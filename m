Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD823D3338
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749873; cv=none; b=M28aA7Cg6XtKMsiCwuYFqHqYHfKBztuL1Yw5D2PaIQlkvREipw4o+co0OJ37ASKVpdE5ZXnggoBgjyOhhdIi5hfmvKfFNuOxrHgo74y7+GHw98B4LyUceMc1x6bPtXe0GrHjfOY1w/mGKt6OxrYvO6H3oQDRhXPkfElQVu2aT4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749873; c=relaxed/simple;
	bh=4jUCMdTQDiY8nnaNgKzeTR4BiuPclNDBdR4sa4EX4Vk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nstMYkWXPdDkWHfd67JaLa/cX72DC2oEQa5iZfsBicIM5faH8J7oxTMrLfMCj0kU79VMyIv4CK+L0+wfor5Hgrf4/8spK7Cml5eJ/zfA6x9X2z1Jaojq1dYS9l1dZq/tKK+mXg29V/uQO4JrsjaLlAzb6wQUF8w5g94teuQoh74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j1cMmoDk; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1cMmoDk"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb733fc5024so6150786a12.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 12:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784749868; x=1785354668; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X8TW7+1XOyC8evaweToXtmQSrjCuUbN9HYIt2ES0cRE=;
        b=j1cMmoDkp6soDlTDapRK5/184mRGyVOK9pAGnR3WTDl2CE5uwAQdBKW1IYfBf3J949
         E64rA4akFgYGAaN1G8rNZTHpfeq6zLrGBHlPDeg9hxFFZE+mBzDsgpsV3AQY4CV2q1r+
         BsBmeiI/bOAukqdeJRF8WTWx74MPCWlug4A/T6S11AD1MIt5+dkhs4nIzdw/YXrXtf/C
         ltyRTGhf6sOos/WMXg0YJTcTxakXUpcAT8vSUd64dABOd9FWogkd/9cmdPZL1iDY34lj
         0rodhG0SuoY8CFxk3K3SzCIYj+YnBFthI4PiEx5sWSHFJlggqGRn9CbCix7eC/em1rMC
         3UcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784749868; x=1785354668;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X8TW7+1XOyC8evaweToXtmQSrjCuUbN9HYIt2ES0cRE=;
        b=ouwHrTO3y07uO2oY5BvckQ3X99EmHK70dEZh7XVSbuua4gKgGFLFBlFXQOwO3TMKGz
         Kc7VD1WW/T+NZJJJm11FRuskUp0PY8zF58eVa7J32GhAdJMPnwZeVaFpWpgSKw4r5iKZ
         Sjw8xo0WblRpOC9VTSdI9Ixz4/qs6rH41D5OLU2L1YDmtsGy3jYsKs2t/9yfxB0G46cm
         sAQ2AMFBnkgz8cGbLknXVjJuDKO9vworG215b1SqRhWgiFfRP6KzfAt63CFmUaKOw7eu
         OawDH7JWI8CUi2BA2OrygIBzpd3uP8IcivMWIpoj95EJAkuz3FERKsHtbwuR8GgHrT00
         NUQA==
X-Forwarded-Encrypted: i=1; AHgh+RoNcPpJtRmzEtpp1Ub8tEb3HVqMuzHAzkycSTJwSr/cktZUBIa9ApYfYny27E2g9qGLPQ8EcE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYEks4Hjcpp1ECL2rqwe8AHhDVBP0lDTx8Uj0EVRhiYtxZq8uk
	Zc4eT1JtdjX4USRmGJv+5AywIS3jBzw/UznLujlwdFgcUbcxad4VBPBUtik/thMpMbTIWXFzYrx
	+VMtU+A==
X-Received: from dyng25.prod.google.com ([2002:a05:7300:7f19:b0:30c:2bdd:dcdf])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9206:b0:3c3:9993:d5c3
 with SMTP id adf61e73a8af0-3c3ad665cdcmr27250375637.9.1784749868246; Wed, 22
 Jul 2026 12:51:08 -0700 (PDT)
Date: Wed, 22 Jul 2026 19:50:59 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722195059.1420738-1-jthies@google.com>
Subject: [PATCH v1] power: supply: cros_usbpd: Limit port counts to EC_USB_PD_MAX_PORTS
From: Jameson Thies <jthies@google.com>
To: bleung@chromium.org, tzungbi@kernel.org
Cc: sre@kernel.org, fparent@baylibre.com, chrome-platform@lists.linux.dev, 
	linux-pm@vger.kernel.org, Jameson Thies <jthies@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently the cros_usbpd-charger driver probe iterates based on raw
charger port count returned by the embedded controller. The only check
is against the number of USB PD ports which the embedded controller
also defines. A malicious embedded controller could return an inaccurate
port count (up to 255) resulting in an out of bounds write and
subsequent memory corruption.

Update helper functions in cros_usbpd-charger to limit port counts to
EC_USB_PD_MAX_PORTS.

Fixes: 3af15cfacd1e ("power: supply: cros: add support for dedicated port")
Cc: stable@vger.kernel.org
Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/power/supply/cros_usbpd-charger.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 308e1d4e6dd8..82185ee33fd4 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -125,6 +125,11 @@ static int cros_usbpd_charger_get_num_ports(struct charger_data *charger)
 	if (ret < 0)
 		return ret;
 
+	if (resp.port_count > EC_USB_PD_MAX_PORTS) {
+		dev_warn(charger->dev, "Charge port count out of bounds\n");
+		return EC_USB_PD_MAX_PORTS;
+	}
+
 	return resp.port_count;
 }
 
@@ -138,6 +143,11 @@ static int cros_usbpd_charger_get_usbpd_num_ports(struct charger_data *charger)
 	if (ret < 0)
 		return ret;
 
+	if (resp.num_ports > EC_USB_PD_MAX_PORTS) {
+		dev_warn(charger->dev, "USB PD port count out of bounds\n");
+		return EC_USB_PD_MAX_PORTS;
+	}
+
 	return resp.num_ports;
 }
 

base-commit: 17376e7311cdec252b61cb1ecec43be61907781b
-- 
2.55.0.229.g6434b31f56-goog

