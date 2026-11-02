Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627218;
	b=Rn+By8dYGv/wYAH4M3Y8gX493JFdfh4qyv1izKJ8hsDD3phNI5lJLfLAzfM+M60roqHG
	 vwgEUt9IlqsLEbfORoJ1bf5Fl4gs79gVtFoUNkd+66+/ycS7OvhSY1Zzk8tusiG6V6/BF
	 cCCCulVeNLcDluW2pP3ByD3qDTnuAzjsX9tRsqVpMoV+IO6440xN7g0Z0WA2/pcEFVJID
	 5gPBQ68JbDReIBb4tjL+cewWltKxfbpulPb5x4ylcyWGLf0zkM6Weg0e9qp0xKkf4wf6w
	 QlwoMEd3YAmyroFZsVDLg3kgKBgH6DUQ9c1wQTXT4g0/KmFk4g0i0ZRObcrk/W17IXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dubg1gFlwLFjUntHBfFzK7AT4OWC46obGwplwmSB/ss=;
	b=zGuUZwu3NEXrdAQcUq9Z+2BqT12dB2R680wYIHSBDeCQIMvAoFfcuc2gaAkba7NCAMIq
	 CW2N0W6u9f1cC9iQ4oEmryrCxq5h+4VdA2SnqTs5DAkIRnMYrRPLSIXgZMozTQgZHr09O
	 uqNb70JWEeq1ile3v7lUAIzlBnFHeZziRP2SqlF21tbEH4itTh1+gP8D5Cg/qKz7h9Ett
	 n84MuX2OptzeudCWjipv+dY6YLazN1cTXcIuihSxKa2qQpS82Z6meMzsQdxA0rSdNMOvP
	 EKEwDj3xKUfBx9SciwSLj/ZFYRwyOX3Y1qTeVp8P+CMkTy37tWHKbBRCgC5bzh0Vvfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Q6+Shkn/";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB649606A329
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 13:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB649606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q6+Shkn/
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so23277035e9.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 05:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793627216; x=1794232016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dubg1gFlwLFjUntHBfFzK7AT4OWC46obGwplwmSB/ss=;
        b=Q6+Shkn/ObJr5jdATQDsyRSPLAb9MySAWl+yJX46CQKajHmZsK/iR0yiIQwuUi8y1J
         9v1QZf3SPv/OiXznYwMqUybwM8VSNfZy96EEl4hAqrzMSwGDlyCLi5unRHhqOymdpMSA
         yC/CjmhNV24dDnOUp7jrBKE1wsR/P6KqoEbo0STcFrMMOM38FZB4kn89Smwww6mXWspa
         8rgzTWjmTWIzabmKmTTBqu3Jig0z76xSvrexbGAZaNosC9cP/MchuajEj9hYb343yGgH
         KSkDgXj2Kb+7dk7qRtR1cUsRy/KLhwlPWtnZG7bHPMSCGjdwZcTgrgHtUiA1m/CgFOBC
         3QmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793627216; x=1794232016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dubg1gFlwLFjUntHBfFzK7AT4OWC46obGwplwmSB/ss=;
        b=tWQtV7EGI/X8NW3zk+h/MuNYgZ0AhVKKH1QU0icNUxq1ukEnj3SUQn+XJE9TiVvL2l
         doLsdr1FtzRrpUEaYsOS6NmZrAorRFAWsS0+UCdGldLKgonxhfr1jQ6FKg3HwbJjGBjX
         wjjTnZFctqLMYPG7HOZvO51VcVlQM1fkuc7yARzGbCGEbVXmIJE4rI5OgbeSt/aakbdQ
         aY/kN+xiPEqeDf1AEGqddzDccze7375HaS5uDYnSz8tsPfUkkXxSGpNZGBRi89f0nKpX
         8ycwtGEIcItEBXh8Txo4BRnPFIWjx+Z5Xh+iI5WgnNACFzDi5S+V4aBScE4Wn5UXUSCi
         9fEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwS/TqYH94J/usiOtIDlJxWyRQMPXuN2q7lxNVTImLcSVTdQKzJIlPBG3wTFGDAUvayYM/Fn/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZVTDTi/1neSew1cpdKlUjeWcIBAwYCNaldIDxbaBzpS106ugy
	4LLRqSODy7pulClocfs9Iqzz22DKNd/16aVWIENrbY7TaURW1Oyveq4=
X-Gm-Gg: AYBFou0jEGHzvmWl1nuAOAk10yG8os8ktDY1+ow5g9mruSMxUqeqFyeARPJSWkPa1lV
	CVca6B/u3behZc5brYpQNUiCHi0OlCU28g/czOhDcpiikkxFYwbhnBI+PEh2uocwoIXS7oNCADh
	ficnXN2rl0vhQxGgbZJDYYddxgx3ehI5XiyASrFRFz/3zwPeMjXETinyAKxDct3e9EnuB2T2xhL
	sZCsa85+l/tZVwT2+A3ytDgVvHtAQpMEyhVTFTvlXZr0weITD9KdSOsj2k6fpWJtTEMTwMthcBb
	vgkq1zT0ejdkm8tYOySg2qc1sUnGZi6Q5KWatLu60KSVPxmm250wI07IREe7m91XlBTk2KGLiKW
	xe5t/eTJmKY0QAh9U5ohjaiQzWj46z0X3WNpzeMXf6T8JWAhMxjNH27JAfqy3Iz8T+vM1feGXoN
	nBhFmug8baO8cK7FmelUx+UD613RdgPCZFWG7APTYc0akocfSsIKgS+jZj5pH6Fiy4XEM8Pfhs4
	9NnQplGRRCvTbceh4EMyNGtsPaCZ8Q23z2atvitjLgF+UUN0NtdgkV8xGPT2XLVS7VX1FTq3A==
X-Received: by 2002:a05:600c:1f94:b0:4a8:f2ad:a9e5 with SMTP id 5b1f17b1804b1-4ac1548f591mr233240795e9.3.1793627216106;
        Mon, 02 Nov 2026 05:46:56 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896fesm388643405e9.10.2026.11.02.05.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:46:55 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: jlee@suse.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: marex@denx.de,
	mjg@redhat.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: acer-wmi: validate ACPI object type in acer_gsensor_event()
Date: Mon,  2 Nov 2026 13:46:54 +0000
Message-ID: <20261102134654.638644-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

acer_gsensor_event() accesses the ACPI evaluation result as a package
without first verifying the object type.  If the firmware returns a
non-package type, the code reads package.count and package.elements
from the wrong union member, which can cause a NULL pointer
dereference or read from an invalid address.

Add a type check for ACPI_TYPE_PACKAGE before accessing the package
fields, and validate that each element is ACPI_TYPE_INTEGER before
reading integer.value.

Fixes: 1eb3fe1d3b6b ("ACER: Add support for accelerometer sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/platform/x86/acer-wmi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 61ae622c93d94..72b44f02a992f 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2043,7 +2043,12 @@ static int acer_gsensor_event(void)
 	if (ACPI_FAILURE(status))
 		return -1;
 
-	if (out_obj->package.count != 4)
+	if (out_obj->type != ACPI_TYPE_PACKAGE || out_obj->package.count != 4)
+		return -1;
+
+	if (out_obj->package.elements[0].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[1].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[2].type != ACPI_TYPE_INTEGER)
 		return -1;
 
 	input_report_abs(acer_wmi_accel_dev, ABS_X,
-- 
2.47.3

