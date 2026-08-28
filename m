Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F74B368276
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939402; cv=pass; b=IO2f8uYioGBjksR2Jipj59w3llfbQl46R0IP82w2HwinKICCMA/sCLFMXMmp51Sr89jzUSpBuvfmLrqksLvXLLsOoFCWVVPe5Bs5BZpvbgxLtjj+to6NDzkopxLmfu+dAjrWAeSa6MrX7NFZd8lv1jqJCBodnai/EXAx6YjCYFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939402; c=relaxed/simple;
	bh=LQ3fjEooKPETFdFoQWnDo3gh5Lmoo6R1vHkIQ7xHji4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRq+kU5JvLl16hwjxS4esVM6fkF9+DEQsYQ1x1mBexptGdATJ3G9Kad9BiYKrprIOsGXHwkikU8vx8vGSEUV0FeAEfZFLfPvV+q5dd2m2vOZi3rxb1hBIkHTBoUNDqlhxwHmVN+wNXcm7oEiHLg7hZn+q/yYHz6WPL2Wx8PWr60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DiaVi47i; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DiaVi47i"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so1523109a12.3
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 10:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787939400; cv=none;
        d=google.com; s=arc-20260327;
        b=Rg/JZbQcE92yNQIZhIyFibsKWZiX3Q/D+56LHZBySAjK+6xRenznaoLW/lPPfPdxVp
         U1JjN3t7scKEnw9ZkLGMoruEtT5dI6OAy8oJpmfRakB3WZu7B34mAswox6grJpSzyhQ/
         ON6S+QxoOwV25svVQPbJbtcROId7j3h9NXAqZHE7JFzJVlNGA9sEnuqKnRcNVQmeE3FK
         KZmPd39a73A/9HHGELuJLVm/Denii53gN5zt75DWt8EKasRZefGJxsaSMz9g9HDSX5xO
         7rO0fAWL2PnIK9KRRQNdZ7/lm/aO4GHeBsucfOxduo7ZLpmLlBQhmrPKDqLhTteK3TLm
         QWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=caNOEyBkHtDSXs15jKiYwMl0jYwy/fOio1tRTmfPcyQ=;
        fh=AH0ARvr/YxPEqCbIoXPcEQh/6nkaqzVpsfVKT2mLneY=;
        b=RoNcwW5g6BMh3nHkj+Q/m0AcqKPOPdFZ0vg/u7aFVI7jFB/hmQBz0uFjVPempnA7/5
         DNkKRUaw9UpQ44uJr97Mw5Armxzt8ZouwL+MLsfUudkfBOYZMUVyKBQv+fxj75ABv8Zr
         Rg6jcMKd8EAg/DouM2tm0lBwc78tq4SYpXFiYYr8K2AYqZrO/Bissps52MjuQ7iHqBxw
         tDlQYO0oL0kCcZn7PRApldyEh7bLOjleV8cRvirAJCMkfA8kb0fVZDFqi3Jc+9OKgLXE
         yGxS5pCel5m4/QY+NRjF9cdDfMxiZNYgy5pjm6i6kSRlqlZy1r16tMEFa8fCo3spLK6G
         vkeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787939400; x=1788544200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=caNOEyBkHtDSXs15jKiYwMl0jYwy/fOio1tRTmfPcyQ=;
        b=DiaVi47iuaIxIr7onVzlILA5JLViLwHqlP08CqzqSJD/j/cHy9VyF8BwxyBxYXc7R9
         iCH67b3MjMhGH6t/gj108IkA5KTJBGPSJlwTaCZQCzj5AwYSQR90c3VdAQzga+VWnLLm
         fEVvweIfFALBmCIUpc87hthmH1VlGHJZAmtbWYlvHXsHmXQdPi9pUOsci3vP2ctAo9gl
         bmll1eFz2ZhjIBG9L2sXGhgoZ2N/D+TM0oHwJqVdA87wMU48upNtos8fsvuYGDSiATp1
         jPoP6LNcystR8cQS7T9To+pX4GyTW2xCsnSTN8cBfrhU8akVQD6uOdQij+Mha5VL2qn0
         MqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787939400; x=1788544200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=caNOEyBkHtDSXs15jKiYwMl0jYwy/fOio1tRTmfPcyQ=;
        b=GOTVsH0zfTwXc0i7UO2zmJgSHzpc3CtAiWRcD5zUNC6i2LRcuNhSxjnRVvD29nxXx+
         wo8SWzRNENP/faLOsWRfV67VxcIxqn33j2sVJE47DftsHQY12HG2Ue89Dx+4EdAjvL+R
         etq0caxpHTg8vA14kmDUuhdtnFwlJhUuT36s9W2rZEqxlOe+bmjosx1v5KegSS2xjEao
         wfjJv85lYM+mPlAUcYX9cRdq3L9EliplIxDllA9quUBaMPHo177lAUfVYli9/mpT49Yx
         HXVMsm0Li6mCn9e7U5JijDmHKS0CsWjC9rqsEw84QgNXARrxFq8DBeBhKCan8fVyfDPo
         i2vQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7lctQZtlNvdoYyn3VvqX2WXW95PuBjyOQb8JRax+kprHaTh7XXvI9T1lGXeLO0kEMSQ6klyY=@vger.kernel.org
X-Gm-Message-State: AFuF++lvhagtTqsucYu/Dfia6hpu4LnZfgcxZDCEqjqdm0yjBRGTJnLA
	Gy6VJHDrdlEPKYX2W4VYUV8YgbBfyS2ovT3dqr6uH6ZdCzZAKTA8n1lXiaE5eGPUXIn9A+EnwQQ
	3kquKWh1fdvjpFX/soEyjtt1x6S/2w0y7mF4m6O2BbnJV4LvYi4z7RzlgkuY6Zw==
X-Gm-Gg: AR+sD12A/T4YJVHTUo+mx6z4wRZAwUeurvilnqFFQWU1eeJnmb5eFFRdt6s7s4JW15A
	saJ2cGR59ure8uEbShvAqQWiCrKDmkvIFGKK8j5fGA4W8ITLaK50kLqUVER9iIIKX7QuuPevfDh
	xJOzZSfVASnUNCOospV5y5gxiVKFfU5HZK7gHyNofaf3M8qxuiV6ocGqJQRxqn6W6Vz5ChypOda
	f2LRIg96ENEzr51+AIbqahHaFzIwo0hr+J+Xz10wkH+qi7JrAb8gKRv9mvZcaVFqk35Bt37pIV1
	IJNMXF/BQOMOP9VFTRPF1j/bBCFzqDoeldFNHY9V/5Ak3Mx/DNVR7U6/+yd1kG4aZPmPYc7858Z
	sfAA3SRM7zEYfgOhHFkgCrI47bQz02pW8TeRTGo8YVSPt9h3BVSmNm6Ml71p/vTDjy81WrVlGT7
	HiRcs7I8CIRd2nRQ==
X-Received: by 2002:a05:6a21:a02:b0:3c4:36ef:3dc9 with SMTP id
 adf61e73a8af0-3d26992c505mr19587950637.17.1787939399901; Fri, 28 Aug 2026
 10:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_4AD5738B48FDD2FC84E21FE59338C8DBAA05@qq.com>
In-Reply-To: <tencent_4AD5738B48FDD2FC84E21FE59338C8DBAA05@qq.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 28 Aug 2026 10:49:48 -0700
X-Gm-Features: AcwNN1WiA2DqZa6xhYX9EXD9Vx1_P4xPxzbugNgugTs7I0_MkH5lekI5Z7p3LZE
Message-ID: <CAAVpQUAYOo1hRXD_fFx9oa2bqTV_x17i7Y=vajcx1knYNLjdsQ@mail.gmail.com>
Subject: Re: [PATCH net] net: unix: reject negative max_dgram_qlen values
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 11:10=E2=80=AFPM Yingjie Wang <1075151112@qq.com> w=
rote:
>
> net.unix.max_dgram_qlen is documented as the maximum length of an AF_UNIX
> datagram socket receive queue. Its sysctl entry accepts a signed integer.
> The configured value is copied to sock::sk_max_ack_backlog, which is u32,
> when a UNIX socket is created.
>
> As a result, writing -1 is accepted and reads back as -1, but newly creat=
ed
> sockets receive UINT_MAX as their datagram queue limit.

I'm not sure if this was intended, but passing -1 for sk_max_ack_backlog
is known hacky config to get max, see __sys_listen_socket().


> A nonblocking
> sender can therefore enqueue past the configured finite limit instead of
> receiving EAGAIN.
>
> Use proc_dointvec_minmax

At least, this effectively limits the upper bound to half,
sk_buff_head.qlen is also u32.


> with a zero lower bound, rejecting negative input
> while preserving the existing nonnegative range and the zero-value
> behavior.
>
> The issue was reproduced on 6.12.80 and 6.12.105. With
> max_dgram_qlen=3D10, an unprivileged local workload sent 11 of 16 datagra=
ms
> before EAGAIN. With max_dgram_qlen=3D-1, all 16 sends succeeded. After th=
is
> change, writing -1 fails with EINVAL, while the 10 and zero-value control=
s
> retain their prior behavior.
>
> Signed-off-by: Yingjie Wang <1075151112@qq.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> ---
>  net/unix/sysctl_net_unix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
> index 47660d5..2782095 100644
> --- a/net/unix/sysctl_net_unix.c
> +++ b/net/unix/sysctl_net_unix.c
> @@ -19,7 +19,8 @@ static const struct ctl_table unix_table[] =3D {
>                 .data           =3D &init_net.unx.sysctl_max_dgram_qlen,
>                 .maxlen         =3D sizeof(int),
>                 .mode           =3D 0644,
> -               .proc_handler   =3D proc_dointvec
> +               .proc_handler   =3D proc_dointvec_minmax,
> +               .extra1         =3D SYSCTL_ZERO,
>         },
>  };
>
> --
> 2.43.0
>
