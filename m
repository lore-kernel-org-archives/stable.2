Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049151;
	b=F3Rsxe68hzbAuxB5jn1kAVs54foirdrhpidJ02E1dG3Aws93Qt7Pd4KrMK5++bk1MQhY
	 +s0Kwl5LuazAe4bi0M4jgHFnXRjZLsaaQnMlO6TZMCyEgiHUUOcz9qXHp9LjfsXUbcIim
	 IYCsMYqBNAb6I8Zr9+ui9NuNttclG1+JNeckx95BCmH8mdQyb+WyvdXsR7SuYi1Ewl3w/
	 JlQoZBcAoXpuNDLpKhf/l8StBblgrv7WK8MFIzDjouppJOB1TSGciDjlZ36HdA98w3auu
	 aGzC5pWrawYDGav/CyQYnEiEj6hpbD/dYPsnd+2ja0NAwj1B0YeSxA21SbE/TC+3aWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f3l0zpGiWBDLrkdGS//TuXETPQIE+ln1iP7r/4acX0o=;
	b=uJVdyUctL1i2A+JrcfVPFprMm9vzNZwLRQmpb9vJZ5rFR2EhJWjaiDyIaNVEBxdOIJOA
	 oTYZnFJy4pLNvCFxlqW9UW+01D/ppP4HpqwHXgWkDoaKouOMVis2D9VowNak/jl7cmG9X
	 YmG/gajgFu4WQi9ocX2fxcn4+XwyVUgsOMD+c3mSBgvlh3j9JzVcTOuULphk1/UWtriu8
	 fVMM/zjPZZcUTeiOaLcDLg9imgEBFQqMUTwKRQORlFa6t2h52EzYcRABC2Fu0lo43KQ8Z
	 RQVywsyvLHJpw02Mjhvuc+Zq746O7S48UoijsoKNWuAIIcwvmaI6uprdUFGX6aWAWOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jmoJRG5L;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE60D606D808
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE60D606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jmoJRG5L
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c434376dbebso78237566b.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 02:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794049149; x=1794653949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f3l0zpGiWBDLrkdGS//TuXETPQIE+ln1iP7r/4acX0o=;
        b=jmoJRG5LFPkpneFDc4+nTlERpAkw2Fyx79LANkHmU59Esr0Sy1tds04Tq+dLppDxGz
         94oKJZiMGy71L3Bqbv5rs7n0FN+yvV/HGbD6bBQQ6IvMBvUf6nmUV10ZkIhsjP2Wx+YM
         gyZ1KX7TIX1phuvp5z54OJWwDV7zeVDmMxPwKQQ4WQkVYTeQSSdA7UGAhE+3TrYbXtbh
         9BKDqRcRkct+tABBB1DbwKxAikMQlzq8tzEaNIHnuXCOVBU0BGFG3OANucQV5fAULe6x
         pqMxDWhomIWm/9+YWS6F3scQ0wlwSWTazLHOF6/Fx+/mQnkUinV5ur6KSJf2beTaWSsY
         Vp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794049149; x=1794653949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f3l0zpGiWBDLrkdGS//TuXETPQIE+ln1iP7r/4acX0o=;
        b=KQA+kK0zU1m4JEKQWSuKOTiBZUEz/bJqqJvfoY85H5omm4jN/M73/BWF60I+3+5TCs
         Om4I3F2uwrx6aAnKRZQK53+kpX1HuP/IrmJxy0Vk17vjLvVP5RfSj1XBv3suxc+0SknO
         QuOhoAudM0/t1x8WNJkkupFYu4954ftrk+IHBDSwOcebVq02/2dhxsQcFUui9W0richI
         b2giZ13rjHqYpzPzhjiT24ePTGfMx7TJ3FaEILjmUBq3ZGI2PxBlHHTOyPT/YPRTuolq
         ZiHdpw5tVWLbrSOdvkAS8+jxn/EGPRTwmATJTbK3slPA3zXi5dyiaT/8Uh7xqlDTOw+d
         PDIw==
X-Forwarded-Encrypted: i=1; AL+hErEgDCtaPCk3RMsgzyMrtNRqoNhddgPdv49zm9xeFT/3k+I7kCg2rKbPhPC6pc2RMsK4jl/lpZo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QUuTEn8QQ7VuOoUc1oOnYF+Lrz/TDUEfIXlgTz/1+WKoIQk6o
	hzNcDV47APS9521nb9XtZvLqLrNwHBKnucadJdwSpZWMKte+ODRjpjEm
X-Gm-Gg: AYBFou2yPGYrMG/Oq38VjRNDxCcrlHKQ8Rqardul3Zl42hOZV6VKWnoqxy5OBibRtQK
	9uE7LeWpz8ZroIchmvfQCdSHN21nxLgCZX89U72QomiPiDGEYEYWyqS03vVsb/pP52/vRrwKpuI
	7FrJYvvuTL/ppRqg/aNEvPjvHQQ6AD1s265RypFzv1Cfmb0VO7QY1NvM+3ObojJjyRYLNtcAbDL
	aiUhNB0qdorBZzGOqHQ8qDMg8yBivoyG2BaaRDQiDy8eXlgyC3PTazR7paKeWnhQu83fGgJfMOx
	tRqKrxIhu+iVK4nmJusf8Yexv7enO3d4hZHCrrCiQ8ARKxhONmMnDiV/nNqzolWh3Kt0khYIpvj
	8ajUh8kk2Cd0dwraWJj5RjJS9xYUQ/9wCkbCjOLWgy9M+oSwH5z0gUknhCBJ3vrUbmKhoSK26S8
	rpqCKZeECSFkwJ55yo6Gm3ejOjjPDJx9jm0KOF94EhaFM4fWrZZae68f1HBZBHmFzXDQlZtCxJM
	RWpATcDcdC4g87+yIoRC6udsi57kHZla1W8CAaYh8x3VqID8lFC8ZKYX0UeJ8LHkGQ8oimCyirG
	COrwkLBZqSMckA2iI3e6KWUFaLmy6l2Ry6JTQwdhFCYrTSh0mR/VkTHPx7PrcNYxZWVgXwVlcaJ
	DNLyPpLYik2c=
X-Received: by 2002:a17:907:94c9:b0:c26:1cfd:4244 with SMTP id a640c23a62f3a-c4d525794f8mr109604366b.11.1794049149018;
        Sat, 07 Nov 2026 02:59:09 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d354ac7ddsm144880566b.8.2026.11.07.02.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:59:08 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chris Mason <mason@kernel.org>
Subject: [PATCH 6.6] backing-file: always end a queued write
Date: Sat,  7 Nov 2026 11:59:03 +0100
Message-ID: <20261107105904.3962893-4-amir73il@gmail.com>
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
[backport: no fs/backing-file.c, mark the write in struct ovl_aio_req and
 test it in ovl_aio_cleanup_handler()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -19,6 +19,7 @@ struct ovl_aio_req {
 	struct kiocb iocb;
 	refcount_t ref;
 	struct kiocb *orig_iocb;
+	bool is_write;
 };
 
 static struct kmem_cache *ovl_aio_request_cachep;
@@ -289,7 +290,8 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
 	struct kiocb *iocb = &aio_req->iocb;
 	struct kiocb *orig_iocb = aio_req->orig_iocb;
 
-	if (iocb->ki_flags & IOCB_WRITE) {
+	/* Pairs with kiocb_start_write() in ovl_write_iter() */
+	if (aio_req->is_write) {
 		struct inode *inode = file_inode(orig_iocb->ki_filp);
 
 		kiocb_end_write(iocb);
@@ -413,6 +415,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 			goto out;
 
 		aio_req->orig_iocb = iocb;
+		aio_req->is_write = true;
 		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
 		aio_req->iocb.ki_flags = ifl;
 		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
-- 
backport
