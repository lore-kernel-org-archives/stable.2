Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050242;
	b=TUQbAzFawlPF0PnxbQFaWRzE6keccZga+Sdske0Ni1HX92OoNfrVygNef32Z77nGm4vd
	 Ek8reXejZ4p4UAWql9avTuNdSBvC76/Y0Cb41DwEA4gWG57Uyr50v3tsrRgMS9b/MB4CE
	 YgeF8sBJjXI2VmkOUI5JiDiCouPEdSeyOeiNMAkTCMsGvedjCsSz/CYGJLcS+q8utAUYe
	 MrSCd8i5Nd02bIzU6tbXUFobDNfhpAOIqt3ttRmY01zVMgByT1R/D0W+EfFryWuP8ZCgO
	 3EnrdPs65Zi3XLDDBPN7Cdo6z6sXvAEAgjM77zLlPImPuSWb9cUYzaj8atAhWQanrig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050242;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PY2P8gDgl7+L7dyYYvPJpltyi7m7PSqxa5XHNHDVO38=;
	b=QF9taJ45DxmZhD1+H4EfaTtHFz0wwnr98ig7SWbleRQkEvCRm/uqhd4kNagVd/XCGVCi
	 QO730PyNrsyHEqbT/3cyWiRPICE3QNUHa9J9/PWZ3MW6ZJSf/SCcQ/DAghAQ01Z9GERFM
	 CiQSGNJvz6/SpOq7tuXoAOvKgItiSjI9JKsJ2IpR8BwKpGYLdRjxImUiDXme01eIsssbF
	 90vA/yRwPKyCF9+yx2Fv5iIHPUfnFbiQZwbOePkB6+e//wlM5QEklcuB5IPpRUfJD8Duu
	 SKEs5wFnkJ/e/B2LF6YjB05q6Wbdrwy6JskubxucOWbTkV4CseTwd33hx41b92w2HKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WK/CJqKg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09F7606A33D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WK/CJqKg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6931F0089F;
	Sat,  7 Nov 2026 11:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050241;
	bh=PY2P8gDgl7+L7dyYYvPJpltyi7m7PSqxa5XHNHDVO38=;
	h=From:To:Cc:Subject:Date;
	b=WK/CJqKgj4Dx03OEYMaeScc/EAqZ5YlzYISP/eEpiESxspxL7yM0tWqIOE45KywEE
	 9gNdZXtPitBgIRwRMx06pn0AIEVG0ItcniUqCrkp60alsmucfwB7for4R+sC0b78kX
	 spoExupSqxKgNmH+JXthLuNYUY8BiCichgYvna8DgvdSukZR3LmapDWQtH5Rg+YWaU
	 DsEn88ejlQFrwf9t6Vn3OwBjY3u4mkNgEXDO9Ed4hJeXN0/AniH/YBOwZBlPmK0RUX
	 44gUi1caNT6f70jYo72oTDYG7Vjzu5rVNUv24lpvmHTvpMfD46lstKfO3Oh7ieJg3P
	 WRMX56iPvh5VQ==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: mpu401: shut down timer before freeing MPU" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:17:20 -0500
Message-ID: <20261107061719-failed-5.10-9332af5220d4@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9332af5220d42341bb1446a62c545c0518e990ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061719-failed-5.10-9332af5220d4@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9332af5220d42341bb1446a62c545c0518e990ef Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Sun, 27 Sep 2026 17:38:09 +0800
Subject: [PATCH] ALSA: mpu401: shut down timer before freeing MPU

When an MPU401 interface has no usable IRQ, the driver polls raw-MIDI
input and output with a timer. During raw-MIDI teardown, the timer callback
can already be running when snd_mpu401_uart_remove_timer() clears the last
mode bit and calls timer_delete(). That API neither waits for a running
callback nor prevents it from rearming the timer, and free_irq() does not
synchronize timer callbacks. snd_mpu401_uart_free() can therefore release
mpu while the timer callback still uses it.

Initialize the timer once when the MPU object is created and only rearm it
while a timer mode is active. Shut it down synchronously after freeing the
IRQ so an in-flight callback completes before mpu and its resources are
released.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260927093809.681726-1-runyu.xiao@seu.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/mpu401/mpu401_uart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/mpu401/mpu401_uart.c b/sound/drivers/mpu401/mpu401_uart.c
index 6de03d72a9087..fcf2b686f9f5e 100644
--- a/sound/drivers/mpu401/mpu401_uart.c
+++ b/sound/drivers/mpu401/mpu401_uart.c
@@ -155,20 +155,20 @@ static void snd_mpu401_uart_timer(struct timer_list *t)
 
 	scoped_guard(spinlock_irqsave, &mpu->timer_lock) {
 		/*mpu->mode |= MPU401_MODE_TIMER;*/
-		mod_timer(&mpu->timer,  1 + jiffies);
+		if (mpu->timer_invoked)
+			mod_timer(&mpu->timer,  1 + jiffies);
 	}
 	if (mpu->rmidi)
 		_snd_mpu401_uart_interrupt(mpu);
 }
 
 /*
- * initialize the timer callback if not programmed yet
+ * arm the timer if it is not already active
  */
 static void snd_mpu401_uart_add_timer (struct snd_mpu401 *mpu, int input)
 {
 	guard(spinlock_irqsave)(&mpu->timer_lock);
 	if (mpu->timer_invoked == 0) {
-		timer_setup(&mpu->timer, snd_mpu401_uart_timer, 0);
 		mod_timer(&mpu->timer, 1 + jiffies);
 	} 
 	mpu->timer_invoked |= input ? MPU401_MODE_INPUT_TIMER :
@@ -474,6 +474,7 @@ static void snd_mpu401_uart_free(struct snd_rawmidi *rmidi)
 	struct snd_mpu401 *mpu = rmidi->private_data;
 	if (mpu->irq >= 0)
 		free_irq(mpu->irq, (void *) mpu);
+	timer_shutdown_sync(&mpu->timer);
 	release_and_free_resource(mpu->res);
 	kfree(mpu);
 }
@@ -528,6 +529,7 @@ int snd_mpu401_uart_new(struct snd_card *card, int device,
 	spin_lock_init(&mpu->input_lock);
 	spin_lock_init(&mpu->output_lock);
 	spin_lock_init(&mpu->timer_lock);
+	timer_setup(&mpu->timer, snd_mpu401_uart_timer, 0);
 	mpu->hardware = hardware;
 	mpu->irq = -1;
 	mpu->rmidi = rmidi;
-- 
2.53.0




