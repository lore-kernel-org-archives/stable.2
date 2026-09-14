Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3E3EFFCC
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789371412; cv=none; b=LYnaLLJgGOPv9zhwpFGudHtjZSJAxBoUMKgNmoHtkhZZRTDI346g0T6D//TYRfmcdKJ/FQXxzzsWjQZLX2unDLdEr/2Rs3gIgDx+SJX2U+TtNRiy1IcU3u5qSP10NHvYmmdxCNaC4RuRNrp2jrbM7OpZP5pfF18one61NqbZFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789371412; c=relaxed/simple;
	bh=43eSICE1JFCHbUysIojzxY8vifR5XctKj84YnjLrDo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZpcE08/mfeA1DtjwkUV8UXmWcc2i2ZDKo8uCamuv+4MlGmjh01PGmACwxx2oX/HKgfJO8kmO8jKxN4kqMw9SJ0CB7uJXUAaLlOti7zXzHxsP/hlX9MtXu2nPsRnh+7Fnem4+oAyQX7k/cMUUqMumNFbtty3/ncTxdA00IZA7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlUc9Cay; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlUc9Cay"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccc02279so1563461a91.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 00:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789371409; x=1789976209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zs5RXec5ahUX7Llb9LiQLgtyAF4x1ZaNDold6Hb9HRg=;
        b=DlUc9CayapBhnz0xNIZhbbaeGZX+YLmkBUwihPws8llhzf6+vYqjMXR6T9dZ4702AZ
         o5egEuu3JjZbcTPCqS80ly+Vwwh1brO+iohquJd46hWPKC9LJhNaFE1/GD0ErRh2aBY4
         4fkr2gJr4FG0NtBdGnLouoWtYrEFRT32iJanUkNFitPZSEZR2dhX+q1KqJHW1iUAMzsr
         ibecJ7LmjIDYjFokSSH9CWB1WG2y93GZPHgqFdg5Yj2hzLIf1MHRZYJ5br8ma6D+X0bS
         xnkGz+YnsdL/L5/c9mkRqhy7ymCBmt5br6MUVovOvAXJIhDeKsxWOgtUlwLsDn50itWK
         ebSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789371409; x=1789976209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zs5RXec5ahUX7Llb9LiQLgtyAF4x1ZaNDold6Hb9HRg=;
        b=ejL1hQKJwYDVl36+SDt9RAKVcP/GN5y8tVdpXqhjCDstPj5Cfd6sESc1x9IuDAzOPv
         991OkMYrjjq5o7r5adtKcs4GjMG1vWA0nbwsQDVbLYTcy2FgpoGCVjJWtMkKFn1hH/uK
         tfP4h+AqmfJvkD/Qj8SFB4h4qgKVepLQTRyLgTRm+2gf1Up/1IYa+8cj6ZJFoEkb13eM
         I/No3eoAqpAFoU4XR4feWHtINT5npn76F5O4xJjqqBC5a1IU07jGUb2KznCw12R+zQUv
         J2whUoHrRPMcBMeB9CxvTAL4ezf7xvHzwUKn5lT8ssek65+ugH0RODN3xrVlQQOk7JOA
         90fg==
X-Forwarded-Encrypted: i=1; AKwUvBzrdTzrHPrCi7HICJQUk+DvT8y4kb3IVZ/WliJcsHaZWW/zula4ploo8NOlVwU2ljRv8Qjh0wM=@vger.kernel.org
X-Gm-Message-State: AFuF++k5C9ePbX3dOkAD2guO9cFPP5aXSgtyBwegzkNPRpuZgULIzNHS
	nM7nNKLQNuILdJ35TnK1jX+ewQH4w4j8jghtIJKuCggZhvVAXjLyCg/d
X-Gm-Gg: AYBFou3Z/e3EVz51Gcj8ZHshhv9cy9gCrG6qYUqNFUEAdlfRoBxFwr4J/lRWrEBBPT2
	GLxVEzm4RIs4GrjSAQuZRkRaRTQ4CY1FbTFznRBxWwSMR0qkt3vqWTIEAegFzNG2Z61h040SoCr
	CeUOmramHunxwNwzCmDui9xC/r55gtzHKPLnmizANSMzRaXw4e9G+sk8iV0EGNgQ8z2OF+reTZL
	OB/CvP/CBKJ4HeyW2HqFnOBlMLDirHI7g+EmrEH7k8OEir47vl7aFVcBHiKXo/rBV8TU4DroIeV
	SRdvR77IHNNAgAs/s1eejVoO7NVceQWkVeG9J43k4wc09YueAqMLJceP+Zmioptg2WAgq1eeXhg
	h/iqytE+BrN2n5iuG6SHGMGWbtdqU2r+e7eFjt4iDzNpnwaXKQ17AkaeDMZdbKVBF/18XrpDZk7
	b6BrBj6JWRgKTsM8d2bniLe3v+r90bLg6M+RHBKHKKCa8yb3VHK8mxnA==
X-Received: by 2002:a17:90b:2c88:b0:398:e969:87ef with SMTP id 98e67ed59e1d1-39dec0f773fmr3230664a91.24.1789371408788;
        Mon, 14 Sep 2026 00:36:48 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dada5c76asm17870870a91.12.2026.09.14.00.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:36:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Rudolf Marek <r.marek@assembler.cz>,
	Guenter Roeck <linux@roeck-us.net>,
	Sven Anders <anders@anduras.de>,
	Jean Delvare <khali@linux-fr.org>,
	Hans de Goede <hansg@kernel.org>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (w83793) release probe data through kref
Date: Mon, 14 Sep 2026 15:36:38 +0800
Message-ID: <20260914073638.1662500-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

w83793_probe() initializes data->kref to manage the lifetime of the
driver data. The normal remove path drops the driver-owned reference
with kref_put(), while watchdog users take and release additional
references through the same kref.

However, the probe error path still frees data directly with kfree().
This bypasses the kref-managed lifetime and discards the initial
reference without a matching kref_put(), leaving the reference
accounting unbalanced.

Drop the probe-owned reference with kref_put() instead and let
w83793_release_resources() perform the final free, matching the normal
remove path.

This issue was found by manual code inspection.

Fixes: 5852f9609d21 ("hwmon: (w83793) Add watchdog functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/hwmon/w83793.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index a548586369e1..c6ef04c69856 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -1928,7 +1928,9 @@ static int w83793_probe(struct i2c_client *client)
 	for (i = 0; i < ARRAY_SIZE(w83793_temp); i++)
 		device_remove_file(dev, &w83793_temp[i].dev_attr);
 free_mem:
-	kfree(data);
+	mutex_lock(&watchdog_data_mutex);
+	kref_put(&data->kref, w83793_release_resources);
+	mutex_unlock(&watchdog_data_mutex);
 exit:
 	return err;
 }
-- 
2.43.0

