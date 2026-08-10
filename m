Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7AF30D413
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 04:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786336129; cv=none; b=BMMngdVJyFGA8j2tVBmQ6JXc2Oh9fTkUrCHsDKo/TppGTGJI4/51xgU7gFsjuclHreXN3be0IFQDKgascYPX+rxVr0u1fo3tJYIIZY6wgZi9euLO/jTt8y8qMsqHzc+CdU/pzSjADlA+lv7zwO+HT0t8un4gKYfHrFacMG6VnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786336129; c=relaxed/simple;
	bh=wkVugtm0RK+PqsY5OjF4fBlE5x70gVAyAJs2seIi9es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qe96GoTh9ckNSHgBVCfMLFN50j+rqV0SBIDgIQ49lwTa0d2oa09YVjt7ZXK/3PifHT84aTrmUqTz5t+Xt/L6QtnwNwobpTdK894E5vqXJlUVTNazvGuJXWDIuEMGgIZxv0IOwPas4oo2QFpFNYPyaFuKp7+Zi2Dboe/dmxzBirs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akVIE+0Q; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akVIE+0Q"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso1145800a91.1
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 21:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786336127; x=1786940927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pX6MMBhGhY7ZKweNH7lUk+HVieNOWtynN9b6a3M3yBg=;
        b=akVIE+0Qi5UEm8UKi2qA3qGTOxBfhlYstQyXYTrO35vZ3UfXP1V9uSOe/rNZb85KpQ
         vpaO0XaoEb3jdZ99eX8Sh7g6c9CkUE+e6Wen21C9AVVJNUr0vvPnS9T/lFf6Zkrg3+nm
         1xz+kAOJv9c/9th0HShtVyz0xWX29XmTL6/mJxr3t5LUTfqkFC2PXXhKOoVwLFKDkMP2
         vtmIkAIOdCf/G+lTh8OfjH1CUn9ZrSNT2tnAiuvPsCOoy/2vOPM2enGhQ6tYKWYFJOgn
         QuN3GW8/6JN3wU/DCO845e30S6rBV4ukxggAJNbmDps504wZZPKqI5EibwREmrlwmoNc
         oJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786336127; x=1786940927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pX6MMBhGhY7ZKweNH7lUk+HVieNOWtynN9b6a3M3yBg=;
        b=WY1Pr6IGefch4TX5wQGZBbb3vG64Ae6Kw+KAdUtXo1jlMiP5eeR6VKc9BP8ACUgDmY
         JS483FqAXVl3Hv7+lE4iJD50uSLmEi3xm9shfs2aD3YQWnarvI93Sr4mmRIBgrxsF4ej
         0DfW/PagrIgrHYRYUdaBCrZ/NT3Uon6Dn0iAqjnMfmzH24jXscu1R8qDiWQGBKc/d5XC
         17dmzpq9vr48ZfVLVfu2eZmpI5l8uyrb5D9G+ho/OU5rf8m4B4g09jIUvMu6Rv59BXSE
         IFZcCR7MgW1SC1ZdfBueix4aw6KAEXBz5uKksIRM+ER8824HeBoAnfcXESuFPryxH4h8
         fuSw==
X-Forwarded-Encrypted: i=1; AHgh+RqTPiPDArJXd/BdhXQ/xvvihHCUw/3K40v29lWwXRqU4+9vzrCLG2fqDxYUwkZDVODJ4mPtTTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXT9/y+7heWhro+JeK20enomdcaYPrvslNAWPiqlCi1W1BHQ0V
	OiBA5A/m56VU6djUDFHNnWVLfFnMC9XrQJlf8mcTvHnzHpgJtLZEh5xP
X-Gm-Gg: AR+sD13gL72ajTVAgyHQj5bRPW4fRSdTvKzpiT8pk1Tqhhs0+biTDouEenRbBqz/7jW
	JgOFyia8WWrEyqzFZkbONv2JyYjaqexNcvTXxAN7VNKkvfXLTkq8zeL0PZ3J/7R7kVhmpcNUXXU
	bIY6eg6S9s6Tk1ETdDln2MvlGGS1/29OWwRBkHHO9FhyCHwZXGep72sKmkazlNngDrVQrpvcdRs
	95rwpY9N0HYJE4ZBwT9V3Zks8IDA+jwhhepldb948FBOdfhFUty1NQd3gvS1LanzkEcnhPIstgC
	BnMrQjLUvcRNVoQJTHeYv19JkAtJh7+kr7D720zlvuW+5KmKOoaq+eT918dw7QBVtn6KlTRm+uh
	QS5c0zVViu6VKP3Ecy4CcXnNAXC/zlakgtz8djTErPhmV3H7fIwhMA0fkmMCh5JAvRl00/Qx3E9
	IpPSZkNI2HFvYUxtCqoAhFX3MQrckXdrQ++dQrgXh4hS9KZSXwMR9QLTrxz8QZAhjG/gGzhNrO+
	eZxtg==
X-Received: by 2002:a17:90b:1641:b0:380:ce69:2669 with SMTP id 98e67ed59e1d1-3928467fbfemr7425362a91.9.1786336127203;
        Sun, 09 Aug 2026 21:28:47 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8d6074sm40890689eec.12.2026.08.09.21.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 21:28:46 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Vadim Pasternak <vadimp@mellanox.com>,
	linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Cong Nguyen <congnt264@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: (max6621) fix negative temperature offset and crit readings
Date: Mon, 10 Aug 2026 11:28:39 +0700
Message-Id: <ad0baddbd6163cf73545c8e9273258136718585c.1786334038.git.congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9d3a4f1895a47794bb359a2a32fb1ccd6a15812c.1786334038.git.congnt264@gmail.com>
References: <9d3a4f1895a47794bb359a2a32fb1ccd6a15812c.1786334038.git.congnt264@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

max6621_read() reads the CONFIG2 offset and the critical alert threshold
registers into a u32 and scales them without sign extension:

	/* offset */ *val = (regval >> MAX6621_REG_TEMP_SHIFT) * 1000L;
	/* crit   */ *val = regval * 1000L;

Both attributes are writable and their write paths clamp to a negative
minimum and encode negative values, so a value written as negative is read
back as a large positive number. For example, writing a -10 degrees C
offset stores max6621_temp_mc2reg(-10000) = (-10 << 6) = 0xfd80; the read
then computes 0xfd80 >> 6 = 1014 -> 1014000 instead of -10000.

Cast the register value to s16 before scaling so the read preserves the
sign the write path encodes. The temperature input path already uses an s8
intermediate and is left unchanged.

Fixes: 92b64580f14b ("hwmon: (max6621) Add support for Maxim MAX6621 temperature sensor")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/hwmon/max6621.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/max6621.c b/drivers/hwmon/max6621.c
index ee5898fbe110..3690f2ffe5fc 100644
--- a/drivers/hwmon/max6621.c
+++ b/drivers/hwmon/max6621.c
@@ -239,7 +239,7 @@ max6621_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 			if (ret)
 				return ret;
 
-			*val = (regval >> MAX6621_REG_TEMP_SHIFT) *
+			*val = ((s16)regval >> MAX6621_REG_TEMP_SHIFT) *
 			       1000L;
 
 			break;
@@ -254,7 +254,7 @@ max6621_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 			if (ret)
 				return ret;
 
-			*val = regval * 1000L;
+			*val = (s16)regval * 1000L;
 
 			break;
 		case hwmon_temp_crit_alarm:
-- 
2.25.1

