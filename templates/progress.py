import time


def long_running_task():
    time.sleep(0.2)


total = 200
for i in range(total):
    message = f"Processed: {i + 1}/{total} ({(i + 1) / total:.0%})"
    print(f"\r{message}", end="")
    long_running_task()
print()
