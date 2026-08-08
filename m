Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D633B6F1
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786209275; cv=none; b=ccbOHGVpU7zgNFWPYn7HUgQCo8uQBkQRbXHUhVw9WuGdUe8VEumj/dJjpzRMsayY/gw+OdPCXXqxybZRPiWL4FfVtdanRTTQE53Zrc/nNCXpJ0rYqwCAkJ3b7LZjQtVobn5b8hxXh9fvOYpGzI+gcvAY10dJ8SdmFKElfKtIj+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786209275; c=relaxed/simple;
	bh=NVxEMPHGFoY4x/rwxyavYgnAb9phpv55LWC2IzTuEFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPSA+30qHGKis1prgM1DkpeGmUCT5byHfqzv4e4pwHoq4XHqp9NCyiyYcA0msKe5A+8CYGWYCt9BAAXS34wS6fGy73h4FS5hsRsoi0VeGEx+KBguuTfNDQz8d1yvSHr++jfB9nZNR5JoNaTvxEtpVNs74sTaXWOjdFaPjTzJT84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNB7Jb7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNB7Jb7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67AC1F00A3A;
	Sat,  8 Aug 2026 17:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786209274;
	bh=8xWelVZQPE53mNeeJ6dqqoT3p34Zw7aHxDI9oqftdUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WNB7Jb7IPQowF+t/NHY01hVNSAHyU0ewmFEY1DmSVOd+k0DUuT3eY8ugjQng+XydX
	 /BC7sKje4xPkVCCAprbfeaj7lz3A7sOl/ORX3CsbDqy9DXqGoSHrmrlijM5X05IMJn
	 UpWuivumjqufPRYm7xCTzibA19NWtS9Ja4zwE3BK6YifWE390BkluPGrbYYg2KVfdR
	 ELsBnLqKNKD6rZRzdA4IhK6cLwelJmMKsZMTmguJDqA2BIXOC8u5QKIGLPkabbtbI6
	 RkinuTTe9ZmMP2UfM9oKO4nYRYWApMlWk1MLZa/gUPT/zt6xwXPILGUSZd59pffR8N
	 VtvLXNzKxlP0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haofeng Li <lihaofeng@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] ksmbd: validate num_subauth when copying ACE in set_ntacl_dacl
Date: Sat,  8 Aug 2026 13:14:23 -0400
Message-ID: <20260808171424.498621-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808171424.498621-1-sashal@kernel.org>
References: <2026072937-broadcast-renewal-0307@gregkh>
 <20260808171424.498621-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haofeng Li <lihaofeng@kylinos.cn>

[ Upstream commit 47f0b34f6bc98ed85bfdc293e8f3e432ec24958d ]

set_ntacl_dacl() copies each ACE from the attacker-controlled stored
security descriptor verbatim into the response DACL without checking
sid.num_subauth. The ACE bytes (including an unchecked num_subauth)
originate from an authenticated SMB2_SET_INFO(SecInfo=DACL) that is
stored raw via ksmbd_vfs_set_sd_xattr(); parse_dacl() rejects a bad ACE
with `break` rather than an error, so parse_sec_desc() still returns
success and the malformed SD reaches the xattr intact.

On a subsequent SMB2_QUERY_INFO(SecInfo=DACL) for an inode carrying a
POSIX access ACL, build_sec_desc() -> set_ntacl_dacl() ->
set_posix_acl_entries_dacl() walks the copied ACEs and reads

    ntace->sid.sub_auth[ntace->sid.num_subauth - 1]

with num_subauth taken straight from the stored SD. Since sub_auth[]
is fixed at SID_MAX_SUB_AUTHORITIES (15), a crafted num_subauth (e.g.
255) drives an out-of-bounds heap read of ~1 KB with an offset fully
controlled by an authenticated client.

The sibling functions already gate this field:
  parse_dacl()    -- num_subauth == 0 || > SID_MAX_SUB_AUTHORITIES
  parse_sid()     -- num_subauth > SID_MAX_SUB_AUTHORITIES
  smb_copy_sid()  -- min_t(u8, num_subauth, SID_MAX_SUB_AUTHORITIES)
set_ntacl_dacl() is the lone inconsistent path that omits the check.

Add the same num_subauth validation in set_ntacl_dacl() before copying
the ACE, matching the gate already enforced by parse_dacl().

Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: bbf0a8e93120 ("ksmbd: restore DACL size on check_add_overflow() to avoid malformed ACL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smbacl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 3a250ddb1a2a9..45c9b980418e8 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -740,12 +740,18 @@ static void set_ntacl_dacl(struct user_namespace *user_ns,
 			if (nt_ace_size > aces_size)
 				break;
 
+			if (ntace->sid.num_subauth == 0 ||
+			    ntace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES)
+				goto next_ace;
+
 			memcpy((char *)pndace + size, ntace, nt_ace_size);
 			if (check_add_overflow(size, nt_ace_size, &size))
 				break;
+			num_aces++;
+
+next_ace:
 			aces_size -= nt_ace_size;
 			ntace = (struct smb_ace *)((char *)ntace + nt_ace_size);
-			num_aces++;
 		}
 	}
 
-- 
2.53.0

