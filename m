Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65408288BA
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278394; cv=none; b=AQMBt8JKErzRv7X5m7HwX/Bj5INVLJvJe+7eXUAjU+ITK8SgilgY4NCbFhbTln0kpnHQQ+miCEYwEPXYCLJ6XoBAp9C0lzec5i8Upn5zhYZJRAIYu3wJW2JElPCVqjMBnhooAR8HZQHJqH5lNbiYIsUqHM4GnbW/3L2/yN4Ixjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278394; c=relaxed/simple;
	bh=PE8rub0DLKeH7k0oe8Ru1CelA8MsqIbMl+CmZtq/EXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K56nznnLJ/AxkpY19C0CQUn3nOXt5BuqrpBP/QgxBrpQkl2f2ZBrElcOp1ZLJggfUJchJ0RS+4SpZhQmWA4wIux5ACqtr5eAihFtt8DmMWxD8xlNnIjUTm0mPFrtJ43yBVSGM7CgMLLokOBYlyvpAHJYWAU1OCoce7pSLCJGI8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGYbtzRz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGYbtzRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA2D1F000E9;
	Sun,  5 Jul 2026 19:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783278393;
	bh=8kyDptHl87sbVh5YYfW3rA9YgOQIlcECiARsy3Vj+/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bGYbtzRzbYj072una64p8/WXQDluH3lqmT6xVqhHUmg4ENwbtEkzcbtyB6E0yhkmy
	 kjV82NptXMwaC8FhyR9QOA7AetAnafvlGNxiQA6kN1jjs7lNeN27B4Gd2cEgXcza3N
	 elTlmF/6YdV87OyMXUwW6f4szqpE3InrI36/f+LU3IXCNWE0OimJCCT/7YoSMOvzBQ
	 Zz3bCOChaFT6LvMRfinJdJ0NUsAQAG6kDZn3BsFvbr4LcyUUa6fptruqckfNm2Zt7E
	 Q3LluFhckTZowyVwNdoqK6nQg05bq1OerlIfhXVBwtOIJC9F2vAZXlr5/s3Iz06DKT
	 kHvuOaNI554/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hem Parekh <hemparekh1596@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: fix out-of-bounds read in smb_check_perm_dacl()
Date: Sun,  5 Jul 2026 15:06:30 -0400
Message-ID: <20260705190630.1988235-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070254-saddling-prankish-2dc9@gregkh>
References: <2026070254-saddling-prankish-2dc9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hem Parekh <hemparekh1596@gmail.com>

[ Upstream commit 1ef06004ed4bd6d3ed8c840d9d1a376b66d4935b ]

The permission-check ACE walk in smb_check_perm_dacl() validates the ACE
header size and caps sid.num_subauth at SID_MAX_SUB_AUTHORITIES, but it
never checks that ace->size is actually large enough to contain
num_subauth sub-authorities before compare_sids() dereferences them.

CIFS_SID_BASE_SIZE covers the SID header up to but excluding the
sub_auth[] array, and offsetof(struct smb_ace, sid) is the ACE header,
so the existing guards only guarantee the 8-byte SID base, i.e. zero
sub-authorities. compare_sids() then reads ace->sid.sub_auth[i] for
i < min(local_sid->num_subauth, ace->sid.num_subauth). The local
comparison SIDs (sid_everyone, sid_unix_NFS_mode, and the id_to_sid()
result) always have at least one sub-authority, and an attacker controls
the ACE revision and authority bytes (which lie within the in-bounds SID
base), so they can match one of those SIDs and force the sub_auth read.

A crafted ACE with size == 16 and num_subauth >= 1 placed at the tail of
the security descriptor therefore causes a heap out-of-bounds read of up
to SID_MAX_SUB_AUTHORITIES * sizeof(__le32) bytes past the pntsd
allocation. The security descriptor is loaded by ksmbd_vfs_get_sd_xattr()
into a buffer sized exactly to the on-disk data (kzalloc(sd_size) in
ndr_decode_v4_ntacl()), so the read lands past the allocation. The
malformed descriptor can be stored verbatim via SMB2_SET_INFO (the DACL
is not normalised before being written to the security.NTACL xattr) and
the read fires on a subsequent SMB2_CREATE access check, making this
reachable by an authenticated client on a share that uses ACL xattrs.

Add the missing num_subauth-versus-ace_size check, mirroring the
identical guards already present in the sibling parsers parse_dacl() and
smb_inherit_dacl().

Fixes: d07b26f39246 ("ksmbd: require minimum ACE size in smb_check_perm_dacl()")
Cc: stable@vger.kernel.org
Signed-off-by: Hem Parekh <hemparekh1596@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smbacl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 5e21424aa97adc..cf5361b63c7dbc 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1299,7 +1299,9 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			break;
 		aces_size -= ace_size;
 
-		if (ace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES)
+		if (ace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES ||
+		    ace_size < offsetof(struct smb_ace, sid) + CIFS_SID_BASE_SIZE +
+			      sizeof(__le32) * ace->sid.num_subauth)
 			break;
 
 		if (!compare_sids(&sid, &ace->sid) ||
-- 
2.53.0

