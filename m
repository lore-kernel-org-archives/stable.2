Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297003;
	b=BuSuqGcI+p0saTYbqg2MhHFmjwf0DPC+AYXHyZfTtSl8XvPPG9gViV/rRm+TZ9R6vgdQ
	 TxT7iS4F0lNjksiCq//zCKd5gBgEeSahd9hdUjRCTU+NLI54EOeEw38icZ0dEJljPbBIc
	 sWniCVZejxL+Lqo6iNxbL3SfPNZGod9aN3Uv4uDgEYvBLsLBeg1sLcNYgh76jueoWLvzf
	 IuNIx7qsvVh2UxVjDgQ8FQl7Q1GLGX1zdkIhcNtbNHX0pLSrfoNlDUbN3G551o0hxR317
	 S896r/JIgSvGbj45k4QOxhwCezDl71ASEqFbapd2bYx0bKQcHt6JTwuOiw0o9J8rTKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VPSwyQABsxDeIKe15KWcg49fMkA5mZOjf5WHg6hn20w=;
	b=rSMJq+XGfpI691VRJ6JXn65KPbpd9jFZRBMWxmvAgW9Ww7qkZimRr7u1+jZXn+ewGKwl
	 rVpTEtN+CVjTroW3T4gzsiK3pPtdIa1dE03KfEapY3sHLPaY6fslETx7kekLmddYVfBqj
	 owBZiqJN/ja4+59nGbIEkPSu+5lLUTp8PfuIKrS4lRLqWeeZErSejUcmDfOGoUvI5dIXI
	 KXm6fKhIU/1HM/tlF0K9gm3Sc3rpaukTX0a5kJOvIY1o2nZxICkiDcuXTpES7Noz+ckZF
	 yNH0WAM4Q8Nk57Gb4rMP6Ryp98QaKBB9qMJu2E6e2Qb4dXzWGK9Fn7T4Ppq5y0s2HRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZSsrL1ec;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2CA606A322
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF2CA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZSsrL1ec
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c43373ae89aso396829866b.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793297001; x=1793901801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VPSwyQABsxDeIKe15KWcg49fMkA5mZOjf5WHg6hn20w=;
        b=ZSsrL1ecNekN3zaxWylXVh3KMWw3H1DckiwhWZhQsH2Fjxq/KCRzXlEdBL++OKYd72
         /tT9WcgWdzlhXV3VUmMy6OtAgikfoNKRY/W45ycj3ICAf166SZysPvClGAwBH76+my3L
         6h0z8Xr0XyCrBpYuC87CFbto4rYfuv+EkATe7hkSMm4Str6blamnW4iH2xjaoJ7hrjgA
         mgwhp3WnIm5ZEFEiriXois1iPfdcUpHWoY6VXmPKaP2TJbU5uHTNsFxZirU0f+269bgU
         iiKCBnrU7Ie91OvpnHRsU3ZORrqv+p/+CmbLEDrsHmazHn+YOumaD1rnmfAOGw1Ow7Kl
         2BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297001; x=1793901801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VPSwyQABsxDeIKe15KWcg49fMkA5mZOjf5WHg6hn20w=;
        b=v5Y7A7oU6pEtDONF3gw9a7LJIFKrTVbSyXrkHW8ameJP+iyRX4r2q1SFfc45bWFUsV
         nSBdBEq/3SFX0ODqihYfKmRJvfS/ZndeRefwnmGmZd6tq33VHV065MDqVfWX8NhWZJzA
         /6jYJe/Yr81VNifv+9se3BA3k/ZUMgNUdmuVMS/ZhdsPidp8WhH3q8D607lNgoAwfKWu
         AP1kyPKqFqWVEcvO1jwTCrYD3RieCOTz1h8+pVNC64ruLKV63eHU5EdCSHq3jy0EoNq7
         oDVAtN3+Xh7z4KwKw4arPBUqmv1j9dS2WkgEaIrEec6LF2ZZPMkwDqipzgmNEiv/qlUJ
         85Tg==
X-Forwarded-Encrypted: i=1; AKwUvByVmJWj433Us6h3h3BFt0nOS1vB6T3obCcjYLN+My1HVlCNDrLQZD3ClFiu0HE3HkXMr9CGiXk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5NpCUO3AEpSzq/MaCMJgR0tRf/MdoAJ1JVuXLKI/+8Y3Uf115
	7RdViSyVtbndRxVJHNbZD45ntdRCRzcSc6ZxQ3S0Q5MtPr5D2w1ijsdwJyVeoSJR
X-Gm-Gg: AYBFou3sOQH81gIW/ZQLflJeZ5PaqnU1WNINivaMvEuym+1JT6r8SEzUut7aOe3oq7h
	xVRSr8smi6Bh+4DTaneeNuzHu2kEAC9WtaGnNE4aSWyYA2Q2Ue+9SN1GzSfCMO4lHutqpf23bRE
	Tg56q9oe3F0/p0ddQbDAtwf7u/q4VCiTDN4uVTliSzMlQnWb+17ioAD9Gr8yVA/lNvTjUz/H5eM
	IBFfFdVvw15F7oUiokJ7qmaW3nzAe5Q85hwmlfzGMFD7mBCNVH/3W9lUpls1Nus1mheAgXwL6rM
	LC1qT/R4h387hVlcJj3lEkGwSPyvy4CrcB/Hh3nMrwvMAqVRorvMqxvQhBPP1HgCvoi78KLRXuj
	Cpk48UZ/ihy9pyXnxUSC7hubuwWkqfJd9mLT20VBuph+PBwPym/ofVzeD6124aT5WNdl/gE90vt
	hjsYlujOrlSJJzHvOjZ+n7Y65TqZ7R+0bRKZrOWbN4MbfyAUO1qHWtEdZtSBpsDXYvFGWGfBsqg
	oh5D+R+ghJs0iylTajPr6JQasxcQOX9b3iZEo7PJ77Jxi02xuqKT3Dm9awDSHx9n3UlxR65jejy
	VO5xl38c2jgFvjBoKffoGXdqHXVdk6pmLVKRCa2ktl/Dvi+p4eNFxfdoTnkAZMGNsqOePeIf5YJ
	nhv68VZlhL3hY
X-Received: by 2002:a17:907:d92:b0:c41:26b8:c49c with SMTP id a640c23a62f3a-c49bdf0b4aemr514913166b.10.1793297000979;
        Thu, 29 Oct 2026 11:03:20 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4ca3003e65sm8631466b.21.2026.10.29.11.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:03:20 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] backing-file: always end a queued write
Date: Thu, 29 Oct 2026 19:03:19 +0100
Message-ID: <20261029180319.2852090-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
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
---

Christian,

This fixes a nasty little bug.
It is not critical because it cannot be exploited by unpriv, but
innocent priv users could hit it by mistake.

I could carry it via ovl-fixes with your ACK or you could take it with
your other backing file fixes.

Which way do you prefer?

Thanks,
Amir.


 fs/backing-file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index cc101143f9212..ca8654fa1d83b 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -84,6 +84,7 @@ struct backing_aio {
 	refcount_t ref;
 	struct kiocb *orig_iocb;
 	/* used for aio completion */
+	bool is_write;
 	void (*end_write)(struct kiocb *iocb, ssize_t);
 	struct work_struct work;
 	long res;
@@ -124,7 +125,8 @@ static void backing_aio_rw_complete(struct kiocb *iocb, long res)
 	struct backing_aio *aio = container_of(iocb, struct backing_aio, iocb);
 	struct kiocb *orig_iocb = aio->orig_iocb;
 
-	if (iocb->ki_flags & IOCB_WRITE)
+	/* Pairs with kiocb_start_write() in vfs_iocb_iter_write() */
+	if (aio->is_write)
 		kiocb_end_write(iocb);
 
 	backing_aio_cleanup(aio, res);
@@ -239,6 +241,7 @@ static int do_backing_file_write_iter(struct file *file, struct iov_iter *iter,
 		return -ENOMEM;
 
 	aio->orig_iocb = iocb;
+	aio->is_write = true;
 	aio->end_write = end_write;
 	kiocb_clone(&aio->iocb, iocb, get_file(file));
 	aio->iocb.ki_flags = flags;
-- 
2.55.0

