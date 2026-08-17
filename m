Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA67314A6F
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 05:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943110; cv=none; b=T6RlTTfkKiKjZXX9Ij0NijKAAx8U2DIFTTF/DZDYZBSmofCGLA1FID8WwkFHu8CspGdRS9V4bmOBddZlS0kJMtlgFxfK85xZaQWYRreM5siKFHXuV7TRSW2u7q9Xb7VyQ9NpStkSspzn1lb2ansjdpRUU32/oWqbTRtzp0dlR1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943110; c=relaxed/simple;
	bh=CawxsgZmGgOhsL47d95lSdlJ7wHo5gn6vQ4SEtLz4fA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/6hRVZ+VDShT0JX9vlfRFxiAqNJeRHk2Qiu8REkGBjjjW6zxtS39yC3ZLTYkVnYH9VcttpmJUXgZJrn+IRSvu/Evsq38cMs6uqG0U8Rx82uBn7QJvClcilDCdIsGnbqvgMolp3XNav4dIZKSxw6htWc5X0PFkR0a8mDdgfoy14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvNgXDMv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvNgXDMv"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84a2dcede83so4091360b3a.3
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 22:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786943107; x=1787547907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2tRymJVpfolTktQlDrFjsDnKawKa4L89cQfWtz9noeM=;
        b=pvNgXDMv05jsN9TRvlVIBfoDLreTVVJR53qBYOKxiMkupZSrdZG1TRvAfiPKutwWMN
         kY9crdi4k6rYb6cF9534TdAe0uQ6dkhBzqqmKzmN6f2386SKI4a5sD37PCOXKvIR/Gb1
         m38GIck28oCt6H/jtG9ga/rnv+uwZcKSlL4J9yMozBZdsVo3Vtoa4hF/fKuVx5mtZl5e
         kPtCjk0ExLcIpBwNY+7XFdn+g3oxmmWk7TPhE3p6kmyMS3+ku8kx/QRC9L+glFdvTd2i
         aX0eCzkfWMxf6kW/NVMCUzCstuDOdS+X9bQ43/ywqvgt/JZV8jQUBKsNYhQ0QhAwOFws
         Urqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786943107; x=1787547907;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2tRymJVpfolTktQlDrFjsDnKawKa4L89cQfWtz9noeM=;
        b=CVhUW6BDKmXRP7lrC0kjBQnqXdo8UIbdIE7B/0cz8g3hPJgtgKaHiT9BjE9ohiKkCm
         XtbfO/S+4G2fAzonyB8wQa8d1vb+lx1/hKcw8h6CfPBomCgSxTsNnl6NODMp3S8L0fEd
         B+6w6k0q3S2XE/6Bhmnj+tySBTF5MDSGMtfe6L0AIfUqFbRmrWV2PgzBWSY5NcD6Xgq9
         42l6c1nHcztE12GiZua3ULsYiq6gMa7iSRSPWjhp2TWDdAPwNeWg2qEr+HIgG6DeW/Lh
         iMegiPxMtwI/06qWllIHEtzKuA6dcATSH62DSBSiPsPgrHA1zXZj6dv9tE8BU6qkiJfg
         8DBg==
X-Gm-Message-State: AOJu0YxZUZtGa5hgaebecaNNaaGFIZMdVUlZ6SjVzdB96exprdVUqLd+
	2Xg8gmI1oWVa0Uq05acdfzSP2PSKVBO7W5ptpYE3jkcoP1QX7G573cB5
X-Gm-Gg: AR+sD11lmGxbZDJCPiXr36j+eMZqcc6KEacDQJHhBLyPOMiCw2phkIguZ3lJvLXCoOs
	y1TmpTnJAqTwHVb4+tUv2S8TTObZNVuJqCd2uzJHrO09y1/RH4e+u8Nbbi13mtFIBZnh0BkoJBU
	Ct1iiYG5Q62eFd5dkBPzpAppitUhvZBxkCbEMK3Vf3M0ScWHb9vT0AbDaU9JCOm6ni8Ey35LYgu
	gEQHM5FQmC3UvY31DWOnc4ZTByyhtwCnbaaKj9ynu3X5JW13yCY54XmMaRc7YQXaZ1TXvnnHYKf
	iAmiJbJENjuZ04NvbA/+dJHZOr9teRLwlGuPIvnekH957I9mnFKWsZXOGqFvACenX4svAUG6R70
	npgmvpoHtJok7N2ZUYVtzIF1GdUy8jc313kqXk3CCI2jPq2SMJ318hqEA0VGZvmTcK1IlHfpp+2
	v3KASmDqq/olIYAGPtCrXATEU0xVGO418Kzao/vqTWXaMMP+eDwoIdrRl20eulr/up
X-Received: by 2002:a05:6a00:a91:b0:847:893f:2d0c with SMTP id d2e1a72fcca58-84fddf924fbmr20940617b3a.5.1786943107383;
        Sun, 16 Aug 2026 22:05:07 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d267310sm2131036b3a.53.2026.08.16.22.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 22:05:06 -0700 (PDT)
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
Subject: [PATCH v7 0/4] dma-buf: fix fd leak when copy_to_user() fails after fd_install()
Date: Mon, 17 Aug 2026 13:04:53 +0800
Message-Id: <20260817050457.1005285-1-shoubaineng@gmail.com>
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
v2: https://lore.kernel.org/dri-devel/20260710105740.3080070-1-shoubaineng@gmail.com/
v3: https://lore.kernel.org/dri-devel/20260714114654.3885457-1-shoubaineng@gmail.com/
v5: https://lore.kernel.org/dri-devel/20260730062645.233148-1-shoubaineng@gmail.com/
v6: https://lore.kernel.org/dri-devel/20260807101140.1357218-1-shoubaineng@gmail.com/

Changes in v7:
 - Add Reviewed-by: T.J. Mercier to patch 4 (selftest).
 - Add Acked-by: Sumit Semwal to the whole series.

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

