Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD0D386423
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201212; cv=none; b=L6SSzBvGc6Prb9b4H7kQLkQSdJlyfEm3B21qnExyjB3pU8yvz1IpAspWmrl49Wyegj38oiEyyVRlvA6UxKevy0XQQgfvwQ9fyuta2BKm8deaPNv8A33MP21Q2iWj+aygy40Kvq/BGKQ1HugbMjLjiWJyuwc27OW4WDIEbmZXCa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201212; c=relaxed/simple;
	bh=4urCyMVaiNsaJ5oTpbhYdSXWJFtAQ+6atKPamaiUKok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5h7s1ZFaiTluckh2CFrTtOUkqohbpC5kKFpVXJ8npYVq4Ta3YzrMqnfe471Ebv5+KPr/JPKotqneVrmp9Q/6pnjlMUikHfa78S7qCkElFb4jT2HOP9haoWe2GXL3MoVrJeqk+wdqDQgGoor6Xzn3veOGbx9bR/XGAVpsWvKCPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsMtwl7Y; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsMtwl7Y"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-144f79153f5so1293645c88.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 18:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201210; x=1792806010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fOueiXluXjDj/m0cQAsVf7wLNjXdqluvAn8HpEkfgJc=;
        b=FsMtwl7YAxjF1zetKNovxXluFmVFsyLCH4DY/lHqdbRb+3E1zHjArs7Mq+eRYwe/Tc
         prZSZMhbZ/0ovMeTYaRvPPxxnPy0CmmwsMnh7F4PgY4p/tbXflnBXEAFMW6C8oXH/tj7
         nyd7h31x6c15W5xHH8ZBMF44iTACLO8FM+p/9CNu2WuXnHBt07p4tEUAvRVuvOT2hBTe
         K9t7On1H7e1ixGNjA1rXldhj4G2oPe+qmj/U5IZoT4pgWleJKsqFruQJ7SaAU6eNfWxj
         vQpLBhB9se6Is7MKTUvf1kynkpLU1JvMMLr/jhuMhZLtY9QlryEvlv8GrktMxqBD7Y9/
         gFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201210; x=1792806010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fOueiXluXjDj/m0cQAsVf7wLNjXdqluvAn8HpEkfgJc=;
        b=r1fo0R6hyw4OgpGvi2iZ/gJa8n4PQP40oDsqxNJuAbYEeREKM8Dah4OzW9NbpjdI/R
         ZRaQRKeLacP37zCUpJKXp5nOlFe5UazQmPwJ9xdjLVg5XKDt8wntzmAGXy8bTfcQ2wcZ
         IwJ1TLzmiI6tjnTfYTNO2eETZ4cXvV2/uXAbxhqIOQGrPNGzEFTfdIAR0Cz+xNTULTry
         9d6Wiya+Ew5EATh2KTG+sk48CnBrMk2M+EtePaxCVfL3LAUHzWlSEpEKz8nG5dXz0fS6
         zgPl/OIZ72Y5jzxMpo8EFPNTFiI8itKNPvlDmBv9HALqzgRCyVz3RcT3pXY5ZQFX+5sn
         kXAg==
X-Forwarded-Encrypted: i=1; AKwUvBzM6W5yjApvEvxvN5WHOyOh1lDCkMqXedVMdF8qpBImSwPSv3qzLrX32zUFxDew+Php/mOX1OY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFcoaCiwlvRWTOXIk8X1seqDFHOC+9nK86B/AtX28HskAmCxV5
	vxdlIXxS7yOtIKgpdxk7jgFC3Kgmms/gp1m7xfjkqzwmPs1IZrsdG3Mg
X-Gm-Gg: AYBFou3chOaQsuyUqb7M6jyY1g/OAMjC2K7+5HqolzLD2CZuOOI5/yGSnSpe7YHKHny
	3iHq9rPwsyYd4Oau34SKyyI9TJ8gaIhTmIHucucXNFMJDKp/Vt+LcmvmltSzZpOinY/Ww76pET9
	QpySFsIbq8jc1kWgNyc7r3h5z+zzcNlk4to+ZoCPThV2gGy1p2746+tah71EcByavd6woTQuZFb
	4E5Poyhg4+TVmDpMUdB0S146+TRq/l769K/WIqi9AO+WGo2DyZaHk+mQ2lVPZLacWsAYbPzTQrT
	JAxZynxjReyi7LCAfULlLIxjUHaGHr32Jsni+L8sv+COPsOjUp4KYjMsdcXjNwWxrjDRJYMhtWx
	0Dz/bIsNVRkT9q/NniJyhmtu/srR3NMVRVtvUQ5qd0WpgKWUaftQSxSMqwGxl6J+jENYWwSIcsJ
	n4WfoM9WkbCBLuGsBRUYPbLwsdJMOqOrnL3rUtgEMUuJE9/bXfngTYmGY9/emulCOwjXFV68CZ7
	RpaqSBzc9NYRyVsRJaSEVVPGPj1pS3o+6wBmj1igmqEgZqbcMgtRbHRDD2xiOJmHSA7ne7mr5o=
X-Received: by 2002:a05:7022:f401:b0:184:60dc:c381 with SMTP id a92af1059eb24-1851238b5cdmr2818837c88.23.1792201210084;
        Fri, 16 Oct 2026 18:40:10 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:09 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 03/11] HID: hid-lenovo-go-s: Prevent deadlock if device removed during setup
Date: Fri, 16 Oct 2026 18:39:48 -0700
Message-ID: <20261017013956.2440130-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid_gos_cfg_remove() calls a mutex before canceling delayed work. That
delayed work function calls mcu_property_out(), which holds the same mutex.
Prevent deadlock by removing the mutex. Additionally, since
cancel_delayed_work has the potential to re-arm, switch to
disable_delayed_work.

Retaking the mutex before removing attributes could deadlock on store()
as well, so don't retake the mutex.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index e979527ece8e..b27e82ec9b76 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1445,9 +1445,9 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
 
 static void hid_gos_cfg_remove(struct hid_device *hdev)
 {
-	guard(mutex)(&drvdata.cfg_mutex);
-	cancel_delayed_work_sync(&drvdata.gos_cfg_setup);
+	disable_delayed_work_sync(&drvdata.gos_cfg_setup);
 	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
+
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 	hid_set_drvdata(hdev, NULL);
-- 
2.55.0

