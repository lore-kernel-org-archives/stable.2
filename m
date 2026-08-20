Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288A6476691
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235918; cv=none; b=k0PkfPhJ/oyBOkk/62mXIb4UXCdUVk0MqCUxZGS6niv3bMOzJO9oMvBViEaDPBbezagxumTfx8Fm9PNZfD0rXMU3D1fdh7f1Hdp1Rk34DfeisKh39VXOQhYe1Cu3wRhefSHab6OMgI11VVfVlYlvCQq4OEshXZ4D1K/fMWJwj9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235918; c=relaxed/simple;
	bh=nKJGR3k+2syYP4jawgeydmGZ4v27AsMklBl0NSZFHZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHELXrAKBc5/Gk4dm8OlSIa2/lkkM4AV9WhD3bdq6RuPdM4+KlaksDVbyxKf7IdB2mDAfazQrErfU90tr3V1yk3haRutQqPSSYJ0iXt7jcqzoYjbH80NIFXOta+a8p39eneLTEm4OaiwlFkNmHcMR4nKn7HRG0gU53YmmQQTXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=PZSTaRC/; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="PZSTaRC/"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5276d598b96so12058371cf.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 07:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1787235913; x=1787840713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TOr8max4FuPVqm/XaKBw6uk0jprAw1pvs6KTbTAqIGg=;
        b=PZSTaRC/mH7Vm29lYKv1NhxS0hTUIP+F3yzgWrHatuzbVhOG2p2PhjvHlclYz9mFmc
         k1ZCk4MpqxQ9n2gX4Ynal5J4MpxSCbokucjIR2x2qFpM/+NhbqYxaFrMpwVScjkGU/rO
         6gJfbx6VmZl2WS4kZjdDZbkaiCy+q3SpY+GO9fV8+NWiSsNgyBALcSod1v+y05WkDUCy
         3rFDLjU9dpetGVy7Qb3sIAG7Ot8B3RSUmRV9ASIUj48uqto0v8D5N3UsJl8Uif57Xjln
         1m1vbOBhaUl6hx/rwhZZArvDaBTPz08Z8NfQ/M3/AvvPR7QjLjCfo0QlndWb0zSZpBzl
         qAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787235913; x=1787840713;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TOr8max4FuPVqm/XaKBw6uk0jprAw1pvs6KTbTAqIGg=;
        b=si+hxGmQKDTYHPXNwpVdXLvMyPhgfXaqOpZNNYYWI2BDydKvxXCa/GHYAArniRyNgJ
         2lD2Yux5UYBz5nMxdocM1YJ9c+XrOCg2hf5xuts2cGTt68rYare9YpyWYdIKP9Q+LxaE
         akgiYLgJuABWMO9vzXovgKJI20mikdc9xm19nEbN2iQUCzVvQ5pxFb2E1ZU/9P1SiACa
         dktZNl8X0xLN/R2chh8cMDAWdFtGePAaGAbNoq3VXV2rekiA+0qVGkZzJzSzcJLMRrOr
         xUrfoHGBhan0XmmjmN4O/rxCczH2DybnahkkQTXYytsPXzSAPd22gHyY/uXXGtrDscFf
         NLQg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6DZq6OVZet8WnyGj0xrX8QuNm/pjvAQ52d3f5QN8OcLPpEcAWnEC4AwlgjeRBxNOuellzmeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6u24+eTom3LWMxwIk1jogeZkIvj19XCerC9QDmilk3axC/b6e
	foirqS9TaYS9pz3W6pkaK/dGaTBCj7EFnMq953NDXNZXD997U+iEBIXRZVFc5fkn/Q==
X-Gm-Gg: AR+sD12oXBVEjGa8YHjT/hWVXyZf7W6VkEQHWdBwrSqxXmybmR/tnytzNME6F/Y8PC6
	tBHfS/t7sRcFHKRNAgyllv75jY61VRxOPZGFEPwtuxXRoj3x6I/KIxwzSiQGXDXptl7i9lilQXV
	1W9fRbpfDiZJN7WWD7TTiHVIIcsQ+DHuaISTt0fhpH+5A/TJHVxE40acJVlTiTTm0Dr40pQn4zX
	aoyeLGwaEX0ZE5cs2BeflH+MDv/5/xW6ZD6J4vCGBPkhtd6PSKKXklGBQ+YDg+4jSp2jeG8t85c
	Lg29rzq8kxEHaGWBWGNVKWCJYcwqdqiDb324F2ohTaj3bRhKjs/bYAw5Bk3U3bVodOs56Y56b7O
	6oqhb55uDnMRLoUgJGEywcdb/eDSzGi4SGF2NdGPcojBty0vI33eWFvdjpH/zJB2bj+9i5a2iIN
	zjWXfUpKBpQ2viJ2ZJlW0PN61Lv1TrGj5FJc4FNmeqzVTgU0BT2rY6q0EqoH3ujxXarGO93duXg
	hgoHAM=
X-Received: by 2002:ac8:5a93:0:b0:51c:1532:ae93 with SMTP id d75a77b69052e-52dd5a2255dmr118169001cf.26.1787235912744;
        Thu, 20 Aug 2026 07:25:12 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5eee16e0sm39596346d6.17.2026.08.20.07.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:25:12 -0700 (PDT)
Date: Thu, 20 Aug 2026 10:25:10 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: liuqi <liuqi@longcheer.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb-storage: prevent concurrent URB submission in
 usb_stor_msg_common
Message-ID: <b0b85244-48dd-4ec7-9add-8649216c80d8@rowland.harvard.edu>
References: <870f2627-aeaa-400e-9b6d-ee77eac42be6@mailsrv01.LongCheer.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <870f2627-aeaa-400e-9b6d-ee77eac42be6@mailsrv01.LongCheer.net>

On Thu, Aug 20, 2026 at 12:03:45PM +0800, liuqi wrote:
> From 054ed55aaa0d80edc93d25e4750d67e9064bb77f Mon Sep 17 00:00:00 2001
> From: liuqi <liuqi@longcheer.com>
> Date: Thu, 20 Aug 2026 11:28:43 +0800
> Subject: [PATCH] usb-storage: prevent concurrent URB submission in
>  usb_stor_msg_common
> 
> usb_stor_msg_common() only checks the ABORTING flag before submitting
> the URB, but does not guard against concurrent submissions when a
> previous URB is still in-flight (e.g., from a BULK_MAX_LUN probe
> running in scan_dwork while scsi_eh also invokes the same function).

Why would the scsi_eh (or any other part of the SCSI stack) submit 
commands before scsi_scan_host() has started?

> This leads to "URB submitted while active" warnings and -EINPROGRESS
> returns when usb_submit_urb() detects an already-queued/in-flight URB.

Have you actually observed this happening?

Alan Stern

> Fix by using test_and_set_bit() on US_FLIDX_URB_ACTIVE to mutually
> exclude concurrent submissions. If a URB is already active, return
> -EAGAIN to the caller.
> 
> Reported-by: syzbot+22ea20ef3afb6785b122@syzkaller.appspotmail.com
> Signed-off-by: liuqi <liuqi@longcheer.com>
> ---
>  drivers/usb/storage/transport.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> index f79b449d0..ffb1459d0 100644
> --- a/drivers/usb/storage/transport.c
> +++ b/drivers/usb/storage/transport.c
> @@ -122,6 +122,16 @@ static int usb_stor_msg_common(struct us_data *us, int timeout)
>  	if (test_bit(US_FLIDX_ABORTING, &us->dflags))
>  		return -EIO;
>  
> +	/*
> +	 * Prevent concurrent submissions of the same URB.
> +	 * If a URB is already in-flight (e.g., from a previous
> +	 * BULK_MAX_LUN probe running in scan_dwork while scsi_eh
> +	 * also invokes the same function), reject new submissions.
> +	 */
> +	if (test_and_set_bit(US_FLIDX_URB_ACTIVE, &us->dflags))
> +		return -EAGAIN;
> +
> +
>  	/* set up data structures for the wakeup system */
>  	init_completion(&urb_done);
>  
> -- 
> 2.43.0
> 

