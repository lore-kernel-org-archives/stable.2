Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171235;
	b=Xemw15Am2eboSPjhtoSmj6oeHKNSwxh/N4X7pnT1I1LXUcWM25nZr4qJAo1+OtYj9PsZ
	 XLY/FJ3/FDP/01luIsSSsDSqR83AuuwQ847ARFShaQda/eaakOQVUwfjqr07JTRM+Two5
	 pSpge++Th+F5LxRykxuu8OOTKT+u4a2mksXg/0UVttgVHLoRGR59JU/PByCxoINU10eGW
	 yCXPUjj3a9uZtKy+UmjaQKa5rNurK5BOBAsB2w/hGW73emf0w9ePqEhbmuooz3NYRKabu
	 PeKyHlMGtMWDK8BMzmI9fHvakQEJZ1gLrhAqt+jeB+REn6tHBYwIcCAeGXrN/cv+8Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=hHlxygDCb53QOZol2Y7OOBQXofD0V8rGJEydBMdsadE=;
	b=Di5yFFOYCnOwo7kNNMUtBnPA5cBMG3JhhR0iwPHYJNuohxTZtB9pU6PraY/vR81wiVP2
	 06WS2CtE+FQ2xQKeE1f9B0on7DyEtLvfnp/Fty/Ut6Jw6Gb8Na9NtFeCRFiRl4yECVY46
	 4imMXabqRRh1c+g4vCZ7YGY7FBgp8KOsPVm/QJANkwiX6HUrl4tAgVHdKikHZESjqLATt
	 fyFQLRS8CApYtm+GtCg7KAtsfI+BvPPf0GPwT6qU2GoR1VwQrXa9j5mGy84S9QzMUm+wl
	 PZL8EQ/DKn+BrjKhcBtmWwLcQHc4ywH8wEXBzjPEpmD/gIOv5ydEM+cdZFkG+pFqGxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qRkNbdjt;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC5606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ACC5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qRkNbdjt
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso4916875e9.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 02:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795171234; x=1795776034; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hHlxygDCb53QOZol2Y7OOBQXofD0V8rGJEydBMdsadE=;
        b=qRkNbdjt/R5ARXJLF8HE9/pIUpUGMeZP8BgzS8Kk2/ZgVYCpNm9A5w/95ZvR7tL4qI
         2rKHumL4v01U/RXiMzZa8DJ8qHIr+7E8cTpd2ib07/GnHtwWoXd8znI4MClu0FpRwBEt
         JHZhLv9zddnYVl6f/oOClp53+huipAPWmgdw+6nYk5vp/1W7J/Ubwb6+wMqHpcYUrWDU
         gvaUXyI2dqF6NKDx+r5B+geCdCZB3orD1xDjEVeHCshWHAqf1qyaAJs2mjPZ4kx5FBc/
         UxgNamte/iDLp6LYMnNh2/OX3BOe0b1fFbJGJ/hHahQ6nbe6FIpbXicIa5gfjZQMqYn/
         NVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795171234; x=1795776034;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hHlxygDCb53QOZol2Y7OOBQXofD0V8rGJEydBMdsadE=;
        b=XBgVdrqbkIWZyCeeK5pHJ1jbELIa59aUi/On3I6+EKIc5rBm/GeqmHU5FBfZqANNSc
         E71tGKesf/QpP5ise7QhMK00VKKg5Y7nRIA9y4/YFWVwrFMFVXT69jx4f1nB+9ytaAqq
         ZBVBm/1K3fGItxyIJo/jcHeszUBNnZI/pS5cguNuknEQf3pSVmpXtpS1saD3pVWmc0O5
         UMo1ZjpFmHkXcDzpIRTFbxBtJoOtP4CxEWmKw7SRKK41Jbs6KzC/4EBtW6FROOe5JyH1
         YwX318OSCNMdcsDktbaST11aV9p81vRtqj8Vp/MWpCauegRAHbOR4xVPgeAjBgrrlgJv
         nRWg==
X-Forwarded-Encrypted: i=1; AL+hErE3XSP3tN2pUb9KzABgYRt3HbbnLvhW+hPdqtl3QbrEK1FYTvlBZgtZB89pCDfcNZ+vcLeleHw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RdABixbadSANO+jGn3l8CYCz5Rm/gggt9aCuz2sNUvVFegGkY
	ZxGZxeNpDVx9NYt66oHGpW8jbmD8p1JHTUd22rXOFcz5ucLkPAv8HdKz
X-Gm-Gg: AYBFou2zm/mn2Cv2+V/K1osMJZD7JIqE2NOypidbUJiCWbnFuL3jWRmH8+pdD9uAbwp
	k/1kx26BJh2APuOpx35RAj7ph0bsc5TR2QZA+xamLebctYiJictPTCWsnOqBJgjt5WNWwLk5A1d
	3G8cICCAfzTKGiuU8qBMN/EE4abYvyjooExTYyPLgptx8OJhpezIKr8r8LR8v9DFQ/sWcVgReU9
	+aF5SrdUquuCdj+4565b0p73cyJjHHqLJySTcN2i3JfuzOICLImtWiL93qlViHDlt0M31d9ikYI
	/a5sH701BH2CIjfW/r3OcLfwVbOI9ppGetjlkcITLkgOIpYYbfUsljJvVzAujnWvFASUp/LLWo4
	R5Q3BJh6vOJaQJfsO8diH/p30auUHIWk0DoeDBKZFsndtV75x3U+oQ+/B1cpAgIpn0zYkd16/mP
	0ApKLpsp37+LI63QDsdXKT9i4yhgo3GlIHwOFt8o4QvbcrZ/gmk4AHTAiFihtBl0XplxzRd+KV1
	+OnSartgs7zb6v9nuIyYq1wQViqsqwqpn9eWXwBEHolJ5xZp4/EApSGeVI2Q/ky7wEX5od4PR/d
	j+mqBWlcUodeLNiqwOQXpnVxIPV4S/jea+g6bTgukq0f2rWuLF8oenICFQt/MVftarqxYjYZbcz
	fXuHSoZJvLNp+lws1C0K6fhZ+2qleBxx7w910BQAPZE+tvM3X/do=
X-Received: by 2002:a05:600c:848d:b0:4a5:1cf1:b7bd with SMTP id 5b1f17b1804b1-4bb88810b2dmr54158015e9.16.1795171233380;
        Fri, 20 Nov 2026 02:40:33 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at. [80.108.121.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm22297535e9.2.2026.11.20.02.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:40:32 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH 0/7] drm/etnaviv: Report GPU clock changes to userspace
Date: Fri, 20 Nov 2026 11:40:26 +0100
Message-Id: <20261120-etnaviv-gpu-freq-trace-v1-0-445fc6eacddf@igalia.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2MQQ6CQAxFr0K6tomtAolXMS5G6GA3A3aGiQnh7
 jbK8v389zbIYioZbs0GJlWzzsmBTg0Mr5AmQR2dgc/cEVGHUlKoWnFaVowmbywWBsGW5cr0vMS
 eR3B5MYn6+YXvjz/7efV+OcZ9/wJRgfV6fQAAAA==
X-Change-ID: 20261116-etnaviv-gpu-freq-trace-52e421b3f72d
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: kernel-dev@igalia.com, etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Christian Gmeiner <cgmeiner@igalia.com>, stable@vger.kernel.org, 
 stable+noautosel@kernel.org
X-Mailer: b4 0.14.3

Userspace that converts GPU cycle counts to time, like Mesa, needs the
core clock rate a job ran at. The thermal cooling device can change
this rate at any time, and userspace has no way to learn about it.

This series adds a CLOCK_HISTORY ioctl that returns the last clock
rate changes of a GPU with their timestamps. Userspace compares them
with the fence timestamp of a job and knows the rate the job ran at.
A trace event reports the same changes.

For this a job must run at a single rate. Today the cooling device
changes the clock while a job is running, which can also hang the GPU.
On a GC7000 rev 6009 I toggled the cooling state every 200 ms during
glmark2 runs and got 25 hang recoveries in 24 runs. With this series I
got none in 34 runs. So the first patches fix the cooling device:

- Patch 1 fixes the GPU state after a failed init and after unbind.
  Patch 4 uses this state to decide if the clock can be changed.
- Patches 2-4 change the order of the cooling device registration,
  skip requests that keep the clock and close a race with runtime
  suspend.
- Patch 5 makes a clock change wait for the queued jobs.
- Patch 6 adds the trace event.
- Patch 7 keeps the last 256 changes in a ring buffer and adds the
  ioctl to read them.

Tested on GC7000 rev 6214 (i.MX8MQ), and with backports to 6.6 on
GC7000 rev 6009 (i.MX8QM) and to 6.12 on GC2000 rev 5108 (i.MX6Q,
FSCALE path).

Link to the Mesa MR implementing the userspace side:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/46538

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
Christian Gmeiner (7):
      drm/etnaviv: Don't set up a GPU on resume that is not initialized
      drm/etnaviv: Register the cooling device last and unregister it first
      drm/etnaviv: Skip cooling requests that keep the clock
      drm/etnaviv: Don't change the clock of a suspended GPU
      drm/etnaviv: Change the GPU clock between jobs
      drm/etnaviv: Add a GPU clock change trace event
      drm/etnaviv: Add an ioctl to read back GPU clock changes

 drivers/gpu/drm/etnaviv/Makefile               |   5 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c          |  20 ++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c          | 240 ++++++++++++++++++++++---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h          |  12 ++
 drivers/gpu/drm/etnaviv/etnaviv_trace.h        |  62 +++++++
 drivers/gpu/drm/etnaviv/etnaviv_trace_points.c |   9 +
 include/uapi/drm/etnaviv_drm.h                 |  62 ++++++-
 7 files changed, 378 insertions(+), 32 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261116-etnaviv-gpu-freq-trace-52e421b3f72d

Best regards,
-- 
Christian Gmeiner <cgmeiner@igalia.com>

