Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793668485;
	b=lljTuG1CLgfMDPhJz0okBmjTlD2z3rO6DwDZfxVDjP2AJ1F4geOmuhQoJpj0xx5u3oDp
	 Yc82aUPDj/536b8Vybw4t6FG30jtkvBAx4nEY38IgssI/8OugYrv5hEwUDUvEBNnTz622
	 BxICYbaDWPXMZSm0yi0B2V3ofNexCr6y5Bf3lIp6aK5FVaocFnIZhblcaDX6ccMHK2xXK
	 cVPb2r3J7+cjHp+1KJB/Q3D22RJdvVhToMeQyz4fv9mUgKf2C2VtqfuVdXC03SgqtX49O
	 FhNRqLnYUdoIYyzNbdFsVXC6Zj37a2uwjMFvc7Y5CI5HbgDdPmbUl3USGcyvwXzv/zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793668485;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PemHAwyW+U+iybF7zh11klbOzuIEsXdauTMcn9jFZPg=;
	b=kuQPHFuzMQ3MVEqF9XGNNGorEKYzL5VfrRtUNMwmt4w6+eUSrU2F6MUE9NUCzUjb3t7l
	 uWzS+HDM5Vt6YTMiVtqQMjqsbkrTVH5fxb+uTKyl+hGfCYOMEbU3vFcog+iLLoHXsQaF5
	 M10UH4LLOyF7JiOk/jTVWcA9IdWab2ZclmzRVLIqihlNOoank4+8Ky/GsOwSq1kH0Jgn9
	 KK+2LRKB8WjTdVftJu0XqM5Wx6sGjj53m4QHxiNPkKIpYZl49uS11Cg4uDW1Dir0Lmd6t
	 EuNrd111dtHft5PXY+mguWOc6BUJgH9KRFpppbAoSI9maio2ATEdWzR5WLHz8A8W3Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB90606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 01:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DB90606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-353804b591eso6421628eec.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 17:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793668483; x=1794273283;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PemHAwyW+U+iybF7zh11klbOzuIEsXdauTMcn9jFZPg=;
        b=D65YpSZF2zMH8v2ioibrNs3wG9KszbsQueIWyI7hpeVK51T69t55HtLQPR3YH68Whb
         3RVCL1C842i2t7v8GSOSpMOxyeDBph+xamExfVRmbyJAz3fKPMUaPaDHPA2mwwUP9Igj
         ezFtKAtFy+O4UVLED+9jsoQ5A3iXNOn5PQYpGJmgmGTQubw8vMx6lFrpUxKUyCEJTfqS
         veaoPtxsOUUDfRsl/fmD8D3mHTjV6jZgE/JgDCUtpav2+Y/uyn4Gap+H7Cr8EFidsqrZ
         XK9Bkw4obyb3O/8RQtMtAQc//b3bF4KPIa4dSk8X+Q//Ly5ziAJSC2Uvs7zzg7Hn6dhJ
         1xkw==
X-Forwarded-Encrypted: i=1; AKwUvByM6kTNj8NBhBTtxHY5sqxKl+QWR7YcXXXrRHXJxuB/4bjBxb7P2wadLJWfVZ+CYLH6Jf0I8B0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bBolAPd84bruBnI54vz7M1yqZ08SuS1xm+1NzVPiejab8zxHo
	SgK3WJKPjKJGuIkaHpKS+vPPLdRV5R9bva+gQRYdMsegNyVLS3vSCutN
X-Gm-Gg: AYBFou1i5/tMsVZLJBQanr2RvbIfFqdGakl5PYvYvXoS/qJsM4dn1xaDicS0NEKFhad
	r8xo4uHnvtg3V/opvClvTevYkK7na3h4x4edgbAMn/TU0PJsDiWCsVqhLbf8CKJ5bG/4XlTfh5W
	sttT5aaME6D47t7xfPu+TI9typENBvE/WAJyntEwY/cf2p8ESqew2IM0Rc+LUZw1zAitvC2GSm8
	TqtUuAys+IAfE/pyo61eoDsYP38ReHGND6kqneDpKa56uuVpKBjoWRkL2FS5p9GtqTrXVWUPDw6
	Bgsx+FecOEXTHPutn9yl4hgHYeEcqr6wjdKWQr7FzTPO7v7Wka//HyjpOnhOqqJNZ53x6+YdfDI
	VAHdD8TcFG6p79JgUQy3bebbRYn6YQmE9In/HmK4lMurPG/FDaZ8qA9BQ4XB6Ch/d1zq4+0iShs
	cul+YX7MKpTj+7lnfqIQuIa8V/1KMEwQbQu87PlCPOCXYY3muqOk3XdJcx0LrhOVJOR238277G/
	ruIM62/R9q6h9J7I0t9htNyi8dJt2cYTvCQXnlILijJLKR1/d9pJ4AaXzE16JJG0kKI7i5hkDDc
	kryuKO7Vr+q9B8pbsMEXnvZX0+4aFUh9ZQeGEI1fpEzg7g0Tz1z+TbnednCH9tFsk2NTpokEolP
	9Iy+gEh2ZxG9iR/1wmwzt3ZAmBMSTw/1B5YiqDA==
X-Received: by 2002:a05:7301:db8a:b0:36a:279:c93f with SMTP id 5a478bee46e88-36a423fda77mr17577768eec.33.1793668482843;
        Mon, 02 Nov 2026 17:14:42 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2602:294:1:b9:a2b::1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a426681aesm51988583eec.1.2026.11.02.17.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 17:14:42 -0800 (PST)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: samuel.thibault@ens-lyon.org, speakup@linux-speakup.org,
 linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, chris@the-brannons.com, kirk@reisers.ca,
 w.d.hubbs@gmail.com, stable@vger.kernel.org
Subject: [PATCH v3 1/4] speakup: Stop catch_up when the synth is not alive
Date: Tue, 03 Nov 2026 09:14:39 +0800
Message-ID: <179366847964.70545.6676783028105686328@kylinos.cn>
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

