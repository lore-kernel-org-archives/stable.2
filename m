Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793318963;
	b=MdRxN5LYuR+Xi4xidTzOAfx7UapW8BXZKpX1jIVvgmm3954aoe+JAJUO9Gbcp8iaSfuC
	 BCziViQsH1UW+RiMVaTmhDsNUOzvp9IGTLVvdfgSONvmNVhOOmx9ZuK+/SyoT3V8GTFzM
	 FWUHH6rrLNI1PbyJ00LMQdTasN2ffWUbIoGA39Ftq7WavAVUZkU+rTx01UKgoaUm/an7x
	 wEvyQ7KcMGrbuzb5gGXRDIjBMEBTaxvresPhAFDzXMrFxYkBX+97P/YeH1CQBidM52tHG
	 vu1GKUrJ9xminMXRyW0ZG+Q5u4fXI49g4ntHQsbMV0Biotpi9g11jtOt8wMARRdH4pQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793318963;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=L0Pr5oMx8zJJyFvdY5DiJ4atKKpo2oUOe95HxWQtg0w=;
	b=Xujl7CNWUg8MLLvfx7EXXjhE40JLZRVYxGCihFVCXamNNiJcLM/bGqkP4tTfUMNlWphg
	 8TTkmb9ckbvzbdP61dS1aPFA00r4E2sJDP3zBglBU7a4FPswc/hKlOeQSxlhfZKtkC85/
	 8UryE2uoQHbif9Jj1ZYA4wVjuFkOfDkrBBx6z+36KrovydBBzK53VzHUrczW2umLRF40z
	 8fQ1wjEsVBZ16U7VqOPZYp8P8pGhVFkqfM+LA/4qlNveprrVA/QzPyNCmrcsYToBR3HpN
	 gWzaAo2g5wBbBbrE2c7kI6mXAgpy8beAcbrx80n+ss1iihqFCzTCjw78ewlGnmUjbsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXswa5tp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FA1606A31C;
	Fri, 30 Oct 2026 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXswa5tp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793318961;
	b=talj5Kybg/ktgKB3KrJbEiwHz0e+Fxr2NlRV6/pH7cn7W+pK7ONbx+tjgxqDKqDJCGS+
	 tp6sHf1rRDqMBbvuQj3VWah4IlX+J1/hwK7qurJUrOVmOR8GsUtMVxZrm8BEe7n/qwG17
	 TjTuuTqG0doTESRzQTKzzQc55S0Q0vI6ngCQNAMfiNCFO4w4eWjlG872S5lJTuiyrZ94i
	 WxhPi88YUDnrUKm8NG2sbdhv1kkkrV3KLTA8f4aFA9sXM76CgrqmtRgzl5n0bHkzqcevN
	 U7Tl1jXvRN28iTSjficq34wVlRmNdiCIIoi2niLZ/H0N+csJsfRxSmUrV8vCu3r0d2Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793318961;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=L0Pr5oMx8zJJyFvdY5DiJ4atKKpo2oUOe95HxWQtg0w=;
	b=YGffheWjuzpV924NVVJvtNazgqZTXfkKKMXmeFR7Sl9qSgq2/eT8ZaXq0xKLEv0qjvMV
	 JdHwiHNVD678uoP5ohM5KDcWVGS5qEtYtFfTQcAwYz7s5biIMrQSt49n2XJ0nOk3r7Hbc
	 riRvcOeQlXL7lg9/vuWU4Xc+Q8bwuC3gMpH4rmHQzjyLJj/uMKJABVn6gqvj736FQZDi3
	 QSspUoIpX9csyd+q15ztdf5MOTDMNCKnWIV6tG4jzsQrmC9GGvKvHmxou6HeKe5L+l7XB
	 sWLzpuOVhfvSJcMTXE00YnE8WSpqhCUSQFRdGBG9hqiH39KjY+qakZ7IQZ9gljqNWow==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F014C1F0093A;
	Fri, 30 Oct 2026 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793318961;
	bh=L0Pr5oMx8zJJyFvdY5DiJ4atKKpo2oUOe95HxWQtg0w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OXswa5tpfnC8axtwjMVjNKzawtaIygMp2ICKCpZVho4MlUmWuKplDFja3xT9NqsRK
	 TaCQar2tOkhVvNntUBcSqnuFLDzy6aZAKcjqROLvJw0XSHq7OnfIOzjpcvqYSLwW7I
	 znGYY8njYLDXyyQmYwv9QRvplopwDldSGPY/EoVJTv55OWHu5kkWDtCItWCyCX7pNV
	 NFFsRoRST911KTvr08b+nEPjmtZnsPaXAC4cx9JNKQErX5h/uF6JE1yIUmDGbUpQ8T
	 QDYIgxYEuyqKjPFEhZTcfcZJUzGcHmaOrZ+OZzKaoqfql1t6uqqkzmJqa+RYJGNgnT
	 D/pw4we8gmXYw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 80058409E3;
	Fri, 30 Oct 2026 00:09:20 +0000 (UTC)
From: Kamil Chojnowski via B4 Relay <devnull+contact.diath.net@kernel.org>
Date: Fri, 30 Oct 2026 01:08:11 +0100
Subject: [PATCH 2/6] fs/ntfs3: keep page cache data when converting
 resident $DATA
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261030-ntfs3-resident-fixes-v1-2-7b6c857d4330@diath.net>
References: <20261030-ntfs3-resident-fixes-v1-0-7b6c857d4330@diath.net>
In-Reply-To: <20261030-ntfs3-resident-fixes-v1-0-7b6c857d4330@diath.net>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Kamil Chojnowski <contact@diath.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793318890; l=2745;
 i=contact@diath.net; s=20261029; h=from:subject:message-id;
 bh=4pzU7weQvqE5tgYsOch3aacSWcR74oJYDAyNsY4srgw=;
 b=YfPvOlfp6O/mjMuJkSzHVR4f/Vp5bFcv50PpzY0xypwtgYXE0VzXliofHrCXu+oPmzwPty1Kl
 Cg1nn6xQYKaALCiv9bNy7qYe65dJPkVXxrOdXUNOF5zL6ZqZn8228Pw
X-Developer-Key: i=contact@diath.net; a=ed25519;
 pk=G15RQXroUn6f8ud+bOEqlqpPdpLoCB3L3G9XVUf+YaA=
X-Endpoint-Received: by B4 Relay for contact@diath.net/20261029 with
 auth_id=1360
X-Original-From: Kamil Chojnowski <contact@diath.net>
Reply-To: contact@diath.net
Content-Transfer-Encoding: 7bit

From: Kamil Chojnowski <contact@diath.net>

attr_make_nonresident() fills folio 0 from the resident copy of $DATA
and marks it dirty.  If the folio is uptodate, it holds the newest data:
stores through a shared mmap dirty the folio and reach the resident copy
only at writeback.  Overwriting the folio loses them:

  pwrite 300 x 'A'; mmap and overwrite with 'B'; pwrite 2000 x 'C'
  -> the file reads back 'A' x 300 + 'C' x 2000

Fill the folio from the resident copy only when it is not uptodate;
otherwise keep it and zero it past the old size.

This depends on the previous patch, which passes the locked folio 0 to
attr_make_nonresident().

Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Kamil Chojnowski <contact@diath.net>
---
 fs/ntfs3/attrib.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 080edebe529e..b21c913050f7 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -329,27 +329,40 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 			err = ntfs_sb_write_run(sbi, run, 0, data, rsize, 0);
 			if (err)
 				goto out2;
-		} else if (folio) {
-			folio_fill_tail(folio, 0, data, rsize);
-			folio_mark_uptodate(folio);
-			folio_mark_dirty(folio);
 		} else if (!page) {
 			struct address_space *mapping = ni->vfs_inode.i_mapping;
+			struct folio *f = folio;
+
+			if (!f) {
+				WARN_ONCE(1, "ntfs3: r=%llx: folio 0 locked under ni_lock",
+					  (u64)ni->mi.rno);
+				f = __filemap_get_folio(
+					mapping, 0,
+					FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+					mapping_gfp_mask(mapping));
+				if (IS_ERR(f)) {
+					err = PTR_ERR(f);
+					goto out2;
+				}
+			}
 
-			WARN_ONCE(1, "ntfs3: r=%llx: folio 0 locked under ni_lock",
-				  (u64)ni->mi.rno);
-			folio = __filemap_get_folio(
-				mapping, 0, FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
-				mapping_gfp_mask(mapping));
-			if (IS_ERR(folio)) {
-				err = PTR_ERR(folio);
-				goto out2;
+			if (folio_test_uptodate(f)) {
+				/*
+				 * The page cache copy is the newest one: it may
+				 * be dirty through mmap and not yet written back
+				 * to the resident attribute.  Keep it.
+				 */
+				folio_zero_segment(f, rsize, folio_size(f));
+			} else {
+				folio_fill_tail(f, 0, data, rsize);
+				folio_mark_uptodate(f);
+			}
+			folio_mark_dirty(f);
+
+			if (!folio) {
+				folio_unlock(f);
+				folio_put(f);
 			}
-			folio_fill_tail(folio, 0, data, rsize);
-			folio_mark_uptodate(folio);
-			folio_mark_dirty(folio);
-			folio_unlock(folio);
-			folio_put(folio);
 		}
 	}
 

-- 
2.56.0


