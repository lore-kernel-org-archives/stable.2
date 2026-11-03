Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793668505;
	b=Xx478eiV9QJ/WChsUrVH5rCzrg+5ZG9dlRBzULLQGZM40bweTtvv2NM0K+OPGB7pgnye
	 1Uvxn7AUuAnLIYHqMvVkxQ1/UY7IdmjVEq/haD7sDTurIJSyhYMui9dIc8GJyPf7ZHkw7
	 /qNtyXZ8AAEmfefaYdAJ0Ef4ikRIwvrhTR/pLLyd1ck+hKmaQjx5GFycHF7R2a2Mm+WB5
	 pezupedeNdwP5ZX9YUrex3vppRlRoGdaYbR4rnthUXhA6rY2Vmdud4p66KSV19g2Dab1O
	 RbpWUftWc90dqovZf/VonPYbx6QOBnOmE1BqPhPyExvAZlVhEgSWF/XaTQuX5iWpHSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793668505;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yGfxGis/8g0KaCRnCd2Ma8RfczzUtJnT7BRnU64wFQA=;
	b=OF/8XSnqRmUykdlYkkb440H0+wrkdIYUowScbZHODqRUsqF+4UrBB3a6XpUj2FlHmB0s
	 fqxUMUweRk2atenI7e4CKzLcy12nSPmJufh1nzoqnt/GQj4cQgI7u/Gw+yWIRLHsOpw0E
	 hlC6tWq8/yvc6CR8LoqT3JsGEYCpD6a4u9Ek6oJPviPU+GBOMebUYXs4VwrhmXjUnCcsZ
	 xMMozodQP44DykkypMfQX9vDq/0c94qaXVtNcH+UoEcMyX5n3ezzqLs82kFdNePmA9tiM
	 LN3Qul2qZ31e4z430BxA25ld7MhT2wVpOJaqiLlKut1XTAbdn7PCn2Y8GckOlydHMCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF0606A336
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 01:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42DF0606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso6169014eec.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 17:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793668504; x=1794273304;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yGfxGis/8g0KaCRnCd2Ma8RfczzUtJnT7BRnU64wFQA=;
        b=1c+spLcd6VfmJh7uED4chAYEZ0MdRt0h8TvMcjqesB470ZYk5ytic6gVeY/cnJbnJ5
         LfOq1D6HK3fHGZEQ969L2gC0bPtD8zgeo2iC5OoRm6DnAibgwEaMciwLJVTQHNUDpAt6
         U2tyIL4zeLC7CEFYqikhldM8TiwcQDasTfGXR2LsKVAv2KJyWgRy18BGBOYNEvT/ci8H
         fdfYmAmzmpZLnD0HaeLYaxiI1TkHse6VqW62wCXaQJita2RmoZJFx1+d7AAPXYdyybby
         k4oA/jZdNRxSu7pPXm/vy7yODHtzEAvuvRaIXQhr76NZqg7cyp9TmjdWCdcY+VIAPNk0
         ki8w==
X-Forwarded-Encrypted: i=1; AKwUvBy3ZcgNjmrEYA+XKYGcHW0sjDjAyL+dlVSBetziaKWbu6r7/OQwGw2PQlIHq/QQLTt6lKPxGSY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BVcEczjyJ11C39njLxLmu6QYFQDzdRdeyQ5PMImIcnOSZGFP1
	X92NubwWC7Nhb9BdlgOT4woGnOCIf4NOHd1aF4IvFbPeMBvWFq6mtBi8
X-Gm-Gg: AYBFou3e/g6CqqBcbv20/9ZYRiWGI1FvmEm2dH2O/HSRJvdX4q4N7AxVrL6lYP84ABs
	JEilmNxAxacNksGsAv/2nZknCTQ1zG/J8+ffJshdj52zfuaugruzXl4uuWTKDqF5jW44UYKeSqg
	ymmJd5l2MiSOVcg0g4A7IrLpFEVvRHl0jDh/LFCGbNVa21WKmYRaukyJ6/mTyXmXlNoAbBVUPBU
	6AXS6OzLRrmGwVsxV8nEF1TH2JKtrIleuY+RaEvfwhuH7R0HccjRfB11HA67V95RATW5FHi2M40
	SaebTiXBU8/Juoaj9TNCO6aBd/KhTby/OpVa+Lq1d1RPT0cBCr47AVvF7usSJ0g48Kh6hqvhtAf
	rz7YWemdnuWLrK84r5gkVfWYrXukP72n3nmL/vuIki5St/qaQyhxT4uOwoENGBi5vBtBozDgQDA
	TAYeAmuIHeJS1M1IA5RxTYEF22+T6gJxDpIo5xZRRJBELgvb+En65+0YmmbVuNbs+qwT4Pci/SR
	r3kWmQx6FfithDFHDqYZWZFZjbG2taZyFR13I1SAzPcu/lpTAdlYcFqbKUVoqNRi2G0QL51w5bI
	KSCegVts4EDtgT1sKuE3G80d6HSrnigBzLEZ0mr59ulpdpY6278ttRQ/wa8/dviuQi+1xFRi20/
	DB6s2vNqvlC1zazI=
X-Received: by 2002:a05:7300:7b81:b0:351:7ec1:a92c with SMTP id 5a478bee46e88-36a42431768mr26206992eec.28.1793668504130;
        Mon, 02 Nov 2026 17:15:04 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2602:294:1:b9:a2b::1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a426681aesm51988583eec.1.2026.11.02.17.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 17:15:02 -0800 (PST)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: samuel.thibault@ens-lyon.org, speakup@linux-speakup.org,
 linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, chris@the-brannons.com, kirk@reisers.ca,
 w.d.hubbs@gmail.com, stable@vger.kernel.org
Subject:
 [PATCH v3 4/4] speakup: Serialize synth clearing against locked readers
Date: Tue, 03 Nov 2026 09:14:59 +0800
Message-ID: <179366849966.70545.13780230213235717518@kylinos.cn>
In-Reply-To: <179366847311.70545.1738521378158835923@kylinos.cn>
References: <179366847311.70545.1738521378158835923@kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

speakup_key() checks the global synth before taking
speakup_info.spinlock, but do_spkup() and its handlers dereference
synth inside that lock: speech_kill() calls synth->is_alive(), and
the flush path reaches synth_start() reading synth->alive.
synth_release() clears synth under spk_mutex, which does not
serialize against the key path, so a speakup key pressed while the
synth is being removed can pass the unlocked check and oops on the
stale pointer:

    CPU0 (speakup key)             CPU1 (rmmod -> synth_release)
    ------------------            ----------------------------
    speakup_key():
      if (!synth)                  mutex_lock(&spk_mutex)
        return  /* passes */       synth_release():
    spin_lock(&speakup_info.         ... drain in-flight catch_up() ...
        spinlock)                   synth->release(synth)
    do_spkup():
      speech_kill():
        synth->is_alive()
        /* synth whose release() already tore down its I/O */

Close the window on both sides: clear synth under
speakup_info.spinlock in synth_release() and in the do_synth_init()
probe-failure path, and recheck it after acquiring the lock in every
reader that dereferences it there - do_spkup() at entry, the console
notifier paths after their trylock, do_handle_shift(),
do_handle_spec(), the speakup_key() special-handler dispatch,
synth_direct_store(), and the /dev/synth and /dev/synthu write
paths.  The unlocked checks that used to gate these paths only
duplicated the in-lock recheck, with a window a clear could still
slip through, and are dropped; the only behavior difference is that
an empty write to /dev/synth or /dev/synthu with no synth loaded now
returns 0 instead of -ENODEV, which is harmless.  The speakup thread
keeps its existing fence: synth_release() drains the catch-up count
before clearing.

Two sites of this shape remain, preexisting.  The cursor_done()
timer callback dereferences synth inside the lock with no synth
check at all; closing it needs the cursor_timer lifetime handled
against synth teardown, which is beyond this series.  The serial
read buffer handler (synth_readbuf_handler()) has the same shape but
cannot run in this tree: the only registration chain goes through
spk_serial_synth_probe(), which has no callers, and any
registration from outside the tree is still serialized by the
free_irq() in the serial synth release path, which runs before the
in-lock clear.

Fixes: 2067fd92d75b6 ("staging/speakup: Move out of staging")
Suggested-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: stable@vger.kernel.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/accessibility/speakup/devsynth.c | 13 ++++++----
 drivers/accessibility/speakup/kobjects.c |  8 +++---
 drivers/accessibility/speakup/main.c     | 31 ++++++++++++++++++------
 drivers/accessibility/speakup/synth.c    |  4 +++
 4 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/accessibility/speakup/devsynth.c b/drivers/accessibility=
/speakup/devsynth.c
index e3d909bd0480..5a32d3bbf7b8 100644
--- a/drivers/accessibility/speakup/devsynth.c
+++ b/drivers/accessibility/speakup/devsynth.c
@@ -20,8 +20,6 @@ static ssize_t speakup_file_write(struct file *fp, const ch=
ar __user *buffer,
 	unsigned long flags;
 	u_char buf[256];
=20
-	if (!synth)
-		return -ENODEV;
 	while (count > 0) {
 		bytes =3D min(count, sizeof(buf));
 		if (copy_from_user(buf, ptr, bytes))
@@ -29,6 +27,10 @@ static ssize_t speakup_file_write(struct file *fp, const c=
har __user *buffer,
 		count -=3D bytes;
 		ptr +=3D bytes;
 		spin_lock_irqsave(&speakup_info.spinlock, flags);
+		if (!synth) {
+			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+			return -ENODEV;
+		}
 		synth_write(buf, bytes);
 		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 	}
@@ -47,9 +49,6 @@ static ssize_t speakup_file_writeu(struct file *fp, const c=
har __user *buffer,
 	u16 ubuf[256];
 	size_t in, out;
=20
-	if (!synth)
-		return -ENODEV;
-
 	want =3D 1;
 	while (count >=3D want) {
 		/* Copy some UTF-8 piece from userland */
@@ -84,6 +83,10 @@ static ssize_t speakup_file_writeu(struct file *fp, const =
char __user *buffer,
 		/* And speak this up */
 		if (out) {
 			spin_lock_irqsave(&speakup_info.spinlock, flags);
+			if (!synth) {
+				spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+				return -ENODEV;
+			}
 			for (in =3D 0; in < out; in++)
 				synth_buffer_add(ubuf[in]);
 			synth_start();
diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility=
/speakup/kobjects.c
index e1860f8d9d42..45a8e9fbd8de 100644
--- a/drivers/accessibility/speakup/kobjects.c
+++ b/drivers/accessibility/speakup/kobjects.c
@@ -416,9 +416,6 @@ static ssize_t synth_direct_store(struct kobject *kobj,
 	char *unescaped;
 	unsigned long flags;
=20
-	if (!synth)
-		return -EPERM;
-
 	unescaped =3D kstrdup(buf, GFP_KERNEL);
 	if (!unescaped)
 		return -ENOMEM;
@@ -426,6 +423,11 @@ static ssize_t synth_direct_store(struct kobject *kobj,
 	string_unescape_any_inplace(unescaped);
=20
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
+	if (!synth) {
+		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+		kfree(unescaped);
+		return -EPERM;
+	}
 	synth_write(unescaped, strlen(unescaped));
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
=20
diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/spe=
akup/main.c
index e9b7c2761f6f..60be4d4df363 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -1166,9 +1166,13 @@ static void do_handle_shift(struct vc_data *vc, u_char=
 value, char up_flag)
 {
 	unsigned long flags;
=20
-	if (!synth || up_flag || spk_killed)
+	if (up_flag || spk_killed)
 		return;
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
+	if (!synth) {
+		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+		return;
+	}
 	if (cursor_track =3D=3D read_all_mode) {
 		switch (value) {
 		case KVAL(K_SHIFT):
@@ -1763,11 +1767,15 @@ static void speakup_con_write(struct vc_data *vc, u16=
 *str, int len)
 {
 	unsigned long flags;
=20
-	if ((vc->vc_num !=3D fg_console) || spk_shut_up || !synth)
+	if ((vc->vc_num !=3D fg_console) || spk_shut_up)
 		return;
 	if (!spin_trylock_irqsave(&speakup_info.spinlock, flags))
 		/* Speakup output, discard */
 		return;
+	if (!synth) {
+		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+		return;
+	}
 	if (spk_bell_pos && spk_keydown && (vc->state.x =3D=3D spk_bell_pos - 1))
 		bleep(3);
 	if ((is_cursor) || (cursor_track =3D=3D read_all_mode)) {
@@ -1792,11 +1800,15 @@ static void speakup_con_update(struct vc_data *vc)
 {
 	unsigned long flags;
=20
-	if (!speakup_console[vc->vc_num] || spk_parked || !synth)
+	if (!speakup_console[vc->vc_num] || spk_parked)
 		return;
 	if (!spin_trylock_irqsave(&speakup_info.spinlock, flags))
 		/* Speakup output, discard */
 		return;
+	if (!synth) {
+		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+		return;
+	}
 	speakup_date(vc);
 	if (vc->vc_mode =3D=3D KD_GRAPHICS && !spk_paused && spk_str_pause[0]) {
 		synth_printf("%s", spk_str_pause);
@@ -1811,9 +1823,13 @@ static void do_handle_spec(struct vc_data *vc, u_char =
value, char up_flag)
 	int on_off =3D 2;
 	char *label;
=20
-	if (!synth || up_flag || spk_killed)
+	if (up_flag || spk_killed)
 		return;
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
+	if (!synth) {
+		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+		return;
+	}
 	spk_shut_up &=3D 0xfe;
 	if (spk_no_intr)
 		spk_do_flush();
@@ -2087,6 +2103,8 @@ static spkup_hand spkup_handler[] =3D {
=20
 static void do_spkup(struct vc_data *vc, u_char value)
 {
+	if (!synth)
+		return;
 	if (spk_killed && value !=3D SPEECH_KILL)
 		return;
 	spk_keydown =3D 0;
@@ -2115,10 +2133,9 @@ speakup_key(struct vc_data *vc, int shift_state, int k=
eycode, u16 keysym,
 	u_char shift_info, offset;
 	int ret =3D 0;
=20
-	if (!synth)
-		return 0;
-
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
+	if (!synth)
+		goto out;
 	tty =3D vc->port.tty;
 	if (type >=3D 0xf0)
 		type -=3D 0xf0;
diff --git a/drivers/accessibility/speakup/synth.c b/drivers/accessibility/sp=
eakup/synth.c
index 1af80eb116af..aef482f8b14e 100644
--- a/drivers/accessibility/speakup/synth.c
+++ b/drivers/accessibility/speakup/synth.c
@@ -519,7 +519,9 @@ static int do_synth_init(struct spk_synth *in_synth)
 	pr_warn("synth probe\n");
 	if (synth->probe(synth) < 0) {
 		pr_warn("%s: device probe failed\n", in_synth->name);
+		spin_lock_irqsave(&speakup_info.spinlock, flags);
 		synth =3D NULL;
+		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 		return -ENODEV;
 	}
 	synth_time_vars[0].u.n.value =3D
@@ -585,7 +587,9 @@ void synth_release(void)
 	for (var =3D synth->vars; var->var_id !=3D MAXVARS; var++)
 		speakup_unregister_var(var->var_id);
 	synth->release(synth);
+	spin_lock_irqsave(&speakup_info.spinlock, flags);
 	synth =3D NULL;
+	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 }
=20
 /* called by: all_driver_init() */
--=20
2.32.0

