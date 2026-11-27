Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770044;
	b=gtAlCtjhv+4OphbB9rGtrWetKRSJsQr80kLxk2R9Yw4Rjo5CZfb/i/X+fHCh3/a40qH4
	 VIrozPgblIdy5WGUCVG9G809+RoAtrChaRNzNN79F8hcEwj5PxpgH0s0JbVNmsrVLnfgH
	 33DQ0JSR/aGgsnxJPNA7SFZVRJkiH+OXSoyR1Rr1ob5Ej2NhMK/uXIbg+yNGnuHs4FjK7
	 TvWjn94Vok/etRbz2jRn8h023rN1RZEGLhrICZSV0qj3rKWmta0p6BOFnWxoQDt3Hnu/x
	 hlInvRfcK9TyuEybnVkbV9yCCVvGC1bAoFPsM6NTIGx0q856Z0Oeg93sp4/21KBbFXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770044;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PemHAwyW+U+iybF7zh11klbOzuIEsXdauTMcn9jFZPg=;
	b=4stbADrawn68EcQYKWpuQ5dyZI5mzdqaMz9Y5seHq8bq21WyDpsTU11vGM6zXGQqx0e5
	 +QVr4/HZrfJiSmuYJNLs0+EaFlzTg/h4l2PRJuIUJXaLL1ORSVI4xzT+CKXLoeP1wcQj4
	 LJNcEwfR7njzh8uT3nSUdDuaNTUNVRIW4s6w+iaw1rN1XjueQIpH2lbnZqfnFPY0eZrV4
	 gvxEDXO/fXaSYH8un7CxrN1FkTV24SpYew/siiRwuTyXq21wrZT52PVhA30ixZFyRe5f6
	 UG+BExAQUU1B7ekxofO+s/GWmotGqqCF2n6B0st6Y0bYbu3PxuTyH46JsQEEJ0RAObQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F11606A69C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9F11606A69C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f045b921caso45149435ad.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:00:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770039; x=1796374839;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PemHAwyW+U+iybF7zh11klbOzuIEsXdauTMcn9jFZPg=;
        b=VRfP1WRyLwJTg4b3GbC7fqY/ezb/IDOLy2q9CmQ5rRcSV7lmfij9BOdwpXuPgWNkp4
         KOaJYzmAjS5AjpvFIHv4vg6CedK2TnSkHDLnCiCsSiDUTY48KCxBNf7Ky/frY/W2jI3z
         bVKqP52IHuMM9ILBowP5zfFNGPpjnPq+Md48AMvXsXvxQRy90gCthoDvFBlij578qH0S
         915cvA9mLPXdewgETl12pLu393g3jc0JJgS0k0mcnW9SwslIVwHrqshN2yK4h3MGhH1I
         FAxKsBVzC0uvv9Tqeop5CFSuzNtG5ExfI2PmC+ovi6Mzu0MrCI8O78FiD0HsRiwuQrQd
         sQCw==
X-Forwarded-Encrypted: i=1; AL+hErGy4nv0LjxQTpujyEnk88dYpbBjk21NASHP5E/hU2Y4No7Q+SVjuaqeZGHSJkYeE9YYntb8NOw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+a45FmtXQdLi5I9ZzjQ+n4MghwaXrVpIXP5s++2tSPclHiwVos
	cfJDeCsHIl+4rJXOhzkcj8eAq7p88guMC33z6uYcHO5zlFAGqpX1MpHH
X-Gm-Gg: AZFdTZcyj5L3ACj3PFKDokWIsT0vS/FPWYCrgThUm1SeN4RMCDmUcLWnXPrB4gF5vAa
	HS2Fvjk0aoPzytrEBGMm7jZLrdapWH1R52FWY9A3gz6KK4FfJUYXVsRip7qokufK3kwt4704qZB
	RnUWVwZ/4wm6KbpJQ3z2rN5Z0DYA5sB/clRTnhEv1BqWHtLLyNDe+k8sxTqsyD+rCWjlDe+yAcR
	M1FFxjAonKsVy9AILfyeonTl7TB7BV/j1WcuMD41U3TWwtqUf24aVBFpGI557FKe+ikEcTTzcXq
	wS7CSYyo7v8Ci7vjaaHVx2Tc8aAa0NegszkhmJX20Qeou0X90I0WOKgADqUZCy1LVdKtuDK0lFG
	Rlj3jikTE5NfQS4gBJUBp10CvL6zwaGTNeS901dfhRicsH+UGV4SF+JzdOWmZicqjmEIjSH3F9i
	ezWIKnRfRIz2yQQY8jU0Ob+hjgkk+jJBdOWNdHjZfOIjOAVU8g6LJ0d+amwR9TiN/RBm1QD4/BH
	wjMpg0jthn4MnqIZrcaodHPtzYSDTcOD+Ip0aZny72JXdRMiYF2wp+8oQdd3uzQwHk0MI9C6f+r
	ksx9HyXWnzBaKo3lkLxuvMg9apDjH9/XG+ZTP/ov5hMW9dOZEJXP4N28v0BUStaxHKrlxCmPxP0
	VRsO9Gp9hW9XdBdgJFcN2sJpMwH1ZsGxw79ClyftDjNDTuA==
X-Received: by 2002:a17:903:3d06:b0:2e9:5ed2:c3a3 with SMTP id d9443c01a7336-2f03f188468mr235430835ad.37.1795770038979;
        Fri, 27 Nov 2026 01:00:38 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([216.236.36.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120769sm117050725ad.57.2026.11.27.01.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:00:38 -0800 (PST)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
 chris@the-brannons.com, kirk@reisers.ca, w.d.hubbs@gmail.com,
 stable@vger.kernel.org
Subject:
 [PATCH RESEND v3 1/4] speakup: Stop catch_up when the synth is not alive
Date: Fri, 27 Nov 2026 17:00:35 +0800
Message-ID: <179577003534.23588.5245624279568953026@kylinos.cn>
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

When the synth output cannot make progress, the catch-up loop in
_spk_do_catch_up() (and its local copies in the serial synth drivers)
can spin forever: nothing tells it that the synth is dead.  This
happens when the tty write keeps returning 0 because nothing consumes
the data (e.g. a serial port with no device attached), or when an I/O
error deactivates the synth and the loop never notices that
synth->alive became 0.

While speakup_thread() holds spk_mutex across the loop, any
synth_add(), synth_remove() or synth_init() then blocks forever,
reported as a hung task on module unload:

 mutex_lock+0x54/0x68
 synth_remove+0x28/0xb8 [speakup]
 _spk_do_catch_up+... [speakup_apollo]

Check synth->alive in the loops as well, so catch_up() stops as soon
as the synth is dead.  synth_release() writes it under
speakup_info.spinlock and the I/O error paths write it without the
lock; the loops only need to eventually observe the change.

On its own this fixes the I/O error case, where the synth is already
deactivated when the loop retries.  In the no-room case nothing
clears synth->alive and speakup_thread() still holds spk_mutex
across the loop; the follow-up patch completes the fix by clearing
synth->alive from synth_release() and by dropping spk_mutex from the
catch_up() call.

Fixes: 2067fd92d75b6 ("staging/speakup: Move out of staging")
Cc: stable@vger.kernel.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/accessibility/speakup/speakup_acntpc.c | 4 ++++
 drivers/accessibility/speakup/speakup_apollo.c | 4 ++++
 drivers/accessibility/speakup/speakup_decext.c | 4 ++++
 drivers/accessibility/speakup/speakup_decpc.c  | 4 ++++
 drivers/accessibility/speakup/speakup_dectlk.c | 4 ++++
 drivers/accessibility/speakup/speakup_dtlk.c   | 4 ++++
 drivers/accessibility/speakup/speakup_keypc.c  | 4 ++++
 drivers/accessibility/speakup/synth.c          | 4 ++++
 8 files changed, 32 insertions(+)

diff --git a/drivers/accessibility/speakup/speakup_acntpc.c b/drivers/accessi=
bility/speakup/speakup_acntpc.c
index a27e6bbf05da..fe19ba3f0005 100644
--- a/drivers/accessibility/speakup/speakup_acntpc.c
+++ b/drivers/accessibility/speakup/speakup_acntpc.c
@@ -192,6 +192,10 @@ static void do_catch_up(struct spk_synth *synth)
 	jiff_max =3D jiffies + jiffy_delta_val;
 	while (!kthread_should_stop()) {
 		spin_lock_irqsave(&speakup_info.spinlock, flags);
+		if (!synth->alive) {
+			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+			break;
+		}
 		if (speakup_info.flushing) {
 			speakup_info.flushing =3D 0;
 			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
diff --git a/drivers/accessibility/speakup/speakup_apollo.c b/drivers/accessi=
bility/speakup/speakup_apollo.c
index d2fbb3f57221..b62696e050fc 100644
--- a/drivers/accessibility/speakup/speakup_apollo.c
+++ b/drivers/accessibility/speakup/speakup_apollo.c
@@ -157,6 +157,10 @@ static void do_catch_up(struct spk_synth *synth)
=20
 	while (!kthread_should_stop()) {
 		spin_lock_irqsave(&speakup_info.spinlock, flags);
+		if (!synth->alive) {
+			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+			break;
+		}
 		jiffy_delta_val =3D jiffy_delta->u.n.value;
 		full_time_val =3D full_time->u.n.value;
 		delay_time_val =3D delay_time->u.n.value;
diff --git a/drivers/accessibility/speakup/speakup_decext.c b/drivers/accessi=
bility/speakup/speakup_decext.c
index 271bcf279bf9..e6be5a99670b 100644
--- a/drivers/accessibility/speakup/speakup_decext.c
+++ b/drivers/accessibility/speakup/speakup_decext.c
@@ -171,6 +171,10 @@ static void do_catch_up(struct spk_synth *synth)
=20
 	while (!kthread_should_stop()) {
 		spin_lock_irqsave(&speakup_info.spinlock, flags);
+		if (!synth->alive) {
+			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+			break;
+		}
 		if (speakup_info.flushing) {
 			speakup_info.flushing =3D 0;
 			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
diff --git a/drivers/accessibility/speakup/speakup_decpc.c b/drivers/accessib=
ility/speakup/speakup_decpc.c
index 1bf36d1e5477..cfafd9475963 100644
--- a/drivers/accessibility/speakup/speakup_decpc.c
+++ b/drivers/accessibility/speakup/speakup_decpc.c
@@ -391,6 +391,10 @@ static void do_catch_up(struct spk_synth *synth)
=20
 	while (!kthread_should_stop()) {
 		spin_lock_irqsave(&speakup_info.spinlock, flags);
+		if (!synth->alive) {
+			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+			break;
+		}
 		if (speakup_info.flushing) {
 			speakup_info.flushing =3D 0;
 			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
diff --git a/drivers/accessibility/speakup/speakup_dectlk.c b/drivers/accessi=
bility/speakup/speakup_dectlk.c
index 56334405d865..d9247c53d327 100644
--- a/drivers/accessibility/speakup/speakup_dectlk.c
+++ b/drivers/accessibility/speakup/speakup_dectlk.c
@@ -246,6 +246,10 @@ static void do_catch_up(struct spk_synth *synth)
 		spin_unlock_irqrestore(&flush_lock, flags);
=20
 		spin_lock_irqsave(&speakup_info.spinlock, flags);
+		if (!synth->alive) {
+			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+			break;
+		}
 		if (speakup_info.flushing) {
 			speakup_info.flushing =3D 0;
 			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
diff --git a/drivers/accessibility/speakup/speakup_dtlk.c b/drivers/accessibi=
lity/speakup/speakup_dtlk.c
index fa826568937b..73cd39e781b8 100644
--- a/drivers/accessibility/speakup/speakup_dtlk.c
+++ b/drivers/accessibility/speakup/speakup_dtlk.c
@@ -206,6 +206,10 @@ static void do_catch_up(struct spk_synth *synth)
 	jiff_max =3D jiffies + jiffy_delta_val;
 	while (!kthread_should_stop()) {
 		spin_lock_irqsave(&speakup_info.spinlock, flags);
+		if (!synth->alive) {
+			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+			break;
+		}
 		if (speakup_info.flushing) {
 			speakup_info.flushing =3D 0;
 			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
diff --git a/drivers/accessibility/speakup/speakup_keypc.c b/drivers/accessib=
ility/speakup/speakup_keypc.c
index 9356f6379560..e229009107f7 100644
--- a/drivers/accessibility/speakup/speakup_keypc.c
+++ b/drivers/accessibility/speakup/speakup_keypc.c
@@ -193,6 +193,10 @@ static void do_catch_up(struct spk_synth *synth)
 	jiff_max =3D jiffies + jiffy_delta_val;
 	while (!kthread_should_stop()) {
 		spin_lock_irqsave(&speakup_info.spinlock, flags);
+		if (!synth->alive) {
+			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+			break;
+		}
 		if (speakup_info.flushing) {
 			speakup_info.flushing =3D 0;
 			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
diff --git a/drivers/accessibility/speakup/synth.c b/drivers/accessibility/sp=
eakup/synth.c
index 11cba1fd8715..6a49ff475c16 100644
--- a/drivers/accessibility/speakup/synth.c
+++ b/drivers/accessibility/speakup/synth.c
@@ -75,6 +75,10 @@ static void _spk_do_catch_up(struct spk_synth *synth, int =
unicode)
 	jiff_max =3D jiffies + jiffy_delta_val;
 	while (!kthread_should_stop()) {
 		spin_lock_irqsave(&speakup_info.spinlock, flags);
+		if (!synth->alive) {
+			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+			break;
+		}
 		if (speakup_info.flushing) {
 			speakup_info.flushing =3D 0;
 			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
--=20
2.32.0

