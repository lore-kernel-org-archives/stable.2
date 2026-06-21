Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D001E5207
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782054552; cv=none; b=aiAi8hawSzBwHye7NxfFLIdcXGUs8WE+qqLLzVITE5/HrP9MNXmXyCrSHjZyR84yxbbmeUVxr0oGXZhDi1duJ6FM3NoLlYKZtaHhDCTB/R60SOnnD6XyXScqTG7y7yoPsGFXWRdvOKk//GETd/AXf6mcOYHQH7HjXI69bxP10Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782054552; c=relaxed/simple;
	bh=bGe6auSy2bAcoq3YNv8c9FdmMy0rUqHqUQJP0+7B/4I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a+E1e1OLT0yXPOa6VG3IhQmrBPKn355IUkFZrqWpZdtbURp+ONWu+4DtLJ37D9eqTGkqeqNN1JliO9iWJiW3qg+7re3rQ/0x0tidXGk8QNUunTHSp5kr7lTAgMeGBy3lNxGMoh9DdCSe6FQulhTbvGOShsASvZpNU8uM4bicW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iymBW88s; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iymBW88s"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-842307473b5so2509686b3a.2
        for <stable@vger.kernel.org>; Sun, 21 Jun 2026 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782054551; x=1782659351; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=31UQCBSl6VHtaj4HbZ4B9yytESDTf5UVo9IslisOCfo=;
        b=iymBW88s6DFkORO2NjBKYBMyjdgoeAhgh/RIkmiBNJqEfpW/0J5lkS9uEMjJIIHU3S
         S1XmS2IRuUap9pHKxe2yD/Iv/4MzUQ6pBBua2V1DPpV9iaX8cogQKFxXIfpcVFn1isYN
         mjVYpAWalscVvkZEx51eE4vIwpS4zbKu6/ozsoJmzP/rEtgvC2c0GkQhqJl6Cy4aMN4S
         +UbZVx/dcWQ/3Oic026e9O/7byKGdOBURartKX1OcTI+C2NncQv+BhGXG1E703vxBXft
         IxR4tYO9Q64MAUYw0E8hoKd36y1DRkNWpLystu5dNx7DoG6aduClg3crH72FWU22fjjN
         AP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782054551; x=1782659351;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31UQCBSl6VHtaj4HbZ4B9yytESDTf5UVo9IslisOCfo=;
        b=LeW02CzMkzFk/udCwcoRewWmluniCiF1jduCWTmRC9KFm+YuWPKPPXwF966APqsAph
         1h3BC6xDdJndwxyzI9cqz0ez3AaJ/4r+taZrR0CRigPLveQQA4PWm8hUmK2Hwo0jAqEK
         y7hFD3teVKQw6Q0vzwahCvOQSWzHS9/XnFQOE8Hgn1wEF8sQY/MRSSyz4lQw3PkK5m6M
         4auSGuLD8k9dv1WLhSo6xIscaqRoN3ovOm2u8PCDPkRfYfMjKIn+peqlhnsnDpNTe+fq
         moPJ7lvGHGFTtjmHDHLQ69Up7zyRaEc6eiMz7hwCFg64doyjd2o4kgv80v0JQIl/+JTn
         KDeg==
X-Forwarded-Encrypted: i=1; AFNElJ8KQIseerfBPcXcJ2z8XkQiGs9e9zH/W9/GOH5SOl4kELhP024nZtK/rENZeKEDhzOllMmgXe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5RPa4EeTpG3MybsVbaqSIKAlsdt9+kJVxtCdxtXheWIOZzbnb
	RKbp763+HnuVbr15f5CCGVMDgAWZKnltdCCK0GdgmtKV/n2v8CjN7DrJ
X-Gm-Gg: AfdE7cmM5uYi067JntNPaoJFk9WIdL3248k4hqTqaF20Hyt+SsbMT/jxGkeTcfgv7GP
	0SjYFMfJZzVKeDDr4mx35PTkNhOzDwmPkS1J1kuQPIRr25/a8Tvz9sM9ygp+Z9enG24wpJCVxrH
	wtQSE5AgyGfb8Y4RcR2a2Mz+ZIf8QTdzRsrWaJqiIw6Ez0uWpru2bWxNVm+klnxD6YhEhTcH+4u
	JLV9igahYDotSY2/dJdym74fFW6cF/5Z6Ieg2bs8LnrOdANlGMGbjE0D5nkosU9+SwgT/UD5paj
	g87cIBtjjEuMD/mwZE6JyBoUOD2kksuf8+0Or47Mbp7IzvnP6OsE4ulW54r4nEBFixuAw9GRoV9
	n0O2t/oQRNx86JbcImaLQWyLZKVf+cL9clY4wfMJybMKXMffepZG1oOfvYCxh+WAsW6l24njMJ+
	ophn2zisEFoXm4e4gVGC3YgezZqC2xVbIHC+eitA==
X-Received: by 2002:a05:6a00:2294:b0:835:45bf:9660 with SMTP id d2e1a72fcca58-845561b605emr11255355b3a.42.1782054550938;
        Sun, 21 Jun 2026 08:09:10 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e74727sm4840334b3a.39.2026.06.21.08.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 08:09:10 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Clemens Ladisch <clemens@ladisch.de>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 [PATCH] ALSA: firewire: isight: bound the sample count to the packet payload
Date: Sun, 21 Jun 2026 23:09:07 +0800
Message-ID: <178205454729.1900991.7807310178296762772@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

isight_packet() takes the frame count from the device iso packet and
checks it only against the device claimed iso length.

	count = be32_to_cpu(payload->sample_count);
	if (likely(count <= (length - 16) / 4))
		isight_samples(isight, payload->samples, count);

length is the iso header data_length. It can be up to 0xffff. So the
gate allows a count up to about 16379. isight_samples() then copies
count frames out of payload->samples into the PCM DMA buffer.

payload->samples holds only 2 * MAX_FRAMES_PER_PACKET values. The
device multiplexes two samples per frame. A count past
MAX_FRAMES_PER_PACKET reads past the payload. A count past the buffer
size writes past runtime->dma_area. The smallest PCM buffer is larger
than MAX_FRAMES_PER_PACKET. Bounding the count to MAX_FRAMES_PER_PACKET
keeps both the read and the write in range.

A malicious or faulty Apple iSight on the FireWire bus reaches this
during a normal capture.

Add the MAX_FRAMES_PER_PACKET bound to the gate.

Fixes: 3a691b28a0ca ("ALSA: add Apple iSight microphone driver")
Suggested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 sound/firewire/isight.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/isight.c b/sound/firewire/isight.c
index 2b7f071d593b..33c9dd48b3b0 100644
--- a/sound/firewire/isight.c
+++ b/sound/firewire/isight.c
@@ -179,7 +179,8 @@ static void isight_packet(struct fw_iso_context *context, u32 cycle,
 	if (likely(length >= 16 &&
 		   payload->signature == cpu_to_be32(0x73676874/*"sght"*/))) {
 		count = be32_to_cpu(payload->sample_count);
-		if (likely(count <= (length - 16) / 4)) {
+		if (likely(count <= (length - 16) / 4 &&
+			   count <= MAX_FRAMES_PER_PACKET)) {
 			total = be32_to_cpu(payload->sample_total);
 			if (unlikely(total != isight->total_samples)) {
 				if (!isight->first_packet)
-- 
2.34.1

