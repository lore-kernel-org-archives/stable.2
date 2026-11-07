Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049245;
	b=uC5Nc/fyFWloWTsKz0mgcSUcL+svvIaNbrJ9KBQtRG6M7mgxHEnTrmaG+rM4ZMKQYMPd
	 Wc0OlvnxZIzA7S70Rf4doNlk6LJuKsefCCUl92/gZLtdTY95EiIvdqAz6wthxK1uMmMdo
	 /u/Se8UHG2DmPWHgy88GOeGjpmPdqRj6J+tqhjZyV+hWrV7wGzt7Jcq154GRAqDpBuWBy
	 e9RohxuROrvDAclZdKHBqMgd6hpNE0d5nSowqnSwOUkhPx4CNBgcvmShLY32anlmPd72L
	 JCPkT3aTHJbeam6IJsRO7ig7IdlQwQpMmeb6yU83hkh/Q+/QnO11t24QyECjAzE4Eng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049245;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OHUb8d15uWxvSxnE3N7eQMHcIH14zJStmXLTE1uKIU8=;
	b=iuciySPuhT5LcZNrUovn3VOcQwH8c74nMoaSoyqc5pI4kXR7WFwCVgw0Rh8+ox0SbGQo
	 5hsxrV3MLQZqF3+6BfLNFugSnNlyXtDe+GNvwH9pubZy3+XmtwiG99w6HqrNjPSVpei9p
	 zNaVpJaOegrfF/UmFyUH/vSjVg06mPW3RPkdNGAC6dfvUTp2/QIaOHq5gu2/mSxbXtjWa
	 mNHbpv5SrdGLGeq+iy9H+Wjr3THpWcuOiIiXi546p6bw4WwDqTjG85ECSvTkxQTLnTLZv
	 fxx3cGu1xNAxovom6h5GVfpMROM50ODul+Aa754cxueeXxL24XamsC68AKJr6rn80EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YPI/0XUD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6906F606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPI/0XUD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF5A1F008A1;
	Sat,  7 Nov 2026 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049245;
	bh=OHUb8d15uWxvSxnE3N7eQMHcIH14zJStmXLTE1uKIU8=;
	h=From:To:Cc:Subject:Date;
	b=YPI/0XUDuDD48C5DYotp9W/ARQ/BTtXtSoCV4D1oD2yMrIGvpg00aTQkUnY2erZ/Z
	 ygccLoUwmqlVWkGPT1yt4PPrOqojH0O8nIuzjFFYI5kocgVL1IhnD4/alJ3NevTEw9
	 mulMgvcVChu0UMTGtDft5609h4JWwpNnhnL1dQd6ly3pi5DKtLWF0y95NPY7++jZOm
	 muPGcXiWQHIiNmTVIGUSqlUltGlw9a6JGsln9F2RTqCiobwr17bXMf8ukdqP/lndvb
	 LfQyPNotIgcNEvCHIj48KptPdK2YDTCPKY4quAPT9gOpBklBmrihVVnDzkqgHmdq5/
	 diN65XZdfVxZQ==
From: Sasha Levin <sashal@kernel.org>
To: tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: core: Check shutdown flag at D0 power-state, too" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:00:43 -0500
Message-ID: <20261107060043-failed-5.15-ad63c5b62843@kernel.org>
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
git cherry-pick -x ad63c5b62843895e8c3cd7291ed07cc659df0355
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060043-failed-5.15-ad63c5b62843@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ad63c5b62843895e8c3cd7291ed07cc659df0355 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 29 Sep 2026 14:53:41 +0200
Subject: [PATCH] ALSA: core: Check shutdown flag at D0 power-state, too

The snd_power_ref_and_wait() skips the card->shutdown check when the
card is already in D0 state and immediately returns as successful, by
assuming the all-green in D0.  This assumption makes the code after
this sync point behaving as if all power is up and ready, even though
actually it might have been already at the disconnected state.

Add the missing check of shutdown flag there for the more consistent
behavior.

Cc: stable@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260929125346.1478631-2-tiwai@suse.de
---
 sound/core/init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 1bcb6a2e75507..a51b71812fd9b 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -1174,12 +1174,12 @@ EXPORT_SYMBOL(snd_card_file_remove);
 int snd_power_ref_and_wait(struct snd_card *card)
 {
 	snd_power_ref(card);
-	if (snd_power_get_state(card) == SNDRV_CTL_POWER_D0)
-		return 0;
-	wait_event_cmd(card->power_sleep,
-		       card->shutdown ||
-		       snd_power_get_state(card) == SNDRV_CTL_POWER_D0,
-		       snd_power_unref(card), snd_power_ref(card));
+	if (snd_power_get_state(card) != SNDRV_CTL_POWER_D0) {
+		wait_event_cmd(card->power_sleep,
+			       card->shutdown ||
+			       snd_power_get_state(card) == SNDRV_CTL_POWER_D0,
+			       snd_power_unref(card), snd_power_ref(card));
+	}
 	if (card->shutdown) {
 		snd_power_unref(card);
 		return  -ENODEV;
-- 
2.53.0




