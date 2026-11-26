Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795736106;
	b=UCa1tt6TU1ULNpIsmnhNiO+YOOfkplTpQgAa9CRZIOJR/ZUck9aSeZauxN6kKfEUnRXO
	 PtX/W3x0ZHSPQndYdCl+8DUN0AdKjxo45RKAuL07CKFNKIzKaBlcUCCKWyu96TH/TrJlf
	 Tv80bC1YQQl7OO+jTQ48VoOeDspV8HchCQLh/2FgAtMtOsUaW/CwKbaDIJHptYvv2cU01
	 cFbFuCOvGktM0TGAt9FyTIvrYixql1fQuPkALofzOpEPlyxCvHkULt4QQfOcrZ3sbsA8L
	 5MbgwFZHZUaK6mSVyA4i/T71AwFa8TVFsAuwamIcBK0nHyRTvBGoBmo5Ik50hiYbaIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795736106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LDm3bBcnTnKtfKRSJliMl96Xk4mD8qAAxIPVCJmwuZQ=;
	b=c/c1QBb5AWxZNhn3tId4Tn3XwtBKbe8JRQzA9jx/Icl4EYvseKL1KuHdIjp80b3kFGRw
	 ImMuKwWFmm7b5sBvQJjZZ6LZjYmLnQb4EL6QxP/rOShX2en9ip/xZffe7Qsj/yeWBxt97
	 //hDcfIzNeDzNlT4Zq8+BTEgKSTsKOI2tB4mwNfCo7XgH/zERN4kG8mS7cTNXkKAIm81X
	 2ZsY3GK2r7+/rhAqOofoxMSw+uUZ1TI7hZ4iQLcVYr5nbRpdNITicqdnMwNDdja4yDrle
	 fSxZIsZBAxR7mk9FU16DLJtofXM7iITDCD2AoSpdOXMe9VBCe13ZtiQtPIVN4Ox+x+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=odNLMFmY;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8488606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 23:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8488606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=odNLMFmY
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4a32576da88so4342797f8f.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795736104; x=1796340904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDm3bBcnTnKtfKRSJliMl96Xk4mD8qAAxIPVCJmwuZQ=;
        b=odNLMFmYUky8CejICzOCts7qVd7tAvykDlBzjsjv45kaOEagzFABAA891xwcaoTTRY
         xiQbbK6byyN6yop7VUWXYj35nWFoftDm30lR6cBlkOL96yGw1P5Id+Qz4NlBE762n0eP
         AewI8uNhWwsJ22q+b2ZqBOgf2t91Jghls41S5ZPsPnm2AqTcRQLmk5E3ndBmIcOXSLmV
         fu2bYZBQdGFOdJu5Snf9jdDFJ6llzeI9QI+PhyNQj2/QgVGcpZtxvKLEh/X3dQh3EYTX
         6EJIc7vMCbwNfGhn0MlbddikQ7REXTq+XJ6LDnEbIdRzac1IQ0TfjMcnceU4FNgqzqCT
         dtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795736104; x=1796340904;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LDm3bBcnTnKtfKRSJliMl96Xk4mD8qAAxIPVCJmwuZQ=;
        b=Rc38HAmU63wCjlQD7B5FO5mjJ355L87G64CMT8SGNZUrhnz3MU0NhY6zvbpK1BoSox
         H5BSbhToujCN+ymKgzUbShLge/8w7Dwont1sXgesNDNWmYk9CFyyiLAoPnc9rWoVqcwn
         L+J6RlgMG9Jdv7SM123KPClSsXyRzHZ6wRlrCA3U4edIcVhBgyg4Ol+zHzu8qg6cvRl5
         AwRYacgZThi8reaef5vpHbtUlDEs5zsqO6OWnzkUYR/soZ/FpmfUIisLn3QNp0YaCg3p
         aN9A+Uukq5lCbBpeXewA+GTxF0QaI6S0efImpSpwCZa+AWXvTQ6hKCL6bm6cz29SPrkC
         MQhg==
X-Gm-Message-State: APuU4Z/1FQihpbZbQ+N09U9jGxon09WVjT220rTii9zw9+kid1QpXHYU
	X5vetKREAv15FhNe4yNQDgYt48XugOG/Jtbhs8TxlLmEDaiFuhKFkzaVKdw3Xg==
X-Gm-Gg: AZFdTZchCBMphwapnEZvF8Wazn9MTSNN98wlhrZ+D8gAwbirSwwU2aCkIRoMqDPJVRX
	hL351ytPOL4fArTbBj88358l/zJ9dUdgMED69Mu+u5bYtA43WCi1R9I511i48QsHh9Vh6fcesMg
	98xwcVzFfXyXfmQ05lmwmV2DY/6B4LXOym6AzOf+/XXznu+fV0aqlBaPUEfISfEfSv5rcxzLydH
	Vb1Eo337/i7rHNUHOj3sGJKPgY3+CvFI0V7okZmzQkLk8sfzJQogv1LYclqdumyv8YXUWVUPknG
	pRrC5WSW1psr5VAn+ZeH6ZxlnZO/XO/f3OAVfVPSGPTaGT6hahW1wbkQpX+BbxCy7sD6uLF3CbH
	bTAD7cP5XpyqGhKOBTw7BCjluudjp8UZD33/GODQ4755e8dEeaiKsHpbK61h4ivOWai9aItROgV
	u5HLuY1W1UCASAAy7n9w5huNWnyEn7i9/iM0G/HoGrTC1xzJx+JlbXObquW/W5cM/Q47sGAMf4b
	uvOwI5LN1OfEKsPX0tRQeBWKxFvkbzrz0xIIWhr22Eq4RxRU1D/CLtKGxZryo3cjJiRIuLCX0K+
	r1meIctYlAvgVSG0KsYFOUJkg4numn3vwzzojhlhgO+0JyeD2In3u07u2UeZjQOGhzrb+h1n/Ki
	ZIgaykGgy
X-Received: by 2002:a05:6000:2c04:b0:48e:7470:9e98 with SMTP id ffacd0b85a97d-4abb683b5edmr49579657f8f.39.1795736104132;
        Thu, 26 Nov 2026 15:35:04 -0800 (PST)
Received: from Mac ([2a01:599:843:3686:f8c1:c9a5:9d66:c45e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680483sm43970232f8f.28.2026.11.26.15.35.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 15:35:03 -0800 (PST)
From: =?UTF-8?q?J=C3=A1nos=20Szathm=C3=A1ry?= <szathmary.janos89@gmail.com>
To: szathmary.janos89@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] loop: only write back the backing file when direct I/O is used
Date: Fri, 27 Nov 2026 00:35:00 +0100
Message-ID: <20261126233500.41908-1-szathmary.janos89@gmail.com>
X-Mailer: git-send-email 2.50.1
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

Commit 86947bdc2889 ("loop: move vfs_fsync() out of loop_update_dio()")
moved the vfs_fsync() of the backing file out of loop_update_dio(), so
that it no longer runs with the queue frozen.  In loop_configure() the
call became unconditional: every loop device setup now writes back all
dirty data of the backing file, also for a device that uses buffered
I/O.

Before that commit the backing file was only written back when the
device started to use direct I/O.  A buffered loop device reads the
backing file through the page cache, where the dirty data is, so it has
no use for the write back.

With the unconditional call, setting up a loop device on a file that
was written just before waits for that file to reach the disk.  In VMs
running 6.18 with a rate limited virtio block device, mounting a
squashfs image through a loop device (LOOP_CONFIGURE, then mount(2))
right after the image was downloaded takes:

  image size   time for the mount
  0.4 GB       0.8 - 1.4 s
  1.1 GB       3.2 - 5.2 s
  2.1 GB       2.2 - 2.7 s  (larger VM with a higher rate limit)
  4.5 GB       6.1 - 11.0 s

The same mount takes 4 - 9 ms for a 0.3 - 0.4 GB image that was written
minutes earlier, and 4 - 7 ms for a 2.1 GB image that is fdatasync()ed
while it downloads.

Call vfs_fsync() after loop_update_dio() and only when the device ends
up with LO_FLAGS_DIRECT_IO set.  loop_update_dio() can only clear the
flag, so it is final at that point.  The device is not bound and the
queue is not frozen there, so the write back stays out of the frozen
section, which is what the commit above was about.

A device that is switched to direct I/O later with LOOP_SET_DIRECT_IO
is still covered: loop_set_dio() writes back the backing file before it
enables direct I/O.

Fixes: 86947bdc2889 ("loop: move vfs_fsync() out of loop_update_dio()")
Cc: stable@vger.kernel.org
Signed-off-by: János Szathmáry <szathmary.janos89@gmail.com>
---
Tested on arm64 under KVM (QEMU 8.2, 4 CPUs, 8 GiB), mainline at
9437ee8b6cf6 with and without this patch.  The backing file is 512 MiB,
written with dd just before on ext4 on a virtio disk whose writes are
throttled to 150 MB/s (QEMU throttling.bps-write), several runs each:

                                  before          after
  losetup (buffered)              3.42 - 3.65 s   0.04 - 0.08 s
  losetup --direct-io=on          3.40 - 3.56 s   3.40 - 3.68 s
  buffered, then --direct-io=on   -               3.53 s at the switch

Dirty in /proc/meminfo goes from 512 MiB to 0 in every case that takes
seconds, and stays at 512 MiB in the buffered case after the patch.  A
squashfs image written just before reads back identical through a
buffered loop device, before and after.

blktests loop group, same result before and after: 001-003, 005,
007-009 and 011 pass; 004 and 012 are not run (no scsi_debug module,
systemd older than 259); 010 and 013 fail in both, because the test VM
has no systemd or udev.

A W=1 build of drivers/block/loop.o is clean.

The times in the changelog are from VMs on 6.18 and cover the whole
mount as the caller sees it; LOOP_CONFIGURE was not timed on its own
there.

The cause was found and this patch was drafted with the help of an AI
coding assistant (Claude), from reading the loop driver at v6.12, v6.18
and mainline and from the timings in the changelog.  The tests above
were run with its help.

 drivers/block/loop.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a3325ce..0c84eb7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -986,14 +986,16 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	if (error)
 		goto out_unlock;
 
+	loop_update_dio(lo);
+
 	/*
-	 * We might switch to direct I/O mode for the loop device, write back
-	 * all dirty data the page cache now that so that the individual I/O
-	 * operations don't have to do that.
+	 * Direct I/O bypasses the page cache, so write back all dirty data of
+	 * the backing file before the device starts to use it.  With buffered
+	 * I/O the device reads that data from the page cache.
 	 */
-	vfs_fsync(file, 0);
+	if (lo->lo_flags & LO_FLAGS_DIRECT_IO)
+		vfs_fsync(file, 0);
 
-	loop_update_dio(lo);
 	loop_sysfs_init(lo);
 
 	size = lo_calculate_size(lo, file);

base-commit: 9437ee8b6cf607e883b36e44bd755968daaebd48
-- 
2.50.1 (Apple Git-155)

