Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4FA422531
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097536; cv=none; b=sdLhoYFPgVUnO9rCqKnzwuiWvFM/d6e1PA9njVeSKpB8Z98ofFgHFCGomLpDKVQP51eL5M+EYhtT0GYL0Uf4x2Wf1/QEUXnknDFWDFfQJk/dmUJWYme2l2KjDJQDtvOqdElU3off1js7LlyLBnPFVjaz2SIV4XQHzSJ4wB6/Q1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097536; c=relaxed/simple;
	bh=2Wi3i4Vjg7+AxOlXMBs+6tkx40vpBZwTeE7t+8e81gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CratnAUDuAW+TZS1Ewi4Tg4fyCU5F0JuBjJ3skKudAJc9GZujuSP2nSaygTkimEfm2naMJxlFnSlOb9tQlLrAwm1wUxzPRP2zpTUc+wfHQYNxljWARu4pOfpTH7gQH5h/wYlKIcQrcrzyUIJ+Cmy+EFv7PwqfyjrZOhGyNhaDQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=puvvLBL7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puvvLBL7"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84830c774a0so3386989b3a.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 03:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097534; x=1786702334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3EaYXPThWNdkG4MwcQhWQJEAKHoDeZpU3BU1Rq69yw8=;
        b=puvvLBL7zbmfgGrJ8iirK48syq6zTRzaACoVhgnLqWomGJRuomlXJhC1CGW50Od4FJ
         TyR8SrHBiHeFmHzyylwWz9V/LMX9I7fexp1sxgRGgPfeAP0DjuhbG0vJj+9R2qiCrz3y
         E5EKU7ue24vQhsG+nRX2l/p0U1WBxkb8F5RozkKcAb6EhOhHXOKRZ2JSPKfI3zPxQ0DM
         kKABw/AC9OJSh5DfYmqU/Gza3o15dq+lbm4sPtM6hINu87pPtnMcHL01SJw8MuUVlafc
         1eHolMs/ySrVXlMsKPZlgGZgc3mRjOyVrV1g/L4XXiPnal6C4LlR/YnN6c+1EED+DR4z
         bSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097534; x=1786702334;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3EaYXPThWNdkG4MwcQhWQJEAKHoDeZpU3BU1Rq69yw8=;
        b=iHN33D4SlMQRcfcHugrdIQZvQnijUABgnGWIAK5k4mCnNpR7hQGCf29PNZFe6VuZFQ
         77NAQRYLDRoFu0prK3D8nVxRmcWRJqtAd1QWeWHVwx+FcXq9rco1wqC8IXt96DkVwCoN
         hIqHGzenCueuem4aDP6Oc1SEsolU4cv9mKM3z0YBMOt8WqlINup/b9s4CdnM6DpU09MF
         tycMV4ftMy/y29N5ShxcFfTNEN3n1MrBgmG9/mwae1vqbJG3CJ/dD9cks6jn0Tj/+w8T
         HEslEWEDcj/5O+k8pW/QhG7fSzYf2g6bJ6BrVSEpHfwQ4GMuJ3IwzrFG1LYPrWFZEFcM
         xNiQ==
X-Gm-Message-State: AOJu0YyRiV/Uelcm0n9LeHurkQi8jO1QZgJyQ2vIJEW784YYvEebzp6J
	dRxVPsqy6wkm8DTP/pTHeJgypvZ7ZV4G+GHbzjJGY3w7xw2VYijBxfDd
X-Gm-Gg: AR+sD13PZ42BwmS8/Xlk16TmnQMfltoG2/DD4kMCfKbGQhH4rbYZBGlqrL2TCu6SV4F
	kjGg5tVorp8zDfoiZ708THigEGEJRRfKk24UO3iRhXqXY59R5aDqxsfRLVv3pPwRMJRB8k7Lq39
	xEZd+NqK/69ztjI/xE9MNV0NhE25TrnK96a0e40thmE0s1qDTRQIggiT46L2taZlgsazyp+IWGt
	B12/KhP68KBqXjS4xSlG20x5szaM8AfAcrcIaaXkFRDVroivhnkkfD9YIVZp0p0HfTuQS3N0H47
	PuaDwThizW9zWxwclIX4VByeeYKG04yvMafUD8ZeHomppmilJgFGeoD8OojbEOXcrDNu43szFr/
	kCQ3LgriyL3LteKAIpX9jl5/BGCPn2Tnz6ErXdkfve8iqZsew2nzERbR7cnEpRzjgESQyALgxVy
	eUDpmf+/aHapTenfAtQreYI3WWfaTA9DnO4lS0cbWJckPtuEnsU5v6/bswkqU2btFTDqT9uHPlq
	Is=
X-Received: by 2002:a05:6a00:2406:b0:845:a435:a2eb with SMTP id d2e1a72fcca58-84f2e094eacmr22879939b3a.31.1786097533847;
        Fri, 07 Aug 2026 03:12:13 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a5528adsm797510b3a.45.2026.08.07.03.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:12:13 -0700 (PDT)
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
Subject: [PATCH v6 2/4] misc: fastrpc: don't publish fd before copy_to_user() succeeds
Date: Fri,  7 Aug 2026 18:11:38 +0800
Message-Id: <20260807101140.1357218-3-shoubaineng@gmail.com>
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

