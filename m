Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355A3F44CB
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569169; cv=none; b=iQBFgTYvLDhAF2xmDN5y7nMp7r6kqOxDc9mKojgKtp7Csbsu99sHYmqpUwZdoUj/UZk16WzvOB92w3USiAq9KN1fn31lw8V1I4QKREuPC1cM4OT6bVatHM/ev+fZptHEJ3ABBayLrMjNythZ3S4WXUND8elPAIOKQD2gsbWQcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569169; c=relaxed/simple;
	bh=FZeon4cYnQkIdCedKSXwnfJKsoiGDAlFoIQNSoUITH0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QrGsLLNMJb58R8mu13UF9EyzmH10sYLZRj2Vqe+l/caL4viFMrtpuEn4inp4sJcVQoxM4vLHJAw55UEQM7hnyh9tNY1AKkcVqtETyMrRXGG0fhy0X6PlVb3vr3pt2KwIrJRG13rPUgwgUCJhNHvJ2fP/1tfDB86OuaHjYCjwNNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KjIwAT3r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KjIwAT3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA981F00893;
	Thu,  4 Jun 2026 10:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780569165;
	bh=S0ED8A9Syo2n50osfiRsOudJKjvbwg0NrbTBNOdMtpU=;
	h=Subject:To:Cc:From:Date;
	b=KjIwAT3rjTn6jeacnMJOBsifYE/ziLhyjD4+XHNHNRw1mnXtorZklxkWpEPysZOia
	 1Esp0ZYJIgTlWGZwR3eWkv6pioEbHTnFi5ZET4O7WufyyYV1qvqwOWWKRFePa69W/X
	 lQ9/nJKB5BVwDLIo3t63f+ZuNiET56xVni70hrUg=
Subject: FAILED: patch "[PATCH] ALSA: firewire-motu: Protect register DSP event queue" failed to apply to 6.1-stable tree
To: cassiogabrielcontato@gmail.com,o-takashi@sakamocchi.jp,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:31:37 +0200
Message-ID: <2026060437-throttle-colossal-060d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 98fb1c1bb11e29eb609b7200a25e136e05aa4498
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060437-throttle-colossal-060d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 98fb1c1bb11e29eb609b7200a25e136e05aa4498 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Thu, 21 May 2026 08:01:23 -0300
Subject: [PATCH] ALSA: firewire-motu: Protect register DSP event queue
 positions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/sound/firewire/motu/motu-register-dsp-message-parser.c b/sound/firewire/motu/motu-register-dsp-message-parser.c
index a8053e3ef065..4ec23e6880d9 100644
--- a/sound/firewire/motu/motu-register-dsp-message-parser.c
+++ b/sound/firewire/motu/motu-register-dsp-message-parser.c
@@ -386,6 +386,8 @@ unsigned int snd_motu_register_dsp_message_parser_count_event(struct snd_motu *m
 {
 	struct msg_parser *parser = motu->message_parser;
 
+	guard(spinlock_irqsave)(&parser->lock);
+
 	if (parser->pull_pos > parser->push_pos)
 		return EVENT_QUEUE_SIZE - parser->pull_pos + parser->push_pos;
 	else
@@ -395,13 +397,14 @@ unsigned int snd_motu_register_dsp_message_parser_count_event(struct snd_motu *m
 bool snd_motu_register_dsp_message_parser_copy_event(struct snd_motu *motu, u32 *event)
 {
 	struct msg_parser *parser = motu->message_parser;
-	unsigned int pos = parser->pull_pos;
-
-	if (pos == parser->push_pos)
-		return false;
+	unsigned int pos;
 
 	guard(spinlock_irqsave)(&parser->lock);
 
+	if (parser->pull_pos == parser->push_pos)
+		return false;
+
+	pos = parser->pull_pos;
 	*event = parser->event_queue[pos];
 
 	++pos;

