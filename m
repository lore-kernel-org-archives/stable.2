Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866731;
	b=UAEDllGKN/3W9mtab/DAaV3tnrcDM1GdSkUlqMiocyO2ZpuHTpOhKjrwcvQT3X2VMrsq
	 zWiipOTUizKNvWQ6Cjme+7iFO9NkVZuyfc+PPlYonh0nZEBHkZ0Fjfi9BbrkNm+a6MQJs
	 3Ch0mLdmpjSUNEqhZQGk//rCVBAq2sbiXPN5mcnb4R4702hSUueRIOVOtFkTvP+U1hTuH
	 m92FdKJi96H0X9sT9IoVruul3VdS4p9G8l5LWSPQBnJgjtm8bJKIs9l7rP9d0cffDvG6U
	 unD0dN4vrHOxpJWYaIcjqgwer1uT1PoWcFIjHgtpPDbmdO58j5VJKC33Rwd2a2WDxmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866731;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YnYl0grphqtCTW16mbqB5OZ7Ar0uK9ejWodFsFluXmA=;
	b=hXrav/+yv4Byk+nEZ3V7ENm6oBqIIS9V/7/X2cImBpiD/oTLfB3ctzXowkbTo0M1z0PP
	 nskkQIYInjG0iDCkKvmZKOO3ZcXb3s0DpjaY6KaS/2/3aoKBDmHG+NEu43MHUWRxU3mZ/
	 B5uziD0iogpF07VK/9GWEEuKe0qJIrmi+23ofxnN+M7mejIjHhDHpXvzAdMC8QyRKUkES
	 D4be3PbnVVqyvJ6DT+7ReAYbTvUSq0UPfnhHPP1EQ3QrbDmb2SKfJOSX1GvXrZbbxApLf
	 FFqjUu9+MoI8JEJCWUSmItPwsgD2Amdgfhfj4X7YBNeqxa1RO1Nqise8mer/xcx0LTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="cOs2Z/H3";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VXUc3kFo;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D4606A330
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D4D4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cOs2Z/H3;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VXUc3kFo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793866730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnYl0grphqtCTW16mbqB5OZ7Ar0uK9ejWodFsFluXmA=;
	b=cOs2Z/H3fyglf48BU0THLdP2KnSdCqAFRgw/QMUR2e/5k5FXZ2YJAKG3F6lRcVbviNFW/O
	CSTFlBRkODuDbbwX2wfgUk4CzBC5OZ08fxypB8FCgI+09azSiPKx0vUw1oyDpxDVIOLD07
	iFt31ptmICj9BCexWB1sMOl6PXvn9ag=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-uO8F4psCP4CYBGHeOtuP8w-1; Thu, 05 Nov 2026 03:18:49 -0500
X-MC-Unique: uO8F4psCP4CYBGHeOtuP8w-1
X-Mimecast-MFC-AGG-ID: uO8F4psCP4CYBGHeOtuP8w_1793866728
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4ae58bf15d0so3359775e9.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793866728; x=1794471528; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YnYl0grphqtCTW16mbqB5OZ7Ar0uK9ejWodFsFluXmA=;
        b=VXUc3kFoMMeDYPETcfw19wRE+EWWz8eBSRt+/1At2n2kYjlAnIcuW2KoBloTbNx4bW
         no1b0wK8jaF1vhMt7wTXnWECw0VrTCmwc46AC4CJiVFV6SBiWcRdYTdFBP2kOWs8/Pe3
         0JHy4hMRKGrVnhDCkJZjP71VLYoK8+KheV4TydAwUguHpq4DBNyIzZe3m5k9ZdHd6yxC
         l9oaCBeUVFshJCmMq905F4797DBql1+OJsvHoqwQQk9gSQuLH40D3LWY6ZKzw8yWC3vL
         pVwXN6c1463YriA6C5ht40mbZbf4vUU/aNnvm28Kn/vhHW5Xbr+FXemRtDB4boW2RVQB
         ofvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866728; x=1794471528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YnYl0grphqtCTW16mbqB5OZ7Ar0uK9ejWodFsFluXmA=;
        b=oWDlVfsQ5IbXIkbxCUvFQJD02W2pC0p5viy7whcWHw+FLKK/oFFiNs8KHaVpHySj8V
         ubDyK2QB26b9UyZWOYntIjLdujYOeUYWJDNZinz/cIkSDk8LZejmHw9LubLPeu3re/Yr
         3Yzbpf9cAZMW29rhbYPWnmO/EExXzWsGbOshxKR7q1OoqsRwJt3vE3HH3CAf2h2wPGS3
         3IxvEfQelPRuti6KYN8ph4HKYa6H1SsFPFRujoDRnk+4SlkIDTc6+5A/DF49HGcmvMug
         zmodfRBt9mu7ixy8NLGc5/1ZhHVysjn/Qg/APRuof74z67ksA7nj6BhMD7zthV+zLBiy
         Gfdg==
X-Forwarded-Encrypted: i=1; AKwUvBzZAiHCJQ/nG0+le5VVkweY7LnoV4r7jvhS83rk6lzg1JGmz0UawogOn3x/UqHs7dVP2BhvHyM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RPGj4f9XTd0WxZKd3W+8KFSas5JcoZP8F2kl7eQq45T1JnYLd
	vE+dAjKH2JkfjZSe1JLjSBs/HOktkAeHfMd5vMJSZ1OEJpVSkr+6yEVnXcqe73VbE4hSx/rYbkA
	2V/v52S6YGpxLO2p8CpMEPwCYaI1wa0YnPZEkBgPuQxbrJYsttpDK58RU8w==
X-Gm-Gg: AYBFou0qGgUCI/B2MSTd20dcR7cM7k0kDSghPjywWCEHRIZBe6AhPzeU1Yl+GlCPeRu
	vl/NY4vHk8/2lBr2GXYq33LF+NWbPG90u83XVfbQI2UXBty5BkALvy/OdNTshTLHlTkxdsOU9zr
	0dBtMlgutkJGTHFqIEvufF3/Oc0+D3cMdE0AlLwQ3y4P2nq60ATCZuce2WbAp/qJsx6KI9psED0
	f/LKvRKIo7qlPj/BYTYv5uSLFfs6N6D5LjFh5AEll39Lh1nfarSXRzPzCU3hJdQTZezhvGTiIc+
	VQL7ChVxUVgk02zB6YYynwzJTBLKQkEIfGap8T8qE3SVjDoJvrBYrn6KXW7ZEtG74fqwP1wJxe8
	86Fzrkh9IajWviXfKrCja+Smg6iTkhF5PNxb777tbeB8s7GYDWceF2ed+xnY1ihlGAYv5T56gPa
	SYulBqvHhqCaMRlw==
X-Received: by 2002:a05:6000:2587:b0:48e:5ad1:5e77 with SMTP id ffacd0b85a97d-48e6e261607mr37451516f8f.0.1793866727921;
        Thu, 05 Nov 2026 00:18:47 -0800 (PST)
X-Received: by 2002:a05:6000:2587:b0:48e:5ad1:5e77 with SMTP id ffacd0b85a97d-48e6e261607mr37451467f8f.0.1793866727444;
        Thu, 05 Nov 2026 00:18:47 -0800 (PST)
Received: from localhost (119.red-83-42-172.dynamicip.rima-tde.net. [83.42.172.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda203b6sm8437363f8f.48.2026.11.05.00.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:18:46 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Thu, 05 Nov 2026 09:18:34 +0100
Subject: [PATCH v3 3/3] clocksource/drivers/nxp-stm: Arm the compare
 channel from the state callbacks
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
Message-Id: <20261105-nxp-stm-fixes-v3-3-8129b912e74b@redhat.com>
References: <20261105-nxp-stm-fixes-v3-0-8129b912e74b@redhat.com>
In-Reply-To: <20261105-nxp-stm-fixes-v3-0-8129b912e74b@redhat.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rt-devel@lists.linux.dev, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, stable@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793866718; l=4847;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=gKd+ISmeFZF91zn4FW3sChMabdau9YNhi9yQ9k+mIyE=;
 b=vyi+xrok9WUJjuZ1aq0y/R2QRzxzfZKBFUfjS/ufrPzTsHkchLnh3UsYDssaTGvwk2ad1KIFl
 fqgaUxkZlyaBuKQMQv+qtIzSGIyZOpwerNeuoyWlgaPGdY7D7wfZzk0
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=

set_next_event() disables the compare channel, programs the comparator
and enables the channel again after the overshoot check. The trailing
channel-enable write is a posted write landing after the check: if the
counter passes the programmed value before the enable takes effect, the
match is missed. No min_delta can close that window.

Keep the channel armed for the whole ONESHOT operation instead, and
manage it from the state callbacks, like the HPET driver does:

  - set_state_oneshot() and set_state_periodic() enable the channel;
    a stale pending interrupt flag is cleared before enabling.
    set_state_oneshot_stopped() and set_state_shutdown() disable it.

  - set_next_event() now only writes the comparator, covered by the
    overshoot check.

  - The interrupt handler reprograms the comparator only in periodic
    mode; in ONESHOT mode the stale value stays armed until the core
    programs a new event or stops the channel.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/clocksource/timer-nxp-stm.c | 52 +++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index 81527745b7e2..8ad99863bdff 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -254,14 +254,27 @@ static int nxp_stm_clockevent_shutdown(struct clock_event_device *ced)
 	return 0;
 }
 
+static int nxp_stm_clockevent_set_oneshot(struct clock_event_device *ced)
+{
+	struct stm_timer *stm_timer = ced_to_stm(ced);
+
+	/*
+	 * Clear a stale interrupt flag so that enabling the channel
+	 * cannot fire an event from a previous match.
+	 */
+	writel(STM_CIR_CIF, STM_CIR0(stm_timer->base));
+
+	nxp_stm_clockevent_enable(stm_timer);
+
+	return 0;
+}
+
 static int nxp_stm_clockevent_set_next_event(unsigned long delta, struct clock_event_device *ced)
 {
 	struct stm_timer *stm_timer = ced_to_stm(ced);
 	u32 val;
 	s32 res;
 
-	nxp_stm_clockevent_disable(stm_timer);
-
 	stm_timer->delta = delta;
 
 	val = nxp_stm_clockevent_read_counter(stm_timer) + delta;
@@ -288,18 +301,16 @@ static int nxp_stm_clockevent_set_next_event(unsigned long delta, struct clock_e
 	 */
 	res = (s32)(val - nxp_stm_clockevent_read_counter(stm_timer));
 
-	if (res < STM_MIN_CYCLES)
-		return -ETIME;
-
-	nxp_stm_clockevent_enable(stm_timer);
-
-	return 0;
+	return res < STM_MIN_CYCLES ? -ETIME : 0;
 }
 
 static int nxp_stm_clockevent_set_periodic(struct clock_event_device *ced)
 {
 	struct stm_timer *stm_timer = ced_to_stm(ced);
 
+	writel(STM_CIR_CIF, STM_CIR0(stm_timer->base));
+	nxp_stm_clockevent_enable(stm_timer);
+
 	return nxp_stm_clockevent_set_next_event(stm_timer->rate, ced);
 }
 
@@ -327,6 +338,8 @@ static int nxp_stm_clockevent_per_cpu_init(struct device *dev, struct stm_timer
 	stm_timer->ced.name = name;
 	stm_timer->ced.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	stm_timer->ced.set_state_shutdown = nxp_stm_clockevent_shutdown;
+	stm_timer->ced.set_state_oneshot = nxp_stm_clockevent_set_oneshot;
+	stm_timer->ced.set_state_oneshot_stopped = nxp_stm_clockevent_shutdown;
 	stm_timer->ced.set_state_periodic = nxp_stm_clockevent_set_periodic;
 	stm_timer->ced.set_next_event = nxp_stm_clockevent_set_next_event;
 	stm_timer->ced.suspend = nxp_stm_clockevent_suspend;
@@ -384,19 +397,18 @@ static irqreturn_t nxp_stm_module_interrupt(int irq, void *dev_id)
 	writel(STM_CIR_CIF, STM_CIR0(stm_timer->base));
 
 	/*
-	 * Update STM_CMP value using the counter value
+	 * The STM hardware has no periodic mode: the comparator stays
+	 * armed after a match, so periodic mode is emulated by
+	 * reprogramming the comparator here. In ONESHOT mode the stale
+	 * comparator value stays armed instead; the clockevents core
+	 * either programs a new event or stops the channel long before
+	 * the counter can wrap around to the stale value (~32.2s at
+	 * 133 MHz).
 	 */
-	val = nxp_stm_clockevent_read_counter(stm_timer) + stm_timer->delta;
-
-	writel(val, STM_CMP0(stm_timer->base));
-
-	/*
-	 * stm hardware doesn't support oneshot, it will generate an
-	 * interrupt and start the counter again so software needs to
-	 * disable the timer to stop the counter loop in ONESHOT mode.
-	 */
-	if (likely(clockevent_state_oneshot(ced)))
-		nxp_stm_clockevent_disable(stm_timer);
+	if (clockevent_state_periodic(ced)) {
+		val = nxp_stm_clockevent_read_counter(stm_timer) + stm_timer->delta;
+		writel(val, STM_CMP0(stm_timer->base));
+	}
 
 	ced->event_handler(ced);
 

-- 
2.56.0

