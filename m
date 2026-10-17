Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72777386C17
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201222; cv=none; b=F+zgN0yzwbHPaOhyjcPjvyO6K0E17U1M4kfwGLJTVGdQEDraCMn6BScStBSPN721YthDClrnghdDM/MpzVqtr6aSYzEvaMfJI2Lt0SyYT8wMoWOzvPwDZvCvU2zQC0/rid3h67NpCP+Vk17YiXXXRoyRuHjyDx0OkF4Yhj8ecnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201222; c=relaxed/simple;
	bh=lYF78SligfbmmMBdJeZB+swrIY4S2bg5f6e58TpVnhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6IRO8zuw5aKy/XOIgUbKNz1lf2PV+0NFchzHy+zuH6cucckCJCJxhdSNTymjCH3Q7GFDYQob0V0xpUnMQty0gMk8DDXCr3bGhb3ILgORxXPZuSKZzNVJrVFxRs/Dd5nyRoonz3iYBES8C+hH9dfKOEee3EQkupIYEnHdbXwkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENOcMR9w; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENOcMR9w"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30b6dad2382so1346034eec.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 18:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201218; x=1792806018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MprfhLJ+GeuB+aE+V/cNLxEtbCzCGvTLbPrUm1c9D0s=;
        b=ENOcMR9wCdsqwBHJQ0HhhlXCelZsiPI0JfK/1KgkGHtoSIFm32fbiJa/47wbng2RBB
         tpRGThKkIhiVj5s2dx+GujBd5NdAO7nuscTapMrPNCpgoqO4wGBRsIGPTBrfW5pI/aTV
         vTu9c5ZiyWU+mbeUwcQKfOcDD95dzoCnn6yIC76YfzH5UgtvC5TNYs9uw1Q+2Zf+hBbc
         61aucwOAhdLL5bYSPWcb0f9IqFYA1IE4f88wXfbGoKmQ8nNuXgGDlbqsYogH4+HQX9wl
         ljXjGLWOGFaX4ozVWL6/DdYhquBF1l/vBWhJh/T3TfItJhLYyhuOl5ZcAzDy5rWWkAEj
         2CVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201218; x=1792806018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MprfhLJ+GeuB+aE+V/cNLxEtbCzCGvTLbPrUm1c9D0s=;
        b=ESW9BkQPVGeHxyaWyqtJKwffSI4U9H6PqYvquK424684Rt3BL3cLSI9Wn+9qgpO9Rx
         9DO+5iOFGHQAF5d06eZ+ApFH+2S4XxZWiYQnqZzQ+c1Y/hGi6AK/u0Fa6jJGtn3QEQdq
         9+1jvuhXJIroEddcZOkKYhbYcm40EmlTYxelAdoEIFUgH3EspObmakCa5H0OhwS6eT+j
         xmg61TKtP9p/1RnswjxWPto/AJY6NZH8KztNSoXNJTk6J3OG8bQc2h21vgoWhGVyShgo
         sBEqIuRYvzreOnXhGHuqwWhCz2Hd83Ti3c6wJf22uqJ8lwOENt300djIrA9VLVc8RRto
         IYtA==
X-Forwarded-Encrypted: i=1; AKwUvBxe5E904L9TrKoGAp/dwAcgLuncmfNtxxZfzrPYoV2CWWtLh3bz4xK2PboU/Gl07r3EAnzUq8Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYInaX1ELbfiMjDwhrrHeQZ+c5WcB6NwuBkRrwBfcg2yRllluuPM
	u/vplXd22CW5eAbjeZUCS/DXUo5bDHJkhtus4ApWQsTTGFy+bN/Ta7D3
X-Gm-Gg: AYBFou3CC6jiXEjz7Vde39pwzNJWPf9iK0jVQXkoUxHOWEAVif0pa1JwRR6GQDsNL18
	5d5aDxunhAywqRJ7qsyqaWYfDk/ocWKZDlxJ8+MJHXW6/DRKIO7/nc3ysy7uk5ntssp5JF3I6pp
	ioEBQWex4DRo1lcch2O7vP2m/OHHic2qpGH3RbXV/89uh9p5M5o0EyveCZo5pnILD/YD/0olUTE
	DDK/p11w3T9dBd5zAq9HqD7sIpXl37eWQnoMEw9sz+KHhJslNIOOImgTEkIJcVmzvug9/R4kBA0
	F1obSdgAZEtR710szLmpbUaZZsyn7GDgmW37qMpQ+Q7WzOdThyTtC3LqzBwrRNVgSRPuNqeTIAP
	P9QMwkkj8EgC8phKfKurImlVJJtbMrRum4r1HSm8xlE3UgQife81HMSe19D8czZUOwSFNXSpzxi
	wtFdV8bUql88E9OR6CdkSgYVSIheZupVZA1SAEnTZT2QVpJvpxJ+0xdOCqmkiy8gnnfHeWKbNh6
	V37xGtpzKMrR6ACe6C6PsJg2/evdqMEc1kRazaIovN44sfWUC9E+lJURJhaXMtCP6DtFFgEyFc=
X-Received: by 2002:a05:701b:454c:20b0:168:e942:4e62 with SMTP id a92af1059eb24-18515691e7amr1818692c88.40.1792201217543;
        Fri, 16 Oct 2026 18:40:17 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:17 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 11/11] HID: hid-lenovo-go-s: Stop and close device on probe failure
Date: Fri, 16 Oct 2026 18:39:56 -0700
Message-ID: <20261017013956.2440130-12-derekjohn.clark@gmail.com>
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

If hid_gos_cfg_probe() fails, the HID device has already been started
and opened. Probe failure does not trigger the driver's remove
function, so the device is left open and running.

Close and stop the device on this error path.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 1a2b28e1bed1..694b329f30db 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1786,8 +1786,11 @@ static int hid_gos_probe(struct hid_device *hdev,
 	}
 
 	ret = hid_gos_cfg_probe(hdev, id);
-	if (ret)
+	if (ret) {
 		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interface");
+		hid_hw_close(hdev);
+		hid_hw_stop(hdev);
+	}
 
 	dev_dbg(&hdev->dev, "Started interface %x as Go S configuration interface\n", ep);
 	return ret;
-- 
2.55.0

