Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AA735B137
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066174; cv=none; b=dDw/riiWcD2eZaHkMeTeMrDFPzklMjOsBx2b2vZJXYmWVIivmmoA+q+osNFQOhqIa6tSgjMYNamsniSsMG8rryfBExuB1tVnF70hPClpDApyXgYmnAK9t3xtQIwvHQaSAUTKZs/zITd9A0fKM+lmL/JxVJgKVEajXABUYsOvZhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066174; c=relaxed/simple;
	bh=CSYuelwBEgbOsTqPxA/RNruqEGmC7llHkPEnmOQMDNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t5Cd4SneNmpdhLilywLvDsQzp7QputaLzm3uvCsNJFZudMMctiHPqPY+GplcnuDORO1wgV8igDhcKJv/MC52P+C4Yznl+I7GwRmu51oJGkYSxfWVyFuFShpGKwrPU8GBIMxhwI3bDJgx96G42WPjQrPi8N3LEq4c7f1Fxm8ZGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz7bKLxt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz7bKLxt"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3804e42ad5fso332911a91.2
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 01:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783066172; x=1783670972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w87AnrTB3+K5h4mEbRFEu3fZorqFSIFJ3pSg+bs+2hw=;
        b=gz7bKLxtjD6wzsMtzaXuvzZEpzJzvQhH+mrf6cEjNTF1S3tox+ChiQmN8MptMVLssm
         lS9y0LIQX3oqziBHlwK0AeiVe8FU1M++x6TQaWLnUnQDEOdeXP3dpcTWeAQef6A675VM
         zIV5Gg18ANh7+t+delRsgFypGHyITARitdrvUOCHDJJov4DgfgoHkAAyg5qotdZ9id8Q
         A15uU26KWyQ4rbD7ygcHCTi2F0BlSmwBiNVYFbB+M7AFKw/6B/j3NxanAySX6xhtEmrm
         ay3zVfnTceOrwiQJ8mGXgUnISEq4cDKNBxOTusLoo4ZojHszJTEldH3Eb3RnzBgz96D8
         Z16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783066172; x=1783670972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w87AnrTB3+K5h4mEbRFEu3fZorqFSIFJ3pSg+bs+2hw=;
        b=HW5I84eAe3VzvK3fRikA+dkLrf52TfM7y3lY+4BBM/Md3ImWCF7yHHxQTYwiQ/n8Dj
         sxcgeW87IRA8qbJJ5Z1hcUJLAXdXTVR3ZniXqjN57yDRolkHQDivSf4njP5qF2L9UPpK
         wnj2wiiYX2R39PH1t0esr9KmUcXzT3d1h0SdXXR8DnyAHGwymGDNIFF8UmsNR80hF7mv
         FAPX1DbzTyu4k5WdSfTjEsKYXhmJowvWhF81njdudHJa2mTjXWtTQqPz7x4GnIW0qM4Q
         FU/mw/4G9E0XKXAPcC2rWPDu2gqUIQRVFI8B5Sknv8MeMHArGT5EbzicjLGYv2R4+Yvm
         ZOeg==
X-Forwarded-Encrypted: i=1; AHgh+Ror9loSxBjHJWhKriAEr2OpaPAKq/u91FJW83A/NQEfK8MRh0RHoKyx1P6JN6FBLGPXEP25SX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4vr171TvMI58qP6xoPsn11R/KFdgvlE/9UKCl0gUO4PueuIzi
	UitNoZhHcwLtNN9X8z8mYx13+mS6gFTPBPJou9XdUtRVWGAJah927C5t
X-Gm-Gg: AfdE7cnTbK+X+8D/ltWCLsw6eMQ6hR9J/W0um85/xeJfcC29360oZK+dLXkdaFPHRM+
	E82SzXU0hAcLLcP3LSyRA96CZkMZEGxJQOuP2FV0qH4Q+oxPSMb/CSedcQk3fPODTdTS+j+1bG7
	Ulcaza4M1aEBqLl2bvfPHKDb0+e+TrovZBm+dZc/Dic87o4C6njvIVBcUUJXXw6QgzRfIRDsBBg
	HOWdrKa/fw9rCAyGGkp+BnqcqJ/m3A8Mt+VqCaoNLmtN7IIcope8o1hvabNCj1SxcunWIqDCM94
	sq78Y/tXaQQ4qFCn/q4CxRf4UU0w1gfmAw5+H2z0A4fGCHuZPUWDIQ4ZSaZ3Cj7Vcw0QWu7nITu
	90uBC6suLuvMyKB+F3PCjMQLMDJB1oRnx0wwO/2y6ri+l4Uem0lane1NBlTQgTkTaPPwqPWnuyu
	/86SvSd4ClR369a4hp4YU8l5o5RBDxbRrerCcqqhwRCvpzw2viHmrgIA==
X-Received: by 2002:a17:90b:1d8d:b0:381:20b:a9ee with SMTP id 98e67ed59e1d1-381020baa35mr4976082a91.14.1783066171845;
        Fri, 03 Jul 2026 01:09:31 -0700 (PDT)
Received: from localhost.localdomain ([45.67.201.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127ae18f7sm614923a91.3.2026.07.03.01.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 01:09:31 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sandeep Patil <sspatil@android.com>,
	"Andrew F. Davis" <afd@ti.com>
Cc: Baineng Shou <shoubaineng@gmail.com>,
	stable@vger.kernel.org,
	linux-media@vger.kernel.org (open list:DMA-BUF HEAPS FRAMEWORK),
	dri-devel@lists.freedesktop.org (open list:DMA-BUF HEAPS FRAMEWORK),
	linaro-mm-sig@lists.linaro.org (moderated list:DMA-BUF HEAPS FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dma-buf: dma-heap: close installed fd when copy_to_user() fails
Date: Fri,  3 Jul 2026 16:09:22 +0800
Message-Id: <20260703080922.1838362-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DMA_HEAP_IOCTL_ALLOC allocates a dma-buf and installs an fd into the
caller's fd table via fd_install() before dma_heap_ioctl() copies the
result back to userspace. If the trailing copy_to_user() fails, the
ioctl returns -EFAULT and userspace never learns the fd number, but
the fd (and the underlying dma-buf reference) remain in the caller's
fd table and are leaked for the lifetime of the process.

The failure is easily reachable from userspace: pass a struct
dma_heap_allocation_data that lives in a page whose protection is
flipped to PROT_READ between copy_from_user() and copy_to_user()
(e.g. via mprotect()). Each such ioctl leaks one dmabuf fd; repeating
the call quickly fills /proc/<pid>/fd with anonymous "/dmabuf:"
entries that only go away when the process exits.

Fix it by closing the installed fd (and clearing the fd field of the
kernel-side copy) when copy_to_user() fails after a successful
allocation, so the error path matches what userspace observes: no fd
was returned, therefore no fd is left behind.

Fixes: c02a81fba74f ("dma-buf: Add dma-buf heaps framework")
Cc: stable@vger.kernel.org
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---

Reproducer (full source, gcc -o poc poc.c; run as root):

    // poc.c -- leak one dma-buf fd per DMA_HEAP_IOCTL_ALLOC
    //          when copy_to_user() fails
    #include <fcntl.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <unistd.h>
    #include <sys/ioctl.h>
    #include <sys/mman.h>
    #include <linux/dma-heap.h>

    int main(int argc, char **argv)
    {
        int n = argc > 1 ? atoi(argv[1]) : 100;
        long ps = sysconf(_SC_PAGESIZE);

        int heap = open("/dev/dma_heap/system", O_RDWR | O_CLOEXEC);
        if (heap < 0)
            return perror("open"), 1;

        for (int i = 0; i < n; i++) {
            /* Put a valid request in a page, then make the page
             * read-only: copy_from_user() still succeeds and the
             * dma-buf is allocated and fd_install()'d, but the
             * trailing copy_to_user() fails and the fd, never
             * returned to us, is leaked.
             */
            struct dma_heap_allocation_data *req =
                mmap(NULL, ps, PROT_READ | PROT_WRITE,
                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

            memset(req, 0, sizeof(*req));
            req->len = ps;
            req->fd_flags = O_RDWR | O_CLOEXEC;

            mprotect(req, ps, PROT_READ);
            ioctl(heap, DMA_HEAP_IOCTL_ALLOC, req);  /* -EFAULT */
            munmap(req, ps);
        }

        printf("done: check ls -l /proc/%d/fd for %d leaked fds\n",
               getpid(), n);
        pause();
        return 0;
    }

Before the fix, ./poc 10 leaves 10 anonymous dmabuf fds in the
caller's fd table:

    # ls -l /proc/$(pgrep poc)/fd
    lrwx------ 1 root root 64 Jan  1 00:03 3 -> /dev/dma_heap/system
    lrwx------ 1 root root 64 Jan  1 00:03 4 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 5 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 6 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 7 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 8 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 9 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 10 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 11 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 12 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 13 -> /dmabuf:

After the fix, only /dev/dma_heap/system remains open; the
anonymous "/dmabuf:" entries are gone.

 drivers/dma-buf/dma-heap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index a76bf3f8b071..0dd7a84b06bf 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>
 #include <linux/xarray.h>
 #include <uapi/linux/dma-heap.h>
+#include <linux/fdtable.h>
 
 #define DEVNAME "dma_heap"
 
@@ -181,8 +182,16 @@ static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
 		goto err;
 	}
 
-	if (copy_to_user((void __user *)arg, kdata, out_size) != 0)
+	if (copy_to_user((void __user *)arg, kdata, out_size) != 0) {
+		if (kcmd == DMA_HEAP_IOCTL_ALLOC && ret == 0) {
+			struct dma_heap_allocation_data *h = (void *)kdata;
+
+			close_fd(h->fd);
+			h->fd = -1;
+		}
 		ret = -EFAULT;
+	}
+
 err:
 	if (kdata != stack_kdata)
 		kfree(kdata);
-- 
2.34.1

