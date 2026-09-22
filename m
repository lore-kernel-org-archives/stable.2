Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B0851AEEB
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112237; cv=none; b=JA+2bSRDdp437L0GK/6tloVgttO2xLxL4CAzkv8PkCkvS9KJ+YvXAjanloe2b43vF8bSUrk9lh68cfMH2Bha0DjMgexCvYZ4sDjHncp9NKq+IyRIPHdsJJyo+ShRsJ73j4ncT0PNif26FkF7tLbJZ7QKPbMf0R14IP0Ho9ZdICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112237; c=relaxed/simple;
	bh=57w7mQQDm/wg3haQg6FEa/zaTkQRaLwX0ZsESQx/aa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3e5RNKWbkmzEiZteWhWAx1QcZ0OaH1I/1j7+X1xDSnz7fcxUDQAstZ3Uc+XaJRHHJO0rp6UpcbUOYSNI9JW4eXOJnsHDbbwOVQ7YmNC6HAl/aIuSK7DjnRErKz05qPNSV4tFNalowbnbUZcIHxCkaIAqxfd7RjeX12PLAhbASQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyLDGn+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyLDGn+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A2D1F0089E;
	Tue, 22 Sep 2026 21:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790112215;
	bh=yIAhq2KWbbzDHaqM4P4IXYQ6B8vdrEFQ4N211srpF0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VyLDGn+La2qkPcYzJsqtO4Lkuw53HHkXqoV23dUzCw01cRKqSfcalTMSXrmmsYTof
	 uOrWIlBPiYqiZsxIFQG0MQLwKhlktFnEtKBMwypPWkU8WmmXMLYB2jKCICdfL6z3EE
	 wfTEl2WBmvG+wTOsHxlSI4GtyPS++ug/cZVKRf4BivRriXPBs+o3sZ/dU0aEpZT3PC
	 4M7VivO3XPiNQjuFCpGnca+RDuVvsmEblOeBVf0fq5M2B57uW6rRqOb0Trly2+yZcM
	 G67G8Vd8lPfQPerhQK4q9s+9TzLiSyPirw+7ICwbHVdVC4ait6xApZteij7yGs6ROU
	 FDaL2r9rKC5qA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: fix potential OOB read in smb3_enum_snapshots()
Date: Tue, 22 Sep 2026 17:23:32 -0400
Message-ID: <20260922212333.754129-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092246-amplifier-zookeeper-348a@gregkh>
References: <2026092246-amplifier-zookeeper-348a@gregkh>
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
index 51f8ea0c89065..8fb3db801d3ab 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2165,8 +2165,14 @@ smb3_enum_snapshots(const unsigned int xid, struct cifs_tcon *tcon,
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

