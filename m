Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770079;
	b=Ac0EUyjrey5nTKpAvt13z2fqCDaiReYjBBh9S2Mx+Xc4en0mSwg+G3xn8Ikw3duRdLVZ
	 DYLyNKZhXkNMcOUHIjoBtBrADYwXZeHDg43kWusGLQgbNgd23j0N5rcxoaFqEFOQqSH5f
	 lsk2WigEueZ01lEjNJLGHtWfCFFCVg6RZyYdTpC1v7++aOv1ikLn1+eVkA9wUTrDcn6V/
	 m8MzFLjtpgKGCeZre4lYTAO6sdom4DZSCl0ARWp/4iz43GHxvHcqQXs8m5+emCebYI9nF
	 EKR5tkpgIP4lcMvNMDCdhZl7LMOQJ40iiSXotAbbMs5OUMYHObpJ0A6/M+j62dCC8lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770079;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yGfxGis/8g0KaCRnCd2Ma8RfczzUtJnT7BRnU64wFQA=;
	b=ATD6TKtn48+zKmO4x1L+t9CQ5U4aPgPPZh1YtrEhQ9UWkAFDQtotpWT2zXa21l6f9wgW
	 v0wJvq+6m0BemGIXRrJX5OfxfrTM1H6d80yPBfuZqDtAFKToPOqcQxt1Pxl0H94IFaSYM
	 FDlErbwGORv2HTm7HYPA1IWkNZALLhqBrI1ZQ9bXr7xWUWu9per0zyu0x/JfAtJq0sCdJ
	 r+45SicjMpDpzsRieWH6NUhG3QtAl2CxEIwJPx1ndrztoWZJLixaRdfewPd2oZUNGXP06
	 8Go1dXrDCxBsbttndXquB3nRdv6LZnZZbOVKl78Q20hSQXXqm0gP4uCob0v/T+pFgiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF55606A684
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FF55606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f048476ab9so54881805ad.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770062; x=1796374862;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yGfxGis/8g0KaCRnCd2Ma8RfczzUtJnT7BRnU64wFQA=;
        b=MXPn3L0zjxmMaKbym6NGNYIIzJrpt+142Jvp5CEqVLssz3vUDbGhqyFH/2oRNVIiir
         3hI472qhQnGvZrdqUnGEy36baawT/9nevQPx7IEcs8lbzYIem1vQAZ6bzpIuobIEjAck
         UjNnDLGnRIUNSSQwtBmJk8n3hyc1QzXzuTvr426/IasOMeGnFnzWqYZ4aKNQCEpTjrCN
         kMkdFcPOD22Qi8yRDejBJLd7l8MqKZKhTNv6hD+m7bcBUPMcItxqn9hSJdmQYJz5YKb+
         68+mRBKICgD958tglhN6iyBV9ZzwYodoL2zXoqkHoZ4YmSrTZVFMa2L3Ree1DIVJF4qk
         kCEA==
X-Forwarded-Encrypted: i=1; AL+hErEDA/YQrYEUh17K5Toa7VGXzrT4X4fiIwvDg6d17uvlOniZlsViohtWb6fMEMBufTfRe3TvjKQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TF+3t1am6uAffUQVE1voA2ne07TaIPHjq8pK+tlymsRi7KMU2
	N/lnVq5fOWV5hY8uA7VXIvjT1/Vh852zsvdIwQpqJnDA8J+mr4suKwNb
X-Gm-Gg: AZFdTZebmHX8IO4uzA7CaboYIz36tMUVqw8zr+IuihB+EJYcrA4ApK8cqKDPy0/E0R6
	j2KOFI9A7NfoWOVVq0VTzwq11fMR40rc1uT2dN76PEvzfDrUMVQr2J9aa0KiitwimUlxrM/2ujG
	3OSz9/p8uxz5MnFbNgrjqscgiB1ZNUvy/O4nLVqOVGCa2z7dLCEs3drXCw+ZoWx/STEwrVyezjd
	1FbgwjsnPceHxszfePYUmnrm7V/7ivbXA2qu8W+ZtQglV2yTuXM2SSYXCJfcDSwsJ7/Rb+1CW+L
	2BEZ+CBs0SY3YmqzNUDNEdFx4WftuKLD9fj6xkQiezAbJmrMybOeIFgtXnIQjXUO2yCjftYntJb
	+r4XEAaha0sYpxWLMUh4VBFPHFPh7wKWHmygzfVcrueIXr7qTCOta0nU5A9EJXYFO192/GpayFr
	+ElfWVbp6IRfAuYUc7ygksEzb/cWxYRvgFIPGMcAPP4YkjmIYa8czH6eVhyHPqIJFkuPUZLiDVd
	GyAi/4uErZ1EqfvY7B5Q0GWP94WbRaJ/aAHObYqefByQORqrmTlGt+rQ7D8tS0FOXw8c6YhgJPe
	sMtAzW8FaH85UlPtviTDXr8eDR7CzVj1xZkzZ0ekn0zBgyd5VHoNtd3ZNkNHtuIQtIl+TisueFm
	uOfzgH1Dka9L+Z1BJsE0vmbhAXBRbL0j+9xu23Bl6Oge8Ag==
X-Received: by 2002:a17:902:dacb:b0:2f0:25ea:8fca with SMTP id d9443c01a7336-2f03f11e6f1mr266297825ad.26.1795770060116;
        Fri, 27 Nov 2026 01:01:00 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([216.236.36.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120769sm117050725ad.57.2026.11.27.01.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:00:59 -0800 (PST)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
 chris@the-brannons.com, kirk@reisers.ca, w.d.hubbs@gmail.com,
 stable@vger.kernel.org
Subject: [PATCH RESEND v3 4/4] speakup: Serialize synth clearing against
 locked readers
Date: Fri, 27 Nov 2026 17:00:55 +0800
Message-ID: <179577005597.23588.2542403252088469180@kylinos.cn>
In-Reply-To: <179577002884.23588.802785530849276690@kylinos.cn>
References: <179577002884.23588.802785530849276690@kylinos.cn>
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

