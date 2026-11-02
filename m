Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793585582;
	b=XKx5RUYQs8+amGpLSxU62oDyWwhbfEt5uA8dIvPevYUngXmyY0jMTz+gODoLI3XiwG6X
	 1NcBqXTav7eIrVl+vDU5hARB67It2x48fmC5sBk16PJf89tNZJIxbaMRLRt9Fpd9ediwI
	 elsmiFIkdG5+0d2V7JrnNaoXIXO/sF1jw5DyyGsI9G0MNyAy7fef03g5Q4zzCZ5s+Qw/7
	 FWw9qla8Xf0xlB7JlmlsokxQiyy9JtYCa1Q5yTW2bwMlRI1pa+P84TBleaZyjdDwrs7iz
	 HqkhTyRCVuUmuFEsj1G6fh33BpsQwCnkxXlltrZzfDdqYoKbDoAmkOzQPA1ws9+wHsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585582;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ul3ViH0BqNtI/du99aeBML0JoH3ONvwfitZO5nZZvBk=;
	b=vfvDeBvaKFnoyRW6HHUM+RlSmk4OnE+pIN46RVfI1wAfjO/7BkM/1oo4ECiWXx0hdTIs
	 z9C47LUc2lSHwFdVvyHVezzFeeP8jqTqiOmE2dBteWO2WFlr7iGlcgBSLuO5wO1j3d3pT
	 wue0byipNeSGAvOJLPp/oA9mTIA7EMCn8rtClMgnWbN6jnguIo+Rd92wIYfImpdE1Pz3Y
	 iBsCEY4AZPLVW/sUMZWSeLbHm2plSYrOaF4O9UqlCQbLibZcVjzXRNgerZ6b3Q/ZkiNjY
	 vODpdz2BLNO+iMUHVE2/OJa6+5Hf8K75y4wNWC6LwAcN5Od+dxe8V5W2EWv+W1JLHIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HthlXF42;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9A960A2609;
	Mon,  2 Nov 2026 02:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HthlXF42
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793585582;
	b=Z9AO+v+NBhuH3jaXqsP+cYiXXxf0zYbKWOwbwSN+SjWWAc3FY1/5KTpAr1th7ASJN1PY
	 ZUc9gSRQrbVO7xQ1ePnRv0+J7iviLuD5KKTugNzfrMpUUnXAMsJXEevuWaBBfdKRyy0OU
	 IBemwfXHZpQDFbonkzXRBHWQPSRrSTzqLQZoSVJNAgq4rZMq+qvPxJnWZtwGQQ8W3FGvT
	 GCpGmWaY9uPwuZOyfqPgN/lCfgO+T2e7H74qWkfKcBPmgCCyHMYafAgb+pUz5yjTOJrer
	 wkO5v5jd/bVl19JfTZwpGx2GKxo2SdFuQsnK0ES4pHjTxa4wP2x0oQMLzm9atlN+MKA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793585582;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ul3ViH0BqNtI/du99aeBML0JoH3ONvwfitZO5nZZvBk=;
	b=Hjbr+cKzndGVkCC0j5y3brfC79Qzcr9d/EG/hvWCoacDYvsN/wNjbFMuXU8uGDOVoOKF
	 sLFru0bhJfM38n+31dxm5IbazCJfZ4zM8rriSWGe/hHJWwAtvlYZ+ygj1ZAiEtoLUCkAv
	 66Hp6lVIYG25jqMJjXLH3MLlZJL99xD3ibyMBWfplo1zQpn2QWD0eQVcle2tNKeEZ2HgX
	 zrOp4xKSAVQ3Cs4om20Lo6N/8j2LW625PFoCJHWXnkauFVIP41UD3/QYofjfxC+i7s0D1
	 brj5XzURFH03aW2CwC76dgrtn8Isy/PwV5FBCRH66+9JxkNNdzlu6jk0eTANHVHfgBQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 67F041F00A1E;
	Mon,  2 Nov 2026 02:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585582;
	bh=Ul3ViH0BqNtI/du99aeBML0JoH3ONvwfitZO5nZZvBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HthlXF42YcLa6zkr1IP1NaPpWg18gIp3uKrWdkxwLoGeUrVcXG7Tjs/iAVwaSUY0s
	 g5oOqCD7NIRaO76xDSRQ+0ipD9YRd3AeFuBqHCvNvholLJ+UVhA6YUe1e4mXdewib1
	 SuPjmZE+p3ArAwLdpYqmzwoGswvQAFqwqOVqiU8ND8KIgCLWwn0w3n+BDLAitSVN0H
	 ldaG3Wt9/EHd03Sjxsrsf7wx2zki0l/GRey+bMU9/RnDvaxhS7ZtOIA1hwEpeBsXpA
	 csgzgnFUYvStxnBrTyCE4YkwHwJYldBVr4uJ4Gl9U7+Zcm9/xE0kfS1NRhmQYftSO2
	 k+zjgaNysw0vQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CA78646309;
	Mon,  2 Nov 2026 02:13:00 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Sun, 01 Nov 2026 21:12:25 -0500
Subject: [PATCH 01/10] leds: rgb: ktd202x: Fix the flash period of short
 blinks on 32 bit
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
Message-Id: <20261101-ktd202x-et6326-v1-1-eb51eddad08c@telaak.dev>
References: <20261101-ktd202x-et6326-v1-0-eb51eddad08c@telaak.dev>
In-Reply-To: <20261101-ktd202x-et6326-v1-0-eb51eddad08c@telaak.dev>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, stable@vger.kernel.org, 
 Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793585579; l=1672;
 i=joseph@telaak.dev; s=20261102; h=from:subject:message-id;
 bh=hrB15O/zuKtRubiFTS3YHvdWnoAX4L1NgES4v7in3Vc=;
 b=k5X9Zd7ZY2jupGWKd00Eyp/g/9gjsAZW6C68IV7jEv+S6BKf2KV4Wx+2faFWLbu3HI5jcjSGo
 XwBT66/87l+DbF7G20RKOm+IxPlgDC8RrpNbLVtTt+8/FIVgYNxeZTN
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=OmwSusdK4grZpiuZVfCZAvYyqz9FBkNemsV1EnHyVr4=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261102 with
 auth_id=1382
X-Original-From: Joseph Telaak <joseph@telaak.dev>
Reply-To: joseph@telaak.dev
Content-Transfer-Encoding: 7bit

From: Joseph Telaak <joseph@telaak.dev>

When delay_on + delay_off is below 256 ms, the unsigned subtraction of
KTD202X_FLASH_PERIOD_MIN_MS wraps. On 64 bit the result truncates to -1
or -2 and gets clamped to the shortest period, but on 32 bit it
truncates to 33554431 or 33554430 and gets clamped to the longest one,
so asking for a fast blink gives a blink every 16 seconds.

Compare before subtracting.

Fixes: 0ebdb7210943 ("leds: Add ktd202x driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/leds/rgb/leds-ktd202x.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index 143020945..539cf425c 100644
--- a/drivers/leds/rgb/leds-ktd202x.c
+++ b/drivers/leds/rgb/leds-ktd202x.c
@@ -296,9 +296,13 @@ static int ktd202x_blink_set(struct ktd202x_led *led, unsigned long *delay_on,
 	/* Convert into values the HW will understand. */
 
 	/* Integer representation of time of flash period */
-	num_steps = (*delay_on + *delay_off - KTD202X_FLASH_PERIOD_MIN_MS) /
-		    KTD202X_FLASH_PERIOD_STEP_MS;
-	num_steps = clamp(num_steps, 0, KTD202X_FLASH_PERIOD_MAX_STEPS);
+	delay_total_ms = *delay_on + *delay_off;
+	if (delay_total_ms < KTD202X_FLASH_PERIOD_MIN_MS)
+		num_steps = 0;
+	else
+		num_steps = min_t(unsigned long, KTD202X_FLASH_PERIOD_MAX_STEPS,
+				  (delay_total_ms - KTD202X_FLASH_PERIOD_MIN_MS) /
+				  KTD202X_FLASH_PERIOD_STEP_MS);
 
 	/* Integer representation of percentage of LED ON time */
 	on = (*delay_on * KTD202X_FLASH_ON_MAX) / (*delay_on + *delay_off);

-- 
Git-155)


