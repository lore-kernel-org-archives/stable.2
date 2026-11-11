Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359683;
	b=q70+ceKzRS8qgBH4J7BV7JBfsH45h15rTp4m0/10u2Qh1Run500Fm+1hp8ND/ywF8ACh
	 pdN+5spfIQ0GoLdCDO0tXB6s//aRMrrgnY5sZTHYvVFnyxzZzWwvz+XHq24s4BsWpz6Dd
	 E9n/6ACuwMDm+kXK/P9v4Le58ToMT9ufA0osot92CnvRkI+6Lak7zbQ/7RnepOdZKAsBI
	 eGQToXKyKlbgbdxXGll1sJPcrvTCb2iGvqVr8XKxcT+2a7bxtjH5E/ZkykFKjpVaKx7yz
	 BJpfM5fvV4tdhpIGuc/HXEAQGFiY+7dm5PL+FruyMROsmfgBh3N3KeR9heKazLKL2VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359683;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e5v1x+ZlEhUuZFBcGgX37scpZnco3/TepjeKGSDc7fA=;
	b=jhb1wrWBeXDSENZ2eEq45kcR3Kl1GR3KNqx6JEOCCRdQRpE6WYyhBqjpVm11+WjiVYMX
	 HrLEj667/3YlesiK3rN/67UXa+cTqDgD2FRpH4FfuMt9D+eNp+eCyd9irRNnNOgcQ/SMk
	 W4EBObj3+usjXg6D+byGYrewXVKEUHjV6aMHewT+fZEXsnk9ikBIP3QYTdsMnMcSa6ZpA
	 r9u6DVl9AVdZCrL0o7OxrUga52RBpVbkjyHuFgkr6f7PxhXEQn2ltXiq3TPSvYh/o53iB
	 XL/OG3SNBb7aaFIja49d12GrhyxEFbhQoxYnURxLn1OTg/p864FVQpHqqKgdmusi/mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kssH9ztP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99A606A325
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kssH9ztP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFBB1F0093D;
	Wed, 11 Nov 2026 01:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794359683;
	bh=e5v1x+ZlEhUuZFBcGgX37scpZnco3/TepjeKGSDc7fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kssH9ztPvzcrInkut6clPHCMdkBxmiPw9rUqFvKeXJ47qbA4cUb03pX4FWEuC/xHC
	 sduPau5bZmrBx4F2O4JYqNI/STdWJmxD1cU3+/Ug6iGCx/b1Zb1tOO1w1wHqCXg86V
	 gN4adVbaK4wkzKiuHMhP14FjD88CbahyXUMfZjBAS3zTAAqG+SdOq6IbsrWQogxsAo
	 YuW89uo9y83q5HAEX+Zv3JMTN4cVjqQejXDxu1sKpsOQZsIZ/v4+xF4N4l6vVEoT97
	 Pq6A95TjJ8bEN+g4aLPsyw6RGDQD7MTH57zXPAg/RVrEbwC9U8av3wzxYRDIQn7xqh
	 0e0mc9S8bxXLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ALSA: compress: reject buffer geometry change on gapless next_track
Date: Tue, 10 Nov 2026 20:14:40 -0500
Message-ID: <20261111011417.365858-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111011417.365858-1-sashal@kernel.org>
References: <20261107053651-failed-6.6-82da1acad6fd@kernel.org>
 <20261111011417.365858-1-sashal@kernel.org>
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 82da1acad6fd60b6072dd5f3383e6a55efdd2ac7 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/compress_offload.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 511087456568d..b7c0ff1b9b5a1 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -592,9 +592,19 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
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
 		if (retval)
-- 
2.53.0

