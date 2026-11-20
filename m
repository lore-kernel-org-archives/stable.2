Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795184947;
	b=iL9J2XEdzF4PhfI5zehVMl5xFjUZguA6wYwFGafwTCvizOnGyGCeeEEMv9+HV/OLS5bB
	 iWAN8BB4Sz36UGRCuv7kY4CS7c/cQI2GE2XlDRsnTM9Q+CEPmJf+24ayYRiAeKAOD2kyu
	 5+h3YP/hNtirWqlW0095EVtmhlsi0VMWGQgxMLBst5rU9PeiuGGc8NbSmDolU0OdQ+IO4
	 ICmm0aI3gDk+1vn99dgj34RLRtR8kg6OecexWyANbzjmscAtRkuC9oBUCEKzeluJSlauB
	 xngEpBfb4FmlhjSmBSF0CMoiuZuNkTdNPafVOg594mYllKbY8Gy8FMcs2sHnPMq39TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=PrOqE+bSiayWOYxEYrs3jZYEla+CkFoA9nQLVlRCn6Y=;
	b=cdZC5xmLom3PNwhjFf/SJWclj1GMKypXeZZdLg7T94r4xH0I50215YdmsB0BJWUezzsA
	 KL3r6/aXziphH16vmRBau2+2VKlwN/T7BnT1wT+jhFVwYXF2qxxHJohCmGouFla2sOHK5
	 IrZbILshczhWzNm4015sdxrUuaziTwi6oliZ+CKP+ojTI4IXqz2sElTyKMYmVSsgeNCCH
	 QYJYjmj+jokgjbEOvSoyxSVAh5yfRPsdjmdXt//goyIPj+N6N3+IOweaB8kD+M3GshhLC
	 LpcFLVtxDws2pru7XrsGsKQO9orxuRroOKrdHntUA5bSim6a+MuLoHKuDqE4OtGpVfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b="KGPM2/li";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D9606A32A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 349D9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=KGPM2/li
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so169343066b.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:29:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795184945; cv=none;
        d=google.com; s=arc-20260327;
        b=Jqhszn6wI70cs2XBwATm/X2h2isW3FNOVuROARrZBLz7m/RE+NQV2NcbZknLRUMcA3
         DNu7WebAC8zWUwL11peZ9qKEulowt9iQfNjx6pnxG07WLJdd6jkhIk5/4uede6cBoQNe
         P/hVhwWmlOW570hWtIIuX6Rj7wBnI2GeaDYWQb0SP6pVbdZ4koOML2UCIcnLiXg5aFd9
         UtCwTZqvdSyHX4HY52fgIzjF8Wse2VwlDOkPK6mf3n3CKZhBSn1gf9qEM6bM3pJAFkkV
         JIH/IMjtiSK2g5rqQ6uPKR2EQ216o0mQ9gFLsEzPHdu0qcuWYtDBEUYZgPq/nARURxrf
         v/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PrOqE+bSiayWOYxEYrs3jZYEla+CkFoA9nQLVlRCn6Y=;
        fh=1UQ/bTbZbFJZGqIDnEHMA6yBrN3gQck958Rqvn+ECV8=;
        b=r77SgQv57F7bV2WUeOj5buSTte/YyFeq8FdBMVVH7vZB5JJDVs6ecssWSTBcue2hX4
         FGG/EKJwfbFFdU36yuMkaVva6DrhMn2IvW9LUSubLaiK/HfB/SYrBa152dGfpaC6SPiJ
         l/g6SOsa+DzUb2X2uF2ywUzs3Zc0I973UBEJpSKkkq1tIQASg72Lf6izKS8OxdZm12Uu
         qBXW2Fvs6jxAtRFHRt/x4kTHelyWuFpJVib6INyiYQOeOX6KA2Zxq5m+x9nk4VrEL6rk
         1saBYy/Jv0gcssaQ1eMOnDHvnsDXMhJqvDQm6udAqkdkr2we7ago4WZ+zO3161Nnr2BU
         tluQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795184945; x=1795789745; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PrOqE+bSiayWOYxEYrs3jZYEla+CkFoA9nQLVlRCn6Y=;
        b=KGPM2/li2EqKJYsf/Gv0WBthhS+7luPZAuNGPpKyoFR0Tzkw/keRMcPSqNncdo+2u3
         uZ+z8CtXzAHyFe95zXtUVAzd3/EqXdFCu6If/GIpuT/0EUC5sR2s5ZHQAtrFj3wHUQ0Z
         IXdKQpGDDTztrw1WwuQaleOUwzoMUx9m7ewvakMso9Ku4mvH+wudthJmCerHjg1bYbRV
         o1ynKSSNX6Rg214EU/v8oT5eMHlVczo/yhDp5h56i+74PPC6D1YDy+Ll9n4D/UClUXHw
         Cli1pzyCwK1zM/moRyGGU2j/ZJ4fZUiQSbjkpPtk5urWyIMeD44Rglud1eb1xF9kceFu
         b2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795184945; x=1795789745;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PrOqE+bSiayWOYxEYrs3jZYEla+CkFoA9nQLVlRCn6Y=;
        b=e3cvnzhmjzGUnRLKm7Z50aNNgE59VFwEj2aRybycrkdyy16n95FXRMxMiyWm9k+pPw
         Cvl5ombZbJ6cYTTIbwgl369Ei7yGU/XssVhAb8iEA/gErhU8OvbEqR9WTt7RPmsIn+7m
         FWTu+1blxVC31nb4QLhfpRzQz3wvcjNjlUkY9s4FqXsBLLo/66n61VsGt4omKjXLVdRH
         /Ia+1vpscenUYRXLsKvwHHnrheBWc8KFOMWZHrBPRRXEJRKLfrm/+XAPnYbWuQyWuDID
         F1zHTa1yVekWwh/1tifv0eI9FdtsULWXmp5u2pPmy+4uR0EQM+LPTVW5hwdA7wvRxvbF
         rSMg==
X-Forwarded-Encrypted: i=1; AL+hErEcfyov5dEv9fceknT3S3/sMpHzvT0m6JBbfOTBYeDPQM/dDIuQOxlMHEUFT702VWI0U9lJLGw=@vger.kernel.org
X-Gm-Message-State: APuU4Z83gEssoDAZdgVoYrUF0IHBCgbtWRb+Rpw68H2B3kMloFWwIQCU
	FCeozqT7nDIF1dbnqpMuuML+hc0ZGS0Loi261ibAuH9+H9iPOd0X6bbyGHIdSR1+BR4Gs87/Y3e
	Z6AFHN54TvG6bXBif060WWDoa3XKGl/5LtNQZ3Do72w==
X-Gm-Gg: AZFdTZcITySoKi8Up+dEGbmdOLJKF6l4igKX2jScchth8M2bbQqysWBB3TpKe0AirFo
	EBYl1Hwh5kDU8q5T29s36PpXWx6amAfzvxOpcKLTW5OWhXoiyB9HGHR7g8YhSxWqhDcrRSDtk1B
	jV/fH4i3QJSNcpUtIbCE5njeY98kve9VOTw3TQOT8UHUOc4yaVn/JUZHBRDDNuHP81MKd1110RJ
	W4VXD4q1fbrspn7sY68KDyR2GcBBm/SUBAmqsTXjeSw6/aY8RmvTrNks3ZaD2nc757KWm7dA8ra
	SQkJeapcZGhMkfGrvO3LPH1Wuo9ZlAbrbOG7OPdn1Dc4VxdX2OX8dft7NwZdl9i0kMGZBgVo8C2
	tyNY1g2VE+m2vUBZ3bSb/nlsMvfAOCSX+eQ==
X-Received: by 2002:a17:907:ec02:b0:c50:aa10:d898 with SMTP id
 a640c23a62f3a-c513a859528mr312083666b.26.1795184945410; Fri, 20 Nov 2026
 06:29:05 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120121614.978396-1-rmustafin@cloudlinux.com>
 <20261120121614.978396-2-rmustafin@cloudlinux.com> <awA8o4oIq81a7J1z@kernel.org>
In-Reply-To: <awA8o4oIq81a7J1z@kernel.org>
From: Rustam Mustafin <rmustafin@cloudlinux.com>
Date: Fri, 20 Nov 2026 21:28:53 +0700
X-Gm-Features: Aa3M54ovtmNup2lPY6rNVpSaJu-oUVw9OB9JbjDeYfkHzHe9GxRDZx2A7BPFff4
Message-ID: <CAG6=z5tzc8DG-7gU03mKs1JxqEzUULwBinfHKtYWyPycKkG6mA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tpm: Track the response read position internally
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Shuah Khan <shuah@kernel.org>, 
	Jaewon Yang <yong010301@gmail.com>, linux-integrity@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 20, 2026 at 7:27 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> On Fri, Nov 20, 2026 at 07:16:13PM +0700, Rustam Mustafin wrote:
[...]
> So... why does not this block uring? You are implementing a feature
> as a bug fix, or so that it appears.

Patch 1 also fixes a plain read() racing a write() (the second trace),
which does not involve io_uring, so blocking io_uring alone would not
cover it. Patch 1 is small, so it might be easier to backport.

The io_uring block is posted on top of this series:
https://lore.kernel.org/all/20261120142116.1630010-1-rmustafin@cloudlinux.com/

It depends on this series, because the new ->read_iter() would let
vfs_iter_read() callers such as Coda reach tpm_common_read() with
their own offset.

Br,
Rustam
