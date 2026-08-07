Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A641A4F1
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097399; cv=none; b=Z12z0l/eu+Pu7wC8SxTkQTtkD2BlkoNv9hYVi7naGA6SBphzLurBce5Vq40TqmpnfuoNR7kHYd8Skv+5qvLHAyWFcG6ruzdQP65YVKQna7ufYk9enFfUOZZmKZQFMVAAEBcIPN0IPGW4+hULSo+Tbyr+HknAermagj7o5dCeloQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097399; c=relaxed/simple;
	bh=Lh9CRmCJRCXUfNdf9uNGdR9iSpJFMr7nm3Cly0+0f/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2Yeb60iIkKzf6fdu7bSN+jDAoo7PGhWzSvkj8vzSNlY037SbWDva+LV4qU4TBbNaA8dcPB1mdI+K4iNZe9Y95BIfYriBXH/Qbikqj3/rYDj68UY70Iv857Ar4VZPJvG7cqME05uMUGyI3HlRPIlnYW76MJuTO3BhrjqB3ieoIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryyqhbCN; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryyqhbCN"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so2296886a91.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 03:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097397; x=1786702197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
        b=ryyqhbCN27qKVoEeqMgJB9MEDkAxYHQbs1tB1JckFH+RUhT0jbEcJXxnnWBJp0h/go
         nAQi4W9aUTM+/hZ57vkLtykYA9Fl2915NYy4M/a4SWR0LImu6P5NvbIskt9q41glT18v
         chU2P7fr+LFVsYF9EuSmVHFVak0Nd/Zot8OSS69pS4DH3Nl0bMSPiGbdUhoD0wmVVRrt
         l5+47B0J3iTQG1ioDeplElR01abjCFCS/AHrBR6T5l+ViyUhCeFFIdQaG8o///fy2EH/
         HcCO5PTkhZ6bmJkHSE++tq1jfjPCoDR/lg1W2cOSLZwW14ZpedQOzaB0lWJG/kI256m8
         Sw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097397; x=1786702197;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
        b=ZcUiarZowFpkbtjWs3/fwRDjFRbq0ElRwobcaNb7GT82JP1RID1Jxa8YBp26/T+din
         LPrcBJlA6kK/KE1ct7nHsbAhA9a0iNAGxeFHz2iGX1AE9lBThLHHllxuBMfKMYEccn2j
         zfAtvcWsHeMBvPdQKoCgnJDNqzfFLq7yEMYweTPQYwtTzMvUDloD0SHvU8BEZgeQrkkT
         wFz84yy9vTSpGjcfQd8Giof9NncQhod9yw6XydVmcXdajzHecOgvnszXXZZAJVrYcgbt
         vnNP+5rpFxQFdBhRPyKf+eEDdKfoU/BBTbtlcqRZU+iGJWNsWkTn19xArIyXbCWQeWQr
         BSJQ==
X-Gm-Message-State: AOJu0Yxe86bTDrpJ8s7NhcYArnR+xQXu7AWkC8kxGsgNVDWdzDWJCqFr
	fcllQID7qzEBWJE+jxYTPPP/f5L8f5QhyK3fRdKaEExwdfSl0CfAoD+u
X-Gm-Gg: AR+sD11mO6mrZ2Fu9sF+gG047Lcl6QLsFnxGNUvhw7PcTWJPuZqyZ4p3vxTGmsw/TFi
	YKaEfmyFEknu9DaXo+L87eAhwECIUQDdIbhlNOyxFk1LlB+j0LsEivrnPnfb8Sg2iZDm1TYCotG
	iNiOgccfF23Bwy2IFGOVHHi9CAwrey7/FUOrNtq05N/ywRHoYyY9Bb7bxfpvLeiqZ3cq7/367jS
	Dgpfmj+hL7IS8uqLIiWoqF1X0zPi2BUJZevBMVzE/QNerl5DMvnJW2IM3uox3a7V57Q1+hrT2+B
	dbHljwSX3kafZFDMw0NReQlAEKzJt5laE8rJXJZsNG4Y/QcUCr9N9mFI+qAyHvB6RT+v7CRwGrV
	xfqtXlSadQr1P7mTx9eEyaRng3/+37oRhYbxL5YliLzWRC+FcfLcd8HVe8YdGDAEzDamosXp8p9
	paOHNSXYJQ2tnHNvwNZoif2rhkn35yzl2afhrd/+YApU8NSUXPTkBgmZ4T1O7XpDoSjngq5WQBR
	IE=
X-Received: by 2002:a17:90b:224e:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-3903c5c443dmr18527888a91.16.1786097397142;
        Fri, 07 Aug 2026 03:09:57 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de8ddcsm4363444a91.6.2026.08.07.03.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:09:56 -0700 (PDT)
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
Date: Fri,  7 Aug 2026 18:09:37 +0800
Message-Id: <20260807100941.1351356-1-shoubaineng@gmail.com>
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

