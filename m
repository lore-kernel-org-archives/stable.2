Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049148;
	b=qIo7VQ1CbRLa4TtX9GZJ+tktEFCwQxAQ9U/NIUITbC7y68iHIuLQTqGgf1noRJMJ5nCQ
	 zI7UqCot9iMnwBi67Q/TYq+birfwneQKjvEiWPKennJD2fMCCdAznX6US+C+ho7eESXDd
	 W9Wf3uKbSkW/4BY94Zaa3VtSdOTkPIM3YOVNflczfLhLZ1ipizRabc+rKuJm2Xm575/xL
	 /fWzL4WoeGjF6M83eNh8XKFOFZ/ljhEPvXrIJSsOblGgIk8p4oft4JBzRSohpKVL+CVQw
	 tUolF/f51kxFT8PcFGXawo3R38qlR7kfZKilWXLhdJVJLNd80gJSN/Cos0z5HZTlHlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uF3NLECGowX2y5BaUJvCNV96peqx+/eZQsYA4HOxfiA=;
	b=VxnZuEqEzXCVDIeyrH0+n/QyEr1pCOMpI819srvCgLfHWtDMQ9zho1mDOdXlGpiDrEei
	 pvJKzHVvlvm9Z343b437rHE8wrzk765WV6lqlwhLFLq4fl7QCBGRqDqDxfROgYJEHM3/Q
	 GnqrPkxwPvrZU0xXWfzw9e0W8B1Iy72RA8UzeXezHE3kiVTKNSDNJ9yjjo+MpVV/sDrgj
	 Wkc7TdiHO7wsBsbuhNMRbBI6JQ4oBRzshBMZFzh6qtg0I64o2Xy+iznmv0vaKLd6HPghX
	 jA4T2h0BN543FhJe9lAP5/hKE2xKszBG5Bde33Mm0n5by/17Pp819QOsP7OA1UM9Usw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AfRugtVJ;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E5606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 130E5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AfRugtVJ
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c434376dbebso78233466b.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 02:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794049146; x=1794653946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uF3NLECGowX2y5BaUJvCNV96peqx+/eZQsYA4HOxfiA=;
        b=AfRugtVJHHWWen0rD4EPsg5cpCcP0AekhrFA9Qt/I/sf0AYhVFxJuJiuAaP9JFZtp0
         9yLwbTGPT4/921m5nXTYLd5LLMuzVqDb+Ws7u8HPuAjJhOuvma0tuCHivKiS2jNdBCbd
         Wz/2t0HI7G5QShGuq54OjEk7kvdwGFSsGqXVnIcoWjEpg3G/J/CtiMvkKoRfVVlLkNx+
         NJkDTTdZYy5W+2znJZcRy8D7Ua0T+MwIHdWnzM2+XXDCiUkOMVtqJJ2Hiyq6NpkpRckn
         gjA0dptNa7A0UY0NPLF4MLzY+Q8D0vk98gXYz3ZTuFiaTAZDmSueug51qA028x3scVF/
         fDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794049146; x=1794653946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uF3NLECGowX2y5BaUJvCNV96peqx+/eZQsYA4HOxfiA=;
        b=JvCSwlg1h1OM+VNqWsQWXSKxRuwnTD0Ms+PB6W3Q4HhvIYJtx/1JmUEzup03RTaYnx
         BkFTyPqkjaiUMs7lewB18KFyAt7d085m9iqhv3XTkVFejgkIZVWr34MTM3DQPY+TSzky
         LEZMtuC/FXFCEeV4zChn3v0YY1a2oDKxKkrABs1QObWp62Za0Qupi8okkZ9vE3HZKWGM
         ++Dua2Lo+sKE0sSlpV+fFSgamJBwDNn+dc8+wEEUmMN400ayogd0U7GSikzApS0InWvT
         kHVd6Q72NmJMcHPU6hZO/KJvos0KwnxICy5vVabaJZh+9Ax+dDkS97wHOR6idhKoZUCb
         xugQ==
X-Forwarded-Encrypted: i=1; AKwUvBzqx6xN04OekrPqbWVodwmp0LOo/OmRim3g8uhqZ+6VZlX+rFB18TjQGqkOzveDaN5yj51nGpQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rCvyc19kwggFuShc3O2rV9Hjs0wffx6IRHMuhf8HLCBPAOiSH
	e77JO2Ldu5pu5mJNkyh6g5VdfJQ9d5YPrwmB/Vh8ObZRv//wbI/hdg//
X-Gm-Gg: AYBFou2VQEmUbouJqpYJ85H59iBhrHJk1IbuG748GeztNrUzovQYgfUi85CEFY80qXX
	l7DkKAnqvEXB83c8XNqEhMnrzSlv88Ah2BBe5OVfylska9/8r3rIiCqCuWtnxujgllOUxd73qRx
	NeVVNeH/HKk2dkEnlVTNxHoM4TFPWRr2kgqWQ/GraJp0rycEw0Sg9mnPS7Z0Wi6pxBPrBAyvMQi
	GCjPed0BwI64Yft+DJg8iuRL7B0slkSKQMPWlFATsrHjZSqrnqklLT1tJmJx/8XONNBnV4nUtP3
	Fgi76bGK9jABvofP4LrYrm/Mczt6fEVv5CtFICnZvOAvpSXDlin5y1hTMx5Cv/ckYv2kUx3/UOp
	whj7aPjEy2Bjh17EiJR4vnvI4kV8T+Vyn1xAoZDt1wh+A1uc+7huZCgeF0iwY0gVmoemZuDqFDX
	Lh2LuX3I9zznCWjIoQT4+ENcZ6DPAGqwXStNLow39M5n1aQnb8lAnjcilXAXa8anuoUazH2QhrT
	Ihssjz4+drTb4uVoH2QPySSo6xgS2Lf+Q1B/Mjz9qVEZwiW9u0yGCQY7zTSlmcEJiC6aheaA/RA
	rb39xIQ6CkOKdBDHG9AOQJrhxRXDOPJuU6Jri5LQT6ihwsDse5j5xnAbv4cSW8MmhRRtEhVU1+0
	+ccrokt4s2csU
X-Received: by 2002:a17:907:1c92:b0:c2e:2275:1168 with SMTP id a640c23a62f3a-c4d527afc43mr109634466b.19.1794049146286;
        Sat, 07 Nov 2026 02:59:06 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ff8a6asm1695097a12.32.2026.11.07.02.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:59:05 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chris Mason <mason@kernel.org>
Subject: [PATCH 6.18] backing-file: always end a queued write
Date: Sat,  7 Nov 2026 11:59:01 +0100
Message-ID: <20261107105904.3962893-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107105904.3962893-1-amir73il@gmail.com>
References: <20261107105904.3962893-1-amir73il@gmail.com>
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
 	void (*end_write)(struct kiocb *iocb, ssize_t);
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

