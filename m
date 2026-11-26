Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735533;
	b=NyC1PB03amrMWlm8BVumWz/cnkVzacnQWNG05yrcC+D3KHKjDYgOPQEux2UAkv6NDK7/
	 DLdx2jxJGiio1UIBLDudl1beNJsyytP2nITpAO+bCCyA0XLxwLuDRMP6QzRWeINxEy54t
	 aqrmSCXSSSXT2IUdXD6D0kCtrCrK8DYVJh36oJDDjCut+md4a8ICUZfUf1e3RaYg44+Zp
	 /o1uqRHhG5+ml4WsYXNxrfzp1jjTV5Fad9RKHT+MbAnNAAIKR0ajjT+bW+hd3BJ9lFDx7
	 CInzuynE0sf98XR7sEhIKei0gerLpz0aqi9EkZKO5/RLVSeQqr8l8Fh0bdZY1yhG43A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oG/+w0csiQVe4FFI8b0yBOwgbMGqEcUyNTqDIYH9z7c=;
	b=sfOTLTLXxk9DBjNZozmlyyO7q1pOEUiy8B0Au3cfP4m5dNfIazZMWZ7pPQF2jlrVsqQd
	 duUlWJyxBwPlxorL+6kbXExUpxDcgVcQdXmKNzNbsjmzzS2mtO48W8ktuLb5fa246uKsA
	 vK70ZBOw4rE7Wd94PLBC9Qf5cZ0atOb4Tl1setM6HVMcwAr5QFDGHiurGZSD+s5HYBxfP
	 eeJt3UMJNochJsOi5KHp7C3QharsIh3y7h9tLETqnBmv751PP8dh+730F8x7LGvL2W6LS
	 uYvCoTMkM+VAKs4YU6Hq0p2DiyHxw607ymmG9AnRs8+A1L49wYUKJDzmTuSpDpZ4MvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C63CStN1;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5E606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 23:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7B5E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C63CStN1
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so68289515e9.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795735531; x=1796340331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oG/+w0csiQVe4FFI8b0yBOwgbMGqEcUyNTqDIYH9z7c=;
        b=C63CStN1mmXK2ZTozkm4P+LZR3wvdlhtpdjRo8AJi1RnqwUb3vxYdhlmFSe57+qdJC
         1985/XIVcPVZlOXVcn1CQoy/fkNTjprRaL3ea71Pz8+7T+aXyMJIEb3mED92kqPesAtD
         SRCSaYa83SZgqtdesH0RtSJZ/T72kFvM3aNrjGQ+lHdBjJ3mpA84nq/ge93wd9+rRe/w
         hQY+8AU6xKXvLy92EOxbUSLlq9UGdG/tSEX8rpbSfLLDvN+2yRAs/xd5X9H2Mkqpy2dh
         toN/GYhaCTbJojTX1RmS0pRxCIuONnTJg2Y3qCoH9baCm8U5cugnWS8xEmGf8r80U8qo
         Ri1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795735531; x=1796340331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oG/+w0csiQVe4FFI8b0yBOwgbMGqEcUyNTqDIYH9z7c=;
        b=1Soy3Sa7QcrC3xONPSipcL1AVrFMf/HXuuFAsJMASahFw8I3NfdnCUVz0xM4MD86BO
         gow6DsiZaNREG5xcqfjp6dmiYBdabRfkFByy7m6+tAfUgo4ulz4e4dow+RJqJSNkoaRH
         92rpHOdZEKDZLonGMPGkOpY3d4rOsumVPeK5pX+Or504Gi0pG+l8uqLsKemK8S2AJoK1
         vORbOAOU/BCsm4ok5X9eUtkd5CxYW13IdQM4TW4vRV0obo2k7iEdPyqSx570eeqmZvkF
         jOsWYD3Jzks+zd2i/DLW742bnVDrt1+XDbi0i8F7wKU/ugoI+Qj9kvUtGJ5SVWtldK0g
         f5cA==
X-Gm-Message-State: APuU4Z8a7iw5brGwZDf+2Xs/V0MrH5WSFcIGmdx+ak0IaB9O3s8Gd7w/
	CA+Kd4TU4vieMCksS88LklMbRCiKCteWxkKJhgYpUv1WOIVccOn/R3f3ioud6Q==
X-Gm-Gg: AZFdTZdnoXn8c/oRWhM8uVv1/4sDPdNdaSgQ3zz25bA/gISn8dzRO5xnK6+Qtt1cVmz
	4/UTGJv5LRfQps+wQqFchuHGCxF4NxY+pqQ9hKxHXqk7rmDI4o49aclo+8asQkskFlbltkJggep
	o+SFZMzLneIU6N/2HoVUmC7jsNpvcwh5y7fA4NvgTf0x2BaQDO17CdyEnjjV3FBD71J4jlsYeDb
	gojCeR9zWSP9SRnrkTMdci4T3w8GrTVNpP/UQkBfzqf4I7MD4IHvQSeF6m6FTJCL7QokGjNIHcD
	RSJNqSCXN6zqHo7okfuOYzfJaBSBDQ1Z+2K0s7OYmKLBn/C+5PHxIhzZ/DVRqungG+pUigrj/wo
	ZtmwcBFcHEIh//yEr827LDBzQtRVD4x1cLUaghDcKdRYDL69fUxFFeblqX0WqVXqW+x4oVtddLt
	xYqF/4l1tt1FnKlD4PWMR6zWPyYbzq2H+191BMtL40tK0JRIIhPD8nKaL+hXjcBZFNSIt5WiesK
	8QIaxHjaq+17TSapFb4sj533gmjEDmoVZJsStw7lbh7ngm7pyxZmdgKpExJDX9HSp5ahQvz9inH
	zBMTb84mtXZpaz+lv93E4UZQ6LjrUTaWXwKN6DUfK46kXy61dY/VozKP7nlTcyCC1IlAXpksR8h
	FFUfzHcZ7
X-Received: by 2002:a05:600c:64c9:b0:4bb:8701:bb14 with SMTP id 5b1f17b1804b1-4bb88804d1cmr483522705e9.5.1795735530848;
        Thu, 26 Nov 2026 15:25:30 -0800 (PST)
Received: from Mac ([2a01:599:843:3686:f8c1:c9a5:9d66:c45e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8533579csm552898115e9.2.2026.11.26.15.25.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 15:25:29 -0800 (PST)
From: Janos Szathmary <szathmary.janos89@gmail.com>
To: szathmary.janos89@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] loop: only write back the backing file when direct I/O is used
Date: Fri, 27 Nov 2026 00:21:41 +0100
Message-ID: <20261126232141.40888-1-szathmary.janos89@gmail.com>
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
Signed-off-by: Janos Szathmary <szathmary.janos89@gmail.com>
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

