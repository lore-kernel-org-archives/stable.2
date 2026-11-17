Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794875122;
	b=aXP7WvmGBQItxxytbmxWMC135SPfh5UXxKE4qSldwfzDpnnk6KfQI5K/h7iKORn6wKHl
	 BJonOoEB+Ifn1zkooQ2zt3k+3rYVvkzxi6dlyFfwEosVMZ83pUYK5WtGTyQFmrZzEXSB/
	 TqT6MRB/x4kyEG1qhYChjZuYTfQigv8n2tRDJLwIwINHUtxQwv+uWCKRVhESyX5OSN2W6
	 f5VsIvL7NCjfkrF7Rp98bfhBrnsWoY+lahY14Mb4zC36UDAXOUsUEbROxW7RH+0eq8Awn
	 0w46TMjqNL60ZGAbZGrdUJSxNDlwWSdUJy2TXfsw381yiRH6nHNDs4nZeOs+53/BAAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794875122;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:X-Mailer:Thread-Index:
	 Content-Language:X-CMS-MailID:X-Msg-Generator:Content-Type:CMS-TYPE:
	 cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=QGgWgQaBDnFhyxITg/5JYi2mF4ivdfxPk9uPLffvh5Y=;
	b=bSplrDYnlHn7FN8V/E9oCKLU0GX4f8MFhgDw2RBsu6yprJyqIsuRfYckQdM/CBgoltQ9
	 pVN+MqCM+a31+X+iUB6yC1EysX17JzrwKZyQIZPWp17lRTTufuSTYUkUYZNL3XAj+geaH
	 mzZ3Ytgsdc+avXk8u9qA2/1avzBp6UB0QaCQupEBW+v7kZRRIbQFhI/tNear+f6Kia090
	 C+UUHAk464E01Wc0q/xpRLdrcM3zlZIYL4Q2DmzHoDa6koCz9IIsytMZ1dA/yvM26uorQ
	 CY6d095FnDVERBTIOzRpCK1d7kmiYZPLp1Yl+LYkSFGg7KyvXxHYDJIt03cc5kd3RIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=TqvH7+H1;
	arc=none smtp.remote-ip=203.254.224.25
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D078606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 00:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D078606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=TqvH7+H1
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20261117002512epoutp02b2712e88350c9c5a9a68565a3892e5a2~orWeh35640602606026epoutp02P
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 00:25:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20261117002512epoutp02b2712e88350c9c5a9a68565a3892e5a2~orWeh35640602606026epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794875112;
	bh=QGgWgQaBDnFhyxITg/5JYi2mF4ivdfxPk9uPLffvh5Y=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=TqvH7+H1cp5lBxH+bs4vQw56hmQxaOU6ddxbKipi8sx5V+r3sAOUBYRaJ2zMcZrHc
	 QYNvbaqP00gs47yN7+fCABS5K3jb1G2m4EyAWH9+1wG2X1spDNe1TqNif5FO5iqZ0e
	 CkwQeNNGzrUEC0gL/0ABvBAo3ynb04W3pNPgapAw=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20261117002511epcas1p1cbe40920668da17a8929d2b8413456ec~orWeAUQLU1254312543epcas1p1B;
	Tue, 17 Nov 2026 00:25:11 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.38.116]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4jT5930lsjz6B9m5; Tue, 17 Nov
	2026 00:25:11 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20261117002510epcas1p375a79d93a0869035c4a60515a3e5f5c3~orWdI6qpy3154231542epcas1p35;
	Tue, 17 Nov 2026 00:25:10 +0000 (GMT)
Received: from gichoonhan02 (unknown [10.88.99.189]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20261117002510epsmtip28a571dc1e9b9308c6790eb6aa07979d8~orWdGBtyv0355303553epsmtip2U;
	Tue, 17 Nov 2026 00:25:10 +0000 (GMT)
From: <gichoon.han@samsung.com>
To: "'Alan Stern'" <stern@rowland.harvard.edu>
Cc: "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>, "'Takashi Iwai'"
	<tiwai@suse.de>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <5ed0f4b7-beb3-4059-9e12-b9738af65d91@rowland.harvard.edu>
Subject: RE: [PATCH] usb: host: ehci-sched: Don't let a bogus siTD remaining
 length underflow
Date: Tue, 17 Nov 2026 09:25:10 +0900
Message-ID: <000001dd762a$1b15f230$5141d690$@samsung.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJAw0W1MzUdd2pxp7jiVwua62XKywEoK6GMAU9T2V22VxCWEA==
Content-Language: ko
X-CMS-MailID: 20261117002510epcas1p375a79d93a0869035c4a60515a3e5f5c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261116052855epcas1p403c518b90d70d98752ad0ca2d9ac05e9
References: <CGME20261116052855epcas1p403c518b90d70d98752ad0ca2d9ac05e9@epcas1p4.samsung.com>
	<20261116052851.2272125-1-gichoon.han@samsung.com>
	<5ed0f4b7-beb3-4059-9e12-b9738af65d91@rowland.harvard.edu>

On Mon, Nov 16, 2026 at ..., Alan Stern wrote:
> The type of CPU doesn't matter as much as the type of EHCI controller,
> since you're talking about a controller hardware bug.

Fair point.  It is the on-chip EHCI controller of a Novatek TV SoC
(DT compatible "nvt,NT72668-ehci"), driven by ehci-hcd through a
vendor platform glue that is not in mainline.

> Actually the bug lies in the host controller hardware.  Not the driver.

Agreed, I'll fix the wording.

> So you have no way of knowing whether this patch really fixes the
> problem?

Not directly, no.  I don't have the siTD contents from the failing
device, so the claim that the controller wrote a remaining count
larger than the programmed length is an inference: the faulting
memcpy() still had about 122 KB left to copy out of a full-speed
packet, which can be at most 1023 bytes, and this subtraction is the
only place in the path that can produce a value that large.

What the patch does guarantee is narrower: whatever the controller
writes into the siTD, ehci-hcd never hands a class driver an
actual_length larger than the requested length.  The crash itself is
already prevented on the ALSA side.

If you think that is not enough to justify the change without
hardware confirmation, I'm fine with dropping it.  Otherwise I'll
send a v2 with the controller identified and the wording fixed.

Thanks,
Gichoon

-----Original Message-----
From: Alan Stern <stern@rowland.harvard.edu> 
Sent: Tuesday, November 17, 2026 3:09 AM
To: Gichoon Han <gichoon.han@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Takashi Iwai
<tiwai@suse.de>; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
stable@vger.kernel.org
Subject: Re: [PATCH] usb: host: ehci-sched: Don't let a bogus siTD remaining
length underflow

On Mon, Nov 16, 2026 at 02:28:51PM +0900, Gichoon Han wrote:
> sitd_complete() computes the received length of a split isochronous 
> packet as desc->length - SITD_LENGTH(t), where SITD_LENGTH() is the 
> "Total Bytes to Transfer" count the controller leaves in the siTD.
> Nothing checks that this remaining count is not larger than what was 
> programmed.  If the controller reports a larger value, the unsigned 
> subtraction wraps and the class driver gets an actual_length of nearly 
> 4 GiB for a packet that can hold at most 1023 bytes.
> 
> This was seen on an ARM32 system (vendor 5.4 kernel; this code is

The type of CPU doesn't matter as much as the type of EHCI controller, since
you're talking about a controller hardware bug.

> unchanged in mainline) with a full-speed UAC1 microphone behind a 
> high-speed hub.  snd-usb-audio trusted the value and read far past the 
> URB transfer buffer:
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

So you have no way of knowing whether this patch really fixes the problem?

Alan Stern

>  drivers/usb/host/ehci-sched.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-sched.c 
> b/drivers/usb/host/ehci-sched.c index 57d07d1c2dfa..12a10248a4b6 
> 100644
> --- a/drivers/usb/host/ehci-sched.c
> +++ b/drivers/usb/host/ehci-sched.c
> @@ -2241,6 +2241,10 @@ static bool sitd_complete(struct ehci_hcd *ehci,
struct ehci_sitd *sitd)
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

