Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048078;
	b=hg0UkcO+QuoHoyvo0eVbZedKw0Y5TpE7ln+4wYFUulYzZdmSDiTquPS/9luHN1Z08KYj
	 iLnqDCaxc/2iB6EfUMJAS60GxffaI+gHog3SXiMuwAfOfif8t1KkENpelyCID66nDV/L/
	 iC9l5DvhBz+UN1DlO3v2IxN37k5pQ8QE2InOum19xWkvAAGV3KoviZXxZEB/wJo6S/qfE
	 WSd/s94LPRBT7N7Z84TwXZ/sPaxtZeBHedSvIC0cYSQFHR2MexdJ4WmqnR8woy236KIQO
	 U2HI8PDDyHJd6rveuZzbk+Y06+R681/5T3RvZoWqsENqjMqFwfmMHW100jPFVOA0QDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048078;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DtAXfrkGdc23dgFxb4mmiM3gH8dw/fUWPX+NCm87sMg=;
	b=vlFbXfzgoASZVIjhFMJyCzwe6tBM+pb/0wVckPCuLEaoSZAtcMTZ5pQvN6fauRLMZSfk
	 ySYClL70ZiXXjBP6ke/aS1e0wpU3cfPVgueAt5Z8Ft+M/TLdAOeb/aexms6ycp7ucVeML
	 Uqg9BqOHrtR/meCYqEhppc0gw6d6AFnL3diFOMtbP5p0M+kmKTUCaTHNp5fKK45rUDXFv
	 WB4uSNTuoEgab7G/fQT0o5CfhTehY+Xh8xY3xU0rVG06hMCOfrn5QcO7N9bqd/Lj+1iU/
	 TewfIkHjnDfso3PsJLY9jnw84yK5/2XVZvebMqPlcwsoKRo1OyMLHZUbdSQ5WpuGo6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PboHj7q8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2BF606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PboHj7q8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8903E1F0089F;
	Sat,  7 Nov 2026 10:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048078;
	bh=DtAXfrkGdc23dgFxb4mmiM3gH8dw/fUWPX+NCm87sMg=;
	h=From:To:Cc:Subject:Date;
	b=PboHj7q8BKLIJb2E2b1tDWEq/pubnn17UwVoAn+0Twyaguqfyuxra2z+abR51661B
	 jgjTMx56Trsi9OSsNOQST+3gxP+PWjDPrcWP9f62GbSafgQDcdybdEoREndb5QhTzR
	 ptLyiFBB/7O9atQIepAj81blLobL/I+GlBUqBMvBJ8wWump80FZKiSQ+8ThJk/Ev3B
	 eB3p2vhe4xxYy8QR8TroD/lu3jzbPCh6Vsa8SapOfKkYlsJL9w4fLCRgST5SDEZAos
	 yitw/6pi7a9/+8UWPaEfXCuOrU4USxEn1UPilD/JnSdx7pPyQHUIWJ32Db3fxJ+ATY
	 jrLF8CnqHOVhg==
From: Sasha Levin <sashal@kernel.org>
To: fanwu01@zju.edu.cn,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: cx231xx-audio: drain wq_trigger before audio fini" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:16 -0500
Message-ID: <20261107054116-failed-6.1-a691c5498641@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a691c54986412e1fa87f036d2577d5a78a75e658
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054116-failed-6.1-a691c5498641@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a691c54986412e1fa87f036d2577d5a78a75e658 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Wed, 29 Jul 2026 07:26:13 +0000
Subject: [PATCH] media: cx231xx-audio: drain wq_trigger before audio fini

audio_trigger() is deferred work (dev->wq_trigger) armed from
snd_cx231xx_capture_trigger() on every PCM START/STOP; it dereferences
dev->adev state and may free the URBs via cx231xx_isoc_audio_deinit().
cx231xx_audio_fini() tore down that state without draining wq_trigger,
so work armed before or racing fini ran against freed state.

Use disable_work_sync() in fini to drain the work and prevent further
queueing.  Initialize the work, lock and stream_started counter at the
top of cx231xx_audio_init(), before any fallible allocation, and clear
the partially-built audio state on its error path, so fini is safe even
if a later step fails.

This issue was found by an in-house static analysis tool.

Fixes: 61b04cb24a12 ("[media] cx231xx-audio: fix some locking issues")
Cc: stable@vger.kernel.org # v6.10+
Link: https://lore.kernel.org/r/8c7e1294-b906-4636-890c-b64d03b0e1d0@kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/usb/cx231xx/cx231xx-audio.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-audio.c b/drivers/media/usb/cx231xx/cx231xx-audio.c
index b24ceef497e4c..af04fb104cc4e 100644
--- a/drivers/media/usb/cx231xx/cx231xx-audio.c
+++ b/drivers/media/usb/cx231xx/cx231xx-audio.c
@@ -581,12 +581,19 @@ static int cx231xx_audio_init(struct cx231xx *dev)
 	dev_dbg(dev->dev,
 		"probing for cx231xx non standard usbaudio\n");
 
+	/*
+	 * Extension init errors are ignored by the cx231xx core, so fini()
+	 * must be safe even if initialization fails part way through.
+	 */
+	spin_lock_init(&adev->slock);
+	INIT_WORK(&dev->wq_trigger, audio_trigger);
+	atomic_set(&dev->stream_started, 0);
+
 	err = snd_card_new(dev->dev, index[devnr], "Cx231xx Audio",
 			   THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
-	spin_lock_init(&adev->slock);
 	err = snd_pcm_new(card, "Cx231xx Audio", 0, 0, 1, &pcm);
 	if (err < 0)
 		goto err_free_card;
@@ -601,8 +608,6 @@ static int cx231xx_audio_init(struct cx231xx *dev)
 	strscpy(card->shortname, "Cx231xx Audio", sizeof(card->shortname));
 	strscpy(card->longname, "Conexant cx231xx Audio", sizeof(card->longname));
 
-	INIT_WORK(&dev->wq_trigger, audio_trigger);
-
 	err = snd_card_register(card);
 	if (err < 0)
 		goto err_free_card;
@@ -656,8 +661,10 @@ static int cx231xx_audio_init(struct cx231xx *dev)
 
 err_free_pkt_size:
 	kfree(adev->alt_max_pkt_size);
+	adev->alt_max_pkt_size = NULL;
 err_free_card:
 	snd_card_free(card);
+	adev->sndcard = NULL;
 
 	return err;
 }
@@ -674,6 +681,8 @@ static int cx231xx_audio_fini(struct cx231xx *dev)
 		return 0;
 	}
 
+	disable_work_sync(&dev->wq_trigger);
+
 	if (dev->adev.sndcard) {
 		snd_card_free_when_closed(dev->adev.sndcard);
 		kfree(dev->adev.alt_max_pkt_size);
-- 
2.53.0




