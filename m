Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49E219049B;
	Thu, 23 Jul 2026 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784797086; cv=none; b=GLVGvKwDSPvyUzFdaF5PnER9dUDgHW4g3kGiSVdCINgu3Y4NjD6y4nvVGjqwHTFHPrFWTftDnyGrslBmdIcwTGxLh7QX4y4Fx93ClF8SQULCsxru0FyqM9XE8chpTVoButxjJnLpRjKr7RuxnwO0enA2h5h0KW1spQxP2Wrksns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784797086; c=relaxed/simple;
	bh=y/PJ1R5oznmnskhWGSo1h4XlEa1yKwHjG/YAGbzOJG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIExds24ogxLNSn4hdCzh+6Yt1AB78HBmoZvypV0YBWWocGsxUjCOj+A60jjt3Zq00NGA/kRYkfTlCwRFB3XcVeqo+STBEY825k1VqntIB+k+CjKbiePfZixEhww/wi1qZ8gVAUkA8FRWqRJrtd8uXH/e5xLK656+WrNC8zq+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=JtuK1gws; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="JtuK1gws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784797050;
	bh=4E8jyp7xaBeSrb6i9ABxyDkz6Z3sx2wdtDMfzuD9q9w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JtuK1gwsfSZiGXFNm7OyKzaQgP9kHzHAptHfGZbaCaFbbiy0AtvIdt4zd/nV8uRA1
	 IKqHedJS8KU9L6mg5hhnqz2htl7BoLyppSi5CE2Up9M8rfj+pXklTkXfUsLqCUsZVB
	 PJfaNrv84TrXv5dUpqtFbzd/XZ6UDo7FUmyIZP14=
X-QQ-mid: esmtpsz21t1784797034t8cc23156
X-QQ-Originating-IP: O+Ij3hZPgPkLWEG2ml/9XtXvylZYdjV2+cq9/X1eB50=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Jul 2026 16:57:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8717825214625693770
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	rongqianfeng@vivo.com,
	raoxu@uniontech.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: lx6464es: fix period byte count for 16-bit streams
Date: Thu, 23 Jul 2026 16:57:10 +0800
Message-ID: <8BB12E8D92A7CDBA+20260723085710.2567463-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OSjTqsWSa+11ZaxGrL3RDhJxlnyirjzIAIFwUlL2uKcHrN5aFfEORdb1
	T6t8uqm4YYEcOWBzB969PQFVJfaopGDlQKV+S4hh8rXm8+GPK3JkgP1d1oAoI5PlgzY1oSC
	l3yiL6lHI/RGyAcMf26tF+Ee9WTwOatKSMKM+K8sL4dbmlA6PAEr8fvFAVcuLCUF7a7MrKw
	1mOa/MeTEpi0S2ck49wxkhXbqnNXdKh0tz7lIYAXxEXzQ87Atq8DVfMyHTP6i30isTXteP2
	9kVnwtku9APuqJJo9C0Ip/oAY8thFn7uPEvkM3rQq/4xw8PH/DJ5EBgpYlYGt/Hp19N9XrD
	h9Ehy1o18LC7KzWFSWbkfXElqSZNZiyweC5NHDK3H/s2IhkPVvo/0UIyOXxfsMeEj/Md0Ey
	b+LuiTH/5hhUz4jf4ZMiXAheN9cEzh8vcGmsHDZ6Q0tRc2IYo6BcCulWYdy6y5nHtxRDn14
	0zcXk7cbQTbVDPX0PofTKCMNOtO+alYcYyzXhz/BT48nQBS6aJwfrJPY82vqS3TNe6ZgN0p
	9kbTbkZXTZ96A4RRhD7z8IU87MPMTlHdaSA0F3GCcd12v/5+Vv67WLBd3do5+m5Ky3GjB3u
	RIYz5AZx2U90b9PEg9XMob9OGRMulSo+woJm6iSVArau36R0kwdC2cYpAMFJUG9kKlPxSLO
	39hiIYyYQ7dThVCIvNo2OBMJeD3kR3vrbEGngI7Qw9g4EPg02Ppnwb03iDjNawv+QD3OhuZ
	K9EN8DjdqlXdKa9FbRe9OnQfikWBa9ByYSANh879lVZEHJB8lzdQzQN8od6DxJ6gXUzLQKX
	UvHp/PXW+wmp0QfMuGYWQo2qadjboVYjo4OPvTFw0H9OPti8gMa7FQAqFPcq4f9qLVOLlyn
	tXqhEK9pc/k+mtNOu/WX2YKusZrTAtf6IeOhhVwPDz0ZgvWq7gU6zUmGrke77lZLzMKbDvt
	90RGkXrO32nA/BnA1wDNJW6+1TrM0akxFRD9fxAPKTisqpi8mlTQlB1vXw9T4gnwzf2Ka+i
	jl8/TgbVeIt0+EfkUPrhrjh9eop5Ncm5D+GkAkSliSWo1p8tWfzNbITrmX7eU=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

The lx6464es driver advertises both 16-bit and packed 24-bit PCM formats,
but lx_trigger_start() and lx_interrupt_request_new_buffer() calculate the
DMA period size as runtime->period_size * runtime->channels * 3.  That is
only correct for the packed 24-bit formats.

For 16-bit streams the driver submits buffers that are 50% larger than the
actual ALSA period and advances the DMA address by the same wrong amount.
For example, with 2 channels, 256 frames and 4 periods, the third buffer
already extends beyond the ALSA buffer and the fourth buffer starts outside
it.

Use snd_pcm_lib_period_bytes() so the byte count matches the runtime
format, channel count and period size.

Fixes: 02bec4904508 ("ALSA: lx6464es - driver for the digigram lx6464es interface")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 sound/pci/lx6464es/lx6464es.c | 5 +----
 sound/pci/lx6464es/lx_core.c  | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 96df00db51d5..3b40ec071379 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -402,11 +402,8 @@ static void lx_trigger_start(struct lx6464es *chip, struct lx_stream *lx_stream)

 	int err;

-	const u32 channels = substream->runtime->channels;
-	const u32 bytes_per_frame = channels * 3;
-	const u32 period_size = substream->runtime->period_size;
 	const u32 periods = substream->runtime->periods;
-	const u32 period_bytes = period_size * bytes_per_frame;
+	const u32 period_bytes = snd_pcm_lib_period_bytes(substream);

 	dma_addr_t buf = substream->dma_buffer.addr;
 	int i;
diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 6f0843cfb3be..9909f1067871 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -969,10 +969,7 @@ static int lx_interrupt_request_new_buffer(struct lx6464es *chip,
 	const unsigned int is_capture = lx_stream->is_capture;
 	int err;

-	const u32 channels = substream->runtime->channels;
-	const u32 bytes_per_frame = channels * 3;
-	const u32 period_size = substream->runtime->period_size;
-	const u32 period_bytes = period_size * bytes_per_frame;
+	const u32 period_bytes = snd_pcm_lib_period_bytes(substream);
 	const u32 pos = lx_stream->frame_pos;
 	const u32 next_pos = ((pos+1) == substream->runtime->periods) ?
 		0 : pos + 1;
--
2.50.1

