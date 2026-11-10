Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320218;
	b=qzYjNOTIBsukSppa+H0LPrQv+nii8kE8PFuNgqWdnzGWpo0657l8aQ62PeQKS/VYO5l5
	 Zop+4fL29yRTyvz70PWt6f/e1EpXBVAdoAmXRZU5HzOxSEume5oqIha7hyA9WwO/h0d5H
	 tWWh/kfxHv6QinWavJBYRlPM4zVzzhiMsSJB4wXpKQmFw4fefkFHgKgrTSN5VSs29tbDm
	 bGZmr6hgBnSw2vLRvfq0SMSOUyU89qZRPNj9YoVdNdG6iQjpCtzw07XE2pUHyzYPxvVlr
	 Ul+pBrJaOEq3HNf0DzdADGW/S1QHSFLcHwILO1Kc8XgVh/2IWuFPURzZVEpNprhMZ+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320218;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UlsqCNa5mCt9x3HgjtjslCMCcO36oj3t/hXku7xA2Gw=;
	b=2Ey5X7NVllGlmdil+4JJn/xQ2WL7Bg76Oc3ZWpKPtuN8DY887bdYVuDBI8EcTcW3ZD/v
	 qJ1X7iw0FSmamPtU/rpdfrlHTCnC86zkFH6uoKWBcufC7oLlIMGSEe1GzpkbkZaEherw7
	 5h6/50fFfDTo67LgoZflYc5hfwIn10jgGq6lhS2ptuxBwlnSsXFKS2OzYEEpdficxZOPV
	 P/0f+Eh74WPLAmC0uMenfSH1VWEjb/AH7xapHB3PlZVFbQJPEvxkymJBbVkydq5tFWj9Z
	 aP9iv6aQ8rF+0Xdy6r0hcKqkrtE6pH7tLnwBSHV3aM/r8B1vWb7CAL/+CiR4As7Ty9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUS7jmK0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEA860A2606
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUS7jmK0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC15E1F0089F;
	Tue, 10 Nov 2026 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320217;
	bh=UlsqCNa5mCt9x3HgjtjslCMCcO36oj3t/hXku7xA2Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KUS7jmK02Nd8Zf+Ix6ilERMEvksSkGiZVKh/ux6RSPsAPVA3ElaQz9Ulrbo4U8Ftp
	 dpw1mMZFCOtFYw878x9Fu5VynnjvmqDYBEazWsqUFzSAHNbZ57GmVIzyRnCKqEvNq0
	 1r9msOL9O36j43KFqsUPQ9bu0hcSpOQ6ujN33pwdayiM0JZCWyzWG0Gi9ODDDZ8w5H
	 Xqgq1bXf8ebZDd+cRI+419/5iE9kip4swEn/tzlRs2QnTaQ3a7zTU5d4QF97MUJQ1I
	 kGCkkQYjcE1kbQHAKA7C/Q4e62P21gxpLMWpUUl2BK3j2sEyLjJ8Nb5nnVFNtL0Iot
	 buF7R+Ncmp5OA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/5] ALSA: core: Check shutdown flag at D0 power-state, too
Date: Tue, 10 Nov 2026 09:16:52 -0500
Message-ID: <20261110141408.1841234-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110141408.1841234-1-sashal@kernel.org>
References: <20261107061731-failed-5.10-ad63c5b62843@kernel.org>
 <20261110141408.1841234-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit ad63c5b62843895e8c3cd7291ed07cc659df0355 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 1759ef9ae8b4e..e55f95eb2362f 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -1015,12 +1015,12 @@ EXPORT_SYMBOL(snd_card_file_remove);
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

