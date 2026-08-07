Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638A441DEE9
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097548; cv=none; b=dQlIlDnt6QV0uLNeIdmwtWeujelYFmgN8LOwOUCp8Cyfc7h9a+jPJq+zfnkE5VyhPmvb2tb2wg3alSFBC/ejk2EfqvzZ2xGG43yru3SZjwD4V5ztKIE3mUt+DsC6wFy+vz54vEzmWj74VrLDZYY6JGXLMyRKwCsEYKOFVIE4n/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097548; c=relaxed/simple;
	bh=F1UzQeZHsiabgRSoKYgZ6x2SoQv1aOF17+66tpxhGm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Avk3R+OImv84DiEJXBJ4ySABdPE2f9n2Dl/SXduGooIVgHVVt5tHpjqTDKLfAl/9Jop1/EmFUaJMT6N1iGLuvy6hNE52JhuHi/LUUlWatkudy8NDhZF31vhTRjv5GGcGwLRo+vieUZ8Nh7ZgyifjkYnOk0FVJa0FUUKivPACh54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+UAkjmY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+UAkjmY"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84eb992a881so2869412b3a.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097547; x=1786702347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1QPAle4B6UVEoKy/UvltvjtFmYUt6krDcEVyTwixgM=;
        b=R+UAkjmYQVwAFPG/XsDDKTicbg2ber+BJXst4QUEEcglLGxzmaLZ2eh70Ke6b39D8n
         gNTdaRXw0hOTbc227iBaKwE0rt3YGJPj2pMchuFwTJyXiBooqyBuCiSAaSIxokSu7g3D
         ND9NDcZsi2087K4qhwpt4iOa83ns5uvjgIspETrhX/hUrsjSqx0KmTgFSWrWYmf6jwNF
         c4xQQsarmmL2nBp/0G+ALhmfUEhTLKeb5YixerbyXVC93ge0iIiQbyBOgD9/0zhTQcT8
         cFQ5tTqb2Rug+fb2JNyaQueDucVoveEQs+UmBupD2qshTb065ALYnOin/Uo30LUu1s00
         LvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097547; x=1786702347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b1QPAle4B6UVEoKy/UvltvjtFmYUt6krDcEVyTwixgM=;
        b=pepIrvWVhIgD/Et3QiIvMrhyswcJ7mRUXYql5xRKUy7/gXTQSwye4HX7FuTNwJ61lb
         xmTX8ZLyM3zGCRy95sVPyRZsy/C+Rg7ZwB0+G/LRS/m6/lLiFxYXoeAktDqyd5Ej93Uc
         fdjXJ5tH2N4zu4wI4OpsQiK49H3cUkOnBRdZVtqNKkNVtYbfqHm9vSEU3AunsY5T+GXD
         r7AMKOB5X2GXhivlBDwMr72igEc/SrP4fW59EK3f0q0BbFwir9vL6vge7uiXkD/9kdl/
         oc6F5qx6pFLwd+LnSAtDRQXHpxx5UDGyOtG8M2sijpWWXmlplaN6hasR8Xs+hvTpUjNd
         iQ1Q==
X-Gm-Message-State: AOJu0YySEY/+Eqxl0VdE+XwFBuQ0hnKwtgZcbD+1aEvqCLHov0UwX0Cz
	qyL7q3j96UX45gCDqJcX68J+1lc7hhYYlNDZaTYC1qeaY09ZmMD+LvT7
X-Gm-Gg: AR+sD10J+E5hSQPKE13qLxTOhPNok9/J18NrKPLCvzQHWzPYSxlaZUgJTkv6jeG+WMT
	HKx1E8BUkEbxFmB3ODGwuU6uwozwN4i3JUZXElncqoZTf+LtygomcvJPR8Uvq1VfxFojM53P4Cs
	pAMXrO55NzUvUQsXnnU6u5r44FjEJyHLWa+61xCGy0bQCckoR7G3X6NKQEV1EnMdRovxGx2wSlg
	2azRd7xydYCL1vZts7yX9iCJzARN0tws4i9W6CVHAnAio3aYDKOhf1pg5PccPQDnU/KvSDIm6fk
	sNrtt6R7DqjvgzPZ+ez23tJ6nyy31+mkZq5QcKf2tTJqd/zONnMhvb2INfpr04zHUCAR2A3h4nT
	eDcXBB+N6tEsOyK1xnNw9b2KEj4Er85RLzFa+fsVFsy2NUoX6DdN6QaM+sONy0gY56Ua+obGX4m
	aUHsChqH2KYoqOilE/VcX+ycd8iGHa5MRc5PAuSEzG/wuiC+sRzSv/lkfHx8GX735C
X-Received: by 2002:a05:6a00:ba06:b0:84d:ff47:fa53 with SMTP id d2e1a72fcca58-84f4fd9f842mr10114159b3a.2.1786097546501;
        Fri, 07 Aug 2026 03:12:26 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a5528adsm797510b3a.45.2026.08.07.03.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:12:26 -0700 (PDT)
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
Subject: [PATCH v6 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAULT regression test
Date: Fri,  7 Aug 2026 18:11:40 +0800
Message-Id: <20260807101140.1357218-5-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807101140.1357218-1-shoubaineng@gmail.com>
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260807101140.1357218-1-shoubaineng@gmail.com>
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

