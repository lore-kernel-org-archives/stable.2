Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F7A47606F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132958; cv=none; b=PZZrUVlPx7ODTXPmP9rSDj/t0J/zVOLXlDC3NbjYQQVDkPMnXcuhNFetcsCxKpYUr2TQ8jVvwZO/MILzw0vHGKO1yv20iumP8wgBereUYXeXg1GJk0Hrh8CxmGGRkJHPZFh73VIevs3T2i+ESkEjcfbQYSrYycb3YaiLBX5jsoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132958; c=relaxed/simple;
	bh=xHZhA3szZA1hZVZbOIyn030oF1VwprWMhW3TO6nzBXs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YTeK+1RALQEI8/9gYeJhJYZr1NOF/x5s0FN9zePRfOFTe9to13MtkddWAgZH55ew5a2Z8VR1Y7X+3F7TBSs8wp5VKPWwN2CWGRSjNNM6unMa+3hRbfvjohz63biLKROA6q0lID4QkQPVPC4ASVwRui854fOUCu5+WA3XBxgKwvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ebYRm1O/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ebYRm1O/"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a2015bbfceso12247481fa.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 06:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789132954; x=1789737754; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hazyrIg4ggyFOS6emaQbu6dOwEnHBIR0x34bXl3xik0=;
        b=ebYRm1O/ZBSDz+sc7zIULNyFSbzcYFd9j2tfRtNjaaEns6fXbDP3TRjVzNDC2hRcRN
         4nRyIQ1RIaJqNgLW1JsglZcdeVDFm3AwGQY4v+5zNjV1rGYaycG/d7cFHt0VWZRmfvJb
         FHiC1EP5XfI8RmSpsaMeUAs4KNjDvkXCmmlDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789132954; x=1789737754;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hazyrIg4ggyFOS6emaQbu6dOwEnHBIR0x34bXl3xik0=;
        b=m00J/C5E8+3mU/tjx2DWmgktE53qea0GnJa3C+jEVu+JM8ekSugsiV1Xox6lxNCQX9
         naeW8Oft5v1bu3UwnlF9x6Xmxdz9n2IWB3ZrLSaB2XQb1bbVWe/RMOHPEeQOd2nM6lK9
         3uJ0jsHOYTIZubn+r0ZBx6GMw/EEmpug0QvS9Dedex5N5qXyhX4G1oAJorCkKOVvc3Qa
         F7lsauQBtmKvLfEDTFenq5uKRM62SUbjsTZlHB4Qd046/jmFQ3J5KuXeUcFWsdNxeX/F
         2go824ywpjqDQSyKedebOR3zaOU+Q4cF/MwGXajHiEMwebK8gGbC2+kj68wBvEtr0Ekq
         XJng==
X-Forwarded-Encrypted: i=1; AKwUvByYeUfz62C4PvcG2a6rub+oevKVkIAMg4bJX4nOkF9Sr5uSUdxuQnufraFr7i6yBP+VHM636SQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mbNA/gqkl36zdc/wEE0RrT2hpk7QF+PwHYk6qWlj3gNxw2mo+4
	0STFVwAvz1MtY1jEsvgUCGR0AvErP7Pq8SAkDnbm/DY3z8hV4SG9Hh3NeYt9hONdCQ==
X-Gm-Gg: AYBFou248kWgU84SLDkvcRrq8lCbqkfIeyPMZ63jOD1yibrEhJQgxOk/q+Y//ZchxtX
	dvKposgkku1ashDHmBD8HVvklx9uTHcpKOGcqzUnWr3XA0o1Ge7Nab/P0QoTPdxgdB1lHN2n40B
	nSIqWzH6ckWPCSWrseKobdF+oIVRkwLtFPhfFIa1RrjeBSvnufvQhC4aL7L6uLafkciEw4DxLIg
	I64jwZGG14o0NZgrxem2OijtbQiyzDgGrVx8Tzyf2fvNSH9zUxDX2P+bosiH4U0wEEIy93rEVbQ
	RiarPEvxfaX3pIn8Ounr6razEDcf7i072jGcV+D7lhoICFK5tkDNm/21ddAEIgnJGDXkMtvTmJz
	UNqhzGTi/woSYQ9JJk1MV//s/JfPde2MLBFlYJyOW2fqhatEyt1GfdS9vYZadjGx4LL5h1JP2hB
	JA5jGppXQ/ZKzATBllT+kKgcR+zHvCpOsTBoPYMKd4+4PmEHD9sj6HatxxWC+uviQLbnAQtte2l
	sToroyFPojkzl+Hu4oDUqxyFWrVLmTxXNvZN8C6kgW9QdZD5g==
X-Received: by 2002:a2e:a801:0:b0:3a3:61ec:43c2 with SMTP id 38308e7fff4ca-3a591260d4dmr12294851fa.19.1789132954319;
        Fri, 11 Sep 2026 06:22:34 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a3303fc9sm6677511fa.6.2026.09.11.06.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 06:22:32 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/5] media: uvcvideo: Automatically handle invalid
 uvc_versions
Date: Fri, 11 Sep 2026 13:22:24 +0000
Message-Id: <20260911-uvc-version-v3-0-604328d8a0dd@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJAApGoC/22Myw6CMBBFf4V07Zg+BhFX/odxge0UuoCaVhoN4
 d9tWalxeW7uOQuLFBxFdqoWFii56PyUQe0qpodu6gmcycwklwfe8gbmpCFRKD/oyJDVqI6oiWX
 jHsi651a7XDMPLj58eG3xJMr6v5MECFBIWBtLHA2d9RD86OZx70PPSirJD12Ib10CB9XWVjY3j
 oj6R1/X9Q3hdEN06AAAAA==
X-Change-ID: 20260907-uvc-version-aedefc4384ce
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Edwin Gatier <edwin.gatier@protonmail.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

This series changes the way we handle invalid uvc_versions. Instead of
just failing it will try to continue probing.

Now that we are at it fix the way we handle device warnings.

The last two patches are "optional". Feel free to ignore them.

Thanks!

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3:
- Move uvc_video_ctrl_size to uvc_video_init()
- Fixes for uvc_warn_once
- Remove bmVideoStandardParsing parsing
- Link to v2: https://lore.kernel.org/r/20260911-uvc-version-v2-0-395f27b0444c@chromium.org

Changes in v2:
- Add quirk for Avermedia
- Change the way the compliance error message is printed and cache
  ctrl_size
- Link to v1: https://lore.kernel.org/r/20260907-uvc-version-v1-1-34e45dfe04de@chromium.org

---
Ricardo Ribalda (5):
      media: uvcvideo: uvc_warn should warn not info
      media: uvcvideo: Use uvc_warn_once when it make sense
      media: uvcvideo: Automatically handle cameras with invalid uvc_version
      media: uvcvideo: Do not parse bmVideoStandards
      media: uvcvideo: Force UVC version for Avermedia GC515

 drivers/media/usb/uvc/uvc_driver.c | 17 ++++++++++-----
 drivers/media/usb/uvc/uvc_video.c  | 42 ++++++++++++++++++++++++--------------
 drivers/media/usb/uvc/uvcvideo.h   |  6 ++++--
 3 files changed, 43 insertions(+), 22 deletions(-)
---
base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
change-id: 20260907-uvc-version-aedefc4384ce

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

