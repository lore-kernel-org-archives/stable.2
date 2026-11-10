Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319422;
	b=B2lUMAbzV3ID45LJ5VyoZ0kWyEo82Rh6/Paf2zZwot8JaZWCm3AB5d4CICIXxZrQZHo+
	 6Ny/4tcZRF1V5iXivKPruuMrZcNvkMANndgRaaJS0ooEiyMNuuAiuD5D9OM7tizt48+/A
	 ZBHGTarBwQ+VRb3n74qRfxZArP66JxJdq4ZiV6Y8wSuCxqV5VfCAnEUg3O5cnEck3eMun
	 W7iKfSMhWn/xbn+3eWfetevi8Xom/x38jqqDB1movNjiwpCfHXuR0Y2xIYOfBZ5fU9o2G
	 opV0Of4KXe6x3oJSE9f44M24eD77gpYXRJgCkfF0RjcKgxXdiAU4XSb2ixvkcwRdPtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319422;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=a7pDtLmsXL7P1y0OA2Kp9DWSeH19f2kZ2sKmXvqUt+M=;
	b=Kf9FxlqaHSkIrZMRU5lnkTiH3oPIhQIxtghgwuY7sgDdx0vc9LTe5dg21bPaJpPrZtlx
	 sLoWH2oPFVv/tDLVGj5cMY7k+HQHhm2gnrj3THN6iiDymMUquSQRY70MvJzXTdgpUtfoI
	 zzl1OhIHkKmq4S1UUwuvgS1mQdhVrkIpEwzyaZyQWx6Q0sqNEdoSB5wNHQSehQAClk9Nj
	 coTkdoo5BgsrtUUjL64Wkm7qQQMcQKWQDvlaGEDjHAXpAZubaUVrf4M2MuUbaqqhL2yT7
	 4y79gk1CFJS9UrnF2rpDGHcL+AGUl9hoAC91LcWckK9E3c4mMzmvJ1gUvC1AVfIwppw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L12jlbnv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DC1606A334
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L12jlbnv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6726E1F008A1;
	Tue, 10 Nov 2026 14:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319421;
	bh=a7pDtLmsXL7P1y0OA2Kp9DWSeH19f2kZ2sKmXvqUt+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L12jlbnvEx4tIlsD0P69JgA03k60jQz34bhmwNNh7F86RWz0NlPR0xXwwR+YAXdW0
	 2+6iP0kCVUejYb/eLIeMbxmvN3Z5arp3Qkt1QaxQ58IU2wsUMrVomFWnOd5+zupPX4
	 gSQzQgJhza2B5E29wSyNKFaYWo3GuQWCKnrYpTUo0MniqOy1mbJtRg/KaabsMW/DGy
	 6fMHSDwdM4s5L8zATltrqYcW6GEp0yVljvmVfxyK+qEzyqerQCyLBEkIRrWRFr/0Gl
	 40ZcnK48tIP7RSURahzxFGl6rUHK3keU71wA7SqyH5guMxxvRHTPVdSD6AvDVLar7D
	 PgvF4KW2v3L0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] ALSA: core: Simplify snd_power_ref_and_wait() with the standard macro
Date: Tue, 10 Nov 2026 09:03:38 -0500
Message-ID: <20261110140334.1822546-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060043-failed-5.15-ad63c5b62843@kernel.org>
References: <20261107060043-failed-5.15-ad63c5b62843@kernel.org>
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

[ Upstream commit 8c0ae778e2874f3742bd619000b791d178c187e2 ]

Use wait_event_cmd() macro and simplify snd_power_ref_wait()
implementation.  This may also cover possible races in the current
open code, too.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Link: https://lore.kernel.org/r/20220119091050.30125-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: ad63c5b62843 ("ALSA: core: Check shutdown flag at D0 power-state, too")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/init.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index c0e7d4962bbc9..e9465b31f9fda 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -1154,29 +1154,14 @@ EXPORT_SYMBOL(snd_card_file_remove);
  */
 int snd_power_ref_and_wait(struct snd_card *card)
 {
-	wait_queue_entry_t wait;
-	int result = 0;
-
 	snd_power_ref(card);
-	/* fastpath */
 	if (snd_power_get_state(card) == SNDRV_CTL_POWER_D0)
 		return 0;
-	init_waitqueue_entry(&wait, current);
-	add_wait_queue(&card->power_sleep, &wait);
-	while (1) {
-		if (card->shutdown) {
-			result = -ENODEV;
-			break;
-		}
-		if (snd_power_get_state(card) == SNDRV_CTL_POWER_D0)
-			break;
-		snd_power_unref(card);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(30 * HZ);
-		snd_power_ref(card);
-	}
-	remove_wait_queue(&card->power_sleep, &wait);
-	return result;
+	wait_event_cmd(card->power_sleep,
+		       card->shutdown ||
+		       snd_power_get_state(card) == SNDRV_CTL_POWER_D0,
+		       snd_power_unref(card), snd_power_ref(card));
+	return card->shutdown ? -ENODEV : 0;
 }
 EXPORT_SYMBOL_GPL(snd_power_ref_and_wait);
 
-- 
2.53.0

