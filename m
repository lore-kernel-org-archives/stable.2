Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645535;
	b=gPmKDMZ4j0umPz2I6925FhQpRU1HLDnJhB4B9nmLEkd2UtyfUj0wHrCrNAJZ17jd3wzS
	 kyuWYIUpf3Nui75cqyM8eijTJex3C/8i8fRHz556AtFqSvemt0w8DlnFKC4w8S25Q3R9b
	 BARaEiNxds4o4r24WnQxltV5tT4iP9U8DaqC7EnVOlgDucyo0P9ETokUilA9apQwz243H
	 mrbeskL+pYCe4nD6lRe5KyRL+8cq4/HW1lRQUqhQmq8/AcjV2tvBmAQvcA3GQvyFf9BQE
	 LDJWemughp6SuDW4Pg35sAJzNLH6aFZnJDRQ9o09Vu9OOVcE/vwyXC4mxgbMtYxTDEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RCCssxDP7VqyjtjkkMxKeVZicY7ZW2acPhjksq1uY6w=;
	b=qxUdhCWHbnaR3iPKGiDyfKTFw7+WApW12DB0iNOwLxbD5cAxr1k4xik42CBtXi/my8+/
	 aco8Mnecwg65NYc/MzqDUl4Yhf3W0Zv/1a+YvWDlaYGTdNlWGF4GfF7UIDtNr/KuflpEG
	 Fw+klkop0d7GugsQl/K3w7dul5QWtIQyVZHlJ4EGrleHFYL/NInvv6kD/UZIYSVVW7aGJ
	 mA1tcWjSyG9src5NquqTvHzqAvu1lz8K2sJTJscJF3i9Uyd/KhCaiSReNzp3Sf/AKPo0V
	 Nzw0kCtPHENbK5EoIjDrEN1fyvAo1METy1SNAMZGzEpFUFsyhbP82cQngcRbxR/VgLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XHR3R2so;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF560A5BD4
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8DF560A5BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XHR3R2so
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so9500864eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645534; x=1796250334; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RCCssxDP7VqyjtjkkMxKeVZicY7ZW2acPhjksq1uY6w=;
        b=XHR3R2so1mn1uGUnq+aG6WGdaxLRQ2F2VsbqIuDb7Zo768ZuZhwuDtjO+A89l9Z8wI
         /FalLqpBrFlX/MxeG4FXcZ8lYx33htKbBDUKVatEp3EWI/ZLvkJmdS5RGPy/8Pw+q7s6
         qGrIA/noEH1eDbW8I8jd45Uxy5Nv6um8LqjOvRRA/NGbiAGbZFlgl2Eu5lc4HzxNAVmo
         gc/s/ATFmLfJYB6UHLrgavGZsS7kse110nyrDmqQOCM1q3dn3X7bjzn9uCcuDZgkqvHS
         XYi2gtXoC3gVDi2F6Q8qNN3NNZh5Q9AuG1RpnesRuWqyo+BTDNHM9N5Q3UegetrJtZje
         8xDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645534; x=1796250334;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RCCssxDP7VqyjtjkkMxKeVZicY7ZW2acPhjksq1uY6w=;
        b=XfhivVZz2RQ8UQ9xKD9+w5CLP1miYW17ijGDivBwWlCK0AQanaoxd8xLh8c9JvX0wf
         jeS/CtNyG1zSaawDQG8C/UMz/GHhC6GPmPgWPA/lLAyXIAncAA7kLuL8xHVzuY0xI/KZ
         /MKYKHjLiHIsFMypPqIQ8JKJczF+YOLSUdqgbiVpzClXa6uAIjsZEmxcNCe6ICNpJI7O
         4uV/OeZE12hOtEs3/YYBWxXJ5vLwvh6GSKmmqlbVKepjpU2U/wwczFNxV+0qZGISkn40
         ++IQTNz6znX4v3z3Yc07RPmsNGvyw35DSrEV5gRCEoge+Db7EPyfUeceH03BX9UsTn43
         YOsQ==
X-Forwarded-Encrypted: i=1; AL+hErEAZSZrtYmfzEwOpXZFKX8FNII3Oo4X3u0tduYOpaj3Gjx3EWK0xFtLBI6kk5w33ORiJNBYEO4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ft/SjImJ6mXV/5S4eTS9ab5ayjhcfgHMFKA5OzsKN5aG3KO65
	bwVJ0LlmYfddh5bUFVMnRP62Q8iR8xnuh5kMBnroCu7R9Rf7l+UsrlSdjaoSKsfXk4e5La9ia5M
	bOA==
X-Received: from dycnn7.prod.google.com ([2002:a05:7301:1407:b0:384:71f1:1227])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:d587:b0:381:d92e:ecab
 with SMTP id 5a478bee46e88-3856f25884emr17876278eec.11.1795645533582; Wed, 25
 Nov 2026 14:25:33 -0800 (PST)
Date: Wed, 25 Nov 2026 22:25:12 +0000
In-Reply-To: <20261125222513.1446099-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125222513.1446099-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222513.1446099-3-elkin@google.com>
Subject: [PATCH 2/3] drm/sitronix: st7920: Check drm_dev_enter() in crtc
 atomic disable
From: Elkin Cruz <elkin@google.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

st7920_crtc_atomic_disable() ignores the return value of
drm_dev_enter(), allowing SPI power-off writes to proceed after the DRM
device has been unplugged and unconditionally calling drm_dev_exit().

Return early when drm_dev_enter() returns false.

Fixes: 88b09229f34a ("drm: Add driver for Sitronix ST7920 LCD displays")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/gpu/drm/sitronix/st7920.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
index 091e80d8bda5..ea4566009c4b 100644
--- a/drivers/gpu/drm/sitronix/st7920.c
+++ b/drivers/gpu/drm/sitronix/st7920.c
@@ -580,7 +580,8 @@ static void st7920_crtc_atomic_disable(struct drm_crtc *crtc,
 	struct st7920_device *st7920 = drm_to_st7920(drm);
 	int idx;
 
-	drm_dev_enter(drm, &idx);
+	if (!drm_dev_enter(drm, &idx))
+		return;
 
 	st7920_power_off(st7920, &err);
 
-- 
2.56.1.839.g22a8290db9-goog

