Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794852561;
	b=uRn3G3/ulWPNIyuQnCoC26lHm+ZJNISA+3eb/5S/5+TMLqG0sqMH1glUer9X6W82BVzt
	 Ln9lx5kPL5Re6x69cQz0ocPYLHtxK4xjOmO7jEMDuQbHWjB4dIT+J4i2uEK92WMkEskEK
	 UGURI9vDREYTQjY24HxRQtfZ04FG6+rKp5GuNuFQlkbIInh8dLQCwbxKsKH/XbDiVMEhw
	 BW7d4xlrE3LBnPVorA51pZqZc2w06GX44mQbBs2M9NjvXNhMCgbfkR67E0vil9McxMPG1
	 LhcDkhJhjYATsXOIcI+UbdniTuRcHMvC+ZNcZ2fajeoBHEY5lvuPtsx67JGqUDt8Srw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=okvp8C0zuSE2GrsT9KtMaCBqr1Zkfu7oGXcl3aeW/jw=;
	b=VNaJHNf31u+414WynIlqRNtdYwmqrjiPpmB2QrF4y1APn2K+Nx/a5stqapmMUM2bT7CL
	 sByifwAm2PmbPtIJp12q7ZuR1ypgytzoz3EMV3gvTNXPiO/bvpPrLzKvdVus/t3ltfNBo
	 C/JXBquVRwQ0I0drMaQHacCD2E1YNqE09ONTOM/UpDcjro0KqzWh2/1iroopB1e53ylsV
	 4rJpYQek4wKoS6D9At7dNAeQzjfktIXcMhlsbyxDuF5QO34tSaTG1q4OPnpzMXCsD3Csk
	 TeSPrYZyZNiuw8p5d0eWVv7aRpWAhXTTMnnycKor9APEJMJ5zZittLwJPpABaRgpKmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=OiL05YS2;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E850606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E850606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=OiL05YS2
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5361e313e63so54424901cf.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794852559; x=1795457359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=okvp8C0zuSE2GrsT9KtMaCBqr1Zkfu7oGXcl3aeW/jw=;
        b=OiL05YS2dUgjulEGZcPXZ2GuuPa/kGvqN3r2wKpIWxdRWJBuCWWnuQRwvIsJ3sA+B6
         t6KKOyOM0n7cbylFAJD/bMiC6rbwG/aZVbI4p6sfZVr5Qjttyl8bhfL/1SRsFfy/DMia
         ZRmY5IVTEWmeRQlhNXWoAO2LkovRs7PyMF+I6PDXPo22DTCgroKPuKMpxSH2mif/r8ev
         IkcUPTqY3fgyh5mx8lPonJdaS/NZz80oey7iNRgfblPLVYYICRLhZ6ZVpPuw+okbkEv3
         bOTxYJ+EoZW571F5EkPT4g89TG/xLfrro0PkZccqWb65T0ztIDbVg72oCSV4pkCJbEOh
         5+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794852559; x=1795457359;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=okvp8C0zuSE2GrsT9KtMaCBqr1Zkfu7oGXcl3aeW/jw=;
        b=fKRu9H+anBZtzOg5EYBcUlv99k41iux8lEMtO984Pcu5+zpXVXpZWLs5+MEwBgEg9N
         7mbHYYabed+9hNd46+JyPpHNJOGvTYTc/wqekQ1FPnjB6KFkuV0+Pl/kg8VMvZMxUBnc
         xsQtvNN/nWAzAwBN5E/8pIptJA5csWW5A+uO0D0ZY7nZX5fneuF5xBdwfcBRGRWjC2Au
         9AzvALp585bwDXrEizhBOOC1wkqgYIZBGNZDFvc8hhWIxrqWI0KsCLD/ed09nOpYVRT3
         7qdSGwBP54EzMgWXi3M0TStD3ubZgjkJuqObkCxts56yqrSWx3Y0z4pOT318OQ2Y+2dM
         rtUA==
X-Forwarded-Encrypted: i=1; AL+hErFAJjPqTJQYoM9Vqe14OcaDLvGUjJSTLmkLAO/6hE+gb3Gu/1Jxgzo/CFGxJkjI+SQiTa9mESM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GIu1Yx3dXrQAdpO2FTWP7QKsVMxgyr3XPMl9qevPidKWcqKIV
	nDEmRO2if79G+Ugdv9ThIvmscM3NxAA4BCXCJRA/acL9TTPUhVFrnAEboQvfghm/yQ==
X-Gm-Gg: AYBFou3uqrDa1Xx1otZEfB6bY/Sv+7hsJ1Q0BqNAKhgmSaRIR+WV/VnYcWmCGque9QW
	dP9AWx2+WPz+iHgwsril4xJ0+f0YjzGOrRbPaT6tXShDRek2mHYF7E3sGzk4n4KHrvj0iXbQquf
	MN7NwGpv/91Byp/l9sFCmujTFvkaw9GUtyqgodtiXpdFQEyu0JHPRh059a61Qv2feEtHcz9baX1
	W1G6Ss32K0zagtQ3L0HiojKovJcqA7UCoe+guDzLEwhlX8ozsQVW5hB2l7aP4xLHvVmFGx+ijDw
	TouQS2lHPLZdwZ7hAd6Xk41G4A5Ru+gWeUj5iRsKIVhbF2HgmIYO6wg7ljbr5+3qlahcc2EpcmV
	1HozykLYDr7sjYSt8GQiUuwJ9qRKFRfW1PMz2JdaO0/gohums+9igkCaZ+LFy6HAIMMPxwMhKFS
	ePjcb7fRSP3sEJI6zB1fcp5+qCaVjCd2FAlcGSO3D2uBBx52Ftp8DDORl2bw3VLNowNRV5oODoD
	mPxUnxUOTwYxuhw0g97fvUuGhda5HBCOBl/34ARnz/piIt2Xfs7CpkdEDTYmCGZ2Hzp/aZ5/WXI
	DRgtT8xpV/FbpQQvYcmDEwKEPSEOHtAPujEDbOJjr37s1ivJM+Y=
X-Received: by 2002:a05:622a:580a:b0:535:7b01:1ac7 with SMTP id d75a77b69052e-55ac4390e7dmr180243411cf.6.1794852559307;
        Mon, 16 Nov 2026 10:09:19 -0800 (PST)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:2008:aeb7:73d7:d8ff])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55c42b6f3desm62496871cf.27.2026.11.16.10.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:09:18 -0800 (PST)
Date: Mon, 16 Nov 2026 13:09:16 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Gichoon Han <gichoon.han@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: host: ehci-sched: Don't let a bogus siTD remaining
 length underflow
Message-ID: <5ed0f4b7-beb3-4059-9e12-b9738af65d91@rowland.harvard.edu>
References: <CGME20261116052855epcas1p403c518b90d70d98752ad0ca2d9ac05e9@epcas1p4.samsung.com>
 <20261116052851.2272125-1-gichoon.han@samsung.com>
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
In-Reply-To: <20261116052851.2272125-1-gichoon.han@samsung.com>

On Mon, Nov 16, 2026 at 02:28:51PM +0900, Gichoon Han wrote:
> sitd_complete() computes the received length of a split isochronous
> packet as desc->length - SITD_LENGTH(t), where SITD_LENGTH() is the
> "Total Bytes to Transfer" count the controller leaves in the siTD.
> Nothing checks that this remaining count is not larger than what was
> programmed.  If the controller reports a larger value, the unsigned
> subtraction wraps and the class driver gets an actual_length of
> nearly 4 GiB for a packet that can hold at most 1023 bytes.
> 
> This was seen on an ARM32 system (vendor 5.4 kernel; this code is

The type of CPU doesn't matter as much as the type of EHCI controller, 
since you're talking about a controller hardware bug.

> unchanged in mainline) with a full-speed UAC1 microphone behind a
> high-speed hub.  snd-usb-audio trusted the value and read far past
> the URB transfer buffer:
> 
>   Unable to handle kernel paging request at virtual address e8756000
>   Internal error: Oops: 7 [#1] PREEMPT SMP ARM
> 
> The register state at the fault is only consistent with a wrapped
> actual_length coming from this path.
> 
> snd-usb-audio now rejects such packets (commit eed0e9583a29 ("ALSA:
> usb-audio: Drop capture packets with bogus actual_length")), but as
> noted when that was applied, the bug really lies in the host
> controller driver,

Actually the bug lies in the host controller hardware.  Not the driver.

>  and other class drivers trust actual_length too.
> 
> Treat a remaining count larger than the programmed length as a
> protocol error instead of reporting a wrapped length.
> 
> Link: https://lore.kernel.org/r/87se19ufoi.wl-tiwai@suse.de
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gichoon Han <gichoon.han@samsung.com>
> ---
> Compile-tested only (ARM32, W=1) on linux-next.  I could not capture
> the siTD contents on the affected hardware; the wrapped value is
> inferred from the oops above.

So you have no way of knowing whether this patch really fixes the 
problem?

Alan Stern

>  drivers/usb/host/ehci-sched.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
> index 57d07d1c2dfa..12a10248a4b6 100644
> --- a/drivers/usb/host/ehci-sched.c
> +++ b/drivers/usb/host/ehci-sched.c
> @@ -2241,6 +2241,10 @@ static bool sitd_complete(struct ehci_hcd *ehci, struct ehci_sitd *sitd)
>  	} else if (unlikely(t & SITD_STS_ACTIVE)) {
>  		/* URB was too late */
>  		urb->error_count++;
> +	} else if (unlikely(SITD_LENGTH(t) > desc->length)) {
> +		/* controller claims more left than was programmed */
> +		urb->error_count++;
> +		desc->status = -EPROTO;
>  	} else {
>  		desc->status = 0;
>  		desc->actual_length = desc->length - SITD_LENGTH(t);
> 
> base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
> -- 
> 2.25.1
