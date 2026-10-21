Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578377;
	b=w6Tb+zzaUuZ3OrCCswY+i+C9fhn0GjnVZg1OXjQewO1nITz1FD1vYPKxpm7Uw2mj/fmo
	 v+DkwVnDwSXilGAjRDQ1NSqWhtCbcSo3FC9FP6NwLgUKHfN9LjENDNhaBO0ONshYOFc8B
	 52j4mmN4Q+qx9y9R/7rwMaLJ89RODan8xh/6et9eTQIu9zyILHYHMgRP4yzI7OKGdV2WM
	 m/8d4Xkztqeh+uKto0Al2EYjRR84vBq8nEiI7Pr9ExS7KQZWCr7DIObcPevTzZLdTd/Qs
	 3Hi6ZSicB3W1VIhgef9Ms9VPYwPRJCESTi7lsVquINhzoD5DbJoTHDX51u2UH3Mz0iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578377;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=/nflRbylx/h34L8KxHrPbZRKVSvB5v+NuXRPoeKgSQM=;
	b=m/bXjePTNXTNMReMObbiS8jy8WnuphthnE9AS3acFsn+JpyG0hb246NJPayTjRtwNDis
	 68YghFILugQukULGofMjRBlWgEC0zaGaNFPrY93NM6UDeBgB4V+sRmQKl8dKe3p8AqpVc
	 Qbt+b3EKij9tW3u+Hbzc55EbnqiWCKSnBZwrbPZG/YBjdgT83kLtWpdT0XaAKrU+89z5L
	 8J1G3czFWKyHZBgj0rIkX45JvGrZAyWcE+Jofm2q4ZQhjLqlYwTW9O0eyV+4jgcCmkdVW
	 Akwr7qvyIXAUjvjJb+Fv0sxC8WK9X9hdvSVaB45ExCitnovvZsYaV45NAxqRieQCrvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQUD+ZQy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114B606A319;
	Wed, 21 Oct 2026 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQUD+ZQy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AEE1F000C9;
	Wed, 21 Oct 2026 10:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792578376;
	bh=/nflRbylx/h34L8KxHrPbZRKVSvB5v+NuXRPoeKgSQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RQUD+ZQydBPeblVHdapK1/H8RTmtfLtjDJzJPUHy3BQ9MQaYQTOSiSRmAM4zmMiJy
	 TkTMe2iv6iasHFYI5Zf39eY3QG5dBlllmu6rXqRkB/bEYgUjMlXBlKbFPLBI9yUqbs
	 enHYIJLD1dbDpoFyySQF2h8lvt7k6LFIHhEt3K5OG2He0OWLtrWF+ByT4vRwd9qDMQ
	 IkqhSYY6S4UxHp0TUN96Au+RWIadsSbOxax0BiiUk0GWHvLe13fd9CzppmS9wzOWsL
	 Zv7gDcCNpnhX9MqOzhrf7xHowb/rR3EAyLexBXgK6ZDbg+GRc7UkQcoX5VbfGlK/0a
	 UqWbMfbGxAqgA==
Message-ID: <f4c591d0-304a-49d6-8892-d28124767a55@kernel.org>
Date: Wed, 21 Oct 2026 12:26:13 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: uvcvideo: Add quirk to retry SET_INTERFACE for
 SVBONY SV105C
To: Ostashow Constantine <ostashow@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261019-sv105c-retry-set-interface-v1-1-ab2f08bc3fcb@gmail.com>
 <20261019111712.GP595565@killaraus.ideasonboard.com>
 <449eb143-37a8-4044-a071-63fe495c0213@kernel.org>
 <20261019112726.GR595565@killaraus.ideasonboard.com>
 <CAAquLuDc==WsbOYTfuKV2tspTSQAvB7kg2r2aqbE2rs3tYx2LA@mail.gmail.com>
 <d2d5e53a-ba8b-4b66-8e15-0c45e08e0f3f@kernel.org>
 <20261019123803.GA855235@killaraus.ideasonboard.com>
 <CAAquLuBW3MaBZgxQt_Kr7L2jGQf6mXarRtKi729-44DqwC=CnA@mail.gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <CAAquLuBW3MaBZgxQt_Kr7L2jGQf6mXarRtKi729-44DqwC=CnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 19-Oct-26 14:20, Ostashow Constantine wrote:
> To: Hans de Goede <hansg@kernel.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro
> Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
> linux-kernel@vger.kernel.org, stable@vger.kernel.org
> Subject: Re: [PATCH] media: uvcvideo: Add quirk to retry SET_INTERFACE
> for SVBONY SV105C
> In-Reply-To: <20261019123803.GA855235@killaraus.ideasonboard.com>
> 
> Hi Hans, Laurent,
> 
> On Mon, Oct 19, 2026 at 02:33:11PM +0200, Hans de Goede wrote:
>> When you say "then queurs the control transfer", you mean the control
>> transfer for the SET_INTERFACE, right ?
> 
> Yes. On Windows the order is: COMMIT completes, Configure Endpoint
> command (about 3 ms), then the SET_INTERFACE control transfer.
> 
>> I wonder if the problem is that Linux is missing this Configure Endpoint
>> command ?
> 
> It isn't. I traced the xhci-hcd events on the Pi for 20 stream starts
> (MJPEG 1920x1080, auto exposure). Linux does the same thing in the same
> order, because usb_set_interface() calls usb_hcd_alloc_bandwidth()
> before it sends the request:
> 
>   COMMIT status stage           Success
>   +0.07-0.46 ms  Configure Endpoint (Add: slot 1in, Isoc IN, maxp 1024,
>                  burst 2, ESIT 3072)   0.23-0.26 ms, Success

I wonder if it helps if you insert a fsleep(3000) here on the RPi case?

So that is sleep between the Configure Endpoint and the actual SET_INTERFACE
ctrl urb being send out.

Maybe for some reason the RPi XHCI controller reports ready here too
soon (or Linux XHCI code is missing some check to wait for something) ?

The reason I'm looking at this is because you say that on Windows
this takes 3 ms, so it feels suspiciously quick here.


>   +0.06-0.11 ms  SET_INTERFACE alt 6 queued, doorbell
>   +0.9 ms        Transfer Event 'USB Transaction Error' on the Status
>                  Stage TRB
>                  Reset Endpoint, Set TR Dequeue, Configure Endpoint
>                  (Drop 1in), Configure Endpoint (Add 1in)
>   retry          SET_INTERFACE alt 6, Success after 259-295 ms
> 
> The first SET_INTERFACE failed in 17 of the 20 starts, more often than
> the roughly 15% I see without tracing, and the retry succeeded every
> time. When the first attempt succeeds, it takes
> 260-262 ms. The error event always points at the Status Stage TRB, so
> the Setup stage was accepted and the transaction error happens in the
> status stage. That fits the guess in my previous mail.
> 
> Configure Endpoint itself is faster on the VL805: about 0.25 ms, against
> 2.7-3 ms on the AMD controller (see below, the same under Linux and
> Windows). I don't think the timing explains the failure, though. The
> fsleep() test in my previous mail put 1 to 300 ms between COMMIT and
> SET_INTERFACE and did not help. On the AMD controller under Linux, the
> gap between Configure Endpoint completion and the SETUP is even
> shorter than on the Pi (0.02 ms), and nothing fails there.
> 
> On Mon, Oct 19, 2026 at 03:38:03PM +0300, Laurent Pinchart wrote:
>>> Have you tried reproducing this on a different XHCI controller then
>>> the one found in the Raspberry Pi 4 ?
>>
>> In particular the same one as the system running windows.
> 
> Yes, now. I booted Ubuntu 26.04 (kernel 7.0.0-30-generic, stock
> uvcvideo, no patch) from a live USB stick on the Windows PC. The camera
> was on the same AMD chipset xHCI (1022:43ee), behind the onboard GL850G
> USB 2.0 hub (see below). The test was MJPEG 1920x1080 with auto exposure
> and v4l2-ctl --stream-mmap:

Ok thank you for trying this. It is good to know this is a problem
specific to the RPi XHCI controller or USB2 hub.

Can you try the camera on the RPi without involving the USB2 hub, or
are all ports routed through the hub ?

Regards,

Hans



