Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830203;
	b=QHa6pqwCxdL53+ed/WSP7cF+oZr3qzw8wYcmwLw9KlPq/OgFTHONasAEu2cSMEkRymrN
	 qfcWo0vXWQ72u1EB94d6E/alxgywIQgcSG+ndkIWd6h5OYrHOkE4bihkRkKHmxkgNi/2j
	 vipy+Zr2dgY8fPOzHrs/i2ruKnxUaYv27FUodn98INkLvAU6LDWOjJu/oB07AfusPjOWs
	 R6qaE6JSbCeUb/2qPKoovNBTuAF53X1IvHaG7F+cCmqL49eN7O7eGZQVK8yj1a6l6xcJV
	 Xny0kQYFL4L4IL6QwWVfVvMNWmFG4gbdpy8iUzMySa2G+F5AM67IVf9Oue0rH/rVMeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=75BqASa3pQSiCLazbg9HUnip9NSP2k2e52gEQNem2NY=;
	b=u/z/tqA4OsZ4Wgbauvst7i19bqD3/Qk87rsamwRDYtEgMk9PivsrYJdsqMyM7XyLeBf0
	 lzLYOc8AX/03BUuHjltWqSTHPcJFuQx5TGA2gh9ZOvcfGVMBMmBVwri0+LE76Hb+hguIB
	 W+yHXywSLKAUKGEdhi22JyezeLNC4ZZ2CynIL26c5rZmFmjAcyqkfNYzYfMvTfMMBBcnR
	 vExTH+BForWytKMqt5PZQfAWSRNEd6QwHiPKXkuZktIU8nnlq9AdPrbkg1SxR2OmMGQeo
	 ppMzMjpTovwQkb2CaJo3e+QbD/aVt3CBDtfMXe6quv7ob592YyGVqULkpug9/C30FOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=R7eMeQvc;
	arc=none smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7ED606A330
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF7ED606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=R7eMeQvc
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ae25dcbd81so32022381fa.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 03:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794830201; x=1795435001; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=75BqASa3pQSiCLazbg9HUnip9NSP2k2e52gEQNem2NY=;
        b=R7eMeQvcKmV+YQ0RO1A52l9WKu6AgEr6CjleT4AbxpCF087ib+8qBbk7ylI3LyhvGW
         nl9mwEBSL5R3YwT8HcD8fSldh9XD0xvhB1oGKgsDUm3nfxN2sXcfT0rJRpvYfdS+rI0B
         ano23tip8N3VL1zCVMp+MZ4hN0+YQDLDOcFQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830201; x=1795435001;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=75BqASa3pQSiCLazbg9HUnip9NSP2k2e52gEQNem2NY=;
        b=cgaBiDC7aoF1dRkJmwb949XGgRxLBabWbqgtTbbI3xKJk+S+l81syuOWysZDBBFEaG
         OAw5llpYIxt4nJjX6bKFWYExY+GZ0zX8adE2xtwGtFSDsT8enZj/rTxhvNB7RR1EDBTu
         LKOdQ1vEhG1+A7+AoXglWb+02DW0ME3X6hd19FzV+29/gy6gVpCN2hJwZDdplCC8rdPD
         ogISlItQNiNmpGj45q70RUszZQB3If/Lr2SH7yA/XN1Bm6q0TouPKRinlcQjgmwZsu/X
         2DXnY5mPXSkMa3ccQ9ZbCjvz9AUgYqhCW5yVXyzby2qvVzE90FmDJQmil+ECEqMYIN2H
         Adnw==
X-Forwarded-Encrypted: i=1; AL+hErF+cAKTxAxt4WOHEy/QB2uLG/MF6doovEi4dbWpfzRywvUcpZzFHdPtfDc4DkcIhtZXc7FYnOo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XSV4DIcog1Eo3CxrYyQq7b9xdBOLX/+p5mD2t0S9Y0UOzLwpb
	JTCqWVTAI4r6ANQ8M8pqUAbB6VyuFAsi3sSOQLeVVSpO0gl9tNuo+oE/TR1wbemGKnlHDSejljo
	PEmk=
X-Gm-Gg: AYBFou3/myfeYEcsF+sfTn3zMAkkjX4S01atTa52xOpnvvNppvk2e+NQU1i/hi76iaH
	a3nKkrK6MPL+pYRaZnhi6Pq+jcux+IR05CQpzbJOxl25AfANDfOPHa6CMyEED/oxmSIq6B5rqmh
	In0lN+swK7KzMTJqcyt30PkOcKpiTVnmXb7MYpyosTVT3+NQvSy7B8+f0O6eUBKHuBjDl+b7C/7
	JZC0A3tVzZP6sFWcuqFOJGfAu+XjUUfPDzuLd7ZTLDe+9/tQyypYCSuL/xGgQ9wNUVJ0TK6fxac
	LF6kIJHadcjkHxWx72KVpEFchg6MGBYkjgUvM4pEDLG2YQGXwlZtdU8nlcwLN5vQhlbHUcAxYes
	mlfSRGR3Peh0TWlZ25PaltpnQ02CGYDQ2nCQJeV/uCtK1q7TASEknqcyfZ9KtlFC0UyNLqp1jmb
	mW4QtXTxogaYKCk/0+nqjl4DxMouF6atUO+b8+BHJtBB55mhFbv73qWz5huG6p/ymA+2+xhWqlq
	T2p/eMKqUhmKWWzFWCRrFqDU3cJB6XptTmf/b5mPLmk80MmEd1rCq7iCrHg+9d7/iMyH1IfW9EY
	ES6es53kUMRFpk8DUAHcej2dhraNqPKnDJshGUMLRetK0cZS2nz34NHrntCbuxE28lhS3icpk64
	bxeup/OmarQ==
X-Received: by 2002:a2e:8a88:0:b0:3aa:fd7d:6164 with SMTP id 38308e7fff4ca-3ae2b68121fmr25930611fa.25.1794830201228;
        Mon, 16 Nov 2026 03:56:41 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1712dad7dsm3183754e87.9.2026.11.16.03.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:56:40 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/3] media: uvcvideo: Improve checks for medatata size
Date: Mon, 16 Nov 2026 11:56:36 +0000
Message-Id: <20261116-uvc-shortmeta-v1-0-487cfe42fa89@chromium.org>
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
X-B4-Tracking: v=1; b=H4sIAHTv+moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mz3dKyZN3ijPyiktzUkkRdc9Pk5CQzcwPzFMsUJaCegqLUtMwKsHn
 RsbW1ALgAAO5fAAAA
X-Change-ID: 20261116-uvc-shortmeta-75ccb6707d9d
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, Sinan Turunc <enscrpt@pm.me>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

In some parts of the code we have not been very strict when checking the
payload header size; fix this.

While doing that, I also spotted an unaligned and OOB access in a debug
message, so I added a fix for it to this series.

This work was triggered by:
https://lore.kernel.org/linux-media/20261115121701.189-1-enscrpt@pm.me

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (3):
      media: uvcvideo: Reject short metadata
      media: uvcvideo: Check header length in uvc_video_clock_decode()
      media: uvcvideo: Fix unaligned and OOB access

 drivers/media/usb/uvc/uvc_video.c | 20 ++++++++++++++++----
 drivers/media/usb/uvc/uvcvideo.h  |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)
---
base-commit: 48fe5a7834cc10081887d7bcd9ff0a4cadc3fa8c
change-id: 20261116-uvc-shortmeta-75ccb6707d9d

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

