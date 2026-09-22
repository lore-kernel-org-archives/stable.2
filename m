Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFDC4A0139
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112234; cv=none; b=M0ZJ+SJ1zKl+ilTNUT4SQk4Wx/ZsyXiBeDb+bOLl4NpLZITbeQWWgVMlL1pRqwoQb22NlSaeAsB/RzFixxWUk4D8UsfZngIac2v5B+q8OfqDO7N3tyqlHVZaIZbXuVXSAm5u8NZ36waMMha3XGMMqYKtjXLfW5ebmi+gEt6AJxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112234; c=relaxed/simple;
	bh=22xrgLF7f0OBg9Acx1VAgDINaGo86PU598/6rz5NjhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gu01TeEC6iLUTvY/R3dJEkhutVmUyuhYObKuzYkwe5ednzbt0RbcgXEgC94E8u1toB8KbeU+5tbQLrciCjWGOGygewlfbx5bk+xFph84S76VAh+APjXgUK8xwxj6JqetACebpmsVymnpVW1jv0l8RUzHkTlnr4giZzupD0S4/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXrdwl91; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXrdwl91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950981F00893;
	Tue, 22 Sep 2026 21:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790112218;
	bh=MEyMgcbBWDGTMPTqiX4XnN7aqz3VLvIBkZdFzaGZygI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fXrdwl91vWt3N3ApVSAi53zXZ52bolhPKX8o75rvPLCRNAJdWLsb0POMkQxQ9DXFD
	 kBcWuH/7mtie2r+6hGgz7mLFSKvakIBYRRYQRnKSWtYhX/G/JBlleZyfBZl5sXj/AL
	 xkOn/KskL+OuEJw/3QX61HPeceHt9vR6nUv6wm7aa9HwAeUz6z1DpLziIahl90Pd6U
	 3G4GEWADRc/mGgGeWqm2uwwun6byVAuqEG1INaVFM2bC+oYWqLbvdWuBP0XgWBTxw0
	 QFHeV3ZFYU4TzhWozBDlDPRtEClY+jZHFUhfg/b4it2T8/y6hUohY/e//ojVidfPXb
	 HE5cyO0BP3O1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: fix next_buffer UAF and NextCommand bounds in compound PDUs
Date: Tue, 22 Sep 2026 17:23:36 -0400
Message-ID: <20260922212336.754478-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092209-entryway-vastly-d821@gregkh>
References: <2026092209-entryway-vastly-d821@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 05762c5bc1cfdcac36747994fde2c04387a457f1 ]

Fix several related bounds checking and pointer lifecycle issues in
receive_encrypted_standard()'s handling of compound encrypted frames:

- Clear next_buffer after assigning it to server->bigbuf. A stale
  next_buffer pointer can lead to a use-after-free on subsequent
  error paths.
- Update pdu_length to the decrypted plaintext size (buf_size). Using
  the pre-decryption length allows NextCommand to point into stale
  ciphertext residue.
- Reject next_cmd values smaller than MID_HEADER_SIZE(server).
- Fix an integer overflow in the upper bound check by verifying
  pdu_length - next_cmd < MID_HEADER_SIZE(server), ensuring the
  trailing slice is large enough for a header.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ Replaced unavailable MID_HEADER_SIZE(server) with (HEADER_SIZE(server) - 1). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 3aaa45375d8ba..cdd7fec5faaae 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -5222,6 +5222,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	length = decrypt_raw_data(server, buf, buf_size, NULL, 0, 0, false);
 	if (length)
 		return length;
+	pdu_length = buf_size;
 
 	next_is_large = server->large_buf;
 one_more:
@@ -5234,8 +5235,15 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	}
 
 	if (next_cmd) {
-		if (WARN_ON_ONCE(next_cmd > pdu_length))
+		if (next_cmd < (HEADER_SIZE(server) - 1) ||
+		    next_cmd > pdu_length ||
+		    pdu_length - next_cmd < (HEADER_SIZE(server) - 1)) {
+			unsigned int max_next = pdu_length > (unsigned int)(HEADER_SIZE(server) - 1) ?
+					pdu_length - (unsigned int)(HEADER_SIZE(server) - 1) : 0;
+			cifs_server_dbg(VFS, "invalid NextCommand offset %u out of range [%zu, %u]\n",
+					next_cmd, (HEADER_SIZE(server) - 1), max_next);
 			return -1;
+		}
 		if (next_is_large)
 			next_buffer = (char *)cifs_buf_get();
 		else
@@ -5271,6 +5279,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 			server->bigbuf = buf = next_buffer;
 		else
 			server->smallbuf = buf = next_buffer;
+		next_buffer = NULL;
 		goto one_more;
 	} else if (ret != 0) {
 		/*
-- 
2.53.0

