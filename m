Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359682;
	b=4wUJp++SnWx7f7tBghOJ3g8Jm6Y0Uf37rERJNtLttUkauYCulXhBs5IBs3bNPGghJ5AR
	 D6vY/NZXZ37np4tCXtlZcgncs37kKul+BX/5+VeVZyO0A7wRdL/3Oz3m3ile6MAJFGyJ+
	 aViUutPwF2XLPkI9oKZpUqFxBDA+qGFuLbKnfZpn+XeqXbGu3oAJUliJGeSDDuVv9aUIs
	 G+9pBurKbXUQ0J/I+i3rqMq+ErLovIttd0OUvAl+ivemK3s/v+cKvMSUGWpwogCUbw7s+
	 Y677CMrBpW0pTgPbmN84ixcy9VHvH8JOoIAadMQBXcAeucDZJEfcSIUODLyS0Gn/QSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359682;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ok9mr4GYiN2pDiNlUp44yS9tNMPQGQKNNVOjGIYLTpo=;
	b=zDohA+ecI6TNRa464EhNH9TL4zuBzi8A+53c2tf4Zwa8tQ5Pe4yNNnJPJ6Kkv0tAspOu
	 /TuzSLXbjk9ETu6ZyGlG99H/1cAbBckQV4ycp5bHn5Ao4pBimnCboniz2GQNvAUxGh9H1
	 RC9a9pJYsKDuu1GZZeQFb0sPEqHD5hQU4MklGnT0i6pM4lr/SJT+NvLfNH82khSaFApxu
	 5Ji7JYtsLAUja1FNUIJ/o8DRfXZX2qIJ7yySQROCit2C7w6eg99KKysZLxn4vnLXTuNSU
	 tphsMcMmWlmdRq5eh7ar9pQGtQZIzQK3L2qTCNg0CH1dHoVBWHKJWa4McgKfJJQjDHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lu1UtsMa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE902606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lu1UtsMa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5DC1F0093C;
	Wed, 11 Nov 2026 01:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794359682;
	bh=Ok9mr4GYiN2pDiNlUp44yS9tNMPQGQKNNVOjGIYLTpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lu1UtsMaP6W0tNhWmLsz6jkZYMeq1nMIApV4kz/g0TGn08BOOj3b0zHX7wKDSBAag
	 rjxQ9QWDbJhy1mE+tPL87ezZmlaJO0wy51EZBOttTI7KkOELzKzBRLQ8/RDmqkTR5X
	 whK37GQsS8uKNrBet2nrKSH6EJhD21bLmUOJkAsuOtEZcxUDJeMHFIs3xHDK0fsSUC
	 B2r/07fk7BoTuSNQKvjNFI3DE81083DmEoZATJtCScjrriPSkqFRCFm6RyuMJOdxHz
	 wyqnc69bkQf4enPEaNu8chP6qaCVKGfqzCrvoqOuzAGM8BNP2G6x1MXXnYKq6Bi4uI
	 gmmXoQyg2wihg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ALSA: compress_offload: Use automatic cleanup of kfree()
Date: Tue, 10 Nov 2026 20:14:39 -0500
Message-ID: <20261111011417.365858-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053651-failed-6.6-82da1acad6fd@kernel.org>
References: <20261107053651-failed-6.6-82da1acad6fd@kernel.org>
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

[ Upstream commit 9b02221422a55e834469fdc91dc4d5147f5a1fb9 ]

There are common patterns where a temporary buffer is allocated and
freed at the exit, and those can be simplified with the recent cleanup
mechanism via __free(kfree).

A caveat is that some allocations are memdup_user() and they return an
error pointer instead of NULL.  Those need special cares and the value
has to be cleared with no_free_ptr() at the allocation error path.

Other than that, the conversions are straightforward.

No functional changes, only code refactoring.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20240222111509.28390-4-tiwai@suse.de
Stable-dep-of: 82da1acad6fd ("ALSA: compress: reject buffer geometry change on gapless next_track")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/compress_offload.c | 36 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 3c259b9419598..511087456568d 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -458,7 +458,7 @@ static int
 snd_compr_get_codec_caps(struct snd_compr_stream *stream, unsigned long arg)
 {
 	int retval;
-	struct snd_compr_codec_caps *caps;
+	struct snd_compr_codec_caps *caps __free(kfree) = NULL;
 
 	if (!stream->ops->get_codec_caps)
 		return -ENXIO;
@@ -469,12 +469,9 @@ snd_compr_get_codec_caps(struct snd_compr_stream *stream, unsigned long arg)
 
 	retval = stream->ops->get_codec_caps(stream, caps);
 	if (retval)
-		goto out;
+		return retval;
 	if (copy_to_user((void __user *)arg, caps, sizeof(*caps)))
-		retval = -EFAULT;
-
-out:
-	kfree(caps);
+		return -EFAULT;
 	return retval;
 }
 #endif /* !COMPR_CODEC_CAPS_OVERFLOW */
@@ -579,7 +576,7 @@ static int snd_compress_check_input(struct snd_compr_params *params)
 static int
 snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 {
-	struct snd_compr_params *params;
+	struct snd_compr_params *params __free(kfree) = NULL;
 	int retval;
 
 	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN || stream->next_track) {
@@ -589,24 +586,22 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 		 */
 		params = memdup_user((void __user *)arg, sizeof(*params));
 		if (IS_ERR(params))
-			return PTR_ERR(params);
+			return PTR_ERR(no_free_ptr(params));
 
 		retval = snd_compress_check_input(params);
 		if (retval)
-			goto out;
+			return retval;
 
 		retval = snd_compr_allocate_buffer(stream, params);
-		if (retval) {
-			retval = -ENOMEM;
-			goto out;
-		}
+		if (retval)
+			return -ENOMEM;
 
 		retval = stream->ops->set_params(stream, params);
 		if (retval)
-			goto out;
+			return retval;
 
 		if (stream->next_track)
-			goto out;
+			return retval;
 
 		stream->metadata_set = false;
 		stream->next_track = false;
@@ -615,15 +610,13 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 	} else {
 		return -EPERM;
 	}
-out:
-	kfree(params);
 	return retval;
 }
 
 static int
 snd_compr_get_params(struct snd_compr_stream *stream, unsigned long arg)
 {
-	struct snd_codec *params;
+	struct snd_codec *params __free(kfree) = NULL;
 	int retval;
 
 	if (!stream->ops->get_params)
@@ -634,12 +627,9 @@ snd_compr_get_params(struct snd_compr_stream *stream, unsigned long arg)
 		return -ENOMEM;
 	retval = stream->ops->get_params(stream, params);
 	if (retval)
-		goto out;
+		return retval;
 	if (copy_to_user((char __user *)arg, params, sizeof(*params)))
-		retval = -EFAULT;
-
-out:
-	kfree(params);
+		return -EFAULT;
 	return retval;
 }
 
-- 
2.53.0

