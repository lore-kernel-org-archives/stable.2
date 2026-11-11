Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417182;
	b=Mfm1NqNjqFidGaNWZbG0oAU3rFtBKuJQRa0JjIASVuWRpR71rDgPXyPVT6Nbww5m5kz/
	 a+J3FrUbQU9gGCaxcNRLql87qA2FA5Y8UmCmCsiPZ4a1que+jD65Zo47Q4K36/aE5uovt
	 2vBw82DS2bEcrfCZMNgybR2Yij6R8piTh533JLJM8nse4Fmu0gZwkKN0PLqZjg3ubrKOD
	 slZfAc61Q94ADmdW5ZsqBzX11LPHtxvU79s3DYHbuW3hxtbeEqRNQOmpgtRZbK35KmAe5
	 Cp6bf+rgHFIpINahXeY0KGtA6fMM80VYIitKozd1zgEcnKt1G7ofGumM6iR5roED7NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417182;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rcduNwrb3xYYkPzTXorKwaW0OFQSuvbtTFNx35XCrDs=;
	b=Ctg0jpH0g5M3GSr/PaV5yYkEnt6v6Xui4LDlh7UsLOw9v3rZN6y1NXg38w3AiD2bjYGi
	 z7CDIHmRqZPqTBbfX6d9oxNrw4vlIsBkkTM1txI4pQ6sAU/ppHVteAfnjB9thfog81IOK
	 JLMZFn6jNfjiwGTZN0KjJy677HduW8JLuATWnh3q4yOzofhiC6GLJToJv/ModIHVzrInm
	 JwCY9DU2H3lnFvp4WDp+p9nb77rR4PNlQpEEA/K/R7dNnDQzTuI+C2tpfommWCrLMUJnx
	 XQAX4U3U9cL7/C1ufuMategRrCCOtW/IB0eLbF81TCSiDm5rle9FG47tlO5iOgnl3Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=am4+1YZd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4088E606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=am4+1YZd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1AA1F00A05;
	Wed, 11 Nov 2026 17:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417182;
	bh=rcduNwrb3xYYkPzTXorKwaW0OFQSuvbtTFNx35XCrDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=am4+1YZd0SIkoTa80QNCP0dJYy4gs8hfKi7aGbxpQMF98HJzNC6VRqkdTTHoHT6ab
	 DVJsG26vfydkMa9QHlWTGoUQ5HFB1WwTwzpOGKW9hp0hspa2F4aOJ+0CAaP+bLhio1
	 i4nlOAyHj4VFmbuGTOOjnHcu4cbQoirg08XgRUO+Zkbjs7u383q8VZsFu2T1iwV48M
	 Qsmq1GbU6a/4ACimp3DYn5jn0vuKVgeniquMp3NGQXhSaxL6ZCylAdC3ZFt5TP3cPq
	 JfQHiIB3Jw7SHAuiCYUAg3M2S5vF0ufQVjOy9OS3hUosb2rTCv4NIb9SVdyJgoaHHM
	 0Tf/2CvR1RaUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Karlos Abel <kabel@voidship.net>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] Input: always accept EV_SYN in input_event()
Date: Wed, 11 Nov 2026 12:13:00 -0500
Message-ID: <20261111171231.3467772-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052409-failed-6.12-c1d13bfdb9c7@kernel.org>
References: <20261107052409-failed-6.12-c1d13bfdb9c7@kernel.org>
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

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit c1d13bfdb9c75c2885d10332174a887349eb0b51 ]

Commit 0cd587735205 ("Input: preallocate memory to hold event values")
moved allocation of dev->vals into input_allocate_device(), which caused
input core to accumulate events reported while seeding initial device
state before input_register_device().

However, because EV_SYN is only set in dev->evbit during
input_register_device() (and some drivers also overwrite dev->evbit
directly before registration), any EV_SYN/SYN_REPORT events sent before
registration were dropped by is_event_supported(), leaving those seeded
events stuck in dev->vals until the next SYN_REPORT after registration.

Always accept EV_SYN in input_event() and input_inject_event() without
checking dev->evbit so input_sync() flushes dev->vals as intended.

Reported-by: Karlos Abel <kabel@voidship.net>,
Fixes: 0cd587735205 ("Input: preallocate memory to hold event values")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Acked-by: Jiri Kosina <jkosina@suse.com>
Link: https://patch.msgid.link/asx50uz6iafsyAd5@google.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[ sashal: Adjusted context to preserve explicit spinlock and RCU calls instead of upstream scoped locking guards. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index c51858f1cdc55..05366b82f722e 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -392,7 +392,7 @@ void input_event(struct input_dev *dev,
 {
 	unsigned long flags;
 
-	if (is_event_supported(type, dev->evbit, EV_MAX)) {
+	if (type == EV_SYN || is_event_supported(type, dev->evbit, EV_MAX)) {
 
 		spin_lock_irqsave(&dev->event_lock, flags);
 		input_handle_event(dev, type, code, value);
@@ -419,7 +419,7 @@ void input_inject_event(struct input_handle *handle,
 	struct input_handle *grab;
 	unsigned long flags;
 
-	if (is_event_supported(type, dev->evbit, EV_MAX)) {
+	if (type == EV_SYN || is_event_supported(type, dev->evbit, EV_MAX)) {
 		spin_lock_irqsave(&dev->event_lock, flags);
 
 		rcu_read_lock();
-- 
2.53.0

