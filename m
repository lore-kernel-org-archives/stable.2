Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE83AD50F
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200076; cv=none; b=HYQg+XxJVsqx7LjuL55NsjMw1eemTGFJeqEbnSoee/inl6oEtvWisT6Lq9RD+TAtaOtJViTKIZzRy/dyWH3NFe6/kVF07LQoyF50AdOPqt09WHcS9mmPfEsw04HQd1LX/EoQ33+Ut2H+eeT+dZVjk8VbkGruTdMmCMRCbMgI7Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200076; c=relaxed/simple;
	bh=bx2ZDT6wM9avjFk9s3hs+2FsecCtMhGmoJkQNkCi8LA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PN8fw2rAkXfCDRCE09ZENvTb6jJVJibY+G1symWGzdaDfAF5cHwWat02ePxIDIbuLvjvc7Ve3UZ+qeCp3tf0lB14aayhzd/IL90y4dRgEA8LDfVd471NTJpkhrrXeC35lc9i3PDlORvDd4qtlRyYb1Rukfhzdz2mfRb5EOgAdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/0w+y7z; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/0w+y7z"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398a147688bso1057313a91.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200074; x=1790804874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TVAYOBTNEVAkzNmWopVbzpKk0XjIfuhkQ+/cS4DRbJU=;
        b=C/0w+y7zyjOt3N2iq57LY8lSZcOVEqr+vUsLAcRT4/yk2YhCCDaemLA8uc1/xmNRGm
         M5pNOmot4niN9jj0/DpeFapx+zOLn8FllGStBleBr0Ewc5aMCne2X/AMhg/JLp0df/5v
         z4VA2CyyWHqjdSJmhFI0xoj4FENoQe+CRt4DBxLY0ooNNVw9hV+/s0DGTiTc9kmGc/zs
         iFHojrOtsGCdi1WeQHW0TNelRipiyYkEPX1VOORhE/yTX2vCYHMUqXo+xI2p4lxOuu7Q
         5KeVPnDHLTRdfyvh8HnJ0pWTMsZMX+K2B08ahTlLxiaPBa6XnK5NayTJU993h/QVXRlg
         u5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200074; x=1790804874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TVAYOBTNEVAkzNmWopVbzpKk0XjIfuhkQ+/cS4DRbJU=;
        b=SJOnlclKISFPGY8zWxnlDUV/78vOjpIUXzqDE61g0PTwbcapqxKc4mX1BnwqUvUFLO
         rOOSFEi0gi7XKRp8ewJYUR7yYuKQgV+ufHzuMVnztqFHon8dtrHjy2uXxT9H/cxWZ5e4
         2W79rPwF+CR0vradqID5q+WXIXMtK12SDVdcxxt1Jxnd3lJDhRhlL7RSnZoavP70awCi
         1QxXCIkklX3kRYscY1wO4s6rPcaHQoLz2SWAH548MOqylgwWDQ/g9vN0qEHNqv9ALLWp
         1NPPo1xFC5TMZ5dE8wm6YmrP3f5k0Xor8fQ5c05FwyaYZlL0OchRVZEMlb/6aCPI1cwQ
         9REQ==
X-Gm-Message-State: AFuF++l3oznPNQaN2qENMNzlkQglgVp9+Voh9b/jX5qfackm5i3Ttknc
	J6zc9mL4IiEsYFcY8N/G+N9C7UaTfY75RJV0l7HDABFcm8b6qdbCUZUdYWyqRQ4S47A=
X-Gm-Gg: AYBFou2c8Y922gIehRKITEHdcEmpeTmsivA8ZpdHbMl1pzde9SUhbFotkDDePWJ57+G
	Ja9+Gj/YHNBXW/vKFA7P/Qr6bgrgfERwVPGQQLaLtU86yFYQS+plXMwqpoikSRx9UUi/+r/1aYD
	ZnAxAVPC1B+YQc15mNDLS885dln0hRI9qsat5aJr6H33c7WcW16D8bonkvQbAXcgOJGmA9u+KsN
	OF/sZEKQLrF8rNS6Dt1UQCCNRHKpjtVVOgYt+lMdo2jw8RKAbGvY/q2n+cS4h6C0QcRw4t4ucyL
	T26H9d1IQ6BDyDjT8fhA7yXIPlHzBRat1V4a1GKwUJBUYqd1E7HPa3yGnIwx70nv21gVlW2O/p9
	HzCSUzlj1JzsmJm/Rv6gmN1exjFA2FkC9SziWBl5pjJ3/3s11CC7Ki6nRnlz3sIIMlGeR1dvcrU
	CB/VJ5Tpm7zXVi0R6Jaxqefyjbi2H/+8fmtv0TkXq7n+LtA2cNn9f6VWnEjDH+2UUWmTHM
X-Received: by 2002:a17:90a:da88:b0:3a0:4444:ef1e with SMTP id 98e67ed59e1d1-3a098dfb13amr366559a91.29.1790200074333;
        Wed, 23 Sep 2026 14:47:54 -0700 (PDT)
Received: from fedora ([2607:fb92:3080:b51c:3c6f:fd76:69b:10ff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0813318c1sm2355169a91.4.2026.09.23.14.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:47:52 -0700 (PDT)
From: Ping Cheng <pinglinux@gmail.com>
X-Google-Original-From: Ping Cheng <ping.cheng@wacom.com>
To: lee@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>
Subject: [PATCH 1/2 RESEND] Write shared touch initial status only once
Date: Wed, 23 Sep 2026 14:47:49 -0700
Message-ID: <20260923214749.18635-1-ping.cheng@wacom.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping Cheng <ping.cheng@wacom.com>

For consistency with how the shared has_mute_touch_switch is handled during
registration, let's apply WRITE_ONCE to is_touch_on too.

Cc: stable@vger.kernel.org
Fixes: ba16e5ffbaa1 ("HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration")
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
Note: no code change. Just commit comments and code comments change to the existing patchset

 drivers/hid/wacom_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 8dc7aa1c0a26..33fa491fba92 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2386,7 +2386,7 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 		 * match historic default.
 		 */
 		if (wacom_wac->is_soft_touch_switch)
-			wacom_wac->shared->is_touch_on = true;
+			WRITE_ONCE(wacom_wac->shared->is_touch_on, true);
 	}
 
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
-- 
2.55.0

