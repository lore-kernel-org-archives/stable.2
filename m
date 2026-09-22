Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD6549B5A9
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106908; cv=none; b=csGKDkaqKlV51NpRFoBYnolPo45zmO5RKG9OPQfGS2Y5b7bivijL+yKU8ufBxzPad1fLS7umU9BZ/l4ehgaQ1aYA2ofL3gAktHsWj+K/FEe95H1oUwLIBBv++eYmu/PUKCg4RdUiNBz5yvAYwBoMpmfZpC9vaUOsJtIoKuP4Pto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106908; c=relaxed/simple;
	bh=r0NXGua0iVhsSCyg/y0NynaR5qBc6TtmI608czlHxbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBSCNAmuLXE3blYbx2WL7vZoldYvDOB85iiZeaKBmDW1hl5sCIUzLDMw4uWDxjEGp117f1SSNfQTogp6DIZOjU/Nc6o4rW64CqCjp7+AZwRdElLXOyUhyA/i7s8HNIqk5wXUIHujO7nbotOVa8xWY+M/FMznLOOptJ6JYAuUg3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5GCSEAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5GCSEAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAF91F000FF;
	Tue, 22 Sep 2026 19:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790106904;
	bh=YZaCJBkWUrj7SPQcKkj/sNp7NZaX3IthhtYvYH2Mskc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G5GCSEAg0A/b+TUU9mg8j0YMTL3SMP+WOLF5Z9enw6nrWwWLzgg1p0hF+d9FNcnC1
	 WtdvvWFb00zaZ38yzUSsYliEJHdCONK05p8wn4qS3QCccAtMXna7UYWmbc6PdlnHP8
	 ZF8zV16AB9MKkns7vLQgEGmsM5jp/APpVrhAHZYdtZSCC8HteqGFoglMrbAvcIMFOU
	 rX64anP9nhTg/mJNLDzDOJR7tCHBNWpp60y0xaKhD/ncHKMOPHAcjtNx6mom4mdUvN
	 kl9mx00vt+rJcPWbRFCy3nWDNTYRXk3KOqGrh5/utGAZeyr2OZjVu2G4lPkyjlUduJ
	 u7F2SFG8w8F2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: fix potential OOB read in smb3_enum_snapshots()
Date: Tue, 22 Sep 2026 15:55:01 -0400
Message-ID: <20260922195501.134716-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092245-kick-debug-cfb1@gregkh>
References: <2026092245-kick-debug-cfb1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 4775c3b7a597907e0b97556c7986fda238a377ae ]

If snapshot_array_size is smaller than GMT_TOKEN_SIZE,
smb3_enum_snapshots() sets ret_data_len to
sizeof(struct smb_snapshot_array) without verifying the actual length
of the server's reply.

Because SMB2_ioctl() places no lower bound on the server-supplied
OutputCount and allocates retbuf to exactly that length, a short reply
results in ret_data_len exceeding the size of retbuf. The subsequent
copy_to_user() then reads past the end of retbuf, leaking adjacent slab
memory to userspace.  The subsequent clamp check is ineffective as it
only reduces ret_data_len.

Fix this by rejecting replies shorter than
sizeof(struct smb_snapshot_array) with -EIO. Note that the bound is set
to the 12-byte struct size rather than the 16-byte
MIN_SNAPSHOT_ARRAY_SIZE defined in MS-SMB2 3.3.5.15.1, because 12 bytes
is exactly what copy_to_user() attempts to read.

Fixes: e02789a53d71 ("smb3: enumerating snapshots was leaving part of the data off end")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 3aaa45375d8ba..42b5e5264fb6e 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2271,8 +2271,14 @@ smb3_enum_snapshots(const unsigned int xid, struct cifs_tcon *tcon,
 		 * and retry the ioctl again with larger array size sufficient
 		 * to hold all of the snapshot GMT tokens on the second try.
 		 */
-		if (snapshot_in.snapshot_array_size < GMT_TOKEN_SIZE)
+		if (snapshot_in.snapshot_array_size < GMT_TOKEN_SIZE) {
+			if (ret_data_len < sizeof(struct smb_snapshot_array)) {
+				rc = -EIO;
+				kfree(retbuf);
+				return rc;
+			}
 			ret_data_len = sizeof(struct smb_snapshot_array);
+		}
 
 		/*
 		 * We return struct SRV_SNAPSHOT_ARRAY, followed by
-- 
2.53.0

