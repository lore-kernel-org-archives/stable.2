Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0F4825CA
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962524; cv=none; b=MboK0lmr7V0VQifioFgRLCB6LtHtVONNqu3SYnIG7OvLWPcmllFiTVSxsKmkjyaqysSfABkVvDQ69T5lRzcll+QDe5O6OBg7nNdVhEFhNFRF5V3n7QqY2fEz3ooPEH4u4Rsr7HIDZffN3w9p4BW0ISf0JOh9KgPDmXehwUZoR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962524; c=relaxed/simple;
	bh=HPCnWzHw4UlvCpmrJOVOKrF7xXClMlnJj90UhUe1r8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O6QJ5qtDzlm4u8w5Ie+fBMuVGE1an8eJWC4N8kclVLAiW39JhpfflsSzhg45maw+16GU/whx2bfaIau643bnoxO+/igtNAWZ+VyikONcwr+GqNAxawHOGNnFtvePNUkapVOasCcPpJ7RftF8ivzNF3Kxv+C9AEhdFc2r7nVAuDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a80d1c98f5so54496a91.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 00:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962521; x=1792567321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SRRjCThkLtkh9ioPnv0DPeiv/jW/COvqnvAq2IwV3Gs=;
        b=xiWN9f1jYT4tYEBTZ4oGqEMlfNSTzZXGCwybleZX+33m2/cnv+aoT9Tku/cKtEvOEo
         P3DxSjXdzfnZpGWIZrIcaaitggwsoeqxevIoGEeh1lgDU3H/1uJn6GDHdh2KCGrxezR4
         aAsrnay5WboJ9MsUB7gvgXtoqubO/AWFDfsuPHAfFnkzSCxdVHTZibv+T10MT0QEvoMR
         GsAQ/cOY1rjiYfZ2442RcF1oMyOO+91zDFoMZgR+PJJKXdP1gp6TRQW++5LuCRN2vRhe
         frOfXCK8hb7792SCJlfr/YqbXrMoocodpNkRc8NDT/Ub+GevR2FMAoHZiaZl8QzQrhXn
         8uug==
X-Forwarded-Encrypted: i=1; AKwUvBzgDHI7/8jEvI29xlnBLun+tYp6076TYeeUPojRJ9LeMbSQj/wr7u3uQmPggenEpkoAf/Y0vsk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOj3A+TetDZ0iHPsQ913lTHlUBDEGrR9hBt6g9SJHV8PCIVOOI
	glMpkRyjhyO+DtA65FP445ktC+qAxRk9p1zVQ9p4sOfDAGIOVaKtp5fa
X-Gm-Gg: AYBFou1ajxLRxxR2RWn8Ktk6a37dSMZ4IDFBCDQsQ2RTh5cSKl9ttBQBOKrXBs6SurG
	kS8EFj2i9Beplo8eXVrgHNq/VwcZ0HHPkC3lOFz/t+NPTxcsixd5M+xglofrFL9KgI47N+UB32C
	EqkE/r1YxccueY43YtvtjIPOc4qPw4xDxpcbulazW6iNlXA9YZBJ6p+/r5VpQHqkhAuR8JKpa9f
	aDRUZ/ri25+Bo4FJK7DsuigMqgaRAu7IF5bgtM3vZa5Xpq39BqitDiG2CT8paVvIrqRorzebsC9
	8kHKiEq5Deg8zOGAMeSkZ6eRk0pRPCsFhy4IDaKrgPD/LYJ3o5ny0M7QXdxGYuMcy5G34HMxP44
	zvsLhykQXWXJwI0js+6npB1RUZ19RhnhNFxjj0v+8XgO7JekHmMok11NkjbjgEIcSFOOE7fb+31
	4tBSy8qBiQHUD/wm4/oHDOqXZFO915HMSNyPR6Me8ffKw2tR32+EonL9S/I9t/rzDy7urdUliGr
	HkQtK5BefJxgamBxLNtrICMGg==
X-Received: by 2002:a17:90b:2681:b0:3aa:ff61:9504 with SMTP id 98e67ed59e1d1-3ab3a9127f1mr11675232a91.20.1791962520905;
        Wed, 14 Oct 2026 00:22:00 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac604b2f7csm2997758a91.10.2026.10.14.00.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:22:00 -0700 (PDT)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: samuel.thibault@ens-lyon.org,
	speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	chris@the-brannons.com,
	kirk@reisers.ca,
	w.d.hubbs@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 4/4] speakup: Serialize synth clearing against locked readers
Date: Wed, 14 Oct 2026 15:17:13 +0800
Message-Id: <20261014071713.321914-5-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261014071713.321914-1-xiehongyu1@kylinos.cn>
References: <20261014071713.321914-1-xiehongyu1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

speakup_key() validates the global synth pointer before taking
speakup_info.spinlock, but do_spkup() and its handlers run inside
that lock and dereference synth: speech_kill() calls
synth->is_alive(), and the flush path reaches synth_start()
reading synth->alive.  synth_release() clears synth under
spk_mutex, which does not serialize against the key path, so a
speakup key pressed while the synth is being removed can pass the
unlocked check and oops on the stale pointer:

    CPU0 (speakup key)             CPU1 (rmmod -> synth_release)
    ------------------             ----------------------------
    speakup_key():
      if (!synth)                  mutex_lock(&spk_mutex)
        return 0  /* passes */     synth_release():
    spin_lock(&speakup_info.         synth->alive = 0   (spinlock)
        spinlock)                   ... drain in-flight catch_up() ...
                                    synth->release(synth)
    do_spkup():                     synth = NULL       /* unlocked */
      speech_kill():
        synth->is_alive()
        /* dereferences a synth whose release() has
           already torn down its I/O */

Closing this window needs both sides of the race:

- Recheck synth at do_spkup() entry, inside the lock, so the whole
  handler table runs only while a synth is still registered.
  speakup_con_write() and speakup_con_update() gate on synth
  before their trylock; recheck it after acquiring the lock too,
  so these readers no longer validate outside the critical
  section that dereferences.

- Clear synth under speakup_info.spinlock in synth_release() and
  in the do_synth_init() probe-failure path, so a clear can never
  land between a locked reader's check and its dereference.

With the check and the clear under the same lock they are
mutually exclusive for these paths, instead of merely close
together:

    CPU0 (speakup key)             CPU1 (rmmod -> synth_release)
    ------------------             ----------------------------
    spin_lock(&speakup_info.       ... drain in-flight catch_up() ...
        spinlock)                  spin_lock(&speakup_info.spinlock)
    do_spkup():                    synth = NULL
      if (!synth)                  spin_unlock(...)
        return  /* in-lock recheck */
      speech_kill():
        synth->is_alive()  /* cannot interleave with a clear */

The console notifier paths had the same window between the
pre-trylock check and the in-lock use:

    CPU0 (vt notifier)             CPU1 (rmmod -> synth_release)
    ------------------             ----------------------------
    speakup_con_write():
      if (!synth)                  (the clear lands between
        return  /* pre-trylock */    the pre-trylock check
    spin_trylock(&speakup_info.      and the in-lock use)
        spinlock)
    ... uses synth ...  /* stale */

and now recheck synth after the trylock, in the lock, exactly
like do_spkup().

The remaining locked readers had the same window between an
unlocked check and the in-lock dereference, and gain the same
recheck:

- do_handle_shift() and do_handle_spec() gate on synth before
  taking speakup_info.spinlock and dereference it via
  synth_printf() inside the lock.
- speakup_key()'s special-handler dispatch dereferences synth
  inside the lock speakup_key() holds (handle_goto(),
  edit_bits(), the help handler), past the unlocked entry
  check.
- synth_direct_store() validates synth before the lock while
  its synth_write() call runs inside it.
- the /dev/synth and /dev/synthu write paths validate synth
  once before their copy_from_user() loop while every round
  calls synth_write() (or synth_buffer_add() plus
  synth_start()) inside the lock.

With these rechecks the check and the clear are mutually
exclusive for every reader that dereferences synth inside
speakup_info.spinlock.

The speakup thread keeps its existing fence: synth_release()
drains the catch-up count before clearing.

Two sites of this shape remain, preexisting.  The cursor_done()
timer callback dereferences synth inside the lock with no synth
check at all, and closing it needs the cursor_timer lifetime
handled against synth teardown, which is beyond this series.
The serial read buffer handler (synth_readbuf_handler()) also
dereferences synth inside the lock with no synth check.  It
cannot run in this tree: the only registration chain goes
through spk_serial_synth_probe(), which has no callers, and
any registration from outside the tree is still serialized by
the free_irq() in the serial synth release path, which runs
before the in-lock clear.

Fixes: 2067fd92d75b6 ("staging/speakup: Move out of staging")
Cc: stable@vger.kernel.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/accessibility/speakup/devsynth.c |  8 ++++++++
 drivers/accessibility/speakup/kobjects.c |  5 +++++
 drivers/accessibility/speakup/main.c     | 20 ++++++++++++++++++++
 drivers/accessibility/speakup/synth.c    |  4 ++++
 4 files changed, 37 insertions(+)

diff --git a/drivers/accessibility/speakup/devsynth.c b/drivers/accessibility/speakup/devsynth.c
index e3d909bd04804..19799a362948d 100644
--- a/drivers/accessibility/speakup/devsynth.c
+++ b/drivers/accessibility/speakup/devsynth.c
@@ -29,6 +29,10 @@ static ssize_t speakup_file_write(struct file *fp, const char __user *buffer,
 		count -= bytes;
 		ptr += bytes;
 		spin_lock_irqsave(&speakup_info.spinlock, flags);
+		if (!synth) {
+			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+			return -ENODEV;
+		}
 		synth_write(buf, bytes);
 		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 	}
@@ -84,6 +88,10 @@ static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
 		/* And speak this up */
 		if (out) {
 			spin_lock_irqsave(&speakup_info.spinlock, flags);
+			if (!synth) {
+				spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+				return -ENODEV;
+			}
 			for (in = 0; in < out; in++)
 				synth_buffer_add(ubuf[in]);
 			synth_start();
diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility/speakup/kobjects.c
index e1860f8d9d422..00e92efa872ca 100644
--- a/drivers/accessibility/speakup/kobjects.c
+++ b/drivers/accessibility/speakup/kobjects.c
@@ -426,6 +426,11 @@ static ssize_t synth_direct_store(struct kobject *kobj,
 	string_unescape_any_inplace(unescaped);
 
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
+	if (!synth) {
+		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+		kfree(unescaped);
+		return -EPERM;
+	}
 	synth_write(unescaped, strlen(unescaped));
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 
diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index e9b7c2761f6f9..a88b6d66eeb76 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -1169,6 +1169,10 @@ static void do_handle_shift(struct vc_data *vc, u_char value, char up_flag)
 	if (!synth || up_flag || spk_killed)
 		return;
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
+	if (!synth) {
+		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+		return;
+	}
 	if (cursor_track == read_all_mode) {
 		switch (value) {
 		case KVAL(K_SHIFT):
@@ -1768,6 +1772,10 @@ static void speakup_con_write(struct vc_data *vc, u16 *str, int len)
 	if (!spin_trylock_irqsave(&speakup_info.spinlock, flags))
 		/* Speakup output, discard */
 		return;
+	if (!synth) {
+		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+		return;
+	}
 	if (spk_bell_pos && spk_keydown && (vc->state.x == spk_bell_pos - 1))
 		bleep(3);
 	if ((is_cursor) || (cursor_track == read_all_mode)) {
@@ -1797,6 +1805,10 @@ static void speakup_con_update(struct vc_data *vc)
 	if (!spin_trylock_irqsave(&speakup_info.spinlock, flags))
 		/* Speakup output, discard */
 		return;
+	if (!synth) {
+		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+		return;
+	}
 	speakup_date(vc);
 	if (vc->vc_mode == KD_GRAPHICS && !spk_paused && spk_str_pause[0]) {
 		synth_printf("%s", spk_str_pause);
@@ -1814,6 +1826,10 @@ static void do_handle_spec(struct vc_data *vc, u_char value, char up_flag)
 	if (!synth || up_flag || spk_killed)
 		return;
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
+	if (!synth) {
+		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+		return;
+	}
 	spk_shut_up &= 0xfe;
 	if (spk_no_intr)
 		spk_do_flush();
@@ -2087,6 +2103,8 @@ static spkup_hand spkup_handler[] = {
 
 static void do_spkup(struct vc_data *vc, u_char value)
 {
+	if (!synth)
+		return;
 	if (spk_killed && value != SPEECH_KILL)
 		return;
 	spk_keydown = 0;
@@ -2119,6 +2137,8 @@ speakup_key(struct vc_data *vc, int shift_state, int keycode, u16 keysym,
 		return 0;
 
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
+	if (!synth)
+		goto out;
 	tty = vc->port.tty;
 	if (type >= 0xf0)
 		type -= 0xf0;
diff --git a/drivers/accessibility/speakup/synth.c b/drivers/accessibility/speakup/synth.c
index 1af80eb116af6..aef482f8b14e8 100644
--- a/drivers/accessibility/speakup/synth.c
+++ b/drivers/accessibility/speakup/synth.c
@@ -519,7 +519,9 @@ static int do_synth_init(struct spk_synth *in_synth)
 	pr_warn("synth probe\n");
 	if (synth->probe(synth) < 0) {
 		pr_warn("%s: device probe failed\n", in_synth->name);
+		spin_lock_irqsave(&speakup_info.spinlock, flags);
 		synth = NULL;
+		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 		return -ENODEV;
 	}
 	synth_time_vars[0].u.n.value =
@@ -585,7 +587,9 @@ void synth_release(void)
 	for (var = synth->vars; var->var_id != MAXVARS; var++)
 		speakup_unregister_var(var->var_id);
 	synth->release(synth);
+	spin_lock_irqsave(&speakup_info.spinlock, flags);
 	synth = NULL;
+	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 }
 
 /* called by: all_driver_init() */
-- 
2.25.1

