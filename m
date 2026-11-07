Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047813;
	b=sUNazHwySvx633FXt+DY+PvXP77mssXdH1qKYi4K4Jj2rtcKEarCkaU8b4BXNBfhUYaL
	 edYr04GdC4CWITF8eP6WphEyJma3pWqRZdkp/zUiiiveLlZWaRy9v2hmNpEDnUhEPkD5W
	 K4GRKrd7yEKvLVfWmwQxJttqriaCTnUOwVm0SxvrbYXaj45q+KZe2KsfHYPZehFLowbSq
	 QJDRJ76lnQ6TRqRf+DIe5V9WL/+3nsWlc3JYXSI60cLL3ef8dkWRVcDxA9jy8mAzYP80m
	 LJdA6zey5E61o4rEqORMM04u6LIsBO8XeEhw36OIaW0P3ZZWDdcizbxcGCQpcUJ/wIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047813;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nSH67wWyhxtaUOJLOUOCQxtchhTWWRlbILutZPr4Ks4=;
	b=AU4qsAqgcJKcZiEzDeuHhwuyXcU+zlfEgngK55cHEl4Giz0O14wjhwNs/ycCkiU9lsOA
	 ecES3pEvdN5wT9NXcIvXq9om6Y3achweVprXCh04Z1nornFcaa8twnte4slbc7fvE0n7y
	 SIdalq6VrEf8h07b1K+cLUxSAUlV5ORvkKaPeQXoYwJGeh3g3CRQYh8rhzvhPKUugBATz
	 a3pKijo6iI8GK8r1C1EietB+yd8VKZa2nnOjESYovUphwBstFPJvupz2/c1tOdCgusv8S
	 DGfifUrV3tUzZbXag/xWncJJkKKLfsPkjduC6HnAsKE2wy6GIKvKNbwlc5ta5R8ZSyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFaMqPnf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE40606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFaMqPnf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3884A1F0089F;
	Sat,  7 Nov 2026 10:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047812;
	bh=nSH67wWyhxtaUOJLOUOCQxtchhTWWRlbILutZPr4Ks4=;
	h=From:To:Cc:Subject:Date;
	b=YFaMqPnfWu93VhROn6wIMMygGTrL3prg+NVsz7h1uSgVC6zuv02Fg8//iqeAtJQ+H
	 2+83JzxhRf1OudWDUTEJhTigeJq6mG44iQ6sQBWy4hHBY03iHi3ZoHqsIfNp+GDvLV
	 0e0Xq2OpwDGLfEbJrIl51hN7mDNUQp4Ky1verjEPOAQZtZ9g4uml5coRiQbbhb5bo7
	 5TPBYUi3qOqbVBi0Lwe5dfq0MSBzQB7wekhI1tRyfPP4t3NlfF/2hc5Z8xilb56ASR
	 kELmhtWlUOD6JXZ+2WLzlb9Ms5Y9y+BfL9Um1Q1laYojOmd/XeKMr/spHLkt3hfhKO
	 +ymHjQLhbek4g==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: compress: reject buffer geometry change on gapless next_track" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:51 -0500
Message-ID: <20261107053651-failed-6.6-82da1acad6fd@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 82da1acad6fd60b6072dd5f3383e6a55efdd2ac7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053651-failed-6.6-82da1acad6fd@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




