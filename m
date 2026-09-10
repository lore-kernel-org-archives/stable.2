Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2FB4CCDFF
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067316; cv=none; b=WtF2S1m6Uu2ENX7yJon4Om/Md73A6K+I5oLvHxd1pkzDhh9R1ApPNW7A6QHpWopeOUpQpxaRM/5negq0pCM7t02jrkzMReA7Vwd/aX7tij1lZrtKvINURckNIKXZXq4fWNpDk9alAhjxft0pRYAwbwxqVPOtxOZAx4jC4Cr+YrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067316; c=relaxed/simple;
	bh=t+v0lMcuOsml9W5E3A06/7SdZaX3UfKdpDF2ku4L3Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCBRMnU3G4lMPWKyywZBgooZ5IM5xxfCNvC4Rc/sd6yUJPhM/AUp/prl6ebEafBOYi9Hz4zTkR6fCMhSYrSkcHydldzgAuikAT/0xc8JMfiX4vsvkvCBfCk/O59tEQALxBqMw82yIkuRkBap16UIiJCA3nG7vC0H/D1dgRVmJuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et1JnYoy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et1JnYoy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800021F000FF;
	Thu, 10 Sep 2026 19:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067314;
	bh=tBTiEbhk/gC6Jg187jiS+cGD087wwyyQhbroGksO6HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=et1JnYoyjnTKCXwuGIw1SBFxdkVpjKeIisyqn71OEeKUcSr/kfObyRJ366GIhqDfJ
	 KatjfkQFckfwZY9tuZYofeyZZGp1RaoPMwwVF7Pc9/Hu959GU5JLL9MqcsuuQodk8O
	 PKPRthFoIZAE8rrkNrRdpOB1gOatO5Y7nWfhGbVlBvtYLMZGDMkBW453ZDkX8AjWIF
	 GmrYVclfocaQ1e9pZhK2doCC3f9LiVA6ueaPmzJdGduaohSgkOpF2kDSK1dDR01xrz
	 Qy+cJKvFeaNKla515kNnpZRO/5sDaCPIQjOHhYzJcQlJQOZWA7uFE6plBoB34bp8Wo
	 JbzHaMlpwp0gA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] ALSA: parisc: Fix assignment in if condition
Date: Thu, 10 Sep 2026 15:08:32 -0400
Message-ID: <20260910190833.1452894-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090915-crucial-humpback-b546@gregkh>
References: <2026090915-crucial-humpback-b546@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 6ea9a2b84cc354ffd028195edb4e3d60d47f7bcb ]

PARISC harmony driver code contains an assignment in if condition,
which is a bad coding style that may confuse readers and occasionally
lead to bugs.

This patch is merely for coding-style fixes, no functional changes.

Link: https://lore.kernel.org/r/20210608140540.17885-67-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 33abb7491e89 ("ALSA: harmony: initialize locks before requesting IRQ")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/parisc/harmony.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index f2ca0a701987f..1440db8b4177f 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -915,10 +915,9 @@ snd_harmony_create(struct snd_card *card,
 	spin_lock_init(&h->mixer_lock);
 	spin_lock_init(&h->lock);
 
-        if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
-                                  h, &ops)) < 0) {
-                goto free_and_ret;
-        }
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, h, &ops);
+	if (err < 0)
+		goto free_and_ret;
 
 	*rchip = h;
 
-- 
2.53.0

