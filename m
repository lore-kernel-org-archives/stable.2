Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164074;
	b=5GmZq57SjBI+O/xClvVuN6BHeS87nLyxkL5JIqYxxgnQnmTTRfOB45sbmYmkiXGy+irz
	 Ty1UjzdaaSqPBE06DCdb3/LfQ5GvVeNt4aOHIT+wiU+NPEEnL8/D27DUYGAW+aeIUKRLN
	 K8mup0hEpE+tykbLycfHQLntn3SY4dwP4XatdD3jUDBHrT8FnKGak0m77u2kTAMVIdcJE
	 RFwXweva37QMo9cVyRS/66+k0rsgI3HrPhbxSLhK6D/Uxn2O2BaMjSyUCwR/Z7sYAw1x6
	 izTxK+PXNEAV/Jo8yHaHQiZoZ9ABBnRocJL8KkyYhlOre3/DJDYu9ao0svLFOQdObEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=cgMr5qNlIMfJEblzb0pv0k5MT6Z5DtqCm3U1oEMsFog=;
	b=QVnhbiXBQh/TE2AKOJc7UvzMN1RfIIeLKWeI0IQNhqzjW7zH3RnXuV133Ze383ikAyKP
	 +/sKYRZ8HQrTakHMW2Fs1kWnbIQAywDouTAdhUoA3rdJDcAtWs+3vPVlQUerYbVIBcBPq
	 XpXcELIBexQp6sLVRfa/N9vXs5viZNCO1g1/iFUapl36VaRlAcZ/LS5s7NywRqrdBiBeD
	 GlHOf/9JQoQn6zmiG9zWM8gNADJR0fmEufPq0/tiaU1gRODeGoFPzWtNyEYacxuBcLdmB
	 F+X0qIyJtNo9YhCaxnezxo8H4aUX0sNxy5fsVCX43aYuGAyolmi4s0HYQzI4qsHthzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dIyoIe78;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2452360A6F52
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2452360A6F52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dIyoIe78
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-38587f3de36so709697eec.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164073; x=1795768873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cgMr5qNlIMfJEblzb0pv0k5MT6Z5DtqCm3U1oEMsFog=;
        b=dIyoIe78vmMKmgjI/H1qq/CRdqmVnjiI2Wctq60aJtCFmCkWM6KWmikYWRfJx3VdGe
         b0WLL8wOt1qG25CCSOxCrukPNq1gSOVm4QiHhzXE5/bw8kwgPGNLCGRW0vGiWrI09bwz
         Cv51G/xXzOu8ey1N3patrzhkybZLv9G9cl4Q37BXpcablTrg48/dX/a2ItKBbfOjk9hv
         UIUnp9WfT8WbgzshbujmSyZiO5k5GreQziiu6dhv3HkA+ySKFmBg8Mt/ftMx2bd17NHw
         behbKRSgs4PPZEzlfOvRyGVBgkkj4pTa6fM15H9cFk//A3SiscRvuM79GdyZ4kGYCZXk
         Zz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164073; x=1795768873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cgMr5qNlIMfJEblzb0pv0k5MT6Z5DtqCm3U1oEMsFog=;
        b=MWn60/ZRp8mqI2cusswtNPiOxxt3zuBv/k4rTVBA7KedPkIk5DACiQR9HJUSHabVUp
         lw9vMh0XsPvXuq4wiKZj3HwTdFgeYeSYLSc+4QEUi8oEXxdkXOSngd+zv5aTEYnfjE56
         +NtHqSsguhCPiy0NEzc8gB5pjxdgG+Tp3Lihpp10yLD9oj4ixLETf41zeGo3ZnTct+d3
         8llKdTz/ehk6omGzAQJQLctwlhN1jUBo58OXPXnCxCsaHvs9D1Z1IlAH383S8HG1mmkW
         WzdzPKfM82tJIro5GIDldI6pbTrNsL41VqzRL9Ul4lwhh9J1j5QTP5SGpzsdCkNHRAnp
         +spQ==
X-Forwarded-Encrypted: i=1; AL+hErGte90CCP9hmaLA/YGPcMXU+Polzj8L+0a1kSAqqZ87kCOKIVJLmnsSVKNRnS7Uf0aOZSJGLXQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uzVwGgxDGoYWs3K7DVxHzidmOGe25aphAWQN/NrTzJ/UpOmk/
	8Q7X5KyEGMig9rwlWOZ7VXtFx2yd4tuszmKGQZhMrXdf0XqSAf+Fbqm2
X-Gm-Gg: AYBFou2LXigsShhSFWBTwybXeW8BAcn8cJba8Hfyccw2X1T/DS8yuE9GLSjpGcHHQ+C
	apyuQNMBJbtRRVFl6Z6imk0IN9nb4eIbpfl9lH9Wyb9IXMyzgnF2Q0yUPyFoFs9HEYSwUB2nKcL
	I4IDNvE/ypuA44C7BwmCWtyluFpB85EWBBzZyjfJMn1/3OZmfYaClCFMkGuOinBD+ufRGLTbEZP
	Kvi3u9z3BdlnnRHn3dltVTgFxpXEnJwSLntejiDzGiSm3SNiSDTBMZ8dNYo2szhZjUseDypkxiO
	4j/lXabvKZgs3LlDAufLWkymNTyXNfUru51KpXqd5Q4a8PjYV5euEcAnw1w9aXkbvMn4N4CDHgz
	GwN/Re1cxkbY7uFfsFAWrOTenr+SOvdlaOBLNBECQS0sgTsqwP+XgfIj4Mhlju0ycBHeR2ymMZl
	MFmLOF3Xh8IQUHYjW8N3OtKgCu184QWuNl5y4UY+40V0dQdjOvo6pm/iQOIQh4tV3YuLgMxZEpC
	e4iVulJUStHJ9JSdK6Gxke3gzE48m7m0oj+UEeNoMtM6RDIN1mHPszXByb8vbKWizgc+jqAPtMl
	lVOHWMzrKlcAvJ6CAf0XKqduNRV1yEm+jZTni073IO36r/buw2DlwXrXU/uvCqzUgznvbU159YE
	UHgg+uDs2+8p7CW6HnQ==
X-Received: by 2002:a05:693c:4195:20b0:35e:2c6:d46c with SMTP id 5a478bee46e88-3856f0511fcmr2053564eec.10.1795164073138;
        Fri, 20 Nov 2026 00:41:13 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:12 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:58 -0800
Subject: [PATCH v3 10/14] HID: logitech-hidpp: fix HID++ 1.0 battery
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
Message-Id: <20261120-hid-logitech-hidpp-v3-10-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

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
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
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
2.56.1.750.gf70dc682cf-goog

