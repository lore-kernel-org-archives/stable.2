Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048689;
	b=hFV6Eqmk+H5nbgq3CRWgx7f9bekJXNI2dBuymk+EExy0NkoDqcwsZ51qtogQX8ySLcQZ
	 YLiONmRH2inkWknSwRnuM4qqDpuZaDEOQs3Zbi2GgYN7Gc7cwbec6srFt9tQrxtCRUkmN
	 rgnrKGhRJuXSyYnYbVpV3XK7EeULX9cCFxspdgOJKoHQ2zKJ3nuMjCv5kmpSZyVMLKS1t
	 RaLVTwp+h4BK/syDx2tX0LpPirxWjDY22OCIiId54u45GLIjgSK3Vs9xLWyr0bRY3Lj35
	 ZuKGHZ44zjEZ7kKVSYUUhlkavqJ7W75QYqLWYrBjsGocb3/Qxvq09HkYWWaJtLibLnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048689;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nvjRU8/2drM0+ecCWRCXD3tasg1gXk60fp///RiyEH8=;
	b=epqbUVWKVzln/GREEHqlAArvyMN3oNUYSaDj9jEL1EAaRBrNFyxVgSo/jD/ZNecBshcx
	 18xq4k5b5XHzKDr+yfsCoWUXi/8iR4vmgvyI2gY2RVSPkxnIAaNA6kS9155QdIFWdHcfb
	 wsfpU2abJ++Q17+hC1lMKASQCJ/izgSRUm8Wmz5dSOGOprrO5uhW2rRmw3e+I41VmzbVL
	 bWOCdMbLPLg6rWDAL6E4AiAevmbLfn1/G8SiE2sMRTdIoog6gjDkgtauIh5spMBpZ6H/H
	 IT5PYEsU53wdEIHYeIzhf6afNuzHYuW0UGW4q4kCMYE3lBZEVv4LCUSFKiVQEueetaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Osx0zevU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8E7606A332
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Osx0zevU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807AD1F0089F;
	Sat,  7 Nov 2026 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048688;
	bh=nvjRU8/2drM0+ecCWRCXD3tasg1gXk60fp///RiyEH8=;
	h=From:To:Cc:Subject:Date;
	b=Osx0zevUgnnNdGWMfR2PRt21oHhOeOo/nzkM7JZFhzHKvHTovfMXQatVoJRzgWcKX
	 P/WQKVIIUgsakOVE6Bxx1MjcEFkjMPPnLni1wGWqQtluOtAQBpHcbRJVJl6nIvcKXk
	 kKRUwrWOMjLequOOMFmTaOQiMVMjaBZqD6vy6hvXWG7qPnCTgF1peWu2MSkCUxm8WE
	 OX0c5qQpNbu3GEEoQuMY/Tb96bpXFl/lrPQufQY/bZCNLEmFQWQhTJo4SqUWBbxeYv
	 Vmmqzeyh+zOSNMz0jqFwUcz66fJ4SGYBi6nOKJGAeIyM8WTbbpFw4g+Yn3Pm0dOGrn
	 KSXK0w4FAJjUw==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: compress: reject buffer geometry change on gapless next_track" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:51:27 -0500
Message-ID: <20261107055127-failed-6.1-82da1acad6fd@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 82da1acad6fd60b6072dd5f3383e6a55efdd2ac7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055127-failed-6.1-82da1acad6fd@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 82da1acad6fd60b6072dd5f3383e6a55efdd2ac7 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Date: Mon, 19 Oct 2026 17:45:31 +0300
Subject: [PATCH] ALSA: compress: reject buffer geometry change on gapless
 next_track

snd_compr_set_params() is invoked from the gapless next_track
re-entry path, which calls snd_compr_allocate_buffer() again and lets
buffer_size change while total_bytes_available and
total_bytes_transferred still hold values computed for the previous
buffer. snd_compr_calc_avail() then derives an avail/count value from
those stale counters against the new buffer_size, and
snd_compr_write_data() copy_from_user()s that many bytes into the
new, potentially smaller buffer, overflowing it with user-controlled
length and content.

The buffer is set up once, with the initial SET_PARAMS, and neither the
core nor the DSP expects it to change for a gapless track transition.
Do not call snd_compr_allocate_buffer() on the next_track path and
reject a request that changes the buffer geometry, so that the codec
parameters that the driver receives match the buffer in use.

Fixes: 9727b490e543 ("ALSA: compress: add support for gapless playback")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20261019144533.30665-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/compress_offload.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 50301f72579ee..d6863336f21cb 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -697,9 +697,19 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 		if (retval)
 			return retval;
 
-		retval = snd_compr_allocate_buffer(stream, params);
-		if (retval)
-			return -ENOMEM;
+		if (stream->next_track) {
+			/*
+			 * total_bytes_available/transferred still refer to the
+			 * current buffer; its geometry must not change.
+			 */
+			if (params->buffer.fragment_size != stream->runtime->fragment_size ||
+			    params->buffer.fragments != stream->runtime->fragments)
+				return -EINVAL;
+		} else {
+			retval = snd_compr_allocate_buffer(stream, params);
+			if (retval)
+				return retval;
+		}
 
 		retval = stream->ops->set_params(stream, params);
 		if (retval) {
-- 
2.53.0




