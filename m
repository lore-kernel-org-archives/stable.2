Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793318962;
	b=zE29Z5q3Ye8jtVeyPcakJFw+8ljYBncjjWkzcQaWS8maxHOnbQxNlnaPRnd4qAJvI+nO
	 6x8ne/Gx1lkNA6r7GTTfvxulVNPleXzzG9MGqkaY3eu+k/nIKCOavxnQguSFA3vBl711I
	 O7YsxDEf5lJgX7Zvi0nfEBwy51LSP0tjAI/lQ9/rJu/JTzu4XmEyuDW4v9EAYJASNufCj
	 aTUDo5/oedPFqlsgv7h89fGaxTxr2dqqIjfkfIb+rL+b0OK1UdFaV3fStZNwpZ+SBGYC8
	 esP5KhCuZ2rJThdFeatOfk/Ih6Rmki4+7W6bs5ybAC85h6ElRrSRQUm7gwnvEfqF2Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793318962;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ECcPVfYhh1YHadNxealesbNjKOWqLn9bWZFXROXuu0s=;
	b=Sr6F1FbZ3IsZF9rxUg1gSyZiHdO9e2yg2HyfyFw7qwjqjfm+EmD+3o3fToTeMLAzQ9VY
	 BpSMwuopdSXOvuQuVToRESBhjfTBS2MnyMtMKKGRBBjm87CrX+/zcP+kMxWrJZuAELub7
	 X5DNsuTcjWZikZYLVb94gJlUNH93Ry56DvzPJie321/8IIVu3payqTLIPE8lLMO8mAoxZ
	 /LEaWobVfoTz53eK2506V9W5uDNj0Ldq+QfI6Le6moBmFG8O8tacz/qZzhfJqIhTnYpYZ
	 z5kIf1Q9A20q3idF2AInE33hG6J6sjprd8YgRSvqJfk+v2ii9flaszk9apaGXNo41GQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQz9ejkT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35017606A31D;
	Fri, 30 Oct 2026 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQz9ejkT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793318962;
	b=jlaDMp9p3yYLcjIewvvq1Ez5gPTPpMk5YPXQAfedQAgFJj5QYni7e/+QxonZC5OWHvty
	 M278N1nKrL8wbkA6vTx3m4HKGhmfl6cMb+uu9GXIGNONecFPPqoYp7W6jL78xe0Pwj9wo
	 bypm8QyobqepsA+vZjHofwF1LDqlJkN+vqIeNDTIlXo4WhlU0KlHNxtvA1XJgLz0QVo4b
	 s4j1zMMLND1sKnwtMK3nk0eU3sf2PCc70xIL2Ba0ybR/lhHZQJBL4NLKe+l4wYarps3/X
	 OGZuXUDx0t7kUGISzJODv4SzCwqr71yLcKfj6gYyVVBEJl3ARcWrcwu9wIJ72LIKCHg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793318962;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ECcPVfYhh1YHadNxealesbNjKOWqLn9bWZFXROXuu0s=;
	b=HjrY9spzrstRJjTJ0dZ74NHhlrCHeeWsCXDQive1jU65/i6J68QbUuFuE0aJ2NsZ9TrQ
	 R9QC+kvmAlhW8N6nloKOEaMDTpLHlUCqmaAeIPEarFZZg+iYXMaO5e2Uqfvyu+sZXM6yE
	 hvtBkuN4fKthLtJv5xKJEcp/xCOpEREITnueDLLWTOb3jmbyeelaGLhHOozgKH42yQCcf
	 QW7JFDurm+cRUgjqiVH+UhsSsThfgG/300wdpyvZiLphh269uIiKjGbZ1xrAMDZPhcIQp
	 /uuPZAnCKEnefGO7elGR2wmhWHbLdz6uYtB43aDnY2Q30Tq55nSKlcq2fvKOvV/2ZOw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 11A581F00A15;
	Fri, 30 Oct 2026 00:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793318962;
	bh=ECcPVfYhh1YHadNxealesbNjKOWqLn9bWZFXROXuu0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=oQz9ejkTuwI3OQwpc4BhMCyzogfK8Ub2mITkt8Fpiyfe+GtsJ4X8Gr2BAII/Psccd
	 M5oPPmS8kpJZ8/I619G6SfB5aRlvs681D3o8n4q+1pMLKaGaf8CZZ2ho0EOq81ZDV3
	 aAW3QLF3cEYJjeJTImGQU/4opTbC/SA2oWwNWxYDtB/ycut/tO/aoxGau+97TnY7Tu
	 6ozT8y0SJVevwyONRPNCl/o9g0o5CjMfZlAXNkzde3FPSs4wk2ImZReRDNX2+evjfB
	 7NQv+/+Q+elSMVKX8lNInHorLsq6MuytkTNGqDQPX/a94k0L6zDynD8DvgNgGUAzmg
	 iKkGP00V2J1FA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 956BB409EC;
	Fri, 30 Oct 2026 00:09:20 +0000 (UTC)
From: Kamil Chojnowski via B4 Relay <devnull+contact.diath.net@kernel.org>
Date: Fri, 30 Oct 2026 01:08:13 +0100
Subject: [PATCH 4/6] fs/ntfs3: write back folios that raced with $DATA
 conversion
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
Message-Id: <20261030-ntfs3-resident-fixes-v1-4-7b6c857d4330@diath.net>
References: <20261030-ntfs3-resident-fixes-v1-0-7b6c857d4330@diath.net>
In-Reply-To: <20261030-ntfs3-resident-fixes-v1-0-7b6c857d4330@diath.net>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Kamil Chojnowski <contact@diath.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793318890; l=2603;
 i=contact@diath.net; s=20261029; h=from:subject:message-id;
 bh=W79ey7LkLwclwvNyOK0icIx8SUUOsitBLSIs+VaaqG8=;
 b=aKVF+mCyioHX2ewIERO3mKOPALX8atEHrAl3qyFI4dNGgjCFgPGm/yDvhvO85aeKeUcRHb6+U
 6FFRCKHC3AtBKkdNVutto55fdL5c4BxwxRJCD00ua0neI2w0ZKqdbxv
X-Developer-Key: i=contact@diath.net; a=ed25519;
 pk=G15RQXroUn6f8ud+bOEqlqpPdpLoCB3L3G9XVUf+YaA=
X-Endpoint-Received: by B4 Relay for contact@diath.net/20261029 with
 auth_id=1360
X-Original-From: Kamil Chojnowski <contact@diath.net>
Reply-To: contact@diath.net
Content-Transfer-Encoding: 7bit

From: Kamil Chojnowski <contact@diath.net>

ntfs_writepages() takes the resident path when is_resident() is true on
entry, then calls attr_data_write_resident() for each dirty folio.  If
$DATA was moved out of the MFT record in between, it returns the
internal code E_NTFS_NONRESIDENT.  writeback_iter() has already cleared
the folio's dirty bit, so its data is never written.

Commit 2727ac2ba87a ("fs/ntfs3: prevent positive E_NTFS_NONRESIDENT from
reaching writeback error handling") turned the code into -EIO, which
stops the errseq and writeback warnings, but the folio is still dropped
and the writeback reports an I/O error for data that could be written.

Redirty the folio and finish through iomap_writepages(), which writes
it to the clusters the attribute now has.  ntfs_writepage() handled the
same race by falling back to block_write_full_page() until commit
d4428bad14dd ("ntfs3: stop using generic_writepages").

Reproducer: grow small files with fallocate(2) while another thread
reads them, with the first patch of this series applied so that the
deadlock does not hide the race.  Without the -EIO conversion this
warned in lib/errseq.c and mm/page-writeback.c within seconds.

Fixes: d4428bad14dd ("ntfs3: stop using generic_writepages")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Kamil Chojnowski <contact@diath.net>
---
 fs/ntfs3/inode.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 913ebd2a2196..8651b9e4ba06 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1267,6 +1267,7 @@ static int ntfs_writepages(struct address_space *mapping,
 
 	if (is_resident(ni)) {
 		struct folio *folio = NULL;
+		bool converted = false;
 		err = 0;
 
 		while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
@@ -1276,6 +1277,18 @@ static int ntfs_writepages(struct address_space *mapping,
 			err2 = attr_data_write_resident(ni, folio);
 			ni_unlock(ni);
 
+			if (err2 == E_NTFS_NONRESIDENT) {
+				/*
+				 * $DATA was moved out of the MFT record after
+				 * the is_resident() check above.  The folio is
+				 * no longer dirty: redirty it and write it
+				 * through iomap below.
+				 */
+				folio_redirty_for_writepage(wbc, folio);
+				converted = true;
+				err2 = 0;
+			}
+
 			folio_unlock(folio);
 			if (err2) {
 				/*
@@ -1293,7 +1306,8 @@ static int ntfs_writepages(struct address_space *mapping,
 			}
 		}
 
-		return err;
+		if (!converted || err)
+			return err;
 	}
 
 	return iomap_writepages(&wpc);

-- 
2.56.0


