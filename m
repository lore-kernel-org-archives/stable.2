Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782905;
	b=o9MV1chkiYnNBtjAF4nIT//mHePyppXvlj+5rIVtMzarrC1KoWfBoP4V5uJKMkxtQ71u
	 K9ZtwRtYNbAkbLEXVWTvXoofC8MAfBTn1/ATasSaQGFAYNH/UDk7CTxiX0Y37FhzAuRs2
	 R3IrB9zJXeQNear8tbEtmlRFHSs7wJRLXw1aJNUSYg5JKCd/XIUM2HHcsVmhoUNqexlCs
	 AFHts5y4xrz3/xvfM6jijr/vvZC95AGl+CYFvBwYSyNb3y+ysYh7ioD886ZshpUjONeRx
	 5fbGE8zd4tb1FACOsBlFl3CffgY8LNinqOauy5dlz108bFU2mPIkHwq4Ady+ep2beew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=j5thw4aqlZ2SY83bvfjuNvSX/gTNsfeGcVUo4niR+ac=;
	b=5gtEJRgWzwRDbA9ghnUE6IbGmpYtBSTfbUOrk/HGMIDGTbPxv/ZN7W6GJFhsYDbqaUis
	 vRSRMyc6FoLnQq+De5iTX2eyWGFlKPJ6vShAf464CknpmGqQubnr5jGNesUWk/tGN2jeq
	 Oa7u8K6WVe7SZ70py6NgjCRPuYjE3dG1mgGzyoN3jFAiyOXZZM24ItR5PDp9NX7gj4gH2
	 B8Nt4zDt+cfQ6fDOzDvK3LlgG25Unhnpixi0nOn8H3g3szkeCFQ1xeVi96t4qIMjtBSx3
	 N0lQvVFBp4IscxrI96GM/ibQPT8h1aJJCAo+SShcgeuFgrNz9qFlAFXOp8tiy08G1uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=syjqtj6f;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41501606A320
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41501606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=syjqtj6f
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f3c895a0eso94148785a.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1792782904; x=1793387704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j5thw4aqlZ2SY83bvfjuNvSX/gTNsfeGcVUo4niR+ac=;
        b=syjqtj6feIG5AFFf7XsgD5piN6XF2532Bj5zlfb4nzUPljy+bmkRWUkXg1dinX+yOZ
         jcv82rXH2puWYPvWiIvfzdl0WLMMtLmGDBPbvLh0kJI1Fqcz1Z5QDRcM6E4GVhhGbnaa
         9b0OXcpAfew56ijeNQ9zPxYOuRG1tcHwm5876MnoFzA+OMXCXLgomYbmygPbNAhjGk7O
         Zho+OAbQFnyIt9i4UjG1mv7yyCTMO9XEIBFodHObxq/u/Cj4OwAn9FlkxUvFaA3A0JZX
         W985Ip4/rYLFkOr31rQEBf+ikjWqPSHFWup4IAik3mt9CRODLCvLSTuhraAngsP0Zxrq
         /xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782904; x=1793387704;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5thw4aqlZ2SY83bvfjuNvSX/gTNsfeGcVUo4niR+ac=;
        b=aEkfRug4KlqYZjJo5ZErk/moyKiNQi/MnSkcHOoqncAfNo/gfbDFRosb09swb9Akgd
         M4YY4ipVtk00yszKs78XtqGZuOx8FM3kHIX1a48YG8PkIVcNP+eNIR0gQem34119jBHC
         4oVKvlkC7g/4H6oJkuBt56Hcm2WNQN/+H0pG8YnxLkuusPZPuFYXfb9we3uSQyEqHNbV
         ZJQ2glm8VK0R6sEiMIHnfJWIX4SpfWOYX9g6ppYqnt/niuTqP4FtiNI73UZ/4EVCafpH
         ZQ/5DmYViA4+zTE9mmBdp8TTsiocNVt+QtChtntGYiKIjv3nA5zwhqujSBou0Qnk351n
         n19g==
X-Forwarded-Encrypted: i=1; AKwUvBx4+D6x/QeoiMgjza7XU6K1NIxA7p0CRSemvgnDdiRCjkvvWfWoW0igmPwhzRvVVB1HugLCjrM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyQiPV0bZ82pCz+gG35Nh2C9wvOosIPm2SJrJLhN1qgnyA14kL
	K8jqZszxdKcRRP12UxOtenHEnPJwIw4nrezQZBaxr2h0zhF4l4Ugf8QBRoeYxGUtUCDkxEBLfXY
	6XP7vsg==
X-Gm-Gg: AYBFou1VoQM6sZGRYE+V5Xfu9LGgrP6kqqiYQ555XQlqV6ZXaQ6ebHFcVnBfjbjrDUp
	i8sFIL+zGycb7eadNdZ1jzSJB0IsZbyKdZw6cca3XDPc/Id1NvaCqPNkzvkE7i4eZqJmMWNJdp/
	uw+cJGkgBoivuOk+1ZAO3L1+BpB7q0oPA/Dt2UMWOSc+YCWXsMtVGUmOq0TFwHyJjR/r1W1B/2p
	xH5ej9zKPiquLmojbVHDmXpNuILFdMazF1/Ijjv+OHD/inblI37Y8+WEQmSqu7xq/jYKPUm7VIh
	WYkJBVe8EFZbaO8OMq83R/G1WpHpFh+OpvVaCT4Pf5jajEco3FmkYNLuWU+plEZMHapkoLEpoFT
	52EzLd6idcMJzvMXW8DWKroAUHG5YKzbaMkPHehybwVBgFsTAzAlou45ax9jzyIIK5WBazEd3ZR
	VznYa32I0HDl1Q40cNMKltgeaWn90gnvrL3gpXmOTXLx4uyCkjX11U/y/MjP/fcykJmr9NwJH88
	tX1zFBBa+hw4h0drpbOB4m14YGnHtCzJ2y9Nst/tSKa9GzJgj27KrT9
X-Received: by 2002:a05:620a:439e:b0:939:7683:33d5 with SMTP id af79cd13be357-93f6f79bc6emr542030585a.19.1792782904116;
        Fri, 23 Oct 2026 12:15:04 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9404722eee0sm92440885a.14.2026.10.23.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:15:03 -0700 (PDT)
Date: Fri, 23 Oct 2026 15:15:00 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Igor Putko <igorpetindev@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Oliver Neukum <oneukum@suse.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: core: hcd: cancel giveback work synchronously on
 stop
Message-ID: <e16930d5-375d-4d61-9e37-94dc9a83ba64@rowland.harvard.edu>
References: <20261023174015.54793-1-igorpetindev@gmail.com>
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
In-Reply-To: <20261023174015.54793-1-igorpetindev@gmail.com>

On Fri, Oct 23, 2026 at 08:40:15PM +0300, Igor Putko wrote:
> When an HCD is stopped/removed (either during module unload, driver
> unbind, or an error path in probe), pending URBs are unlinked and
> completed. However, for root hubs or HCDs with giveback done in BH
> context, the work function usb_giveback_urb_bh() may still be executing
> on another CPU after __usb_hcd_giveback_urb() finishes.
> 
> Since the caller may immediately free the struct usb_hcd via usb_put_hcd()
> after usb_stop_hcd() or usb_remove_hcd(), the running worker accesses
> the embedded giveback_urb_bh structure after it has been freed,
> triggering a slab-use-after-free write detected by KASAN.
> 
> Ensure all giveback work is fully flushed and cancelled in usb_stop_hcd()
> by calling cancel_work_sync() on both high and low priority BHs.

Sashiko's criticism has a point.  If there are any URBs still pending on 
either of the BH lists when usb_stop_hcd() returns, something is already 
badly wrong -- that's never supposed to happen.  Whatever it is, it 
needs to be fixed in the driver that submitted the pending URB, not here 
in usb_stop_hcd().

Alan Stern
