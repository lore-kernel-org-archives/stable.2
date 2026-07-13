Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B8A2FF144
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911665; cv=none; b=tc/PFykxr75EpESpkn+ANuqrHfWq5ImyxcKw00INrC1W9/7XXrqkscalIXrB48lX7KOx1Q31/s1rdTB39jOeDmaHfjfm+eCK6SZXoDRjpLRyxs7MhTROZBXhLuN4FZAxJyspBmZ5eHihNaCyDYwjODFbtAmi2sWSMcgYV44ZvcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911665; c=relaxed/simple;
	bh=Gtks24nGS2PEXvE4OeZrCnqjewElZhLxVQVatXzmG30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hn6qiJB61OiJ7xXPxVO+tP+6miE0YW0U5iqW+wlwcxCO/6xVA2eWdW0jjeLQhsc85FIHSZklvre6mJHMe/edLjZuDW4m+vz0qc0MRaxdsOY8PtYJ95hhrb7Q3d7AhYVq/mYMWE4HV7SH5FYVAyek+GnXCpg+AbqFYckod+lRPoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFkvepFr; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFkvepFr"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so534818a91.0
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 20:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783911663; x=1784516463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fy4EZP2uQweLrKR+q7jpU3GAZlA4iI/CrpNIH98Z8vY=;
        b=IFkvepFrZwozQIGJa2Zt4gCjAIaxeFVDOFGm1Z/ssewZ5cXlBgNG9RdhOGY7BTs1Oo
         SLh429lUydwYyi13hAPMq2W3iae9V1TNocTby1rCJ0VN1UwtKfqdUhhA8CRchQy7uuwh
         vTugpIsEhjac/i7H7jWe87Rw0BeRJz9DVpATSBAy+glHaoVKYDU/Wb9diqNM0N3dvj0z
         bgZ1QiCUTcyHKr7v1c/dUjjdn30upp+zC/KvyrZbAnqbdJY5J3eLGTqUTe5a9rjK+K4P
         UlR8BatuNMobz5V9pLo8PQniB5OGOKcPmsVxBorHCHcRew3PEzPk6BRSpgL7Iqy1CaKY
         xMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783911663; x=1784516463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fy4EZP2uQweLrKR+q7jpU3GAZlA4iI/CrpNIH98Z8vY=;
        b=TpOfssDelkf6Jdk2UY6joAGrgxtQesIdZHG97HfZz2BV73nRzIjFqb5Fh8n6s7LFL0
         KOHWGCyest4nK2rbDjhKhDiFD8w74KLvi2xtnf8xZVOIQRp/KOiGzDqPzPKxw+NaKSWb
         tornRQsMcONQcHsJ0mblhTye/aaHWjJDXW0zARS3J0DlBlTfZSZuGzIhld04MtEgK/Ks
         4/IDAbpviZ2R/QXDjapxFp2FJhcZNzjiDn8khWuNZuAjIBRYLc9PKz69y10Ns8QB6wxv
         ReB3oMMzJY3f/OJSnifAlAKkAuMLg/4uF5JzHeu0SdibmcGog4uGM5T3XjFwXoagJDCh
         PNbg==
X-Forwarded-Encrypted: i=1; AHgh+Rq4S/CSgqHM2CpP7XDsfmDjKTECooX15XhzNzKwdn7JKEM0hdoJOqHaRhsDzdqJnMJfyE8HPio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2X9c5lX0XOGc4aYXPKLJMLu0fqE13Zwq+Gl3+nrXKDWUYfWvg
	YEx4Q4MCsclNGpZ4A2VirFwrU1w7UxZ+J5gJmEMvdme2S+x9BS0Vol4P
X-Gm-Gg: AfdE7cl3JLju6Qpw+2CJrnnXs5VcTT4KUShqa/KpqWGmO45BUtgC8tA5J10isQsrD7Z
	WF9f3Fgr5gUYEnqVhIW1/P0aE6E6slrKql0Q1rUC4jX+7xcDULbD5KIVfRaMcY+aiW62AzA3kOm
	r8mA8kASnBYJR1Qk5lpzlHBNwxXTdvdeGfJNqeNKjMrf31NagwyoZUOxCOWR9kWAXEQNjRFvc4U
	wrdccHjXEnmpSOiKv4k8hhEzNaxgJRahOu39ChIcNNmWG3HO0VcTjdjC0apfLyfJ1ZrnX83vBFm
	AmLQhqZR3Uu8F2zVV1OotcEe6+pSxQEnx13qg1b8k68+fwLOsif0ZsFkazzN8WKpUJXGXgobF7T
	n6JgY029hXJ9aaeGkUZmVMO/x0ieVQ4Nsu0NDqGh+3LkWps2vOW76g9jmMcvZi9iBHAfoUsrgyG
	WJgO+b9GFObpyl90Ud9QwGJkvnqabz4EXotimg/c9yQODgxRzHoDxl7g8dvWHcv37QpMEN
X-Received: by 2002:a05:6a21:d83:b0:3bf:9a30:3a12 with SMTP id adf61e73a8af0-3c110ad2b13mr6859782637.50.1783911663534;
        Sun, 12 Jul 2026 20:01:03 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([2401:4900:ab82:b7db:dc18:7983:dbbe:39aa])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accb0esm67242637eec.30.2026.07.12.20.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 20:01:02 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH] iio: chemical: atlas-sensor: fix PM reference leak in buffer postenable
Date: Mon, 13 Jul 2026 03:00:46 +0000
Message-Id: <20260713030046.21143-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atlas_buffer_postenable() acquires a runtime PM reference with
pm_runtime_resume_and_get() but returns the result of
atlas_set_interrupt() directly. If atlas_set_interrupt() fails,
the runtime PM reference is leaked and the device can never
autosuspend.

Add pm_runtime_put_autosuspend() on the error path to balance
the reference.

Fixes: 0e4f336f50de ("iio: chemical: atlas-sensor: Balance runtime pm + pm_runtime_resume_and_get()")
Cc: stable@vger.kernel.org
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/iio/chemical/atlas-sensor.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 0e2edcff63f9..b2c1a598b3a5 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -413,7 +413,11 @@ static int atlas_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	return atlas_set_interrupt(data, true);
+	ret = atlas_set_interrupt(data, true);
+	if (ret)
+		pm_runtime_put_autosuspend(&data->client->dev);
+
+	return ret;
 }
 
 static int atlas_buffer_predisable(struct iio_dev *indio_dev)
-- 
2.34.1

