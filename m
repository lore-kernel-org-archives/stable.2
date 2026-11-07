Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047325;
	b=c5qb5v/tvSD7qZkiV7yTWaeG2+FpIBFaoLK97fU/y4gPNY6qwsKbRE/ztzCDJzLDNfmC
	 PRwKypgDIFvAjz3FJxQ1yRceIQLUVtrOZd47cVeO3XLJGxAXjrr48I1LuN8SIZWR1kjef
	 6ZLabpB4GVF4WJoNfL9l5riBTLCQ6AHEuVN6GSnTpUCOdekXBCCv1LZdQZjDjIuqxIqW8
	 GGVDH8kWzvHXRv3c63+/ns32NHfasfAHZh72hYE9re5feDfHZSFPrjhHlFPAaeTJSFe/L
	 tclhhe0idragWABaESWyfZYqY6BxREKGAMNDVBLRnXMyUF0AQMANjORJwPCsa7hyEqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047325;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ROQSFL1v78o/xtHI7MIhMJDpEmJNrR273jFNw4Ex6mQ=;
	b=3tC30ZwmK5YFmh3F57ef9K7oUorWlKV4kNm+evS22Hyrw5WfHh4kylkP+yx6yFy1ETcn
	 CHe2P/XAXU3vl+XpqCH+JJa++RT+8CnN7HdboDEs/t73+UAzFRdMw8foJYNqeleiNb338
	 pGJi7n93WTb0qmwte8EEmJ6NjEB2Znr5Ifdnm2wklqsSr23XXfVaPaR3ga2Z9a8pnC+Vt
	 TqTCTqYOfjLbJd88JylR7siTMJcPWygOAXXL2HliIsgSFWhGibmsk4YyhV+wi32O86xBD
	 aZ81NWlqgagDuqTmm5QCLBySDalQ15Q0x9XxlN+wJbjrviI3L5+RkNqCMJoEEZ0Qo1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EZBmw/XR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E5606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZBmw/XR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4396A1F0089F;
	Sat,  7 Nov 2026 10:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047324;
	bh=ROQSFL1v78o/xtHI7MIhMJDpEmJNrR273jFNw4Ex6mQ=;
	h=From:To:Cc:Subject:Date;
	b=EZBmw/XRTrzWtxgkqMDietSKVSCMHsVDhM9UHlu7ksJC0SYvDVo1pqQqwPxcJ7UGs
	 TlvQJmfcKbA2i1L+VxkMQG1p2am3PGo74exb0wXbmGU8/fpyprx5FR+IRkn8UotYNi
	 OEbMMjXSDxRPT0QRpGc7SDF5cG4DZdjx1/2LMhhvni7Dsf3Fy+zUD3mM2NFP2xyTK3
	 rxQ68gcTLzE5QTQqcMtAir/8OttMXoMejUdGE6W/2yRygH7oswwsIjP9nlREdLXaHs
	 Gugks8PW/tZ3sVFQ8JceEdWRx51varEkYWTa4hWQiJBxUxDVcELn4hYJgWjTJs6FFG
	 SN7b7PgMs/y7w==
From: Sasha Levin <sashal@kernel.org>
To: fanwu01@zju.edu.cn,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: cx231xx-audio: drain wq_trigger before audio fini" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:28:43 -0500
Message-ID: <20261107052843-failed-6.6-a691c5498641@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a691c54986412e1fa87f036d2577d5a78a75e658
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052843-failed-6.6-a691c5498641@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




