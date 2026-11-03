Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700698;
	b=m61VKs9nOD2MwgBpdtKdLiR+OJp8G8HKl+LZwZ47Fp2tMxrAbkonsio5AZ8Em1dGF0RD
	 XgoNw8T2MPCrhvUINACWxvA/nvd9NPdBFkQ55fmmsH4QqMJ+gJF6ovm0AsYDQbMyxmnKO
	 rkYAZpsOu1qgDkpCT6uHKGBXt9wBokWDU6q/v/1DR/3zFuUeIVa/5ctTSWAVXDvegxU+f
	 INXTAkfziCt5nJ3VxRadnKPUrcI/Ru/1ctDFkC3P0Iy4YBzHKpgH3o6hswf7rWQ/l0ELs
	 JqbUFn0PfBWqOXfKjxA8WSws8ohfFsCrgZUEWaQrUK+mhiEB6RY8Bel2wroMpeGukKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700698;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t17PiJClzrbSUyIuZwjHIqiTh+XCRNFWKyNf/HaOlVc=;
	b=n/npYjEtotB5xfhyPox0aYGMmeQpy8xmaggg+6z2zBrUu4mcitjAkhGqW1CTUiSNoXAf
	 WTMAmVS34SJkhGfLMgkzG3yHJL2pRwCwiZ6q9HdNKjFWBV3VC+todiYFIcI2vxVUwnj5c
	 o3PrNO7MbiNQEzAQvdYY4jO8XlnKTxaG0wF6ZbzuAf0b4gv2dDErtwJBf1hZNjfzasvHZ
	 +gz5WTryH2gI8yxICi9+Osbz3Q9488NFYISD3t7uPENnXPWPFN+mGHdSwqlD0JVt3LAhR
	 gSUjFtlNx1yNthUHsNb3y5NFhL/wTWOj0oWApE2FB4DvgqjKJQWzHbTyj1jP5dONG2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=u6IUJBki;
	arc=none smtp.remote-ip=162.62.58.216
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA531606A32F
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA531606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=u6IUJBki
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793700686;
	bh=t17PiJClzrbSUyIuZwjHIqiTh+XCRNFWKyNf/HaOlVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u6IUJBkiDWMTtei85hJrClnBtXc7X3HUDm8YgW2UBAOWtP9+OcWqV45VUTVa/80o3
	 Gt375L4aFdb+fjT1dVagYbIaUtm0Xg47b4pLenfyq6k7ZCakywUy7S4K0z0BC3QFUH
	 lc9MzQLeFiK0KjZ2Qszc0sZWmRHzC9JYXUuRGHPI=
Received: from HAPYCAO-MC1.tencent.com ([101.226.143.247])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 2D8234CE; Tue, 03 Nov 2026 18:11:24 +0800
X-QQ-mid: xmsmtpt1793700684t2n7ljwd9
Message-ID: <tencent_B42A09AEC55F1C8563B4D653B79914ABA909@qq.com>
X-QQ-XMAILINFO: N9eG0vJsEPeN3KWeQ6EPNdmLSwpehhF4DxsHuo9HT2dofDXTJQ4Yz3Kq822dsj
	 1uqHULIDSiPCpwbM4IH3KdLzrWzIMgym3ChWnDE0i0edhuLvSoFYq3wGkI+3XyTjIhyC8G7ApExc
	 LJIp+augV2FpHvZhR970g7DUOZYITVquQZYxWYIz16ibEdp5D+f64nLq9F5XchuS6jcDh5btt4xi
	 qSg2NR0YHjkOi6jOc0zmlVitKRgayNxXR/yYeR6zMt8WTA/eEUTzTMZS/cYe9FFQnD8h8PSaBh+J
	 nhToEiqJa57wW60su/uary9qUlTon65IizSJPNUFc2CfrcpO2e2RT9998wgBhrRqDQXJ925toRJT
	 ATzT5Z9hELBqXsXttZF/fZjyWgfShcXtEKyseWhhbAzAajUZDLXdSTM2JD/D6fb8+Gl7Rd+e0SJr
	 r3ovpAdvx+uc4zFIehwp+iPF5VJA2bXivRy/rbkBU9935QjNUIeS6eJXbXDt2+7eST8tUVitzaX6
	 mbb8dkDEyzTJbvsNQiPZHzA/99bk7BgcjfFeaa1pvilhuxSCQnSjUZDS+tfKGPhhsWZbM8JkD9TL
	 KoNwTgQxuGsHFRrLW6Ck5Am6EXEfYBybT3tToLoxE6Dp4Sa63t/E7bhz3hiy7REhiUHPSggdAV//
	 DWRcW4Z8K0a33UhZdw4oXRKg59IVgiuxogG7H+NIOI8g43vb07S5IYE4HrDppt8+94twvwQYZNFP
	 6bBZQqDdjr1f7/YdjESRAfKdTS+lPNzmRwihb4GAAIw9w5tEHaq5fRSnjEUHglG5bovZtCFmzbcD
	 tqQpQdmVXDtY34Lv2fkLrhLHy6qp13EPmu5LbJIe99S3o8pea7Zl/+whk4OCRA+MShAI20dQnH9o
	 F6cIj+K+mHZexHsPUzsfH9Zfb8Y9G5/6bbEKM0xbE5p6gZv9w9mY9Bc+5eq4bek+d7yrog8p+H7h
	 THkY95138NofkYCyhU3Nq+HagHMNDj5Xm6Sa54ejnArIQoexbESDTU0wsZljj9u16jdmx7CZ/9zY
	 b30DkukPIPBtfdvoNUQ5Cox6GY9rW2PYAeRyfiRrr9OZEF533WxNiFrV5Lhp/nHs1srZV/8g4kW5
	 uRsyC65Whk2+O+rR1udtyMcltX/N4mjT0KoarvP4OmdTylGrx8aaSHfuVN70YwjugXipBceSIBq5
	 xeRJDhvoikzUAmTw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: bo cao <treebacker@foxmail.com>
To: johan@kernel.org,
	security@kernel.org
Cc: Bo Cao <treebacker@foxmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: pcm: Don't release the DMA buffer while it is mmapped
Date: Tue,  3 Nov 2026 18:11:17 +0800
X-OQ-MSGID: <20261103101117.77560-1-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <aumqLnR0FO3vjNHr@hovoldconsulting.com>
References: <aumqLnR0FO3vjNHr@hovoldconsulting.com>
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

From: Bo Cao <treebacker@foxmail.com>

The hw_params state check refuses a re-configuration while the data
buffer is mmapped, but it carries an exemption for OSS emulation
streams.  The OSS flag is kept on the shared substream, and a native
ALSA fd attaching to an already-open substream through an O_APPEND
open inherits that flag, so the exemption can be reached without ever
touching the OSS emulation layer itself.

An unprivileged user can exploit this combination by opening /dev/dsp
to mark the substream as OSS, attaching to the same substream with a
native O_APPEND open, running hw_params with a small buffer size and
mmapping it, and then re-running hw_params: either with a larger size
(making snd_pcm_lib_malloc_pages() release the old DMA buffer pages)
or with parameters that fail refinement (making the hw_params error
path release them).  In both cases the pages are freed while the
userspace PTEs remain valid and writable.

The stale mapping of the freed page never expires and can be turned
into arbitrary physical memory read/write (e.g. by reclaiming the page
as a page table).  On arm64 this was demonstrated to escalate an
audio-group user to full root via a modprobe_path overwrite.

Refuse the buffer release while the buffer is still mmapped:

  - snd_pcm_lib_malloc_pages() returns -EBADFD instead of freeing
    the old buffer when the new size does not fit it and the buffer
    is still mmapped (same-size re-configuration, which is what the
    OSS emulation layer itself does while mmapped, keeps working),

  - snd_pcm_lib_free_pages() refuses to release a buffer that is
    still mmapped, which also covers the hw_params error path and
    drivers freeing through it,

  - a buffer retained this way by a failed hw_params is released at
    the final close of the substream instead of leaking.

Fixes: 0df63e44c3e3 ("[ALSA] Add O_APPEND flag support to PCM")
Cc: stable@vger.kernel.org
Reported-by: Bo Cao <treebacker@foxmail.com>
Tested-by: Bo Cao <treebacker@foxmail.com>
Signed-off-by: Bo Cao <treebacker@foxmail.com>

Hi Johan,

thanks for the quick response.  Below is a proposed fix as discussed.
It enforces a single invariant at the release sites -- the DMA buffer
is never released while it is still mmapped -- which covers both the
buffer-growth path my PoC uses and the hw_params error path that
frees the buffer on failed refinement while the OSS exemption lets
the re-configuration through.  The close path releases a buffer that
was retained by a failed hw_params, so the fix does not trade the
UAF for a leak.

One caveat: I am not a professional kernel developer -- the analysis
and PoCs come from an independent security research effort -- so
please treat the patch as a starting point rather than a finished
fix.  In particular I would appreciate review of the
snd_pcm_release_substream() hunk (needed so that a buffer retained
by a failed hw_params does not leak) and of any OSS emulation
behavior I may have missed.  I am happy to iterate on a v2 with
whatever approach the maintainers prefer.

I verified on the affected setup (7.4-rc1, QEMU arm64, snd-intel8x0)
that the PoC now fails cleanly: the second hw_params returns -EBADFD
and the mmapped pages are not freed.

Best regards,
Bo Cao

---
 sound/core/pcm_memory.c | 8 ++++++++
 sound/core/pcm_native.c | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index cfe9f10e7359..ed3da74e2cf5 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -439,6 +439,11 @@ int snd_pcm_lib_malloc_pages(struct snd_pcm_substream *substream, size_t size)
 			runtime->dma_bytes = size;
 			return 0;	/* ok, do not change */
 		}
+		/* the old buffer may still be mmapped: refuse instead of
+		 * freeing it behind the userspace mapping
+		 */
+		if (atomic_read(&substream->mmap_count))
+			return -EBADFD;
 		snd_pcm_lib_free_pages(substream);
 	}
 	if (substream->dma_buffer.area != NULL &&
@@ -488,6 +493,9 @@ int snd_pcm_lib_free_pages(struct snd_pcm_substream *substream)
 	runtime = substream->runtime;
 	if (runtime->dma_area == NULL)
 		return 0;
+	/* the buffer may still be mmapped: refuse to release it */
+	if (atomic_read(&substream->mmap_count))
+		return -EBADFD;
 	if (runtime->dma_buffer_p != &substream->dma_buffer) {
 		struct snd_card *card = substream->pcm->card;
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 5cbf88da7626..8e337983f2ec 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2851,6 +2851,12 @@ void snd_pcm_release_substream(struct snd_pcm_substream *substream)
 		snd_refcount_sync(&substream->runtime->refcnt);
 		if (substream->runtime->state != SNDRV_PCM_STATE_OPEN)
 			do_hw_free(substream);
+		else if (substream->managed_buffer_alloc)
+			/* a failed hw_params may have left the buffer
+			 * allocated (it was still mmapped at the time);
+			 * release it now that the mapping is gone
+			 */
+			snd_pcm_lib_free_pages(substream);
 		substream->ops->close(substream);
 		substream->hw_opened = 0;
 	}
-- 
2.39.5

