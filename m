Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204675;
	b=xh20s8WDqRmv13dhfXAf00kr/YwL3oHu3rjTcD/643tFJs+l0s25K6dQ/+lUj2LG7Vcc
	 gDZDXQQbqFtsrL4f61G0Yd/36m0RSmY919+eu4ESwvlpNkLiG7RCi6kmcrU7dVw4ZefwM
	 HtMKh4txf8iJR5ca5jDBCwKyiG2zQFOpX6B9nqGL2x9lU16GcgqRNRY9X2RwxNsskO/2g
	 xvlEP8dtJUVUgVVc6UTUXg9ZuUuGFa+TBZVGbua7DWb9GlA2BdTvekYQwDnX87aHrwPYq
	 LozHdrQzLiGP42jGJ75A0OPlzjPxcuma2QEIeuxeU+IQGEsWwMxI2RZVquZ9Qdv91mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gHzyFwE4kZmoIyCMCuEGRvLMldGFpGCRJxETSq1bEAc=;
	b=Z60E569lJ94MwAVT6Cz5/tOLAOrTgI6f70EnIerYoQxsaHLgKj/t+UCkAFOulDA8jLqc
	 j9lpRk16YepXS0X6MkNH7/gkU+5jQSbe+8XH/sQsLvYiLcXAF+a+S4cO4qaahphvITMb/
	 iZ6SUobb6VKSJOTNB9+Tp9gmpBLzz363VCVWkznXkYwY3NLX4IdozO2K8XLJ+wk6bgFnC
	 Lr/eh+Q9tDPSkZoFb/dGcqQinr86NyVlMk3s4b5/jCaku+2P3RjVbXpNXIA1DSWMQPwi8
	 FeVyt+oWIsuIzL1w8EzVZ1xNOj98AcVo9IzIR8qFIfkvyJYAsHn7hi3sxjn5hpFjI7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="QzGJvgB/";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DF6606A338
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 06:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8DF6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QzGJvgB/
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3712b6d9843so146025eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 22:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204674; x=1794809474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gHzyFwE4kZmoIyCMCuEGRvLMldGFpGCRJxETSq1bEAc=;
        b=QzGJvgB/Ha/ubu4EeNf7m+HsnOI0YYdWo0CGi2KAtFmjebJ/JSQV8O0Czo47GbFR94
         UCLgcXOHtgNdPZ3ZDAMNVLQhMf3DbFCy8sC4cB04Z4vda25/yUwx4rvBLPlw57oVyLIX
         zZUACtRLgEXv6WMxsVjdol2ou67ROg2qfna6SidNhHKaQSwIN/FMV/VqBcechWHf0JWj
         ZF141THChrSnWiBqaSig4WugfTksD+QaNgU7/SH5qXhuKG5++6vwC1/NI6o+EBmOV367
         EKf5W2HKFAaJYZqRLIYp90e18woIYsCyN3LnRrsmNKpIngX49JMrgkayGcOjlkneirBo
         ubVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204674; x=1794809474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gHzyFwE4kZmoIyCMCuEGRvLMldGFpGCRJxETSq1bEAc=;
        b=rzHhE1y/HwmZdi4KoIB4vXOddOpDOALasgl5z8zdrVUE0Zlmh274t5Dc5ZVoYL/SiC
         MT61CNDOlrVuxnYUQFcN/kEWS7d++L0PUHTdPrfw1cy0ah0BpOIYeJdA0rTNBdT42r2D
         2KcIZgYGrTOg3RkACcfqzxyo+WlMZq8qDB58z2us9obs3kWXI8huExg5igqLl5nH+PsI
         MTGqpSGdo69su7W+BjJTvHVrTSICVb1XjXQlX0cti2WfHcYWtpg7RF5z42Y36/Tm7o3h
         OpYWx+WnPn4kVksRA+Tf5dW7LTyGQvUyNer2rGNHDY6r1b5TYH0A8smilEvH7Md+YEvC
         Inmg==
X-Forwarded-Encrypted: i=1; AL+hErHXK1jTOeT28bkcLFdAF4DXLKeXLV9Cpl15MzbT4UZ9E5TRspaRs+Qrq3xDy6KYE0p6ckWIKkk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wn1nD2+MSSaiO+kHTBTxsZa/zk7AgB2m4NNiNsOH+6uhi7ZEo
	7H9qJ82ireLM+gEEIjY+wUyQ3akPg3Dq5G5pCClc7IbXbY39KuXK1w4D
X-Gm-Gg: AYBFou1VFAWqGEpywqyjI0MyToucXLmH6sQ+IgUpvnLn2g2pd8+Yla8B7UoudcKIN36
	cCf78aTtJnMVVA7HZfPTePTGosMHabBEGYx9gc2JJDQTe6aFa0B7BrVQb1wSbXHdZE3lavxNTS2
	6o43vFC+nt8gEAdYi/E5di+jX42qGB2/VQPdxeoOWr4IH0+EOSqsYgoNAkpGYVm89AdGWGZPAeA
	y8rL1Uu2ibcZoNnv/JLELMkPLjw5MR6Ya4AFaUiJdAKlWpENKJDPK+eR+8TPzzNYstEH3iVq9H/
	Ksrd+ib7BN9+54T/hswNdwWDhChFFn1eo+ATSAi/Ifo35+uAEtFMwnLw1VH1C9t02KJglYZJ4hH
	yb2OxyHiyH2lXZ71ywtQhTzVVaUsq/seGlygQKPOToI3+odMZ9tXZPa0BOIRMzKaDs4Rk9Zkkn5
	UMY4TJlqeDZmMqHyXBcQ//kwgqEJVQP85IpSPPMnejouGpnYcpeiNgT5zxyC5lxP4RdN0RHxBoo
	Q3Tg6E9zOe5+KftYETDr81r9wWERBvQQmIkGUk4/k67Ng09XPZLmf0KYNaU/DEV6Um0PclWpEhN
	cQvlQZTi87HRBwhrtKqJ1jxRQasDs/pfm3Ah8BRnuAfjE5NJkM8KH9bqfSCGnyl7Dh6r81JZKEw
	pksQmHmT1ycoPPqOe9WCBT56WgXRP1gvQU9cCtw==
X-Received: by 2002:a05:693c:8382:20b0:35c:8b96:94d9 with SMTP id 5a478bee46e88-3725546fbfamr6786230eec.19.1794204673770;
        Sun, 08 Nov 2026 22:11:13 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:13 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 04/18] HID: logitech-hidpp: disable works before stopping transport
Date: Sun,  8 Nov 2026 22:10:48 -0800
Message-ID: <20261109061103.2887636-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
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

Device removal cancels the connect-event and hi-res-reset work items
after stopping the HID transport, leaving in-flight handlers able to
issue HID++ transfers or register power-supply and input devices during
teardown. The connect failure unwind path in probe likewise cancels work
after closing and stopping the transport and omits the hi-res-reset
work item even though incoming packets are already enabled before
connection setup.

Disable both work items synchronously before closing or stopping the HID
transport on device removal and on the probe post-I/O failure path, and
drop the unreachable cancellation from the early transport start failure
path.

Fixes: ed80cc4667ac ("HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 476c0f0eb086..4e0758cdae64 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4799,12 +4799,13 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return ret;
 
 hid_hw_init_fail:
+	disable_work_sync(&hidpp->work);
+	disable_work_sync(&hidpp->reset_hi_res_work);
 	hid_hw_close(hdev);
 hid_hw_open_fail:
 	hid_hw_stop(hdev);
 hid_hw_start_fail:
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
-	cancel_work_sync(&hidpp->work);
 	mutex_destroy(&hidpp->send_mutex);
 	return ret;
 }
@@ -4818,9 +4819,10 @@ static void hidpp_remove(struct hid_device *hdev)
 
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 
+	disable_work_sync(&hidpp->work);
+	disable_work_sync(&hidpp->reset_hi_res_work);
+
 	hid_hw_stop(hdev);
-	cancel_work_sync(&hidpp->work);
-	cancel_work_sync(&hidpp->reset_hi_res_work);
 	mutex_destroy(&hidpp->send_mutex);
 }
 
-- 
2.56.0.506.g506a7eabc5-goog

