Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C5E32B107
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791391; cv=none; b=aCcFfo6stiIIjneOxc0Mc+9VUOMsoIowpDF9vzatFmiUpG2g3cyCXW6bIE6vw1ziJslenZY+XcDLFrXf1IPcBKQ+LjPH3Qy7t8CAlpw+M+3hU0AIggJwMfGiR1ZGrBojBnqChSqdqkzy6uo2UQu1LZWRUTxLM+k3lfxjSS+7L8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791391; c=relaxed/simple;
	bh=263UnQqT7FgRjQmrIuWnRIN9Xzmjzy5Zozx+IEZgAgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kYAzX3fSmEmzh7f3uT1a0mZxoY1avMhiO68/U3pXm/A2hXoLTfFHbPqh5cC3E+FiDVhKNi032bPlziZslYXbX0jAEvWwTsBj0AHb+0+TYVbxn6hi4Vcl2OEOLyypK+HrODec+punSgGKwSqtum6nscFad7RUee9EaogFve5Flr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pt1Lllqf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="pt1Lllqf"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-462ebd5d37dso1167595f8f.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781791387; x=1782396187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jos76VU9rUcfTgCENKyUN1lsrrQ63yv55cXHCv1GV14=;
        b=pt1Lllqfz1DR5lS4hxUiGsQrthAzYZWCVFMOsUeERbgGrWTzXfKYxy0AIkSQzkhFAo
         H3Np4gA1A6ZHufF1UoiqaNQcs4usnBEC6d0fdBteYemOLjunU7q+qH3lnLAcM0MnsMrM
         nxqYTs18z+EHLx2380LEFg3XbH4cCC6hq3tmtgQm46KEJv5hBrAKuKjfKMNmcUh/Lb4V
         zIgZmCggCD6xisEF59/evzGLbzTuifT1HG81MOVxGcoSNIMR7BBtimzwZ1wnsG3z3itN
         FcKNNRjTK9wYB1pV496DHEqZ7FexcOWOSyny5GYeUUlr8uGrz7IvvsP+AqT9xz7XRpLx
         OHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781791387; x=1782396187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jos76VU9rUcfTgCENKyUN1lsrrQ63yv55cXHCv1GV14=;
        b=qR6A4qlp+sF/jtJrMZc6kqOlKjAf8HbcIqgycz6pOodCiaugbQFoSKSQjBsxfhK2oA
         4aIGTdpCUjjhjQb/51sCin4mlo6aKiNcfvKso5z4bMqxXslOc83CsTdU7AKA1IuqX6sI
         u/qu9lJOtezoIhNRFvVO4ZJRirZsRq030j2a+8z9LvzIlcKNRo7AaKfJSJFsnGj3tCoY
         jYuHS4Eyfvjp5Em2qlQ8/QTyEgzJW4lbCdiMAA8yATErV0iUIb9I++ekLfUGAJ6Sgvh8
         wXw8DevytatGT89QBAm5QCffLjdlqnNUT1I+u989heT1AkvEs0ebt6W1BlYr/+tkdjAW
         3ivA==
X-Forwarded-Encrypted: i=1; AFNElJ/dncpPsE14TrZFu2c75VKtzGi/5YmY/9ED//IeESGqQnoERYCjKfI4GFg7hRtxG2u/9ep58GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgUyFYT3s8VRhb9zXH5vT/DmF11TIIKNJrpRedQquTtWKMZec
	KT3Af6x95thV//6+FQ20VejEusfTSdcz5Tg9v+DhcbEV6O1+EPVhT1Y0T+YdysVlRHM=
X-Gm-Gg: AfdE7clNmE4qnF0Qt0osN0iXJ9soediCbfq+BqjNk315cLICNr/dgpxY6FdpR05mfjl
	o0qTnQi5AhfwMgYQ+hKm7Ubu0Mvxn8nVvX8rCdntGwFGF7B2FxuNzo40XK2H1TNv0Z3VXva7f6g
	4dORhudngXe8sczFvCgCH/eurX2umPyaTB9jJGmDLtpRV7CKCxFkz09ZdI4K0HtVhHMs1IkZKJn
	zbTPrCsuUe5Kd9JJtgsblFKdLs8XWE+V//KFUjxsXMuGE98LDvOOsH0YAIvvw7kyUU+Z8ni4t1V
	+6ZSo8ByaUbFilxwJEZWyv6Qp3DqaSCWZuorvdwryDbQ3ITCBC/q4pAEiib9AMvbUtcpGUkAgyV
	QJAzcfM1yvXiycXv/7qBLtn2iOn8+o7SwHmJg/aZKfTKHc5IBYU0ZbMIPJTsLkYxYzSZDZiSPpk
	+dec1bJh4+NZYJ7yOlRccsuKimk2538x32rcKL7T61V6KUKhPWxjQSp0w2jaQ0TF58kBy21vmPM
	buV
X-Received: by 2002:a05:6000:4687:b0:464:6ee:4fe1 with SMTP id ffacd0b85a97d-46406ee51d8mr3568612f8f.33.1781791386660;
        Thu, 18 Jun 2026 07:03:06 -0700 (PDT)
Received: from localhost (p200300f65f47db04cea0a59ab11cac9f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:cea0:a59a:b11c:ac9f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46289c3b3a3sm15325402f8f.30.2026.06.18.07.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 07:03:05 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
Date: Thu, 18 Jun 2026 16:01:47 +0200
Message-ID: <20260618140147.142489-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2611; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=263UnQqT7FgRjQmrIuWnRIN9Xzmjzy5Zozx+IEZgAgM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqM/pML1hFap/UgihwRJNb3DQPM0zusq3sfUm27 yKUYXEx1neJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajP6TAAKCRCPgPtYfRL+ TqY2B/wPSLflQcf6bhsX8LkcflcqNm7174taCwQLa0R9I1TrLZQqw/AOowkuL/pwpTwGLrs84gR relE5J0uazE683Zv3i/JkOrMkiymyZUx5T5sOuunNvGrQhIRwJsk3fDxlfYrdQnPTf1O6wNk7TC Ev8kds36RmxGDCSzbhsYfvatVmoRtESYRP7bNPJ0j0xB9bmZpzM6Occ09QFN9eDgsYKsX2loH7d z30fZLMFcjkIVq2pglGw9xHrVAK695hDQ1TGxr1kbNzrgm6HVnxbgksjSI4m9H/hNSGOspTCKk/ IgD7zCruvvHll+ZJLNTAEsx2Xo+TASyfNvsOTuxJzxi0n0hl
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When determining the device details was reworked in commit 5e6c3454b405
("net: can: Use device_get_match_data()") there was no replacement for
the previous handling of non-of instantiated devices via the device's
id_entry which then results in a NULL pointer exception. The only
in-tree provider of such a device is arch/m68k/coldfire/device.c.

Given the id_table only contains a single entry just hardcode the result
of `platform_get_device_id(pdev)->driver_data` and drop the unused
assignment to .driver_data from the table.

While touching the id table, drop the unusual comma after the terminator
entry.

Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
Cc: stable@vger.kernel.org
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this is essentially v2 of
https://lore.kernel.org/all/20260528094540.1867783-2-u.kleine-koenig@baylibre.com/,
but that patch was intended to be a cleanup, while the discussion then
revealed that there is a crash to be fixed.

Jean-Michel Hautbois confirmed (off-list) that Marc's and my suspicion
is true and probing the flexcan device provided by
arch/m68k/coldfire/device.c indeed crashes.

Best regards
Uwe

 drivers/net/can/flexcan/flexcan-core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..05b8ca72ca2a 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2077,10 +2077,9 @@ MODULE_DEVICE_TABLE(of, flexcan_of_match);
 static const struct platform_device_id flexcan_id_table[] = {
 	{
 		.name = "flexcan-mcf5441x",
-		.driver_data = (kernel_ulong_t)&fsl_mcf5441x_devtype_data,
 	}, {
 		/* sentinel */
-	},
+	}
 };
 MODULE_DEVICE_TABLE(platform, flexcan_id_table);
 
@@ -2148,6 +2147,15 @@ static int flexcan_probe(struct platform_device *pdev)
 		return PTR_ERR(regs);
 
 	devtype_data = device_get_match_data(&pdev->dev);
+	if (!devtype_data)
+		/*
+		 * If the device was instantiated via the traditional platform
+		 * mechanisms (i.e. not by device tree), device_get_match_data()
+		 * returns NULL. The only remaining such device is mcf_flexcan0
+		 * (defined in arch/m68k/coldfire/device.c). Pick the right
+		 * device type for that.
+		 */
+		devtype_data = &fsl_mcf5441x_devtype_data;
 
 	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
 	    !((devtype_data->quirks &

base-commit: e2cae00c05d196491c318196792297f2dfbaa02c
-- 
2.47.3

