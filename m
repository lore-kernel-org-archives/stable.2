Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1633D47CE
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461350; cv=none; b=ksHzYThv5Vft24rik+kjd8t8tNz43ga4agNLNxo4k/LT4FKSqdaJ7sb+kpTRscZtfRypDgwdpOOuUvVqR8QjMIq1suVZ3mPs+JXuQQfvLb3QalorefZY516x01li4nqR2KLSfPA34PtxrzWnSNN3UUPMVWiTLZM6/uuJ0r0+bG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461350; c=relaxed/simple;
	bh=OM/p48Qc0aO3PcwqIVzqa8+f4RK6lv3rfeLufct8Tg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l0t6bZaBiAx5GmnSHcTZ9keALVX7nRYtCuq5iLG9twRrQnbYAGwtCRgPoiJM+T3CtRdGL2E1FsVff2tvPdY59QskBb4oQgF10GdM5+K5AUsUBwAd+ljU9kyd/Jz2AAgXE8k2dgk/7iQzKxgIHVo6DQDWXxno3BzJD2P85jX02G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8Chn+4Q; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8Chn+4Q"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eefae4so8804195ad.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789461347; x=1790066147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/IPwSIiNpzASsj4SkKRZI8zUj5CTEryEYHaO7CYib70=;
        b=a8Chn+4QvGWgj6dT8mI1PV87sr/HTz1CtptMT4n/abBqbfXwsCWlk+wYwgGLL+3fTR
         EKHlHDVAARQDMAUMTQu/t9S2x7FpTfmpIP7S90aWozUR1ZwM05fWzyxrOhq3Eg9RiTCG
         TYXxN1L4hP9XFUJ96FSMgo+3pSDvrZcsru/wCAOKK1sNrdS/noYJtYl9Dt8iTan4ANwo
         yB8KiHtAHm2TcVC5B9DE1HtoAKrPHF54kR9V4so+zx0cwGyq6UpiMrca9A9sUUiCwqKy
         6IHDF3OUsnZcbGMpaDKgSUR78aXuRWtb+tZuPZJa5sWJJQEBugkUMXb0vWi9VP4A1knh
         Vw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789461347; x=1790066147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/IPwSIiNpzASsj4SkKRZI8zUj5CTEryEYHaO7CYib70=;
        b=0Eo7SlF3eShmvOVRiA8C3GaoE13J8ChSJQEfh+8kPISl8ndzwG8EWvpTm9Ods4Bwu7
         7UZDAf3WRBoluA5VJpdBZwSJir8oFQUmTCs7H9vpS266VJoGlkx6AK8ueyrL+xU+J9Rk
         baxLWhf2DB7IGdRemtKIkEYZrYRgMEU4Kij0rOEcA4pfyMH+X77A5Z3aIySzY4VTbRXf
         E1m4lsKbj14rqb7FsYsP4fu0jQR/yg2+yBtLm30sshZVNxQQSIxx1tBIt2ZLuyLBl2lf
         m9RB4G6RvtnOFqDouW9/sCugLERn2/ueP8QQIZa7Ywk6IKmAYcjrt5dAP5DCK958b3zR
         IO6g==
X-Forwarded-Encrypted: i=1; AKwUvBwydXDooiIBr0Dy4TGyH4i3zxyWLUlf82r/XkGZqJyyTsPrApQqjXYWV9aoNCPhADo76PMXlQc=@vger.kernel.org
X-Gm-Message-State: AFuF++kJu2H4Q3mgzoFezThn/LTKT2ngYLJvPgQ3lxSPJ3cW2ufymGUe
	mer/tV+TTkgMbi8t2vOqdzNsUsjDcJKI/kQIrcbwKZRgNRwo9LiH4Z+0
X-Gm-Gg: AYBFou2Ll32zCZK7RX2a/go6G+c8QzLrF6Zt7wGz/RrdyPOR8x8iCfAkKUm2UQ16Kt2
	KvGVcjDSxOvnUgxUZTMaIWKZ70emgiy2+ilXXYb7Snc850bRy3VzNSqFmRQN6bmRZ4y6jyvBxcK
	ctGbGidUHgYwnmj7TgLJ0+rmg7/1jNddRviW519OGYald7VRDWgziYgwXGsBYcirLOw+a+T3Bl6
	mBNNEsvOS6VVwSvDPmvnRqZCTTTTCW8lZhS1k+1FBqTnuKVycG+YPtAMcS3ykVD9CZSo3eHQBg2
	owYEij4APIz4QcLVCl2b6eFhE5dG5uJM3FbO2MDHg1O0v3MpB8kjjOkWwFbh8pf58lBmppoMCeF
	nJ4eEZOU/pup/jvOmdYZ5Kc0Y0PKTK+zY3bEcsXKAfY0Y6ZHyoqLxBDL3pnehtZhQIAiGSM4Evt
	vg1SWPTCUZ4w0rjkSiw/uhyBaKKaDyGUjnof5VbuSWBYE9H/62WwM1WWTI8Rny+6snjxX4
X-Received: by 2002:a17:902:f681:b0:2dd:68a7:d853 with SMTP id d9443c01a7336-2dd764ec710mr35774085ad.9.1789461347173;
        Tue, 15 Sep 2026 01:35:47 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ccadb4fsm62294745ad.2.2026.09.15.01.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:35:46 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: og01a1b: power off sensor on remove
Date: Tue, 15 Sep 2026 16:35:34 +0800
Message-ID: <20260915083534.2290587-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

og01a1b_probe() powers the sensor on explicitly before identifying and
initializing it. After a successful probe, runtime PM is enabled and
pm_runtime_idle() is used to allow the runtime suspend callback to
power the sensor off.

The probe error path explicitly calls og01a1b_power_off(), but the
normal remove path only disables runtime PM. pm_runtime_disable() does
not guarantee that an active device is runtime suspended, so the
sensor can remain powered when the driver is removed. This also leaves
the xvclk enable performed by og01a1b_power_on() unbalanced.

After disabling runtime PM, check whether the device is already
suspended. If it is still active, power the sensor off explicitly and
update the runtime PM state accordingly. Avoid powering it off again
when runtime suspend has already done so.

This issue was found by manual code inspection.

Fixes: a95ffde28783 ("media: i2c: og01a1b: Add support of xvclk supply clock in power management")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/i2c/og01a1b.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/i2c/og01a1b.c b/drivers/media/i2c/og01a1b.c
index 1675f0460969..1cece90c59ee 100644
--- a/drivers/media/i2c/og01a1b.c
+++ b/drivers/media/i2c/og01a1b.c
@@ -956,6 +956,11 @@ static void og01a1b_remove(struct i2c_client *client)
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(sd->ctrl_handler);
 	pm_runtime_disable(og01a1b->dev);
+
+	if (!pm_runtime_status_suspended(og01a1b->dev)) {
+		og01a1b_power_off(og01a1b->dev);
+		pm_runtime_set_suspended(og01a1b->dev);
+	}
 }
 
 static int og01a1b_probe(struct i2c_client *client)
-- 
2.43.0

