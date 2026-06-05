Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827CD277C9D
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 00:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621162; cv=none; b=VUdt9uIPDiRd+qTAiPa5niCb8CtOkBo9eXNqzFZa1SvOWobRX05/331R6YR/KAl90UTHP0qRVVCNyFJU6CjR8e5K1/3IVyeynHWH02TMAnGCk6TFZgs2s7q9Lekj5CX9nWdz8hQz6d+64gy0krOI2GeIk4cyCa5hqpynS07Rks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621162; c=relaxed/simple;
	bh=FPtpuHA9u7qJg42Dd31A4iJduMxWGP9qZmd+50RZ0kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSAGtJc6zIsmDoLoxcTDtdq6edsN4guvLRDOqtTb1s2tL+pVdzw5JqhNJirf6LsXkMGlB4jAPuIDKzgRer/yo9z9FbOPYPnItALAv5K9medOrCmFrBiTaN5B+Fy9+HU6dy6GU79WdF4ZQjGkaZMpGx+aYjRAi5E6PBsUb9FGaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3vk6yuA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3vk6yuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2BA1F00893;
	Fri,  5 Jun 2026 00:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780621145;
	bh=Hgmp+5QsQzeFA4umCjMnwzAkl20i6Uwe7GqXW+1EOpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K3vk6yuAJzKm+YVwqP5Svh4R2/vmrjwrYEZSbv5mF3T1A1zZz8Lhw+o71qSa+5zyQ
	 bJmBSBNCHxDHvXSg1oA26sIqz+4MPMYaL3Zvey8ZMeLxIH7/IX5iCgYF7bhxY0WHj5
	 zZqXMPuyiIVWQlYi5bC1TWoQyPfvO41bC2/fy7E+wfjDZnN6mgqQnAvDe0gpnybDYO
	 eDb92EikZit2PNitMQXcH9p/MUo+cZJva19iH9QdAgvGiuntzSoTNr/Xj06leFuQho
	 2tv0lPNpgmJto+V19C7C1yF/6xd6zsFiqpjVfGuru9swnzPBOQ3P/E8IdgTbvnShAS
	 EB4kGM85XWBSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: firewire-motu: Protect register DSP event queue positions
Date: Thu,  4 Jun 2026 20:59:03 -0400
Message-ID: <20260605005903.2802313-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060436-lumpish-nemeses-2d25@gregkh>
References: <2026060436-lumpish-nemeses-2d25@gregkh>
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
index ef3b0b0f0dab9a..abafae59f365ba 100644
--- a/sound/firewire/motu/motu-register-dsp-message-parser.c
+++ b/sound/firewire/motu/motu-register-dsp-message-parser.c
@@ -393,6 +393,8 @@ unsigned int snd_motu_register_dsp_message_parser_count_event(struct snd_motu *m
 {
 	struct msg_parser *parser = motu->message_parser;
 
+	guard(spinlock_irqsave)(&parser->lock);
+
 	if (parser->pull_pos > parser->push_pos)
 		return EVENT_QUEUE_SIZE - parser->pull_pos + parser->push_pos;
 	else
@@ -402,14 +404,14 @@ unsigned int snd_motu_register_dsp_message_parser_count_event(struct snd_motu *m
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
@@ -417,7 +419,5 @@ bool snd_motu_register_dsp_message_parser_copy_event(struct snd_motu *motu, u32
 		pos = 0;
 	parser->pull_pos = pos;
 
-	spin_unlock_irqrestore(&parser->lock, flags);
-
 	return true;
 }
-- 
2.53.0

