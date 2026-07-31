Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB8449EB8
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785518075; cv=pass; b=o2NtPFVLCHBHYwoPvV3+q3JxvctT45GyqLOU8n+UqdYoho9L9HVVp5gaVwvAQFzrFG69CsTCcDshc91NvA/8jF2FYgW+osI4NJ3MFWNK6P03QsEYVzhaXQyTpFHTu0BVYiCGvtXVLOdJVfO0c3b9ZQDHyP7PW9vmznAbRC5s/d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785518075; c=relaxed/simple;
	bh=ffngbTb7VcDss8OyQZ0TIbyICe29Rhb7o543BGHLugA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mv9xd8xuFF0UHUMyrrl/p/KcfI+LJS3OFhPv5UzKPSqTU+o7Dwt4Qlv2Na3UQrP3lUP7KRKFNO63XkWJBqLAGbqtZK+1pn/IhRtxiomoo0Ezi3gTUSMRYjvuoBShl21rsl1RyUmk4gTJFTabREMcIhe4nYZFGHHy9+/GkNNeVPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fni8KbKl; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fni8KbKl"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso572a12.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 10:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785518071; cv=none;
        d=google.com; s=arc-20260327;
        b=aJ4L7FAX61KsmjKH2QKJljQDVWKMi6q+91MEwZGjE2HV1+fhrmdU96TIK9P46EuXVd
         quFDf8A2QANwljPPFtiEA8Vaj5EjdZx9OKHUPfMWCHMP/2wlUIF2MatDkX4dhTyUl0/4
         uvgYQvei0uJVw1KX6oqwofUMWYGzF80EwzOXiAgPzlScbP+1gH+Cc2cIToSmsSTauTKL
         Y4vX05zFtT69sMeR2iE0qGA1+f05sapquJ0JVG0YEoAl3nI4mq3u+2C+1w5VXIjIqDQW
         61roEGJaRwP16qIUAKWshTadXrsb/uH4iS4a6PrtDH50CV7r2KG4PJCBxHX+ASK1mGub
         uW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1IEjvxIxcf25OzZ9XlYmxW3nZw+p1akOleAKSM54hBk=;
        fh=vVB512S496QAP548D20gKQWsqqk02gntpO/G5lg99Qc=;
        b=Oasi8ooQMca8bBda6UdWM6zFLu+84aVvrAJCbz1P/mi8xhnwEbTsiBxe5POecaTJKy
         bUjxHV4+x+6z1RklUqSAkVvMF/tp5Y53UeiWWX7EaiYrd14xByzpdkYi606qcRgdlj05
         F6LQ8UcQvO89Xwyuz5+UDPgoyua9JKY4Ya4mdItdFpa3uQXI98YfA1hARodJL1rZul84
         eKiYWidrRZ17bqu9EZcqXoe+qODvBgNZcmgpKRITCUFw0nehh0w2sMiHeHiyISwx5l9P
         /BMFd7vl8vraEUSQZ7tinBovU990rjnlzVawP31LIMCLaNZqHwSCuvejq1ePa9360MK2
         dvmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785518071; x=1786122871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1IEjvxIxcf25OzZ9XlYmxW3nZw+p1akOleAKSM54hBk=;
        b=Fni8KbKlLBw2IOxA0RONt692zF0OCdq2s477p4WMfaM20/wr7HKkohBG8CnJWOlmlF
         GHpxGge9dQIMobk6QOjz6VoiH+lzbBBDz1HGkzFAqaVV8rDW68bUPjR3z8o1QaJpbYNh
         g5vxh7NXHn3dx1/drxTwfzPY6KtNFoFRBA55b1oAfImkqjIJlEeeYZy3IhR/1HUJxpPw
         CSkFyixPaOO01U3Q9Os0MYfbNdzqU2nzg8hRKVCMyPlEqGI0h4LxH8UGaHtejPXpn4so
         Jcihh0paUm4iLm9w83aDyo3csHFs11CCy++2SG8a1eHVXsqY9QobX5qCw2sgNJMyZ42V
         RoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785518071; x=1786122871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1IEjvxIxcf25OzZ9XlYmxW3nZw+p1akOleAKSM54hBk=;
        b=c0iKO8gEQf6p4pTs3Ez1/uDI/6cS0wrU5XogLB3xxC14Pb/UwQOQ+NiDM5JHGkLWB4
         saLx8vjFmDYStG+BaLNvCKMUWQrQazDv43NHnlRATuys5zqUa+F4XFvP7KPJGcSzMf4p
         W2n03JrXm3WjmJl/FNW7tPN3wSZckffRckYSfbWEybOM7a+0Njkp01BJcmBIYUxLnmzH
         JpepaUiltoM4+9FGp6gfySn0rOP+sDmNv+zWRPMmDddGbY0SuWbfh5GTEHEZbwF7W0XJ
         HpQLXtc31XPUS+/7lyDvwQQ7bxVCCxi9xUDnNQsf02ntPp7Os220MmTD8Qmh176lXw44
         cEVQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7RxgF9PlL+K73U1h7bIIHqN7Ac6YdHnN4hS7UwO27tx+2ALZrGsqLNz3ytXLXxShNV/MyrBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHd3k28SP9GDLeLCNtRsxu8A8lVpe0OmgRCOB2z5HtomeazUJT
	xauU25vUWk2WYVdATaLf4V7ydrcLXNUgRx+vQP7fV8ojqiDkwrv9vhvTBSW77AOnxRtqNyLCO4J
	rfTr/0ojb1AT9tYWL5iddunWPoF+qpWvEk1OKJLBH
X-Gm-Gg: AR+sD12NnuK74XSftQw+5rBuBsOQzs5MfyFS3y3TXVdIoFmBo93ivzlOQ394krVGXv/
	5YANlOTcF1Rp+giINbzooHro/m2KFlSSrD5QGBxC1a9r4m24KdsLoFZUGjtTnmJYQFSasIMF8oc
	xjhpNWn2AEUX+INyBltw02pgp+oZJ78cEUHR2weJrEfj4laUDFx6ssQByWfUZvFrbfw1nbRs6FC
	e8YDE47vNpvH+oOHLV2dkQYZ1g23+Do4SO+mvZhzhspQlj5Ra3pB9UFnvsiFxFoAv5+/lJe38zT
	9Dtz+L+0HfEmeBRgjN4gxO2c+lWq6Ys1ixz3waTjUhb3kr4u6O6OXJFzGgyrdehLal2Xs8UZlVE
	=
X-Received: by 2002:a05:6402:29a:b0:69f:d9cd:ec41 with SMTP id
 4fb4d7f45d1cf-6a0a84fb211mr2629a12.6.1785518070065; Fri, 31 Jul 2026 10:14:30
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
 <20260730062645.233148-1-shoubaineng@gmail.com> <20260730062645.233148-4-shoubaineng@gmail.com>
In-Reply-To: <20260730062645.233148-4-shoubaineng@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 31 Jul 2026 10:14:17 -0700
X-Gm-Features: AUfX_mzp9OFlht_i5txZ0xvAxi8mLSvD5KWIdtBZewXay8clz2l69cTX7T1s68U
Message-ID: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] drm/prime: use dma_buf_fd_install() to preserve
 export tracing
To: Baineng Shou <shoubaineng@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Sandeep Patil <sspatil@android.com>, 
	"Andrew F . Davis" <afd@ti.com>, Srinivas Kandagatla <srini@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, stable@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 11:27=E2=80=AFPM Baineng Shou <shoubaineng@gmail.co=
m> wrote:
>
> drm_gem_prime_handle_to_fd() open-codes fd reservation and install
> using get_unused_fd_flags() + fd_install() directly.  This bypasses
> the DMA_BUF_TRACE() call that dma_buf_fd() emits, so observability
> tools relying on the trace_dma_buf_fd tracepoint silently miss all
> DRM PRIME exports.
>
> Replace the bare fd_install() with dma_buf_fd_install(), which wraps
> fd_install() together with DMA_BUF_TRACE(), restoring full tracepoint
> coverage.  No functional change; the fd lifecycle (get_unused_fd_flags
> =E2=86=92 work =E2=86=92 install) is already correct.
>
> Note: this patch depends on dma_buf_fd_install() introduced in
> "dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds"
> [1].
>
> [1] https://lore.kernel.org/dri-devel/20260714114654.3885457-2-shoubainen=
g@gmail.com/
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Baineng Shou <shoubaineng@gmail.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

> ---
>  drivers/gpu/drm/drm_prime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 9b44c78cd77f..fe3436d1235d 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -524,7 +524,7 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev=
,
>                 return PTR_ERR(dmabuf);
>         }
>
> -       fd_install(fd, dmabuf->file);
> +       dma_buf_fd_install(dmabuf, fd);
>         *prime_fd =3D fd;
>         return 0;
>  }
> --
> 2.34.1
>
