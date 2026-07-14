Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30513A0EA2
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029629; cv=none; b=ufYdsbhqepMU5hkpXvNMK6b39oXpiwyyzfe3M6BRn3UGisf13zVczoWhsaJJAAZXDeH+fXZgA6VkD4GgqxxhoK2Y4GyeE+MMsZxAS2xDOstMT8+MIj4ziXWXO6rPQVdjoXo1au68tsyWV+N6AveAMViE+ui1dhfROomDs+zqRPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029629; c=relaxed/simple;
	bh=X2wVqRoit1+4E3SJBgb2YLDCRJq7n5J1UWwaW8Wo32c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgKOnrmC2MVRLcoPQgNbRWlsee2SaziPbT0BGV6YYkPTw7IakSggKW052779P3Va1MNcIfwF0Urjx6wo07Q92tH16A00o2uduJGS+3T5WvNW0a8WIP4YKwyqtIjb33tla/c/SAwWuCUbJtXm6zDbyq/qWeH3pQEkYS2Q2/YzBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArLxSAFx; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArLxSAFx"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38deea72eebso2090718a91.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029627; x=1784634427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CQQ+xhhQTJIQk1G/3qoal2tftp25+Ya+e3y9IcyhICU=;
        b=ArLxSAFxkT8wPJ4FUtusvN4arssaKMGkBVoyTZkrkBNkQdaGd7icp9J+xwfvjhVkKz
         kMzGj9xygRiapIDXvDuaon7eB/jDOt6d5JH1pG2FgfygAqzVA78kO35gIld/z0quviN4
         8mJZaJbPMXGpl0Rt1Vhvvx5pqSIQvewd/lG1Tkh9Yd7DHUD1uDfKvLFco48N+TDiVY2f
         SGxoJEHUWSxpciaorcmUfE7eJZp9gzODwjmNXye3v1CBWUiWARAYkvLxo3UcpX1eU6Lu
         C/iKy/EAi+VJ715mQg7Mva4eQLF84hs6XtgI4xF318mq5vF7l5Tq4gL1XF39eljdjfaK
         f+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029627; x=1784634427;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CQQ+xhhQTJIQk1G/3qoal2tftp25+Ya+e3y9IcyhICU=;
        b=WEMWdcp54RSd6pYz1D0CokDF+WkZup5kSM25iwckhE4ImVik3ymMxLwC63xY6J+mPq
         v0yJlh1NaMWYhk0t2OwOEpxEIbxgANRYoTMyR7AEQelYg4TQyj7Jap51HDAeuIRCIPZt
         3OmD1HLsXcayHIy09zJ8k+WawG8eEcdRUKKlETVP5AiZUB5v7HHCJd8PomEHefRXqpW5
         9z70wINU5qSgfY8T0ZRSCN2Bj80Xv7UyqBO1y5y9BrSscAUUlr1aYxU0NU1mkse/aIV/
         EHbJeEqL8zt7RJ4ZQWXXCFK+DSL9biUQ4mMMXf64PJmPfQGDlNLQgxizn6s4Z/Ejy89t
         yj5A==
X-Gm-Message-State: AOJu0YxWnWwPWyJP8xQtl0Us7mK+MMEiozL0XZyB2DAEwtTZDmdr8I7u
	jJDvZtA8uh0XtbxGHw6v88ejo6qp8moTm03k3uIavKFwFFmwWeg0GKHm
X-Gm-Gg: AfdE7cnKVIHbHSkaophVP8V4r8Tpl4f+zu7V7Xd1Gt7I77p9gxfQ6ZlzZVyu2HAbeH/
	FpN9+BcUVkiO4FSxm0tzDnXhC+jv684PwPkJ2lxssqjba2Gbopi7UYuSAMT5Kk/vGaV2pWQlEc3
	W0TS3wlhx16nEvAaKennIc3//hdIQzP+X/kRZL5u9Njf4DnnaoADhtc0RgMWB4TQftTPelB8t04
	bBdrbH/pd4cPtqYGRkn9/76w96Bg1VQ20kt53v5vD7xa1Dzaf05dyh3jiCpX6yq7uJ0edrtrtTi
	aO82iMlwjrWjSCXuDFv31/rRHzdQn34eHf7+bhCcRCze6pJOtlJaILa7U0mwSSffF0gK4JjuQmY
	04WDRzU1/DXNb9ViDTq57gimaOoVOSxxGxq52juxLgNnjfRth8B6zaVujKqFPBaU45haMwxRh9Q
	68s7lvGjtuxvgPwKuF
X-Received: by 2002:a17:90b:2c83:b0:380:f34a:6ff1 with SMTP id 98e67ed59e1d1-38dc75eb657mr11649534a91.17.1784029627050;
        Tue, 14 Jul 2026 04:47:07 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e17470008sm1356162a91.17.2026.07.14.04.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:47:06 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	Sandeep Patil <sspatil@android.com>,
	"Andrew F . Davis" <afd@ti.com>,
	Srinivas Kandagatla <srini@kernel.org>
Cc: stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH v3 0/2] dma-buf: fix fd leak when copy_to_user() fails after fd_install()
Date: Tue, 14 Jul 2026 19:46:52 +0800
Message-Id: <20260714114654.3885457-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
References: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
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

v1: https://lore.kernel.org/dri-devel/20260703080922.1838362-1-shoubaineng@gmail.com/
v2: https://lore.kernel.org/dri-devel/20260710105430.3059661-1-shoubaineng@gmail.com/

Changes in v3:
 - Split into two patches (dma-heap + fastrpc separately)
 - Add dma_buf_fd_install() to preserve trace_dma_buf_fd tracepoint
   (spotted by T.J. Mercier and sashiko-bot on v2)
 - Add fastrpc fix using the new helper (suggested by T.J. Mercier)

Baineng Shou (2):
  dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
  misc: fastrpc: don't publish fd before copy_to_user() succeeds

 drivers/dma-buf/dma-buf.c  | 20 ++++++++++
 drivers/dma-buf/dma-heap.c | 80 +++++++++++++++++++-------------------
 drivers/misc/fastrpc.c     | 16 +++-----
 include/linux/dma-buf.h    |  1 +
 4 files changed, 67 insertions(+), 50 deletions(-)

-- 
2.34.1

