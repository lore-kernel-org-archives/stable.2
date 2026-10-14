Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77114569F36
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999278; cv=none; b=udofQSHx8Z27JQQA2JyIWcq2RLvmGRTH+8kPabo1Wvuy/bAzQlkrjzNwNHBHFG3P5c58+OBA2JFGcR7NS/cZgwrWb9bTXJ9SKvsLGAhKEyXOrSQy/zTO352KyyTjlZRlSjMq6FaI7bWyPIyJdt/8IJ3z7tbggCOC5oGYfqpMx2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999278; c=relaxed/simple;
	bh=bzbUmYbwUXLekuDAfrcWEFz0OZjDqt5QElM4sqlrgZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nbu4EJuE4QUuyvl0ltwoVvg8InmaRCWPl/oVPhxRsEIg5sa1vUL+OVPSdsklYvNB0YxFwEGmSPNC7eIkLvev10/BxocFGhEnUnZ0sOlYNffkUYtME7DgyMDJCu+cd4EebDu2lA5sxOgkHHKqJA+NnQMqeusEXBTL1Rlw0Wka5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGJpulDq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGJpulDq"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2e7496f947so722677366b.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791999270; x=1792604070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6gvT/8PSXK7W+KJQiA60Ooue5nDlDpUxFEkNrlgsoAs=;
        b=FGJpulDqU51HY4RBXPJ7MnbycibmlIvCg3oT6EzpYZF4eHc8MQ8mf1TGVKYEi4Zp/E
         Y00DjvV4qrAwpynVCaewNc+cOJqW1pVjtvPNP7Vbe2ljdspkuy/h5i9YVbWTglcI3en6
         0YLOocIvtLHseEz525FJcfesUzGuVqKUYbouyq/hQsJ+DFkFptKNP+nwYfZ2+SkMG8XG
         tY2CS0YWm+nmZi8mdRGI4wCik0Be1//Gy9ybQMCm+tMRHe7kUj8V2Jh98P8cMlMdxRZA
         XEzVQvE1028w4MpBaRTEgHQKEtFau7xQgYJ1r38ApimuV8caxqEFtaedG+2yCvzo//qD
         YyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999270; x=1792604070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6gvT/8PSXK7W+KJQiA60Ooue5nDlDpUxFEkNrlgsoAs=;
        b=ePyrU5ieR+SEKVJO+aToOFpLtIyDUPwPGQt8awa6QlCIxBN6QnBXePxRx0g/IIMYdl
         OfWXul8FnWn7VPNKOk5asIPMIauUvcwXtH3fnqfVO58oZYovf3cUoEd8gyyh0t8swbGf
         lee7FG6H5PBlzHzk2M9Qv1PyNjI3/8nbUcT0+lGvbpwchSHc+t+nLBgkIWPgcc5ab84v
         oAf5TvaNwHgbKG+3pYfdcMRI0PA0uv0NUo6lqjbsNvzgZtoiwtlB4yuCMUKmy/r7fLOW
         /5Exyn7FFhWvnMbeoN4skWafNvzllcci17ZMjNAv/Z6D/I0NSZxvURS7mf/i8Uwlvo/i
         VsYw==
X-Forwarded-Encrypted: i=1; AKwUvBwhWbhTiSgtlOcpac4eATjge9Lze/joXZbxOauTbmzAqNitDfg9LJSfHu0yw403Wpab42U/Y4c=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/PNUBl4ynFlEUNmTqHx57RYNBZ9o80SXFtKw3b1dmQPX0RmjS
	Gm7XdAXpzV0fMO+QMuRN1BzE71j36/538OypdRaqWoKlAyKMzKVPTZDg
X-Gm-Gg: AYBFou3VR9y0lkBupqVDG3C+LsRiJyqZG2psiex+uQPcpFTs/0oWxBxmsm33lQY+sQf
	i9OpBCD9bDqUUaawfRMdshsTMvER+yG7cPYYgRYCcShfza/2zkTk3BZS8Zs98V/uAu/pWeIXgw0
	lG+vhovg5NxfW6j++/ZyYgl7xRXDt/Q7w86kaW2gF0VGpgSQufSzKoU2NpPhzojykvgR5o1hT5E
	XLdIOtMreJhaEE6a4UgTkfDfaQxCJM2LiT90oARutrRRkG9nOvlIDT2RYZhjnunCMsVpACVkPqR
	rRayE5jsGqXx2GL5bD1KhoLabvD13mm/9g2CvD+4W+yFpCVC9MHmdLo4bbIrbluHK4Cpk1cPeAa
	fMGfa2TgS0KOhSiPuYPWDxUeZMUXU0n+DanR5NujmMU/7L6nmfZO+nJoaQ3i3BuaiiZW9FoqqkK
	KUU75WTqPZSGXpph0S8VpSlgXl6xsUOVozr/AHy494d+K8AwZ9cwYb97UogPiAYLRibpDAf2xxJ
	DHW+IcwddXeEb4RUw==
X-Received: by 2002:a17:907:9618:b0:c24:4128:c19f with SMTP id a640c23a62f3a-c31a9d0a1efmr1616131266b.11.1791999270168;
        Wed, 14 Oct 2026 10:34:30 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:148:f08c:65a8:f8e5:f310:5a71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed963cecesm9381366b.21.2026.10.14.10.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:34:29 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Oct 2026 19:34:10 +0200
Subject: [PATCH v3 11/11] hwmon: chipcap2: synchronize ready IRQ state
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-chipcap2_locks-v3-11-27ebfc2c5b9e@gmail.com>
References: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
In-Reply-To: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791999252; l=2220;
 i=javier.carrasco.cruz@gmail.com; s=20260924; h=from:subject:message-id;
 bh=bzbUmYbwUXLekuDAfrcWEFz0OZjDqt5QElM4sqlrgZg=;
 b=KkffEK19xqZ2pzHaKCnCPVcs6OWCp0j204MpTFkltOAHtXtyvNJchFYvrC2L9QQ+HdUo2lzKU
 W/q+NODjKriApMMkpuXCIcIQwITwb2yRBaMdP79LjRsiRFS4Sr2WtaT
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=VV+hcMoOj1Sx6xSiY0W/FZNAskGZe2AagSMVj0PsmAs=

The ready IRQ handler can race with reinit_completion() in the enable
path. In particular, a handler from an earlier operation can complete
the completion after it is reset for a new operation.

Use irq_lock to serialize access to the completion and process_irqs.
Disable IRQ processing and synchronize any running handler before resetting
the completion for a new operation.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Assisted-by: opencode:claude-opus-5
---
 drivers/hwmon/chipcap2.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index b3b725cc7224..00f62a33d463 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -123,6 +123,16 @@ static int cc2_enable(struct cc2_data *data)
 {
 	int ret;
 
+	if (data->irq_ready > 0) {
+		scoped_guard(mutex, &data->irq_lock)
+			data->process_irqs = false;
+
+		synchronize_irq(data->irq_ready);
+
+		scoped_guard(mutex, &data->irq_lock)
+			reinit_completion(&data->complete);
+	}
+
 	/* exclusive regulator, check in case a disable failed */
 	if (data->regulator_enabled) {
 		scoped_guard(mutex, &data->irq_lock)
@@ -130,9 +140,6 @@ static int cc2_enable(struct cc2_data *data)
 		return 0;
 	}
 
-	/* clear any pending completion */
-	try_wait_for_completion(&data->complete);
-
 	ret = regulator_enable(data->regulator);
 	if (ret < 0)
 		return ret;
@@ -162,6 +169,9 @@ static void cc2_disable(struct cc2_data *data)
 	scoped_guard(mutex, &data->irq_lock)
 		data->process_irqs = false;
 
+	if (data->irq_ready > 0)
+		synchronize_irq(data->irq_ready);
+
 	/* exclusive regulator, check in case an enable failed */
 	if (!data->regulator_enabled)
 		return;
@@ -510,8 +520,10 @@ static irqreturn_t cc2_ready_interrupt(int irq, void *data)
 {
 	struct cc2_data *cc2 = data;
 
-	if (cc2->process_irqs)
-		complete(&cc2->complete);
+	scoped_guard(mutex, &cc2->irq_lock) {
+		if (cc2->process_irqs)
+			complete(&cc2->complete);
+	}
 
 	return IRQ_HANDLED;
 }

-- 
2.43.0

