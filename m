Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67E3CB918
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182094; cv=none; b=eiYWXrE6AoerfLlebp/gkKbebEWzHFLDS4MJZxWLCu+So1/VS1QzYvF5iDSMzAHrcdTEeGYWtG+73Qc2CAhL9ko/vlK078PW05jemIPFcrCcBfXTt9hHaVszUUqCPuU8G0Kg8aAJekDtdmlhYAce/HDG1/XuoV2BFWvRUwkt0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182094; c=relaxed/simple;
	bh=JyBUjyxL7nT4ZYclweO/wW6mn+OU7uxxJf63SKPKOeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qrzulUmpLFveG+TfszzypnOyUfHpEtXxXbs2IJcTao479deomvDqbo8zVOmPD1zLIa72XERkjzDXcdyyFB1CPjBhDTIYx7txBTtsRUUagt5NRM8e+jbg3YIIV3LbE5b4DD6NEcEUq3DJmbTpCVQ+ttZOa7g2iPnPUB2UDazrcck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqRr7AU1; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqRr7AU1"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so3064993a91.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785182086; x=1785786886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uo3Jh0L4b+BG4DFcYUfx+a8EHRfupQuURbh1tRgkMyQ=;
        b=QqRr7AU1JYVbcH0raJzQdjOp6QrzR67IMEdaXIyEFeN7FJooD9s1JsEmGUHjTg3gFK
         3aQPbold32/Olu2+QGL5NqUFK0DtOHnYhoP30zF4Q7Bu6h+BgYZ6rtCBfRpoRKJUMbXc
         wXhQmUr01NsT44HxpYRS9Ocxr8gPmA7Np6afO2n1Zh+1r9UMY606IMpSygDcokZKZ1/R
         4RwZTWZOB9l2aagwl7THeZmmaajiScTrkXpIHD6iFdlUa3hyHKB5B1JSHcht/hYfkv0s
         3vnQl02KYro1JIzEZXQ9cu9B9pjUODTqpsU6BkCgxOH9SMds4Gq1qPFipj/kYYFhC+nL
         9tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785182086; x=1785786886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uo3Jh0L4b+BG4DFcYUfx+a8EHRfupQuURbh1tRgkMyQ=;
        b=euYP8ifRHURWIpAx7TMiPq4eWzkcaAi/95lM/QJ+EOBy5FYnd2UmeZVZBPXiJL28/7
         Sh0QsK9quGlRIsPe7ywUYrhAXNaLTxDqjD1+H7XxB5gB8sUfNCwZSNsPm5yg2mJ90PMX
         EcomQMDL2+zUYGtniVDY6GJZ1SjY4Bnzk7DPNJ7RHVcLHMoR7CyBSwwxTTzGDKIIN+FX
         ruHuqalF/LV0OP8mA/VfWGmoH8KC1Ka6Fh18P38sq66jwq8OKMJs5cgCts4TGyrcPh66
         4q3z2/vKT2L2hGKxApA41xoZMCluaL+jhNQQWxAcQ5jMxPyJKS1Lo7c+junb5m6QMF50
         aOcg==
X-Forwarded-Encrypted: i=1; AHgh+RqK6daTTgcJ5B0AtVAOboeRIxK4SRXJ6ffpOb3BQSbC4kMd/xqmp0okhmq5GdaSNc+EaY/A9E0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx14pGrf6vEvS9+hmjtruBaBL/Dhk78Xh6X8EYZ+tg8hLdvbWFw
	bahdUt9dBQAt2shfCrnbc/MRUH0eAORhCXhv65C7tQE1Hv9IXSbB7jXU
X-Gm-Gg: AR+sD137OecDAoFBjlQhJ/epn9QAaMFcmW+qHIewlc1XPaZGK2DBr9K8W8kyk/97atM
	aCKn82qjMkE02bc8YdXfJ5a2P1bzhjaycZttWD1UXMAGLwqgZS5AchH6QwxuDR+EJEDW/JHpXin
	cT5TaeTClifcQHAbsv8+p4CbUrbQPenI/8NYNAfv+/amLkQ1yb4QglYlDY4hZ+4q7W9OWoURNkv
	wUdIxKlsxeIEwnmCdBEYjyzYhpnpS/Ozznv1tfCiNIOmBnMgugSkqC5zyeiSQEAtXkYUnqHLydJ
	qmEUs/sae1zJmL+ZNcvst4sbUxfqtnrfYbSbjh8uNq5Nlg5ZtTDlWNvJ4kswCTulqYgJ7al4FZA
	31QFo0lsZzbhib9hzJtcYtoUQc0do/ZOzn0Zohj+f2EVVC/N+pUkBuqBTjqd+AcYkIsdNJGGF0p
	b9Kf39G6mGUn9au/IIX68Y/SzKcS8vBmPbb9lzRDO8/Fs4BzpwPMaSf5xUQBUaXEWYow==
X-Received: by 2002:a17:90b:2c84:b0:37f:ad36:8fc5 with SMTP id 98e67ed59e1d1-38f64cc9e1fmr539746a91.23.1785182086532;
        Mon, 27 Jul 2026 12:54:46 -0700 (PDT)
Received: from localhost ([103.170.252.6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc44cb92sm57447013eec.13.2026.07.27.12.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:54:46 -0700 (PDT)
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu,
	michal.pecio@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nikhil Solanke <nikhilsolanke5@gmail.com>
Subject: [PATCH v4 0/2] usb: core: Add quirk for 255-byte initial config read
Date: Tue, 28 Jul 2026 01:24:32 +0530
Message-ID: <20260727195434.14626-1-nikhilsolanke5@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a quirk for USB devices that fail enumeration when
the initial GET_DESCRIPTOR(CONFIGURATION) request uses wLength=9.

Patch 1 adds USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE which causes
usb_get_configuration() to use wLength=255 for the initial config
descriptor request, mirroring long-standing Windows behavior.

Patch 2 splits announce_device() to log device identity before
enumeration, improving failure diagnosis.

Nikhil Solanke (2):
  usb: core: Add quirk for 255-bytes initial config read
  usb: hub: Split announce_device() to log device identity before
    enumeration

Changes in v4:
- Reworded comments and messages
- Moved the memcpy() block that skips the second read after USB_QUIRK_DELAY_INIT

 .../admin-guide/kernel-parameters.txt         |  5 +++
 drivers/usb/core/config.c                     | 32 ++++++++++++++-----
 drivers/usb/core/hub.c                        | 16 +++++++---
 drivers/usb/core/quirks.c                     |  4 +++
 include/linux/usb/quirks.h                    |  3 ++
 5 files changed, 48 insertions(+), 12 deletions(-)

-- 
2.54.0

