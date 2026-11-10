Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320217;
	b=ejaoWrVVdblNs47LOeUtB8qKGSFwDlEqRV83gpCC03Z95zOZTX5cUsTJmDkeYfdQ+txK
	 7qSIWBamusDD14wjLzJJnupf0B3osN4f3ixgM7+lKMs1sSljqc14Xh4B7TJ7okHc09t9f
	 qQAd6ciMen0rmyJpVcGO9MI124kkWAa8tWlcUmr/GIBURJfHO0zWjCsTJG8CxEhNMgSxo
	 YKfTNavbnxM7QDiHd27U5HSgvriatfnd/Zc8lxGAIXTv6h8t22glsXyhA1K6/TluMstQP
	 4NXKAgHzYPnmojDjBKK1T3cuMH91ORbA+qo/tykq1tJhx+UwWopgxDCKq6Yh1AlGstw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320217;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MX9mRCQXpS87NMFrgzcmApvF9UKj4W9IkjZ4j4jJoac=;
	b=ELvoeP0Rsi4yjb/Y4+Y7D/3rvEkdeXZBZ18rUIaQgLBsICsiOdCDvrkDQIg4UTFk9Na1
	 qqc506BF9mxSTTity0BkWit6VPb6f/8OqNQQPhoS/8ktKRZD9cmclzEmC7rT1vX9OW50C
	 RALOUWHhx1XIOGpjY5LhXAZ21xzFEFyOQlHvLVciD4bQakfsn+D788T6CWGXSSImBKFRq
	 +RcuR76+I7lcolt14cwSgELy6tnEOtiX5+7oEbkfkrvqegdIxXRacnHqVEZxq7/RGw/EO
	 zt7m7G+bTEZQZgt2QAZdpukTTd5ekSWe3sryEu8C7wbwxpJfSR5UX5q/q+6qVVD7ZEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nger2zLc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76C160A260A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nger2zLc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F631F008A1;
	Tue, 10 Nov 2026 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320216;
	bh=MX9mRCQXpS87NMFrgzcmApvF9UKj4W9IkjZ4j4jJoac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nger2zLcp19xetCZXYIG0Doqv1wz3Uk9O1I1CoHO3hOLojcDY6ctgT+85ezQyroHj
	 f3AZCsbW4G23M4/A1fKn4SPacDKDxs2R2qFmslV+70dexMFxjKlVhFMvMGaUpvJoev
	 jiaTx0YTfBC5XMX7wtIThj9dFLG5P4CKXYHYq4lihQ3q+aMvl0RRoczXK38KAmYJ+c
	 0NFm7KMnnTj0Efd5u6bpgfHOIEMoMg8+h2LW+WDaXF17kExydVKFHrDGn7AoayMPSf
	 r/F+TNPtApZA9EBm3YOfh5kvZ3Km1WHJ1x7l4zi+DV0SZwWyCp+m5tf9MntrPR2gUU
	 AwJ4GdxUgcWwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	WenTao Liang <vulab@iscas.ac.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] ALSA: core: Fix unintuitive behavior of snd_power_ref_and_wait()
Date: Tue, 10 Nov 2026 09:16:51 -0500
Message-ID: <20261110141408.1841234-4-sashal@kernel.org>
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
index 279c630438882..1759ef9ae8b4e 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -1008,7 +1008,7 @@ EXPORT_SYMBOL(snd_card_file_remove);
  * typically around calling control ops.
  *
  * The caller needs to pull down the refcount via snd_power_unref() later
- * no matter whether the error is returned from this function or not.
+ * when this function returns 0.
  *
  * Return: Zero if successful, or a negative error code.
  */
@@ -1021,7 +1021,11 @@ int snd_power_ref_and_wait(struct snd_card *card)
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
 
@@ -1042,7 +1046,8 @@ int snd_power_wait(struct snd_card *card, unsigned int power_state)
 	if (WARN_ON(power_state != SNDRV_CTL_POWER_D0))
 		return 0;
 	ret = snd_power_ref_and_wait(card);
-	snd_power_unref(card);
+	if (!ret)
+		snd_power_unref(card);
 	return ret;
 }
 EXPORT_SYMBOL(snd_power_wait);
-- 
2.53.0

