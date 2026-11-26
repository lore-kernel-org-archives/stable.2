Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795736238;
	b=P3LhaaO+JuLWEAVhUB/l9k0iLgZjTtaxMf5z8jcWX2VJtRV3ww8P/pM81gNHG/V5m6CU
	 XCk4dP18ryMZTsGGLqyVFHEzlGe8eDx2UmyTVClcA7PZDN61dOezCDTkT14WuWdg3NOuj
	 CExPJgOK1Dgbrc6pN/abEr9Rv3uiyy1Q6abB5zuMYHYno6CB1g1CFAw/quOBp5Tn03rod
	 ZiUVi0+L71Ps9wEqFGhwaXZtf7JmsrBGegcXPkWtd5rH0FViym+RhD9bGHEMAnvT3b63Q
	 vrYvYJzKSVTH1CFC5dXeXufTVcD9TejFjOXIFa4c/rlsQHs+kZGAXnxG/Dqm5r52RIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795736238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LDm3bBcnTnKtfKRSJliMl96Xk4mD8qAAxIPVCJmwuZQ=;
	b=cH0ThA2oqLPAyBQtJF9+GJ1pcd32SxPhwEXR4nKCSwds6s9+ksDWrPfDy/dJ5zG1lx0G
	 4VUsiuUSuojCrvdz5/eGfx0F5OgIfnEFYF6229EMFKP+og+bpaFeLAKzzGERwOeyP8Xj8
	 5r9926cHXeGrgOdpc2DYbOyAZkWqHCetxrAykS03FYe8OiDXY647GaHxWvc9juri8tisO
	 LpF2JbBjFvuiGfie68EG3txiVr71p/FYPyWuWA5uDulk80fKc173VmLN4x6r9Wr15Md7J
	 fdmOmVJ0mjgMpEB5lVpD8lSgWcLRZUUCVEskGV0U4it7nScjw11U9I+YHmlw1gC68ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qcoco8Qk;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B36A606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 23:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B36A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qcoco8Qk
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso6760883f8f.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795736237; x=1796341037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDm3bBcnTnKtfKRSJliMl96Xk4mD8qAAxIPVCJmwuZQ=;
        b=Qcoco8QkasuK/e53iBKD2sD2ghxxpi0c7lgK88dZuX7Xjr7fCAdxBuFDgZi0npMr6l
         OLlZ/WL4pPrbmoifO8P6RydTtVS7soXQNWmBD364Jc5KpuP/cXQAkpeRZeoQ5E3pLze0
         cq1k216au9JWBWmAcSfG2BWX9GqrY3W2CcBfVl2AnkvAuFVL7mZBB+UuzU8hrUfI8+Wj
         uPlhGu4mZqvuvztRqVEeGSzIJb0Lvi0tmg8xsTaho6kb4iaKOfz+MTO7t5lABLS8IBKJ
         XivmiSZB1VwTWQnErL8ZpmGUmxKL5NbYd86WxuQU5OLsmxpg+Uy+SLvltxNwW/aNNUlQ
         MLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795736237; x=1796341037;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LDm3bBcnTnKtfKRSJliMl96Xk4mD8qAAxIPVCJmwuZQ=;
        b=XJh9Z5XmIPlx3i3IAbJC1iiOh7sRqpScsdF4cZsswIEDv0PNTsbcve/EBN+Dc9MqOo
         Jq7FmDWkNXWNRgKnef+RLBeYdrpXFk92pkGvDacwvFFSgnBq/zVbzsrm8ckQf48borq7
         eqIWgt4HNOE97RB9skiAS6pTHxjRms5JWn7mdAvBJ3LsiKkS5BZAtIz7cdquv0SWkpTH
         Fo+xYrn4jnHI87DQ97fQ3FdqAtvIpxrYZQkV44/w8DRepuBbF34Fa6O0IHDmwdEulL1F
         JXUqWpQkaiszL7J+5PnD1jkfI2D1/zggiUVFeaM4ZCR4eN5bXt5eo8l2vwoORuXi8mfN
         KaSQ==
X-Forwarded-Encrypted: i=1; AL+hErE4l1+zC5WPvgQiHCvq/MfrjTzWzEMLts7ZbL3zzue25u1rCpaERLHAZ6vQmXLU+b9krsjpDUE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8B5ZzfyrNal4rmusCPRc5wWYahpSSi+Nw0arbbfqlinAPB9uif
	7qMKVkev17RNM2O/O4Ma18v51urgHQowwptkEWGJsQziVEnzDBJbTv+f
X-Gm-Gg: AZFdTZcRED4I9s9aETtytg14i6wMZ92ze8eejm/FxBL7/4Cw5CoeKcG1u6hCGXaOlwJ
	bjPVXWPtC42OIKZT03jmZZAksjc0jbZ1UNDWb6X02svtBTaw+j5fiXQS7WjnyeY+9nZ7Q2PyQoP
	uQNFzOkF02AXVjmmEc3Rq8OvHhQuxuT5dNFIptppsEAkZ8uMmikERKzrKwysKghEvOuEj4I2iU2
	VVQJe8wUyk1yGtETTlTSOLBMYwU+VtWd0cvvxFfWXBW72OOrqI1aT4x3rmDwhTbNs9wbw+XKXj3
	keJuRR3YI5NWcqjBm32kmXnry5ncAOfxYyVAgwH7y8gyMscU1Km4fF6WaZt5fYy7/Ob1pH7Zlcf
	ceG8WGMpLwYjCPxUPlbggthoK8Nd4hOpKzncihGqrV6YazaFTA8VTFuION2epTOBadT4QAiqB9h
	2YYEsGFCD9JZIIBSy2JaSCDltWqjNMK1CsuiJcDCO4Af3VAEfEVWpDRBPrhZosMWHtXBCGragJi
	0ATCBZd07bTulklKybWXn43cff0RXkRbAw81sWCbr2wgfqQm2hO9pAa+Femy4cqb7bim9c1phh5
	TnMPIFNZ27UagQP1HMphA5OS5cp0WIGSc5DK7nvi9tiLPtSTZAn2jUCWVHU8Ni4qJT7XN/znLs9
	pobBQp0VH
X-Received: by 2002:a05:600c:3b94:b0:4bb:6f41:39be with SMTP id 5b1f17b1804b1-4bb8880ca3cmr564837615e9.15.1795736236738;
        Thu, 26 Nov 2026 15:37:16 -0800 (PST)
Received: from Mac ([2a01:599:843:3686:f8c1:c9a5:9d66:c45e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm630189005e9.10.2026.11.26.15.37.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 15:37:15 -0800 (PST)
From: =?UTF-8?q?J=C3=A1nos=20Szathm=C3=A1ry?= <szathmary.janos89@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?J=C3=A1nos=20Szathm=C3=A1ry?= <szathmary.janos89@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] loop: only write back the backing file when direct I/O is used
Date: Fri, 27 Nov 2026 00:37:10 +0100
Message-ID: <20261126233710.42048-1-szathmary.janos89@gmail.com>
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

