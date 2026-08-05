Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABD62494D8
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 01:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893687; cv=none; b=lUldXpLA+R0+Ut3g/hFGi9tH96Jkp1a+WUaGqIjiXM4dYjZGlgUbGqJ3S1VA0qWvDjvLJPApwUG2Li8x2jNOmqjWOt8r85XsO4fhPTzCJlwPC0gjQixs7E23oRWvV+x4PhIdJFrzRd2zFBge91Z3MFu2Bt86U5WQHEivMkCZrnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893687; c=relaxed/simple;
	bh=6ggo468VqCJiBEAW/CY4gRyFscERZZi0d+FSNRqo7fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sjAVjmt4BY/fixB7OODOp5cZvGDRS+hDMg1MQ0YLL/LTmJkSGHfmY5b0x+JLwJ/B/eYbsXcHvuw1/YOo52U+m3SJvxsV9dG8mnImPFa7CdmYAk5Kfl72TTidmboeKj7pvBJ4NiZLtbBFGbI375URzhVmxWAJGTQ+aGG6mGYA1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=f5IG8uNz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="f5IG8uNz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf52d15d88so4512945ad.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 18:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785893685; x=1786498485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4cYrPAdGr78t7YkoLwcMiDz4Rg7VzdKjNoh6ElfleWU=;
        b=f5IG8uNzFilA+bx40PllHgen6xCmvCxpPtA5YGpIpz0e/ltOqlvTkHxL2IO35l0Gwb
         ICLo0tlLQ0zJEuiliXsoX9dYAChX9rZDREoueg/RBIGkanujl+uKZrC3wXVwbrDKv/Ua
         oUpeMJF5dwLHmyc8cbHyenvtqBv+7viuTB2UCqy++MzV7H70CHMD6d7CGngZ8N8fmIHU
         f2PoOWaxVfbwOmklUTxI24901jJp0Y7VKAR/sK2sP5CN4N4zeHPu7Jzak2E+ISJW2AJD
         HudQPn7ALTxL//rdvXHIeLMcTQDz7F6G5qTOhcXxthZigqla24PMVMaK0NYsD2b/AE7t
         zafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785893685; x=1786498485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4cYrPAdGr78t7YkoLwcMiDz4Rg7VzdKjNoh6ElfleWU=;
        b=KQD17rpdpb9gvtgTbKFz1yGGqfL+DoB9yTEKcCMYWbZ0Fan89F4i+snoxnhioVqq2F
         JiOMyLnjYbQyeyM+NgfKEudWYoF2937HiPv6nyA53WIdoYShZZH2muEITMZgjsG9e2Oj
         vhqU/nRrbywlPh3ZRKYtXvnKNsIQteXbxIpszgigH93MO/PmyYHZhhnPq2DQZ4lItBUu
         9D3+hz1n1Od4gvTw/0R500l2MSa8evtQIZzbVABSJzYveyG1paEB4v7qDhO8bbFWpl58
         pQFsBuUVLZgK7/esHUSfcrUFRTzO5WFDxcFw5ghUJWH4NeYPi9ydXbY9AjhXfr31HGZ/
         Nyqw==
X-Forwarded-Encrypted: i=1; AHgh+RqxbjZkuYTnoS5kWG/+pCKpwrP54JZnVkj7kW1pQjhLU+Lg63xcbr2V2lWYFuJ+Me3Ze8TjGnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvCbh9tO0iHExc8dYPTeGy5fI/fxHhsR0/YIsSFCXrtjIgn6Sx
	VmVxJBw/FM+MzdDSJFleqtwHayLSGbj9rcnLec0D6n/u94dLonCGw0aGx9ct9x4nzu4=
X-Gm-Gg: AR+sD12bcb1EbdIsidN/KRx7qHKxqDFQNk3liUQMVJXnVA1/uI7XRBcvCXbq+DOC5MG
	+99YFXUZqBGRXrrCAOPiJUUepaSYkpoy92kspfzc7EtnORztBV+SthUJonfRGOFWfDKclME7Par
	atEWBsSAd9oUD+fZGtbCG0rrjJRUA2uF9IOawCm3A32eJL9sRY0igKbfDWujEzVizArY3Yz7+0U
	dvfqrYhG8J9E9/LrkYZdXCju6NpfeNekE/SDpu+DUCTAY4B8UKA+DtohjjtW254uUNXIaG8792l
	sqb7FBVAC+eZggXSSYkor5YP9WcR0/CethpHg98hnASJXLZo4GFn93tOIzxxSnZyB+YMvBMQQ4b
	Y6Z0dhAVuDAgjvDjrhClsvcb5d4Knfi40ZLlnSxTTc4ZCoEYlkBZDj9UTMLP82SHPEQvIX+SSaQ
	Lpc8qAL+Dd/7bsNLKL/7AlKtnAYuBSaUK2DnUyWlolcJU6LxjaGESGJ62IU53BHUaHofbXAEVlF
	GD1x1UxQi8wFl3P9atzEztS1CfiS81kBoHCLYg=
X-Received: by 2002:a17:90b:5823:b0:38e:485c:ebd3 with SMTP id 98e67ed59e1d1-3903c5b727cmr3065888a91.15.1785893685187;
        Tue, 04 Aug 2026 18:34:45 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903d2f9807sm545246a91.1.2026.08.04.18.34.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 18:34:44 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>
Subject: [PATCH] ALSA: usb-audio: fix OOB write on Type II inbound URBs
Date: Wed,  5 Aug 2026 10:34:41 +0900
Message-ID: <20260805013441.38245-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

data_ep_set_params() sizes each URB transfer buffer before it adds the
Format Type II transfer delimiter:

	u->packets = urb_packs;
	u->buffer_size = maxsize * u->packets;

	if (fmt->fmt_type == UAC_FORMAT_TYPE_II)
		u->packets++; /* for transfer delimiter */
	u->urb = usb_alloc_urb(u->packets, GFP_KERNEL);

buffer_size is computed from the pre-increment packet count and never
recomputed, so for a Type II endpoint the buffer is one packet short of
the packet count the URB is built with.

prepare_inbound_urb() then lays out one iso frame per packet and never
consults buffer_size:

	offs = 0;
	for (i = 0; i < urb_ctx->packets; i++) {
		urb->iso_frame_desc[i].offset = offs;
		urb->iso_frame_desc[i].length = ep->curpacksize;
		offs += ep->curpacksize;
	}

	urb->transfer_buffer_length = offs;
	urb->number_of_packets = urb_ctx->packets;

The last descriptor therefore points one packet past the end of the
transfer buffer, where the host controller writes device data on every
inbound transfer.  prepare_silent_urb() and prepare_playback_urb() bound
their fill loops by ctx->buffer_size, so only capture is affected.

fmt_type comes from the device's audio streaming descriptors, so any
device advertising a Type II capture format hits this once userspace sets
hw_params on the stream.

KASAN on 7.2.0-rc5 (arm64) with a dummy_hcd/raw-gadget device, one report
per inbound transfer:

  BUG: KASAN: slab-out-of-bounds in dummy_timer
  Write of size 64 at addr ffff0000186171c0 by task cons02/166
   __asan_memcpy
   dummy_timer
   hrtimer_run_softirq
  Allocated by task 166:
   usb_alloc_coherent
   snd_usb_endpoint_set_params
  The buggy address is located 0 bytes to the right of
   allocated 64-byte region [ffff000018617180, ffff0000186171c0)

Compute buffer_size after the delimiter packet has been accounted for,
and bound the fill loop by buffer_size, as prepare_silent_urb() already
does on the outbound side.  This grows every Type II URB allocation by
one maxsize packet.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 8fdff6a319e7 ("ALSA: snd-usb: implement new endpoint streaming model")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 sound/usb/endpoint.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index dca06ba1c67e..a1d449f2a342 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -385,13 +385,15 @@ static int prepare_inbound_urb(struct snd_usb_endpoint *ep,
 	case SND_USB_ENDPOINT_TYPE_DATA:
 		offs = 0;
 		for (i = 0; i < urb_ctx->packets; i++) {
+			if (offs + ep->curpacksize > urb_ctx->buffer_size)
+				break;
 			urb->iso_frame_desc[i].offset = offs;
 			urb->iso_frame_desc[i].length = ep->curpacksize;
 			offs += ep->curpacksize;
 		}
 
 		urb->transfer_buffer_length = offs;
-		urb->number_of_packets = urb_ctx->packets;
+		urb->number_of_packets = i;
 		break;
 
 	case SND_USB_ENDPOINT_TYPE_SYNC:
@@ -1243,10 +1245,10 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep)
 		u->index = i;
 		u->ep = ep;
 		u->packets = urb_packs;
-		u->buffer_size = maxsize * u->packets;
 
 		if (fmt->fmt_type == UAC_FORMAT_TYPE_II)
 			u->packets++; /* for transfer delimiter */
+		u->buffer_size = maxsize * u->packets;
 		u->urb = usb_alloc_urb(u->packets, GFP_KERNEL);
 		if (!u->urb)
 			goto out_of_memory;
-- 
2.50.1 (Apple Git-155)

