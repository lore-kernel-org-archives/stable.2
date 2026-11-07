Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050730;
	b=XH7vUhdR55IJUzFwQXZ3ymVJfXSeQHeYidKkNc6wJ2FiCxgfe17RrfNdS9Zb/lxTI/k+
	 gCYQ4RoyqxIXwv8r09xCld+JIJv/h6clkzkhyG/yCMXDx28/gRYl1pQ8p+NOnNuAPMP9h
	 pDWlEFWRqqosUU4aTWVvgwukJ/C79E2j8QUpm6mBP7aRhR9RjjqIA1q9RS5qrJlbiad8N
	 anAd2Tze6maRM2IlgXbKk8cRXq5g5KFMTMff/DyYrzIhhOrle7rQRimL0v4f8WHR3cH+Q
	 lQAQRlthp2Pmp/fSYON/CbIXsGA+2HTU0jrMB4QMYqx3rjDOELu87sBo5M/y8jO+shA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050730;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZRrOK23o/ymnuoZg9DfuyH6OvT/M1dFe+FF2WE0Tu5o=;
	b=oEqVszLnaUt1urSGsX2ynGdiTX47Q4FleFKu4fEO/qlWNMx9pOZlcjXgZk5mlceMg8CN
	 hwcMNvmpUXWyIvWKNYnvBsN9Z482b8zbORRDPqKyd9ttfrQzZ/RR1TcuzA0QxHzadqWMW
	 Q7LPsFHRrYGrB0GKuOKNntC+Yqp9bf3Vaqmex7SzOHUJyQdE+93pKWrEa7ZBNn4uWjHvL
	 73s3NUO5TiM8CyPUk7Xi+aunFKXZ8Ctk4Gk4OG+3FlUshNN1BWARGv+KnJnpa50LSMu7E
	 By4H8IN9SJx+uJBVsPfMD5fSKI5ahKHxYc4G68zrL2jc5HePb2L0rAvcqs9P4vdXPLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8yD8Y49;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F841606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8yD8Y49
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC951F0089F;
	Sat,  7 Nov 2026 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050730;
	bh=ZRrOK23o/ymnuoZg9DfuyH6OvT/M1dFe+FF2WE0Tu5o=;
	h=From:To:Cc:Subject:Date;
	b=H8yD8Y49Z81Kwq6QfRSzsH7OqC1f0Y78wUAdG3hnbi2RUKXHkUPxpHy07HZeKjVlG
	 TciEEsechIgxagHw3Z02hcuRmRzRH3lmRlhZwRHsBl7lHXvejbapT5/8B+qRUW74Rw
	 sp91WRH2xCgL0q0VFf7u9ODKc67AeE77GXPCbnnqZnb60ACMtiaAd2IFd4p+ffNogm
	 d9giQ80UCAVadf1nRUUHpFi/mOD4dPJDJRfSBXxDwxT3l5wJJ2qNWn6oHV5j+l8gwe
	 Llx72oZlQSWIjgtbgLLeexLcYq68oERZ8z3bq55OdusnoBETHTNYdtLMooKmQigpT4
	 WPqqgYjU7bSrw==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: compress: reject buffer geometry change on gapless next_track" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:25:28 -0500
Message-ID: <20261107062528-failed-5.10-82da1acad6fd@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 82da1acad6fd60b6072dd5f3383e6a55efdd2ac7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062528-failed-5.10-82da1acad6fd@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




