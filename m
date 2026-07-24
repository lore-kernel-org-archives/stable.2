Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C54457AC
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905568; cv=pass; b=iauekRNB3egUmlvRtDFotpaAAANr9o2NGlCd3QDncKtpNy1mqbSI/qMzW4kJ7d9+R5/dx2t1FjgMxtGEae207dzUE9qanZqJpDO2IbQdPM9XXmUcMXdK1TVVuPIY54aKQQCacXroouN5IRJ0di+1CEfyLhPDhHp4Y1Xy7WOuyUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905568; c=relaxed/simple;
	bh=I2AhTyeN3QRdL8SRsF8YtEzSAzEn5+ptNy7HN5yACgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VS46mvZdoa4nGm5fAV8Uxdg4Zl+2cKfkV5dFs7gs2ij0edFvIZwtColSf9W6DmWztHIJbFHJyo0q3XeWvj0TU219HSG+ya3nKM3Lf+3mBz/Mmnxq0j5vL1LyzBbczrVTIlAezPxxxtgMs8+tupQVowVFL0jAe5TMTOWbugUWrGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QmcEQY5m; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QmcEQY5m"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cab97c86bdso87865ad.1
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784905565; cv=none;
        d=google.com; s=arc-20260327;
        b=cp2L08Eer2NpS3raiuFhAJ+DaQmkuYmCLb2/KbRxaFkb5CWU3P4/4BH7ah23hgEWrF
         3kIa+4U8ywBL6Sgob3cYF5zO9pcrzyHKXPvHzGRDVnfvabegb9ViYeHd3VGyWkT5ytM5
         FaXfOD5xBK3ye1bHGAGHB96GiBUANExEgrUB0AgDhA8m/AzS7NVgD/LAwlb4O4ZHSuo1
         8Ogc3j1HhZDNXO2ZofLYLzrg1jkNt1skJ8J1uAjgvqzeV6KFH45KQ6e3NclmFXa51Bzc
         qglTrsukAfmFKl31R1xvvsceJGUHVF2Bu41hXbGxOXuMsm2Vt/nEAoWD9pJxwE/pDNxx
         SvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I2AhTyeN3QRdL8SRsF8YtEzSAzEn5+ptNy7HN5yACgQ=;
        fh=l13rI7Yz9v55tYoeFFFtl/swkeaYJx/16UmBLj5fcVw=;
        b=J7wXqoJvg9l2mfmGoNcyyUK3s3KouiYNqFpXkTcOZe4CK/5iXGxoWJOQCkelN6Up1R
         VDvG9BWZv6zgURNWSO3UZ21WiA8P9LTlM2V51vT9aYRl1WMBan7tgMRUk9ALj6Ep7UVo
         4A/PvvUGi+OVTdRci/YwwQx33N+IGhXJvM5zHeuiK0cAVO8aXgkTudIZWcutnw94KcTg
         AINJvGtoKb3eModUfZNSqagzaezP/II3OtBeimvmeAYZSbDUGqvNWvjX9zcja7ziTab3
         PUoLrHCxeGu48JqTh70erPD+5d9203pjajCJ9KiaTVGQwjl1L0DaHi2z0bRwuEurYtW+
         sg3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784905565; x=1785510365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I2AhTyeN3QRdL8SRsF8YtEzSAzEn5+ptNy7HN5yACgQ=;
        b=QmcEQY5mzSsOHqpAYuQdLkTt3hXzp6ENcX3MU+pcHpUaFux9hmDAiBrkujOWmSy212
         GSRbwwgTHBq3oKRdgRdsEevFPh/TtzOnmICS2ssYvVaxXb4Exer+C2SNVIqjRWmV7sE6
         uCM+6SPDBRGqHN3jOSSHC8Pl5CMBjajsu6pmYuB7VrdDGCfVczsO+t5r5NyCMBNwMAqf
         8FLbAqC/JD2l0KspXY5LxD/HYogZKWrTvKHGDNIXqUXZ5/oBjUbdN/ZP6ubocSFv3hKk
         Pdn6+71YBFBpVXO+DIQ1HkAwobhbsSVpchLZGRGpWUh0ipYWVbSCUxu1Y9lJe15RzebL
         VUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905565; x=1785510365;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I2AhTyeN3QRdL8SRsF8YtEzSAzEn5+ptNy7HN5yACgQ=;
        b=RG3dytRRSY/x67TvWQaQh4XgJpE7Ec67T1olgngsFxRMZDe+VfuNzgxGo89iKhK1mo
         bw48luQC0ViphVftJZAvT6HSpKrcmMABHQy+Dw31KBKK/I6sFs2HA1aR8e3iXJ5mqa8g
         YOsQsfLM9IQdM6A05Y67xotWU4PVdqvApO12+tceW9EX8q8qbNrroDYzhGoXAoUfIuqO
         Fd7vsTxgCDCXc/lkytpgOJ68H+Zdwj7FnsV3OgRrk9Whg+v434tBNs3dZFCocR3sF8Iy
         gehkNQ6knMCvy2Xb46AvPHAABOhOg445e4J2OFu4wphOOVQMB6qECJiEpFBGPdDcDd7L
         v09A==
X-Forwarded-Encrypted: i=1; AHgh+Rr9tMcoh9Hi0LCHUs5TK+IeIUJxa7V5/Ro30edEd+qa6FvHz1+lEEnMgmGWHYYAAjr2YsrY/Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6EFAUEDAtSopAW1gWzgDywYLmwoGnpps3CltphZunBoyJ6pZ+
	r9g/YhaSOEtwDTjzoy1FVWTagUsYxgt+d2uJ2GQRiTD9f7H7kpWyKgczKD5j4K4uUpF9YaUAV/G
	lbpvLJSmsfR5fR6AbooMFQRtoBGRethTbk3Y54RXx
X-Gm-Gg: AR+sD13vwrYMFqp0+bkj4lYQSw9iUf3k94rCTDE+7zFNhJBdHfngjSsNM+H829FN9CV
	GLsd7M60iOHKvGpaiZA+9BG+PNG/0p8R/A/X7MJjGEgHhfrMahwK/rVbv9OtPmnqS13DIZ4IOui
	FwLgbOi2omxI/zh45xgdJrkDlmqs8l1IEkaOEMBSoveOui8WA4UfhEW4BHNvDe4TRZKSLYVdzC0
	lQfZ5HSousbRq2oLmuWkcjPqE/zXRWr8NNpU9P3TA4sqR9zmlJzGBlLkd8p8g==
X-Received: by 2002:a17:903:41c3:b0:2c6:a078:bfb7 with SMTP id
 d9443c01a7336-2cfd0fb3585mr3755725ad.7.1784905564254; Fri, 24 Jul 2026
 08:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724150156.72816-1-doruk@0sec.ai>
In-Reply-To: <20260724150156.72816-1-doruk@0sec.ai>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 24 Jul 2026 08:05:51 -0700
X-Gm-Features: AUfX_mwLgnAT3LWQNCfXsdDgeg6v8reQG-fWkKN1sEa9xceCtFPXGiiL_UvIO_E
Message-ID: <CAHS8izPJK1wm0a2FQA7L-fjKc9pLiqYBDyf_GEb_AvnBL49gOw@mail.gmail.com>
Subject: Re: [PATCH net] netdev: require admin permission for the bind-tx
 netlink operation
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Donald Hunter <donald.hunter@gmail.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 8:01=E2=80=AFAM Doruk Tan Ozturk <doruk@0sec.ai> wr=
ote:
>
> The netdev generic-netlink bind-rx operation (NETDEV_CMD_BIND_RX) is
> flagged uns-admin-perm, so binding a dmabuf into a device RX datapath
> requires CAP_NET_ADMIN. The symmetric bind-tx operation
> (NETDEV_CMD_BIND_TX), added later, was given no permission flag. The
> netdev family sets netnsok and has no pre_doit, and
> netdev_nl_bind_tx_doit() performs no capability check, so any
> unprivileged process can bind a dmabuf into a netmem-TX-capable device
> TX datapath.
>
> net_devmem_bind_dmabuf() attaches and DMA-maps the caller-supplied
> dmabuf to the device and installs TX device-memory state, the same
> class of privileged device operation that bind-rx restricts. Gate
> bind-tx behind uns-admin-perm to match bind-rx.
>
> Found by 0sec (https://0sec.ai).
>
> Fixes: 8802087d20c0 ("net: devmem: TCP tx netlink api")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>


It's intentional that NET_ADMIN is needed for RX but not TX. Maybe add
that to the documentation.

On RX you'll see any received packets on the RX queue, so binding
memory there is sensitive. However binding a dmabuf to a netdev for TX
is not really sensitive. It's the same as sendmsg with zerocopy more
or less.

--=20
Thanks,
Mina
