Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851539;
	b=o9Zzw6/+Oiv2f0ykMTmsYGJQYNnVl7ir7j7WQxcZCgBa46GzSUukE1lx2KtgRrPmJ7aO
	 tUIyE14wKbbV8sEp0uutHTS+AYsj0bFhZafEKjron3RxDvZOSYd324STHYFPniN0tzQFj
	 1cV9z0XW00lu2OY/E3acRkEnlmBq8uIOLxN6wLOfyICZvAX7gW0bsl+rqthgvVpddAtRS
	 lwqHaH4L+K7uzHfPxzEjj+YS9LFCqvCGuXCMKyaVA3XDSE8hYEZyS2RrA7OE8XRGQwRqq
	 V4jiIfNAU09mj7BqA6WmINwvzRgQ5U/YWLmum1LHgqX26pZaTPks1TxVhYSE4L6ByCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=433xRDin6SERxQl4zr7qCG8UKdvmvBEfHT10lpucpws=;
	b=tOVWV8dAO9VrqZxh05wLArY+t8rUU+W/weJLVF9lKHBt3fr3fbZZZjK63xDJ6zreAxsy
	 SpR+85HITs1sVDHlxafe4oSKerR3unX2kb7mNbxXyHA4NFAOMfdhUyTIM39yAmuGOZU+h
	 rm/eBXyUZVrMTC10fbU8jCt1wNHuUoNdzoNU39Dq4yQ0BArX4ipo04gZp4ahzoB9Mqam3
	 1R8Kb7V/hItmcQrczykKRohLXlqGDJGp3qLarggCfWxCkyRyMWf6gNLlJGmyf+YuFLJs9
	 4nLj3YJW0KChaV/Bdr3S+4hKPhKyakk5XsqyESMjnCSSJ+TbWqL4WWJi8F0bTT0cJ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WiiQQwfv;
	arc=none smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF98606A33A
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDF98606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WiiQQwfv
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bfbc67991cso2629624e87.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794851534; x=1795456334; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=433xRDin6SERxQl4zr7qCG8UKdvmvBEfHT10lpucpws=;
        b=WiiQQwfv3C1J+lYmCRVn+Rk4GZnRw+IphmS2VK6qOyfRA9YY4ipM2WuKUKlkI6ba/x
         2YqiFMyz00ABeyanHS/PS6TJRsN+Jj6RJHC4wnTyEbZxoEImDq411q8IKSuqnxrPQVv9
         Dc0l68dIxEIbm6whSJpHoVtUMz2t/3JXQhY74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794851534; x=1795456334;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=433xRDin6SERxQl4zr7qCG8UKdvmvBEfHT10lpucpws=;
        b=fC02lLPpUoyxgZ2MstFBYUWatNJ6mNv0JwR3NmmXJtJh++tkEVE9iJLNG3iXr8Y5j4
         zztM18Hzkq0EP4eaU0KXEFNJRNYeX7jocLQe8/pE2kUdAzXY1bVb1z7wLlH3kLZbAfbI
         Y733SEBqckI8xR+qTqI6qtVCCCRFYwpkzNlle9ab5cU0W41/kYt6ejvxoQjufLFnM4lt
         bJCl3FBCbTSlyzNTaKb1XsC5fZaiO0WIkUIVfSFHZDpNVXmChlOMh4sd+sBjoZVfoJbv
         Wb7g75Wh5ZYj+L03EWyRMzS+s9vcxA/3+ICumfAbN7iQQxJFomhppPra+b84q6DLIk1x
         /3ng==
X-Forwarded-Encrypted: i=1; AL+hErGalRoA1KzrHf47FE9BGuN+O8wdOaE3BnLmcKwkZdi+ku1jfO7YfGT2zraxJU64Cs2C14wXZNk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Rj3mux4BG5sa3pWHnafVvckLsD5iWFob4GxOKeQeg4p+0FdtJ
	GfsH6cUtUDLfan0mi0OCnedLWcKXAOwEDmpfb8fvhLzt9f647rm5yDCfiSe7SJy6hg==
X-Gm-Gg: AYBFou3ITljgFQkC99qTovEtL3lYLis2tlePD247jKnR71gMVi32DokgwvaHNM6RCsT
	tyq+T04leVKq9DBh2Kd4jw6c5FFnkAckhGFeo4IrJZRC62DDWkmrsRYab6qAx4IFy2RiE0b+zy5
	ntjIjEB0n5pZUxzD3jGV94BTOjnRjlBWj3zC9aO/BMu7o1zOuV0l4QVM6HaYpaoIkpcSM6DLRKy
	Q+EQCS9VpO+1VvtiZm/YL1hh3v5LQgf5Bzp5Kp8S3ZH+llsierKgc+r/ttdj3k7pkwirAHkERSe
	2Mc8cqEL913G23JgEzoXsN4JZFa8+VHtKen0rK0NS86v/Wr4qUeIFf95+Vg7qCe2SsD5hH25q93
	l48TuNwsEaYtcIu2pLV70QntrxwEi8TcDmpngIGfuMiyBf+F/dq2UIq/Y+6KXR1O86l6AlCgKqY
	zCUZi+Xu3VOU8G8tQ2/LG2te6XTxuYF3wrtjjgi20/W6eaOKHQFd58PHan+4uc5KxkOCeGSwhda
	8NHeCJohfBNcwNMayJ7EyquZCZ29dikFXsgFvr7qg26syPXGqVyiyTYb+sr7mhVFrlrYnlAD21S
	dIz5AQMOE6Wist7tMWm8/pl9klCM7AmesenouvgySv8SnJs7SySlilVwtsk0FS5Majrl7GOryEc
	aCCtyofF49w==
X-Received: by 2002:a05:6512:2214:b0:5c1:57f7:f4f with SMTP id 2adb3069b0e04-5c170b36a78mr4191576e87.43.1794851533981;
        Mon, 16 Nov 2026 09:52:13 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c171333630sm3391252e87.19.2026.11.16.09.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:52:13 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/6] media: uvcvideo: Improve checks for payload header
 size
Date: Mon, 16 Nov 2026 17:52:07 +0000
Message-Id: <20261116-uvc-shortmeta-v2-0-62d4a8176fb8@chromium.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMdC+2oC/3XMQQ6DIBCF4auYWZdGiAXtyns0LiyMMgulGZC0M
 d691H2X/0vet0NEJoxwr3ZgzBQprCXUpQLrx3VGQa40qFppKaUWW7Yi+sBpwTQKc7P2qU1tXOe
 gfF6ME71P7zGU9hRT4M/JZ/lb/0lZilo0rbETNmoa2663nsNC23INPMNwHMcXyoY3160AAAA=
X-Change-ID: 20261116-uvc-shortmeta-75ccb6707d9d
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, Sinan Turunc <enscrpt@pm.me>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Payload header length checks against the PTS/SCR flags are scattered
through the driver, with different behaviour in each place, and
uvc_video_decode_meta() lacked the check altogether, which could lead to
out of bounds reads.

Validate the header length once in uvc_video_decode_start(), dropping
non-compliant packets with a warning, and remove the now redundant
checks.

While doing that, I also spotted an unaligned and OOB access in a debug
message, and two places in stats and clock decode that used the minimum
header size instead of bHeaderLength when checking if a packet contains
payload data. Fix those and factor out header timestamp parsing into a
new uvc_video_parse_pts_stc_sof() helper.

I have used an LLM to review the code and commit messages.

This work was triggered by:
https://lore.kernel.org/linux-media/20261115121701.189-1-enscrpt@pm.me

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Validate the header length once in uvc_video_decode_start() and drop
  non-compliant packets, instead of adding more scattered checks
  (Laurent).
- Drop "Check header length in uvc_video_clock_decode()", now covered by
  patch 1.
- New patches fixing stats and clock decode to use bHeaderLength
  (data[0]) instead of the minimum header size when checking for payload
  data.
- New patch removing the now redundant checks in clock and stats decode.
- New patch adding uvc_video_parse_pts_stc_sof() to factor out header
  timestamp parsing (inspired by Laurent's review).
- Link to v1: https://lore.kernel.org/r/20261116-uvc-shortmeta-v1-0-487cfe42fa89@chromium.org

---
Ricardo Ribalda (6):
      media: uvcvideo: Reject payloads with a short header
      media: uvcvideo: Fix unaligned and OOB access in uvc_video_decode_meta()
      media: uvcvideo: Use bHeaderLength for payload size in stats
      media: uvcvideo: Use bHeaderLength to detect empty packets in clock decode
      media: uvcvideo: Remove redundant payload header length checks
      media: uvcvideo: Add uvc_video_parse_pts_stc_sof()

 drivers/media/usb/uvc/uvc_video.c | 173 +++++++++++++++++---------------------
 drivers/media/usb/uvc/uvcvideo.h  |   4 +-
 2 files changed, 78 insertions(+), 99 deletions(-)
---
base-commit: 48fe5a7834cc10081887d7bcd9ff0a4cadc3fa8c
change-id: 20261116-uvc-shortmeta-75ccb6707d9d

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

