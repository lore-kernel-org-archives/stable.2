Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795436480;
	b=tzDu85J9xbfclz9eALps4VP1Fg1wDXA5VHtoSzUGIHLDwypRJDhBkwbxErmrA5v6v5Uz
	 husRJaxQWQY6kDSqHr2uj6/CRn21PQGCrgUf9o6Xs6eSMPKQ42MUNEpuXdqt8F4DjmW0W
	 25XVBeySp3Ge3ek6SlgRtHOcm8/KLy/DaYFuBON6tQ9bDQ+MBDUQztE7jmnB22nSpDoA/
	 dbKEYr8iAcxUanSEAY/uAKppImGqoi0CYSWgoBAC9ag8noGZY5y22RFcjFsw+VIGQXPXA
	 A9Wgdhrp0FuG0WIDwT5ebkrnAKyqaIWVaocr/0dncEY12XEZq+yRVFJQcoVY4XhD7QQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S+3UY8YgKHQ6r6HwEv6iZIETGtvYvXbZwkM5LcLCzD0=;
	b=HUidrFszyYZy7tz+7tK/NlOiPG+1Z7jQZG5kyZeInEy1Q/ckaoWTNTLJx36oUlnCCZYv
	 Xpu3oO4F6/SaQWWVZhELMZcYH9F54bQarLTepqz0327VNpfhrW8/xjWt09xcrldqh1pK4
	 QMS5nP3Ri/yy+RrLYzTmueXnIgOO4sGbdjXgCnPxI5h/RXFwngcyklIrYKNVf7aKo0ltD
	 nisH6HiFnRJBRVt+QuckXrMAemuN0Cn0MLaMnFjyCaxDZ1tei9Ai2Iadc6KxCZ0gk4rp+
	 aUZdWiEW+cBZsPOcKRCLV5go1ibdxj+gDEL6uHoQzNf/l5K+x8Ki690A/WKWuBk2faQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZNVMMsr8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E6606A681
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D8E6606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZNVMMsr8
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f020d0169eso14276295ad.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 04:21:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795436479; cv=none;
        d=google.com; s=arc-20260327;
        b=iBozyRwgRRhMzRXM0PjMCM2bYW7ep5dLXcKixsOmcczEQrxOf9AiLMPGmlAtuKXIFJ
         YGCIR0ngADjfCC0V8edek3jyxFLACvLHoSb1iEjTcXntS+otRAvZmAbTPeHq/nkBv6wJ
         cyI+Q5iuQIOvj6L/uaZOJhIF6t9GKUJq5cabDZLs5ivNzV6Svzkaa/9Vc0K/ndMUpPpl
         J/ZT3Ns2S5C6zd3PVmc7cBCV227GiMW73AH1vfxJwNR8hINNrHWJMZ9vcvPOTR/L3d+p
         DmJQXPnSbbfqdD4E7JUrWuPr65+nhdN1Jm1coTNi1oZPaDXwyOFWK/m12gpY+fMO6tM7
         d26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S+3UY8YgKHQ6r6HwEv6iZIETGtvYvXbZwkM5LcLCzD0=;
        fh=saIrA1aSKeGzW5VPDhLTse0uJSUePC58xobnFBcPOdY=;
        b=JZQCG7F0i81pJhicaD4bW5f6COM3/vFpl3JRU0V7FCi0mh2RQPmveSPPhE6ohk1BW3
         1TAY6Sn7uvKVtFZvG7ofIGsDJwxPbd88vrdBS9rFH/OTkvH8GUT59QBC9ro7YcQUWXIL
         YygYfAgWQpe9aJlYOabvuirRxCR+anM6ZXHvzYPSK6Hb4S4XjPhp8IDiO9ZrQs2zXMlC
         RJzzsPKUs4gBQzsU4weGsovkduPRyYCKiX4Ownpxx9f8y2P3Vw7j4VFtZefYbOoVD9Ym
         4GP2iNhCIxII7JPM1KEdW9qBgyzeEOKkZqF7qQlh+Stj/SxWLG2ATxf/ci7V6sixZenu
         XFaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795436479; x=1796041279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S+3UY8YgKHQ6r6HwEv6iZIETGtvYvXbZwkM5LcLCzD0=;
        b=ZNVMMsr8xgBZwMHGgf0llTeJT9OPe/PTJydE7JNTVsNbrKYrrUoxDH1Sk2KsLachsB
         JitdI9KJdwsvuHViguiPP70nc8RfB/emZ7AHkz4YQ7lvQC3A7ZVlv//9W+N1A6hf8Tuz
         Fd5otwAJiuQrh9qH7WlLB/ENHnn1gbVXIKbxSly2MKe9ldt6/Twjgx2KjjWVaS1E/W3o
         /VMaZwgTwWXgFPI3GHadpgV3XTiMVIEQaNxtFYajnYqrrNKYrq5HpgYAG/eT1tn9Z7hk
         FAtHCfUGn6uaHB1tOPirI0/ENl9Qs1NoUVExmVhSdwfhZNm7USZ/empOKW1d18rsFoWf
         KSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795436479; x=1796041279;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S+3UY8YgKHQ6r6HwEv6iZIETGtvYvXbZwkM5LcLCzD0=;
        b=NcgqTbWAd4mrLFgJtLSeclsnkXjZ+jBi787XyxqLZt7EG2Xh4rdITi5T7lN1dZRIYZ
         gNLZi+7oZGCVKRb2/DeHDNI73wnxXZKP763sdG6ziRVQ0h2C76PxNyHOpRPYJ7+fkTkf
         2WYMwQBc+Qg9dm4Bt05+sr0ge+H6DNMhZdJkl6uYWFAvfIu6DsuJlhFWQ3Kmap6A325i
         +wYU23VILg/JjGbgvA8dWmxpV4bLiD6Xy5RvUuCrQFkH9egQUaSZx6p4hnAu6iYTiiAk
         7qOcQCBFNL9PdT/QFETo+J3d5pQApLVRqjLChuqGdBX8jZagssuVy4phWD0SE3lDQm0v
         396w==
X-Forwarded-Encrypted: i=1; AL+hErEnU7EXvTcXe3jY9xT+xtuu+mmVDdMyPCD5Qbv6bbhTGwd8PiCPw7UqhvYfoTjbVomYFv3RzRU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9ntHbngbG3/tlnUlkM+op5wfnlhr+lpsYWxcj1WZjE+pIGmbb
	rPzxYg51lqDCqWf84Xc5Li23RcCrjyLHLKD8n000/oAzbsHMcNv9Gg70ab2r5hqVxa4+5/Rm1ox
	eT3AWacx0U3GMzUBmLBfs8Tdket2GdtM=
X-Gm-Gg: AZFdTZckXtILu0vJMJ0lNgBceqDZnOpwiJ+uDkEoEkSAFIYeK2a755SIoPavYYNZp/J
	4FjUHQs+Fb4Y9A6FdAAYB8eXHIVNfGGNLxwjgBNgGB9DFrGuVWiBB3HrKKLYspvNejCjBJauJB9
	Bf8Me6FMtsEjMZL262gC/08QxFvPyQCdIaPkbvroqbloLA43qwgJeSTWXReUAYmpZttx9Cs1kmZ
	6+ExzSOT8pGx4wnDzAPHxeplKshgjl+QzRJF16A2LBj/tOdsb3mkOFXsaCPY/w5KR9/TAu2nEE3
	d7XphzcvBxNblHdWfhhJ4NR+SZXlRvmJQHPfMzn1D12CGSqZZkl2TUDlb9cBsvZZIHzRT49Prhw
	p4i4i1ex88if0KmJ9hxfTREsdDL8BlN8QuiUK48ar2LDwBvA4er8okF4L+dsGHp/H1mse0squ4u
	PLplKsBlacSEDzOC2fOYROnxJnkg==
X-Received: by 2002:a17:902:ea02:b0:2f0:4168:fb35 with SMTP id
 d9443c01a7336-2f04168fe4emr105967575ad.11.1795436478851; Mon, 23 Nov 2026
 04:21:18 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123121325.3137049-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261123121325.3137049-1-bsdhenrymartin@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Mon, 23 Nov 2026 21:21:07 +0900
X-Gm-Features: Aa3M54qZQ_AH7l8CEolFlSvCzul0ZDF-gQS65gCmLYJoMaHRqjccaUQe7U_FBLo
Message-ID: <CA+7S2v+CpMWyD89XQiWq5qC=NPQWFtJ49_7mm-GcxTOCt+gZ3Q@mail.gmail.com>
Subject: Re: [PATCH net v3] net: zero the tail of ha->addr when allocating
 address list entries
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, sdf.kernel@gmail.com, nicolas.dichtel@6wind.com, 
	horms@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org, 
	Daniel Machon <daniel.machon@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:13=E2=80=AFPM Henry Martin <bsdhenrymartin@gmail.=
com> wrote:
>
> __hw_addr_create() allocates entries with kmalloc() and initializes only
> addr_len bytes of ha->addr, but the dump paths emit each entry using the
> current dev->addr_len, so an entry created with a smaller addr_len is
> dumped with an uninitialized tail.
>
> dev->addr_len can grow at runtime and nothing flushes the lists.  While
> addr_len is 0 every addition collapses into one node, because
> __hw_addr_add_ex() compares zero bytes, so the test adds one zero-length
> multicast entry to each of 64 tun devices and switches them to
> ARPHRD_IP6GRE (addr_len 16).  RTM_GETMULTICAST then returned 64 entries
> of 16 bytes, 37 with non-zero bytes and 21 starting with a kernel heap
> pointer (e.g. 0xffff8188_04857ee0).  tun has to flush dev->uc and
> dev->mc in TUNSETLINK as well, which is a separate patch; qmi_wwan raw
> IP mode and the HDLC attach/detach paths change addr_len in the same
> way, so tun is not the only case.
>
> Allocate with kzalloc() so the tail is zeroed at creation; the explicit
> ha->sync_cnt =3D 0 then becomes redundant.
>
> Found by an automated static analysis scan (Tencent CodeBuddy Security)
> and triggered at runtime on v7.4-rc3 as an unprivileged user.
>
> Cc: stable@vger.kernel.org
> Fixes: cca8ea3b05c9 ("net: tun: set tun->dev->addr_len during TUNSETLINK =
processing")
> Link: https://lore.kernel.org/netdev/20261116024056.1274402-1-bsdhenrymar=
tin@gmail.com/
> Link: https://lore.kernel.org/netdev/20261118125443.1137177-1-edumazet@ke=
rnel.org/
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> v2 -> v3:
>  - describe the test setup accurately: one entry on each of 64 tun
>    devices, since all additions collapse into one node while addr_len
>    is 0
>  - point Fixes: at cca8ea3b05c9, which made the leak reachable from tun
>  - link to v1 instead of the earlier review thread, and link to the
>    companion tun patch
>  - note that other drivers change addr_len without flushing the lists
>  - state how the issue was found
>
>  net/core/dev_addr_lists.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> index d827cc21867b..9613c8a9ed7f 100644
> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
> @@ -96,7 +96,7 @@ __hw_addr_create(const unsigned char *addr, int addr_le=
n,
>         alloc_size =3D sizeof(*ha);
>         if (alloc_size < L1_CACHE_BYTES)
>                 alloc_size =3D L1_CACHE_BYTES;
> -       ha =3D kmalloc(alloc_size, GFP_ATOMIC);
> +       ha =3D kzalloc(alloc_size, GFP_ATOMIC);
>         if (!ha)
>                 return NULL;
>         memcpy(ha->addr, addr, addr_len);
> @@ -104,7 +104,6 @@ __hw_addr_create(const unsigned char *addr, int addr_=
len,
>         ha->refcount =3D 1;
>         ha->global_use =3D global;
>         ha->synced =3D sync ? 1 : 0;
> -       ha->sync_cnt =3D 0;
>
>         return ha;
>  }
> --
> 2.43.7
>

 Reviewed-by: Yuyang Huang <sigefriedhyy@gmail.com>
