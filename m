Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640979;
	b=v3ih/dut2ZqEFS94cV7W/hwjFYzeUQ7AE464HKuvKxbaOvW8Uaj97s7+9KN1F7rIO+Pt
	 o+Th1lDQguGazx4P1cvGsTiqUCeOiqwQZTLjuODgVVsGg0OlHe2wRKZugU7Iv1oiN2wBd
	 nA7xRv6rwYV61GbcMe7sIaUWcGGI46mTegQKI9m1sicPdwYz7Zk7/TfP/L84OUhw/V7Dg
	 iny8fDjIb5n+8SNxeC8SeFToiSBCpxZ3MqxghBEoW9gcljBAMYPAWJ3XaOBXAU1TAc4Mo
	 a+jlRtG4UAORLKpqU4BXy/KtFoNkrq7l6MgBosdA17LsGFOISrkQj33pzk6C5+JHzhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ElUJWOdoo11axaVjJS7g+O8dXrqVocWR0XYxanpNOCM=;
	b=iJb0pjmdrp4/T+Q5liCAg3J1qfTxPWO9EEqwZquyyoHZGWKxGDTUgatyh/oNNlvLmSLq
	 uQjug8SG1LQtNzAiRqS+kQjXXJ04Wgd7GJ3MWfP6+/gEBYFjSi75toWtaCOAeEEhmlObe
	 jxWKsvJ9qZtksJmbYBCBiuXTpHPRDhJOVAk4K8pKIiQSItcet2zQ3Mt4vE4Y6InBwUBqj
	 yp1poG1wqXvSqB7TzY6w6GykdR5QHHIAaP0B2xscXJRhn3TPB1chY8UH/CVhk/h7kjfp7
	 9jlB4Sp/DfvltxTDR9kw6JwgmR4JPZ9vqpv/PR1tgfzx0qPCSjFxoC4S5uXRvak42bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yzKch8es;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A50606A90E
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 17:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1A50606A90E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yzKch8es
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso1707341a91.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 09:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793640978; x=1794245778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ElUJWOdoo11axaVjJS7g+O8dXrqVocWR0XYxanpNOCM=;
        b=yzKch8esjQrEKcQH3riAxIKTubwAXtuBXQ97tW7DzgL1hPoMhkQAtm6Y73K0Q1w4vY
         dsdxc1zMKGFC2G0Y9ZVpNLsi7IVSB0YXDlsKPMXF7AOEAnk2g+N7wBS8jfdWCAQXzbQC
         6QxrVW9Hy1uOjOrxHtXFN2wG5+cpH7YY2uh20LhKP0mPTwYj7rKPFDOBAjJmIfB3KHHw
         eSp5xfyqeem0WBpEvdHEKXWBkVzTXCplcstPRNXjKlGUTePvi+N3bRq/pdoCOfBUY+yx
         ern1LxJ5vKnTbk21x+H2jHLeSpv1DzMH84/LQjb+vcJJjesGh3ciX9hn33fT8Gu+uCBd
         Pl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640978; x=1794245778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ElUJWOdoo11axaVjJS7g+O8dXrqVocWR0XYxanpNOCM=;
        b=onnBgChYZ4ljqJIivfhUcgiXaDkpfmqi13sknDsDgKx4I7ip8r5y4AGFt/iJjdvGoI
         9UHuUKLwomwx/wmnQmaOxbQkZVlVu8O7GjOmEFruHQ9asECdhfBk1BgVTAhgFmK9eOcO
         mblRs14rbdOcbHLlB1IMpmFU2zTU9W8Z3xeGT7HtrrWk62CjZDoLgs3Aj2hSHsVebN7z
         AaU3JBRGKdGvQs2T7O8yQW3Rx58UYhQ8qlu9z24BGEOCECMHioHXGXW8pfo/dbZc4feN
         tvW0SWzrgsbdlqRrfqBNv5hLYM5jnH46xv7q2jOLbJSMo6LGLCWKQLAZiQHjtyaVO1St
         B/Lw==
X-Forwarded-Encrypted: i=1; AKwUvBwZGHj0/Vx3XkdJ5rbsBBoXgPVIMkoHMjaSz5i1LAV5FEioqM8wnTCfMhAF6UhmxxU5zsGVxjA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NT/ISh2w6r9H79Lpg5FMeY55E0gjfeZGyqFKRC4wBspo+u4Ru
	Nz17Eoro0iEboU1cv8Xn2t/1wOk/5SwPhj+ZF3MrPddlJkwEV3irU1mM
X-Gm-Gg: AYBFou3siEaD716yNXdmrbjhVP1vMIyHOU0yOV8ySEjIn+KVItzLo7AlhtbgxqPWgQc
	VlWxWcuGzaYWzjs2GCabSThBRxEovw+ycXZuC2i/vG3ozGsVQJssYX/LE7GMbGSpAqvXqT45zw/
	RhuRiOSDCIg/KwPdiFTMmcOBa1ynDImsKExYFzFLS7oqcCPZuKp5EYzeaGLTyQoFUCCRILt81WY
	rQOxq2WaxmVXQPfXPR1dR+8mjRfjLGvB1qPu2yYc47q4OMflmTXY0AlGY4+OxPA6ZO9B18V8C9X
	w8ki863L+XV/RCGAGY2Yht1ZsGAkG9E2So28hekjpzBPJ2sIe3aggX5OPiM1Zc3N2+Tq8/Stkj8
	qClqhW8GVv6xzMgJMY56My0TkmvihlaaPIFYJ8Ft9ryvoXd0KH1CrfRz/IwhIrQWBOmSvID9hka
	eD4bxvUx8aDAv50+45KnMHRSpQ2eeV4yR00ktERfzHEPc/BK8gjRLCtsW1rDiA9nBQGdX5YXRE0
	uu4uDdS15zthxBHLMzC4Cjmtb2e4le2Wz+YqSmnJUypUZbSDCz+jROyTpVYbzkzM6+0Js7++HmC
	idUFewAKoiptR6iSU5VV97YVkQHcpQB237XU3j2r7HCYXvOU8al5fA2HjfaG6CYwkA==
X-Received: by 2002:a17:90b:3e89:b0:3a7:9045:fe29 with SMTP id 98e67ed59e1d1-3ae895362e9mr9184522a91.4.1793640978092;
        Mon, 02 Nov 2026 09:36:18 -0800 (PST)
Received: from localhost.localdomain ([61.255.248.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c666cdcsm142858a91.11.2026.11.02.09.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:36:17 -0800 (PST)
From: Song jeonghak <thdwjdgkr123@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Song jeonghak <thdwjdgkr123@gmail.com>,
	syzbot+250fde257a3eebba4426@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] jffs2: keep alloc_sem held when a write retry cannot reserve space
Date: Tue,  3 Nov 2026 02:33:42 +0900
Message-ID: <20261102173342.314251-1-thdwjdgkr123@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When writing a node fails, jffs2_write_dnode() and jffs2_write_dirent()
retry once in a newly reserved area (jffs2_write_dnode() does not retry
for ALLOC_NORETRY). For allocation modes other than ALLOC_GC they first
drop f->sem and complete the current reservation, which releases
c->alloc_sem, and then call jffs2_reserve_space() again.

jffs2_reserve_space() returns with alloc_sem held only on success. If
the new reservation fails, both functions return an error without
holding alloc_sem. Their callers expect alloc_sem to still be held on
error and call jffs2_complete_reservation(), so alloc_sem is released
twice. syzbot reported:

  WARNING: bad unlock balance detected!
  syz-executor317/5670 is trying to release lock (&c->alloc_sem) at:
  jffs2_do_create+0x1ae/0xe00 fs/jffs2/write.c:474
  but there are no more locks to release!

As mutex_unlock() does not refuse an unlock from a task that does not
own the mutex, the second unlock can also release alloc_sem while
another task holds it. This follows from reading the code and was not
observed in testing.

Take alloc_sem again when the retry reservation fails, before f->sem is
taken again, so that the lock order documented in fs/jffs2/README.Locking
(alloc_sem before f->sem) is kept. jffs2_do_unlink() already takes
alloc_sem without a reservation in the same way. If the reservation was
interrupted by a signal, this waits for alloc_sem uninterruptibly, as
jffs2_reserve_space() itself does when it first takes it.

Tested with the syzbot reproducer on mtdram: the warning is gone while
the failing path is still reached. The jffs2_write_dirent() path was
checked by code review only.

Claude (Anthropic) was used to help with the root cause analysis, the
reproduction setup and drafting this changelog. The fix in
jffs2_write_dnode() was written by the submitter; the assistant adjusted
its comment and coding style and applied the same change to
jffs2_write_dirent().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+250fde257a3eebba4426@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=250fde257a3eebba4426
Cc: stable@vger.kernel.org
Signed-off-by: Song jeonghak <thdwjdgkr123@gmail.com>
---
Testing details: next-20261023 with lockdep, 128 KiB mtdram with 4 KiB
erase blocks. The warning was reported in 6 of 7 runs before the change
(the cause of the one miss was not identified) and in 0 of 3 runs after
it; in all three runs after the change the failed write and the -ENOSPC
from creat() are still seen and no other lockdep report appears. A basic
test on an empty mtdram device (mkdir, create, 20 KiB write, rename,
symlink, unlink, remount, filling the device to ENOSPC, remount) passes
before and after. Not tested on NAND flash.

Two pending patches, "jffs2: Fix a lock leak in jffs2_flash_writev()"
and "jffs2: fix wbuf_sem leak on summary failure in
jffs2_flash_writev()", handle a failure of jffs2_sum_add_kvec() inside
the write-buffer path in wbuf.c. This patch is independent of them: it
fixes the retry path in write.c, reached after any failed write whose
retry reservation then fails.

 fs/jffs2/write.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/jffs2/write.c b/fs/jffs2/write.c
index cda9a361368e..0ac3220e7b05 100644
--- a/fs/jffs2/write.c
+++ b/fs/jffs2/write.c
@@ -147,6 +147,13 @@ struct jffs2_full_dnode *jffs2_write_dnode(struct jffs2_sb_info *c, struct jffs2
 
 				ret = jffs2_reserve_space(c, sizeof(*ri) + datalen, &dummy,
 							  alloc_mode, JFFS2_SUMMARY_INODE_SIZE);
+				/*
+				 * jffs2_reserve_space() drops alloc_sem on failure,
+				 * but our callers call jffs2_complete_reservation()
+				 * on error. Take it back, before f->sem.
+				 */
+				if (ret)
+					mutex_lock(&c->alloc_sem);
 				mutex_lock(&f->sem);
 			}
 
@@ -299,6 +306,9 @@ struct jffs2_full_dirent *jffs2_write_dirent(struct jffs2_sb_info *c, struct jff
 
 				ret = jffs2_reserve_space(c, sizeof(*rd) + namelen, &dummy,
 							  alloc_mode, JFFS2_SUMMARY_DIRENT_SIZE(namelen));
+				/* See the comment in jffs2_write_dnode(). */
+				if (ret)
+					mutex_lock(&c->alloc_sem);
 				mutex_lock(&f->sem);
 			}
 
-- 
2.43.0

