Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CD23FE35D
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783549343; cv=none; b=kBspecaoHgNIfXJNjxQj01B60s5h9g8/TWYAH9FFHmbM2VY/4S9PiNqbATAd6E6Kz68QzykSp7Bw0VMC7ADVkAvM0f6nL+QpSvaOf47wJK5MkWrOkJwOS0RcDJDM9sA3H210G9eRSwaPyovod7pIdGIj2T6FFvwYto1c1CMd9FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783549343; c=relaxed/simple;
	bh=OWZNdt/msw1cs9NmTrXei0B1emw1QU53uVXCW2J8f8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uI4Ev/KDgaOaF1B4kepVuWVgU6H8OmsjkML4uPmwl8K/OXVYYvqaJP5377IKyxEM3JLzdPuUgA9sw7VTZtUE39kFQQpXoxsvplcMAv6JYNLchaeDWDlDhHggW84D1yqsozezN66T+afOqZtc/K7wrx5N+Agup4NNJ04qQVeLO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uByKXTfD; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uByKXTfD"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8478d2bea7cso199744b3a.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 15:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783549341; x=1784154141; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ez2sGXr0ImIl6qeGIDRJYiog01DgnPS7oVjoUBzVAs4=;
        b=uByKXTfDfrgLxE+NsidZVd6kG4NQ1Uh+oOO8pMx2TKGBSDhd7UZlgFv3UenusakRM4
         V3lOEix4Imn35X+9W/1dooC5f4asLC1/IM8RwGw4h9+HOVYFg+xt3SAhzp+A6lPn41u3
         f7g5FbvJm/5dHZ1qwAMIjuitXr8BxfkZSaJPs9mlSzv5O8WK03O/vvJQl8qB1AJe8uCJ
         NXMaGzrEytxfoXaT5FfR6Eo35bBT5jltQxCFkJ3NwMRmTj8+A+ylg4+w8rl0WzzYS9Qz
         Y5Qa16OJmkYZrXN4gZfblM0uZgXzGmegxuvTx8boe1MWzrkpn3to0yYJ5pxbnWZykzOk
         YZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783549341; x=1784154141;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ez2sGXr0ImIl6qeGIDRJYiog01DgnPS7oVjoUBzVAs4=;
        b=pZcU+SYaCHrDT1Vj6BLLrG6Qkg18YIqP9qdT8ShF+PKBRBP8jbum4CjeSjRhdGjC2G
         FIAi2UcaUf1nyeUVD1LlRBPOKrFZwabNZ4E0cV7jFErIlSvaSzRdsquTncVFl2TBO93g
         y0cwduZXSlSeRBzdHynI1z9eMxpL5U5jANQIMvy+ouqYq97PQXZhVNB2KwOHSlEoBL28
         CRy7fA3rqHIjSMVhNuROWx8sDD17tTCq7YrBKw2AxchxjlzTAwc7m2EgPsLKlfrI1jt0
         gJ2VsOERM2w3ez2y3F6sFmAduljxbov0obLgltAD7QEwQGm+fkE5Ou2034Vr6Po8GEQX
         YzGQ==
X-Forwarded-Encrypted: i=1; AHgh+RrUHAqBNMzIhuuH/gFGC0lYLPNWbqpEasMsR1BBXI1B3Ticx7JNiW7XiWBfehuwPHXyC+ztpPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4PTwB+EGW+aI0kXYAnbwwS147XmwW8UK242wZ5o3mvGQuSaHE
	82Do7XdGjlzh7VEDeWWU+ZWZN/jVqZ6sBZGzouPzfCWQ8c/33K5z6SdihXTx1PrRl8729sOzE+T
	XB0aXIPG8iqw4h59cwTDVYv8bJA==
X-Received: from pfbna42.prod.google.com ([2002:a05:6a00:3e2a:b0:848:4809:51c6])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e28:b0:847:8791:f54f with SMTP id d2e1a72fcca58-8485ab7c6d2mr193415b3a.29.1783549341021;
 Wed, 08 Jul 2026 15:22:21 -0700 (PDT)
Date: Wed,  8 Jul 2026 15:22:13 -0700
In-Reply-To: <cover.1783549129.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b@google.com>
 <cover.1783549129.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <946c52b1d2bf058d8a61128a1490cbeab56b20a6.1783549129.git.ackerleytng@google.com>
Subject: [POC PATCH 3/3] Reproducer for allocation failure due to cgroup v2
 memory limits
From: Ackerley Tng <ackerleytng@google.com>
To: devnull+ackerleytng.google.com@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, david@kernel.org, 
	erdemaktas@google.com, fvdl@google.com, joshua.hahnjy@gmail.com, 
	jthoughton@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mawupeng1@huawei.com, muchun.song@linux.dev, nphamcs@gmail.com, 
	osalvador@suse.de, peterx@redhat.com, rientjes@google.com, 
	shakeel.butt@linux.dev, stable@vger.kernel.org, vannapurve@google.com
Content-Type: text/plain; charset="UTF-8"

(This reproducer was hacked up and not meant to be merged.)

cgroup_v2_allocation_failure.c triggers HugeTLB allocation failure by exploiting
cgroup v2 memory limits. This allows testing the error paths in the kernel when
memory control charging fails, even when physical huge pages are available.

The program performs the following steps to trigger the failure:

1. Enable hugetlb accounting in cgroup v2.
     + The program checks if memory_hugetlb_accounting is enabled in the cgroup2
       mount options. If not, it remounts /sys/fs/cgroup with this option
       enabled. This ensures that HugeTLB allocations are charged against the
       cgroup memory limits.

2. Create a test cgroup and set limits.
     + The program creates a new cgroup subdirectory named test_reproducer under
       /sys/fs/cgroup.
     + It sets the memory.max limit of this cgroup to 1MB (which is less than
       the 2MB huge page size).

3. Fork a child process and move it to the test cgroup.
     + The program forks a child process.
     + The child process moves itself into the test_reproducer cgroup by writing
       its PID (using 0 for current process) to cgroup.procs in the test cgroup
       directory.

4. Attempt to allocate and touch a 2MB huge page.
     + The child process maps a 2MB anonymous huge page using mmap with
       MAP_PRIVATE, MAP_ANONYMOUS, and MAP_HUGETLB.
     + The child process writes to the mapped address, triggering a page fault.

5. Triggering the kernel bugs.
     + The page fault handler calls alloc_hugetlb_folio to allocate the huge
       page.
     + The allocation of the physical page from buddy allocator succeeds
       (assuming nr_hugepages is sufficient).
     + The kernel then attempts to charge this allocation to the child process's
       cgroup by calling mem_cgroup_charge_hugetlb.
     + Since the child's cgroup memory limit is 1MB and the page is 2MB, the
       charge fails and mem_cgroup_charge_hugetlb returns -ENOMEM.
     + This triggers the error path in alloc_hugetlb_folio where the bugs (folio
       refcount mismatch, infinite loop on ENOMEM, and reservation leaks) are
       handled.
---
 cgroup_v2_allocation_failure.c | 160 +++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 cgroup_v2_allocation_failure.c

diff --git a/cgroup_v2_allocation_failure.c b/cgroup_v2_allocation_failure.c
new file mode 100644
index 0000000000000..938cbf02ae6f7
--- /dev/null
+++ b/cgroup_v2_allocation_failure.c
@@ -0,0 +1,160 @@
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <string.h>
+#include <errno.h>
+
+#define CGROUP_PATH "/sys/fs/cgroup"
+#define TEST_CGROUP "test_reproducer"
+#define TEST_CGROUP_PATH CGROUP_PATH "/" TEST_CGROUP
+
+void write_file(const char *path, const char *val) {
+    int fd = open(path, O_WRONLY);
+    if (fd < 0) {
+        fprintf(stderr, "Failed to open %s: %s\n", path, strerror(errno));
+        exit(1);
+    }
+    if (write(fd, val, strlen(val)) < 0) {
+        fprintf(stderr, "Failed to write %s to %s: %s\n", val, path, strerror(errno));
+        close(fd);
+        exit(1);
+    }
+    close(fd);
+}
+
+int is_hugetlb_accounting_enabled() {
+    FILE *fp = fopen("/proc/mounts", "r");
+    if (!fp) {
+        perror("fopen /proc/mounts");
+        return -1;
+    }
+
+    char line[1024];
+    int enabled = 0;
+    while (fgets(line, sizeof(line), fp)) {
+        char spec[256], file[256], type[256], opts[512];
+        if (sscanf(line, "%255s %255s %255s %511s", spec, file, type, opts) == 4) {
+            if (strcmp(file, CGROUP_PATH) == 0 && strcmp(type, "cgroup2") == 0) {
+                if (strstr(opts, "memory_hugetlb_accounting") != NULL) {
+                    enabled = 1;
+                }
+                break;
+            }
+        }
+    }
+    fclose(fp);
+    return enabled;
+}
+
+int enable_hugetlb_accounting() {
+    printf("Attempting to remount cgroup2 with memory_hugetlb_accounting...\n");
+    int ret = system("mount -o remount,memory_hugetlb_accounting " CGROUP_PATH);
+    if (ret != 0) {
+        fprintf(stderr, "Failed to remount: system() returned %d\n", ret);
+        return -1;
+    }
+    return 0;
+}
+
+int main() {
+    struct stat st;
+    if (stat(CGROUP_PATH, &st) != 0 || !S_ISDIR(st.st_mode)) {
+        fprintf(stderr, "cgroup v2 not mounted at %s\n", CGROUP_PATH);
+        return 1;
+    }
+
+    int enabled = is_hugetlb_accounting_enabled();
+    if (enabled < 0) {
+        return 1;
+    }
+    if (!enabled) {
+        if (enable_hugetlb_accounting() != 0) {
+            fprintf(stderr, "Could not enable memory_hugetlb_accounting\n");
+            return 1;
+        }
+        // Re-check
+        enabled = is_hugetlb_accounting_enabled();
+        if (enabled <= 0) {
+            fprintf(stderr, "Failed to enable memory_hugetlb_accounting (re-check failed)\n");
+            return 1;
+        }
+        printf("Successfully enabled memory_hugetlb_accounting\n");
+    } else {
+        printf("memory_hugetlb_accounting is already enabled\n");
+    }
+
+    // Enable memory controller in subtree
+    int fd = open(CGROUP_PATH "/cgroup.subtree_control", O_WRONLY);
+    if (fd >= 0) {
+        if (write(fd, "+memory", 7) < 0) {
+            // Might fail if already enabled or not supported, ignore for now
+        }
+        close(fd);
+    }
+
+    if (mkdir(TEST_CGROUP_PATH, 0755) != 0) {
+        if (errno != EEXIST) {
+            perror("mkdir test_reproducer");
+            return 1;
+        }
+    }
+
+    // Set memory limit to 1MB (less than 2MB hugepage)
+    write_file(TEST_CGROUP_PATH "/memory.max", "1M");
+
+    pid_t pid = fork();
+    if (pid < 0) {
+        perror("fork");
+        return 1;
+    }
+
+    if (pid == 0) {
+        // Child
+        // Move to cgroup
+        write_file(TEST_CGROUP_PATH "/cgroup.procs", "0");
+
+        printf("Child: Attempting to allocate and touch 2MB hugepage...\n");
+        // Allocate 2MB hugepage
+        size_t size = 2 * 1024 * 1024;
+        void *addr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+                          MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+        if (addr == MAP_FAILED) {
+            perror("Child: mmap MAP_HUGETLB");
+            exit(1);
+        }
+
+        printf("Child: mmap succeeded at %p, touching it now (should trigger fault)...\n", addr);
+        // This should trigger the fault and call alloc_hugetlb_folio -> mem_cgroup_charge_hugetlb
+        // which should fail and trigger the bug.
+        *(volatile char *)addr = 1;
+
+        printf("Child: Successfully touched page (bug not triggered?).\n");
+        munmap(addr, size);
+        exit(0);
+    }
+
+    // Parent
+    int status;
+    waitpid(pid, &status, 0);
+
+    printf("Parent: Child exited. Cleaning up.\n");
+    rmdir(TEST_CGROUP_PATH);
+
+    if (WIFSIGNALED(status)) {
+        printf("Parent: Child killed by signal %d (%s)\n",
+               WTERMSIG(status), strsignal(WTERMSIG(status)));
+        if (WTERMSIG(status) == SIGBUS) {
+            printf("Parent: Child got SIGBUS as expected (if kernel didn't crash).\n");
+        }
+    } else if (WIFEXITED(status)) {
+        printf("Parent: Child exited with status %d\n", WEXITSTATUS(status));
+    }
+
+    return 0;
+}
-- 
2.55.0.795.g602f6c329a-goog

