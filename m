Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E532B13E
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 05:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943120; cv=none; b=MX3UXcyk1TOtTssYMcizybX7JmwSebxkHeQdXaKXQQmigGcUx4fCEAh9CXGGZ1OqT9qpYZ7KUzYzd9jUfo7CYQ+iGuLVQ6hVtBslsxfSsAIgo5r9eoJ5MzYBlX9IjMGvt0ydf6ihMvVW+EQCuVtOF03+X58e5azwXfu7Jqrsl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943120; c=relaxed/simple;
	bh=ErYC+NBUB1uSMVe7dsSUwt3ETggiJBFdGT3p09rSUlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1iqM+XubinXmhJvcRT7fE06luZCdX0UC+RxGa1aj83MJRVcey62KB4laPZToxOX7y0EHD9cejofGMRwNszV0mzJ1QYQz/coMTanPVJD/pZrgfhM9vfwXCNkP5iK9MdZdPCPKpu22G9RpWm2NvjDYjgoCDRIl7JyGbKVE7PRjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2iYdAev; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2iYdAev"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84a652535dcso1683004b3a.3
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 22:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786943118; x=1787547918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wA2XmPl+hovwGxL3ai/U+yA7AWOU/owR4IcUEcMXDYY=;
        b=O2iYdAevYt5f4khFQNgP5bu5iMekzcpaFVoh/eGfulEMTn9UNF+KYNGAj56vk/Xe5J
         uOOqtzH0EO6K7p8vNfUw9vJWjI/iHDdhutTGn/6TjBk1+WPzXKvgDVijfWZZBruDW4tR
         nkMWI+ZGTIV3paoQSx9VO+ExdUsk3Qrq9vn3DnRlS9mrNyNM7ynhOx1ClzwwlaNY90w9
         RB5dg73VoVq7hJs4DkKG2nQMvrHPNYxqdxCe0l6aIcFQNVNgkirANDhegr6HaKDjeaPw
         PGrcJ85cMgQamjtj6dErJWJoJ/339Q8MGelQnQYEvPbEl8D0pDsCaqEpJHsXVXv50CwL
         dB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786943118; x=1787547918;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wA2XmPl+hovwGxL3ai/U+yA7AWOU/owR4IcUEcMXDYY=;
        b=JpYB3HTqkaCWp8NwEC6ZJkZfyhxhJLoUoT5hFpQvDCR7Kj4DrlqTFfXcaKU/DiSjA7
         eV43ktRIhl7IPeWE/m5oHaieP/AxlYYKXPO4bwhDzJDbVgCGg6foUg8fWRPd09CIwVJM
         /A/bArbw+gIaizL4a0i8KRlxfMSNGhKuSSYi5TVJuhi0heXikum3JVT/TIbM5AHh3U75
         M0mizd4WaEq8AoksZ5ott7Qx97KDhYtWsV4dNT2N3fj68beO6z2ak9mhVfRlRDHHKhp4
         MxWS7+UOZW9IgtIITLu4e96fY3ITKbztZzGNlvvt8L8CAKrws59M8MOsW0JblUKuVGmk
         enCw==
X-Gm-Message-State: AOJu0YzU/GUd9wZbF7BDmpurYyLWmzyKRdbC3DshedXNzcxeCsZahX3V
	db3pw/dpUIvANR5mbpDO02gq/H5hAZeiao86y00RzDWhv+igk8IM/Wdc
X-Gm-Gg: AR+sD12yb/bPKS6jAxuKrQ5/pGWiKrvKtz94edQ8Lgc8hbN72EatvFNjmlHAZz8lnJ6
	M6NMgzkf42MbMFhGsK8mqoSOytakoa0S9iXCJLXOy5RqICGFPM6Q3Afp9dFWRVU5cn4UcMn991i
	zhnsPRnVIyOPJvOiXNWSJp7icLaUIA5xE5a3rezVEp0rnItxu5vkCZIQlfiMbVFh90K/aiydOLF
	ufP0+TWcQa6Znu5QJ7qOR0/3glGazlJImU2Nd6ZFzZGDO6BpPsBdk/+ucVs+jriu6ffiLgxZFCW
	7wnxgJ78kDrtFKEtIbbMPhs1nRKCovUhnq4vvwcBEk7VfbtBegtWK+wN1XspOE/Qm2ViclegHyK
	ke8+6Op/beixgOw268dzbDYoo533X9sEgCSUWssbAKfe/n7cqdeVjD5wFOwvdwcN+4kA8BbIjgO
	Z0g3QTIu6d68CokDWN635wnYSjJptlRhbO4PhhAeBLxXxoyx3vPJVCquaorJ+gFZdm
X-Received: by 2002:a05:6a00:94fb:b0:842:5da3:9b89 with SMTP id d2e1a72fcca58-84fde3e397cmr21923062b3a.38.1786943118310;
        Sun, 16 Aug 2026 22:05:18 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d267310sm2131036b3a.53.2026.08.16.22.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 22:05:18 -0700 (PDT)
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
Subject: [PATCH v7 2/4] misc: fastrpc: don't publish fd before copy_to_user() succeeds
Date: Mon, 17 Aug 2026 13:04:55 +0800
Message-Id: <20260817050457.1005285-3-shoubaineng@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fastrpc_ioctl_alloc_dmabuf() calls dma_buf_fd() which installs the fd
into the caller's fd table before copy_to_user() copies the fd number
back to userspace.  If copy_to_user() fails, the fd is already visible
to other threads in the same process but the ioctl returns -EFAULT.
The existing comment in the code even acknowledges the problem:

  "The usercopy failed, but we can't do much about it, as dma_buf_fd()
   already called fd_install()..."

Now that dma_buf_fd_install() is available (introduced to fix the same
issue in dma-heap), apply the same pattern here: reserve the fd with
get_unused_fd_flags(), attempt copy_to_user(), and only on success call
dma_buf_fd_install() to publish it atomically with the tracepoint.  On
copy_to_user() failure, put_unused_fd() and dma_buf_put() cleanly
unwind without any user-visible side effects.

Fixes: 6cffd79504ce ("misc: fastrpc: Add support for dmabuf exporter")
Cc: stable@vger.kernel.org
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 drivers/misc/fastrpc.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f3a49384586d..c5143cd25767 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1709,24 +1709,20 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 		return err;
 	}
 
-	bp.fd = dma_buf_fd(buf->dmabuf, O_ACCMODE);
+	bp.fd = get_unused_fd_flags(O_ACCMODE);
 	if (bp.fd < 0) {
 		dma_buf_put(buf->dmabuf);
-		return -EINVAL;
+		return bp.fd;
 	}
 
 	if (copy_to_user(argp, &bp, sizeof(bp))) {
-		/*
-		 * The usercopy failed, but we can't do much about it, as
-		 * dma_buf_fd() already called fd_install() and made the
-		 * file descriptor accessible for the current process. It
-		 * might already be closed and dmabuf no longer valid when
-		 * we reach this point. Therefore "leak" the fd and rely on
-		 * the process exit path to do any required cleanup.
-		 */
+		put_unused_fd(bp.fd);
+		dma_buf_put(buf->dmabuf);
 		return -EFAULT;
 	}
 
+	dma_buf_fd_install(buf->dmabuf, bp.fd);
+
 	return 0;
 }
 
-- 
2.34.1

