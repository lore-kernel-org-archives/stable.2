Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3452CCE2
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766558; cv=none; b=gky7S+69qpbVvaxJO2QTIPbGLADR802c8jvl3YTd2rwI16xjbCyNvhZ8Hze4QOX7MKrgRj1ndmzTm/PXLvhW2/iB7o/dSECCswHoPAR0zQW5V2kmBL+q01izcjS0UfozQUC9eWPGCc4H6wfJSBwG6vnasd+9wGZnS8TKENYFviY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766558; c=relaxed/simple;
	bh=hoCAkVBtBvC9DAPYEWIlEI0CsEORI44ZWvGIi95NMtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TcGBwlD1wondqbCC9R4RGqa9u+RICWroqiPnzqf0+uSgS8+Pi1tWZETubknCUGzAyHrDtJ7hcnz3zq3HkvdFxg/QKyQhTVjkIiq8bWUxuJ5Fswhs0DgF+LBm9sEl20WmnUZFewK28M9koq7pnWjfFDkqah5Z4hYlZRmiKWJEbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=menurgeB; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="menurgeB"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1204005a12.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789766555; x=1790371355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N0QetRYgCZpW+pGrhIsg7iJBlh9aiyAlkrfN9/mWYWk=;
        b=menurgeBizzAb7/WA2tvS1VC3RazV7gL6mUnIKTYBaxw/HrgbvDkP0C39tkT9MYlU4
         fhf/w59kBdgkI66LFSScWXFXWLzJSoZvcwIFm6LSWqOLNKgbVZ2L3h7z44XLz+lEyFRu
         eQWneCxs+MtvYg4VGl0AlZrpnrWULquA33o69k42uHaVmm5R3DMLTbl+ffWq8zlAKPOX
         crfHzDaPOxLIBlHHOgGah4//+oxIwA8lDdwH4sWgtjwVakgo1zFUNVlYBd4r9cu9mNK5
         hiAPB92830vV1kPULT2ZwSmvcbjj5su408cBcSpG0r2xUI0kCT84FHAlTvwet7YV0h3R
         i4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789766555; x=1790371355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N0QetRYgCZpW+pGrhIsg7iJBlh9aiyAlkrfN9/mWYWk=;
        b=FYpooXUI1O4PkUh/dDwNxfNoD4EktLqaMYfFjxBFv6orWNBnfUEA0JeS4MbWtSJwMr
         YkesQVaSlmmtJMZk29CsACHgjWRHnLw6qYvICv5xTd4HO+5hDRELY3AtQSRev9tcvpO+
         GltUUmpzHwUaOe4eFwJTWgD+aTt1Et72+2PXzL3t69HsSuhpEzDEhRNKT5OuSXC8D1G2
         wOwSi7gIk99VHQJ3LrDvMlnEnt8Mhydp2oily8yi8yw+J3xDUIAwlphiBbc2VT9a3NcS
         xv1Q6z5OoulIKCAZvSauMGCJUt1nx5MNHuUPPCEIEFOeqwwK2cd/eLMy+0DX2M2RP7tK
         RAvw==
X-Forwarded-Encrypted: i=1; AKwUvBy179KkOac7bLylmk370jxKvCy81sFUXDKkU3R+KReXuQeLUfzwRWZrEbZp6Wzd0lyXAPvwHoo=@vger.kernel.org
X-Gm-Message-State: AFuF++kbR8HybtnotAFWHZsqx2RkeDQ/OsOFAwLp90W3IesOFRWEDRrV
	uMWe5evrSPaIbisP08f/uOznP0IExKc6jsJWKoAPG6yIJvrUYXGdYNXk3caLPUOmvQ==
X-Gm-Gg: AYBFou0RdXZyUjy+r8nPGMA39fIxJO3Q/VLLRAF1qILE3YpTly/kGrOzL5RfKBP2lUy
	TQzz5evM3aTNUKJg7XB9TV9qjvYlwVJ7hlATl4+0eiwVim/rNeJIbxFUjkC4j9AKdCgfsfvFO+G
	6QgAyGBBMZaw7cJuNuh2HkuBmFTVTfIWdbjawwJPjVJ76bEfgXnjlGRBNGZyaeAtQhQ7NmFYkiZ
	+xEs0D92NthQ4Gbot6bFENQbBKUNuz8QJrF6mG/nqvek13erJbw7YA6c+qrplsbcGRQl3Xg7kqq
	sAn9AybcDkUysui7zyOELdxbrf2yGKZ1lgI/qgy5OSpBipqBP1t3iKEW93I+qDdQFGIDTNHEUxi
	0Ym+mrItKY09Iwf3e8Sa3GT8ndQAOJDhlf5wjrULI819VVImQpSejFh9xHFExeGAEKFKKpJobZ+
	ByLTjXcUinMDDjqe6gRJ7dv68nggT0b9H3EY4L+OxYKh/7zlZp68/MAx1sS6t92AgvXwNfvqhjK
	nlxMIXv/3tn6pwOx7480EjqJem9/skCXGrvuw==
X-Received: by 2002:a05:6a20:20c3:b0:3db:4bf:53fc with SMTP id adf61e73a8af0-3dd72522a1dmr11258967637.9.1789766554581;
        Fri, 18 Sep 2026 14:22:34 -0700 (PDT)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c32f16f9csm1261175eec.2.2026.09.18.14.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 14:22:34 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Cc: dev@andree.sk,
	co+f595d33a1b0a565b@bugs.sh,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] ALSA: line6: Clamp the playback URB size to the OUT endpoint packet size
Date: Fri, 18 Sep 2026 14:22:31 -0700
Message-ID: <20260918212231.1193758-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The playback buffer is sized from the OUT endpoint's max_packet_size_out,
but submit_audio_out_urb() takes the length to write into it from
prev_fsize, which audio_in_callback() derived from the IN endpoint.  Both
come from the device's own descriptors and nothing relates them, so a
device declaring a large iso IN and a small iso OUT wMaxPacketSize
overflows the buffer.  usb_submit_urb() rejects the oversized URB, but
only after the write has run.

Attaching the device is the whole trigger: toneport_startup() acquires the
monitor stream and starts both URB streams on its own, so the overflow
happens in the URB completion handler with no local process involved.

Clamp the length to max_packet_size_out.  A device whose OUT endpoint
matches the audio format it announces never reaches the limit.

BUG: KASAN: slab-out-of-bounds in submit_audio_out_urb (sound/usb/line6/playback.c:242)
Write of size 1024 at addr ffff88801b94bc00 by task vhci_rx/183

Call Trace:
 kasan_report (mm/kasan/report.c:595)
 kasan_check_range (mm/kasan/generic.c:186 mm/kasan/generic.c:200)
 __asan_memset (mm/kasan/shadow.c:84)
 submit_audio_out_urb (sound/usb/line6/playback.c:242)
 audio_out_callback (sound/usb/line6/playback.c:354)
 __usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1657)
 usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1741)
 vhci_rx_loop (drivers/usb/usbip/vhci_rx.c:107)
 kthread (kernel/kthread.c:436)
 ret_from_fork (arch/x86/kernel/process.c:158)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

The buggy address belongs to the object at ffff88801b94bc00
 which belongs to the cache kmalloc-512 of size 512

Cc: stable@vger.kernel.org
Fixes: 7a0f55aeeb8f ("ALSA: line6: Support assymetrical in/out configurations")
Reported-by: <co+f595d33a1b0a565b@bugs.sh>
Assisted-by: LLM
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 sound/usb/line6/playback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 7ebaf125f969..cfb20585c5ea 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -181,6 +181,7 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 		}
 
 		fsize *= bytes_per_frame;
+		fsize = min(fsize, line6pcm->max_packet_size_out);
 
 		fout->offset = urb_size;
 		fout->length = fsize;
-- 
2.43.0

