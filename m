Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793855189;
	b=hCjlMqN5OZcMM3GoO429fI1sl3z8UjAK8vsS8cC5ChzSJqhvXTWeKEc838VsW8c6x73G
	 O2n/DFB3UqVdRrJ+H4dx26Kw7OdzRAt27wHZlyeFO/36WpFu0pNh0kNmxBzRVL/n8F0hD
	 PxNInCz9UG1uZceTTjt6uwiZmwCEIJzsWfRgzMsEoUhTrkMTrbkB5zZhTQPHYHgPbVFDq
	 xiQIL0I7TdNHUD3ivTfHfgSAN10Tb1HPDeT8/XQzY6y0xRDoR7voRA7IPyib3fdVtnS8F
	 ntrclh/BUaCt7wYjlh1PVvjkNUzK1kbxdw5cXbk48L8kBBBNX+YpnTvp6urJgBXxz5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WJXyrXeadAPpp1EgKOr4nzDbu8SHuoj6JH23Y/l65FE=;
	b=sEJuXNY9Y041RIG6XIjydb4qNBO8axcJutaebNgW1PUfUCgVdTfaKSQpkTDI82vrILDx
	 cj10AMJ+0+v8jPU0T4DoK2iZJLuX/Oxp0NMRvajQxBiA2Mq9/Tt59jAbw1XBgC5dD2LA4
	 grFirT+7lG1M21+XgT1NG+w6KhDAw2jN9VFjBtRSjBkoBcQEkIEfmGKquNeOuBuGkxJCD
	 y0WWZgpDfD0sco+kXOwtubX2vwWLinzozTFVKW3g+f2ZxvQ/ihgCrh9C3g/ACA8tkQT5d
	 bxwuUAq/k7sfotwRvqYzjEMTct1Pu9HTBkFZ30RoQn5cZIplUHobboSpsEI3AhvKCGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=u1vps6FB;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D411606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 05:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D411606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=u1vps6FB
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91e7fc8265aso17333866d6.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 21:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1793855188; x=1794459988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WJXyrXeadAPpp1EgKOr4nzDbu8SHuoj6JH23Y/l65FE=;
        b=u1vps6FB9frxf/5wIeIkT79W6+qKBcnHUXgZFA3lxyIcYMxWBSmuscItg+LvtzCPt4
         wBr1/mtJY/KdPwSIYKiqNB7nr/GC5kN1g6ESuFk5sivSG+oM1NZS9EzeiYbFdXLDLnJg
         R2P4a9eqHvR/8bAAY7C/e8ag0fUqd68EswHYUgY5F3qh8yTG09z43B71PnaptvlwZjQi
         zS69FjHsGpaGz/m6gfwNcRf1iwYvtxvw3HKv+CwvysJR2kNza/Q5lGXCV1+6fI4TEX0t
         h79lQrcPeWwS7dFc+ta2AHIO9VxrEiNfI34Egr3aWtmJCvctnWKRi/7MqfEHpYhsm2qP
         bjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793855188; x=1794459988;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WJXyrXeadAPpp1EgKOr4nzDbu8SHuoj6JH23Y/l65FE=;
        b=j6PmRAzzaUKEX/7p1JQ/83JY/0FbcDgJcPDR0cZaySmyU+8xqJnQrUlYNIw1t48IPA
         KZ9hLmCt3Fc8uhC95Xr+fM04BYJAl4vMadtcIay503YipTTNRfUDPySx1zip4MZ9gPjH
         hHR0iKi9obFUg2gxdquLS+PM1XHizb+sLX1dQzTRdhi50gcWta8i9S/gYNIkmSA0OPU1
         bdcX4w+UCHVWF/tbApHymibvNfLO2H15XacgLhkek/PAeUbErLtIeXl6C4ZoNWJKQNli
         uuaKYkqx2Qjajm3R8Wx6a4P0LVmTWwNXa8ahA7Pc1DRM4bf9UjizyUUiA5l/wlbpXVnV
         GNAw==
X-Forwarded-Encrypted: i=1; AKwUvBz5EG05b/6kcLGlRVxmhXoeqtNipXXoEBvnDMirpCeP1wscAFypHt4sy2COf5CuafBNtng/Qkg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ptMuDqmFm/VKl5XfNZzj/Zi/BDRPEatV5FYxiy62hAFYhNJWR
	k794j0sBMBbzVQIgH2RHbVdIPP7lQdTIXaNc6FISVjV4s2HIr2Qql054FgzZGbj24A==
X-Gm-Gg: AYBFou3x4neZ87xVGM0Shdwd5w7z3cWcZ9mbOZ3pP6avuJSLNEmIKneUr527Mid5jPE
	rkwepWuDO3crH1K8BKJzHztgSAmdU+cKVBSmyJrvva3o62yYb+Q4us0euto2nZGl6GjOgcasBlb
	Q1n9EaGqH7cNWHLSwW17DnPhq4G0HilecAM31UwtIYvUetQ/3AzrZmKoxLk5nSHzqc2LZMN0YOb
	hNzY1Rs9L4vWqYBFD65gCgE0108jymecrB8GxeFtzJ4OEUgKq+9u8LVlqkvmRBrLhLPK67Ir2Z4
	KwapSKTN9urqpSdGgMcLjveUhmv9160SwMbQLv9S3KisFTfONQHwXqsKRe65EfpoIL6VtQ959zp
	d+mbWlMhTo+Ww4P7J3iunBMteW9KAlTV4IRwEdbzeXrW+btrQHxtm3WAsHlOpp1r5y3UsmRtZNw
	Q/Civ5vQ/fBvnEUfwfGmhBAmdnRZ0tdc0Vhih+bY69cIDfWgiA/YZgtEChNWiUUElAQuK8Gjpzo
	NROSk2umEtaFbnY/iPtyoM7aRsQG4uXDhod2gFIbks/akk+Xv45tNesvLjB4K34+X54glquLYDS
	fSMfIkYKGNJQui5ZB9UMHMQUjge3
X-Received: by 2002:a05:6214:2263:b0:91c:7a7c:4491 with SMTP id 6a1803df08f44-91ca4bbd308mr298429816d6.43.1793855187833;
        Wed, 04 Nov 2026 21:06:27 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e01a3f5sm38061886d6.30.2026.11.04.21.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:06:27 -0800 (PST)
Date: Thu, 5 Nov 2026 00:06:24 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Pengfei Lv <lvpengfei20@huawei.com>, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, xuhaiyang5@hisilicon.com,
	xuetao09@huawei.com, caiyadong@huawei.com,
	suzhuangluan@hisilicon.com
Subject: Re: [PATCH] usb: core: hub: Re-guess ep0 maxpacket size on reset
Message-ID: <59b0cc88-9ac2-453b-bd68-56aa356c0fc0@rowland.harvard.edu>
References: <20261104124402.1269650-1-lvpengfei20@huawei.com>
 <b9ac3c8f-7ce5-43d1-bcf1-d2ce9877d914@rowland.harvard.edu>
 <20261104183603.17d663ce.michal.pecio@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104183603.17d663ce.michal.pecio@gmail.com>

On Wed, Nov 04, 2026 at 06:36:03PM +0100, Michal Pecio wrote:
> On Wed, 4 Nov 2026 09:59:24 -0500, Alan Stern wrote:
> > On Wed, Nov 04, 2026 at 08:44:02PM +0800, Pengfei Lv wrote:
> > > When the subsequent re-enumeration then uses the "new scheme" and
> > > issues a 64-byte GET_DESCRIPTOR (get_bMaxPacketSize0 with size=64),
> > > xhci_check_maxpacket() sees hw==sw==8 and does not issue an Evaluate
> > > Context command.  The xHC queues a Data TRB of length 64 but applies
> > > ep0 max_packet=8 for short-packet detection.  
> > 
> > That's exactly what we want it to do.
> 
> Should we want it, though?
> 
> Were there known devices with bMaxPacketSize0 <= 16 which required the
> whole transfer to complete before they are reset?
> 
> That's not what happens in the initial iteration, so it seems any such
> devices would always take two iterations to begin working.
> 
> Is this what the only correct Proprietary Operating System does?

I don't know offhand of any positive or negative examples.  But if a 
device was going to hang if it was asked for the remaining part of 
the device descriptor after a non-initial reset, how would it ever get 
through initialization?  The procedure does two resets, and after the 
second reset the device has to send the full descriptor.

I don't know what other OSes do about this.

Alan Stern
