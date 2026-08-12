Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8184846D57D
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548447; cv=pass; b=E/2tt3Wvh7VwRFj96abvBTUPdjd7K8Kb6XTD9OxSF14sIP3jxuD0ImcOfYhw+RHIkQpUUe1IZBbxVqzpp9TSeYb1BTU4Hps5ljSZ9AMUUKNMwmYITow3ja64HZKZ2FAa6PYuCrNLkYR6GthSH2EjSWJ7RnmtOnwKmSqtQmtwqYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548447; c=relaxed/simple;
	bh=Ts9PK9aXwLEU/nrIRNxnM9qG/yIOXNQLDe8r+ZcI+pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INa7CGETqYDZPiHTyEMF1yOGi0ibYT3j87MJYtTdmX8sbIcQLlaUQQlcZuaUnefVxwva/47wQ+8GUTZn/pI0cBpzOqj9MHmex/+l9DdM55O3IciPisbRLukkpchyZH2uIdhG16JDx+EWC+vVgJNnS073ckSTGt2LzslPk9gCFdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MuE9lDq4; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MuE9lDq4"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a144c8eea2so1869189a12.0
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786548436; cv=none;
        d=google.com; s=arc-20260327;
        b=Kt6W48V98kqozYvx435v2iz215A/vjrMWa4ReISLBaXDE5NXNcOdvu3tUoDX+opdU6
         GRik16fMk8KjAHLtHwloMyEJtoG5Ey/79Wy0lu3rCpe9D7SOnENZJbQYy6OiFU+Yh7fO
         UVgOibgdo4W5tGEGy/65kxDBaltla3f4Z/A2RJB7C1Eqz+zmbSonwyMlpfoCA0AgdDoH
         GczJ7SIFa0XDqBhbfErL3mFWFHH5hILwqa2wG58pPWYht7WzGu6PbAD7EAXlFoLZpkFf
         WY5wRj7luWCrL7x0HKYMWYgPBMEFc4U6WNwYLtZ04PNOo69RnP4IXmRpiP7R+UYED1GU
         0dcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9HQw24hdIiiBy71zEiY+V8zJ9GZN0hXXJxvtzQE5bgc=;
        fh=0F4K5681C2FRoazpwvt+Fv2D6qM3ZXQ7ugocdiKMsWY=;
        b=AOWMYUrW0yjsKEIrry27I2nWkeCrLE2zjuuZrwimC37eQUSo7pyBj3E9+rOyzUjbGM
         AkI3Ns/K72sGoRS52fCQJq1D5okgf+AB830TxBEQe2hLxFCkmzSSQ45R5eQppne7LI/E
         eIyraRQtJlsovRKYNYUNY20ycBaH7eLrmgK1a98AvwFyi1NaMgjGgPeMH0DYQepzi46x
         YHJGnqZdi1CYT0CQW/Y5i+ooJTIl6d/vHSy72RCgUFg3OZpbueN6gi2SpvdRgudQKlX2
         kC34j3cOt9iu0Jb+2MAKcoLmbxIsO0I5+MHaB02tG+RmAmGeIdLxnRDEJky61guZ5Uo2
         o/sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786548436; x=1787153236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9HQw24hdIiiBy71zEiY+V8zJ9GZN0hXXJxvtzQE5bgc=;
        b=MuE9lDq4eU/VmDmnJ0bdER+wcAXpqzUL9FpQFQFw8ysphFxuWvXkt6ouCcNepWpmIi
         Hwp5S4eOH+U2E34qrxvHwOiYQ/aFVgvmnEOoDOywKLDpbJ1EmBz8HtOwUlq05v07c0EB
         7yJeTC5vSRJCLulUdZuaQVh8Of8LPr6dwk3Ca0D/fJDrWmvUm/VMgsCWyBVVOS6bZoVc
         LYvCemx9m7N5vs5dvziRKE3Ctm2pu8dcNnVsVeLiDmqmeFnudiwYpsnKXNnnSFu/th8a
         7pWmh1GregKJwByIXvrRVsD1iakbnBJxxGMjbIAfVMMGC09cADuF5spUQXinBM/mAaZr
         +qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548436; x=1787153236;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9HQw24hdIiiBy71zEiY+V8zJ9GZN0hXXJxvtzQE5bgc=;
        b=dJa5anNcg8h8+akuc3ZfZUijwBDhadlwvH2ztMM8VGFaCfcdayv2lKTo4mb1+3mCXe
         wM5mM5qh/FHNiVDvx5/C3ZF6LOQU/PA5KVl1NIXo532rblIgcOqDgT5aBei+7ZLqlnYp
         3wghCwwIhCKypMiTbRnOFwuD2+snYhjoOYbokHmi1B6qEvnJg1JgpcoXf6kFyR1s6Ncd
         ejgrArzR/AXfjKmez52IoBsVxZPA2oBxhLuwbJqVSjfvKXGv8pGCsst8tCksOq6UIeHx
         y1+9pkmaHr5+ili5/i7Z8vJ7o8OdD5CqHdCnGcV0vfYaEo8fCmAxZiFIc1S/6AYmnXbr
         aLFg==
X-Forwarded-Encrypted: i=1; AHgh+Rq3eDU6C9Fqql1sbCDsy1viASxX3ywF3owTjt36eTY7yw0n1mG/eCXtm/GT5sB2mrnA3Z3Hl1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Hrgsjpqq442PBpWNttXgIHaDSX1R+HBKLLbrO+sGqJL/0E82
	itxFpQN37RcOahcIi0/jskZ964ufrRPbU/bN3g8OZtxQ6OHZxiTDTuQ06QdZLvVJsbHpE3kwnxe
	UWA4nUor/lNp/ExZn6432ciK3FqR/Y3fK8Wuyw+JaYw==
X-Gm-Gg: AR+sD10aoKTvQ0sSlLlulN0teaGzjeMlOqvurUFOnf36SaRAvx5bXHS5vrO3An18vqu
	GzCne/NgykYTy+fS+3KCqYGzv3M01rWHzmWPTWosa2EFcsLtGaJzTLmDIMgPDdDM/x3Kq857MTu
	9Rj/z54G2Z11Mvbg1BDpwk5IMrO7WgKKf/WIxy5O0xwT1fVq2ePRV+kPfh6XiJAhRv17Znlf7C3
	99YPp+Hfk7FMGFPg02KZC2ziyqxWoks8nQCvUvdNyHoUaR2XkGmc454/7JK5vmDMzfVcqbQXPvr
	k6MDNorpiA1DtTjy7gZdLUOLh1K8CppnUXdfajEpvVj43Khkl9xzczdESwShnTNTNZkPH8Xgbg=
	=
X-Received: by 2002:a17:907:f816:b0:c20:2d38:e518 with SMTP id
 a640c23a62f3a-c20f2e66a3bmr273702966b.2.1786548435676; Wed, 12 Aug 2026
 08:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260807101140.1357218-1-shoubaineng@gmail.com>
In-Reply-To: <20260807101140.1357218-1-shoubaineng@gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Wed, 12 Aug 2026 20:57:03 +0530
X-Gm-Features: AUfX_mxKHc0XJq4SFZbCVvYoj4A8ln1CqD7e7dKrGyTLzT3rZmWFByVVhkPNP5I
Message-ID: <CAO_48GHc2TQJ9baa+EYst5vR0qUYvRVj=r8F9hxMLpySWE5+QA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] dma-buf: fix fd leak when copy_to_user() fails
 after fd_install()
To: Baineng Shou <shoubaineng@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"T . J . Mercier" <tjmercier@google.com>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
	Sandeep Patil <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>, Srinivas Kandagatla <srini@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, stable@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Baineng,

On Fri, 7 Aug 2026 at 15:41, Baineng Shou <shoubaineng@gmail.com> wrote:
>
> Several drivers call dma_buf_fd() =E2=80=94 which internally calls fd_ins=
tall()
> =E2=80=94 before copy_to_user() returns the fd number to userspace.  If
> copy_to_user() fails, the fd is already published in the caller's fd
> table but the ioctl returns an error, so userspace never learns the fd
> number.  Worse, the window between fd_install() and copy_to_user()
> allows other threads to observe and manipulate the fd (dup, close,
> SCM_RIGHTS), making any "close it on the failure path" fix unsafe.
>
> The fix is to split the allocation into three steps: reserve an fd with
> get_unused_fd_flags() (not yet visible to other threads), do
> copy_to_user(), and only then publish the fd with fd_install() via the
> new dma_buf_fd_install() helper.  On copy_to_user() failure,
> put_unused_fd() + dma_buf_put() cleanly unwind with no user-visible
> side effects.
>
> Patch 1 introduces dma_buf_fd_install() in dma-buf.c (wrapping
> fd_install() together with the DMA_BUF_TRACE call to preserve export
> tracing) and applies the fix to dma-heap.
>
> Patch 2 applies the same fix to fastrpc, which even had a comment
> acknowledging the problem could not be fixed before.
>
> Patch 3 replaces the bare fd_install() in drm_gem_prime_handle_to_fd()
> with dma_buf_fd_install() to restore tracepoint coverage for DRM PRIME
> exports (suggested by Christian K=C3=B6nig).
>
> Patch 4 adds a selftest to tools/testing/selftests/dmabuf-heaps/ that
> reproduces the fd-leak scenario (mprotect flip before the ioctl) and
> verifies the fd count is unchanged after a failed ioctl (suggested by
> Sumit Semwal).

Thank you for the series - please feel free to add my

Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

>
> v1: https://lore.kernel.org/dri-devel/20260703080922.1838362-1-shoubainen=
g@gmail.com/
> v2: https://lore.kernel.org/dri-devel/20260710105430.3059661-1-shoubainen=
g@gmail.com/
> v3: https://lore.kernel.org/dri-devel/20260714114654.3885457-1-shoubainen=
g@gmail.com/
>
> Changes in v6:
>  - Rework the selftest (patch 4) per review: extract a count_open_fds()
>    helper, fix the copy_from_user() comment, fail (not skip) when the
>    ioctl does not return -1, drop the bogus mprotect-race mention, and
>    reword the result message.
>
> Changes in v5:
>  - Add selftest (patch 4) reproducing the fd-leak scenario (Sumit Semwal)
>
> Changes in v4:
>  - Add patch 3: drm/prime: use dma_buf_fd_install() (Christian K=C3=B6nig=
)
>  - Add Acked-by: Christian K=C3=B6nig to patches 1 and 2
>
> Changes in v3:
>  - Split into two patches (dma-heap + fastrpc separately)
>  - Add dma_buf_fd_install() to preserve trace_dma_buf_fd tracepoint
>  - Add fastrpc fix using the new helper (T.J. Mercier)
>
> Baineng Shou (4):
>   dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
>   misc: fastrpc: don't publish fd before copy_to_user() succeeds
>   drm/prime: use dma_buf_fd_install() to preserve export tracing
>   selftests: dmabuf-heaps: add fd-leak-on-EFAULT regression test
>
>  drivers/dma-buf/dma-buf.c                     |  20 ++++
>  drivers/dma-buf/dma-heap.c                    |  80 ++++++-------
>  drivers/gpu/drm/drm_prime.c                   |   2 +-
>  drivers/misc/fastrpc.c                        |  16 +--
>  include/linux/dma-buf.h                       |   1 +
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 113 +++++++++++++++++-
>  6 files changed, 180 insertions(+), 52 deletions(-)
>
> --
> 2.34.1
>

Best,
Sumit.
