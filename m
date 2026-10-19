Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DF94E50D8
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411133; cv=pass; b=gySUrTrn6DrrJP5R5/CTM3nmdsiDjrUy+nx8ISIs3sCJYuSqx4Kh89LTp0vyjqCmkyE7oxTXBtW6OaCc12l3cD0KilHRrm7lYZiK3GT6jCknc1cZH2i5BSQG/W9QUI8+vNDzsag8SVF+152MTWDaa/2nVOzUXT4kY5nbLiQ8DI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411133; c=relaxed/simple;
	bh=fj67lO3edxVDgvlqN8Zdz2Nd2dpZhUF61eD8eEdkb48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYAxpbigGoIIpPQpZOTWUYawYI1m+hrgGXtYZAhzdNOSTib2PEKuPMsfXn9f8CxSGDNO0jJCDuiaDeryOD1NcozO/xt+jZaOYPIrYJqRi8i92+RZIr+qIxROZvNJtPzo/6X7dv7ToZgu4M/EgFbpINQGbxAegNZurtlgWC5j1a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDIy3Et4; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDIy3Et4"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15354aa70e8so913746c88.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 04:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792411131; cv=none;
        d=google.com; s=arc-20260327;
        b=IlEDBJVVzOU19oRYx++GfmzTL7NLMjQnPO/IpPhN1uWtCCMlptElLxt1j61Uk89LLS
         rHbWUfiJ4b4BHT96i/rK35ytNCEDzkeYbP1lJYKKoaBIhR8eYQ2RoYzjzcvLuVaMXpf+
         71vxep63ZuLNWxyG2FDFCE76MTL4gl2nC5oVESaZpBmwzJ5uTfk4wka/gT6FyEm77QbM
         PNMFlrkaSur6gZYr07flIsMJ51LalfRndY8KGdP7IALrPnj5hCtqzh5iTxgex8o3a6DL
         31/nviY+fDHZKrBtv2GQ+fdvP7oPYVb5G0W5rF1fLoDWgmooajgwBepkRXmPa3HOWKwz
         Sjhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5dYf1TZbMSijaFd8YK2BOfOlVhvl2NvNeNo192tf8ws=;
        fh=FDXR2QoPjp3+GhwHomU9V8pn8bzpZnaQCcfB6EDGs9Y=;
        b=Q8+Niv/MGNv/GuEZdP/iz2S78VD7kvw/FBnKQQkHWjMBOvtue1ZC+fzqfxo04/FLo7
         D/TsFR1CPeK/VUGzhRyX1b9jWKXJdoWPrd/1IsIGPhUYzcClCKc8hkKuYC7oCahyIJdE
         mMd52tkCHkxvqvonYrddZne1yKWBHDLYY5Q3j0GwtW8Rfz7ALe3cjnMCvW9Xdc0q6Nbt
         X4n4J6Mogyh4sfgFl51iy1gDRB1ElE4k/VSaViOiviFupqUmAmYwArlmaIGRSgNh3kvm
         ISIzP2/EYJkc0OXwR9lAseLCZTzKbN8Q4WTxVx4sO6RgBobbMtxSavw+rI/X5n36WLcm
         OYuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792411131; x=1793015931; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5dYf1TZbMSijaFd8YK2BOfOlVhvl2NvNeNo192tf8ws=;
        b=QDIy3Et42ie3HmL9JSktzNb4ORoabqjBuSrlZyRkuMN1+mxRsRV4i8lRladWf7Y20c
         hny7aH4j/crwsBSDWsgc4eEM8kukyiNEnOoomrC8SnkAp62K8/+Sb132b5p78KUV1/em
         JA1SHWa3RShBRNIR5MZ58pxR/2KEkADY7IIcb8yfOjGMWmFby/JLvTG4Rk0Xx46v7K4r
         0/oQVK0MJgfLQW5BhMSuRl7DELX0vnRF2SHajAvm2/28rFK2OU09LQyOwsRXnk1P7Ij1
         Lf6bEXmnZ8eyzeBvf3gnFjSLvRTqsZpzAj2a4coZPUZk2v9/JXRwRJNzDb3KlVc7kBGH
         VXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411131; x=1793015931;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5dYf1TZbMSijaFd8YK2BOfOlVhvl2NvNeNo192tf8ws=;
        b=YFhD6N9zyoHM6CewzDO2AQsTOQAq4QlrPIiP4abJTJ1sujJUi63PhVyN3PG40JBbVS
         5kiPi9ShgDmiuv/zWiWTdDMb1aefVQK1sL69TfNBD278WZ5olL4mYJkyS+B2Vy00ZW2G
         skMZSQw8HOXZYFs8ehdtMWy26datj4T4nd/oDPE79PCWvsr7M24h7IVw3L7U+UZVPlOY
         19DxycyfmxDm30Tg8p+xoRVYyb3atMTB8Ky4+ZpYaPvO1sS4haRi9ftIpe2w6ryIujW8
         phx7bhu0WJsJietAVfJf21YUgNKXNSFHDc1PJk4GCFWg0+f5KFVDLYCly2KECVJbcARk
         kLpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxuDqHPtUT38BvGQHaKwC4rmp95xz7HA8eLu0m9/JAs2tr1CSxvt3GovTY13lm45QeLI2CPOG4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJ0BcnPrrlfYj+hcJRzZ982D1JbLNrJkVa4w9Byt36QerrPU+o
	xN5H0VQrotQK9g+NxJo3845pX8nvICE69iXFvk65aIOWUvfrLHIV4h3Lq6cdlquvbeyT0+VrgWG
	hPpZSUK485nMuOBJsfg472Vldp9MVckM=
X-Gm-Gg: AYBFou34Z7SpyLrNnvwYZzGg/OqDwXpeGqfUAcDbZYVGOnAtd6pP1flF1p6wyIT0uXU
	PWlwwBvDbMwzueW1J5yUtpSVbe34Yk6ZdAsk8nXdb2+FbI9PaV8iZl+hV2CsUhWvgpnlUBRhcha
	nkbXg9rrELL0VEjEFCge450wLXRbi5516fpJoWYTs/ph7IjmZCOiUZzhknFmlkA5i02PJBvq9ov
	FzBLNuDOHmYOwO/bsPG0sjOkSQe6VCAs1wPEvKLZfpJRRypo2MzPNmi928YlxVoWP2N63f1hjl6
	wHrJmxEvhg+t7C1f+RfcioTfMLYkDYKhYiWOwWB+vY50xgKso5QzgxDk1bX4YSln
X-Received: by 2002:a05:701b:260d:b0:185:6b47:dcf with SMTP id
 a92af1059eb24-1856b470e22mr10309664c88.36.1792411131321; Mon, 19 Oct 2026
 04:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261019-sv105c-retry-set-interface-v1-1-ab2f08bc3fcb@gmail.com>
 <20261019111712.GP595565@killaraus.ideasonboard.com> <449eb143-37a8-4044-a071-63fe495c0213@kernel.org>
 <20261019112726.GR595565@killaraus.ideasonboard.com>
In-Reply-To: <20261019112726.GR595565@killaraus.ideasonboard.com>
From: =?UTF-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0J7RgdGC0LDRiNC+0LI=?= <ostashow@gmail.com>
Date: Mon, 19 Oct 2026 14:58:39 +0300
X-Gm-Features: AclHuK-LRHqWo9ViJ33OiTVWU8haG9ETAHoju0Ier-hutiYfpJ9-Czbp4j4W_n0
Message-ID: <CAAquLuDc==WsbOYTfuKV2tspTSQAvB7kg2r2aqbE2rs3tYx2LA@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Add quirk to retry SET_INTERFACE for
 SVBONY SV105C
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent, Hans,

On Mon, Oct 19, 2026 at 02:27:26PM +0300, Laurent Pinchart wrote:
> On Mon, Oct 19, 2026 at 01:21:49PM +0200, Hans de Goede wrote:
> > On 19-Oct-26 1:17 PM, Laurent Pinchart wrote:
> > > What does Windows do differently then ?
> >
> > I guess Windows always has a short-delay of at least one USB frame-time
> > between the VS_COMMIT and SET_INTERFACE. I think we should simply add
> > a flseep(1000) before the set_interface instead of adding a quirk for
> > this.
>
> The commit message says it doesn't help, but I can't tell if that can be
> trusted.

Fair point. I have measured both sides again.

Windows 11, AMD xHCI, camera on a root port, 120 stream starts with
ffmpeg/DirectShow (MJPEG 1920x1080, and YUYV 1920x1080 for 5 of them),
captured with USBPcap and an ETW trace of USBXHCI/UCX/USBHUB3:

- The requests are the same as on Linux: PROBE GET_CUR, SET_CUR,
  GET_CUR, GET_MAX, GET_MIN, SET_CUR, GET_CUR, then a 26 byte COMMIT,
  then SET_INTERFACE alt 6. There is nothing else in between.
- The SET_INTERFACE URB is submitted 22 us after the COMMIT completes.
  The xHCI driver first runs a Configure Endpoint command (3 ms), then
  queues the control transfer. That puts about 3 ms between the two
  requests.
- The control transfer completes successfully after 263 ms, every time
  (402 ms for YUYV 1920x1080). In a 100 start run, the ETW trace shows
  exactly 10 control transfers on the camera's EP0 per start (8 for
  probe/commit and 2 for SET_INTERFACE alt 6/alt 0). There was no
  Reset Endpoint command, and every xHCI command completed with Success.
  Windows does not see an error and does not retry. 0 failures out of
  120.

Linux 6.18, Raspberry Pi 4 (VL805 xHCI, camera behind the VL805's
internal USB 2.0 hub). I added an fsleep() right before
usb_set_interface() in uvc_video_start_transfer() and checked the
resulting gap in usbmon. 20 starts per value, MJPEG 1920x1080, auto
exposure:

  fsleep()   COMMIT -> SET_INTERFACE (usbmon)   first SET_INTERFACE -EPROTO
  none          0.35 -   0.90 ms                 1/20
  1 ms          1.53 -   1.84 ms                 2/20
  5 ms          5.42 -   7.26 ms                 6/20
  20 ms        20.4  -  26.4  ms                 3/20
  100 ms      100.7  - 108.1  ms                 5/20
  300 ms      319.5  - 325.2  ms                 1/20

So a delay does not help, even one longer than the time the device
takes to complete the request.

The timing differs between failure and success. A failing
SET_INTERFACE completes with -EPROTO about 1 ms after it is submitted.
A successful one, whether the first attempt or the retry, takes about
260 ms, the same as on Windows. My guess is that the device starts
reconfiguring right after the SETUP stage and sometimes fails to
answer the status stage for a few microframes before it starts
NAKing. The VL805 then reports a transaction error. I have no bus
analyzer to confirm this.

I also need to correct the commit message: the failure rate is not a
stable 80%. Today it was between 0% and 50% per series of 10 to 20
starts, with auto exposure failing more often than manual exposure.
The retry always succeeded on the first attempt.

With 0 out of 120 on Windows against roughly 15% per start on the Pi,
the difference is real. I can't tell yet whether it comes from the OS
or from the host controller. I haven't tested the camera with Linux
on a non-VL805 controller. I can do that before a v2 if it would help.

--
Regards,
Constantine
