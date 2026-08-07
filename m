Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F141835E
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097456; cv=none; b=nZlPf8JwkWl69pi/c+ORv4Cdb5YHq8cEGeBCKdVQFxdptFK8c4GVsPAhaORurPDB9DGuFXgX8R0Huq+zs33ah1hq/SHJqQacO2qwDXFAh/5DExbjO99bGevRgSOZzGw6keLjevRCw8l6WZzQVoXltGI3Y6w4eU5HexHN+psBHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097456; c=relaxed/simple;
	bh=Lh9CRmCJRCXUfNdf9uNGdR9iSpJFMr7nm3Cly0+0f/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mikpeP97kiqufrcQFLNMDs/9DO/egReMHXgVQnjUDJNZ5rTG2TQl/fImIEzAYJcwEVJvpu+WnMSPtd0L4AcrI3NR+2kcr9x3eOlwyI5P60AwrA2hPvScCgnoksR+YJp8vUyrF0FYx9Jx5hhXvkMY8hC17Z+FYpDt/nK95305g5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLg3Plvd; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLg3Plvd"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso2480045a12.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097454; x=1786702254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
        b=FLg3PlvdhUPtM3Yyoup4/pv5mIPNcmUl4ozWRmpoeA2ltpAZVUz8pKhUkW2mSWBNf1
         a7KCpVLitzhS/3pD9fd3JRHWvzERMHX02BaUbsaDbm8luHSFUL96abqmT1XK2rB7a9qL
         +Nczqh8lK5Hra0kX1VoNxhLQ/14ptEn4kUYibwRzGxZFvvfxK5c1nId13MflJJ2sKg7z
         eC8B9KOrz5Rl40JvyhaqlzFaRSAbWjkPbPzN/7N+8ZJFqCZoQE3s+c/JKPofo3Vp7gS+
         ZCv3rL24zOF9Are28JMS1YJiTMVTOS/7rREYM7zAdBOJ9YtdVyLN8aMUjHZTgJDweYkj
         iTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097454; x=1786702254;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
        b=jvQHoLuPTWu7cOtkVTHhGCKpATOHOTQ4ayIHLqey+1TFa2YY76IYurYeLxLUgID8Kd
         JovMjVzeoMpHNNUUBAGTnv6E4A8+sl+GYQ0cci0w6Jd0psjAk9ZuuW99bZSDtfc2S9hf
         60VAu1IWp9iwRAl3oSzWtEMZ9JwVnzrvg8aT15kD2ehJ+ZTjkiELgTpTS7bnsg8OosZl
         e6zHu7t+h25D0FtlUIJ54iJ+NiVypqPSZd8/o4uX6nYBNq8GwqW+EhOKHH7e9Uzgp1f1
         Du9n1p3ghv8GcEP9YQLyQWrMnlvCb9kh5rrtZZjSWx8S/FPsLVvuzXV2gqy4ekvQxSsC
         GiYA==
X-Gm-Message-State: AOJu0YzJcznP1iLsa7JNi/LY6UJ3d4RrKdazkhhnYrKdJmwxipJZ7diH
	g0EGNt2y0F6QOy3qYLAuGDlNHfC/JYd9oIsZP/sA1jj88slW0TVk59JH
X-Gm-Gg: AR+sD13uJTZZzz3ttv5Q+Mk8Z9PRMGGTX16mfNfYG30izN6vV2rd19LTkebDIiSoWJe
	kOP8Ih3OukER/fkmV79QfG/UBPGdv2LoZLsRDfl5CisDI8gkyD7FC6SVgu0W8IzEisw8QhMCwHT
	r8XPuYSrlgcrbH4erJVkwU7c3rQwkWTE/yTRNfzGw2u+l7BZEKDkcYXTDfiVJHivn8UeupP0NsK
	s5inC2P5yiRIkKEk0UV889KgoqP+7PkD3Sfbxkk3AYdLZB3hjhJvN7OtH+Em+XkO1QaOmhjRjwk
	9e20q6t8Ok557YCMDjznasy9xZ9VTgatkZWn8aDJc7c56yPY3EetDR1tazohnDeOo5+afOHEiM/
	hvBX4ZQnx5gpj+mi6xpOxSlsn9+fraVboRJdMAMCo9bUTjK5LXIWrj0+zAnuK4EFKJmiCv1Qezt
	vMbI6JynQwM8aMBwZlmrd+wtBN/lUUzCF+S6aJvE/odQ7FfD2N6oBQ9Vjily46poZfAc2zRk5uc
	5k=
X-Received: by 2002:a05:6a00:8084:b0:842:6a3b:60d8 with SMTP id d2e1a72fcca58-84f2e072867mr25591073b3a.30.1786097453818;
        Fri, 07 Aug 2026 03:10:53 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51e9f0sm790953b3a.28.2026.08.07.03.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:10:53 -0700 (PDT)
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
Date: Fri,  7 Aug 2026 18:10:37 +0800
Message-Id: <20260807101041.1354250-1-shoubaineng@gmail.com>
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

