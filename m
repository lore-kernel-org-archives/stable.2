Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8FA4EA380
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664437; cv=none; b=HKZuESdDrOLiU2+nlRO8oMIlox3b99malCDOO9c9pLZSQYQJSPRpIoQNtkJLjpHnzg4qXiROPoqdkPSnNn1d+r0XOaAxmMO1/+8HyiF2iZpCtrpBPsnEZ7C0HxEjgsJ/ydwJD9Kj7bD9A9/j+JBpF9DJj05cqdBteCMzmtaRngU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664437; c=relaxed/simple;
	bh=ib0CNFQufn4my8Vyf+W/y4OXO+w3b223ucJng6X1yAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNiSwf/OmW5P8bjM2d+jW1IFYAOsIwJ8PIJyCe78KPAt5Ozcakdkp4h51zwIdE4MskPc7fpOs9RrKwWhq0KTXRq06/aeAmvzLNu2uFp0ejJ9gdNx8N+ZA7FOPF8Bdx8BQ+AWhQJtk1DNa4qaZBtCABE8RhpGccp2FtzXBWYXlPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI1f2afy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI1f2afy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6571F00893;
	Fri,  5 Jun 2026 13:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780664436;
	bh=B3SRHOxgaPupQlnmfP2lfe6SOdD8mSsQVdW0Jw+Rzqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RI1f2afyFrLvApDTYUuEPclWtHVrNgDLbdmlF4OhHDbZjKRO6h3B7OnPl/KJ5jSc+
	 6xgth81vLYmeYqknK3NHKzK+eWMI+ZYFFiOjNc/6VnniinEXv4rC1hmZ2gdoNfGGrC
	 Ii6css3tvHYBepIRzmgXHcx6dRjqOCqdD7z2pC9MBKp8gkzuUvxyEMZWXHfPtoog4p
	 dLJmOHnSTOwo5yQdQ9KgGJHVLkwOAMiooreUkBfBaEkGL6N3yuaRSRC6V+7I5S6p1h
	 YEJJcVcpwWg9qkdNsKxDKFZephBjqpzNcBtGFztS5w9xhsuBhT37yuTTnYSQSCFJSl
	 5ef5PvyR2MntQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: firewire-motu: Protect register DSP event queue positions
Date: Fri,  5 Jun 2026 09:00:33 -0400
Message-ID: <20260605130033.370944-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060437-throttle-colossal-060d@gregkh>
References: <2026060437-throttle-colossal-060d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit 98fb1c1bb11e29eb609b7200a25e136e05aa4498 ]

The register DSP event queue is updated under parser->lock, but
snd_motu_register_dsp_message_parser_count_event() reads pull_pos and
push_pos without the lock.
snd_motu_register_dsp_message_parser_copy_event() also reads both queue
positions before taking the lock.

Protect these accesses with parser->lock as well. This keeps the hwdep
poll/read path consistent with the producer side and with the cached
meter/parameter accessors.

Fixes: 634ec0b2906e ("ALSA: firewire-motu: notify event for parameter change in register DSP model")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260521-alsa-firewire-motu-event-locking-v1-1-708e1c2b5e56@gmail.com
[ converted copy_event() from manual spin_lock_irqsave/spin_unlock_irqrestore to guard(spinlock_irqsave) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../motu/motu-register-dsp-message-parser.c        | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/motu/motu-register-dsp-message-parser.c b/sound/firewire/motu/motu-register-dsp-message-parser.c
index 0c587567540f22..8c1a3759c94c28 100644
--- a/sound/firewire/motu/motu-register-dsp-message-parser.c
+++ b/sound/firewire/motu/motu-register-dsp-message-parser.c
@@ -390,6 +390,8 @@ unsigned int snd_motu_register_dsp_message_parser_count_event(struct snd_motu *m
 {
 	struct msg_parser *parser = motu->message_parser;
 
+	guard(spinlock_irqsave)(&parser->lock);
+
 	if (parser->pull_pos > parser->push_pos)
 		return EVENT_QUEUE_SIZE - parser->pull_pos + parser->push_pos;
 	else
@@ -399,14 +401,14 @@ unsigned int snd_motu_register_dsp_message_parser_count_event(struct snd_motu *m
 bool snd_motu_register_dsp_message_parser_copy_event(struct snd_motu *motu, u32 *event)
 {
 	struct msg_parser *parser = motu->message_parser;
-	unsigned int pos = parser->pull_pos;
-	unsigned long flags;
+	unsigned int pos;
 
-	if (pos == parser->push_pos)
-		return false;
+	guard(spinlock_irqsave)(&parser->lock);
 
-	spin_lock_irqsave(&parser->lock, flags);
+	if (parser->pull_pos == parser->push_pos)
+		return false;
 
+	pos = parser->pull_pos;
 	*event = parser->event_queue[pos];
 
 	++pos;
@@ -414,7 +416,5 @@ bool snd_motu_register_dsp_message_parser_copy_event(struct snd_motu *motu, u32
 		pos = 0;
 	parser->pull_pos = pos;
 
-	spin_unlock_irqrestore(&parser->lock, flags);
-
 	return true;
 }
-- 
2.53.0

