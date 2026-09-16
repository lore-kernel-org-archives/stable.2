Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EC6262FC1
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518581; cv=none; b=CvAM4ZvENXx8U2iSclMCBK/+19L0l3RI/10VDiU+Q92i0mnJIWhYJN7SywS3SZdvwmqJN4NrBnke1BYXqsIyPWqTraaXSKoAlj0j7lT3z/dW0TLe6E6DPjWfwmImlv2Zs6nai0l3M4Vm9xFClZAgPgH/WOcim+d96aJU+70nAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518581; c=relaxed/simple;
	bh=JEOTKt0Dzx91mkjXhhoaM6TgD5HWgwbpqOYkcuSDjUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uh4QDrc45Y0wmio3ZOQTv8L4SDBFO8g3E8NNoy9hBpJGkfGaHiKG8JTJdwc+xodGDffKze5Juo0gzMm/CofD0VndGQeyNFsknASD4ENKs18KsFPpGlSpQcTV1HznPRpA66uU/Ydavmf6BS7l5KqujDeMaD/mRu4N86b0Hw+VCFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chU+HpyG; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chU+HpyG"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso2458605e9.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 17:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789518578; x=1790123378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tKqlv/hz08xj9ZVfIOS5h1evGtqTWLQkw0YhrEDSCJE=;
        b=chU+HpyGozVf+AmQCHe8U1B+ejDkeOJcbAiofWsDeOrUEjM7bXEX5QIa/ywBMDkD27
         arFMwBACvIpOaLkozOzxdBp9fSidmJNowzup4y0wYRZw63JlyT2cuUf4Trqpp6K07+9Y
         pArPQsSM0YLORK1HDTdVQCVv8As+34X2u3Jx+roxOZoOlAcYgBbyz3Y1B5UkyHxFto5t
         tx38SgPjNg7HVgOtT0Rc0hoC77Dmoa2nE0GEKr1QxpLY1Q86/HzFVYizUUQhlI9T33/3
         e3D2EjsPBNMrmIJ7HWs1wLX2ahGqW5DPV1du3xLXIFaWPzniYwzUIqxgdDMRHoMwwLyL
         MH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789518578; x=1790123378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tKqlv/hz08xj9ZVfIOS5h1evGtqTWLQkw0YhrEDSCJE=;
        b=DpJhbTWZjcOxCQDSNlvCdQb1G/KwjtsF7+KMnk5vjwKahGWZuCNh3E4PmEPCrKz2s8
         UH93nG1q9JM/9vr5d3520KaIqiw50HHYI8rNF/Q0NxPbotyUkTlt3z/aecjc6pV5O0JD
         5dioXF+O4QKfdXygATyQaRKGEsTKQW+JG99e+gE8SSgZvfrrpH8OuSfbEpQlrvNqp70n
         TIGXwNTMOUUFDfgt9a/xN3tGiK+Sud8PrTjQx05wBAige/9YYEH1p2Pjb6nMEE3xzFxH
         zwtotrktxM5njgF3Hhc9jVaXcetsn98pWx5cmDwVEFiftn6I+3k50kKvM1bnoPQ/zDch
         HLCg==
X-Forwarded-Encrypted: i=1; AKwUvBwXS2eKc1BFkPcJ2qKHhDLudX2YuVBWUT1pP7X02rVebxaZqpK4phPzxBeJTTz16Is4AfWMwQY=@vger.kernel.org
X-Gm-Message-State: AFuF++l2Sejm3gt8DEGUgJCtKHur5MeD0vz3PVkNdqlEMgbJDO5m+/Zz
	0Rca+b22YPHEEJI3DOSaUkEoEKallCSj0YeNncn8D8yjWPfpaVbT4+Wx
X-Gm-Gg: AYBFou1RbEMbzxDHUoEKV64OzYCeB1UY7L1DMCMAc51doZTT0Rxo6mrcQYTnCLZ6o3B
	tBvOsZPoAbgX11BVwIw3QN4v5+0iwpxM+adUKR7gWbMa4+3qozl40/3lLr3gZJAqNNvy46alA1L
	MyrigMyZ5WFJud8r7vSUrOwu40mAGkrSm/hnheAbL5jFl83it6T/5RVEObqTz56jVs3uxs/VgKY
	EJINTGuNCBl0ou4rkSsV+LN/TossXHo2y0lz49sdys5byAQFQwtzsDzpuEmKIrG0y1NBGmF0l6+
	bhGRi7t+wePXioj0TzTmr0TWQ4ExFgWq/uACZnfZxGv1D3DMwVo0UKqpjGuyiHazQUVDtm0H1J1
	75nBM4mXdBKniYgsI5jzJH078njXzgw8gnanYnFCu06y6OMz12esPZDN9ZU/tB1SimAHsmFgCzC
	UW+RseHB6Eh2lDvg4pzSivE9sEmSWpTu7qhyKR1G/RU1Y6/9DdGsoePsPLP4cvue9wS6PqmCrHR
	/7o93gWj/n55BRL2ESkF3Jtt758N/Cy72Mwm2nwYeFFpNOi6/v6
X-Received: by 2002:a05:600c:1f83:b0:49c:c96a:d36b with SMTP id 5b1f17b1804b1-49eb7306966mr4213945e9.12.1789518578208;
        Tue, 15 Sep 2026 17:29:38 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83da99b7sm29827395e9.10.2026.09.15.17.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 17:29:37 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: James Seo <james@equiv.tech>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (hp-wmi-sensors) Fix use-after-free in fungible_show()
Date: Wed, 16 Sep 2026 05:29:26 +0500
Message-ID: <20260916002926.161595-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nsensor->current_state is dynamically replaced as the sensor's state
changes. update_numeric_sensor_from_wobj() does this by freeing the
old string and installing a new one:

	if (strcmp(trimmed, nsensor->current_state)) {
		new_string = hp_wmi_strdup(dev, trimmed);
		if (new_string) {
			devm_kfree(dev, nsensor->current_state);
			nsensor->current_state = new_string;
		}
	}

This function is only ever called from hp_wmi_update_info() while
state->lock is held, so the free-and-replace itself is properly
serialized against concurrent updates.

fungible_show(), however, reads the same pointer after the lock has
already been dropped:

	err = hp_wmi_update_info(state, info);
	if (err)
		return err;

	switch (prop) {
	...
	case HP_WMI_PROPERTY_CURRENT_STATE:
		seq_printf(seqf, "%s\n", nsensor->current_state);
		break;

hp_wmi_update_info() takes state->lock internally and releases it
before returning, so by the time fungible_show() dereferences
nsensor->current_state in seq_printf(), no lock is held. Two
processes reading a sensor's current_state debugfs entry at
overlapping times (or one reading it while another read of the same
sensor triggers a refresh) can race: one thread's seq_printf() can
be part-way through printing the string at the moment another
thread's call into update_numeric_sensor_from_wobj() frees it with
devm_kfree() and installs a new pointer, causing a use-after-free
read.

Take state->lock around the read in fungible_show() as well, so it
can never run concurrently with the free-and-replace in
update_numeric_sensor_from_wobj().

Fixes: 23902f98f8d4 ("hwmon: add HP WMI Sensors driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/hwmon/hp-wmi-sensors.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
index 03c684b..55aee16 100644
--- a/drivers/hwmon/hp-wmi-sensors.c
+++ b/drivers/hwmon/hp-wmi-sensors.c
@@ -1247,7 +1247,9 @@ static int fungible_show(struct seq_file *seqf, enum hp_wmi_property prop)
 		break;
 
 	case HP_WMI_PROPERTY_CURRENT_STATE:
+		mutex_lock(&state->lock);
 		seq_printf(seqf, "%s\n", nsensor->current_state);
+		mutex_unlock(&state->lock);
 		break;
 
 	case HP_WMI_PROPERTY_UNIT_MODIFIER:
-- 
2.43.0

