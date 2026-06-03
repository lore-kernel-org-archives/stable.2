Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A02437756A
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464585; cv=pass; b=g4+V7MoybyVMn8wkFfmmkBwRyvBvwIRxB/6k6nWU+DSuWGIx9IiwY0yknVKD1omL+HmFXKh+xdT7aRmJuwS7Ifeh/z8vZnDPjxdtT72wBiJiumfK2Lgo2AdBR1wZCiX7mqkK1AYpvRrBCLQHJghBEnbJJ7zG1/38F10NyhRBGzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464585; c=relaxed/simple;
	bh=VcM4nuQ2hmvuiM0bqHjX58fcri2ACUFgOliK/mfNxbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IumTQm6pqwbbcgRojr0Eu+HJ1P5o9Sw6kU4zta1KJ+loQbSWXHqTz1d/qlgWJA2nxhEg2X67fptRjFgsNfDHIPp9orHv4V1ixRH7aIHaAMcwxkCTxR50cXpuGhiINsrPHeHan1hD7rB2MeBqD8KZ67Pp1rQLp47KDHnshF55AiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2jm6rRI; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2jm6rRI"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66077f6c438so3323117d50.2
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 22:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780464583; cv=none;
        d=google.com; s=arc-20240605;
        b=F/L3emnR1p7EyvEHi7+zCxK36QYSy6GHRP9L4grD4a8yZDsdbicDkuNB1a7x4gEnSk
         jbochQ4AuGjto9JbqkPN8ak5Z1rDkJhkJZpQ+b/Pb+WieU+g6+8ONSnsB0g++J0me7lQ
         TZbA1G7odfqD5PVPYTkAzLF9E1xXkolq1UwHN9W9UMX+kzB7s33LS4v0jtvFHbmpcQ+a
         1/K/mgo4mJ2yCIcp8wjPiQmCVaQ+Y6LgxbYkvI3Ceyr+Fy4Qh9uHVdHyRIg5pvW1cRpd
         GmxnLkQwjrV7EtgCTcDqAVNZMV6Uud1puhntwmVIuXrk5uLMeov8R+fhlzzPa5foMfaf
         jMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VcM4nuQ2hmvuiM0bqHjX58fcri2ACUFgOliK/mfNxbk=;
        fh=ECPKrsA5uGSb731Tg6+f5nb5N0CM60+Gr1lf/x89nUY=;
        b=P4i3oQ7s8LDw5DpJjediEJgqcc2lAjM8Fb4tlJir5hglA77U9XGEGrSmQFRhXiyTI4
         GLf01+vHjzHONGgJ1lZ1ptyBWdh5kBvz7NW2epdluem1XCrFx8NCjIL+7tnuA1W2shA1
         OElRZLyg1MquZWgsinOU4Ud2ZG2SnFEg8tg0zOrNzZfSaVR9LqYpAt+55w6Jo/lUDHPm
         f3Ofn402ji1ENU+1CrkauaDvDzrcVEbcIHbwpprmBDhO9S1HN/jhfO/xHBZHFJdCf9AI
         vk9QF2d3yY4hTQPI5A6oR0Rvdcr0oSwZoOdOz3HmdTe4aVKonxM4lxSA7M8mhfuf7xWa
         P6Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780464583; x=1781069383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VcM4nuQ2hmvuiM0bqHjX58fcri2ACUFgOliK/mfNxbk=;
        b=J2jm6rRIZj2zRdB8XCHuo9IqWk+9TVP+MwA9DrupQ3m7exO4eNX3O/6iDvr7axLuAw
         VaynVLRzB/PP/0R61WveRyPuxbuLRgYf/L6RaJVb1XMGE5yv8lHl9jEuFK9mYGsghNUW
         0/TTB2BCJjNyFdKekcPHHcccx6Y4amE5oJNYnp0Z7s5QvXQ4QaOmi7FyidU2OCey/IqX
         Ys62GRofGN9AqMX2pJosjZqZXsQSROGSlLWbCafTkIEIQpXPwiR3XobtXTTMRB2MJmG5
         zBAd9Rm85DUzxz7qm3nL99QyTft5ndxNcsOsB1ldoNKGtmpv2gOzAGMhqlRGIWuUF0K7
         q+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780464583; x=1781069383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcM4nuQ2hmvuiM0bqHjX58fcri2ACUFgOliK/mfNxbk=;
        b=cUMpAiLzFPPRmPWCKxAmGoNR5ClNX2IJSyT79K8zNVmy93LE0Br03rLbklrPG0LSbv
         L7o0qfBczD6g1aUAAOr/M6AexEBJG8eIWyGXbl32q6zInS9liOxXf3Dy7PixT4p+J9ts
         ydQH8w2EIPfNDZPJotMwW56+aDgVrr0Cv1iuSarduQUaCYzlICdShWjc+n1JLAXi37kx
         uW1eWkOzysZTFDI3xBdIqqcLLR4XGIled3zW75MiTC7qXZTrUESj+RcT7yQevFrzZj7w
         tqrbqssar6AJ4ilC0GsMqn5CBX5xG8/m0moBR3FFdj2yGtrQOSwxsMAHvrWj9MHrh5Ag
         bIDg==
X-Forwarded-Encrypted: i=1; AFNElJ9qWnIPeWVAO4xg7ID8Vw65UE57E62TrZwnRztVlFouDn4Djm6+3fkCTRaGonmywwtgMUQvEK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOrChGs7k6AFO+A7tceyQdDS8HQpz342GGctKXUSlzYOjwlXZq
	u8quxblWkRYDFsUWij+WTpv5e/PqTcJXq7IQeamWlyHowTzp7fALZvf3XBVn5nuBsLXK1MzO8kb
	anGYlLHMugmHt/KT4V0AlmbIBlEBS5vk=
X-Gm-Gg: Acq92OGyELI49za6er8AP2wPSWQ8XIUNBp+ErJ27X4JIJ3H5yu5cuQARRixZuvhJdZ3
	gcls/qPRdyqzy6qnsZq60ftGoSrUqSE9xqbirLjMe+odKOYnw6B+aWJWZY5cW/0iuxoKFUiAIG8
	oW1frwl/yMd8/09wvPffwPladWWP8nD9ZjZx949vIJAp3zNWZUhjWIgVleuWnF1SzmRZrLmdcm4
	mzRLvD2PttOIqOsAW4TVU/ncXijFtB0I/xH/RDx+jTt7CKi1+6VqXsTL4fv8+Vjrf0T4w2PNEya
	78RKrHmtBSlLJEz/aNnr
X-Received: by 2002:a05:690e:408b:b0:651:b2e4:63c1 with SMTP id
 956f58d0204a3-660dd530b47mr1468054d50.22.1780464583418; Tue, 02 Jun 2026
 22:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602155210.90987-1-leontyevanton1995@gmail.com> <BY1PR21MB38709E89497445EECE3C931DCA122@BY1PR21MB3870.namprd21.prod.outlook.com>
In-Reply-To: <BY1PR21MB38709E89497445EECE3C931DCA122@BY1PR21MB3870.namprd21.prod.outlook.com>
From: Anton Leontev <leontyevantony@gmail.com>
Date: Wed, 3 Jun 2026 08:29:41 +0300
X-Gm-Features: AVHnY4JnwoCsNKa6ADnSbG6NTG6nP0KaPkNGbMnFr4WC0wsdE_B23uevxeXo304
Message-ID: <CAAN-wAkSjVbfzto+Pi4-OLt2vXyzeCNpqhen2VQFA+VCFH2HrA@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH net] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Long Li <longli@microsoft.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

>
>
>
> > -----Original Message-----
> > From: LeantionX <leontyevantony@gmail.com>
> > Sent: Tuesday, June 2, 2026 11:52 AM
> > To: netdev@vger.kernel.org
> > Cc: linux-hyperv@vger.kernel.org; KY Srinivasan <kys@microsoft.com>;
> > Haiyang Zhang <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> > <DECUI@microsoft.com>; Long Li <longli@microsoft.com>;
> > andrew+netdev@lunn.ch; kuba@kernel.org; pabeni@redhat.com;
> > edumazet@google.com; davem@davemloft.net; stable@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Anton Leontev <leontyevantony@gmail.com>
> > Subject: [EXTERNAL] [PATCH net] hv_netvsc: use kmap_local_page in
> > netvsc_copy_to_send_buf
> >
> > [You don't often get email from leontyevantony@gmail.com. Learn why this
> > is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > From: Anton Leontev <leontyevantony@gmail.com>
> >
> > netvsc_copy_to_send_buf() copies skb fragment pages into the shared
> > VMBus send buffer using phys_to_virt() on the fragment PFN. On 32-bit
> > x86 with CONFIG_HIGHMEM=y, phys_to_virt() (i.e. __va()) is only valid
> > for LOWMEM addresses below 896 MiB. For a HIGHMEM page it returns an
> > address that has no kernel page table entry and lies outside the
> > kernel direct map, so the subsequent memcpy() faults. As this happens
> > on the transmit softirq path, the fault is fatal.
> Please include the stack trace in patch description.
>
> > A HIGHMEM fragment reaches this path whenever the page backing an skb
> > fragment lives above the LOWMEM boundary, which is common on a 32-bit
> > guest with several GiB of RAM (for example when the in-kernel NFS
> > server splices page cache pages directly into the reply skb).
> >
> > Map the fragment page on demand with kmap_local_page()/kunmap_local()
> > instead. Using pfn_to_page() on pb[i].pfn maps exactly the page
> > described by the page buffer entry. On configurations without HIGHMEM
> > (amd64, i386 without CONFIG_HIGHMEM) kmap_local_page() reduces to
> > page_address(), so this is a no-op there.
>
> So, on 64bit kernel, it has no performance impact?
>
> Thanks,
> - Haiyang
>

Correct. On 64-bit (and any !CONFIG_HIGHMEM config) all pages are
permanently present in the kernel direct map, so kmap_local_page()
folds to page_address() and kunmap_local() is a no-op. The generated
code is therefore equivalent to the previous direct-map access, with
no extra mapping cost on the tx path.

The kmap is only meaningful on 32-bit CONFIG_HIGHMEM, where the
fragment page may live above the LOWMEM boundary and the old
phys_to_virt() result is invalid.

Thanks,
Anton
