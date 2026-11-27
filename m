Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795762077;
	b=R6QxCTKl3hniQDA9wtWsuFleO1rJUwatk1stqXXeGO5rlkjadm4GoVSa3+atBEJ0j7Mc
	 1AS4hkyFqCCcEsdnk01gTyPM6N6Eo0l2swhJwNOszx/mtTL50w7I3mjsz8Vwfs3MzF6DJ
	 J10bfv/+uDSF4jTlI93Jcs3BmtFm9h1QkVppDtLuSMWMDsFMU3a1jcN5fX1Eq1jhjcSel
	 dWzA8JBxHKG2NUbsNGRBatZYN9TVNEgHkti3zAaamU5tv+WcHnSiONNK0z8tcDLrfysnw
	 jnwsydoK1uOgf7B3cOjX+wvM2PNxcqmFAKIgkb5R3IfRDgN+ch1mmmZGfbFT4ZjERng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762077;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=j6m7R+QoZXf0daSNyypH1YTXx+y64p+sMjzGTV/IfP8=;
	b=GhuvA6Jtqv/oQy0TioGoC+9meNbdvzT/WpiUdSSOooa4rkSL4Nyhp0vT7HqDSMCCYbJj
	 KULIXSQNo6eEMYB3JfTsiAguR4A7TCs/WizcTi96YUProFzmpq1FUWVtG4lsxHkPrsvNy
	 bfmfOuZmwOKWFR32RwvkHL+T/SP3IMc8HepMWKQBWTcMCs9bDtLr8xiDz4Q/YnqhNrah/
	 jryU5tM/I1Ni1H3bekLut49PUCsW+dQJeR0KFn2uXKv4LJMLygx6ICjT+xmbAdqPdkCup
	 uNKyTQxk/X+k5HxixFwZHLTGhJyEag2JBeKXwnZYdbKifbzq00WLbU6JhMmfv5bekJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYnp0l8s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AFA606A326;
	Fri, 27 Nov 2026 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYnp0l8s
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795762076;
	b=eWFOBye8/oJsvsPmR5hWgVR8nw115YJHygavyFovXEue1zBlkIsWh61M5TK1DtvEppc5
	 RJohAjGBVHoQLbEGX7OeiMzhFNLPCf48djoiut32Za9wsB0bwz3Y82tB0/TxO4Oli3mub
	 PmgDSUwq902ywGUblzY/SGvPKIDhFcBVnl7XKGGOC9fmQaBwVa1T5zHYzbfIdxgX5BkiL
	 finruOrvnyxXzT1o1fuKkSC6t9knMCPaLpcPb7iIi8DZaetFKV3ooZrdsqlZWh8UEOox6
	 mPPzlfRjwezteQ5l5jJX50HmvSHqiHJlJxK+9l03K+q8S0ZOERxfiqwviJglaFqUy2g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795762076;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=j6m7R+QoZXf0daSNyypH1YTXx+y64p+sMjzGTV/IfP8=;
	b=xi+nnviyZhGerAwDJOZQ5SYI0/vyBx7rk/8YQjMzRBeniPoN2ZOVJesXWR4P8CaEsaHf
	 izSvuPgpkBMx0p+cJdcDboAEC/gznK+vcGt64XIsmYGSAA+a37KIA5GVcv7K9FNMWmxKe
	 e5jJqyi4Z+4zzdnxhjyjJxE7+eHAwHTA3O6jL8kN2SaBqsAgwrZLUkPw2PW8uYhFqCK2s
	 AAwdUafh37c5reknGJgRhb+owoQksZpGEskRmUuidkklwUEl0YF+h3gyXavTtZJFyWR0V
	 wDoaWb5T+47dp0TUO3uN92krepggrJ65OEaUYsG4XvUEJoYpH2olR/rrSYXglMVvsLg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AD3B51F0089B;
	Fri, 27 Nov 2026 06:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795762076;
	bh=j6m7R+QoZXf0daSNyypH1YTXx+y64p+sMjzGTV/IfP8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=PYnp0l8syBeYyhAbju9tLXeOj7CD/KPcKIJcUeBAxCBFF4/NOuMnf5YIxoM1O9bAp
	 tmOFE5cZG/jM6uL/6CEE+C6MqwoIuUeYMnJdMPcNt3aJ4FVgpZa+4ROw3nAspo3il/
	 RvpLxfnPfemHRtv02mSXJnX1eU3cAEAKOxbFDvdyxsft01f4weRzm0JD9g1MM6wkZO
	 reSjls8E+w9PnQW7bsmbUArS/YCFguvAbsofjMbHT0Xy1g/aJOu2oPjjsoJ8Fc17Cx
	 9q+RbDYPh7exNcoVU/GeCXP7OB6jssPjqNpHxhbLbdeuZLjO7EYGEFCtpstyGqPuwo
	 JawQ8pR+oMS6g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2B5584B5B4;
	Fri, 27 Nov 2026 06:47:46 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Fri, 27 Nov 2026 05:35:37 +0000
Subject: [PATCH 6.6.y] ALSA: seq: Don't leak the extension cell pointer in
 the bounce payload
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
Message-Id: <20261127-so5-alsa-66-v1-1-e6baeea4106a@certik.com>
X-B4-Tracking: v=1; b=H4sIAKgWCWsC/02NSw7CMAxEr1J5jQsJJQiugljk41KjKqnigkBV7
 04CG5bzNPNmAaHMJHBuFsj0ZOEUS1CbBvxg442QQ8mgd9oopY8o6YB2FIvGIPWOgjrtfUcdlMW
 UqefX13YB05r2Ddcfloe7k5+rqRadFUKXbfRDRUIxzCmNWPn27wHW9QPWIRLiogAAAA==
X-Change-ID: 20261127-so5-alsa-66-efbed193c4e4
To: stable@vger.kernel.org
Cc: HyeongJun An <sammiee5311@gmail.com>, Takashi Iwai <tiwai@suse.de>, 
 linux-sound@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795757736; l=4003;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=nGJ91NaFovr+BISLWd06H/MX3/Mv38Fa6V8EKicAbJ4=;
 b=ZlYd1JYkTfkU4c4meREjx9iDEgpue9uA7XF0TuuIpDNQqouvJ9FY8KlhMqzT3mr0baCEvwwUT
 xswXe7PBP8ADbGbuuSQBvqgKWCS3TzxPWNTf6kuDYeuqNpd/l9m3lX+
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: HyeongJun An <sammiee5311@gmail.com>

commit 59e1592d3c270ff4642d5d6dc55c545306eb0693 upstream.

The bounce_error_event() embeds the failed event in the bounce payload
by pointing data.ext.ptr at it.  When that event is a queued
variable-length event, its own data.ext.ptr holds the address of its
first extension cell, put there by snd_seq_event_dup().  The payload
goes out verbatim through snd_seq_expand_var_event(), so the address
reaches userspace.

That is the same address commit 705dd6dcbc0e ("ALSA: seq: Clear
variable event pointer on read") removed from the event header.  The
read path still clears it there, just above the call that expands the
payload.

Embed a sanitised copy instead, treated exactly as snd_seq_read()
treats the header.  A stack copy is enough because delivery is
synchronous and snd_seq_event_dup() copies before returning.

An unprivileged client reaches this by setting SNDRV_SEQ_FILTER_BOUNCE,
queueing a variable-length event to a port that does not exist and
reading the bounce back.  Eight bytes on 64-bit, from its own pool.

Fixes: efc86691e4d8 ("ALSA: seq: Fix kernel heap address leak in bounce_error_event()")
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
Link: https://patch.msgid.link/20260811131835.3837024-1-sammiee5311@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.1.y, 6.12.y and newer already have this fix.

Tested on v6.6.163:
- x86_64 allmodconfig W=1 build of sound/core/seq/seq_clientmgr.o,
  base vs patched, no new warnings
- booted the patched kernel under QEMU/KVM with snd-seq-dummy, passed a
  note between two ports and checked the error bounce for a rejected
  fixed-length event. I didn't run a variable-length bounce.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

sound/core/seq/seq_clientmgr.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)
---
 sound/core/seq/seq_clientmgr.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index f039fd6ee3a7..de17b66cd16b 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -578,7 +578,7 @@ static int bounce_error_event(struct snd_seq_client *client,
 			      struct snd_seq_event *event,
 			      int err, int atomic, int hop)
 {
-	struct snd_seq_event bounce_ev;
+	struct snd_seq_event bounce_ev, quoted;
 	int result;
 
 	if (client == NULL ||
@@ -594,15 +594,19 @@ static int bounce_error_event(struct snd_seq_client *client,
 		 * For user clients, send SNDRV_SEQ_EVENT_BOUNCE with the
 		 * original event embedded as variable-length data.  This
 		 * avoids exposing data.quote.event (a kernel pointer) to
-		 * userspace.  The variable-length path in snd_seq_event_dup()
-		 * copies the event data from data.ext.ptr into chained cells,
-		 * and snd_seq_expand_var_event() copies only the data content
-		 * -- never the pointer -- to userspace.
+		 * userspace.  Sanitise the embedded copy too - a queued
+		 * variable-length event carries the address of its own
+		 * extension cell, and the payload goes out verbatim.
 		 */
+		quoted = *event;
+		if (snd_seq_ev_is_variable(&quoted)) {
+			quoted.data.ext.len &= ~SNDRV_SEQ_EXT_MASK;
+			quoted.data.ext.ptr = NULL;
+		}
 		bounce_ev.type = SNDRV_SEQ_EVENT_BOUNCE;
 		bounce_ev.flags = SNDRV_SEQ_EVENT_LENGTH_VARIABLE;
 		bounce_ev.data.ext.len = sizeof(struct snd_seq_event);
-		bounce_ev.data.ext.ptr = (char *)event;
+		bounce_ev.data.ext.ptr = (char *)&quoted;
 	} else {
 		/*
 		 * For kernel clients, quote the event pointer directly.

---
base-commit: e2bb30811e063ce0db964484357973b855b06572
change-id: 20261127-so5-alsa-66-efbed193c4e4

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


