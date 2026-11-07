Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049147;
	b=r8obkXBPUk8WjHJ0cfz07yEh0LMj/vOk26qYU8IQfQKLu8DFhoV9XeKlGAc6G2SRDY8T
	 K39vu06DFuaaWVtlVOCcR4Pl7P4ui17h/DyzFXuJ8Jz4yYvXueZ/zNSFRlG+NMB33Ihd6
	 Lf/ZKoOhxO8v/1DObfPlALDf6u0L3F+a112wmznsqdNLS6K62mLOlP4HOM9qzLFef5bbg
	 hakxVjQtV3GuwPYw9VyVRzJAdrM6H7NQkk/NhAUyxf4KU0gMIqfWMBzFhruzG594efvf7
	 eb4TWn5HtlQiGlQzmePmSVVR4vkFe2eUHtQckoZvXfpmeit9BbZiKQFd0KuNFktyGtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y7ipCEUrdtIpyp5vON0jqVmEjc93IveEInQ5iyQmhTA=;
	b=I9zgVwAvCemYKWkM7Q0oXtFWoO6tLUqMYqyb9gQF3n1bcF1wK7xciiW/RNJGr0BbIsJa
	 k2pa1uaxnRpdRAPZQZtsA3fQvtfcA4mfieA9vHAZ9gicO1+o9yEacJ+eTkkZZAl6BsDPF
	 zRavS9xB+Xm6w52lIWGXzMWpQSJSSZ8+1+TQ1v/VRD/6K7vH1zjX46szpVRJk3mYbaP71
	 bBOh1fRKQfR37MQQj7Qw+sir6ovnpAB4y+YarOGdTKqADgHPJd/KY/2T5L43SK9WSNH9Y
	 pY/e1sKhbTCcQ86nHOi0eqNsLjJVuN046tFBSdxXAmnPXgKokxpwMUNBB5b/msO2IOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HvHBgbPz;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C5F606A332
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11C5F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HvHBgbPz
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so1970140a12.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 02:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794049145; x=1794653945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y7ipCEUrdtIpyp5vON0jqVmEjc93IveEInQ5iyQmhTA=;
        b=HvHBgbPzV9vYHHncefQoVq2YOPXOaNBD/LbZSBsl6UfsFTreUEenBqrKE53enVGuBZ
         cueLshNxWFgeHUaMlnJSyuePRFv9cT+JapbvK0CR0AuNoWM1s1N/plgLfyuGF918j6CL
         JnyxhTCp+Mf2P7oRpE6DHVRMATjRXyXkEcGgV6KD9cPZiK1wL31xrnGczuQvsUSXz7Aw
         1I53MsBjFTbYzDj8vZfcYNuXHhuGFXmJIsIo/BA/tIr6fK2zFvM7hPAyW159j6YDVvJn
         IjhaqiDJ/ulTJhQFzrbcrPEULvfN1P4GMk1YH3KRAGA79bkiLRRmnnGjPcfjgjHV9md1
         D+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794049145; x=1794653945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y7ipCEUrdtIpyp5vON0jqVmEjc93IveEInQ5iyQmhTA=;
        b=XXZQSVKaxTTT1/V5qb89sLFS0s45M3Yew5qZg+35tNqzGb6MwBOBMr1yFBPfPwp3eq
         Z8zzkGeLjWqWYTu5marvGpecAM8zImmzJxk+lRvnCaCxYOodaqhNTaSecZI2EPYcT+kI
         YccNwBr1gbmWqXKUp4BcKZHOJ+l1VpnX1T9XHac+A/XAolk9MRzwiM9sDa8gj/YEZHC8
         kwKqa5gbQ19u0WqIo2JfrP9YOnPefuRfWerNNKAruvAaMzOq8rfJyN+WfYbCY8esNCXT
         dF3Jj69gMJLATPks72iDhHlcdOqoM0XedCb0N8th3Izusn0COw8xjNHINfJWiu29KEyZ
         rCZA==
X-Forwarded-Encrypted: i=1; AL+hErFPB/9b0BE5MbDEwd1OBSxw81/aqodxMdC7eufY3TH315BGQd2K55vZcWH3fbYS9sLFM4XkO20=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rQ7THl7lYm87NLfzM3tug78kiz9QYG8f8UwFKCoFQtMqjkIsz
	H/Y9H6kFU6kdl05W+8gj4io0qlrg/ayC8D/uwkhRGipHddcCI5S7oPVR
X-Gm-Gg: AYBFou2rTXYtZMRH4pKIIbRCinY8vSChp9LVkQhk0QH3Y7awy5BZbz6ybpQkpa6Vx7W
	uqELRENSJ4TrOJJERNpViovQ/g3ZYwXX9vObuF6fqf0r2PWgUjoCNF91MuHXOq2fa24cV6wfdl2
	+oJtZa7JQGP0Omb2RCml5zb39fsS6tH4IDyrMX6Ki7pMkr7hQSfrkPGdlENF+From2t5vDvzKFu
	dFaO6Tosd67WxYJ1nqitiq25yr/uUoDx9+G793n0+v9j08zZO11PcsibNos4tVUTUTvnaDsMSR5
	a0S7a+C8etWjvDcFMorwTPF54txTeJQiLRtb0J5Kreydny/dtfqfp3t8qqxePMP6GqCFQRRyE+9
	aAjidYBCD1AjUJ10RwqWijHguTddKSedXL9NeX5DUzLs47R6TasDfsz0XSfZ4pyXs2PSVw66Xwi
	ByT+enda9pF131ofBHu9N6V9i+7so7eNJsSdiTdATw2TMz2bfOIFwnFUivqQAzUQyjDlWADAeeO
	W9efSalKzepdG6ue5bgeEWzBevgOI2CNNOSwvgEggtyDxQ+7bgnYos3hsJvDB7pga0UH4XrQRyw
	Y1sZVy60osw6GH0pnpe1vs1Agy35kjauBfsvR4Ts90jbdjTXMP4uKdDO2WP/Trcf+CaN5KUM8Si
	YcDAKUfDusvs=
X-Received: by 2002:a05:6402:43cf:b0:6b5:4fa7:4f49 with SMTP id 4fb4d7f45d1cf-6b59753419cmr3643652a12.6.1794049145133;
        Sat, 07 Nov 2026 02:59:05 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b65d6b3847sm1654045a12.1.2026.11.07.02.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:59:04 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chris Mason <mason@kernel.org>
Subject: [PATCH 6.12] backing-file: always end a queued write
Date: Sat,  7 Nov 2026 11:59:00 +0100
Message-ID: <20261107105904.3962893-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Chris Mason <mason@kernel.org>

commit 627cdcbc2a2eceb0452078a0c14370f9f1f17a91 upstream.

Writes to a loop device with direct I/O on an overlay file make the
next freeze of the upper filesystem hang for ever.

Every kiocb_start_write() needs a kiocb_end_write(). For a write that
is queued, vfs_iocb_iter_write() leaves the end to the completion, and
backing_aio_rw_complete() only calls kiocb_end_write() when IOCB_WRITE
is set in the flags copied from the submitter. In-kernel submitters
such as loop do not set that flag, so each queued write keeps the
freeze protection of the backing filesystem.

Direct writes to a loop device with direct I/O backed by an overlay
file left fsfreeze of the ext4 upper filesystem, and a later touch
there, blocked in D state. It takes write access to the node of the
loop device, which root has by default, to attach the file and to write.

The fix used here is to mark a write in struct backing_aio and to call
kiocb_end_write() on completion of every marked write.

Reproduced under qemu without KVM, on v7.3-rc6-21-g602042bf29f6 with
earlier fixes of this series applied, with and without this change,
once each. The kernel was not changed for the run. With this change
fsfreeze finished in about a second. Not run: the nvmet and LIO file
backends, which do not set IOCB_WRITE either, FUSE passthrough, and an
xfs upper filesystem.

Fixes: 2406a307ac7d ("ovl: implement async IO routines")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[amir: use aio->is_write to explicitly mark a write aio]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Link: https://patch.msgid.link/20261029180319.2852090-1-amir73il@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
[ backport: context: no do_backing_file_write_iter(), the write is marked
  in backing_file_write_iter() ]

 fs/backing-file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -83,6 +83,7 @@ struct backing_aio {
 	refcount_t ref;
 	struct kiocb *orig_iocb;
 	/* used for aio completion */
+	bool is_write;
 	void (*end_write)(struct file *, loff_t, ssize_t);
 	struct work_struct work;
 	long res;
@@ -123,7 +124,8 @@ static void backing_aio_rw_complete(struct kiocb *iocb, long res)
 	struct backing_aio *aio = container_of(iocb, struct backing_aio, iocb);
 	struct kiocb *orig_iocb = aio->orig_iocb;
 
-	if (iocb->ki_flags & IOCB_WRITE)
+	/* Pairs with kiocb_start_write() in vfs_iocb_iter_write() */
+	if (aio->is_write)
 		kiocb_end_write(iocb);
 
 	backing_aio_cleanup(aio, res);
@@ -255,6 +257,7 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 		if (!aio)
 			goto out;
 
 		aio->orig_iocb = iocb;
+		aio->is_write = true;
 		aio->end_write = ctx->end_write;
 		kiocb_clone(&aio->iocb, iocb, get_file(file));
 		aio->iocb.ki_flags = flags;
-- 
backport

