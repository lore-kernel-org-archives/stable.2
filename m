Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794362419;
	b=YrIUh7rbFDdBEtzwnoqmbpvvw/YG6VV9Ib9937W6v6KZNm7XFtWoVZBaKab3sgo/3Wt5
	 UYH7vtHJ104IxptIXiufYJApW9bADhe7nnOdtcv8LhXCUultLg8+6hqceD8vi52sVmSb2
	 rM641evppxaz8hl4QkM3ZOhnc826xw0DntxpUT+6jpahKyTJPBealoEhrTfrXUIBchTUB
	 LxlW12uJPo95TTTd2SUR08EW5WzbTalIrTbVIUrhy1yWJcdwD/iOadVOwBjzsPIRJhsq8
	 mHAiUxxlDO5Woa3mjCpCnzViv95x5eT7AdPePR9dzrWVmXTyiPpuGeW1jl2lgnqBY9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dtC/s3IFvRHvWLM5ctW+2r/vaRjYMyyM7FY+73RqcL0=;
	b=TgUDjVRILd/7HSBYU3JA8NH2ut3GWUneM19w9gGr3Byf8mS98LK4YbDaE+5453bsUwNs
	 KCLmx5qsE0hQujqvrPMV1GcTSrrHgd56p5cEC4DEr+FXB/wlganiJcIlNg+3W05Q2AN+c
	 lb96uSICpnusi8Xq5IlfkCZrcD5yemMe1bjg7IVasrM0mU/lETYY6USye4crH9yjCl76w
	 FLGRBBXlloe/JQhDVgmAPIkfTWqPTaP3IzycfAyDaL+0F5Wo6ub9IRte9/5fYa0ewXf4S
	 HAZiIYPrti5CQEgj5CfaHPW8zUqVEOUXcDfskQvyr0Z6cf18d5Wkpk0K6kBSnaRuqtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bvRxWyFG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16F606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF16F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bvRxWyFG
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-37628596783so1371809eec.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:00:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794362418; cv=none;
        d=google.com; s=arc-20260327;
        b=sOAq2SCBuB41J+nyUrEYOqurIqDwkPDeHQDEgV4W79L7y6YUatU3f+iGSG7c93Luc2
         3O//KEhjQmLTon36dkTOAN7WxR7RPG4yb+H6YClUQPlf+uDib7DF1qkoUHhhoobvpGZl
         GF3NKkYBkgE6fwX7EyjJFyrMkL2UVtDlTM452FDhr/b4TEviT/c0mFh4GzLSzRFb1ley
         wvNzW0pqitUXX3nd0EEycUuDV2dK3Rvzh16azZ7ML2onlrzv7UcTI3mXCwmBgCNBMnwy
         unJ97rSDv9FmFINyTqmzMFUtvDARuWAMjg2UMhSY/irtmNkU5hs4XIJlHtNFG2MEKr5Q
         UV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dtC/s3IFvRHvWLM5ctW+2r/vaRjYMyyM7FY+73RqcL0=;
        fh=qNWh+ru6NbCwfNNCgJrkV5rczwaUoBb5haIi+2yuy00=;
        b=iPscbXgqKVP7yMg33WOw7tFtztfleoAvXln3OTRwaljHrlrBu459WsJtUyj5ywgxwn
         1lU9QDQoSzxeIRTAKmZJWKJqSAjf0CFMVv9zb+nhRCoOo3lCDzSe27bBAPQKnJXt/S0J
         DTbO2oek3vRghYTWzpE8tcoHqLkZQRbYIR+GXmHK30/VDm8x3pqVBMRVh46g2QeLWXej
         Ibyr4Xre2RNrCokpDJ12Fwoc4d74KE72PJWz6dNdC2Iu6vhiBnAcf7db654Tv+2RO2zA
         3hGILAoziiF+JUJ/dUCjkqzN76SyqoS9HoYlP4itr3iYwyKwshi/mimhMfWoJ8F28Ij9
         qzGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794362418; x=1794967218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dtC/s3IFvRHvWLM5ctW+2r/vaRjYMyyM7FY+73RqcL0=;
        b=bvRxWyFGwXzDLRtpU1+Z9VJNOOTsNT0608bHW+RTaiPzND6oFBDN/qWqzndR17T2BR
         KCn2IxPjarwRv9oaQoFUKWSwijRbWm+Ow/iXOOOwmli3lH/82MX/KzxoaWKZZ6i+8sH6
         VSE+pL9SIqnv3FAUOwjgnW8gmHuWeCZrlEpJ23fPmxEg5iNQEDg/aT7fk9g6AJbLLIlE
         d8n7kLo5VHvrtvzQZMdpAS/M2Ts4CtOTuV1imvMhxXAj3CB9Nh6Qjliw7Vqa7KGEQJBn
         tkNmJAwzRm2nQGjbRs6YP91uy4RcGAA+nuSwDAU97BQeflbNLcuTmOVJjt3Wizl3IkyC
         3W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362418; x=1794967218;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dtC/s3IFvRHvWLM5ctW+2r/vaRjYMyyM7FY+73RqcL0=;
        b=N9vTEwIvmSQgpIM/goxYaW0h0LTlQpBVvfzdku4wZAyeds2ehTRJS365/7sqWEu/p9
         IVllp0FP3sTviW1nh/Vw2k3dwitvniDyRCemv03iuTDdsts+Fx/sKHv/zuFiKDHjLfMt
         Jym8rVJSFtX1IAl4lorCqw7/4EZbdLwxkOvWK4lHje4chaEEmLpKwUREp95CjwQTSJza
         c43uukBmVSj22xDQzCgQaXUVrnIkW2NhekSfIs1mqIdbfDZyunxDLmvvfhJnEkyMidgO
         uZoN7r6a8PwhXvTyyY09CYs1GDvYaZN8edzegqSPH+kMGpl6PQocXAvIT1wy0/QWYZCZ
         Hnew==
X-Forwarded-Encrypted: i=1; AL+hErGASocJcNumnPcoI+PVUz4bstrtn+UlMghlFoeutLhxyaI7b9rVAS62OpVXOWuJW2qLwXz2Lto=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fEXjOoRu8ScnsNFw0qxatSfjXQ7Rcg5T4HbQkYaoTPHSV34dd
	QRSgg9jLPuB756fzlLyfZgKAIkwvJ4O49XNRCT74mh0Y8Qd5uLIkulwKsENy33JWBUq9WP3XdnK
	wDqHgvh3CgAF2XnCi+ymy8bWTUrNXleM=
X-Gm-Gg: AYBFou1cFcWHwMwXSxdGxby0eOZYsaWpoPkLhH8pEmgX5KoUpL4s5VKnO3gTAGe/uwk
	stWFR1U+TzihaeTMrNkY6PmP76GidbJd5FeJIccSzhClt2ccLHLQ2YnyfO7WdfuZ7c+MOPBeDfT
	QNBLJlU4g2VBV1jp3Q5a0vjYEr89As2gvD96KHx+CyJdOUIhPivlJCL/VorDBQQMCiZZveAJ898
	nabzTtkFTK5sb2Xl1V4VvLxsTcz4JkgCLNML5JiVjtS5xCMJDvXguvI1aEK5lajQ7NhrK2KwmNC
	HH9oHNpBfzi/Vcm9m7dQeC8ZTzOpc+TmdQqBuZxQ8M9G9egBA4SKOs4DzgKjlaI92mEN07qr7PB
	eNbsI4xpFs8C69Sr+3QX30GfuT2I8UNjzVpCnO7m1JPifbRJ9TUOf3LIedwvGYdxLzGB0HPzsBa
	ORpMdgnqSYIp8eyFFrcqu784jbzRU=
X-Received: by 2002:a05:7301:795:b0:36e:e349:f2cb with SMTP id
 5a478bee46e88-3768579dfa3mr1470248eec.19.1794362417519; Tue, 10 Nov 2026
 18:00:17 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-smsc75xx-rx-fcs-v1-1-4e048bfc28f3@gmail.com> <137b3cc5-7077-45d9-8ba3-ea4c584f1992@lunn.ch>
In-Reply-To: <137b3cc5-7077-45d9-8ba3-ea4c584f1992@lunn.ch>
From: Joas Antonio <joasantonio108@gmail.com>
Date: Tue, 10 Nov 2026 23:00:05 -0300
X-Gm-Features: AclHuK8ROedb8-shxTvKJCqZsFUqIT-32EYB708a8vtoB04n-gGoY_3AV2iFUVI
Message-ID: <CAOCBhwFSS_weykmFvmHQJ0VuMxW-dxHytBn81rn47wfWwnsV9Q@mail.gmail.com>
Subject: Re: [PATCH net] net: usb: smsc75xx: reject frames shorter than the FCS
To: Andrew Lunn <andrew@lunn.ch>
Cc: steve.glendinning@shawell.net, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I assume there is soon going to be another check to ensure the frame
> is big enough to have an ethernet header? Can these checks be
> combined?

Yes, that makes sense, thanks.

Looking at it again, short frames are only half covered today.  For
the last frame in the URB usbnet drops anything shorter than ETH_HLEN
after rx_fixup() returns.  The other frames are copied and passed
directly to usbnet_skb_return(), so a frame of 4..17 bytes (0..13
after the FCS is stripped) reaches eth_type_trans() without a complete
Ethernet header.

I will send a v2 that tests for size < ETH_HLEN + ETH_FCS_LEN in the
one place, which covers both the underflow and the missing header.

Regards,
Joas

Em ter., 10 de nov. de 2026 =C3=A0s 19:41, Andrew Lunn <andrew@lunn.ch> esc=
reveu:
>
> On Tue, Nov 10, 2026 at 09:03:21AM +0000, Joas Antonio dos Santos via B4 =
Relay wrote:
> > From: Joas Antonio dos Santos <joasantonio108@gmail.com>
> >
> > smsc75xx_rx_fixup() takes the frame length from the RX command word
> > supplied by the device and strips the FCS by using "size - 4" for the
> > allocation, skb_put() and memcpy() of each frame that is not the last
> > one in the URB.  The length is only checked against an upper bound and
> > against skb->len, so a device can report a length field of 2..5, which
> > gives a size of 0..3 after RXW_PADDING is subtracted.
> >
> > size is a u32, so "size - 4" then wraps to 0xfffffffc..0xffffffff.
> > __netdev_alloc_skb() adds NET_SKB_PAD to the unsigned length, which
> > wraps back to a small value and the allocation succeeds.  skb_put()
> > adds the length to the 32-bit skb->tail and skb->len, which also wrap,
> > so the skb_over_panic() check does not fire.  The following memcpy()
> > then tries to copy almost 4 GiB from the URB buffer into that small
> > allocation and writes far beyond it.
> >
> > A malicious or malfunctioning USB device can use this to corrupt
> > kernel memory or crash the machine.
> >
> > Reject frames that are too short to hold an FCS, as lan78xx_rx() does.
>
> I assume there is soon going to be another check to ensure the frame
> is big enough to have an ethernet header? Can these checks be
> combined?
>
>         Andrew



--=20
Joas Antonio dos Santos
Cyber Security Specialist and Ethical Hacker
joasantonio108@gmail.com
LinkedIn
