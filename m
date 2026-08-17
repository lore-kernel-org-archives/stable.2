Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926BA3246ED
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 05:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943130; cv=none; b=WiNDPYaltkRQYpCRjwUebqHAJvmutxyEm2GSwQiyZYrjQHhUhImwnZMm5CJeiDKokR4uasLJcEuhevvc514N/lhBdxBfGldwrfEYQQWl0UqbIOThCww9UCUAB3sSfG6QxUTVq5egIb/wIIGmR2RZD91uk13Fu1/1L/Wiy6gUVtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943130; c=relaxed/simple;
	bh=75OpRWLkQ/Xc518yrBO/o+kJMGpZhe1F2xhM+Ifk9Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZR4eoSJwaGegVUEiU7LUPCNUvYGGq8jTkdiuoRyb95H4oJ9MQVhHMJbAEi+dfbMH+MxP/nNj2SiUYoGZD9afeQ4nrNP35AT3xICpeB4mN/F1L5SCvD+ZQ1LM9RrgNZZcfXFTd4d9zrWSM9/rFcBYVfVx28dhYL4o7vK1oogXTtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qz4k9VEJ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qz4k9VEJ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso1842081a12.1
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 22:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786943128; x=1787547928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ziVl5gmafK8z7JTYijjTnWVXlXKGtu8Xos512S76WIk=;
        b=qz4k9VEJPi7zbcrAfEsUrme08mFIqGYO+trxS30HF7DR/HMNtqn8ELA8gUlfy7t4kk
         A2RyMTWcLEPy9Lmg0GNga8nNjHRYCUDkzutLSfLQTa3dAnx7gkOUYUAxSTkIncUew/5E
         QH2l34t+J2F8vbkQ2ZXzmd22BG2vHQIVhsZ88FWneWjHhR14PI0fGQKVqQ8e1wwSucYW
         rcGUQ3cBJVxZjLOxAAp6SEyyBcLmPvVntIGX8X672IoDJmHirMyYf4Tm5JDlYw+tEaFL
         SBByfA5m3Anb9BNtqKcs2wKwgkZ00qJ2znZFWw4o5bhgl25TRWvwyUUB2K5WW3+JF8xr
         0Vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786943128; x=1787547928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ziVl5gmafK8z7JTYijjTnWVXlXKGtu8Xos512S76WIk=;
        b=jVkmsSBPavA2Hsa/4sVLPM6jRnndzxG80dM77zTpPF3taEvfa8w0TORRQX4kU213Sn
         hGetOdXFOvfeJP9WdIPGarLRwxib2uflW5a46816fpkSxvb3yQo9cy3iFf2EFLYXat8s
         CoFaTP52Q9YEfJeuB9SXZTXBco/vVYLHMomenDPalGZ8mhJaDgvo8pQZ/YSxxXzFLj4Z
         nCpqTqzBXdkJIIEiaP5lZvHXKs+TrjB0+Mfo1ZUYyEbMdgLzHVSQxyv8RussKX7Ykc4q
         AZMig0YkXyaVRULLrU9f304FBbERdvptswKxFpIDNQwdhnNG2VjvAhSaUol/OR4vYtID
         KVtw==
X-Gm-Message-State: AOJu0YwSpqjuV8gVWw4FD0DvsIyRoYHjRfNO13ibmA4DTIRxs1FVjw7Y
	NpQ/6vIF+ePD4uq+vzxMgRX04NAO3dS/+5rlGW4QeGVYfaZbV5VL5o3e
X-Gm-Gg: AR+sD10d/DfEx+2RxDHvC97bl3IwtaBFn1VpAkn9TaJczcl8O2l/p6bxD8Bm06REVSV
	cJ8BurrUGbRhrg3gTeK5m3Sl7H7q1YogLZ2hpmwDF6mNbE4U8RetlfhOaST5ICNGr0BR9Z3PxRh
	B/53SkYuJ5BvEegSgIuZpf21FovVPzr30Ha69qMRlJThmqgzJF52pZPWm+B//975oo+h2y6c4Az
	WI7OI9RiSdWI96USCki/wUxQ5OW2r2JVjDYsc/ks4Wk7CFfLReyjj5qjfI8X5s9pJ/xkGnyY9dy
	LUnn/E4OTfeoeoeGIhYEq4TQLbJ8WXP4wyAXu/riQ2KQov8vzYox+kYPVMm20Iq5dc2bXnLuNtU
	g8EZy8UAsHZDgD8wJG8hW5ipxHt3MD9SLj/h3b4ZNK6JKtvLPTJCNGjeGxbwUSYv1VKomQpdmO4
	ftIozWOv8/MuwLD9z7zSJ+enID27Trh7ZZ3bFB6aQfv5oj1R26MCSnDWGGuKAY3yUH
X-Received: by 2002:a05:6a00:1f03:b0:846:bc81:3e29 with SMTP id d2e1a72fcca58-84fde365255mr23307379b3a.2.1786943127867;
        Sun, 16 Aug 2026 22:05:27 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d267310sm2131036b3a.53.2026.08.16.22.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 22:05:27 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	Sandeep Patil <sspatil@android.com>,
	"Andrew F . Davis" <afd@ti.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH v7 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAULT regression test
Date: Mon, 17 Aug 2026 13:04:57 +0800
Message-Id: <20260817050457.1005285-5-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817050457.1005285-1-shoubaineng@gmail.com>
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260817050457.1005285-1-shoubaineng@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case that verifies no file descriptor is leaked when
DMA_HEAP_IOCTL_ALLOC succeeds internally but copy_to_user() fails
to deliver the fd number back to userspace.

The failure is triggered by placing the ioctl argument in a private
anonymous page and flipping it to PROT_READ (via mprotect) between
the kernel's copy_from_user() and copy_to_user() calls.  With the
buggy kernel the ioctl returns -EFAULT but leaves an extra open fd
in the process's fd table; with the fixed kernel the fd count is
unchanged.

This serves as a regression test for:
  "dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds"

Suggested-by: Sumit Semwal <sumit.semwal@linaro.org>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 113 +++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index fc9694fc4e89..1d49df671919 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -390,6 +390,116 @@ static void test_alloc_errors(char *heap_name)
 	close(heap_fd);
 }
 
+/*
+ * count_open_fds - return the number of open file descriptors.
+ *
+ * The fd opened by opendir() itself is counted, but since it is opened
+ * and closed within each call, it cancels out when comparing two counts.
+ * Returns -1 on error.
+ */
+static int count_open_fds(void)
+{
+	DIR *d = opendir("/proc/self/fd");
+	struct dirent *de;
+	int count = 0;
+
+	if (!d)
+		return -1;
+
+	while ((de = readdir(d)))
+		if (de->d_name[0] != '.')
+			count++;
+	closedir(d);
+	return count;
+}
+
+/*
+ * test_alloc_no_fd_leak_on_efault - verify no fd is leaked when
+ * copy_to_user() fails during DMA_HEAP_IOCTL_ALLOC.
+ *
+ * The bug: dma_buf_fd() called fd_install() before copy_to_user().
+ * If copy_to_user() then failed (e.g. via mprotect), the fd was
+ * silently installed in the fd table but never returned to userspace.
+ *
+ * The fix: reserve the fd with get_unused_fd_flags() first, attempt
+ * copy_to_user(), and only call fd_install() on success.
+ *
+ * We trigger the failure by placing the ioctl argument in a private
+ * anonymous page and flipping it to PROT_READ before the ioctl.
+ * Inside the kernel, copy_from_user() reads from the page (reads are
+ * allowed under PROT_READ, so it succeeds), but copy_to_user() that
+ * writes the fd number back faults, returning -EFAULT.  We then
+ * count open file descriptors before and after; with the bug an extra
+ * fd is left in the table.
+ */
+static void test_alloc_no_fd_leak_on_efault(char *heap_name)
+{
+	int heap_fd = -1;
+	int fd_before, fd_after;
+	int ret;
+	long page_size;
+	struct dma_heap_allocation_data *req;
+
+	ksft_print_msg("Testing fd leak when copy_to_user() fails:\n");
+
+	heap_fd = dmabuf_heap_open(heap_name);
+
+	page_size = sysconf(_SC_PAGESIZE);
+
+	/*
+	 * Place the ioctl argument in its own private anonymous page so
+	 * we can flip its protection independently.
+	 */
+	req = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (req == MAP_FAILED) {
+		ksft_test_result_fail("mmap failed: %s\n", strerror(errno));
+		goto out;
+	}
+
+	memset(req, 0, sizeof(*req));
+	req->len      = page_size;
+	req->fd_flags = O_RDWR | O_CLOEXEC;
+
+	fd_before = count_open_fds();
+	if (fd_before < 0) {
+		ksft_test_result_fail("count_open_fds: %s\n", strerror(errno));
+		munmap(req, page_size);
+		goto out;
+	}
+
+	/*
+	 * Make the page read-only so copy_to_user() will fault.  The
+	 * ioctl must fail with -1; if it returns success the test setup
+	 * is broken (mprotect is synchronous, so there is no race).
+	 */
+	mprotect(req, page_size, PROT_READ);
+
+	ret = ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, req);
+
+	/* Re-allow writes so munmap can clean up */
+	mprotect(req, page_size, PROT_READ | PROT_WRITE);
+	munmap(req, page_size);
+
+	if (ret != -1) {
+		ksft_test_result_fail("ioctl returned %d, expected -1 EFAULT\n",
+				      ret);
+		goto out;
+	}
+
+	fd_after = count_open_fds();
+	if (fd_after < 0) {
+		ksft_test_result_fail("count_open_fds: %s\n", strerror(errno));
+		goto out;
+	}
+
+	ksft_test_result(fd_before == fd_after,
+			 "fd leak on EFAULT: before=%d after=%d\n",
+			 fd_before, fd_after);
+out:
+	close(heap_fd);
+}
+
 static int numer_of_heaps(void)
 {
 	DIR *d = opendir(DEVPATH);
@@ -420,7 +530,7 @@ int main(void)
 		return KSFT_SKIP;
 	}
 
-	ksft_set_plan(11 * numer_of_heaps());
+	ksft_set_plan(12 * numer_of_heaps());
 
 	while ((dir = readdir(d))) {
 		if (!strncmp(dir->d_name, ".", 2))
@@ -435,6 +545,7 @@ int main(void)
 		test_alloc_zeroed(dir->d_name, ONE_MEG);
 		test_alloc_compat(dir->d_name);
 		test_alloc_errors(dir->d_name);
+		test_alloc_no_fd_leak_on_efault(dir->d_name);
 	}
 	closedir(d);
 
-- 
2.34.1

