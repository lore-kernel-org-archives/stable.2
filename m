Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB841D655
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097481; cv=none; b=CqZTTSgGMU7YHzjSACjIMQJ1gGV9ZdRJEHSRZqOOsJ3Iw+u7zMzQHWR3sUAGXBZpvdG7m823l2VPtek1dZq+AAtTbyWu3I2vx8ruO7uHsenA5ZuxAsukai5lSG1CPwWbtYgR9kWzCspTSG3LYwYeCkkUvBcYPfmKvCEq1zBFlws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097481; c=relaxed/simple;
	bh=Lh9CRmCJRCXUfNdf9uNGdR9iSpJFMr7nm3Cly0+0f/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IeyhMK4QLfjDlKXxd33sj3PSPGbfwSsaRFD0Zg1HBY4TohFd7JMWCEd1US+S/AuKcSzdpmS3c7jgk4Gk/urRzK74XDWrX0rQGyKOYkSajJFHcvhV8PYWs7TLU9AjQXJb7kdfc3UiozIf/uoVw419WDevaMYI8dMxA97DPKCNh2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWSzpG0D; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWSzpG0D"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso3246460a91.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 03:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097477; x=1786702277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
        b=AWSzpG0DMAhDsGUtavAmQ6Fu/fEdTz4FYk/miy2J7IQy5SOdYJxUrwi8lUy2vEQK9w
         PE48cpC03WluYAZihYrYcF/4S5yvaxw5r+YVRCKZoqu7L3m/OJ91vSUrDmckObS5IeBt
         qwImmH3g9z38q0iy7sehGVs28+iJOui0LDe0Cq4+F3kwrJwg+H/QzYIs9V4x4ocApXcP
         32+7YPUF8NwUr1txp8Hq0EylFCiIAYDgmkvkdA3yRjVFELzIr8cH2BLBCs+mYbiT1hFj
         inpWlhpgoWLkf2jN2809HUs679Eogx1gEBeGDtM5NRkIAnOs7s705ONiAi10UhNCwGXI
         mg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097477; x=1786702277;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
        b=ZPH1/09YoxooRNkT6wk+gJ81vpaRccEkIX3gI9RH8G+iEtQ30FkPBWPC//IJQ6UXXC
         NN9Zm052ezpe/E5MiZOnjN1Gnh9aQYqZVgzRT4ckgkIgTC+RGuY28lSAU+aiCDGprfa+
         ih3zdmhSNiw64KGXZYf2JzgT03jxlA1j8uJAJV6lbuYyFDkbSiqOF0FJ6ce7mWZml7Pd
         Hrn/0XyyijEc/ILrwK5n9hGjFBR1KTJ0hFWLDuVhgRvBmgfddNeAKXd0GglTGWoZB4b7
         rSpLiX0oB9mYpQ3OQdgaaHADWHlfzeBbvcW5/NQ+g5kvsUERPlJk9LImKErE7lT3VWtB
         stEw==
X-Gm-Message-State: AOJu0YzT576AfbWXqxx0BWfJYsld5+C9/rBQyi0roxsr/Kxbs++0+de/
	YlDwo1MPS+AnWPzrjh3OyXQIqNcKOeu7LZ/tjyW2conxi8+wVwMpIXdK
X-Gm-Gg: AR+sD10bPmx92gkqkI7G088HrwDWLVyVSlC6nPfEHfqWJVOfzx8WG8Ms+bCAhPYhO36
	Vg4WRhulS9NdphIhX7cdgv3gHTSTWSZVaxcIN+ulitHUhcTgrJZIst7790xe2DA+EeoIuhbzts3
	ASvmvnd7+xrbxAGdazUYse6cU6I1QNuTAS6LMjUv9pqdbLG2hnxfxbYKmGRIYaqG9Q+DcjtD/zC
	M8blvAKZ0WS1+Je4XL6Y8rqZpA6BkXvkBEAOQl2IHfxA6vpQkb4/vWarPhzmQ2FbSRKyiNrIQT8
	li8l+L3v1BCd58oNOnVP4AS/CgMwNqxakLvnLF7UW7gD0BV+5Bd6Afw8c/b9q55kZImR4Cr7ymZ
	SnxMdkGMTTaz2gBJaXFnY7sdzjVI/H0XZA87zverTnLDPFpwUnZkOrcn6a3jbvLr7K7IqT+Tndb
	NaqBPhBlgu2myE7y0f4sz+NDx+cs2NGs6SwfQnj4vo4bfn539o9hUwajOIs83dzfF2ysYXx52/3
	EE=
X-Received: by 2002:a17:90b:4d8c:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-3903c544f17mr18302876a91.6.1786097476902;
        Fri, 07 Aug 2026 03:11:16 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6c13asm1928581a91.2.2026.08.07.03.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:11:16 -0700 (PDT)
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
Date: Fri,  7 Aug 2026 18:11:00 +0800
Message-Id: <20260807101104.1355464-1-shoubaineng@gmail.com>
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

