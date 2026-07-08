Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CCD3FD152
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783549342; cv=none; b=XbdfyICuQVR+FLbQhg/Oca3yDwsAFnPhdnOTpOcDVIbYGWuo3KQKT+wIz/wHmGRKDwZDSFcSAPgb1262v13vyqpn+v2AQQRjDYSqYbLpFbtMDoueZByX8XPyDgv9IWKKuFXeMvYSlQc1dCx+MsYhf0MRaKU7ePHKrJDk2JDAICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783549342; c=relaxed/simple;
	bh=8zbcBZ/ikA+lS2Z1h138IurVSPyCX8j0diTLH5W7Bnw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uASjN2OO+oMf5uUpQNUHTYx+5je0fVxgRtTSojTCoI0CvisywBlsZ4eg/oIQpg0WaxSvnuv/bHJD0iIYg12VkVwZY0ai2DvQ0TLsqGGBpfP+9jHxcSD6YdiobF6ZycWXw/B7XpV0oC256dMA9sMnpxioAttFP+bh9AAuoAx31mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wed6k+hw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wed6k+hw"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c89956023dbso1759681a12.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 15:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783549340; x=1784154140; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fjLxz+SrWa7Pn13CuDqaEisDU6zq2N+GJpXd2lET7Lg=;
        b=Wed6k+hw5ms/5lzC1crr1xQsu9Guf9guqlT+a4fMAK5JbRvh5KXRcwwkHydlai1zUr
         Iuk3CZHE0Kl4bLcxqHmF2EfNBlJJC1TaF4ttt62zkNHJsqPAHSEG4YCuKau+ApTkn4Lv
         UaCDJzDmcLSTrS6SlM+qayatR+7dc/zHHECipiy1VfMNmS47Axqwvu6LLDJlGv+QNo8w
         Xh9kRkMxRJbeaxkxMYkY9bcr9JrlMnEXeXtotW1apQQyZN0MDRegCFIDbMsvybSsjMoQ
         AkdfoH4qXPp01zi7kZSWsV0SFFmxjCqUJUHO4zScpKILdtnf5kwwo1bAerRhGSLdrkNz
         Rhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783549340; x=1784154140;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fjLxz+SrWa7Pn13CuDqaEisDU6zq2N+GJpXd2lET7Lg=;
        b=Br1nQR+1RnADNyRMTGUGJgWO2c1k1p8n2XOYvdlyiV9B5gpVGONHu0kZ9UFUllDLbT
         V+HCV++466eMwGqed9vcglsROc+7LG26cTHkzKxILUC2i9RjavInTbU52KZt1/STmsGn
         Xe8zL+/A7/mBrAyORI+PRRqc70xgT/v88h1H2bK8atlVzs0HFjfbAork44bh4uyGDJWD
         PyyZXzhwM6XhYUjyR5N7sV8Oz8JsDXGB9sFvN8+/Z1HfkCZnksmn1ebz2JQlGIMKqWtx
         mUmp0k1O3+UKtNlyAQEr6Oy28VGdh3X5U6HSkaduA5LTY5HqExO8TKKVWRaC+ara9iiz
         RPIg==
X-Forwarded-Encrypted: i=1; AHgh+RrookoNr3DUQHIp3PyCs20+P0GD34O/gJTQxjR0Hl/Ssa5G+0tMMnBoP+UlWO2hp7Y0e1HyYKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ogphuP1XKDDY4UvrbhpZLN9mwnciCJMIqmpt+2IHQHw20vGj
	SpaKDaJiRlz+pkWRqpzQtT9X2rafzkFdMsGVLEl9RhAYIdzrxbqpN6/9u29Jt4xGjFQSXzOl7xD
	vAVYRYKKce4pGW0fXwV8QUpE2Dw==
X-Received: from pfbim8.prod.google.com ([2002:a05:6a00:8d88:b0:847:93d8:2813])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:66ca:b0:848:587f:8acc with SMTP id d2e1a72fcca58-848587f902bmr474336b3a.54.1783549340213;
 Wed, 08 Jul 2026 15:22:20 -0700 (PDT)
Date: Wed,  8 Jul 2026 15:22:12 -0700
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
Message-ID: <0b8165bc4558d5bea490eb6fca08398db829438f.1783549129.git.ackerleytng@google.com>
Subject: [POC PATCH 2/3] Reproducer for subpool usage leak
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

The kernel leaks subpool usage and the subpool structure itself if a HugeTLBfs
mount specifying size (which sets max_hpages on the subpool) is created.

subpool_leak_max_size.sh reproduces this with the following steps:

1. Create mount, specifying size=2M (1 page). This sets max_hpages = 1 on the
   subpool, but does not reserve any pages.
2. Set nr_hugepages = 0 and nr_overcommit_hugepages = 0 so that physical
   allocations will fail.
3. Run fallocate -l 2M on a file in the mount.
     + This calls hugetlbfs_fallocate, which attempts to allocate a page by
       calling alloc_hugetlb_folio.
     + alloc_hugetlb_folio calls hugepage_subpool_get_pages to track the
       allocation against the subpool limit. This increments used_hpages to 1.
     + Physical allocation fails because nr_hugepages is 0.
     + Before patch (Buggy):
         + The error path in alloc_hugetlb_folio sees gbl_chg is 1 (indicating
           we tried to allocate a global page) and incorrectly skips calling
           hugepage_subpool_put_pages.
         + fallocate fails and returns to userspace, but the subpool used_hpages
           counter remains leaked at 1.
     + After patch:
         + The error path always calls hugepage_subpool_put_pages if map_chg is
           true, restoring used_hpages to 0.

4. Unmount the filesystem.
     + During unmount, the kernel calls unlock_or_release_subpool to clean up
       the subpool.
     + It checks if the subpool is free using subpool_is_free, which returns
       whether used_hpages is 0.
     + Before patch (Buggy):
         + Since used_hpages leaked and is 1, subpool_is_free returns false.
         + The kernel skips freeing the subpool structure, leaking the
           hugepage_subpool structure in kernel memory.
     + After patch:
         + Since used_hpages is 0, subpool_is_free returns true, and the subpool
           structure is correctly freed.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 subpool_leak_max_size.sh | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100755 subpool_leak_max_size.sh

diff --git a/subpool_leak_max_size.sh b/subpool_leak_max_size.sh
new file mode 100755
index 0000000000000..bfafa1ba074ea
--- /dev/null
+++ b/subpool_leak_max_size.sh
@@ -0,0 +1,71 @@
+#!/bin/bash
+
+if [ "$EUID" -ne 0 ]; then
+    echo "Please run as root"
+    exit 1
+fi
+
+MNT_PATH="/tmp/mnt_hugetlb"
+FILE_PATH="$MNT_PATH/test_file"
+
+# Save original values
+orig_nr=$(cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages)
+orig_overcommit=$(cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_overcommit_hugepages)
+
+cleanup() {
+    echo "Cleaning up..."
+    rm -f "$FILE_PATH"
+    umount "$MNT_PATH" 2>/dev/null
+    rmdir "$MNT_PATH" 2>/dev/null
+    echo "$orig_nr" > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
+    echo "$orig_overcommit" > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_overcommit_hugepages
+    echo "Cleanup done."
+}
+trap cleanup EXIT
+
+# 1. Mount hugetlbfs with size=2M (1 page)
+mkdir -p "$MNT_PATH"
+if ! mount -t hugetlbfs -o size=2M none "$MNT_PATH"; then
+    echo "Failed to mount hugetlbfs"
+    exit 1
+fi
+
+# 2. Set nr_hugepages to 0, overcommit to 0
+echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
+echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_overcommit_hugepages
+
+# Check subpool usage before running
+read total free < <(stat -f -c "%b %f" "$MNT_PATH")
+used_before=$((total - free))
+echo "Before test - Subpool total blocks: $total"
+echo "Before test - Subpool free blocks:  $free"
+echo "Before test - Subpool used blocks:  $used_before"
+if [ "$used_before" -ne 0 ]; then
+    echo "ERROR: Subpool is not clean before test starts!"
+    exit 1
+fi
+
+# Run fallocate (expecting failure)
+echo "Running fallocate (expecting failure)..."
+if fallocate -l 2M "$FILE_PATH" 2>/dev/null; then
+    echo "ERROR: fallocate succeeded but should have failed (nr_hugepages is 0)"
+    exit 1
+fi
+
+# Check subpool usage via statfs
+# %b: Total blocks
+# %f: Free blocks
+read total free < <(stat -f -c "%b %f" "$MNT_PATH")
+used=$((total - free))
+
+echo "Subpool total blocks: $total"
+echo "Subpool free blocks:  $free"
+echo "Subpool used blocks (leaked if > 0): $used"
+
+if [ "$used" -gt 0 ]; then
+    echo "RESULT: LEAK DETECTED (FAIL)"
+    exit 1
+else
+    echo "RESULT: NO LEAK (PASS)"
+    exit 0
+fi
-- 
2.55.0.795.g602f6c329a-goog

