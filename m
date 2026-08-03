Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC83C108F
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 04:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785816652; cv=none; b=tnTXU7h8eAdFPqlIcMVTKIwoJQasXj1Gne/uCpeEKjh28rXb/buSYS8H8qAZ7X8lj5K7S5TWaLpcQrAUURwKWFsEqjqjK1Pb0SLPX7Z+cGoLiqHaXdlKXT8p/0EmmzzcJgZ7qTiH71dVbEQT5NrpxkhfvFNWBwLBkwd2RzVGiHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785816652; c=relaxed/simple;
	bh=bB+a+BsRvdyrxlR8ORveXOEKWUU2Oz0jfXPJiMmQS+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8OxauLQPKmI75iq5+j6Sv3VYnEETpZT/n2i6aIOslE+ODMOQWB2NCqsyOAVfVpUIwpAeyq2Fdj538h2EqGmUcDq3yTQCwU3U7cx38LOtg7icPcogcJyuiRR2MXJkH+eEEDZjMrAB3RzC6BHg1wpnxRS27hz7J5EoHAi0oMX44w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BWG2NJhA; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BWG2NJhA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785766417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nNuvHuH8fsCvdyIJJC/9rVCMMyZkr6Bz657LnndEBGA=;
	b=BWG2NJhA9mYQOAkIRzvnKJR/41EUlAG1gSIASEIwHRoUUrBLE0hSosrNDnV9D7SkmtjUP8
	tw1iFogd3zU7Z7eFRlrvXEogNrfX/U02KOPDGp35Utfc9cC01q0zqivv0hycgiqDfZqYpn
	2FJFZ9Y5Ul9hXL/rw4deh36o3UrMXog=
From: Junjie Cao <junjie.cao@linux.dev>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v2 3/3] backlight: aw99706: Honor the core blank state in update_status()
Date: Mon,  3 Aug 2026 07:13:10 -0700
Message-ID: <20260803141310.1379194-4-junjie.cao@linux.dev>
In-Reply-To: <20260803141310.1379194-1-junjie.cao@linux.dev>
References: <20260803141310.1379194-1-junjie.cao@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

update_status() passes props.brightness straight to the hardware and
ignores the power/blank state tracked by the core. Writing 4 to the
bl_power sysfs attribute or blanking the framebuffer therefore leaves
the backlight lit.

Use backlight_get_brightness(), which returns 0 while the device is
blanked.

Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 drivers/video/backlight/aw99706.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/aw99706.c
index dfb4b38b5b4c..d035ff5af52c 100644
--- a/drivers/video/backlight/aw99706.c
+++ b/drivers/video/backlight/aw99706.c
@@ -340,7 +340,7 @@ static int aw99706_bl_update_status(struct backlight_device *bl)
 {
 	struct aw99706_device *aw = bl_get_data(bl);
 
-	return aw99706_update_brightness(aw, bl->props.brightness);
+	return aw99706_update_brightness(aw, backlight_get_brightness(bl));
 }
 
 static const struct backlight_ops aw99706_bl_ops = {
-- 
2.43.0

