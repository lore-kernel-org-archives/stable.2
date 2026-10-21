Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.11.79.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792558729;
	b=z4RIps/Ryk7QW765QiBI5To1pdzLKEof/eTWhv982R+OwSSj4vj7uWnfClxn+Qd/C2Jd
	 8Y1BTVL4T+1/PY0ofnMuZJrU2uSJqMgZ20rloZJywq66ubSUJJVh3pDsNRyaPmDI/ARqs
	 Pt3RGGrvxLVYT0/Sg1vgMFIMSgCkWwjLmTOqwnLGn6vHmIpyJGHN1ctL2H1ligV2q9tXh
	 k5V5aWDQhx0OJVfS1WX2TxOqtgzZLhGn0/+0CMx0DIHnjQGuYw8x9MKo//OT2h9IpMGE/
	 45+zos33/rgCQfFfLIJbqpW5Ih/LIlCxGxqyhux8U03pmnnaak0+O7uf5qfMBspkNzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792558729;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:X-Mailer-Info:Subject:
	 From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:
	 Feedback-ID:X-MailerSend-MessageID:In-Reply-To:References:Reply-To:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Abp8x3DSJqqn2+3iXSrmmhIrpq3pCoX57uw/qGsuvA8=;
	b=LaTTKLpeJscYxtX/KsJErDHx+v7tQbnnMHozyunRyYghbNma6mwkn4CYXMzwKnqn2o6N
	 tByFqsjVDdABndpmEGx5jAXLoDIfNxrO/KLiviR9wdtUehaRwxcxKfcNHqllLXzR+bDN0
	 +69lNQNTExk0btaE5CyiZSHYXf9ivBI95mRAajU+D3NJv8xvBOpU+gi1ueHbTEhy8QWz7
	 t/NediUSaODuwHH4NLa110v07JEzLtvwYfW7ReKe6qoRzWL7Yds7A4+UchllYUqDoROrn
	 6L5ZrTRPyCALnXfY+NObiUC7zCW8Emj542aIgUNf00EbWXBDh6tumyDkM8E+F2EizxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hatchling.org;
	spf=pass smtp.mailfrom=mta.hatchling.org;
	dkim=pass header.d=hatchling.org header.i=@hatchling.org header.a=rsa-sha256 header.s=mlsend2 header.b=H+zbEilm;
	dkim=pass header.d=mailersend.net header.i=@mailersend.net header.a=rsa-sha256 header.s=ms1 header.b=BD8dqM91;
	arc=none smtp.remote-ip=212.11.79.128
Received: from mail128.mailersend.net (mail128.mailersend.net [212.11.79.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575E606A327
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 04:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C575E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hatchling.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mta.hatchling.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hatchling.org header.i=@hatchling.org header.a=rsa-sha256 header.s=mlsend2 header.b=H+zbEilm;
	dkim=pass (2048-bit key, unprotected) header.d=mailersend.net header.i=@mailersend.net header.a=rsa-sha256 header.s=ms1 header.b=BD8dqM91
DKIM-Signature: a=rsa-sha256; bh=Abp8x3DSJqqn2+3iXSrmmhIrpq3pCoX57uw/qGsuvA8=;
 c=relaxed/relaxed; d=hatchling.org;
 h=DKIM-Signature:X-Mailer-Info:Subject:From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:Feedback-ID:X-MailerSend-MessageID:In-Reply-To:References:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 s=mlsend2; t=1792558719; v=1;
 b=H+zbEilmxyR3BJI4bnBx5cVTapARpCNWtAF7KMGt+KJFnnxMUXL53VMHEsg3Aj1C671zpxUI
 zaX6dxr7DfbluOAyAEgkPENORKrE39i5wpUl9TNT/E3uIT7jUbfiRukbYGvtXP/Rxq6bcwyxhve
 A6DNk/zfYKfhRDeT8PMUj+hA=
DKIM-Signature: a=rsa-sha256; bh=Abp8x3DSJqqn2+3iXSrmmhIrpq3pCoX57uw/qGsuvA8=;
 c=relaxed/relaxed; d=mailersend.net;
 h=X-Mailer-Info:Subject:From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:Feedback-ID:X-MailerSend-MessageID:In-Reply-To:References:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 s=ms1; t=1792558719; v=1;
 b=BD8dqM91JzFrHOvH29z+BmDu4B5p/elP0BDTypnSO2/409CX1P2YNfN6STZ3Ud4Ju9otekFc
 9ZrAkX3OZ4GeYBMlmtc6vNif6XFusd2T1MHZJoHv7rSj20eqwyLNPdH0EBCrJFhwDRUokcYxyi/
 upfOz3qGsTz7IBKG0AADpWZ7O/JZ0YHctp4gmvAN1WrV2gJObprVyIqYA4fYqtRrecC5VCUd8dd
 5/IV/XjyvDcpegzJRCG56E/V0IbeTpKskRDmBwKrYn6Yv/kXDUY5eqldpTzU/W2dwBC3fnXaMfD
 MAVRtcLp5mkX9AETWXTW9eUDbWhyb0MANrpC81ncCWEEg==
X-Mailer-Info: 10.AZlZWY1xGd.AZlZWY1xGd0MTN5UzN.wc0FmYsVGQ2dWZy5yalJnblxmLvJ3
 Z.gNhRGO0YzNlFWMyImZlVGOmRjZkdzMzYzK0MTN5UzN....
Subject: [PATCH 2/2] fs/ntfs3: don't mark pages uptodate when ni_read_frame() fails
From: Senjin <senjin@hatchling.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Senjin <senjin@hatchling.org>,
 ntfs3@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
Date: 21 Oct 2026 04:58:39 -0000
Received: from 10.8.15.26 by 10.132.0.99 with http; 21 Oct 2026 04:58:39 +0000
Message-ID: <6ad8467f490aa6aa8fec85c9@mailersend.net>
X-MailerSend-RecipientID: 6ad8467f490aa6aa8fec85c9;6ad8467ea12bfee8f4fd7336;r9084zv9678gw63d
Feedback-ID: r9084zv9678gw63d:MailerSend
X-MailerSend-MessageID: 6ad8467f6da68140f232e816
In-Reply-To: <20261021045734.573753-1-senjin@hatchling.org>
References: <20261021045734.573753-1-senjin@hatchling.org>
Reply-To: senjin@hatchling.org
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
Content-Transfer-Encoding: quoted-printable

ni_read_frame() calls SetPageUptodate() on every page of the frame on
exit, including when reading or decompressing the frame failed. The
pages then hold zeroes or partially decompressed data, and that is
served as valid file data until the page cache is dropped.

The error is also lost for the folio that was actually requested:
ni_read_folio_cmpr() returns it from ->read_folio, but
filemap_read_folio() only checks folio_test_uptodate() afterwards and
treats the read as successful. Userspace gets wrong data, read() returns=

no error, and nothing is logged.

Only mark the pages uptodate when the frame was read successfully. On
failure the requested folio is left !uptodate and the read returns an
error; the other pages of the frame are retried on their next access.

With the bug fixed by the previous patch still present, a read of an
affected file now fails with an error after the last good frame, instead=

of silently returning zeroes.

Fixes: f35590ee26f5 ("fs/ntfs3: remove ntfs_bio_pages and use page cache=
 for compressed I/O")
Cc: stable@vger.kernel.org # 6.19+
Signed-off-by: Senjin <senjin@hatchling.org>
---
 fs/ntfs3/frecord.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index bead01a..a8b696d 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2287,7 +2287,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame=
_vbo, struct page **pages,
 	u64 vbo_disk;
 	size_t unc_size =3D 0;
 	u32 frame_size, i, ondisk_size;
-	struct page *pg;
 	struct ATTRIB *attr;
 	CLST frame, clst_data;
=20
@@ -2519,9 +2518,14 @@ out1:
 #endif
 	vunmap(frame_mem);
 out:
-	for (i =3D 0; i < pages_per_frame; i++) {
-		pg =3D pages[i];
-		SetPageUptodate(pg);
+	/*
+	 * Only mark the pages uptodate if the frame was read successfully,
+	 * otherwise zeroed or partially decompressed pages would be served
+	 * from the page cache as valid data.
+	 */
+	if (!err) {
+		for (i =3D 0; i < pages_per_frame; i++)
+			SetPageUptodate(pages[i]);
 	}
=20
 	return err;
--=20
2.56.0
