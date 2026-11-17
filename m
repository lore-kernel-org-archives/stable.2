Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947659;
	b=rtmdmcC0ylRzYoLZ9oIQ1JJ8u1arLSGkQ8L7qQLUccP3Fn9xXyg2IgH03ZgDket3mWNQ
	 x0VkqCiFN6O7Tev5QCxEkEwYMb4p+08HVqg9c2liBD8mzz+GiZfonp5yakni+N0UQsgV/
	 tqlY2ER6RpRiH49jeCr1MDU0l8hBJj4TIJ5LN9FWviRgVeZ9h43mAHkecHkiUwzLIpI9U
	 NdgMaEf9N9OIZVn4U2OsLf3OBXfCbttuFhED7NDjoJr8lkez7ZJ7uFaRKT5HGtxmXNWo8
	 M6Tvbde+B3dMGz617KfbNHPeBZ5P69x1hjMpCCDn2XgRlOBcTAVKFzFkmCxkzb8d6dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/ZMhcm/JCcD+M3t4azWcucL31huBZZJYoXQAph0Cu/Q=;
	b=kXGV6TFxo1kNf44/ECEEpsV3Xt4s5p5k7EfolXdCQVCkUU81IR6QQdaHEYQszKQK3TRS
	 mfMQz52rUCirSIuR2gRBFNuTsC6wfFeBGd09SBmcZcH2691D9VAxXQbicyJewDCWoWn2s
	 vJGDBDoisA21QOmU4dXh+8PPdluMs9/kJ6EMZl5Jm0otDpRXmlFv6RbpaBSHRk003hCx0
	 gvGlijo6GdfgMXDyf0pnA7LL+rvHz7aRpo/G1Zob/ISa+iMEFN3W7aGcFVJeA18NcmIFn
	 gbf6r7ak1ehnnKH5c4zvPRnyBAW3abH6zu7q3NkgRfJM/NVfSJndcPXYkSqFulcRoqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=GS8p0iFE;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81959606A883
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 20:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81959606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=GS8p0iFE
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53665358476so2229191cf.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 12:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794947658; x=1795552458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ZMhcm/JCcD+M3t4azWcucL31huBZZJYoXQAph0Cu/Q=;
        b=GS8p0iFEUF/En0yzlT+JcuCpLdO2j8huJwWM9K1FLGiMQrTQ4OKuEnYY7jh34BNQHz
         Y4JUGy80u1H7sIxiUEgWPoUrNvkqgm2wtp5Tz1Slc5r11ygXc27JiVS3gBazpRwbam7g
         5LoK9Z1PU88QvaMAyD4AkS/9tbw8YYH27s/RWFW6pGc3jxIzOQjkvgXElvfHBrWkXBok
         yHZ53avyhHLSXtdZYUi9T4YYYgMrPW/YXKkxI8Lg8BT4foCHmPFLw4SMXPY3jMSxKsVS
         WxnZD7Gr0kItymyPk9aX7ZDMXsNg94Q3+reBGHl3F165VA+74YLCFsizb4mHQfGD6+tG
         gA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794947658; x=1795552458;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZMhcm/JCcD+M3t4azWcucL31huBZZJYoXQAph0Cu/Q=;
        b=yvJKsIxePqIwgnh5CWlnyueNOhBCibSPeVrRQXcxHvcCbYIR1hNoC80sSQ7hxu6Tod
         kWijVDfp4wI45yoaJ7XLg3zFgLevohhzJtqFU7D1oT3EQBfYGoY8Z0egfMLXL0TuVx/a
         HhN0MAaP6yfHRD7Vf7XzW85TFF8idTBCBVovecD/haOtubIBVQyzoCC8QVs2RYgA9HDw
         HkL7aAS7Myxb/fmpu7fsV/tczfcCK7m5Vt8dN/Wn1hYRuNgcZ4px/FZk7XXU8UCUlRcB
         BoXs3tqs8IAs3xVvPmyu/PjxwpbT7l8kU8qEBCRIdp3gaqGXy/JV88V6y/0uKvmVLBnE
         VEWg==
X-Forwarded-Encrypted: i=1; AL+hErHsqw9GS/Zzga2sBkcz3m2fzyeI3gQo+YHrC8knugnPqX/993M23CWo0vKJ/O0MUOmWueZ58cA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HLVMi3y6JWKofYUgB5dhahiVuTD33cZbzRanuzYBSTpWDAprK
	XFqL/ex5kz2ZdXWejATBIjIW1CaE46O0A+tI1SseCMJlJjUiQ6iam72jlJv5D6ImBP5defipKZ5
	nhvU/wQ==
X-Gm-Gg: AYBFou1fu8R1ZgLtYCDVBPtrXJfI8yEVqYp+gDxMAW/44HebsKlV4rmsUP2UolYazzj
	inIOTkOOu1gHqwrlr8O4zwv5HnBax7GDkgHoAIFhV4vrOsYzf3M8pY+IQnLH3uUYPyt5tRQrirj
	vmhwQ+dHJjBciTSi38TZ8NteqcAYu4zYljm66/Geuw4Wejc1i02qg/lR4R0Kb1TPg7WSvNofyev
	mzu2P5YETGPjG3SGy4uotD3QHukzsdAFeH5xmVWTo9igM0cvp5iX5v/YV04JL9aWlPXnmmBdQ2R
	JMFl9ehhF0nPLXeWr9iisGN6v+3TbJeaKx79JtgZ4PLFCmw3lBWo4VGIan9r9B0qYZ4qjatAlhV
	koYVEEf4XBYPhEWt1SbvsbvfT4ZteiNuy/KEe0TXUMd2+nEX+hz5x5g0c0cX3DfDfx7w6HSF7ek
	9VIk86N1T47bWNzyaLt0/sainOcBlrXVAllmMSRsjHosVzA8mPVg65H6O5zaIj7OxCyaCzJg3IJ
	7eZQJugF58MlY8N/dyotWALTFUVqeuhu3v4m34ziNde3/UoD6G6Dn7zG5ZKgxCb8B72pWiKjyOe
	JFlSEdgRtFLJeHATY6NjGwYZYVbg+g==
X-Received: by 2002:a05:622a:230b:b0:535:8509:3138 with SMTP id d75a77b69052e-55d5a308334mr8458151cf.11.1794947658309;
        Tue, 17 Nov 2026 12:34:18 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::d398])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d5909ec98sm5319881cf.22.2026.11.17.12.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:34:17 -0800 (PST)
Date: Tue, 17 Nov 2026 15:34:14 -0500
From: 'Alan Stern' <stern@rowland.harvard.edu>
To: gichoon.han@samsung.com
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
	'Takashi Iwai' <tiwai@suse.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: host: ehci-sched: Don't let a bogus siTD remaining
 length underflow
Message-ID: <852edee1-229c-4685-a124-497ed2ed85a1@rowland.harvard.edu>
References: <CGME20261116052855epcas1p403c518b90d70d98752ad0ca2d9ac05e9@epcas1p4.samsung.com>
 <20261116052851.2272125-1-gichoon.han@samsung.com>
 <5ed0f4b7-beb3-4059-9e12-b9738af65d91@rowland.harvard.edu>
 <000001dd762a$1b15f230$5141d690$@samsung.com>
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
In-Reply-To: <000001dd762a$1b15f230$5141d690$@samsung.com>

On Tue, Nov 17, 2026 at 09:25:10AM +0900, gichoon.han@samsung.com wrote:
> On Mon, Nov 16, 2026 at ..., Alan Stern wrote:
> > The type of CPU doesn't matter as much as the type of EHCI controller,
> > since you're talking about a controller hardware bug.
> 
> Fair point.  It is the on-chip EHCI controller of a Novatek TV SoC
> (DT compatible "nvt,NT72668-ehci"), driven by ehci-hcd through a
> vendor platform glue that is not in mainline.
> 
> > Actually the bug lies in the host controller hardware.  Not the driver.
> 
> Agreed, I'll fix the wording.
> 
> > So you have no way of knowing whether this patch really fixes the
> > problem?
> 
> Not directly, no.  I don't have the siTD contents from the failing
> device,

Why not?

>  so the claim that the controller wrote a remaining count
> larger than the programmed length is an inference: the faulting
> memcpy() still had about 122 KB left to copy out of a full-speed
> packet, which can be at most 1023 bytes, and this subtraction is the
> only place in the path that can produce a value that large.

You make a good case, but I'd still like to see more definitive proof if 
at all possible.

> What the patch does guarantee is narrower: whatever the controller
> writes into the siTD, ehci-hcd never hands a class driver an
> actual_length larger than the requested length.  The crash itself is
> already prevented on the ALSA side.
> 
> If you think that is not enough to justify the change without
> hardware confirmation, I'm fine with dropping it.  Otherwise I'll
> send a v2 with the controller identified and the wording fixed.

Go ahead and send v2; I'll probably okay it.  And do try to get a real 
smoking gun on the failing device.

Alan Stern
