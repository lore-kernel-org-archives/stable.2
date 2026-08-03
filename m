Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21421A9FB0
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785793836; cv=none; b=Xy5i5eSepCZh84GdEhZRY2Vhq9577benfXHKXQIMD4bnexdQM5YlEKgkWyAX1c0ODuzZHEPbRDtsHNV5Ie80zcS2jOlVanMZ/s3H4P06HhLwK3LCq0531J4ubSc9DWG4I8Ev7PqZcho61Y1jAHkNtBUpymlLao7PgpOSXhL1HrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785793836; c=relaxed/simple;
	bh=wUno3zBDtdnsTP4LkwxzXIyM/e0evS5xh0VuPHMkrC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kizeJmrvxYZSIAyyBKevKTqgpHxEf836wasdR+2iGz7SNmvX9aAYjEu4Z3ia8QLPOaORXWWtMr9fOdu3VuWh3F6m4b5AH+S2NqzOvuqfIMJjJgx+O6/NWcX0vGmwx7xOmU/AdVS2Kph1VVv4Yt5xesTLrgI3WOtFMgrRiq9PHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2W6H9FV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2W6H9FV"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954afac04bso30241185e9.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 14:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785793833; x=1786398633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eTvs94omlnn6KRMYaf/xTULVGskgqo6uDr6699pyZW4=;
        b=O2W6H9FVb9HwDj3weyT4AVKmBINLZSiy9hIoJ3u/LqxIyEYES1DC1jhs8IvNwgsx6c
         wgegVmtitA1yzVkbPU8Z3fawUkAZcWNB79zY52htrP3Mlv1MbLj3kUiXEFrIAmW2geY6
         AWLt9y0Tgmi1/i0DHzNfwDMQSieFI5kKOYwoNuSTpahimr3mHhLKwklZAAk74zd5G/ZX
         ViBZhsHVIkX5xaDnboytWBWbjpGaiRNlHlINl86LxUg56G+nhsz80y20xYBWU3kAaf23
         Tt3fRbk8qf/JBF9LXOYddkL7ZNsmkiDpXPnrhG6pbKr0SQeAGQzbl2JEuU56QeJdjQLb
         PoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785793833; x=1786398633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eTvs94omlnn6KRMYaf/xTULVGskgqo6uDr6699pyZW4=;
        b=c5jlH9MpvoTMSBw9UU2ow32KAmINY0ecTtakqhS0TzlhXWIGibPH5hYIokotDk1bh2
         i3k5QjSp4GtPGjgYX4Dd83lA53GYV5aTTEkEjak8Xk4xdy+9EbArTYaq5COE88y8aUGm
         CMkKJ3mQ0NUQxytxuaQ8eLCWdizMYNKHYcjRSmSNKS+NVSvhdvWc8dsc/isv150zIbm2
         GDsSLCZoklYoYxpq4Mu/88aqnzAJ1+knKWE+yZWvIXpcTn5ZWcCBTvi1+ivtoZv2YfWA
         0u/XLKOOvyv/H5Jbda4R4IIyqgQLVp9Oq/LqDdY2gDwP9EbwOslNt9cSZ5r/Z6d1WtaY
         dAQw==
X-Forwarded-Encrypted: i=1; AHgh+Rq8xS5LHrB7hyAYaTqoCz+crG+i7lScgYe/UkBcXgqWgOFP7lHuaKUdMJZ7s0y3/JGhQjYINc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGC0KQNYF6f5KSMLm8Fmf7bdcPKvVnGFPFQ9xh6vICNveAL2OV
	FOG0IXBxR4JysuH/Y18R3guQBu4R6gALmSjFba/FR4MU2zwlFJMt5Tri
X-Gm-Gg: AR+sD107PLO9O2XflD2oK5GFZCrEHqJLwhG9e51QkN+pIw6+TOI1AJpQsl6N4SaRBLH
	5iWON5+Jg8eW99RTZm0Q/JeC+Yl5YuZwlgECJmgrt5HsVJSWOioa2xSaLQb8pNmIoZoolyEfqed
	mDZ2yvGgkjBAVkCACWheZiH0uwICVIUm4SwlEJuM11B3A7aWyNM7N+JH0yhjwqH0Jte9whiHB8J
	Vfw9THy/9Sk3srPtm/vhLcxpxVeJSMNyEBuPp7PydxzaVd6QedApWQ9ljS1R+z8OAgXwLaJhySh
	bfTJim4iCfCeIbEg+8fCdpptCudu0PJrnUTTZmnvaJUGN8MxPaGu+vVJ6Y/1viKWNfie89rTveN
	g6urIlCaLRu5hH1b3Lar9/4khqApY7bAU7DT6nwhwbuCSNoVQZZbNL0UThFfw5Yc9eceMjjEz7/
	aA3ZitG1jrrrEVaFY2Yh9vLdgXRPaRuGllsrHTjkvQMvQCDLzm3QUUxFqjDoLwZ4/zBgFvWvCkt
	GQ6li4tuYyhcUax+AdkVCZSrbXynejyCXoQWeHqNVY=
X-Received: by 2002:a05:600c:34d1:b0:495:7561:a9ed with SMTP id 5b1f17b1804b1-4980c679d9dmr297266215e9.17.1785793833068;
        Mon, 03 Aug 2026 14:50:33 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fdf392sm44274645e9.11.2026.08.03.14.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:50:32 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: lyude@redhat.com,
	dakr@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] drm/nouveau/iccsense: fix memory leak in nvkm_iccsense_oneinit
Date: Tue,  4 Aug 2026 02:50:22 +0500
Message-ID: <20260803215022.172201-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvbios_iccsense_parse() allocates stbl.rail via kmalloc_objs() to hold
the per-entry power-rail table parsed out of the vbios ICCSENSE table
(drivers/gpu/drm/nouveau/nvkm/subdev/bios/iccsense.c). The only
consumer of that table, nvkm_iccsense_oneinit(), copies the fields it
needs into freshly allocated struct nvkm_iccsense_rail nodes but never
frees stbl.rail itself, on either the normal return path or the
-ENOMEM error path taken when a rail node allocation fails.

nvkm_iccsense_dtor() only walks and frees iccsense->rails (the copied
nodes) and iccsense->sensors -- it has no reference to the transient
stbl.rail array, so that allocation is unrecoverably leaked every time
oneinit() runs.

Observed with kmemleak on a KASAN build:

  unreferenced object 0xffff888104cbe480 (size 96)
  comm "(udev-worker)" pid 526
  backtrace:
    nvbios_iccsense_parse+0x217/0x740 [nouveau]
    nvkm_iccsense_oneinit+0x140/0xdd0

Free stbl.rail once we're done consuming it, via a common exit path
that also covers the -ENOMEM case.

Note: ret is reset to 0 immediately before the loop rather than at
declaration time, since it is already in use a few lines earlier for
the unrelated nvbios_power_budget_header()/nvbios_power_budget_entry()
return codes. Returning it unreset from the done: label would leak
that unrelated (and commonly non-zero, e.g. on boards without a power
budget table) status code out of oneinit() on the success path.

Fixes: b71c0892631a ("drm/nouveau/iccsense: implement for ina209, ina219 and ina3221")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
index 3ccdbbe2fad0..6bfe4913dcb6 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
@@ -239,6 +239,7 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
 		return 0;
 
 	iccsense->data_valid = true;
+	ret = 0;
 	for (i = 0; i < stbl.nr_entry; ++i) {
 		struct pwr_rail_t *pwr_rail = &stbl.rail[i];
 		struct nvkm_iccsense_sensor *sensor;
@@ -280,8 +281,10 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
 			}
 
 			rail = kmalloc_obj(*rail);
-			if (!rail)
-				return -ENOMEM;
+			if (!rail) {
+				ret = -ENOMEM;
+				goto done;
+			}
 
 			rail->read = read;
 			rail->sensor = sensor;
@@ -291,7 +294,10 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
 			list_add_tail(&rail->head, &iccsense->rails);
 		}
 	}
-	return 0;
+
+done:
+	kfree(stbl.rail);
+	return ret;
 }
 
 static int
-- 
2.55.0

