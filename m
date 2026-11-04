Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777610;
	b=2BVjJjctkCJD3Y5WytvkAEhpYdxzFlUo+fMxC+z7brphgYaDVYT8irXYBAveMlhRZ7h5
	 LxiOAPwdAWoOtfN4HVtbPyPJfWWNKwPOJEOoRrPoHhXdj0Qy0rQeExfu7COHC55ckwBlm
	 OMcyyTlJdfbNXeUQhI4EEisNjI0JnrwoXS1ONrrtmEqu3LjBbwtXBHsmRVIpq7wIEaB/W
	 RJ4TCg0LGfmEeTWQtzWIDmDs0hRjmFmoCDkEU8QAMgAzDlIeQUoHXiI4KEyZ9uNZ68NKZ
	 x4g0uEgJ+rc6xoYaRj7yhnYmJuwyQh9FqnlzdA7LRvT50Xu9EWeN+ICfAxnwy+ICmrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=E1F87bb525awAof1JLFi6O+XOwtmrtsukGBHxsxN3uE=;
	b=x6NtBAuObDOGp59shnKNXE9KqQh37EUpu4P23ucuMu5mQZrboYOfKdTPgDJ2/PK51IJ6
	 5NG1DiVzH0PasbyWsm8RghGJuZImUk6rCVpRMhKL/KWkUCTFGqTYyuKpuDTy+BP1sMOOp
	 Lm0SeEYEIbIy1xnk84ai23cZZqOdtA30wVqJX3oNC2ZOT6Mr09DbroJZjkQ1nwuckXg6D
	 cx8l3lWEDz3v4A5Ah741NEutleU5s1HxUQr7zaP0lh4xc8Mt5DviRpTpIVAmEcRgF6umJ
	 91nuh966EqNs21/3KL+oV06kzVOrYdWTCZApPbhPAkYgMfgdsXRVeUmTVNo7x90czCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Gt/4I8z4";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308C3606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 07:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 308C3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gt/4I8z4
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3646e6de3e8so26145eec.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 23:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793777609; x=1794382409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E1F87bb525awAof1JLFi6O+XOwtmrtsukGBHxsxN3uE=;
        b=Gt/4I8z4BSlic72N/8E0Ckwx7OXL1NvxPPHtA+V5oWsY7RaJME/QH9HwmazDXXZC6X
         CesABgwnS84rKoO5RUuefLl6ggQqY/ziJGI1aq8+f4SuVmYIJY3KGzxu4j5j1nWZEKGI
         OGtS5q2/fFomrT+fnKQrvmplc2uLzQ/YYLyjRXc1V53yA6RP/3O730kWs5pj/fQaRcS7
         kmUzPK14dAmM0S6axnoABAq3uRWNw/rawxXLFQl1zYjjKeg2tEeAZEis1AIroX6f4Via
         uS86Gvkw1E+CJJfS0AbTRGphxkHGtibfqBYWPbSgeTPXJeExq67P1m6+qFkx8EFI+U22
         5qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793777609; x=1794382409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E1F87bb525awAof1JLFi6O+XOwtmrtsukGBHxsxN3uE=;
        b=oO/LQK3iy2g0Hgp/BeWhcOXFzJSZQJwuyOImVztRZQqNr9vwfImRz/Q7vwZO9VOYLq
         OcUNLrw67Chm3ZxoqO+JXLMcBju9VFKWdqlG9OKzzOncyfjSd2HNgyGeKfKFPizimTQH
         R78uE4hek3vxNDT/DAw57LluesSqqSNtCyBXLrQzOz8kwX6PHEGo0uEZ9Z43gnsLFzNh
         4b7XNgy1T8xjiEK9BVy3kldP40EORascMPdukDD5TnJKtSJT10d3nSXMr8+UtFGJ4Cyu
         sJvFnz6mLsRr7aBQnsJhS03GF1nP9mvCMS4rETFIAKiwi3O+Bvv4A5pbSWiwXc3dPjDP
         48ug==
X-Forwarded-Encrypted: i=1; AKwUvBz5ctf3kDIMakCQaj6N7CHh7BlPnwsMK6pICY1/5pnDzsBWvRwzpN6bTI/HoaGMT3U6aWsuUBA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DM54laYwrKfBQu6Asytmt8YODS95J6f0J98WkbMwgSQO7nWzv
	7IX2qQQm4ZknGzERnGJLAEsGQRPuzfD8ycl/LQ4FnrykwaoWb3eOtLAb
X-Gm-Gg: AYBFou2ArMTciWfU6tZgL0WGK6teIIXzvB0wP3oe1uoYnKoqcK5K4BAK3sA0OKm9ByY
	utbgkk71jxI+PEGNeq6zbpBznAHITxtJlij0GYXKcVLm1+9Ay+cr8EBvpxbxuKR3dyTCAl/mDez
	b2ppV6NUOX2uu2m8UbnmVl2YlmlSrcJsJPlXUHFcz9bQPtC3k0IANqNwtKFywaoCJp6ATCFh/BP
	DuMQ8TAAnTKQ5Dq5oGHU/Pvv6hx+igZS3aIQPuPfbiAI/8WSc5uXAcp0W7dwPZzd2zb99S1Nx4X
	VwfJ7rMnetvI87EyapXXGLDvBRzM3tb9X/lrXtpWcCQZ4AmJFwGVroYoxKnWW88R36LsSOgGw8X
	+20VjjM7XVnw9wizlZjJBLl9zaoAlNAQgsU305XHg3qkqAP2N0y6zU7TCuLNYBY67K+m6QfF/pk
	WCcdyle9JtEoSXy3a6F9Dg1M43B9iPjcjr2CkxvMubSsoCErngpOOPl3Ig4NxsUUNmrqzXZBuzp
	JpVfmnjG61/yjD1FIqY+txSR/VK6AWsiHheNkwBr/ryho/Hp/dNXFuh3Rs/4qrkgDb14BN8xu//
	arZiiAXP7M/It7ispTuGGufQd4P81pLly/F/KSHIqg==
X-Received: by 2002:a05:693c:8099:b0:35f:ea17:d171 with SMTP id 5a478bee46e88-36a42236aa1mr34685392eec.2.1793777609165;
        Tue, 03 Nov 2026 23:33:29 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d3754sm6295359eec.14.2026.11.03.23.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:33:28 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] i915/perf: remove sysfs entry if idr_alloc() fails in add_config
Date: Wed,  4 Nov 2026 15:33:11 +0800
Message-Id: <20261104073311.1617823-3-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261104073311.1617823-1-lui2012qwq@gmail.com>
References: <20261104073311.1617823-1-lui2012qwq@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i915_perf_add_config_ioctl() creates the dynamic sysfs entry for the OA
config before allocating its id.  If idr_alloc() fails, the error path
drops the config reference via reg_err: without removing the sysfs
entry - unlike the normal remove path, which does sysfs_remove_group()
first.  The leftover attributes point into the freed oa_config; kernfs
only stores the attribute pointer, and show_dynamic_id() reaches the
freed object via container_of (including the show() callback itself),
so reading /sys/class/drm/cardX/metrics/<uuid>/id afterwards is a
use-after-free.

Remove the sysfs group on the idr_alloc() failure path, mirroring the
remove ioctl's ordering (under metrics_lock).

Found by static analysis.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/gpu/drm/i915/i915_perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 19b82427aa..40385f991a 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -4716,6 +4716,7 @@ int i915_perf_add_config_ioctl(struct drm_device *dev, void *data,
 		drm_dbg(&perf->i915->drm,
 			"Failed to create sysfs entry for OA config\n");
 		err = oa_config->id;
+		sysfs_remove_group(perf->metrics_kobj, &oa_config->sysfs_metric);
 		goto sysfs_err;
 	}
 	id = oa_config->id;
-- 
2.25.1

