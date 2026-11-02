Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654207;
	b=OwbMqn3KmaBM21jsA5xhS3quxViJo0ueq+xy2zb0Ech1n9RCgb87E569F1FD55eEzCoN
	 XnA+iIF+vBLXLvk+rH6jo7AvP0zvXNRVxNwi5Sh0Lbzmpl7caBZrAEjpbJlnaexadI+gj
	 mawGLernkuZQKHTQDn4yNaFBbyLFmBKKbCCUSvYda//9M3QmVeaCBLD+3NsEZi485jkFN
	 teIRyHTXV9sNHmWCN35KhPIda6fvDKKTUpXrdGlbekaIkJwZD54xkc0VN/9zlm8J4yFW9
	 F+jKXNzlhOdZ5KVOlvLl6sgAKuquy5YqSG+CxIDunA7VvmygdI13b9A04pwsAJF18hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654207;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2RjoLq/kIZomTqqU6zUcn3juKCDy3taGhnxzS/BtlV4=;
	b=NpQXsGuwNhxLOvfkoG5gSoXb8OqBb0aE//RUYbDvEJMbBKTrfjidaI1SmVf30i4qI4CH
	 kImM0/sH0RHUqtU+ogxnl6QecpSqt+KU50uk0ZgzlF1EBUthYDJponED+lf48/10HO/Y/
	 N/c2EZjeg2XAalcrSmG4yBJ3owmeBUXP49Vr21WASrBf29ip7+0kNUc/BONU6LxkltaPK
	 u5BJUuzLP+vmqCkItJUvVJkocptXEyQnY0fDgA+F16SsXv4t/d4YY+m2dyd1GrtmibCYr
	 WaRapsqBVuEUk3BHT/xpx4HfVQGKOk7Xt7BSrwaESfLLeXUk5uETc1KWUKBo9tOHt2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gg9769gY;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EIqSUpo3;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B4606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 21:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 420B4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gg9769gY;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EIqSUpo3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793654206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RjoLq/kIZomTqqU6zUcn3juKCDy3taGhnxzS/BtlV4=;
	b=Gg9769gYPVQqkjk9w1E8zjBpKRpmpaeia/uvVEUXm4Vs9bMxxNO5g9AZ0NvXa5SYbMlpAm
	wnGZ9Ia0g2AVwW6ythzynzExqjJjNU+qMu+7njpfC0iLAXQLuMWMOaMnBVxgs7WcCj1drO
	aC+27Fi+kBpRJLx+OE9Z9BWhMpRY8sg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-E2XR9_0xMfa_y2-NAtaMCg-1; Mon, 02 Nov 2026 16:16:44 -0500
X-MC-Unique: E2XR9_0xMfa_y2-NAtaMCg-1
X-Mimecast-MFC-AGG-ID: E2XR9_0xMfa_y2-NAtaMCg_1793654204
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a78eb3aa35so5343475e9.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 13:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793654203; x=1794259003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2RjoLq/kIZomTqqU6zUcn3juKCDy3taGhnxzS/BtlV4=;
        b=EIqSUpo3bGUNhYdqSuMweuX3d20XNVRfrkUXdjTXRVYrcqpvxriNITr76mUCiUbq5R
         fotdVenjGtQURIFIDpayJekqk+OkG/p+kYqinovDYp2ATzx04F3PGYqVmaOCjF4a5bIy
         hefvb6hFbcA1kRdZZx7SvajWsQLtifCXBEg83tEdBw9Bws/7P7GPlSySh8rt4slGamoQ
         NNAKb0R+gdQH94geb8N/eKIlr8Emmu4djdlfea6YdD/PI+4030OGCeZy/0QMEuUMCJkl
         MG3jaUyldwvoHL4SPvHgggqhLiWW8Oh1UbOZYuO5QaZHotqu0u8atrjEbiaHw9nxQPOw
         T5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793654203; x=1794259003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2RjoLq/kIZomTqqU6zUcn3juKCDy3taGhnxzS/BtlV4=;
        b=jbb9KNn0YC4etTfEdC0Um6MBpxDUZPST9W6z0/3kFgrnXblyS4E6b3HHDSTlxGhlly
         6bp7hXJ6aICHzskrAM3/LmWFG4wmd2aXVn4+JRqLhMBrQZ2PKemIDKt6DteVLqYGalPs
         0JpfnDIgnbXnSzSyHCYjNWYqta22R2DjZz/aFESPn7HjRqsVpTm4onG++nGr6pAhNguE
         KUH5/4D7qJvBrFpIG6d11mk5WC7yHoRilwrA1HtfnbzJgu+Li1Z7DUUHaAOAVOIPZg94
         g3l7NChGLlpq9insUwNmiBobBuTW/GVbftH94DeP6LRTI12alini3JikYB9MRONyOeYG
         HhyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwULoVEijUms4AN4pkFuqT6fryuVWdFFwcdl6Uf4DFhYBVmW8JrhsIZasF7w3Zz3CXEbmm9hS0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHPPANGN+16ZPRylqicho34GyjPUBhU8cJpudEJEL90Dy5iy2p
	Vppqwq6Z4brUb1XqVHBOG5B4du4s1LQfmC/MECPiaJLxD3Dplxm96HaoWWDcJqAZ8NiOpgg5mKe
	154nAUc3LncabzQDDX1iAxK2RmIKxXg8dSAblj9rZsbv8Ei2ZYWQmslyBcg==
X-Gm-Gg: AYBFou3AbnoerFJyZ9d2aXvReJRhfIwfmSQHZXS11lfHJ3dWYZPPsCaaFdIe225g3nd
	twZnw8j/pkLQglnNwaWV1FRjBUqmvSJC0XAVpUc1EIgDpBr/+dQ4riFGFbdDMNbyKNLmq0I4ds8
	ERy3BG1QkuUS4a77pvYtay9pZioEOmx8jACIZkQKaR+ms6gyPRpOnj7i/baFwPO5p4OvlgavIxA
	9OSkZUlRir21OmCkLrBdRIj6Zvz9N8it7u5LFSGwcYmXwtbhTly3bcFys6MO/8f+htq7NVlFPLr
	AG3rPR5y9UVWZ+GTBSm39qlbkNkLxUQKA3/aZJqU8N9OW9QFbOkstg1IwETV+GHA6fOaCzhXg59
	ILNy0l1cGDhD4YzzyzvxJFfBeM4+jKggi2GWCQFoUYY8WY0w69nvo7wmNwZaxY7yUJkASXSvVMT
	dKF0WiZdlQlMmkTg==
X-Received: by 2002:a05:600c:c08c:b0:4a2:1a:a115 with SMTP id 5b1f17b1804b1-4ac1209f120mr218821555e9.0.1793654203536;
        Mon, 02 Nov 2026 13:16:43 -0800 (PST)
X-Received: by 2002:a05:600c:c08c:b0:4a2:1a:a115 with SMTP id 5b1f17b1804b1-4ac1209f120mr218821095e9.0.1793654203128;
        Mon, 02 Nov 2026 13:16:43 -0800 (PST)
Received: from localhost (119.red-83-42-172.dynamicip.rima-tde.net. [83.42.172.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab00ff3dsm24999655e9.14.2026.11.02.13.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:16:42 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Mon, 02 Nov 2026 22:16:22 +0100
Subject: [PATCH v2 3/3] clocksource/drivers/nxp-stm: Increase min_delta to
 20us for PREEMPT_RT
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
Message-Id: <20261102-nxp-stm-fixes-v2-3-8ca2706f30ef@redhat.com>
References: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com>
In-Reply-To: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, stable@vger.kernel.org, 
 Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793654192; l=1953;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=9U7e/e2EyDS47BqXM0Wq4E/IVIq+iDMzJy9Mz8G/8z0=;
 b=I3diUql5Q6GbqX8veSUe45rbF94jf6KgRxB2o4ixEqSLRhaEof0uU+OQxrTWrQXV/bTJ4ErDo
 +5AE3K8aDZ7CcqtoXD4Mb0PjXDAxuRMGD18t/k2lWRpFU20e7nZ+1KK
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=

Under heavy bus contention on PREEMPT_RT kernels, a 2us min_delta is too
tight and causes ~32-second timer soft lockups.

Increase min_delta from 2us to 20us (~2,660 cycles at 133 MHz). This
provides sufficient margin under severe bus contention to ensure the
channel-enable write completes well before the counter reaches the match
value, resolving the 32-second soft lockup.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")

Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/clocksource/timer-nxp-stm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index ed7662a4e2bc..a1a0e23d3342 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -335,14 +335,18 @@ static int nxp_stm_clockevent_starting_cpu(unsigned int cpu)
 	/*
 	 * The timings measurement show reading the counter register
 	 * and writing to the comparator register takes as a maximum
-	 * value 1100 ns at 133MHz rate frequency. The timer must be
-	 * set above this value and to be secure we set the minimum
-	 * value equal to 2000ns, so 2us.
+	 * value 1100 ns at 133MHz rate frequency. However, under heavy
+	 * bus contention on PREEMPT_RT, 2us is too tight and can allow
+	 * the counter to pass the match value before the channel-enable
+	 * write takes effect, leading to 32s wraparounds.
 	 *
-	 * minimum ticks = (rate / MICRO) * 2
+	 * Increase to 20us to guarantee the comparator channel is fully
+	 * enabled before the match value is reached.
+	 *
+	 * minimum ticks = (rate / MICRO) * 20
 	 */
 	clockevents_config_and_register(&stm_timer->ced, stm_timer->rate,
-					(stm_timer->rate / MICRO) * 2, 0x7FFFFFFFU);
+					(stm_timer->rate / MICRO) * 20, 0x7FFFFFFFU);
 
 	return 0;
 }

-- 
2.56.0

