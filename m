Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192273AE194
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785392832; cv=none; b=j4s+gbz/29HNvb/WazUzXxQZ7QHF8PogKip5nIOREJurNYKgS/C48clHicSDmaQAnUyAjtS1cRpFr3UFEuh6Np5ugIaJWvx2ejpTZFVQLOTpqAje6gsAmoxAi13g8dhoTk3W4UJilHrvGTSdNeG8A4s1F4NxuXlKe6du28zQmWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785392832; c=relaxed/simple;
	bh=F9WeV/nxAP6fHlwe0aqZ4cby4GCtvCwnHIr/wOKq+vA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFTfu1CVboJMbvP0LfmNXRQ6rrGuPQEThJpzV+KxcIk2kDrsB/g/dDxBO4rZ9+q2K9cyLWGyaBBqaXu1MTEdxD5xcCTgo7Lubv1IjksJSo378UOq7M9QC5WtVYwTx1+PEte/jL37U8FsCHKPjQi8nP1owEnuMr0EFbxB/1WP/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1w0edeF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1w0edeF"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-848761b5897so1083398b3a.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785392830; x=1785997630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lC5eDEn/dzL9Eec299VWkBRGUg0dXbB9NQvY7s3O+kI=;
        b=S1w0edeFDpRDZQ3BaEigFHNvpdsf35Ha8TgPZVWhLdqlnnHO/1sDKYCL1KlZMvGEHi
         cbO3z5cDvuHlVBxVc9NEoK++OU9tzePta2Bx/CtBtYpk461p9WMpW8B4vRlARHoEv3M1
         zc1vYvDSpYGxw+4OC12FIWXIjHFSJA0GH5vORS191ZGN/gXz6C4Jyug3m2nvwafA0niR
         eRGhLqpcODTPSGCSLnNL6ISgsIgl4Bu57OyBhs/pae17bzPIzxMA8xObK93ogLhaRQr9
         kTnsgzNhuZbPXli8qCqKO7/xw2ArOnLYkcBWfONNNzywEjhZJ/WQMm9VipoQIkMXkhjS
         LVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785392830; x=1785997630;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lC5eDEn/dzL9Eec299VWkBRGUg0dXbB9NQvY7s3O+kI=;
        b=lb13SckbtZHa8PzvEhSo4t0k4m25IFFj9TqU80/TCRc8yuxpvkjTnbPQAFs7aEqk+k
         XIUp1dPNrVcKn73khPZoyzMBXfcalU1xrX95ukUE1WuCUFuAuimqi8MkwrdQLtkPy4Yn
         dg5BjBkTG5M1WsJ40XfOHctlBKsMx7XOaQRhl905fELvyv1zdppFBOCi7i+vyafQ/RiH
         W20eDCl+NGuLPtjqm6eHtZvoQBFARhILaEZptLPNssRWe+y/yZ2x/HMVGloMhj1ZiD7U
         VWUNcI8HCf/kdjOpnkK0xQ3t33iLwQ6PorVbscQBGeoZ7i9pLgmJpZ3gYtCgfJBG5r6b
         3Vyg==
X-Gm-Message-State: AOJu0YxHv4xeQmM4/7DF+b63/mYSB6gRTlqR1Xqw0Fk94eYKoNumhMHv
	whVH6N7PokTOKmkNVrs3FfhBZ0h4hBXDibM1iiLsz/Ui/JoSVA9kQE/F
X-Gm-Gg: AR+sD11BYEmg78XD64tEr5ciVhAbLinMkgnrF/qwUuVXKVabrD+nfK4vWHtOBfXbopM
	z+quyADv7ZcXmdPtxShPlJWkz37e+0b/uLeur4y2VmpHddZBemt78V1gZdwNE0YFgvDO7Y1u0J6
	clNPBiy41110ayV2dEbK8TG8p7Ew5/Ors3Erehp7slim9usQfC9JefEtwh1bIZrvSNmyN6xVOki
	DAlLKYogyl6RiSNUtuSevG7J9Fq2XokD2Kb5MI2Z3xjKgjNN/JP47iZrSZi9MdYq0uoRqhxhvF8
	ssS9vhDV/LO86gwgzF4xapfcqPW9Qi0aJiism/cEOfE1Dk0Mu0RHR7uJ929DqRmYWaH6hYbzvk/
	dqPlnMzk6sgJ7cM+hXdvBxboa+c9ujkiJjku9xCLbDNGp4/VyMqV6+dG3BzWJMZ3//skCPfnE+d
	vMK4cCtMWJTlCn5ettGiJw3GSzELJV4+g2/3aHzWtO5Lw8l9s8NZNEiL0eDkImwO+4WYvWJoXM5
	Es=
X-Received: by 2002:a05:6a00:b44:b0:845:e8f3:bdd0 with SMTP id d2e1a72fcca58-84ebc2623b1mr1371121b3a.33.1785392821527;
        Wed, 29 Jul 2026 23:27:01 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea00507b0sm2503229b3a.14.2026.07.29.23.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:27:01 -0700 (PDT)
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
Subject: [PATCH v5 0/4] dma-buf: fix fd leak when copy_to_user() fails after fd_install()
Date: Thu, 30 Jul 2026 14:26:41 +0800
Message-Id: <20260730062645.233148-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
References: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
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
reproduces the fd-leak scenario (mprotect flip between copy_from_user
and copy_to_user) and verifies the fd count is unchanged after a failed
ioctl (suggested by Sumit Semwal).

v1: https://lore.kernel.org/dri-devel/20260703080922.1838362-1-shoubaineng@gmail.com/
v2: https://lore.kernel.org/dri-devel/20260710105430.3059661-1-shoubaineng@gmail.com/
v3: https://lore.kernel.org/dri-devel/20260714114654.3885457-1-shoubaineng@gmail.com/
v4: https://lore.kernel.org/dri-devel/20260714114654.3885457-1-shoubaineng@gmail.com/

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

 drivers/dma-buf/dma-buf.c                     |  20 +++
 drivers/dma-buf/dma-heap.c                    |  80 ++++++------
 drivers/gpu/drm/drm_prime.c                   |   2 +-
 drivers/misc/fastrpc.c                        |  16 +--
 include/linux/dma-buf.h                       |   1 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 115 +++++++++++++++++-
 6 files changed, 182 insertions(+), 52 deletions(-)

-- 
2.34.1

