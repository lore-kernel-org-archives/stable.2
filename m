Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380200;
	b=Ro/bt1se3Gkp8Z00R4UwaEy6FF01MqT8vHDqP0INOFivuJuvRtzTsMdGPuLrNYJHGD/f
	 EKKQM0s0y4SDcQO2JOjLc2xUYXfJtJnBMgWgzNi7GoojPsh7C8QADPnvSkZYBKTlxBuLV
	 p0i0NrrsgwwfEA9AH6ssCm96IcEb/+MWR0JSCQpeRkLTwI0pWXSBZDbccz2YSXsy0bCpB
	 PdY9Xq+xQRBcQ5En+Xb4ct+UfqAjNhWV/uboAXtGcsPC/RxHlEX9ZDapP3R5sbGDlLnma
	 XnIAoMKWY1GZNPp3m4DvxYc1dKAol1nxokBvPXEMA4NQF+BXLAHLXYL7+UrSYCzj3dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=7SmbT2885p8gf81jXCe3S6/qBsJ2yVrjvPyxx2QWJ7c=;
	b=h3kwb8t5svgxum9NXdCvM0ax7qRKyEXMUXl5Tg+nzCYWe7zPRCKnLrSlADjNYF1QDSLX
	 ykNF//rx/0VMB6tE+H+cFxfQUmu1q8X75LshoR9Nj0Kp8+KJjNEG9QjdMAh7SMfYcmYnc
	 QPwQs1ZJ2BojPUiNZ9WXdCzTJ1GzHdoD4Omjhge55d7tHpAgN6TK1JQ4IQhCt2WA7tdR6
	 PedpKGUlaQHeZCszTkmRTQ/LauAyph6HJLVbDLSB1NRqjfiNOCUChmtqFYtVhGp8Kkpsf
	 EjRMeDFvqL+FU5dIs/I9URW/EF5ot+nWWzrO6+aLIYvozACxYxz6++cVKfjzAlEY37g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uHqp2NLG;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D8160A5BE8
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72D8160A5BE8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uHqp2NLG
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so270209c88.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380200; x=1794985000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7SmbT2885p8gf81jXCe3S6/qBsJ2yVrjvPyxx2QWJ7c=;
        b=uHqp2NLGhzK00XTIfrkQRkQuKuh0Mmw5nB/Kat4LqWbqhnMoF9FAnCYO72jDqDvksL
         Df8i04ZsPDBrImnMyZRZFGMuRlO8BTUd/nrGj2C/XCcd3Sw/Pypv6A4hX96itvrSKwGD
         gcpI3tXeOCYEfxmvDMoke8M36spvzjONIRQGerRRpnjrxto+uw7iacIxRuo9yLHtRxBA
         muGbVzAki4EKjgZ0bk9GJ9s0CUGQ1//D1kRp9hes2LTBixo6E8nKapTwnAG0FcMU9f1F
         XMOdO6e/nyn5GXPWX/lp5G5XUYytIXbRpvNMMmIwlen9Dcx+yBvgQJrjJQ99NocQaKgj
         KnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380200; x=1794985000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7SmbT2885p8gf81jXCe3S6/qBsJ2yVrjvPyxx2QWJ7c=;
        b=tk2H/sdIzI4wjQLGqVb09DYJl4oiJuRbZOh3nvwDbQT2uomvJCI1KYHj5VRrb4bp/m
         6HRAwWuZ5IOZS91w+ULTudww4UhJewYt1JwDAJqndi/6EBwgyvNZZif7Mo5k+oIfMEcK
         pEt8NHx5F708lfyvybB6t5Txzm1GHWRIbZe42njG+i0IL1l67PBNTeggMBtpBLfs1B6C
         XbMRfjHiFWPjLKf7nrw+Zg5BvGLoDtNNgbktGSVlZwoYRyNe4fbkbjx6tNbhltoVBdNt
         PzNSrL4CuZLCaDqDeN3MSW68fzboh5s4LuFkbPhZpeFhq182IAS69q3+qB97VJS5VcE+
         dktg==
X-Forwarded-Encrypted: i=1; AL+hErFuiIfe4YLvxUQDkPKeLUovR6pkwFhYjlnQPILXCwpgDYrvyn/4Ts650ib/7ye1UVRF6xCwBEE=@vger.kernel.org
X-Gm-Message-State: APuU4Z99zlpF0CoL9pbberaiFHD0MaJI1PHToUCqzJVCM6DFrlPUZouK
	/afLQCyU4UT5B3xP6FM8D5uuKKyU+npZjCYImeM75zVCHtkyzjoWsGGv
X-Gm-Gg: AYBFou0pWoJxTjf/tg8xc8u92mpPd3zl/KuOaijMiwaT+pWPBNokC3eeFkTioiIc9bk
	2W9bWBw5bg4r/RHt3kK2a82hXrTnwd6eAGkps8W4nOk+I0JedaEXIkJGTyh4RMal4V59TrMi38p
	/8dlS5VcwdD/2xmghSwXt0BG/YfGxzMxN72FI3OOhILgBgwsCqU/24tFbEo1rcynfHY5GjaiE60
	8emW4SsdIeH19r44lmaY2c7bIUJ6FF2xuf3kwJ4W6HM8ucaDzBEMVOD/zPZuDVvw261OjkvVYZ8
	eK1G1NpzC0a/FP3Z/6fpbyMOTqcz5Jzq1QAI7WCwyGobLssvnxa0F4MV15hRwnBS5O/NCx9JrQe
	PICfV+yiTG7pqL0/YAwZuLp157H7ugylAbj7YZuHxNLhXozDxqApppt6Rcisdra4JpOFZ+FaiUA
	CqQQIjiLCCCgkJILudN7sbL0FfaowjdeJ7jbm0xteBrmA/SDItZZNM+b4QrlAPiyYsnTOgem8SL
	tbp+fYPDWAQRIZYJMdRFkzFtIXCqHCNHJmsOwJPbWZMnI1Spfb3LDLpGvMSAO+C8O+Xt5hDxETw
	CcLqi+lgaC9ymcHF19olBjPXyUEw01cSUcSTAMNNwXoTUFVeKbFYE4O4lROsDFZ7zN+P651dt/O
	eFRLr3wzQXrSn5PSPEA==
X-Received: by 2002:a05:7022:7f0b:b0:192:e5a8:6bae with SMTP id a92af1059eb24-1b3c034e292mr1417864c88.40.1794380199197;
        Tue, 10 Nov 2026 22:56:39 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:38 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:09 -0800
Subject: [PATCH v2 11/33] HID: logitech-hidpp: handle negative errors in
 hidpp20_get_adc_measurement_1f20()
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
Message-Id: <20261110-hid-logitech-hidpp-v2-11-30743e91d83b@gmail.com>
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

When hidpp_send_fap_command_sync() fails with a negative transport or
timeout error (-ETIMEDOUT, -ENODEV, etc.),
hidpp20_get_adc_measurement_1f20() only checked if (ret > 0) for
protocol errors and fell through. It then parsed zeroed response
parameters (0 mV) and returned true, marking a disconnected or
unresponsive device online and triggering spurious "possibly using the
wrong voltage curve" warnings.

Return false whenever ret is non-zero, logging the debug message only
when ret is a positive protocol error.

Fixes: c361982a13c9 ("HID: logitech-hidpp: Add support for ADC measurement feature")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0ec2f2fd6dec..28402baf04fb 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1952,9 +1952,10 @@ static bool hidpp20_get_adc_measurement_1f20(struct hidpp_device *hidpp,
 					  CMD_ADC_MEASUREMENT_GET_ADC_MEASUREMENT,
 					  NULL, 0, &response);
 
-	if (ret > 0) {
-		hid_dbg(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
+	if (ret) {
+		if (ret > 0)
+			hid_dbg(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+				__func__, ret);
 		return false;
 	}
 

-- 
2.56.0.542.g3ef89b7020-goog

