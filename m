Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173242;
	b=TheR12P10LQ4Q6oqVhOrAd11n30WiSYsKmbaO4nbh1xKjdiX/+g+Y4qCXxqTZu8hXuyh
	 P7t6hIDCFdD9eGKS5CcTzYo4g9uNux0celOFTkmUjylr2l0d7qX5EV7+z+q8YwTIQEAN6
	 i1LPpMNpXVLWQ2z4ZTTMJk+Db3D66CRbytHEh4JGtYxU5OLCVtXCncTmkZ2I+926YlN2g
	 S/HHUxBOakikw/ty1QqYwR+1pnv9ZOM5+J408RVjwn7HoWtu22JVhjEwRlNrjdOHka9iy
	 +rtGOJ9vxGoFt1WT6PrypWVGBiKcSnoQ3EjTzR40EEfqBe1vA0bfYw19iXAB76k4PKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=c5TP8QN0A+61hAuSZdjk63ActRIUkjcmDfLAhcw9riM=;
	b=MTRy82aMj0v6+OAtRsiUbGw/Fqif819hHx6NsnJyj6gqZxlFTLxe3zEZmP0+OEsFJbBz
	 76SMqaqrkc/cOKnjzzXWOPsbgemSV/aMKQMpQI5lhsJ1TmS0gYomAp5WZz9wVJIk9tcvm
	 Kf+4ZQceFSqSxxqOAF69TaqtkxZwl7u9s7EV9whh8oHT8ZiGflcB1wu1hXezapxvWYLEW
	 PMHT5+D2mebccbMV76ME1x5tcVf+dNtobx+XloX0uRoMYkXZdQIMlT1smB9FGJGf3Pk8r
	 A0QzIeBdMaNbprRvYnIbiOucbMbIJAh5/hwWKzxshvVMlQG3BlD7GMNpWZnTHo86WeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fAodecJY;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88117606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88117606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fAodecJY
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so656954f8f.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 03:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795173240; x=1795778040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c5TP8QN0A+61hAuSZdjk63ActRIUkjcmDfLAhcw9riM=;
        b=fAodecJYdDh5FrLQntGkHTfvuTZG4mAqmgdlpnvwepAyDXsAoBKUgwtS+BdGC+QZQI
         NxKqqLZ/Ei6FNNWSA1uSl/QJ52OjQhL9KmxDFcaqb4daPgepHmwHR4ntiZjYtOPySAHE
         etzdAeZ1HUqVOf2fsEnVLTL0565Sy9sGlbhKst2zvg/P8bwybGMmwmwcihAMyQeTfWwb
         6+8ndLbJPLsux4RE69l2+m/GFp22WxKS78HMVnehbl/XKkyOjVTscrsLDLhqG1pJ8q0v
         BsbmFpuGIwdsW+t5JYufilRclbN2LHdbRBiG/BQ7hLLnuloGJegwXxAkKodjJhjkcqSL
         tXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173240; x=1795778040;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c5TP8QN0A+61hAuSZdjk63ActRIUkjcmDfLAhcw9riM=;
        b=tPE6P0nEudJigof+iHk8QFb3Y3B8bjfzMuz/v+DSFeozASr4vKQGEonzx6+nbe7KZL
         P7+w2gIJ528SAtne/J3kHp/BBjLD6E4Si/WJRTKQHGynl/WqMdbh5OaZ1p+SMpsEZcca
         K0ITDeevJoTh+jrXcpJ7r7aK2pEihy4CY14+S/DvEfvE9beuz354N2L5lBDTjMQK7ksV
         ps3MPARWlB3wrjrPpQfvZ866inkttgqRvVbUDD3PPX6fSJ1wvbvvAbCD+2haGI3SI/zK
         b/HBFe0I4vE1HNwI3zAsEYmi3hOzRtyGGWTi335JIiZ0xryGTSLeuaU0tcWWck0PRAf6
         LFhA==
X-Forwarded-Encrypted: i=1; AL+hErFb8oPRqVZKoKreZzK8WvplUrfRM+USowTZFF11CY9XfJzHxR9etAFmHw5r5ZYWdNNKIbqkneM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/v8i6F/LNuFC0o+/fP/L/SU1N02RCCcSjBfB0IXJX5O78uWuOm
	ujEptsLHfBEilYLSbtV/l0Niv2m1nJrhq7P6TyUALunhXWo7S2fSZvpZ
X-Gm-Gg: AZFdTZfUV1AxFgfKKd3KWtTC1IVOmw2g1madivXp9G6CSloDohnfUxjrA6PZurs8StZ
	v3wYa9DFCebk4hvKSU1Dd7V7CvrgINlQ3RlCq+/iK7CLb6AcSzDM7kl3dqIU496L31105gaQTOl
	va+yV7Rfa2NWRY7RNYl+4pHBifyBDUUT0az1kzbAsXTXDR2SXmy6op7Iwf/SMPQf7yFDcclKO76
	bgaDdujyU7zPWqsGfkP7R4TBBykHN3nbskB+UgTh9yg99KOX9jTdrH7xLCcOKahovyTzEI0DCQQ
	/1BwfGgaeFGAPKl4NSqgpdBhlaq77nLzzpSIwcNnC75PeVyLt/jvjZSXrsA96ozAM0gFuy7JmD9
	K8dqgPqhEBHzDXZqeWmimO97o/o1JAxu6rr5dJfOelzikl7ZxX7F67pWk0jQ3awbOl1d62pWiAV
	koWSLTfW0+IXuqAPxZ1nIdEp3sVNkPCYJn22ck9Imnry5MWu0yFZYMOUb1oHNRgAXTLoYDJPl4+
	NHU1jby7ra6WV6vz+GFqGTfjOceb162blrEDoxnhUcqlQyIF2Tihn+TwFuFozIaQxu6vyCXA80C
	CnFrHGhdNbdUtahKBKereJePraTKl1hZOfM7dB8RvYSqO8/ltB/YYdK6eyZHS0E=
X-Received: by 2002:adf:e012:0:10b0:48e:3697:708d with SMTP id ffacd0b85a97d-4abb0d51ab2mr3805002f8f.12.1795173239827;
        Fri, 20 Nov 2026 03:13:59 -0800 (PST)
Received: from foxbook (bfh118.neoplus.adsl.tpnet.pl. [83.28.45.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb41f4sm4905165f8f.7.2026.11.20.03.13.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 20 Nov 2026 03:13:59 -0800 (PST)
Date: Fri, 20 Nov 2026 12:13:57 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Riley Wagner <riwiwa00@gmail.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, stable@vger.kernel.org, "Mario Limonciello
 (AMD)" <superm1@kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH] usb: xhci: pci: do not perform Soft Retry on AMD 500
 series chipset host
Message-ID: <20261120121357.1e1a0ce4.michal.pecio@gmail.com>
In-Reply-To: <20261117193300.25897-1-riwiwa00@gmail.com>
References: <20261117193300.25897-1-riwiwa00@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 11:33:00 -0800, Riley Wagner wrote:
> Full-speed HID devices hot-plugged into a root port of the AMD 500
> series chipset xHCI host (1022:43ee) enumerate and bind, but never
> deliver any input. The device then resets itself after ~10 seconds,
> re-enumerates, and the cycle repeats. Devices present at boot are not
> affected.

I doubt that this affects all HID devices, people would have noticed.

What if it's not connected to the root hub? Is this important?

> With xhci_hcd dynamic debug enabled, the first poll of the interrupt IN
> endpoint fails with a transaction error, the driver performs a Soft
> Retry, and the endpoint never completes another transfer:
> 
>   [ 6658.313453] xhci_hcd 0000:02:00.0: Successful Endpoint Configure command
>   [ 6658.352348] input: ELECOM TrackBall Mouse HUGE TrackBall as ...
>   [ 6659.424165] xhci_hcd 0000:02:00.0: Transfer error for slot 29 ep 2 on endpoint
>   [ 6659.424170] xhci_hcd 0000:02:00.0: Soft-reset ep 2, slot 29
>   [ 6659.424290] xhci_hcd 0000:02:00.0: Ignoring reset ep completion code of 1
>   [ 6667.989369] usb 1-9: USB disconnect, device number 30
> 
> usbmon shows the interrupt URB submitted at enumeration and only given
> back by the disconnect, 9.6 seconds later:
> 
>   2562187476 S Ii:1:030:1 -115:1 8 <
>   2571824873 C Ii:1:030:1 -108:1 0
> 
> No further transfer events or errors are reported for the endpoint after
> the soft reset completes and the doorbell is rung, so the TD is never
> retried or failed.

IIRC that's the same HW bug which broke some high-speed Realtek WiFi
dongle and caused Soft Retry to be disabled in multiple variants of
Promontory chipsets. I actually obtained that WiFi dongle (long after
the fact) and reproduced the issue - it happens when a device fails
the first URB and it gets retried. Most HCs handle this normally, but
Promontory generates no transfer events and later fails Stop Endpoint
with Context State Error and the endpoint is "halted".

And I think I have seen similar issues on other ASMedia HCs in case of
disconnection and repeated retries and endpoint resets. OTOH, in other
cases this controllers perform retries correctly.

I will look into that, because maybe we could only avoid the particular
retries which fail (and also add a whole lot more PCI IDs).

> This matches commit a4a251f8c235 ("usb: xhci: do not perform Soft Retry
> for some xHCI hosts"), which disabled Soft Retry on the AMD Promontory A
> hosts (43b9, 43bb) for the same class of failure. Booting with
> xhci_hcd.quirks=0x10000000000 (XHCI_NO_SOFT_RETRY) makes the device work
> reliably after hot-plug on the chipset root ports tested (1-3, 1-9); the
> same device also works after hot-plug on the CPU's xHCI host (1022:149c)
> without the quirk.
> 
> Tested on an ASUS ROG STRIX B550-F GAMING (BIOS 3621) with an ELECOM
> HUGE trackball (056e:010c) and a PFU HHKB Professional HYBRID Type-S
> (04fe:0021), on 7.3.4 with commit 6895dbdc19d9 ("xhci: give back TDs
> and clean up ep0 after disconnect") applied. The trackball showed the
> same behaviour on 7.2.x.

I suppose the keyboard also had problems on 7.2?
IIRC it's that one which always disconnects itself on initialization.

> Add the AMD 500 series chipset xHCI to the hosts that do not perform
> Soft Retry.
> 
> Fixes: f8f80be501aa ("xhci: Use soft retry to recover faster from transaction errors")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202541
> Cc: stable@vger.kernel.org
> Signed-off-by: Riley Wagner <riwiwa00@gmail.com>
> ---
>  drivers/usb/host/xhci-pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -88,6 +88,7 @@
>  #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
>  #define PCI_DEVICE_ID_AMD_PROMONTORYA_2			0x43bb
>  #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
> +#define PCI_DEVICE_ID_AMD_500_SERIES_XHCI		0x43ee

I think "PROMONTORY_19" or "PROM19" would be better for consistency
with other entries (see also: commit 9e896b4a48c4).

And isn't 1022:43ec another PROM19 ID?
Does anyone know if 400-series or PROM21 have the same bug?

Adding some AMD people...

>  
>  #define PCI_DEVICE_ID_ATI_NAVI10_7316_XHCI		0x7316
>  
> @@ -493,7 +494,8 @@
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
>  	    (pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_2 ||
> -	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
> +	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4 ||
> +	     pdev->device == PCI_DEVICE_ID_AMD_500_SERIES_XHCI))
>  		xhci->quirks |= XHCI_NO_SOFT_RETRY;
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_ZHAOXIN) {
> -- 
> 2.56.0
