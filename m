Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049715;
	b=oS/NLZJJKjh0/vIXXpgEZFe1DvC4npf56NDfnhHLaUKI1XDpX0AskegRBreI+oOQXYGl
	 w4xLF3cHovATI7YMd7hXn/DzmhTNn/gxDqeWeViQQg6eQjkxRtZ/1mVzx5zF5WEuA3s4C
	 x5mZe/I1hHaklGi5dPDBZKRPcMWxdZGinKMpiLfLBdVIK3TSmxmcqM/XFRfxX6U51ixgW
	 xbJ53TV4OI5DKFu/AM5215tT4UnZLM/znJNUgclzFkrdPZS0IPzw357U5ZvMOFDj+Hmg7
	 IDrJzhdnNytOzARpCbxzHhEc+7aHeYvk9mO7B3EtPO4wixk7JyECjdUdn5O7eH9noPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049715;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ijy9ZC1Cc+DqM1bBxk6Sil3imXfabza3ibm3sRmqdIU=;
	b=B+hYZEjDKmvcAxivQLPh/movSFaVI+GQI3ikzjjpYrzKa+oHr2yTej0nDuGedyQuIarZ
	 WVot+FJrvaYcHJL8kvfZb5vLB5rzdlJa6fMy+MrCRL4ulawhhZu6h4T6rxSNzzkXHbGA2
	 Ii3Gs1Hwtit5XR476HO4HJWQQKT5gVJ4ZphucmN73opNRW7iP6V64PYY9kyaKysYP2ZFG
	 kRptFWCw0TthlVT7/cVTjglTXCuIz6kbWCvICLo/k9LteH0ztINW5uchR9T4tb68MYzNd
	 lUx2ilZXyUHksnV8x8qkq+Gq4/MCQ22DQSPu64a99jJrKYAGdzWTVBs50YeC7iOiiWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OLZtMUj/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76249606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLZtMUj/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F111F0089F;
	Sat,  7 Nov 2026 11:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049715;
	bh=Ijy9ZC1Cc+DqM1bBxk6Sil3imXfabza3ibm3sRmqdIU=;
	h=From:To:Cc:Subject:Date;
	b=OLZtMUj/5XMZQBX7Kjo/QT/okgNyqK7LNkzeCLsZTZ+Wgofl6ppj+VYYayKZgpjzd
	 q939Br2yqjXVT5ooKEX2ChqxCiPIyf6CYsSOIIlc8KSSlML61YKEZaE8iwBoP66SFz
	 /st8ImY1YxUPgBckrM8LiZuLGrKIlBJ+sucGiqd9u9Z7m5VPn/7JXMtfiRuYygkTIN
	 EyV/s9cQxsl6/Lzkx9VelXYz+z9NHR9CiDpMcPoZ5r5ALCLLlwkk/Q6Eftek7T9sB5
	 4yFknM+Su+0IxsVLbJqjp41fD/CkM+q/u0l2UztOrw5gQRBdnj/skSK+rjgMUXQ5EH
	 nOHXXod2mHLBg==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: compress: reject buffer geometry change on gapless next_track" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:08:33 -0500
Message-ID: <20261107060833-failed-5.15-82da1acad6fd@kernel.org>
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
git cherry-pick -x 82da1acad6fd60b6072dd5f3383e6a55efdd2ac7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060833-failed-5.15-82da1acad6fd@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




