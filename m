Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFF4525A96
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865317; cv=none; b=Ag+8KoOCbVvQnn2B7aKrXXa0NKG+GFPCn+2ePA1AI92Y3fWUuOucPqrJBtKvlLohg1ZHahDhIwXUmaFBtYLP73OnFnY3d9mn/oxzs6YpunSA0R830suyPY2xRfeY3zOWFe5iS5BXiMgcR1MkDYI46VU0kM2pNnVsDoxzPmIoAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865317; c=relaxed/simple;
	bh=JNIxa+Q0uCVgKetLJLxRgWMaDSMh9rMFW0vqnWvekdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7xHbuZvayAYgOzBkjqpq0qDN0OZDgWeo6n/MoIoUclsVRvniqOUkJHSnaoLG5VOxiu9Pq4RAKTfNNaAhghTwCp7QW8ESqRa+NInP1nn0z4tglQgkmvKNFdQ//46jJY5zjJPKn+kOJbLfpQIIEFSNAOU5PqwD+hkZcgyINFcW0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HinfuyFa; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HinfuyFa"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90e7bde5596so57966946d6.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 04:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788865315; x=1789470115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+dgpGZXxyzJEKTUi5CrmtVo7cbMHzzenxTIN8C/YkDs=;
        b=HinfuyFaKOfhSiER0ZNYdk4YIJmrmre7mzlnuRTn57Lu+4s6MYpWU4UasvcRA5nn/2
         RG2y2KMbF3McqCMBKjSu1lHL/7vP3mBZlKiPRc7aXEgDMFItpXh05NXOeLVqb3IWIecc
         PBYKDaBL3rbLnTHCdwyLck4hymQgLSBD7uYrC9b+tKkSE/VFDPp88eRkY6scsNBxq/HP
         p77GsHUfzBhzPEIfhkBkYFOr3ytO2yo3Gdqe3VyPLXgMoG8ctjQbvQ7cJjl/5G0CCjTB
         wdDHTUsoCoU88XhJo0+UKke068iw67UtkMSgwyPv7WzFS8bDFmsPn8iPa7GwZ2dlf9AW
         pnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788865315; x=1789470115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+dgpGZXxyzJEKTUi5CrmtVo7cbMHzzenxTIN8C/YkDs=;
        b=NmJVGtAECg450RW/ISm0zCUF0eH0b0SdWZm7VOQqcf2/RSzMBZRJ+ogKvWBH+kIx/X
         7CotlgaoE1BqKciiZKZKSGt9GNg7pqQ8HRiClP87RZmVdEfSer/Woo0NbQdb60yEVKqH
         x8GRH6o1xjKBzxBc0tKGzofBxKi0P7nkr/68An8VsxNJD0idws5kUV3h0r/7QBDTrW01
         wXLc9Qj8ma/JFGxA6A2ZnMJeVy57DkkKcPgOdmHWBm0e4VjBlIYN0m+kXxnxUEC6SBFg
         vXhC/6x4M2NvNyVRpQyisfgztmNUq0qieVINabavQr2+JM/3LSho/ooV28AVNdQ5EYoS
         /zyA==
X-Forwarded-Encrypted: i=1; AKwUvBwA4s1TD813JFmIPS0lDN9pB/vRD6VwA7ascFeCeZMpuA/XcOtnDNhN8p1zBxlsDRarIbbSSSM=@vger.kernel.org
X-Gm-Message-State: AFuF++kBY8nAPvz8Y/cp+ePAcYJfoWsCsXVcfVminGNUcXD8d0SxSXuH
	0bsbVMIrol59C+Ll/DHvd6hEGet/UW7y/j20ELPFvZJ++LNR5d5Su+RwusC8LQ==
X-Gm-Gg: AYBFou1v6uV8QMUZpW/gc82uXb5wMeCpViFhB1I52ogL3qrGSd+MJ82uQr2irGrYAOs
	p4Mf/pIfayIG+fmEJKxanrYTPNw4+V4R9uRMrf3e/sejaIo0JtpDVJP7AU6f2i6UrtiYN2Ell/h
	8+cg16rUySv9wv2UZ9KOe0NVwJD+zSC46N2Avcd4p8OwHeG4w1fX+WgabyY6L4N0GSGIvkSHdbf
	1gvUw9IWB0TGvf764yf4nI0mS67uDPRC2vwt/bjo1TmAlBpS2fUIQA5cOpQiZldWlwmlosIYxbR
	ge4rfFfCvigpQOTQntRg4MJqUj3kNvp2XQLn/HWBOBdo68uPljIW5D9f2u6zJKQyaK2XbePs4iT
	SRLconeDAgq3pv8IBXwD5RFAmL9/Ef2BEtaI2sjIqTyPwiIjtFHyg0Pj+DbQ3NJl+Le8lqk6vG2
	4OEwbzRX9DoBjUP3uyNirLsobmFYC3NjQZmyCbC8NRsY2WXsN30xXWhIuXCLN0BZ5EyF831A==
X-Received: by 2002:a05:6a20:2586:b0:3d1:8876:fb1e with SMTP id adf61e73a8af0-3da3976ed13mr37575699637.0.1788865272958;
        Tue, 08 Sep 2026 04:01:12 -0700 (PDT)
Received: from hnkz-ubuntu-server ([2404:7a80:860:3300:f22f:74ff:feda:3295])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc455485c25sm5207152a12.26.2026.09.08.04.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:01:12 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kazuki Hanai <hnkz.64@gmail.com>
Subject: [PATCH] ALSA: us122l: Prevent write upgrades for read mappings
Date: Tue,  8 Sep 2026 20:00:53 +0900
Message-ID: <20260908110053.2950767-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hwdep mmap callback rejects read-buffer mappings that are initially
writable, but leaves VM_MAYWRITE set on mappings created with PROT_READ.
A process that can open the hwdep node O_RDWR can later use mprotect() to
make the mapping writable.

The read allocation begins with struct usb_stream. Its read_size member is
used by the fault handler to decide which pages belong to the read buffer.
The read VMA intentionally remains expandable because pcm_usb_stream uses
mremap() after reading that size. Changing read_size first can therefore
map and access pages beyond the allocation. The same member is also
consumed by usb_stream_free(), where changing it can make
free_pages_exact() release pages outside the allocation.

Clear VM_MAYWRITE for read-buffer mappings after rejecting an initially
writable VMA. This keeps the separate output-buffer mapping writable while
preventing later permission upgrades.

Fixes: 030a07e44129 ("ALSA: Add USB US122L driver")
Cc: stable@vger.kernel.org
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
---
 sound/usb/usx2y/us122l.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index f00b53346abd..a5db0d044ef9 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -180,8 +180,11 @@ static int usb_stream_hwdep_mmap(struct snd_hwdep *hw,
 	guard(mutex)(&us122l->mutex);
 	s = us122l->sk.s;
 	read = offset < s->read_size;
-	if (read && area->vm_flags & VM_WRITE)
-		return -EPERM;
+	if (read) {
+		if (area->vm_flags & VM_WRITE)
+			return -EPERM;
+		vm_flags_clear(area, VM_MAYWRITE);
+	}
 	/* if userspace tries to mmap beyond end of our buffer, fail */
 	if (size > PAGE_ALIGN(read ? s->read_size : s->write_size)) {
 		dev_warn(hw->card->dev, "%s: size %lu > %u\n", __func__,
