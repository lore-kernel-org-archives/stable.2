Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459143;
	b=eW9G5eUpNA7hOSV2347ED2WbTWNl+tikcgk9KHPa4DHH8Iwb4PjDjpgNn5tFG17r10F2
	 9h1P04L6caQkQTJOBvfyovZrY/ENJs8Fc4k2kQMQo+o2UKorsT5cOWYc6IxXDPDAnlCBc
	 ZTVS7eW/OLyc3rufGXTk//60A+YubfrvaYlWQTK/nFp2UnQcWKllT69n0s3n3iOsu/EEP
	 Ci/kqWC6CSKyEfYhdU3KMlHfDhR9IGRtjqAlCbjUa/hSlkMDprPwVoUhmmy108pxH+u56
	 saIht+Njw1MFcgQNHSZOQy9keGzAB3tqDlWR0fDlcxrZPFaQSKK2k5NswD4GIQr/ypQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BVaIouS2pVUMajQqbfDiziKY6k1WNaUbZHjTPOkkoAI=;
	b=NwZWYZFhK4y4iWOdBkZA8s7dpSE+QmRM/s5XGJ9rRknzTFq41mLEvbyZUdfgkRsub9K3
	 1vgfZMCpoPRjEVbti7yfDZ6Gj6UPahumm23MWKyKQAuRJ3O6zoOwpZO9HOC4Fe3Wy6VSj
	 fSiGNaCYTsC+iepwNtWjFOMo/6W8EiWCNTrgCgIe+uRh6+R5hbfzgK80KfoRY4T+EfCa7
	 pcfYaGncmvGo5B3m5ChonQWDE5dFn28he5yFSF2pk+vOiQItAHa6RY6vPpV4BdT2qs4Yw
	 nr74e9A2MMeVSOrHR6lJsJgx8lFMKzqHZlNJVy9xWdHpWvWbQvYAmUepFL5AysD3voQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=odQEP70P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE8606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DFE8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=odQEP70P
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-99e156fe905so3119479241.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:38:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795459137; cv=none;
        d=google.com; s=arc-20260327;
        b=nEhdMf0s+YuklOqEuhREeoZ1v5/boK6RL1YmAoTiYtnHrgKc/IYXDk5g02By7AHw8z
         AqVUId6Mb4F5xaXxpiznEjIickorop+nF/aTKbjPZMR7DaXvP//wzvG5IxYc39jvcYXJ
         IbDHM6C07Di8CUi8JQe3TrGvsaVkVeF/kMFsC7y5QnJIOVpsrHbmJp/ua9gfX9gahHO5
         z8LQAYkqFgw28mPeLfOg/dhbu4/fGnwV4o747BqH+mfgDH+D7c+5FrL/O8pa7KuOHpGS
         inz43Dcg07t0J4iTza/URj8tE5DGwMAfuDMHABG0TIDRw3uYWpPoMWrtcZTMS4RHRje3
         z41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BVaIouS2pVUMajQqbfDiziKY6k1WNaUbZHjTPOkkoAI=;
        fh=CzMI+/2Jya4iAQRSNwHsM0QK7xzqKIxQgig8KKn7xXc=;
        b=VIkrgBK6bPQB1mru7UItpePqcZXdR9CHbksx+UfIZDnR4DIaKn8z4MEjyAN85p63fv
         D7l4eseTin4zDXArQjj15h2fiOOttp0B91/RoX2avBAyJSMEa05glHKSwZSO/Gwofokc
         7+raEgYy9iaFmyc/WY7i0w3F1p8hyleZD+IWbte12y+kvpGZ2SVlM0kyrzmrpUe4edYA
         L6wQeiTXL8Ge1eVPhELPhKyUhmqrUQRpzjflmyQDtM7s5909OsSv+B62qhr9BdElZceQ
         rRpluPnTmIO2cWIwFpQ/doBeY4Kfx2wokZD5KRwyM+eGrMdeV1cvSp0GCCaBrhCfFx6v
         lq6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1795459137; x=1796063937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BVaIouS2pVUMajQqbfDiziKY6k1WNaUbZHjTPOkkoAI=;
        b=odQEP70PWFT6c5SCrCZ4mVifAoDK96XoPCuTYfmIwW5qusVGtYSEfdfpwkpIny5fvt
         ueYLKr44uTbOecaTmw5zySux6FvYhiXh9gpbz9b0WglD2iepcHpNI9+7XKAqFtDY0tXR
         yFDt7a15fqydzcsLjTKrC8mk/3nbWsqr0iaLbA6yHduNsZz7X5/J/TaqFklDzLw7WWFO
         ikcis/EndrDpNa+w5aGu5Da+UxAdEsbVJy6cpi5InHemVoCV+RkX5c6N4legH2Po2lM8
         C4MqrJS22IDV/CFvhXk+GT01+S8yrsxwk5NRxYgNPLSnw67ojRa/3OIWDL+i2Qq9qMOj
         E5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795459137; x=1796063937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BVaIouS2pVUMajQqbfDiziKY6k1WNaUbZHjTPOkkoAI=;
        b=FmKmyF5NE3blq9dgSS/JYaJnqrwCfkqcxRXZqv7egm99zyx3Qy//XzddjHQyTIvWAY
         BI+yvRBuvO6toaXiwVJvpvuHR12HvuFf3HO9TAlUKN+05fc4edtjy0eG/LSzREAAX+lB
         OCXidoR4MO2jvCU+yNw0wuvT2Ztxc8gprcX98qeGUi8Cix9umva6MB3NnOY83JN5peKo
         wdEigxIbdmEy9bfZ0jYfPdxG9pq39CcrtcQooJoOtDl3a9UCQP8gqkKGn/2lwBzeHt++
         xpRhNQ9mkwBstnBSPw3V1cvUA48VJYa2YHgoS50Ns3rHprMRpnjRpT6o8029wRLsQYLg
         837g==
X-Forwarded-Encrypted: i=1; AL+hErE6xbBaAP69NRbH4V8iWYpMmKZ7Gay1wT9KBr9TDoyDWdTeULXQc3PxFSlFzmItmkotsXceHiA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wVB2Di/1MWsnbDGPNoUvlVUD+/djvzbAPEDvq9ULH31jMxcUV
	nkeCWThrMH0Fq2uyoOblzxJoI4ac0W3GRBBOn+QHD5znEcA6DcHxQ7GnYIZESg0AWav6xPy9A+7
	pH1cECMr8wARtrssvncFj25skxANQ/bgwBN7I+kxiSg==
X-Gm-Gg: AZFdTZcjUnAPjwBnqyPevLkIfPSfwPiObU0ynOLVE2wCL3fkVVho15fD4nJsePjqOJE
	v1WbJ+assK7D8Ol5p+u5K5VvtSThOioEUegkCFREc3iNJbbjmDxl5P4VIAc/gfpnDc9GPAUBab4
	DtsIRUnVgtVfEJIl5MScC67/CNZdOQPDwVP641GYdVrj1cGzhCU2FEGZ2JzL29bJ6uOoayTLqv1
	zAmsTlq0Q36UwGwtj99o3C1lsbNGrUeTikbB0gBL9k9bTnjQibeW0X3G0j6zFUiErlXV2x50jDo
	4pT2CdnoU8weASq1jA8YmnYHyFK4o0sb9Z1GaMv4C6iRnpplU49nXkRy0szESca9pvnLKSfXC+x
	6HGTlofg2gUZszM212anNpfTmqwSnKzfOA940JoUy470QaI8+evllut66BDyFGaoTlywnsjejmM
	VE/3kHHnMn6E5CnQ7khzxBuQYIeMSZ4vLy2w9BfodDJbdwKBXbGQe7lPn5WS39wvNjIJTgjAKil
	sBzC0X32dYi/Q0MQGvuf8TB
X-Received: by 2002:a05:6102:3709:b0:7c2:799c:9018 with SMTP id
 ada2fe7eead31-7d71e3301d9mr3598327137.0.1795459136929; Mon, 23 Nov 2026
 10:38:56 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116183519.3314837-1-rjethwani@purestorage.com> <20261121152324.668463ca@kernel.org>
In-Reply-To: <20261121152324.668463ca@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Mon, 23 Nov 2026 10:38:46 -0800
X-Gm-Features: Aa3M54ocmouk4lzpqzy6nOPF8SzDj5v--NdJJzUSb_41Ik007vkSQqPTkqjXAuw
Message-ID: <CAKaoeS0KjzHPcgmhHZud4=1sUG-J4H_J_==PRTtpNSYnMZ7ipg@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] tls: fix socket use-after-free during device-down
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alice Mikityanska <alice.kernel@fastmail.im>, Tariq Toukan <tariqt@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 3:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Nov 2026 11:35:17 -0700 Rishikesh Jethwani wrote:
> > tls_device_down() pins each TLS context, then drops tls_device_lock bef=
ore
> > switching ctx->sk's TX validator. The socket destructor can run between
> > these steps: the context survives, but __sk_destruct() frees the socket=
.
>
> Looks like it conflicts with another recent fix. please respin

I=E2=80=99ll resolve the conflict with the recent fix and send an updated p=
atch.

> --
> pw-bot: cr
