Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794410153;
	b=b/lvPxuPmOnh1OdGawXsuZccjvVoMEe9TgYJGLR+8kbXfWJe+kPTet4zAohfD14ioeW8
	 /+pMTrqY2mW9KwRbd/bCpbpCXBK0jLkUdZ2DwaHG2JDRsxk/JpzSsmMNZ2HTKzFeTNILB
	 WajTXEOM3AzfxbWehlIrA9StZDvE4EJSDBopcWOBkGbemyn3tuZ5g2swvtNmg4GFIhrHX
	 rRsooMqMRkB5abx/hEUI2lSvKYmlo4tU7nIx2SoH5AmoZ3VsfZGzn1swdPHMTPsmyPNa4
	 r4aDLx9T2AKcxelgTm/EZ7hwFlpByKxo8CGtOj53qkJyFtLXd2j2hNBmg4TGpfvBsWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=12qva3kO9NMXV3ZjsX8ymdd40I9ua49Cy0e6eRmwhRg=;
	b=3jE6QoRAHL1UIkbEu5hxgo8hCr+Na+asv+Li0TUZ5+2yboAKhutBaq0GQOPCrlw8QDPZ
	 qJtzuiJIUqsI+FnX9g6gT1GkOG+u66+W9daunYhFXrMXdjY7o2oAtkqE9eItuZ/PUmX80
	 Zzp8i1VjftqYjStq0eU4d26GjiIHeVkxEqQVfn4r/BTQb1/ETiXkH/BE4DZb0HniHG1ap
	 q86XIcEv7PGEmWAFm8hjK6rTcaLjPTqeqrUlzJ9CRSZpprS0lEuoBQe2zlW/CpY4yZThu
	 SQGP5ap1EuxGXdHHHKUfkneYia2yLoFnL6FOKE6SzMGQkvQaqO0UObJcKnRyEp2UkPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MqTZa1Co;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67642606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67642606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MqTZa1Co
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6d290b10a35so1329511eaf.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:15:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794410152; cv=none;
        d=google.com; s=arc-20260327;
        b=TRvYdAD2egypNPUA7zcR1fofM4Vlhw2ULwGqFQyLEMeNjLSDP8nNWVGMcolpmt/dX0
         IFK70dyJ1ZwK8Q5jw+YkUUwcswBfoMCaSEyDBiO2jEu8Jnt9qzv8kRHzYi/b7uMp+EbQ
         GhlfXkf6s8NcLPiHEGCuxYkcTQhuZA/rf/WvQwef+UJiC4gneDZt8+mKVGlJ7/lKcmOr
         eBGD1q9RVLli3xmunHJzhPckSr3RArpGSlArv3ifwxN+V4nCQxgUPwFlwMBxs6NjYFV5
         W5v1pjakRLIjtvmovpk8LyX4drnP7mF1cA0+NCuE5fZIGNPxqNuL46zwqker5dPHCUgD
         jy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=12qva3kO9NMXV3ZjsX8ymdd40I9ua49Cy0e6eRmwhRg=;
        fh=Qn1nBKhrkgufsknsxmBVzBTckyfaTl0APy7EOy9Eofg=;
        b=JvDtfQNXGO8PT9ap2C8FmWyrR/N9c2LMrMmLa8LiG6uU1g4U1r6loKo8lj23Mrj/i0
         r17PMG8oqmnZn5VGOGExvfdoeQobDPv3bWldugGIL78ciacAu2lS8TkxDrjrsfFxPqTV
         WN04zsEOP0X4uuxeI/BCUe20kByNT8V99Ryue0HZdnjhobPFhSmQbNLbs34FDWfe0VHr
         RjioeqMvKrBgm/Bz/fH4Ho8Bu9F4XKNCQeLXqCe73m/vqn9un+9H6hGAShIMmlyuWGwY
         sSmmavCnkEq/iZtiQ+tsKRNiGewVExJnnxERX3N2T9Cwu8tr/wV5s8pg6Dmwr0fxfNju
         jITQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794410152; x=1795014952; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=12qva3kO9NMXV3ZjsX8ymdd40I9ua49Cy0e6eRmwhRg=;
        b=MqTZa1CoC8/Oi9lstEeTqcF692a0bT+fIapN4rv19/TQHhwrz1q0ulMKA2wMWg1mXI
         jm1bE17u6V/U05pmSrgpCLVMzWh1S8l/fk1Lmy0znbgHyB3Wq7Ya4GFh6F1uN1JlYp2U
         aFzFej0+eeLFPwQBJjbJITFPErKDXki5IkFPhMyRvEengDJJwyPy2WvhB72tqnL9Gn5w
         1XTOaHkElyQKa20nHI7EoxL+BApLl8G+POluGQBHx53OLEzZjGpcDT2UBko4iIUaiFSs
         nsoNjOMiRC5y+tmBHF4KmEc47foCT8XCWHJ6+U4peSj5GKGk8iNub6GtTUNX3F/Cydq+
         jHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410152; x=1795014952;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=12qva3kO9NMXV3ZjsX8ymdd40I9ua49Cy0e6eRmwhRg=;
        b=UkcEutqJu/07FfRWAQHqfYTHiXBl6ll2WorJCzs9aKK+cVS9H7FbVF+s8tnICHKBHZ
         Z7KKkDzJY3X+xfNZ5g7W9iH4ROiMr7HXczbqBxJ2WXJ0MN4PpTUMRIfq8jIgeB/VGmbU
         GYK+ad9hCgMgohnGw3B++DgnPly+CiW+tlsq9uysLP2tlOCW2ToHNQYQ9yblE5VV2S7K
         z8cdDIazewI20IXFEDan8pNnwwuVGC6KaNkY9gE4AvvHF2c4pt9UPtuH0S1UCO+MCLWL
         gIluYO5IG+4/RJdTFRrsy6btqWQUQbwEhWo6luK7Coudi78Zp48/PKICZ0Qe96nNAQ12
         1SOg==
X-Forwarded-Encrypted: i=1; AL+hErF5j1FcR84OQOTPEpbos3y3YZItClSU/fbWPtZJ/DnccR+Y+XiYVjjDefeUBvC9n484DCfvDHc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OswVn12l2Y1NCtZpTXK0ndaelvfZSlJcarVdysG1v9iuRLvTf
	BOpCfPww3byJREpiwBqqm38sWspw9HKW39DADA+HSaZA9V0cHmc35VFZms7/Y9dp0MiG0pw0rSI
	+L91a6GC8/Nh0+rmoHN1kt1acbidkHCdxEgJ84a04
X-Gm-Gg: AYBFou0OH8ZUPgJH20ltYfQzz1GHsGtDkuD+YGYBO1Cv2J7nVPWbUSyM8JsvzQ5awt8
	oeGgs/EuLEt3ZUFFve+w5Mcq/ZojahxCQD7sj9EpnmS/IAMupxBXndJv7hgD24pEovhsa1Sag+2
	dVayfXVOo0hW1tK2VRmAvcTr7vWiOhax7zR5ry6IbQ6zHrROJS6tgbU8izOp4W0TujYJEd9eMWF
	s+T0rOGUoGaXROSGx1uFNcRE8n09xq6gz+lJMwESJG6BnkGDI8RpKHx7P9kdTF6zyrGwfS9auaB
	777LUIJ32OUpqab1MC3sx2qoSNrS5ot8knDBCN/W7PA6ah7eRMQnxHCCSrEg44MFx+hWlza1DSj
	5la//HJgzxCXdD16ETAmmtMq+zBDQ80dvLwwNAPUE3JuvfO4BGCUW1oIXOm+Q6xTbVDnl1aOa1H
	AA3lJOjw==
X-Received: by 2002:a05:6820:1341:b0:6dd:1d43:8cd0 with SMTP id
 006d021491bc7-719179ad6dfmr1495859eaf.80.1794410151612; Wed, 11 Nov 2026
 07:15:51 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111092505.3121847-1-lee@jaeyeong.cc>
In-Reply-To: <20261111092505.3121847-1-lee@jaeyeong.cc>
From: Jacob Moroni <jmoroni@google.com>
Date: Wed, 11 Nov 2026 10:15:40 -0500
X-Gm-Features: AclHuK98LgEQHpnp7gUNAvVHjaxsZ5PsQKymcaEXqojXPpEtvDXgfkwqN8-1VGc
Message-ID: <CAHYDg1SDOd_0ukm=7AX029Cr7Oc1UKoSpmd=iBz55C3DFzv_hA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/irdma: publish APBVT entries after hardware setup
To: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: Tatyana Nikolova <tatyana.e.nikolova@intel.com>, linux-rdma@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Shiraz Saleem <shiraz.saleem@intel.com>, 
	Mustafa Ismail <mustafa.ismail@intel.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks. Looks good.

> +       entry = kzalloc_obj(*entry, GFP_KERNEL);
> +       if (!entry)
> +               goto out;

I think the GFP_KERNEL argument can be omitted here.

Reviewed-by: Jacob Moroni <jmoroni@google.com>
