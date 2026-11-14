Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794689085;
	b=Tod7yEIox2usRZBWST9HsT3gcdd8PYrlMUaF5SvH+5X3Qd2iz49Jyuwqv9NwapOxql5s
	 t2iPDRZ1SOFTU/Ar5Zo4CRxwQwU4xekaRImU835lZpLje0SD4fPnOAbDoUTBXSZG9oJXz
	 k36fteosk8wxXklBuHdeaFU1s7EmSh271cq3V3F9Xa1udtt57xhXzxpuTcM5YOJ11hFZn
	 k5H+fj09Sl5z24/qgyO6xTG7ZYLiRKnVKDWLGAF/AWiQnmhJ6dUKUj6NQ+u9x29zURA6C
	 +x40c1Y3UJWtih8j5OtW5zFInJ+poVjzH8JihrzjOUu+Z4dJOHnUgonHLjQSQBwA2Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794689085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RF5riISKB3U2P5GXHOTUJqXWoYoCQ7YYxFY6WjpFX3Y=;
	b=EHTD+PWwbvXF8LTdEzag8qDROqek0VkKDpBY6Xu10721efVA4Ok2EltO5YVTFATA9ZDd
	 Mg4O80wvhPhA+s1jjN8MTxSuga5oA5zYsyDaip/056Gj/X4zlPPR6ku69FjsePERLnRrt
	 oUtF9gshoW0lUpe4+6Ga2PT0+oUkVk0HWGi5MDq/NJ1FWDFBV4y7fdmgVu5FFZ3oXqxcp
	 g99HNHfBue312D3aGa1kNkNiGh53LE3iBYKQrn7NYGtHGn4V/AuUwvLQr9dUwxVlFwfmW
	 KUNsO2+NZqc3E1j4e0lps0U9xYZxyVKWgvI0olKF37iRwvLShuNzdZ8IEzrgdGxph1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=MrBgLup5;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413FE606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 20:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 413FE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=MrBgLup5
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5365d725440so27795021cf.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 12:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794689084; x=1795293884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RF5riISKB3U2P5GXHOTUJqXWoYoCQ7YYxFY6WjpFX3Y=;
        b=MrBgLup5MVsN3BKP8C0z+OVZ4AjO2TH2ZPH5xlez9jhjeZpX9UXub5mCMkTrMdPx/y
         +DRYo1Dw1+zgxDcEgZB/ed7ojmwqhTqme4fs8WqqcNLyvdzHNMBJGjBggWsvayK2Hzdk
         JupTLHLdZpbk6q2De53Yrf4PzrPyctXPSO2Dbz+UOOtQgxYH6rlqVz0LRcUIxeNGhmTG
         v+5PporayHbaGRcABpguFhQzVdsM82CfVG0oJbCf4SqC1avy1620oqVuRWTLgiaOQok2
         wZPXhG7BNeLaTzlt+QwWVmZqITI2O5GtzrvGZt7xspQKt6cipCRmmtK1bzE005KJoEbl
         dJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794689084; x=1795293884;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RF5riISKB3U2P5GXHOTUJqXWoYoCQ7YYxFY6WjpFX3Y=;
        b=o9EVikyF1wp92JejVV0Gmd6ub6shcYRPJVmcKWF7Woju+n3VOutNIWJI6RTKBYTSo5
         57CEC1FULmnSCm4/LCN8DaY3pLo4EXJlZI2JP/F+T23a9wHFpb1hyHOUxlzS4RNcyCau
         h9R0ZaIbK0MBT81YB94lfIMqPeejY1xa1Q0QmvRvfiGAL30bvwzQhQLaCqOMqQgpnPsC
         zc9KqbcltkDxZlWg+NlusPHSM7nWJ0S23JSMnQrk1wjaCpRT53KS406HlBaco4NFPW+b
         a3SMtIvKem4HhTa92Lybx3v84ku048s/SXaXLKNE0jPAtn8wQ6tFTMEpkdTfUu/7AqNR
         1Syg==
X-Forwarded-Encrypted: i=1; AL+hErE7Gq9muWRUel+xoOEmPtmeRtC+gMca6Vl/punp9jp/mod2ldedqOTvacvNSuGeF/GkEwmQTjU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xS73BcTmdtJkeC8G/kKep0BxgS3p5eX0Cn07RXfWJN91JQs7o
	vwTo5XnclRlyydvpFh6zovM4prMmMuGoNAnuTBrhLl8hYh4vViu46uiur8QL3wL0/A==
X-Gm-Gg: AYBFou0OtA05exOb3niOv58gUCXdLm5PKHojnCEqYJg5Hb74vMjLpB6UHmpqgjzNIsr
	3r9HnYFUAOrviV9lI7gbuexpGKoL7F2M8fzPPYrwP1484SNCP+hruiGDBa7IQYpJOlrIOgiF/gq
	XGElHq8oQjMvwZ4nMcY6+jETny8X6frX0/6N6AcRpVjn3dM95xNvWI5XJG2EbigfKyVPxKJZoSK
	lTOrMbcj+Ev6k2M6OWRFs7goy8ChMQiem1LeW5e18kdkgLs7nLxQ7GloRGhm7ZIOzGHmoeh16DZ
	JkKCJztczqvQXrFoRXA+buqc+OdmecUU8lRQA4JB01XnrJbU3nlpNJNvFBKzzn4hL5NQvAkjvu0
	ECCOwK7THJr2OywOenHYWgbGoNySk1A3fzBM9sMu/0y3EYRH39VofFS4EoEOz15yaAfSULmlnR2
	hZe5DZ3qaYo0jG/ouiNxhyCghNxMbt2CgqHkT/q7UFG3lGQdCBDDyRovdpm/E8GXtuPJcIIRF/G
	cIrP+pjLU6B0yP6zSJWL9nUMx+PO5CbKsglW0rh0bRaDJbdKRqU8Kc7jDsmUbaJYFZCEL5NS7l7
	Am1NeYY2JK8iw33uUqAloQxyXEc+mw==
X-Received: by 2002:a05:622a:250a:b0:535:70b5:806 with SMTP id d75a77b69052e-55ac977d7b3mr99745041cf.62.1794689084098;
        Sat, 14 Nov 2026 12:44:44 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::d398])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0534196sm47228031cf.9.2026.11.14.12.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:44:43 -0800 (PST)
Date: Sat, 14 Nov 2026 15:44:40 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Hongyu Xie <xiehongyu1@kylinos.cn>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	usb-storage@lists.one-eyed-alien.net,
	syzbot+30552b4cbe99d6d91306@syzkaller.appspotmail.com,
	Liu Qi <liuqi@longcheer.com>, stable@vger.kernel.org
Subject: Re: [usb-storage] [PATCH v5 0/2] usb-storage: bound the ene_ub6250
 probe-time card-type query
Message-ID: <9b81c4c1-998a-4dd9-a998-1605f4781dd8@rowland.harvard.edu>
References: <b07b5f5b-4722-4f1c-84b9-205ba9b8943f@rowland.harvard.edu>
 <20261113073638.1225998-1-xiehongyu1@kylinos.cn>
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
In-Reply-To: <20261113073638.1225998-1-xiehongyu1@kylinos.cn>

On Fri, Nov 13, 2026 at 03:36:36PM +0800, Hongyu Xie wrote:
> This is v5 of the fix for the ene_ub6250 card-type probe hang.  Changes
> since v4, following Alan's review:
> 
>  - Split the series: the transport helper comes first, the driver change
>    second.
>  - Drop the shared 10-second budget.  Each transfer now gets the full
>    timeout; a timeout at any stage fails the query immediately and the
>    query is bounded to about 50 seconds at most (five transfers),
>    without the remaining-time bookkeeping.
>  - Shorten the comment above ENE_PROBE_TIMEOUT, as the reasoning is in
>    ene_ub6250_init().
>  - Drop the unused initializer of the bulk pipe variable.
> 
> The transport helper is recorded as a stable prerequisite, so the
> dependency is available when the fix is backported.
> 
> The forward declaration of ene_ub6250_init() is still needed: the
> unusual-device table is generated by including unusual_ene_ub6250.h
> before the function definition and takes its address, so removing the
> declaration breaks the build ("'ene_ub6250_init' undeclared here").
> realtek_cr.c uses the same declaration for init_realtek_cr().
> 
> Testing: with the syzbot C reproducer, the unpatched kernel blocks in
> the probe for more than 143 seconds and the shutdown hangs; with the fix
> the probe fails after about 10 seconds with -EIO, before the SCSI host
> and the scan work exist, and the system shuts down cleanly.
> 
> Hongyu Xie (2):
>   usb-storage: add usb_stor_bulk_transfer_buf_timeout()
>   usb-storage: ene_ub6250: don't let the card-type probe hang forever
> 
>  drivers/usb/storage/ene_ub6250.c         | 110 +++++++++++++++--------
>  drivers/usb/storage/transport.c          |  31 +++++--
>  drivers/usb/storage/transport.h          |   5 ++
>  drivers/usb/storage/unusual_ene_ub6250.h |   2 +-
>  4 files changed, 102 insertions(+), 46 deletions(-)
> 
> -- 

For both patches:

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
