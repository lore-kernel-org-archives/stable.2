Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191157C702
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967576; cv=none; b=IRO1RFX52yEBu3hV85DXPvW5RdwuvPJK1Ra0D8S0zyt/bNorom7aEjGdO5m7WMB4gww+k5sAjwLxV34dLBabbeP9uwB3QQR6pzKVcNKMLSk1UOHleBzxY+trJmqUKrONJlRNDBO2J4SX2bqG+8SqGisl/f4tPpjz4hv0ECAexlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967576; c=relaxed/simple;
	bh=OOx8MqPhg93i+68JGGKk7n5+aGs8dJP/do5h71r1TiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e++l//HBl2CtvIotFQewZwUKbAS06vJNsNjuoNb0lnQKAchWEUY/KWOnn3JRnw9ufHmveaR9+Z6S3QR/Klk0zGhwCngLzwwyggXvNG/YjxM/63RHVNsjxyzbU0otVCxf0GJbzj7rbSfyy4RCcSLtGgFiYsAbMUTTNOPGGpEa/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q80vHLkB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q80vHLkB"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b965570d7so67278995e9.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788967573; x=1789572373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qny9Pw6KlJvRSxv34Q9JwIuk/CFu5/eD/FR8nxlMyu0=;
        b=q80vHLkB4GDtMVnfldekFW6wJw/eO3SdUbpRIjuA1q+4jHFemktqyCeoSPt5T+1ZCM
         Np/kWiNhfmYyuafYSFtmBle/+SiHl+xLg84PeoqMAs2+gDOsImYrLvLg8KReWD+pgeIL
         is+hKoR+djvJDYj3CjmHPv7G8J+MZdMPR7i3K3RIrR/qafA4gi20gA8zvVVokGxTBTPo
         WjkPHp0dNot/yjAPxEU7k/4z6quK0oVX/+Jo1R7o9FJtY3bMJBXVRg9xJcm8WJqyZBG/
         7cctF3cYkv19gZeuqD/5sQOWlHKHvuvQhPp7j+X46W7UKXuWnltARd2VsAu5CGybI3gd
         TM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967573; x=1789572373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qny9Pw6KlJvRSxv34Q9JwIuk/CFu5/eD/FR8nxlMyu0=;
        b=OcBXW721SGCc1H8ElTpESri1CGl9FY7QvUJ461g+anXdXzprC/Hs8o7NAggJQxPPPw
         wjZbOAw4ycPmMb2vePhzovPn8wNjrICJAW5cPuvxWRkY1hB4zcjA4WguRyjP/dHXKcF3
         t8jV7h2KuL3XHye9Y3wtVxv+8L/Z5LIA8NglTBjoidQpU1YJz5QiKApDEyZMNEmK7fGA
         ifakJrqjD46K9EJTUcs6+gWCX0vAXsxwe9c26JX1j7cr4NvhLCMvy9+JmJFlOycufgWN
         8cBsXlwk15ufprqqmKdr2a5nVqFirBIFawolpRr9LKuTrk71naS6ZXigX+7ppmHo3QE9
         ONMQ==
X-Gm-Message-State: AFuF++mffOtzolqdcGn7yibLs4+bh4iifAdh6FKhjofM4CqJayQM2dOZ
	XHR9GFx3OxRD7dK08gqN6j2deb+TrLKTp8FMVbIZ0zTbZwoefc8qOciYghPlUTjO7BQ=
X-Gm-Gg: AYBFou27/nvxlNpSnPutuF3P064xoEx0qVUxb/XnihEYGySqSU1jq3ulW4pQN8Q3rg7
	WN/Hr2a2iP/2vOT3au2PZwOcvy1OZZowHezv+51AyMBckx98uY4iLD9AQBuQuZOvkfNDeNw+1Xq
	f6fQTd/vdwWjBuMgOU8SGh8OlY0v92TxHZhpNomlbQUPsMbeM1DtfiPQmL3QxzNx29Bv6qIGuEq
	p8yITAhzH+Y+wDpnKUcN9JH4GEBk9qqOZGOGpq6TaFgI9Vj3U9lGb+C7anjArOExUuSoDWikYXH
	nAGjQra4x87fsV8zP1lJsVtTAIWN+T3JMCqRO0k9JfKWYByqgzqnoP1f51rVPuy5OvRii7y07kb
	Kuzsj/U/0Fy2zafn/OMMH7uCc01r2vUf8QjG6MvRJ9elQgBEh07Y2qcxJCegRBYtXzHG8QbN2Zf
	tKaF9QUqtXTOUzzF39Es2BJry1mWJv6ks79HZvi5MrnNMlTdYvJXexQ/bDwXcugpXcoIDf560YB
	6DOZzdUVYU/lCpkHZn/O/zntWdJoyEMS5OOaV9+skV2/Z+Tmh9JRrTjMHNzLQ==
X-Received: by 2002:a05:600d:864f:20b0:49c:fc6e:8cbd with SMTP id 5b1f17b1804b1-49cfc6e8ed8mr247514985e9.33.1788967572659;
        Wed, 09 Sep 2026 08:26:12 -0700 (PDT)
Received: from cachyos-x8664 (h37-122-44-64.dyn.bashtel.ru. [37.122.44.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d04fe7f9dsm380369455e9.0.2026.09.09.08.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:26:12 -0700 (PDT)
From: Akhmed Zhitaev <zhitaevakh@gmail.com>
To: stable@vger.kernel.org
Cc: alexander.deucher@amd.com,
	mario.limonciello@amd.com,
	superm1@kernel.org,
	Akhmed Zhitaev <zhitaevakh@gmail.com>
Subject: [PATCH 7.2.y] drm/amd/display: Scale custom brightness curve from full range
Date: Wed,  9 Sep 2026 20:25:20 +0500
Message-ID: <20260909152520.83763-1-zhitaevakh@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090900-astrology-gallery-8428@gregkh>
References: <2026090900-astrology-gallery-8428@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Custom brightness curves use an 8-bit input signal.  After exporting the
full PWM range to userspace, the curve normalizer still divides requests
by the physical PWM span.  On panels with a nonzero minimum PWM level,
this can produce a curve input greater than 255 and send an invalid
backlight level to DC.

Scale the userspace [0..max] range to the curve's [0..255] range
instead.  This retains the full advertised range and keeps the reverse
readback conversion unchanged.

Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Akhmed Zhitaev <zhitaevakh@gmail.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
(Move to amdgpu_dm_backlight.c)
Link: https://patch.msgid.link/20260813170959.22073-1-zhitaevakh@gmail.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 6fd83a1c2cdea48c396f600795217fbdfb8124f6)
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9320e49e44..b5618df4ed 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5265,10 +5265,10 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 	return 1;
 }
 
-/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
-static inline u32 scale_input_to_fw(int min, int max, u64 input)
+/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
+static inline u32 scale_input_to_fw(int max, u64 input)
 {
-	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
+	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
 }
 
 /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
@@ -5281,7 +5281,7 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
 				      unsigned int min, unsigned int max,
 				      uint32_t *user_brightness)
 {
-	u32 brightness = scale_input_to_fw(min, max, *user_brightness);
+	u32 brightness = scale_input_to_fw(max, *user_brightness);
 	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
 	int left, right;
 
-- 
2.55.0

