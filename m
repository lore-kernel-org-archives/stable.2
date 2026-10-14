Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ECE568554
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999275; cv=none; b=uLI+9IdmJNO651DGk9Q3hkBiZzPMtb+P73AkTdaqROd9RHt7yodTzquYmUXHSbc5EHlyV+r6nR6OdJH/DlfaCBdMiPvWwTbCuZmg1R4dd8lQX96OT65FED4iIVQAbHV/VGzFIfmd+bFvwprjOJoZmWeqGaXO6CmrJWIEhEak6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999275; c=relaxed/simple;
	bh=Ykf+THWd+wwdgtBisDTMGKg7qHYCcw/sjql5oejhnnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CZVR3RthXB1Dq3BmfDqTsJUYa1CVb6zdMgdziLRrg2MH+D4hSlywfnbwbaUrVnZR6BPwNEF6b/wUVrqy1Ih6m6/uIxqZsfXXxvzT7NNSf0ET/ku5c3LXFD60knWWym+bHdqtjHVPGNZN9nkGlDVYMX6xx4vNrFdDteNP7U7OLX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dy+oW7hU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy+oW7hU"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2e7496f947so722671166b.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791999267; x=1792604067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HmwpXY0pkazAyjk8nr8JLuf2WFindAFqPQA6knsCB1s=;
        b=Dy+oW7hUiHgBkmmHY0E6bAR6VFqDJ6JOveMyBQg3XTZX2fd2rHbknSS1Gl53z+BRCn
         AXVt7DX9eZ5nC07nO1IyOPlYedkqvsEsAXsFdYtsmA3hjSGZ1iFFIbnTLpw9SD8NRpiw
         uCKOdlE07drXqKVe3fcDpb8vh/nGS+2YHQjQwq1+EN44FU7iGkVrXYUwv0IjF3dG6n9T
         Fnhkhu5ttdQ747V6MZZLUJc9joFvSd9agHgONB81p+RFrnrMfjt4kdL3OIbE4eEYNl+t
         PMykS8+CaYrgMwa5gyaNg2AnJt6jgrdcFe+DUVyhbLAr5pbeq6xI0iTXdjUadDNzEO9P
         U3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999267; x=1792604067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HmwpXY0pkazAyjk8nr8JLuf2WFindAFqPQA6knsCB1s=;
        b=k1pP4VCHwglLBr9KzJq9YLSK4A8UD4Imda97qsDPB+XOytPD/Orq78r9cLo1+S6ZsU
         MfPJcOi4n8oYoVS+WYrr3gZKYOKe+4CtJ2nnvNPndNeN4KduUzRlpKgcsS19sM6051zN
         VxkBU6hN4tx9yTDvViQ9IScclzmGWcSvkpVd9BUnQ+wNKWCtIawwyUkdu8P6xPqkfW2H
         9hfIvWLE2GTcHsxZ0k4k9aCF3QWH1odaiF5HTb0LH/2gNj81rhBFPR2o/m7jdBdtrvg3
         Qz485awP31k7xJn3nM7kQhY83HgDE4tvzdRMdupUG63tFGolOTB0NceEsguViR4z3xQD
         GHrw==
X-Forwarded-Encrypted: i=1; AKwUvBx4mXBq58vdZAyibTPueh207Z0h742mfsIVZbV22CHFeMcF66TRMxYMTWRNXTR5isMxY4gRW9I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4RJ00jJOuRsTTzRP7MbQOCnjpUiYFvaRbPXKCJp9XKFepnP4q
	LGDY3v+IAsLXjjUB4NIW/WTpkuYZniSm9Dhy89OdtVlXL5Y7XSHn+rwK
X-Gm-Gg: AYBFou1gndzBpYjYA1seK1adkyM1cz1L3TyIqGMdmtCeCh6yDfSXaNEkPWOA26JXqoy
	TeMHvm2BNd+nyRfPfNe4NeBRFYnm+nGApv8WABJcy1PGKZ+FyyHyL9ndI46u5CWPshBVYE0ZmGQ
	sZvaXzuFRhmw55SwYr6FB/EG/s/iE+dDJbEXbAVbHjDZjATBGI7jBW3Y4UOdOR9M9avHUOCsS2o
	BDFb7+FNsgv1Q3xYgQmn/f4uckYDMc8z7FQOgI+/IdG2/SkbAdG1MEc0B7+M00tF8ddcou7AUvW
	zSeUX84RjahW45s9FBLRh5y1O2FYzZnecYPVdUdwDpjKs++f+GNQtQ7SraUIrNp79c2/pkjU7GI
	6wc3x/ds6TKh6fsw2K/gknE/9jg1v0JyiVsIPD9Hsz3K6y2ebvPdfHXjJwVMvxgRT6WXM9d/H3x
	oFNl1D4ROZimYVE4qzTk96bW1wzTxc14Rt1jWVxAs4DUwm3aasFZ86yLDdUzIM5+qszUcohycEh
	oywJzsPuqXc9NJOPwlNG9dhyTc=
X-Received: by 2002:a17:906:100c:10b0:c33:cc6e:1058 with SMTP id a640c23a62f3a-c33cc7d5811mr649024866b.24.1791999267535;
        Wed, 14 Oct 2026 10:34:27 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:148:f08c:65a8:f8e5:f310:5a71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed963cecesm9381366b.21.2026.10.14.10.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:34:26 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Oct 2026 19:34:08 +0200
Subject: [PATCH v3 09/11] hwmon: chipcap2: do not discard pending alarms on
 disable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-chipcap2_locks-v3-9-27ebfc2c5b9e@gmail.com>
References: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
In-Reply-To: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791999252; l=1461;
 i=javier.carrasco.cruz@gmail.com; s=20260924; h=from:subject:message-id;
 bh=Ykf+THWd+wwdgtBisDTMGKg7qHYCcw/sjql5oejhnnE=;
 b=rPohMS7f4C8gD/qGD/7EKwN795k5pUHWIqrYc1aW14it7pL9S5jKSjA1/029RW2pOCBWJFZH5
 jqTPS3H0+PgD0hpdiVMFcLt8mmKQaou2RK3O1xMX4E3P5QfMn1R/kJh
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=VV+hcMoOj1Sx6xSiY0W/FZNAskGZe2AagSMVj0PsmAs=

cc2_disable() stops processing interrupts before the device is powered
down to ignore the alarms caused by voltage toggling. The handler of an
alarm raised by the last measurement might not have run at that point,
and the alarm is discarded when it finally does.

The sysfs read that triggered the measurement can then report no alarm
although the device raised one.

Wait for the alarm handlers that have already been raised before the
interrupt processing is stopped. This covers the case where the handler
thread has not been scheduled yet; an alarm that has not reached the
interrupt core at that point is discarded.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/chipcap2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 952789fdb9db..eba6469940ab 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -146,6 +146,13 @@ static void cc2_disable(struct cc2_data *data)
 {
 	int err;
 
+	/* let the alarms already raised by the last measurement be processed */
+	if (data->irq_low > 0)
+		synchronize_irq(data->irq_low);
+
+	if (data->irq_high > 0)
+		synchronize_irq(data->irq_high);
+
 	/* ignore alarms triggered by voltage toggling when powering up */
 	data->process_irqs = false;
 

-- 
2.43.0

