Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D17C41DDF3
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097514; cv=none; b=K26UNX1qtisCbkN8qBiFrcnt+qSFRYF6JnS8k4Fj5tMp3o2phdsonVnErrm+nrQNq9ToHlNbULKNh95cxhuEZG3+MAhGOP6hHtWZkSa4N5nStGH+K7fRjRm2sf2UZVQq3HYBA4jHXLJ5vF8Byh9CrRdvHmnHfbtS6vAAWXrgsOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097514; c=relaxed/simple;
	bh=Lh9CRmCJRCXUfNdf9uNGdR9iSpJFMr7nm3Cly0+0f/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvwlnTRoOOWn33tQ4MUAygkvdB6noTFgKREr651mluFyx2BYbq3nhMq49yVZ+rfC4jqsrt3u3gQrOcoZHds4o8vNiiW3ZY7wo9O89UEgDw/FHu9cGmNyH94oGnV+tYPf4ePjX0TsFnW0xdFbX69qge+Ese1W+0Dtr3XHqEVHH+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoXy8lH3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoXy8lH3"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485ef63b68so4727480b3a.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 03:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097512; x=1786702312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
        b=VoXy8lH359lnFjeT0As/fNGG0GqQLH0x2AVeKHLFPZTPPa6LVbBuu4RhbtqYTM4oUn
         Qb+RnaIplme2GT/JmftDDCqsBKmFRPvB+yvkLjjgD0+vcRHq4t+j522IHgBvgdxPibC8
         kLtYLrHhsAlxslOaCZTiuJRZX7yzmm51ElUjaSRGxMszhJ0i7o3deppY/arwWSfL62fJ
         xC2EYbnpGwC2uoRaLjTjrqeOoJo9nfgEEbvumjN9I1OGWA/OT8z592cmu1zdi/Be5VMf
         fwRgBEybTLsImT6kq5yU1mImNm9stv+omIJMrzlTMt+xBp+iH8VQiCW4Q6b4ym8GqltR
         //Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097512; x=1786702312;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
        b=pCnCxfTNYez08n2l0daQm/42xpJhpePpiOe+rSysx8GWR/0w1deLCeAJb0TFh6O3fQ
         LWdZAy9eQ3tKcEg+BHrrqc4chHmdtxwFQumY4Cf58yA9FJLs2w+vtjrb3AYP11FXOgST
         2i2pTtAmgduUnOmQXRaslPPtcJqoWg8Gc0SVGhbGt4ZW7w0+btRqZpz5ojn/IHslzTjy
         fii/wrmuonh5V33NArbHlHVEgFpFjTfQXrqwlbflvX8Qo67x54sKlObCVFv1tOUR3DMk
         smi54jBIespKiNlbNRPaWs61D1HBSI1YjOJ/S5LGqLTZt1C9WgQyKjoOKCqcKc8TyMK7
         YaXg==
X-Gm-Message-State: AOJu0YzowIrqgtxrqTr9yQe98N8hYzVI0xUQ9WMQTX6IkkiNYkDUdQmI
	5ql5gP8rMfzSo07zCpdPI5n0r2tyVag3utMLWiJ1cXZ2p+j6X12qLlev
X-Gm-Gg: AR+sD10OjdZGp7H8pBAxOEbzKe3cjflwLQvseMZdgU7eztL8VzRNyCs/VNSZszOlABK
	8SAmePajA/I53E2sKi0QKbatacc8DVi42EfoSCrWRcIAXqo45UVOMiW/x5mmoFmTQNnz0OehE63
	/ajV26np4WmwhjaGaSs0Vi4hGiBIXqSzQzifgJwu98lxkidFWdqplafpG1NOOs6PlNKLvhrBlNB
	PDhvxQdxzqynEvRDiTnxkNzQt0sqvALlbg6vhacpCNrIOQ7lF3yT0tX74SedtLwsXpgBXazK800
	/3kcrlLs0POiG87X2L/fyAowSqTV0bmXUoWKBHPhssFbeW2N7iXuc8IYv30kvYWd/6fS4loHrtK
	KlrTR6iYzSMjDJVh97fuVWVE8WeId3Jfv5BEiFqouKjCs5xQIqB0b7QpW3yQsUQgAA0+1RWI0cM
	VfZKyc/mI/FDZ8xNn/i0jYa2a7QqwiBH8V8wYZdq3UxpGDFipIFG0w7FWmqj2MaYlQ
X-Received: by 2002:a05:6a00:2999:b0:848:67ca:bfd with SMTP id d2e1a72fcca58-84f2dff1913mr26379534b3a.16.1786097512040;
        Fri, 07 Aug 2026 03:11:52 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a5528adsm797510b3a.45.2026.08.07.03.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:11:50 -0700 (PDT)
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
Date: Fri,  7 Aug 2026 18:11:36 +0800
Message-Id: <20260807101140.1357218-1-shoubaineng@gmail.com>
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

