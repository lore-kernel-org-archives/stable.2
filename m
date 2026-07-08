Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305A82E7631
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783549341; cv=none; b=OVm6qTRsVMmYxvrQuwRo2HIwmik6gn2aA5l+PPykxCQW9l9jfPMzH/NnBglpheMOTsMlHR1Bu4V9mYVt5HwaIjPMT/lhL6QLh47iPjBSeYKm9hrM+dURfq9LIIfRrjbFIJZs1trAfejsXPJA6/C/tJ9gG9lxmuJxsCYrKm87bPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783549341; c=relaxed/simple;
	bh=EOMuNjF04hdvZYLMZ+gzNe9TBq+t8Fng5OZOcUeoZQQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eLfA6hLvOkYxzYvgzTFxhjf3PhwWkUM4QCjw0FZ4Z1eRX7nkDYKxLcMi+ECQ2tDPstUKmcX4Ft2UkPWlIlmJjrZMJuYYd3VmuXHdk5ykSQBMspcmy0jXUo3A5kWLArLKZ4g0kxbsRR6MEFmos81I5ErmxvOX4vd+9obEXt4YQHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVCwrvkS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVCwrvkS"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cd01a14e81so2651295ad.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 15:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783549340; x=1784154140; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FMn5rOQ8G0MdN/j3eEgjALE6UNgIkquz76Y7IvgCOJ8=;
        b=FVCwrvkSUs/8+Aak7HqVir/5QnXlNUMBMKSTW7bjZrpJZoer6y0XlJQ20Pv5nZl5Fx
         GMRcg/6JeLB+gmh+Vx8IaFXXRnwlC3Xh5GRqbC+LnI5s0sfWu9ROQEMkHnRSj6Vf2KAd
         6+RW2jOlUJpAt5d1jlhGfbQBrykvk8leYjCxM4rDCBfSbZ35ACkrdXpXVqgH1fioBpyF
         u6E13S64oGH2d2VI9Bl44++7OCTq7MCIc2+QOZLPL5OM/U5+xR8E5g0eWyb8qzjCSYS8
         +HBf4EZnPcsv7QzbYLWl56aNB/JTOlDdZjVFvvEoVVrO1A8JzYZZy8y/cFGurGf/Uikz
         IBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783549340; x=1784154140;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FMn5rOQ8G0MdN/j3eEgjALE6UNgIkquz76Y7IvgCOJ8=;
        b=Vq9jV3f1jF76wrKI/ebePgS21rvTbkzIGgEmLiwoNLi3omoa1Wmm9QRgLLj4dSt124
         4shSQuGSbulv4rQu9chFb819gz0+jAlcyNfKFkXEl+iDhw+wSVvA20OJVAlkRJstGGSB
         WzxvXvUPzQAM5Hooas+MmwBnZX3MLNbLVL2Gx2qbnxSAs1pHO5RSzrwTWXZn6gbHlVlo
         UnfRIX/ppu5DNNATjULeFLrhe45zX3jRKBr4qchdI+u/3q+mHuGvznmHmBA2IHbfJYJ3
         ShPhzjGAeQh3iTdeUa3jnfoZ71f8AmkvN4DBfOuknScb4zxtnQ1qtBJA1KRq1YkkUR2v
         yXuA==
X-Forwarded-Encrypted: i=1; AHgh+RrrQZrNlk/6EBMnNpRzrCMo0rx6cayZZbuxZkko/WJ5TYeVzhyh1tEx0bAvA3SFjcfPxKqC3rM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx3BKfJxkUuoNLp1uIsaVVL4tScQErZl/1/hIMpPpTMV9u/oq4
	ZFuoJB33BSSuZUpGgHItgjf8MOhfG3lIZ32MixLwpAshw64owQsu0QPG9NkQfWv4a8O3XDKZttS
	r6RCrguwahBPyDkK5i/DP757+uA==
X-Received: from pldd21.prod.google.com ([2002:a17:902:c195:b0:2c8:4c1:883a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1670:b0:2ca:52ce:6f74 with SMTP id d9443c01a7336-2ccea464790mr52655045ad.29.1783549339459;
 Wed, 08 Jul 2026 15:22:19 -0700 (PDT)
Date: Wed,  8 Jul 2026 15:22:11 -0700
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
Message-ID: <1db8819133a88e03297aea7924878582c28e3dbc.1783549129.git.ackerleytng@google.com>
Subject: [POC PATCH 1/3] Reproducer for false restoration on shared HugeTLB mappings
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

hugetlb_unreserve_pages() unconditionally returns reservations to the subpool
(via hugepage_subpool_put_pages()). This means that regardless of whether a
subpool reservation was actually used, the reservation is processed by the
subpool structure.

To create a false restoration, the reproducer performs these steps:

1.  Mount with min_size=2M (1 page). Global resv_hugepages becomes 1.
2.  The program maps 4MB (2 pages) shared (which also grows the file to
    4MB). Global resv_hugepages becomes 2 (1 from the mount, 1 new global
    reservation).
3.  The program populates only the first page. Global resv_hugepages decrements
    to 1 (reservation consumed by allocation).
4.  The program exits (closing VMAs/fds). For shared mappings, reservations are
    associated with the file inode, so they remain active. Global resv_hugepages
    remains 1.
5.  The script truncates the file to 2MB (truncate -s 2M).
    +   This synchronously triggers hugetlb_unreserve_pages() to release the
        reservation of the truncated range (the unallocated 2nd page).
    +   It calls hugepage_subpool_put_pages(spool, 1).
    +   On Vanilla Kernel (Buggy):
        +   used_hpages is 0 (not tracked).
        +   used_hpages (0) < min_hpages (1) is TRUE.
        +   The subpool incorrectly restores the reservation (spool->rsv_hpages
            becomes 1), even though Page 0 is still allocated and satisfies the
            mount's minimum guarantee.
        +   hugepage_subpool_put_pages() returns 0, skipping
            hugetlb_acct_memory(h, -1).
        +   Result: Global resv_hugepages remains stuck at 1 (Leak).
    +   On Fixed Kernel:
        +   used_hpages is tracked and is initially 2.
        +   hugepage_subpool_put_pages(1) decrements used_hpages to 1.
        +   used_hpages (1) < min_hpages (1) is FALSE.
        +   The subpool does not restore the reservation.
        +   hugepage_subpool_put_pages() returns 1.
        +   hugetlb_acct_memory(h, -1) is called.
        +   Result: Global resv_hugepages decrements to 0 (No leak).

When the filesystem is unmounted, hugetlbfs_put_super drops the subpool
reference. Since the filesystem is being unmounted, the reference count drops to
0, triggering unlock_or_release_subpool.

Inside unlock_or_release_subpool, the kernel checks if the subpool is free using
subpool_is_free.
+ On the buggy kernel, subpool_is_free checks if spool->rsv_hpages is equal to
  spool->min_hpages. Because of the phantom reservation, spool->rsv_hpages was
  restored to 1. Since min_hpages is 1, the check (1 == 1) returns true.
+ Since the subpool is considered free, the kernel releases the initial
  mount-time reservation by calling hugetlb_acct_memory to decrement
  resv_huge_pages by spool->min_hpages (which is 1).
+ This decrement reduces resv_huge_pages from 1 (the leaked state) to 0.

As a result, the leaked reservation is cleaned up during unmount and does not
persist afterward.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 subpool_shared_leak.c  | 29 ++++++++++++++
 subpool_shared_leak.sh | 86 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 subpool_shared_leak.c
 create mode 100755 subpool_shared_leak.sh

diff --git a/subpool_shared_leak.c b/subpool_shared_leak.c
new file mode 100644
index 0000000000000..5811e18d7f8be
--- /dev/null
+++ b/subpool_shared_leak.c
@@ -0,0 +1,29 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#define HPAGE_SIZE (2 * 1024 * 1024)
+
+int main(int argc, char **argv) {
+    if (argc < 2) {
+        fprintf(stderr, "Usage: %s <file_path>\n", argv[0]);
+        return 1;
+    }
+    const char *file_path = argv[1];
+
+    int fd = open(file_path, O_CREAT | O_RDWR, 0666);
+    if (fd < 0) { perror("open"); return 1; }
+
+    void *addr = mmap(NULL, 2 * HPAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+    if (addr == MAP_FAILED) { perror("mmap"); close(fd); return 1; }
+
+    *(volatile char *)addr = 1; // Allocate 1st page only. 2nd page remains unallocated (but reserved).
+
+    munmap(addr, 2 * HPAGE_SIZE);
+    close(fd);
+
+    return 0;
+}
diff --git a/subpool_shared_leak.sh b/subpool_shared_leak.sh
new file mode 100755
index 0000000000000..46c622b18559a
--- /dev/null
+++ b/subpool_shared_leak.sh
@@ -0,0 +1,86 @@
+#!/bin/bash
+
+if [ "$EUID" -ne 0 ]; then
+    echo "Please run as root"
+    exit 1
+fi
+
+MNT_PATH="/tmp/mnt_hugetlb_shared_leak"
+FILE_PATH="$MNT_PATH/test_file"
+
+# Save original values
+orig_nr=$(cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages)
+
+cleanup() {
+    echo "Cleaning up..."
+    rm -f "$FILE_PATH"
+    umount "$MNT_PATH" 2>/dev/null
+    rmdir "$MNT_PATH" 2>/dev/null
+    echo "$orig_nr" > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
+    echo "Cleanup done."
+}
+trap cleanup EXIT
+
+# 1. Set nr_hugepages to 2
+echo 2 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
+
+# 2. Mount hugetlbfs with min_size=2M (1 page)
+mkdir -p "$MNT_PATH"
+if ! mount -t hugetlbfs -o min_size=2M none "$MNT_PATH"; then
+    echo "Failed to mount hugetlbfs"
+    exit 1
+fi
+
+# Check resv_hugepages after mount (should be 1)
+initial_resv=$(cat /sys/kernel/mm/hugepages/hugepages-2048kB/resv_hugepages)
+echo "Initial resv_hugepages (after mount): $initial_resv"
+if [ "$initial_resv" -ne 1 ]; then
+    echo "ERROR: Initial resv_hugepages is not 1!"
+    exit 1
+fi
+
+# Verify reproducer binary exists
+if [ ! -x ./subpool_shared_leak ]; then
+    echo "reproducer binary './subpool_shared_leak' not found or not executable."
+    echo "Please compile it first: gcc -static -o subpool_shared_leak subpool_shared_leak.c"
+    exit 1
+fi
+
+# 3. Run helper to map 4MB, allocate 2MB, and close.
+# This creates 2 reservations, consumes 1 (by allocating Page 0).
+# The unallocated Page 1 reservation remains active in the inode's resv_map.
+echo "Running helper..."
+./subpool_shared_leak "$FILE_PATH"
+
+resv_after_helper=$(cat /sys/kernel/mm/hugepages/hugepages-2048kB/resv_hugepages)
+echo "resv_hugepages after helper (should be 1): $resv_after_helper"
+# Page 0 is allocated (no longer reserved). Page 1 is reserved.
+# So resv_hugepages should be 1.
+if [ "$resv_after_helper" -ne 1 ]; then
+    echo "ERROR: resv_hugepages is not 1 after helper run!"
+    exit 1
+fi
+
+# 4. Truncate file to 2MB (releases Page 1 reservation)
+echo "Truncating file to 2MB (releasing 1 page reservation)..."
+truncate -s 2M "$FILE_PATH"
+
+# Check resv_hugepages after truncate.
+# Since Page 0 is still allocated (and in page cache), and satisfies the
+# min_size=2M guarantee, we should have 0 reservations remaining.
+# If the bug is present, the truncate path will incorrectly restore the
+# reservation to the subpool and skip releasing it globally, leaving
+# resv_hugepages at 1.
+final_resv=$(cat /sys/kernel/mm/hugepages/hugepages-2048kB/resv_hugepages)
+echo "Final resv_hugepages (after 2MB truncate): $final_resv"
+
+if [ "$final_resv" -eq 1 ]; then
+    echo "RESULT: LEAK DETECTED (FAIL)"
+    exit 1
+elif [ "$final_resv" -eq 0 ]; then
+    echo "RESULT: NO LEAK (PASS)"
+    exit 0
+else
+    echo "RESULT: UNEXPECTED STATE ($final_resv)"
+    exit 2
+fi
-- 
2.55.0.795.g602f6c329a-goog

