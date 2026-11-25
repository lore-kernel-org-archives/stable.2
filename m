Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608806;
	b=NbFG4drn9IIyhbDTacP/8yONbPJqPvcYAOjAytFpFxm3y8S4iLkbwHzOVsH4ZhcCl9cC
	 0meJEFRN0lkn/dWwEWJCSMMhRKGBa/bWTUlQooCo4UzLSHguAA5ioZvfIKTisVDnpAi52
	 xIFAUuNY5IeB08uetWX/ZhhjDXYovPKkWcK2ChtreKIHqyr/f6DdPuooNtOIBvNpCu5Oa
	 soXkGVCgXJyE1n/Jl9gyt4X38qt8SRzI/f/Hxf9M/gag3tXaELsr+2BwRowjdBZxRTFl8
	 gq4wZKydmNM+8m3VZHSte09F5LKz5FKj/Gb3h2Eflfs73sUGF1YMk+Z/kde3TySPiTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S2gVdkGXp1tM23PpEzAGgdN0iticgUtXoYN49XssFWk=;
	b=n+ZXkMC6AfADkZerfoH77S0/nRJLH7ZrIXliD+TKuaTSr/d5iD73c9xri3slkX2QZp7J
	 1dSvq/91dJJbHlafJEOq5Xue1PyObiNPcJrmfjb5rGZvFBmuS2w9qWdohkC9YT/apB9+R
	 IP1aUZstSq4aQxzwfttUYk4XEzyxzAH1qc4ougGG3FwDruujnL8xQZaHq6duXPzzCvf/+
	 mqESVHuLkmmm5W9mqxruCdvDEqww/L0M0qg3GmUgdAs6h2C0Yxq5cydUIVlOT7q36vEiJ
	 842aHFhYNwarJCKqAR+bussvfaRQF4xEnAH97OUNSYbGpj9x3kqb1xuhahAXNycC1UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kHnSlVXT;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B01606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46B01606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kHnSlVXT
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b589050416so346888c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795608805; x=1796213605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S2gVdkGXp1tM23PpEzAGgdN0iticgUtXoYN49XssFWk=;
        b=kHnSlVXTCWz9psMZvePiWU25vTaIq70sYzkvKfcVGGd6/rStwSKxIbm3ydX9XQ7lEr
         3799NNqr/xEJUJeO3Lmk4vcnQc8BJsXYwN8DgbHo4INUTQoV/dKauoM9TTPUbcW5IpEW
         icwQqelKi99YPTPaXDdI7VlRpwgkRZvPUxlLSymdXWyp6lMiI4l0K+r+MEEWlyfPyT1P
         pcpvZW/qA6O+5uX61XCB8AoShmvZP03aXSJ8Bx+InEwIyjOALIENAj/aMKeT0eNPMo4l
         ImRXo7G4ligMfZ1JPxiz1uR0othJSk+ssXj+f1ocbs/Et6AZQaGG+1jQVx7NU9kt5U17
         ZUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608805; x=1796213605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2gVdkGXp1tM23PpEzAGgdN0iticgUtXoYN49XssFWk=;
        b=t4IOHtyDJhG0u6O/gAduzyHjQs0FY3R4RcyKr/YsYmHKAdzxfNCUexozLWGKtgfXjv
         nQvy3FAxVoTNVp+zbuaShrI0LMvZM7OEgJPa18BUngdwAmA4wcZwL0qjTSBEoL4EJZFA
         VD6YdSg1CyKe9qWxo+MMTdLPwPA5x5jadzTKWy3vWi9JDSb8f+vEb4P1CCm3x4VDn5vu
         ilI4PsirYujEYETAXlFAgXewoltrg45jpAE/yJ/qKSn+0/5TSbzsJa5JnN2UbpRM/Zz5
         3L5fnYDccdXJylzK57ybRRaDOi8hcOv3KxEr5zjnPshHuOaG1+Z+7n66preUyslwIhPH
         +clQ==
X-Forwarded-Encrypted: i=1; AL+hErHNvlRj04lrlMOTyt0NMrb4FKFVEt0vmVLRJxwPiTDQ8oN2tFGsUqQ9RNfVXPWpld1C3T9HPc8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TS/qhC8Xnb1XM13PRnKytJ0igGcxkB73Q0IqGp5XFlB2ltSoo
	IVx8XrKPDm1y9YYBHKzQtytE2BU+1SSoh9/Np7YogHh3UIK7O7454WRZ
X-Gm-Gg: AZFdTZfgTtAzGGsUOGAsjeORGL9bx4o3ZOJs8KOAiJl/Ak9QuTD0Phxzyi/R3BM02rd
	fszAocr9WvMQ/0ciJvV06MUEFJUmqG1eCzdDuaLcfs/KVaNVdhkyF7m6SX78kDqXLNrLqbeFnMd
	4uKcIPpq73Z575zZXaUx9M0GgJvQOOaM7xw2Q3+WJGIzYOUQTIPwZtnRN8Id/t7VXR3fBglfN8d
	04koHeaUmDhv6kbmjkUZtf+iAc0aZmhZeJcG6PzKzzRaz4qnzmYGHPn8vPGAShH3ptuj+QTEVVo
	dTMcgEy17larnjYAE6SJOSnEN7nbYerlXyrUxmZHEi5ms8XIMZPtcNZnYlAM6QoV/5sumayiH7P
	u4tBisMLYRfMloj65dIszg7XSRHkPlbOSPcTDu7eA0nFjtPunYFcYRDAVTCrFqO2buioM4yj7MI
	u4G1gfE2iAUMV6ZscWs0RbLbBCnFrJp4GST1ij5/APrYOE2ENLFAbxCejKRP4hjuEW7gpLL8ttR
	RsPEFB+kiVDkMVLv4vDcH45Rf4mcTd2P/VjbJ/eEkEpo/JqmxiJysqJLj2hm/2IK1CiJbni08Qw
	LPryV4cu9viUsOQPBfrzCojAOkaDggRaGQ7zIRloYH40m5X/5PwPgCQ/PH7YyiFK9rogVewivSI
	=
X-Received: by 2002:a05:7022:130d:b0:136:c443:80e5 with SMTP id a92af1059eb24-1b5568a15b7mr15255653c88.6.1795608805245;
        Wed, 25 Nov 2026 04:13:25 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm39319393c88.0.2026.11.25.04.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:13:24 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	Tomasz Figa <tfiga@chromium.org>,
	chrome-platform@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] platform/chrome: sensorhub: Check FIFO read reply length
Date: Wed, 25 Nov 2026 20:13:21 +0800
Message-Id: <20261125121321.1603687-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cros_ec_sensorhub_ring_handler() processes number_data entries of the
EC reply to MOTIONSENSE_CMD_FIFO_READ. It checks number_data against the
FIFO count and the ring space, but not against the reply length.

A malfunctioning EC can send fewer entries than number_data. The loop
then uses stale bytes as samples. Past max_response bytes, it reads
beyond the message buffer.

Stop reading when the reply does not hold all number_data entries.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer. Not tested on
hardware.

Fixes: 145d59baff59 ("platform/chrome: cros_ec_sensorhub: Add FIFO support")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index cbaec9ff8fbd..1a4ad45ad804 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -969,6 +969,13 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
 				 number_data, fifo_info->count - i);
 			break;
 		}
+		if (ret < struct_size(&sensorhub->resp->fifo_read, data,
+				      number_data)) {
+			dev_warn_ratelimited(sensorhub->dev,
+					     "Invalid EC data: %d entries in %d bytes\n",
+					     number_data, ret);
+			break;
+		}
 		if (out + number_data >
 		    sensorhub->ring + fifo_info->count) {
 			dev_warn(sensorhub->dev,
-- 
2.34.1

