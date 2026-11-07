Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049072;
	b=jnY0erE4YPac8/u4P/iGw1xvbD8Xmt/LmiNct8abNd8MKBtN9MZpzbmifRC1/fJL/kOg
	 Hs+rW0EzOMs0045rs5MTpe7nUlSVTDqiCHgvOmhfuuRJglFOJhLHC8MNZmuBZEuZf/DMY
	 TAH1+ZzYcA8viVyrTvWvTUTM2F7Mryt5MJuKz9IYzMFeRpmpAm8iy/BdlE78drVMdcL0m
	 uf0dddT4ipTzcqw38JFMlFxEPFGt/+9pTUnafrNKUyOyAmwtKJZMDmGaeByq2ZbT7cOyj
	 7g7o5M/0QvAu1b/M25ugIJQiv5GruoGqAIEYngq0NGjhVTa+bIKvFQjMBL0Zf5q+pXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049072;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=i0mddCIcQZ/IrDfwO3x3K7Y4J62hzK34tP2n9IUMc8s=;
	b=DZo5hkPIihr45njdR3GCTcjZFQ9jJ8S9s9QgCoMFI6kdtnAbBZV4wvGz0Zp0HL/cY9G+
	 d5/9gchYPdv40Hs0TQWanEP7zXLXM4X2ZK7i8D4Fje/MXU5+djV7i5iCAtDgBQ8XnSF1D
	 s8AzoQHow9QQZrod2P9MB1hFgnnAQT89lPxWYNGggSpZ4He3/6hWLfWwyYGrFVKZezCPh
	 69eorX8auy/yIWIfQWjVLcaPQlQG2RiMqbO/HVXeeEGb+vc4s+w4lt8ZRXsZftLiZeDar
	 0vz15yGbpkV5lBJBvDhcqY8xQsgGmrnYBnqEqKRA7M079OPooSsaO6l31Z98yvWpkQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNvsFTAA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242BE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNvsFTAA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CB31F008A1;
	Sat,  7 Nov 2026 10:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049072;
	bh=i0mddCIcQZ/IrDfwO3x3K7Y4J62hzK34tP2n9IUMc8s=;
	h=From:To:Cc:Subject:Date;
	b=dNvsFTAA8xNvpcRSbKmky72TYQ5nDtXVWxhsrPR07ZBaObu2S3omwsC7wt6E7R3S6
	 CLCQBAlSWLXXGjzS/nhZ07DoqMdmj/v0S1iNtUZOHfYs3nsPyqAG9JykUza+UczKcY
	 n+36ygB9+xd7i/N62YEWQCazjk2cf73EAzb67rCNjl8br7mP+3ZY76cOGeL0QJk4Tx
	 uuXICfEDATaY8k+cFeh6ZljpFv3SWhRqBmZ8dRrOmL0bBdr8SH1L5pbJOMSk0HrBZ9
	 cm307hjOKtrHKGQuKcAPFttkv3GKDyBsH0akJhsO1n8htpLg5SkaEt1+I3c0N6jJkT
	 vpKjSqVQjgPVg==
From: Sasha Levin <sashal@kernel.org>
To: fanwu01@zju.edu.cn,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: cx231xx-audio: drain wq_trigger before audio fini" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:50 -0500
Message-ID: <20261107055750-failed-5.15-a691c5498641@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a691c54986412e1fa87f036d2577d5a78a75e658
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055750-failed-5.15-a691c5498641@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




