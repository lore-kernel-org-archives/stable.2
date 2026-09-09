Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431748EC85
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994325; cv=none; b=bOeA99p4Qb6Ode38Ftbxr9I2NsamCLOzW4Qz3lmgI6ScdwJil2hEFAg2GNe9TTXtK9sbDJwzkZ1JGsVJR3LYIUnrfHqH10nJwLeeQP/K1b4DGG7zb2DKunCJzMa1UsOIrYTfzX2MYLyOfiJfLFX6+JE79zjVeIJya2DA+NlSGRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994325; c=relaxed/simple;
	bh=w61WNGoIZA/H9B+0UvBqxIy2Jaep+YUPmNtGA17Z5/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1a93APq4WcjlfP/cPFSJN+iS2yUh5xLDDsWHS+EGp5imrv63rrJ0E+g3vSevtHtPi635eXv1NW4Xt6wA8JX4NLAUvntWsNHXKDplLWO8G0f66KBWI+nAS9ONIw3PiwGdLI1M/2SyhUdNwNbH7Q1fI3pnA7nAkZSpD2EmFOejr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MeBpc7kw; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MeBpc7kw"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52fa6005224so55313261cf.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 15:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788994311; x=1789599111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v83isyAjdugdAGxxYVFRPX3ygevFsOMhNoKrO0tFt3Q=;
        b=MeBpc7kwl8MqLB5z6n5iVHzQx1veQ4IM9toLUmhGA9TK0cfX3xwiLG1duwcROB5WWV
         3t8SJ1UpJGFjz0VXzPg6jTVGK1wTgmj+j4POwyViHI4ijP2CcjiAtIP7SorPKiZ0mCDc
         6BET0Oc74wQmklv7fW3R53fsvaveV+uTIKhv8oVG6vD/2+vJBWtn9sOCfFbqcR6ts3de
         P//tvGElRAsCY/BjUMQ0hU0RH9M5EO0CMWccNDF6r4pj9gaNBMPec1sGRSe94TWO03IJ
         +U9OLQCSDRovEQ10YsM31o0Y7NNJ+/60enrsA/x2UIeDAkJ/1b56aIuKG1aDF9ta43TD
         x0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788994311; x=1789599111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v83isyAjdugdAGxxYVFRPX3ygevFsOMhNoKrO0tFt3Q=;
        b=T6AlheTL6x8gNVVbcf3t7qLJvxV6vfgitkerneBtx1i4/N9+2oIe2FqWrixLyBEOOv
         4S0IGe+39esxgHF2h/EQuTnvmwr2qcqinRmYGaqPE19eL4AePtMzVp2y/pCzAKFRFW9r
         54JkhHpuVuNfWBpsvn18HrommOQ4+gg/UW0ykKGERZkCAx50/U+8JCoxUyhEYrWxezNT
         /A6+HMOLtbDWRfIBD9g7vOQozXzmJo7QKmuqo1iY7l5cAIs7tuyIJowhkVPYDfqrXyDe
         xiyPq1msWq+STdvnLcIqOEqGmR/liGna+d6knl/oC3oYC9DpGF2vjzXfz6T1t5LKpJ7k
         xaMw==
X-Forwarded-Encrypted: i=1; AKwUvBx1ouH3lpYje+c5utTYx5p3ZG5rv+XmGq1opTeTRIKyqZWlHtLnh372h4OiJ1Y+ICYnpZ8tAck=@vger.kernel.org
X-Gm-Message-State: AFuF++nS0Yqp1MToxLnXJwe/0w/KptTrdjSJdOlmUZjqEXXdDQlP/BCp
	3voLWHMokgw1fZuTxF+YAbcd0x7LDYP3i4mmvCg9G1034aS4bi7EckdxQNk8+pRyHK4=
X-Gm-Gg: AYBFou2/fcPizy7vSfPhFDfjSykR53kWankpQ9LFJQu45oX6r4CLM/ZzLpr/AbHz+ku
	CD4SXPO87bFUh5ORI9yRlTJiDXuwx6MSgeB9aMzngCN2sa8XJc4DNyRWOFDtkqdXvMnnJgUP3XO
	7WXth6vPN6FOh3eibbfyZauAiM0J72qS+4J1IFQWL4SwbXmLxnlbwBgE6WhkSbbd8XwMscB+FK0
	a+uuNzHk2JXNXL76D7HYecY8WEczFkxA149FNXbG2OuGttt9aTx6FWSCGg9jUY2mYhnxpDjmlPL
	JkGpVvjdgY7/NIC3yXixpmxiGK9v7/kNQjEVQZMRTBygMw8wd3nAPIThPyZvpxxPk1Ty1gG6P/M
	ueo5kw4gcpXJ7IsZkpIi2QM1zhFlMjtQ1ct4YhEzcZgeoBFQmGnwUSU7F9lbht/Sqv9l3oVAoUJ
	l06ZY37ez/C/DANrnpJgz6RitQAADlw2ZnUZr+3EYBdbNOUXCiuXKFOKYD6S3sZ6ZFAZb/UVi8m
	RZw3DH6T20NAgLyP9prw7mkOPJj6JiTDBb0ZDGje2dH7e0L/rW0qp0RtfhJ
X-Received: by 2002:a05:622a:90a:b0:52e:1e5:4754 with SMTP id d75a77b69052e-53054944d66mr394518201cf.24.1788994311148;
        Wed, 09 Sep 2026 15:51:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm59976696d6.20.2026.09.09.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:51:49 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	alexandre.belloni@bootlin.com,
	rui.zhang@intel.com,
	stable@vger.kernel.org,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: [PATCH 1/2] rtc: cmos: Disable ACPI RTC event before handling it
Date: Wed,  9 Sep 2026 18:51:31 -0400
Message-ID: <20260909225132.1392883-2-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909225132.1392883-1-gourry@gourry.net>
References: <20260909225132.1392883-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users of RTC_UIE_ON can stop receiving update interrupts when rtc-cmos
handles alarms through ACPI. In one 50-run test, 40 runs passed and 10
timed out after receiving between one and four of five expected events.

The ACPI ff_rt_clk counter stopped at 218, exactly matching the number
of events delivered to userspace, and reported:

    218     STS disabled     unmasked

rtc_handler() runs in the threaded ACPI SCI handler and calls
cmos_interrupt(), which schedules rtc->irqwork. The work can run before
rtc_handler() returns:

    ACPI SCI thread          rtc->irqwork

    cmos_interrupt()
      schedule_work()
                             __rtc_set_alarm()
                               rtc_wake_on()
    acpi_clear_event()
    acpi_disable_event()

The SCI thread then disables the event that the worker enabled for the
next alarm. That alarm sets its status while delivery remains disabled,
so no update interrupt reaches userspace.

Clear and disable the current ACPI RTC event before cmos_interrupt()
schedules the work. The worker can then enable the next event without
the handler undoing it. With this ordering, 150 runs delivered all 750
events without a stall.

Fixes: 311ee9c151ad ("rtc: cmos: allow using ACPI for RTC alarm instead of HPET")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 drivers/rtc/rtc-cmos.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index f89ab58f5048a..462799667aa18 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -758,7 +758,9 @@ static u32 rtc_handler(void *context)
 	unsigned char rtc_intr;
 	unsigned long flags;
 
-
+	/* Quiesce this event before rtc->irqwork can arm the next one. */
+	acpi_clear_event(ACPI_EVENT_RTC);
+	acpi_disable_event(ACPI_EVENT_RTC, 0);
 	/*
 	 * Always update rtc irq when ACPI is used as RTC Alarm.
 	 * Or else, ACPI SCI is enabled during suspend/resume only,
@@ -781,8 +783,6 @@ static u32 rtc_handler(void *context)
 	}
 
 	pm_wakeup_hard_event(dev);
-	acpi_clear_event(ACPI_EVENT_RTC);
-	acpi_disable_event(ACPI_EVENT_RTC, 0);
 	return ACPI_INTERRUPT_HANDLED;
 }
 
-- 
2.53.0-Meta

