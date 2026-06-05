Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2290F372B51
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 01:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623078; cv=none; b=Zhrhq4F4V0YHGuQBL1JnP6rRbuTLd/qEthqTcob+htcjVB2gZgGpqPSJkMGZCRI6/J1uPq6n7Foux+blyJb73NDrk/v6FbVmIyJIqWwUUn1k287SjXab+sP9SCJzLd/j6Y3C1R113RAmZX6CfRBStXfF7FwgSZEkT0dfPFm6qXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623078; c=relaxed/simple;
	bh=FPtpuHA9u7qJg42Dd31A4iJduMxWGP9qZmd+50RZ0kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i68ESfZY1OaG/jfDaZ28XRKAGdAYLs01oAT9jcrhVie5o7b/0s39ePwWJEcQCANH0Ot8W6hzJ4TZ0UNMAG93JioxrkOxT7iYZDPpgdv1zKqcX/DGfLkybm9r8/GGFq8LkNfVXHfjPXIotyEmqFTKhDV5Z0DMP99pcWHI00l8vM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0jyMxcZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0jyMxcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348911F00893;
	Fri,  5 Jun 2026 01:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623069;
	bh=Hgmp+5QsQzeFA4umCjMnwzAkl20i6Uwe7GqXW+1EOpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h0jyMxcZ8WhETTV+xzEuh9YrYN0D/oUWeNHZkaqgdc3/lIs2uETbDMgNQsC4gZ5EH
	 lb0lqF6rPNTBK8UpadxaB6I8HPvm2TfZ5Q2AbjCN0EPr7wZxJzpXQvkAp9Pe6bT8q8
	 7dIAj/v/Z/oTX39zdFRAlNaZyKi5/TVdDkC1G/WaCnDfnTKOw2wFBXePUuarwjd9GM
	 gGgfkxUsmdUOIemle7ZPWNeL0GKKWudRGd1MgbGr0rWtMwCM5LTFyYkRZsjK26fSjq
	 3rG8+KqQG0tNxSUIAKuzYMzy0MVWhYrMIYL9xgzlLWmnD54mlPT/5+LgkPtN4pDfUU
	 8mu2wKqzcLqnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: firewire-motu: Protect register DSP event queue positions
Date: Thu,  4 Jun 2026 21:31:06 -0400
Message-ID: <20260605013107.2963134-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060436-askew-mundane-fd77@gregkh>
References: <2026060436-askew-mundane-fd77@gregkh>
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

