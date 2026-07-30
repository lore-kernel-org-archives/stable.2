Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962613B6360
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785392877; cv=none; b=hZvL33SAqSqFxUrDUhwjgzx5E0Le/5R62uhfDi9ahYBZBUddykWRCYqXH9tJXLw6X7xoOuq9+caMT4wHRXak1fUkrzCFm7HWBhasjdB+zt2CD5RJc5oU+zMvHB2OI8U5+w1MQAgRQaebpWcvQpUaJ/CMdyo/SuIUXkP6SZPDtIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785392877; c=relaxed/simple;
	bh=4aOFiUN49DqRnWzStOzqLHjicLdnGVpCcmtd6aNH6+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OoMcakBT3iRUox0VTnheLMlaefI/7wbQpwlrJY5Oy4fU+FeuBtJZTh6qMy5d3HXxdJUYHKabNy74SfzmZ4YGDjBhPEMcxUZGuAKjM+5RQ3OS3sedRbOe6a0oDN49ycf3TZYumVCz92VVeYv7kv6CXWhyMVhunlGgWQ0toOP9iFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+hoALua; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+hoALua"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8486672f03cso1935977b3a.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 23:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785392870; x=1785997670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ax7tbNUValSVYnoO1zdiSGKC5h5YwguB1K37baEZiC0=;
        b=G+hoALuaqKHiO+0xgsvctlaWlLe3Hxv4LmHQFaYDH1ut1IKKXhHbpcPfv4mfVv+jkX
         MFyIwurm5yb2qYWdiDR4HX1zj0qm4N7pw773mihNdr2GAX6VZTwRLxk0EdGhIXVyBr6y
         OGrpxGrJgqk3zOd9FNCHYxJm3cQsNGfWaoxnRClE7975JM5pH9FoHsaetkapANMl3rf5
         OiUdmHFs4NubL1BWvmC4pQy8N0Yp732Rnu7wHlhqtw2QvN50z702fXjDo4DRHTLrp/51
         xGzwEl6z/mBnrl0AH6Co/56fFv+RKnQqTyXoT1ywnr7qZR+IFi70xicTY6l+6KhZkMy1
         1wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785392870; x=1785997670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ax7tbNUValSVYnoO1zdiSGKC5h5YwguB1K37baEZiC0=;
        b=lrFHUPPTj25PMAp2KXhwqC0jNzHY1PopxfiKb2StbPed3mph7r/hu0qvrZk5l+xEsz
         qpbj4Y8dh4iANYpFqRdXsmMZMiUyDczYEw0bAw9JC/aaYej1ZUHr0XEmHeuvKQAETui3
         0JvhSx+4RsfT90vOJxyZCUBuWp8Wua0x3pbHeQbsp2vTkASaZrd/lQlLivfTqiQ5Jky2
         YKfxSdnSkUmFmfHRzgoCCgspaOeOSHt2yKUUiDx+MZmoyB1SU879QP55BqyKqp1NG/+W
         en7X921ERLoQJPzN8YgA07Q2LPr1lojbkLx8PPDudNMAh5gTlhvn1SyUzHlxWhCx2l4t
         ZACw==
X-Gm-Message-State: AOJu0YyhLZtDyygHp69rnJ7zieu20wBFB+i7bD6i5d687jRjnjqiosms
	FofXVB7oBFcqcpFbJ9MgAoW650DdX7ApdZbgIUq+OezIPOIoouogklGGeVpLmx1G
X-Gm-Gg: AR+sD11xAaK8FRr28qzsUYf1txojvWpTKubmu6GdlyIeMmGLiD+gn6aAeo+U0WkHB/P
	vT7HwLnLUGdCyCMDfEno4lCxIa219ad2vR/YvPJiCl6dv1OFwuP5GJZpbeNuRF1scm/omoW8N95
	2An0qiL9ZaL0PWZBTE3tTXd2uiR0sJKo/WRB8cve2iqMzORmsu4QXXIIJ+7vR1nOrG3WEIjMHuC
	RnJh2kpTQlGZOVN/UDtHJw1jVTgckVwzo/Hoh+LQNYdaHdy5khKl54jRaL8ni0mUVPjaPIAKi2z
	3KusuBQ5MOKegKAFrJiqm95tunuqoWRQI9xGnK5ZvqMJx5knOnOmzDeEpTehCEna5vSAymAIRH9
	ZnHkY/9uESkn0JZ9dU3smnz1S5SWZdF7cN40N1SjPI+u3NpKq0DatFIpoITQMEgkoo2XpOvQ1+Z
	NQuVBTMRNUOaMAmSkw+vZPZ5DnGgqJuByfrjGK2ahRTYbnWaTDY5J+SZLSCXkgf2mw
X-Received: by 2002:a05:6a00:2d04:b0:848:2f7a:2e57 with SMTP id d2e1a72fcca58-84ebc4475aamr1325657b3a.70.1785392869924;
        Wed, 29 Jul 2026 23:27:49 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea00507b0sm2503229b3a.14.2026.07.29.23.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:27:49 -0700 (PDT)
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
Subject: [PATCH v5 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAULT regression test
Date: Thu, 30 Jul 2026 14:26:45 +0800
Message-Id: <20260730062645.233148-5-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730062645.233148-1-shoubaineng@gmail.com>
References: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
 <20260730062645.233148-1-shoubaineng@gmail.com>
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
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 115 +++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index fc9694fc4e89..bd58e5b06c8b 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -390,6 +390,118 @@ static void test_alloc_errors(char *heap_name)
 	close(heap_fd);
 }
 
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
+ * We trigger the failure by placing the ioctl argument in a page,
+ * flipping it to PROT_READ between copy_from_user and copy_to_user,
+ * and counting open file descriptors before and after.
+ */
+static void test_alloc_no_fd_leak_on_efault(char *heap_name)
+{
+	int heap_fd = -1;
+	int fd_before, fd_after;
+	int ret;
+	long page_size;
+	struct dma_heap_allocation_data *req;
+
+	ksft_print_msg("Testing no fd leak when copy_to_user() fails:\n");
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
+	/* Count open fds before the ioctl */
+	fd_before = 0;
+	{
+		DIR *d = opendir("/proc/self/fd");
+		struct dirent *de;
+
+		if (!d) {
+			ksft_test_result_fail("opendir /proc/self/fd: %s\n",
+					      strerror(errno));
+			munmap(req, page_size);
+			goto out;
+		}
+		while ((de = readdir(d)))
+			if (de->d_name[0] != '.')
+				fd_before++;
+		closedir(d);
+		/* subtract the fd opened by opendir itself */
+	}
+
+	/*
+	 * Make the page read-only: copy_from_user() in the kernel will
+	 * still succeed (it already ran), but copy_to_user() that writes
+	 * the fd number back will fault.
+	 */
+	mprotect(req, page_size, PROT_READ);
+
+	ret = ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, req);
+
+	/* Re-allow writes so munmap can clean up */
+	mprotect(req, page_size, PROT_READ | PROT_WRITE);
+	munmap(req, page_size);
+
+	if (ret != -1 || errno != EFAULT) {
+		/*
+		 * If the ioctl didn't fail with EFAULT, either the kernel
+		 * handled it differently or mprotect raced.  Skip rather
+		 * than giving a false pass/fail.
+		 */
+		ksft_test_result_skip(
+			"ioctl did not return EFAULT (ret=%d errno=%d), skipping\n",
+			ret, errno);
+		goto out;
+	}
+
+	/* Count open fds after the failed ioctl */
+	fd_after = 0;
+	{
+		DIR *d = opendir("/proc/self/fd");
+		struct dirent *de;
+
+		if (!d) {
+			ksft_test_result_fail("opendir /proc/self/fd: %s\n",
+					      strerror(errno));
+			goto out;
+		}
+		while ((de = readdir(d)))
+			if (de->d_name[0] != '.')
+				fd_after++;
+		closedir(d);
+	}
+
+	ksft_test_result(fd_before == fd_after,
+			 "no fd leak on EFAULT: before=%d after=%d\n",
+			 fd_before, fd_after);
+out:
+	close(heap_fd);
+}
+
 static int numer_of_heaps(void)
 {
 	DIR *d = opendir(DEVPATH);
@@ -420,7 +532,7 @@ int main(void)
 		return KSFT_SKIP;
 	}
 
-	ksft_set_plan(11 * numer_of_heaps());
+	ksft_set_plan(12 * numer_of_heaps());
 
 	while ((dir = readdir(d))) {
 		if (!strncmp(dir->d_name, ".", 2))
@@ -435,6 +547,7 @@ int main(void)
 		test_alloc_zeroed(dir->d_name, ONE_MEG);
 		test_alloc_compat(dir->d_name);
 		test_alloc_errors(dir->d_name);
+		test_alloc_no_fd_leak_on_efault(dir->d_name);
 	}
 	closedir(d);
 
-- 
2.34.1

