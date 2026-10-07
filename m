Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903C44AA598
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378830; cv=none; b=N4yKftUh7sYjW9tdomQYEJZEoZzvXbO9tX31OYjEsODLHBFx3oJPhpLvS5jkwz5Z3GwI16aoSOLiUA4BDXMVbfL6Cph6RT67149pEodOLY7XrJUa45qXnap/QEpV1wt1aGzOHd8o2GCEa6yECw2+jFVlb4yV2FzVS6ddL7diInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378830; c=relaxed/simple;
	bh=RhLVAJh+uMum/PtsHXFjeBWU17MBBlUHI447nD9sKy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbxUMDI+i/Q0wBLhABK13np65neL6eG61SYxVueDc1KGHS4jHyO2ANpxh5tqtFAY+u56mTjQfuW/S5XsINzjIpd0Tu/pYg36dtpv6EkLCMOS+WPwthJ0YAceYjwxd/CWpz60dOKiqWZqrmOsRXYbku28XfkL02zirP8xRXW5E9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGBDj4JV; arc=none smtp.client-ip=74.125.230.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGBDj4JV"
Received: by mail-lr2-f3.google.com with SMTP id 38308e7fff4ca-3a77df9781eso23053101fa.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 06:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791378820; x=1791983620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7raFCL+DaDHQ/Xzt3dKVl/XyqPmVrA37jhza1G8kvFU=;
        b=jGBDj4JVtGpl8TMFh1MEzDz41ipbKi0MpHpKRwf8c+ceCtivh3G7puJUnb4goryXgO
         tUr8owFOG78ddLVdBhCroFeFC3q/pz4stAMRiSTFtFH15km73i0s9bH48WQt9nMWL0tH
         2+tpcred9d1ogGDykFWbzw0X3ih7U+ZmOI1rJHXjIP9ouNvLxuJMr/OO+cSYzARwG+Jk
         tIlEKzOWaLZax2o1BqxVsUEhGl+apJGWduSIBfvi4w7mQcZ1YANu9dldstltn6FlvYro
         FiAhYePCKjx9E1k5odwLDQ8CX0pQThB7Ea9VNk3TEASGoHRIMg2jV0wzNxLISisz7W9d
         o0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791378820; x=1791983620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7raFCL+DaDHQ/Xzt3dKVl/XyqPmVrA37jhza1G8kvFU=;
        b=ZjJnO12v9e1q7oHcobjLeW4skWROa03PigweLBMxclcOGy8Od3ONS/X7r3rwOdm/Iv
         ultDFy+SK7zW0riXK7Gv2jTmQ+T+hBa8fxsSkhnyPVNt2ROvbxjBau34aWG9Fx2gQE+q
         tFxc/70bsdmwAo1Yjy94dmSsTByAdDfEteqce9Nke8sd2MGpTuhU5RDvwlSXLqZGHmVs
         e/5bt7UUT7/xHchIzg+RblJHXS9reZ0poHRD/2ydWNxGxu/bwvqKn2xAzS7LP3CB4/UK
         hmq+7sR68aRJKCmtZPozTLFlPUBaGGZls59VRJmZM0UlKBhOvT56YUxnruKf3o08fJY2
         P0tA==
X-Gm-Message-State: AFq9FYIMMCAqmqJG34Da5l6uiOWVcbTVPkjbKKSdPWqdiG/t0Z4tynP9
	ZIlyNXtnZ9AaaitE00G5yhTMuT9CPlrn+mnb6yJcORAXdNk4nUlhlFGmmeEGK3nl
X-Gm-Gg: AYBFou0BgC03YjHldpHMIS13socikmXqXeSfGUhUs3+DZooccI/uosIFXt/1xF9XvvD
	1o22GjC/BpE/UYmNjMYI0to6hFBioY4gsLgmVQ29rMSYidHh++qbpZIReVZ8500k7xDa0ElLb8a
	SX5p/l3svxeuRDJbSt2H7B5rnrFVrPo+33D0UiEvHSam0k85tVqdm3wm1a9j9O2OLQsIM5x+O0s
	HqBOfzqw/rQb1bEwiwHklJVU+swa7cTY3w29I5t6hhyNaNPYYnZvHPhZcY2qV52GCxmaDETBfDH
	fUkCkkWdXpqOWnmNGu5ImHlV8jOXe9WHJvtYiyRcP9Ra43QL8NB/zLEEjhWOtTbkLf1ygdN0Q9+
	A2klATISmsYnrE6xIe7WkS5G/XO4xzgzYfWixyWSdSM267QIw71Rg8qR8ixMNqiLlO+VYbm2Ut3
	WOmfQtTBSB+psz7hdkvc4AKvkdT3TWNlfbrzb1dsUTVHi+u+lZaxDK2ePqI1qX9JH+GFQvYX/8K
	i0a0mAa0Yw9lgwx
X-Received: by 2002:a05:6512:4027:b0:5bc:c63f:7004 with SMTP id 2adb3069b0e04-5bcd072ddc7mr896476e87.48.1791378820139;
        Wed, 07 Oct 2026 06:13:40 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcd309149asm21640e87.53.2026.10.07.06.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:13:39 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Ray Wu <ray.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.1] drm/amd/display: Fix out-of-bounds read in dp_get_eq_aux_rd_interval()
Date: Wed,  7 Oct 2026 16:13:33 +0300
Message-ID: <20261007131333.120389-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harry Wentland <harry.wentland@amd.com>

commit e8b4d37eba05141ee01794fc6b7f2da808cee83b upstream.

[Why & How]
The aux_rd_interval array in struct dc_lttpr_caps is declared with
MAX_REPEATER_CNT - 1 (7) elements, indexed 0..6. However, the offset
parameter passed to dp_get_eq_aux_rd_interval() can be as large as
MAX_REPEATER_CNT (8) when a sink reports 8 LTTPR repeaters via DPCD.
This leads to an out-of-bounds read of aux_rd_interval[7] when offset
is 8.

Fix this by growing aux_rd_interval to MAX_REPEATER_CNT elements to
accommodate the full range of valid repeater counts defined by the DP
spec.

Assisted-by: GitHub Copilot:Claude claude-4-opus
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a55a458a8df37a65ffda5cf721d554a8f74f6b04)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-53330

 drivers/gpu/drm/amd/display/dc/dc_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 6050a3469a57..579a38478d0f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -403,7 +403,7 @@ struct dc_lttpr_caps {
 	uint8_t max_ext_timeout;
 	union dp_main_link_channel_coding_lttpr_cap main_link_channel_coding;
 	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
-	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
+	uint8_t aux_rd_interval[MAX_REPEATER_CNT];
 };
 
 struct dc_dongle_dfp_cap_ext {
-- 
2.53.0

