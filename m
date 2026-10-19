Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792423220;
	b=en1pc0E1iHBZ9O9KIvJSUvPSZh0OhSliE0v7/CkpwOnbNV0uuQ+Tp5mOL086f7HuuMGz
	 ZHmd7mQ/i6zdB8RR6h9WHId7qX00unsSc8Ag2pbjAMqFE5kE970MjAucflz31CPcDidJ3
	 gdzGWkLXWdN969Z/OVEsYiIVxeL+wf/qlzwTGKbxVHvEjKp819A2nNnsKZYLlEHHsYSfh
	 MA9H7Wr6rPN2cHdCkLaYt/GU6dxVt/BknRDJWL9MC4IKlQRxPXomO8EHkm6f7oZ1jtR/G
	 m/6nY6/UxvCL0CUx83aUfPxKj1LLrHEityEMFaoTCii95ZI4d0fuCbi9udrbhDy0GdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=mWjkGewxAcRXbaVfdvgorur7bESLlKy5C/veEUL3TVg=;
	b=wAUlLy75o6vmzYOlNUxMSg5qSnlU/j28JZNrDhhy6RMUSm4YFLcWWYtZ7m3JVRjpxS9F
	 Z2B+0dhVorhAdhDzT/5DgP0nihigdahgGsCyhHZhAccd7epOe9uysAMJ25G3Lo1jc0afo
	 VjFGfnbdexplwoQLe+hQdl2Hs0Qtxe2E7m3kqiENcQYtYmrsSGFZsYJdQDmJRYHQRqJ1X
	 siSWdGIVw4J+8kCLipqCX9JJLL7pryC9ACXM/yMGR/3CdH47OTW6UfhA9OndypkwVIn3G
	 rV7u/HUKfo4EXIE9cqqlAXIXWnNdCcnSYw1jr8NBAj4sgcaP5Oazv/g11rxgAHomkhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rCMUPJ51;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D120860A6F72
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D120860A6F72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rCMUPJ51
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3514b90bb89so5716200eec.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792423219; cv=none;
        d=google.com; s=arc-20260327;
        b=WXVaP5m3VRmyb3YMZb51qHENr5UzfVAqdqpaJVFANMIZW8FMn247/VGiMJgCe/NXc+
         LxXKFx90elC5xpI1M3DAFRoA6Yk79+XObtAAQ7mdk2+UvRFCYPmTShSyYrEzkky0wVO6
         QZwotXH3s7CVUx0EQw3Da6/8FFhjCT+FGc+8xCV7tfUkqUqCfpB55auqRJLzykN4A+NY
         E9V15K421u8ZPCFkBu28OxUgyz2XhOM6yCUiGYKshF+xCP20Mk899kSIwI81TgIm73sW
         LaIGbWrMXECr4H/igT6fiK480GlvrQuXbOe2V9u+5j+7rnyb6zYSbnLSJsATgvAcKz2M
         TrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mWjkGewxAcRXbaVfdvgorur7bESLlKy5C/veEUL3TVg=;
        fh=pgD0SFfs0iFKSkpCoB/ClMwRn+s5N/tQIXyCVTRLZ9U=;
        b=NVCC9Jeg7dmbYBtzmf0Hsk7jd3bt8wbSYAru4qagGwEtNnMEoDITSh/EvftPIgQpU9
         Ieqanj8mm2tGRPJpZZGclBeIIWhcDztJkiS3i43kqIGckNl1+MQqYMSfG5tg9XwLWYrt
         vCulRY34iNfRpqwVY45V/qVrPqv07B+fnoTgWSY8euFROROMrjZ3bv3V881UCGyuthCL
         VEl/Ohr7BOkwF8vB+6jmqf1OKqTPq9DxsnmKjghe6dH5/XjN6wJKibnT3mpMiD7Tzw0R
         TdQ6aHlu3NtnDcHDR2rc81LN5EUivDIDcZ4dDfmi5JcLQXkv1491xgBNHyHQHlbw/Vfh
         hOZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792423219; x=1793028019; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mWjkGewxAcRXbaVfdvgorur7bESLlKy5C/veEUL3TVg=;
        b=rCMUPJ518Q/g4MafTGXS2YOV4ONjKUAugqtcCJ9mL/BGHWbfl65Ba+qC2dfbMP5Uwr
         DPJtRI2RSuri5YNZubUMACeh7jlMAmEx4faToEqDJ5NBF9JAicYv19vtWtrxJ412uCp3
         ZyOxZkWEjIdk0dZ6H8Ngl6AMzPjoyEDw2MlKrleENalkbWx7X9iFWhSFAP/8Q468zWeY
         VP0IeK6hgcQFGVDMIeRVeF/ACPgiVRGgZOqqOeZVOZFU1H/sUwtZkRDWtRO6TFRe2PMZ
         d9FcCu8VzUoB6pwUb0rZ5/vIqc+zzwAym8vGTGMm7Hs/jS2UofdnYjJqk9WJcbaXskPM
         1u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792423219; x=1793028019;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mWjkGewxAcRXbaVfdvgorur7bESLlKy5C/veEUL3TVg=;
        b=FmRpky4JM1DqNgv8Cz4CgPHKIKh/0XXXtQ1KfSt02kPm6r4FpzAslxlW1fdIwHFeE8
         H09OEHj+eq+mCierJ1LK8GyOUBjHFjbg9+3B8136dN2EexgU0iAOtnvpq1FprMgyceFS
         6NsKzNyvngTMi4uoanRE/q4l4i2jnR94L2CDl9C1ApqBSlaAQDVE2vnws0LWU5sIjSkp
         muaFVkmzleCvC315qY1SmKrIuV4tc+dIEaMbRGRKCaTOxZ59H6swWq/hkdxK+CWfFU05
         8RV8/Z2eC+I68Zz00Zcw5icrFbQJpXV7FQBVjfQ5TdL5QgwfjaNVMlConrmKfIqEhggF
         FNYQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9Kc59XAua0Aw55mC4jWLaAlv7+eZjnFbJVX/yTHhOemiRYpZH9FYk7jkl4y1VRVUWZpEqEms=@vger.kernel.org
X-Gm-Message-State: AFq9FYLONDkm6YWRKNs1Jia9m2Qbwg05nlyR2TfC9h1lAiNRlQVmuyhA
	JioGufgpXPeBb+o/kj6DgKHfnOugU+9pmQrf9JqPj/8JaSxTxpHBDK3FupeRkAlhjf+biDEJwrT
	jxe8WmpQNg3QyeW2aWqkWnM8WyN6qkYQ=
X-Gm-Gg: AYBFou1bQrkSDX9Q+EXxheRMYg6UqG5bKsynyxcdBBzc+UcLYMfZIBxynGo7JIpI8bl
	V0zvRihRuQpEursbePh2NlPwzuB/SoqWsWbQxNRykD+7eKuQDzIAXc0uTsddAgnikRSo0NKtSnR
	82oU4JzLxLSQFZ6wk3qC0rPFKHCXjPSjPCUot+193O8Jl3Th8aN+7Li7uTQcI7LXHCqOlB3BC4j
	OdwrGvymqN8j9Bx5yxkdJgcBp3suhF+Io+Q7512IZ8PSo1/4FYojldtP9kcGWy1zV3FQjh3uRBQ
	+2a0l5Vn7tBD1acKksPapt2Q9I+TY/RodjYoqiH4eVO52NnFCTEXL0LP9DBeTAtunLXxPGbsAb3
	wuaAMgcAvCHfX6OsFX1zckIbG4Qfk5QVzVwbNlgdk0BVMivI2blyeueHd/gu0x0Z80pZoLkgjJI
	uzWnfLimDjliCjk2gr
X-Received: by 2002:a05:7022:f51b:b0:14a:a6dc:9ca6 with SMTP id
 a92af1059eb24-1850d087d4fmr11645084c88.3.1792423218217; Mon, 19 Oct 2026
 08:20:18 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-sv105c-retry-set-interface-v1-1-ab2f08bc3fcb@gmail.com>
 <20261019111712.GP595565@killaraus.ideasonboard.com> <449eb143-37a8-4044-a071-63fe495c0213@kernel.org>
 <20261019112726.GR595565@killaraus.ideasonboard.com> <CAAquLuDc==WsbOYTfuKV2tspTSQAvB7kg2r2aqbE2rs3tYx2LA@mail.gmail.com>
 <d2d5e53a-ba8b-4b66-8e15-0c45e08e0f3f@kernel.org> <20261019123803.GA855235@killaraus.ideasonboard.com>
In-Reply-To: <20261019123803.GA855235@killaraus.ideasonboard.com>
From: Ostashow Constantine <ostashow@gmail.com>
Date: Mon, 19 Oct 2026 15:20:04 +0300
X-Gm-Features: AclHuK9PK_erQka1AjpHe9yUHPuX_p02w73ldR6AFrXTpE4OCE3wcIh6ni5FniM
Message-ID: <CAAquLuBW3MaBZgxQt_Kr7L2jGQf6mXarRtKi729-44DqwC=CnA@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Add quirk to retry SET_INTERFACE for
 SVBONY SV105C
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To: Hans de Goede <hansg@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro
Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Add quirk to retry SET_INTERFACE
for SVBONY SV105C
In-Reply-To: <20261019123803.GA855235@killaraus.ideasonboard.com>

Hi Hans, Laurent,

On Mon, Oct 19, 2026 at 02:33:11PM +0200, Hans de Goede wrote:
> When you say "then queurs the control transfer", you mean the control
> transfer for the SET_INTERFACE, right ?

Yes. On Windows the order is: COMMIT completes, Configure Endpoint
command (about 3 ms), then the SET_INTERFACE control transfer.

> I wonder if the problem is that Linux is missing this Configure Endpoint
> command ?

It isn't. I traced the xhci-hcd events on the Pi for 20 stream starts
(MJPEG 1920x1080, auto exposure). Linux does the same thing in the same
order, because usb_set_interface() calls usb_hcd_alloc_bandwidth()
before it sends the request:

  COMMIT status stage           Success
  +0.07-0.46 ms  Configure Endpoint (Add: slot 1in, Isoc IN, maxp 1024,
                 burst 2, ESIT 3072)   0.23-0.26 ms, Success
  +0.06-0.11 ms  SET_INTERFACE alt 6 queued, doorbell
  +0.9 ms        Transfer Event 'USB Transaction Error' on the Status
                 Stage TRB
                 Reset Endpoint, Set TR Dequeue, Configure Endpoint
                 (Drop 1in), Configure Endpoint (Add 1in)
  retry          SET_INTERFACE alt 6, Success after 259-295 ms

The first SET_INTERFACE failed in 17 of the 20 starts, more often than
the roughly 15% I see without tracing, and the retry succeeded every
time. When the first attempt succeeds, it takes
260-262 ms. The error event always points at the Status Stage TRB, so
the Setup stage was accepted and the transaction error happens in the
status stage. That fits the guess in my previous mail.

Configure Endpoint itself is faster on the VL805: about 0.25 ms, against
2.7-3 ms on the AMD controller (see below, the same under Linux and
Windows). I don't think the timing explains the failure, though. The
fsleep() test in my previous mail put 1 to 300 ms between COMMIT and
SET_INTERFACE and did not help. On the AMD controller under Linux, the
gap between Configure Endpoint completion and the SETUP is even
shorter than on the Pi (0.02 ms), and nothing fails there.

On Mon, Oct 19, 2026 at 03:38:03PM +0300, Laurent Pinchart wrote:
> > Have you tried reproducing this on a different XHCI controller then
> > the one found in the Raspberry Pi 4 ?
>
> In particular the same one as the system running windows.

Yes, now. I booted Ubuntu 26.04 (kernel 7.0.0-30-generic, stock
uvcvideo, no patch) from a live USB stick on the Windows PC. The camera
was on the same AMD chipset xHCI (1022:43ee), behind the onboard GL850G
USB 2.0 hub (see below). The test was MJPEG 1920x1080 with auto exposure
and v4l2-ctl --stream-mmap:

- 50 stream starts without tracing: 0 failures.
- 30 stream starts with xhci-hcd trace events: 0 failures. Every
  SET_INTERFACE alt 6 completed with Success on the first attempt, in
  261-262 ms. There was no Transaction Error and no Reset Endpoint on
  the camera's EP0 during stream start.
- The order is the same as on the Pi: COMMIT, Configure Endpoint,
  SET_INTERFACE. Configure Endpoint takes 2.73-2.94 ms here, much like
  the ~3 ms under Windows. The SETUP is queued 0.02 ms after it
  completes.

(The only EP0 errors in the trace were two STALLs of
CLEAR_FEATURE(DEVICE_REMOTE_WAKEUP) when the camera resumed from
autosuspend. They are not related to stream start.)

So the same Linux code works on the AMD controller, with or without a
USB 2.0 hub in between. The failure looks specific to the Raspberry Pi
4's VL805 xHCI (or its internal hub): the status stage of this
particular request ends in a transaction error there, while the AMD
controller simply waits about 260 ms for the device to complete it.

> > Likewise have you tried reproducing this under Windows with an USB2.0
> > hub in between ?

Yes, now. Same PC, same AMD xHCI (chipset controller 1022:43ee). The
camera sat behind the board's onboard Genesys GL850G USB 2.0 hub
(05e3:0608), the same kind of topology as on the Pi, where the camera
is behind the VL805's internal hub. 120 starts with ffmpeg/DirectShow,
MJPEG 1920x1080, with an ETW trace of USBXHCI/UCX:

- 0 failures out of 120.
- Exactly 10 control transfers on the camera's EP0 per start, as on
  the root port. No retries.
- No Reset Endpoint command at all. Every xHCI command completed with
  Success: 240 Configure Endpoint (alt 6 and alt 0 per start); the
  only other commands were Stop Endpoint and Set TR Dequeue.
- SET_INTERFACE alt 6 takes 262-263 ms, measured to the first isoch
  transfer, the same as on the root port.

So on Windows a USB 2.0 hub in between doesn't make the camera fail.

Given that, how would you like v2? I can keep the retry as a UVC quirk
for this camera, or try to describe the VL805 behaviour to the xHCI
maintainers if you think it belongs there. The Pi 4 is a common host
for these astronomy cameras, so the quirk would help users either way.

Regards,
Constantine
