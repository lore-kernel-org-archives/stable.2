Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380198;
	b=t9C/gN504ukuVYweXmalbV8qoNCxabg9NjUrkxe2ZaPMX9dlC2youa+p0WsYZjuxiowp
	 Eusb/2QRSGLx9uxPO/X2MeL8ZRgq8FhyuuHiBcAqIDKNYzCl5A8gNDxVh+hbQbaVBd2Xg
	 WpKSGUV9RrTEboaovdXFbZ8OxxDtpx3MZrS6qA9xGKaEinDcUHFSsVXT+KGf9BIZdbfFz
	 LzXESGqfyF1rB6u+LMv6oS4n1ztmbrpManMc7HQRZJKs1i1Z+6sBBhcnskBLIFjBDvTfu
	 4wsXqSL9bGizP44Ugyp73MxCg2/3YFN3o2M0ZUExKv6OO/Y7oVrxzpO8+o1j+jQXxFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=4PtICXQgYMF5gi3lR+RueE2sIoPdSSjd+glcQFFLPog=;
	b=ikLO+2S29DBmZM5FjrF/1YiEj+4NzP+UQQiNQ38oFZsvFClVJaYHignGmxeUnqu4ngSB
	 hBhO539UlYmOiZIcL/bdOaLK8vDdo6MMFJsOtqhOIy813SHw3FEwLi3qLhwj/R2XB79Nz
	 5kLHIh8RfYzKqjPsJZROtPDob+QFjtOz1t9XW+U89bkW54RBZbZ9TczCNo2t4ZlJeeeSo
	 4fx2viPjyDUVQzWBUgv7GpwA5kcaUUj6nwWVQSFsuEPuXD26SXpn+EG8XxeEOjjt3NLbf
	 8YLQXC+swcb7B/FhSkpC+KCilD0WQKbl8y+bz8PmOLBLQCeyPV3bCynHdQ3hJkpNciA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQA9R7gP;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE3260A5BCD
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AE3260A5BCD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQA9R7gP
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a2af4c8d00so2219033c88.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380197; x=1794984997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4PtICXQgYMF5gi3lR+RueE2sIoPdSSjd+glcQFFLPog=;
        b=KQA9R7gPgWoq5fnFAXy74KLk14GsFWmhDVpN4+RCIoo6MItoK+p9j7PCe7iJ+pBFwl
         WzvErcP3LauXWLrFZJ5g/VE8O6cMvPEpiJ86rjL4zC+3lKybDwvGA35mJZeoU20Kt1vE
         qoQ1s8Wxlbdl8eYhrkz4gcmNsFD2lTS7eU7P75tVaK6DdDIwdWG3tXF5lu8F2iWC5o6T
         ikhlrbsLvqSD0R4J9HWOoY+kxpZRQxi/wHozKMN7zwAjxYzEW5bvslhtU53sn8/HlPEb
         ieyWfkFjaBbFcA0eM/ZbZ9cHJde2X7yoY3vySesKMe+nfhKt7uEquVCNvO0B3MFmrWsk
         hmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380197; x=1794984997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4PtICXQgYMF5gi3lR+RueE2sIoPdSSjd+glcQFFLPog=;
        b=vkbLbU4OiIvWcjRBMQbt5ejXiaoaCAyDvykejhiWsKXMPmda13XPE8re+Osx+/4dh0
         b5DWuduMT99xflWxLrjsn2Epmrdo7vNUGud5NCsh/XPw8Symu431MODY6opo83s/5aAv
         tFfK4eSOcbQgSEOM6rpE39cpv5SETqdGELWY0CveFdKRkSztYbT8LAstua7JU5yFTrQ/
         o8q+LcWqLkqpRix+L1XIdnpTEq+i0uutWk8vwYoxHS7g6Jm9xVTRNUuUU0Q/GlKRFZfm
         ufyBP5w4drptke8VEO8TKaV9veujMfFqigepV9Vo8k5ExoMb+at0/Xtd0T4CrB+YeGAV
         HRwQ==
X-Forwarded-Encrypted: i=1; AL+hErGM+yziyasg0/mX6fY3dorT7fAgNnFd8XMxrhOcTDYoXVQQHgrJxBqK0liXfsPR1qoPsVCSSVc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WYPfRYFIWftYxzGgzlFdWJrsdg9ZD7cwHjnOf6HHgF/SvIE8n
	HEq7G8+FU98yRPzTB/rjRAeyPg0k0Je7ijKvO0B3WMZhFy7cvcET8dVz
X-Gm-Gg: AYBFou2DjwgrCYvkIDwXyBTLWgsE1AOP14432EPt6QtJyGiiabEcg2o2BGZh+Y9s6DA
	M7gtt6rp6g0RHq1HeFxBf0XgNDy672bP2/THh7Z68dudqkjgpwq3ZEOk9IKgo3x3wPGh/LI5ufH
	m6nogTUxuDO+43Yc+XmauWQcTzcRxWrGldr8LEuM8IRP2zwG0PMltaY1yzgJRNWcz3wYo5+egkm
	aoNCT8k8GkX0ZCp+vWe4T3jzuvs340civ49I1ZgD+0lbDdDewH/plbQ9IXpP3Vl0l7QHgZ9Tgxs
	fvmpByl2/pj3U16f/GI+JHdL5LoBGbNPoCutuBiSUzmmnFwzndtBpQUK/oEF9WodjA9Cf23JwHU
	1ehTug9NnnVUWsGA3R6lqGsHw3tQhcZxf4DLvkexVglqohr8WD2uAZn9XfyBUhhdg84jxfwCFJ0
	OjPNS4oXprotxDdBywdp97Fo/RaVCY/T6/ryf0wfosEJbXFU6XqVg3dwwPBN71dLIxQyNBgycm3
	NKDgtHRRLCs7zxxL+fkIZeS9IGAFsyRH/r3zVTfZBHR2kWDM8eMDyltevRN3ybbtA997tfuAGmR
	znmFwnDQbhmvpWkZQelhbdao0yYML4kA6DVL69lDz7PZ4tQXNxur2LybtQX0z57RujchHO6Kr9Z
	A2ADXR2Tq28PoLgT53g==
X-Received: by 2002:a05:7022:5f05:b0:1b3:aee5:20c5 with SMTP id a92af1059eb24-1b3c0318483mr1532305c88.22.1794380197358;
        Tue, 10 Nov 2026 22:56:37 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:36 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:08 -0800
Subject: [PATCH v2 10/33] HID: logitech-hidpp: fix HID++ 1.0 battery
 mileage event parsing
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-logitech-hidpp-v2-10-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

In HID++ 1.0 battery mileage event notifications (register 0x0d), the
register address occupies the sub_id field rather than reg_address, so
the payload bytes start at rawbytes[1] (parameter p0). The driver
previously read capacity from report->rap.params[0] (rawbytes[2]),
extracting parameter p1 instead of the battery mileage percentage.
Additionally, when a change was detected, hidpp10_battery_event()
updated level and status but neglected to update battery.capacity,
leaving capacity frozen and triggering spurious power supply updates on
every subsequent event.

Read capacity from report->rawbytes[1] and store the updated capacity in
hidpp->battery.capacity when changed.

Fixes: 7f7ce2a258b4 ("HID: logitech-hidpp: enable HID++ 1.0 battery reporting")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 16dcd79059d5..0ec2f2fd6dec 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -829,7 +829,7 @@ static int hidpp10_battery_event(struct hidpp_device *hidpp, u8 *data, int size)
 		status = hidpp10_battery_status_map_status(report->rawbytes[2]);
 		break;
 	case HIDPP_REG_BATTERY_MILEAGE:
-		capacity = report->rap.params[0];
+		capacity = report->rawbytes[1];
 		level = hidpp->battery.level;
 		status = hidpp10_battery_mileage_map_status(report->rawbytes[3]);
 		break;
@@ -846,6 +846,7 @@ static int hidpp10_battery_event(struct hidpp_device *hidpp, u8 *data, int size)
 				status == POWER_SUPPLY_STATUS_FULL;
 
 	if (changed) {
+		hidpp->battery.capacity = capacity;
 		hidpp->battery.level = level;
 		hidpp->battery.status = status;
 		if (hidpp->battery.ps)

-- 
2.56.0.542.g3ef89b7020-goog

