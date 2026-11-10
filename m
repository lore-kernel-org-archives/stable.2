Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319423;
	b=Eh7R2cJeJsFzSYd7dG21yoRgD5WyuJlK5ytMXPCEUJVDTMKg25953EkINaMn0TqxiYAG
	 H1Vf1gizzUQVjizXFQlof1XghxkOYj09zfKcRj+9XdDfOAXvI/30p6iRCoqkKeEKL/+ga
	 tWaaW1pTpMz/8tBEewC5zCNWNMS6wAjQHpCRSQcj/MsPmKMFE5jf/eLU2iieutY+v7Zmq
	 Fg1KWIW+LIAdzoo8h2OO25appuPXVd/KK8WliFiGNQJI8HUZaM4aAG9qFaUjuvbDL0NAc
	 21u341LlPseSo+c5i4NOMzu0q6d4tESZV0/iogruqpADTsPJYOoz0dzKE09tbnpGswg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319423;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hfYhbbfDp/BxeN1PSKcstpg1wjlp3WC/So3XcJD7BBc=;
	b=rQtXXwOudN9P3pSCAwmJAUe08hk7AKhuKI0PXywgnRFaz5KY93otQQEXyahclX7QBR48
	 +wQdz5yI34oEp60YM90iha8YhZLcZtwT0a5OWrqC132xCqJbCWq0lZh2iH4mOTngcnNCg
	 lkfucGy6YoiUEKzs6a8cGeXRjvPkaIa7uylceetu7tUWQIfH1mddOxRwKNA8vELEJjmQ4
	 YaPntYz2ZM1WAh5mCbv1zdd5y+l1LF7axl3NBz+Xt+2GCTPUFN6/dAxt2OzWMk+7tVws9
	 WQcZLv+oIUBBtdMKH7ve9hP3hf6ExPVormiWsSkpen4qTFewH5mPuEc5Em1V7pOohDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5FM1Ky0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F3560A262D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5FM1Ky0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314AF1F008A6;
	Tue, 10 Nov 2026 14:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319422;
	bh=hfYhbbfDp/BxeN1PSKcstpg1wjlp3WC/So3XcJD7BBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L5FM1Ky02RKYsAvHgM/W4f2vy8++OXcj4kAhsL+gTrCP4020qEiQ218qLwDs8x/j9
	 T+BN+jJFd4Yy10K9+dpUwK3c134J9iZsfBfGsYWHOhkbRsouCHOZQZdhG1N6tcg3MJ
	 87uTSiWqwxtxxg72Q86Q9vVndwxVenWgcpQ+AeGNE/uui8q/VUH2CILq31Iz4AsRnV
	 6o5WH5SECHmE7SPewrwRgCPb4d5/ll16DQcQTlrubJs29z+K/5v5XkGpkm+CgJLq5o
	 OGUFGKDtdT1gXshC7xtTLEXBU77ULlme5sXIy4OLx7fBpIlvqP3Ma0YUEsushjr/+7
	 XOETPRPAb275w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	WenTao Liang <vulab@iscas.ac.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] ALSA: core: Fix unintuitive behavior of snd_power_ref_and_wait()
Date: Tue, 10 Nov 2026 09:03:39 -0500
Message-ID: <20261110140334.1822546-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110140334.1822546-1-sashal@kernel.org>
References: <20261107060043-failed-5.15-ad63c5b62843@kernel.org>
 <20261110140334.1822546-1-sashal@kernel.org>
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

[ Upstream commit b113a891252c3fa4fab11ec8c2894a22ecaf278c ]

snd_power_ref_and_wait() takes the power refcount and doesn't leave it
no matter whether it returns an error or not.  However, the majority
of callers don't expect but just returns without unreferencing in the
caller side upon errors.

For addressing the potential refcount unbalance, rather correct the
behavior of snd_power_ref_wait() to unreference upon returning an
error.

Note that the problem above is likely negligible; the function returns
an error only when the sound card is being shutdown, hence it doesn't
matter about the power refcount any longer at such a state.

Fixes: e94fdbd7b25d ("ALSA: control: Track in-flight control read/write/tlv accesses")
Reported-by: WenTao Liang <vulab@iscas.ac.cn>
Closes: https://lore.kernel.org/20260612022121.14329-1-vulab@iscas.ac.cn
Link: https://patch.msgid.link/20260614090507.772540-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: ad63c5b62843 ("ALSA: core: Check shutdown flag at D0 power-state, too")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/init.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index e9465b31f9fda..0cd775e913bb7 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -1148,7 +1148,7 @@ EXPORT_SYMBOL(snd_card_file_remove);
  * typically around calling control ops.
  *
  * The caller needs to pull down the refcount via snd_power_unref() later
- * no matter whether the error is returned from this function or not.
+ * when this function returns 0.
  *
  * Return: Zero if successful, or a negative error code.
  */
@@ -1161,7 +1161,11 @@ int snd_power_ref_and_wait(struct snd_card *card)
 		       card->shutdown ||
 		       snd_power_get_state(card) == SNDRV_CTL_POWER_D0,
 		       snd_power_unref(card), snd_power_ref(card));
-	return card->shutdown ? -ENODEV : 0;
+	if (card->shutdown) {
+		snd_power_unref(card);
+		return  -ENODEV;
+	}
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_power_ref_and_wait);
 
@@ -1178,7 +1182,8 @@ int snd_power_wait(struct snd_card *card)
 	int ret;
 
 	ret = snd_power_ref_and_wait(card);
-	snd_power_unref(card);
+	if (!ret)
+		snd_power_unref(card);
 	return ret;
 }
 EXPORT_SYMBOL(snd_power_wait);
-- 
2.53.0

