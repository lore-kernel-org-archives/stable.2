Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676592;
	b=trrXQhsvysQyiOcBfXi0kOyjymeDOuUxBZaHGmOhamMFZUehDhr5mHUalRSyEYpWcfwh
	 TlCMgVZ7A6vDmgNabeI/lmrh2JH1axhfzCOr9qIYVblAECR82R1PRuw/N/U5VnXtqZFow
	 psrjuCPl2GqS8SFRpVYWFwW0TigGsb7Mf3LyasdUcSzOu29xem9CkwlQ5c1OLLmCDS5sA
	 gBUClWxQobZ/W9jBDNnzhexrhwhVlcTGJa+qGiZTmz062q+id1+FgZ2wsr+1xpxwqr/Ju
	 BaCS7Jf7ZCoK7lUle/ocB7I1pB3UjqEVPsDwJp06jOGE7Pd9pXwE9kkmBELofFesosQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676592;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lyYatx+blPLG7bj1C5hxe/xKGFI6pCPhhWJ8rUZSExQ=;
	b=LDUxeJLY8DLnax71p98jWn6ZB9DCe4S4F5J6JT0jrJnGu0i85TCm8UZyvr7vWLYIUpmi
	 RevNACWsYNFo+ZYriG55mV/sMJATSrIFwxWXE/Yc1lxGq3grgVzqjNwl6ZGo804gh4cyy
	 UFO0H8nOpcfD02MAON5AsTSmqH+kWDMxgwumei3r2PIZ7dlzl7jb41WHZSvdP1D8MKTO8
	 Lmgpp1HLgohLeAwqRMP1VWgVDDRo6WY2M+lCPD8jr46nYR67vOMbtC3jhoacx6Ir2wEln
	 YzA6qZThbuVZ0EOyZ33gBfspr2vfPdoT1CtUnu4ZIZzkUzCEXLENffuYQxMc2MCdphQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfKmhXTZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E8260A263A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfKmhXTZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01FF1F000C3;
	Thu, 22 Oct 2026 13:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792676592;
	bh=lyYatx+blPLG7bj1C5hxe/xKGFI6pCPhhWJ8rUZSExQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dfKmhXTZG5LX6I9oefmflhkI0T00DPqxj7bz9qsiNRSOs7PpyP3r0gi+VOLjjco0G
	 +Syx0OUfEzJV39vGalQubGTeUiefw7H89Ed7ZJ5I1it9MK5s4x+EdIo62o/x4hJsu3
	 ENZe/4a9CqOELwY/kiBd/EdfpD/KV5GXK4GzKLyTsy0QeVC5ltP57Vq/7VIyBG1R8Z
	 IWrfu6p4Ds4IWFnVNVRB2N2d2KK0S3cl78xqjBlAVFf1f4W3dyXOYN3e8Ym0QAsdbT
	 pxl1WjmpzV5vzsDSVj1BLJMZuVFR4YmdXEg36kbXyRtsoC1xAMjZg5uP1qccHryEur
	 J2EZemRmtThtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] cifs: add revalidation on FSCTL failure in smb2_duplicate_extents()
Date: Thu, 22 Oct 2026 09:43:09 -0400
Message-ID: <20261022134231.1459788-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022134231.1459788-1-sashal@kernel.org>
References: <2026102114-sincere-numerate-a8df@gregkh>
 <20261022134231.1459788-1-sashal@kernel.org>
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

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 53676a5e28231186c9f56d87b7998b640699bc15 ]

smb2_duplicate_extents() has no handling for
FSCTL_DUPLICATE_EXTENTS_TO_FILE failure: when the FSCTL fails, local
inode metadata may be stale from the pre-extension or from concurrent
remote writes, but is never refreshed.

Force revalidation on FSCTL failure and use i_size_read() for the
pre-extension check.

Fixes: cfc63fc8126a ("smb3: fix cached file size problems in duplicate extents (reflink)")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index c962f22f3655a..600ecf4382fa3 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2296,7 +2296,7 @@ smb2_duplicate_extents(const unsigned int xid,
 			       trgtfile->fid.volatile_fid, tcon->tid,
 			       tcon->ses->Suid, src_off, dest_off, len);
 	inode = d_inode(trgtfile->dentry);
-	if (inode->i_size < dest_off + len) {
+	if (i_size_read(inode) < dest_off + len) {
 		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
 		if (rc)
 			goto duplicate_extents_out;
@@ -2313,7 +2313,10 @@ smb2_duplicate_extents(const unsigned int xid,
 	if (ret_data_len > 0)
 		cifs_dbg(FYI, "Non-zero response length in duplicate extents\n");
 
-	if (rc == 0) {
+	if (rc) {
+		CIFS_I(inode)->time = 0; /* force reval */
+		cifs_invalidate_cache(inode, 0);
+	} else {
 		qrc = SMB2_query_info(xid, tcon, trgtfile->fid.persistent_fid,
 				      trgtfile->fid.volatile_fid, &file_inf);
 		spin_lock(&inode->i_lock);
-- 
2.53.0

