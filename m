Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C343F9F38
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097419; cv=none; b=uAuGqOHG51nzlxjB2sTxXclR2NsMFBW4FcXJtxdkfcNzDP7fGvgMsP455JW/J9KXmcv3Kk+MF3DkrxX9VjOgnP8sGr3DH2KwTUyjX8ChxG4XiL89BvSrCM0LmgvhL3BJbNCU7iUIPPIoHfd0/zMja0PxNtizwXjkFhb/TC55zmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097419; c=relaxed/simple;
	bh=Lh9CRmCJRCXUfNdf9uNGdR9iSpJFMr7nm3Cly0+0f/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNUkf2dtI/rhSKwBqz89L17Gp4ncBMBoDTOgqOSljimQGs4IDsGkmt8nfsnFRh7duPtVrcHENgCqhh+wbZU76AstZTTmNqwFzBJk0SxAcl9GaX4T96yfAmPMSeRVviqzn+A5Cgg2waHSHWQl6IWp04J3osCXOwJyiQLdqzS/7+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDStJmLx; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDStJmLx"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8485ef63b68so4725806b3a.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 03:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097417; x=1786702217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
        b=eDStJmLx9l7r1NTCiXWzauCpJHG+HacCUCkPA2AC6N5px2RlHgG3js0PJaySKKviuP
         SFigkp287QwKLZCuYN7XITo77OYCaB+xq1zbLQpET022/EZwXl0izjn8qs/izEh7bqmq
         qi5AStkzgv6efA5wX8YRJJLo0k/ehMOsk62FoLdVtHZTUewkGl5yxKL7Uurm50LXg6IT
         /NSpNSm65aDPwhkojT9kdctoJGqkmT2a+5GKJd9GuG5Bm4PjcTIIeiPOms2hUeNlBOsm
         9NzWXrxJ3Gd/SMBbHVq9cJlrCP5FzPyyPMaC360N56arGopuJzPLSnmrxoXqkfSTK83Q
         +zQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097417; x=1786702217;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
        b=Zu2Iaw4xOlON9SIXaSiHk1/sWFeaE+mR5A5b7eB1qcodriL7RUceMXV1YFPyWtxc9q
         HEqzMSEVaYqWKaA8bNKC7oj6dw5QOGLHeVnPJ79L3UAoLj+ByLLMU25W2KWsVL7Y1RDK
         If9pGNWZvab3esDbPjteUev17kcLTyaZFRWlZrQK/edG1WJ2zypCBt9dPbotxbLIR4aP
         QyoqFuVCJWYc0PTzF/QUbYaEvoY+jXcPxR0uF00Tu4ycWP1VpUrqrKYXmiorsn6FXhrf
         yzQ4YZZjcE4OMoXIdkSwE7mH+TSKXfe5VUcgsL+jkR6dx8zWbA1X6PsTtfvKiXwielPz
         ZJhQ==
X-Gm-Message-State: AOJu0YwTGAPRPWQ3WotISlC0yujYfcWVt9CSUQeMq18gQB3RscKTLUPQ
	rPFrlY87+4TBG9j9Zwtx8SlF216OK5aacznk7fdC44SlZ3/2NaS30uyG
X-Gm-Gg: AR+sD105OVoqWDX8g8aXtciMfGTV+/64uSU9SWe2qSxMK+GtJo/11bbt2M5I5vLAabl
	IQD0PiVnHWNOcjVlt2MF1Ongu8hWn3cv2TwIdgTmWWv/vkKlZjosq8eSLRkbLkRlU0s4GjwABkC
	xddpbHHGfIliovkKPSnLAkFXhiXOjMLRZsYpQyaQu621K8mUUVa+hPyVY8DyG9ypW6B8/z/Xvfk
	HHfqKjFPbtD9mkDelZJGRecVGxfBsvfB5FAj3e0T4JcWTNcOFmYkqmkykHnnVbnDG7QnHbaQdpY
	H47pcYoEruxttJW1eLhSe4lsD14V6YVWM2a6p08Jv+94nOuMNKU3/O128WtmCUe4djpB1kWC1A0
	5WirkmTDpB6e2UsLIi3G932kvTqUaCWssKSH6ZEPO+CkOBDMXGpr1kFnOeqGa6UsxSqV+Vmah+h
	7cgg1CUZ7P5VJ4AfYgL2aI78udy3dZzXEjQI583iE3FDTjflpImPf3Kjqe1B4OEfQh
X-Received: by 2002:a05:6a00:2d0c:b0:84e:2382:f4f0 with SMTP id d2e1a72fcca58-84f2dfc8ed4mr23153657b3a.4.1786097417043;
        Fri, 07 Aug 2026 03:10:17 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a5528adsm795291b3a.45.2026.08.07.03.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:10:16 -0700 (PDT)
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
Subject: [PATCH v6 0/4] dma-buf: fix fd leak when copy_to_user() fails after fd_install()
Date: Fri,  7 Aug 2026 18:10:02 +0800
Message-Id: <20260807101006.1352561-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Several drivers call dma_buf_fd() — which internally calls fd_install()
— before copy_to_user() returns the fd number to userspace.  If
copy_to_user() fails, the fd is already published in the caller's fd
table but the ioctl returns an error, so userspace never learns the fd
number.  Worse, the window between fd_install() and copy_to_user()
allows other threads to observe and manipulate the fd (dup, close,
SCM_RIGHTS), making any "close it on the failure path" fix unsafe.

The fix is to split the allocation into three steps: reserve an fd with
get_unused_fd_flags() (not yet visible to other threads), do
copy_to_user(), and only then publish the fd with fd_install() via the
new dma_buf_fd_install() helper.  On copy_to_user() failure,
put_unused_fd() + dma_buf_put() cleanly unwind with no user-visible
side effects.

Patch 1 introduces dma_buf_fd_install() in dma-buf.c (wrapping
fd_install() together with the DMA_BUF_TRACE call to preserve export
tracing) and applies the fix to dma-heap.

Patch 2 applies the same fix to fastrpc, which even had a comment
acknowledging the problem could not be fixed before.

Patch 3 replaces the bare fd_install() in drm_gem_prime_handle_to_fd()
with dma_buf_fd_install() to restore tracepoint coverage for DRM PRIME
exports (suggested by Christian König).

Patch 4 adds a selftest to tools/testing/selftests/dmabuf-heaps/ that
reproduces the fd-leak scenario (mprotect flip before the ioctl) and
verifies the fd count is unchanged after a failed ioctl (suggested by
Sumit Semwal).

v1: https://lore.kernel.org/dri-devel/20260703080922.1838362-1-shoubaineng@gmail.com/
v2: https://lore.kernel.org/dri-devel/20260710105430.3059661-1-shoubaineng@gmail.com/
v3: https://lore.kernel.org/dri-devel/20260714114654.3885457-1-shoubaineng@gmail.com/

Changes in v6:
 - Rework the selftest (patch 4) per review: extract a count_open_fds()
   helper, fix the copy_from_user() comment, fail (not skip) when the
   ioctl does not return -1, drop the bogus mprotect-race mention, and
   reword the result message.

Changes in v5:
 - Add selftest (patch 4) reproducing the fd-leak scenario (Sumit Semwal)

Changes in v4:
 - Add patch 3: drm/prime: use dma_buf_fd_install() (Christian König)
 - Add Acked-by: Christian König to patches 1 and 2

Changes in v3:
 - Split into two patches (dma-heap + fastrpc separately)
 - Add dma_buf_fd_install() to preserve trace_dma_buf_fd tracepoint
 - Add fastrpc fix using the new helper (T.J. Mercier)

Baineng Shou (4):
  dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
  misc: fastrpc: don't publish fd before copy_to_user() succeeds
  drm/prime: use dma_buf_fd_install() to preserve export tracing
  selftests: dmabuf-heaps: add fd-leak-on-EFAULT regression test

 drivers/dma-buf/dma-buf.c                     |  20 ++++
 drivers/dma-buf/dma-heap.c                    |  80 ++++++-------
 drivers/gpu/drm/drm_prime.c                   |   2 +-
 drivers/misc/fastrpc.c                        |  16 +--
 include/linux/dma-buf.h                       |   1 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 113 +++++++++++++++++-
 6 files changed, 180 insertions(+), 52 deletions(-)

-- 
2.34.1

