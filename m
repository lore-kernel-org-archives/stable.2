Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050089;
	b=21Ov2qJOMgm5S2r+66P+p7OoGO5Z5MJ0tmwbK2/JQkNZZtMJOxRnYy9yxOfKatg/gyif
	 CaywUDkWcFx96NWPgeoMrrQkgNZqEdHHwnhKoKkSvjGlWEDnWBxkjPZUT1T/29J6PegnI
	 UT9Y039M2FcJc/Ao31Wh5B2+K0T5NAPmbyJt/bd/yNMVxkn2RTgzIiY8e3wPli+63Bv9n
	 GLs3slh5Ff69DRPfZSbYJ69hgDxCiC3M+WedUPv6Fn1E8eoT75hWsw3APxUUjpVFz00Eb
	 BADPXSZzfuzg53glhX5Xr/e+UdmQ8Az+QOXaoP6tTimDsAinYfGwp7YCE9HVzBmSX3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kDwZ80C176t4w3c9T7kE/Pa1zGVCn4iMXeZGU1RuROQ=;
	b=2HiKflKe9Mmp2VuZDWJEMrze/a1mqIa0RPp4roucqITNCQIXzIenSOKNSwwkmXM3tbf+
	 1WNoTD9Qzh6eYrD3XWSyl29OaODlrKkQOkVTMbab0eR1S/oZ67zQ4Lm4cHLOptH5BrI8X
	 t9uE+iuAWw7/MSeULdyrHNxaE0s+XyLsvzXpyA4oJGJtwXq+2JFbbthgRi6GJE6xKEYU3
	 fdVfkaVBwb4EQYWmeBtHXj1pqFsghAJXeopU+wcP82yoKfkGzf38da8P8cQ2EE/pz9JT5
	 5PWpYzlt9MQ2395vD249JJ6HXqbqVwRB+vHkybV/HA3iYtcq94XVdtmhtnnCx1D0ifA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqXkLTe8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB315606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqXkLTe8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2805D1F0089F;
	Sat,  7 Nov 2026 11:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050088;
	bh=kDwZ80C176t4w3c9T7kE/Pa1zGVCn4iMXeZGU1RuROQ=;
	h=From:To:Cc:Subject:Date;
	b=CqXkLTe8vLYfl9pCP+3uAsAtoh/LBrKgTAtBtDsR4WLcy3r3I+mLrYYMxsWIb6cWL
	 hnXX4h98ffW3HfdRa1UesH9jgM6hj8M7ht1edJxcAG04jwUUANDJ/gwRmGqX5d/pD/
	 Yq5FsAB9Qp4WaP0l0UF1j6j5GpgWykw/LtxP4hqNnUYq7TSR1gEZuSdtioKFfLb3nE
	 HykY3sAvR+32Rzdb186Q7zLKC3UUXLMPfx3NBHfTaG1MovM3DYgQQorZUQM3PpvxGf
	 tpbvvPqYrj6shHf16XQ9rdUhN1jzBPY3ptVoKKtoYI3EN7oMxozXioqjuHvHRqOqUV
	 FqqwUvYqsuqqg==
From: Sasha Levin <sashal@kernel.org>
To: fanwu01@zju.edu.cn,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: cx231xx-audio: drain wq_trigger before audio fini" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:14:46 -0500
Message-ID: <20261107061446-failed-5.10-a691c5498641@kernel.org>
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
git cherry-pick -x a691c54986412e1fa87f036d2577d5a78a75e658
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061446-failed-5.10-a691c5498641@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




