Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DBB582B98
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654138; cv=none; b=DGM8FssBaR7EYSkRUT+q2HkS0W9OKGpTgsU0ujnC0dJshxD8oMaps/9iHnht0UX3xA2bbDTdjxXk6NOGvExgf1wwijgcPem7jW8RzDyjPKa9B0YKr2gkRkkqCLymp8mpxP9te7GW5KsNUM6/Xp18J26/CLOPMK4JyBcRoMIqNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654138; c=relaxed/simple;
	bh=3iKNf6gqGztug3DoVKS0TRRVnL6k0EuyVwqQeY79NQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYN3Ecvv0tPxoFUYSKcGeturFCddGe2B5UoQ/B9Bp2HU4KJp7AYzWn/EIUt4Hjk8ZckGpde6srSPyhDEhRuw4gczoSLpgeGbep/PAoGI1nKZ6qTuuc5Qn35PVB/wGumi5JgAhblJ9i1hUdJAHQNKTSO3hF79B2IL/ivAOPV4mXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmYphoe5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmYphoe5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568601F000FF;
	Thu, 17 Sep 2026 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654130;
	bh=aSxQr5T7TYtIkCGpHdqb5W7ws+71Y4gUXDG4gy1T4C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jmYphoe5hlr9t1R6cxglI17+MteihorJmwblKc1lAdypQXYYHR2hDDb2sYLrlP8YK
	 A0Gh36QDprB9gp+1AJ6lOmzKRQ1h+riwxlf4f7vFIJmFLpbTI/WJ+cHuFm2+y77jYZ
	 tQwQHHR+xUdI6v9kSAbMRDs6QJEdBKM7piMwqZd9umq1UxhdTexKlznXL0YbI7LLTY
	 kwAte+wLiCbNWN9BbwJxqtIFrYSiBSXLT/I4HPdd1K77xdQTehfknBRRd9CBe1ibpX
	 oCgCiQlJkYARmftzji8PcVqHxKT0XDFzzu3HwJgZbt0M/uDwsS0cVscY5CHG9zhhEV
	 BUk7jiWOnbidA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjoern Doebel <doebel@amazon.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: fix heap overflow in DACL owner/group rewrite
Date: Thu, 17 Sep 2026 10:08:48 -0400
Message-ID: <20260917140848.514192-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091607-trouble-defuse-0631@gregkh>
References: <2026091607-trouble-defuse-0631@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bjoern Doebel <doebel@amazon.de>

[ Upstream commit 0ee150794c75bcd0be0e24ff3394f433cbae18cc ]

When id_mode_to_cifs_acl rewrites an existing DACL, it allocates a
buffer sized according to the on-disk DACL length reported by
dacl_ptr->size. However, replace_sids_and_copy_aces may rewrite each
ACE with a new owner/group SID obtained from the cifs.idmap upcall.
Those SIDs can have up to SID_MAX_SUB_AUTHORITIES (15) sub-authorities,
making each ACE up to 76 bytes (sizeof(struct smb_ace)).

If the original DACL contains short SIDs (e.g., 1 sub-authority) while
the replacement SIDs are long, the rewritten ACEs overflow the
allocation.

Fix this by always budgeting for worst-case SID expansion: allocate
sizeof(struct smb_acl) plus num_aces * sizeof(struct smb_ace), which
covers the smb_acl header and room for every ACE at maximum SID size.
This replaces the previous split logic that used dacl_ptr->size for
cifsacl mounts but num_aces * sizeof(struct smb_ace) for mode_from_sid
mounts: both paths can trigger the same rewrite and need the same
headroom.

KASAN reports this as:
  BUG: KASAN: slab-out-of-bounds in build_sec_desc+0x1e8a/0x2680 [cifs]
  Write of size 4 at addr ffff8881a5e25374 by task chown/5298
  ...
  The buggy address is located 0 bytes to the right of
   allocated 884-byte region [ffff8881a5e25000, ffff8881a5e25374)

Cc: stable@vger.kernel.org
Fixes: bc3e9dd9d104 ("cifs: Change SIDs in ACEs while transferring file ownership.")
Assisted-by: Kiro:claude-opus-4.6
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Fixes: 5c3564852c58 ("cifs: Minimize the number of cifs_acl memory allocations")
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ changed smb_acl/smb_ace to cifs_acl/cifs_ace and le16_to_cpu() to le32_to_cpu() for the branch’s 32-bit num_aces field. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsacl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index 1b52e0c88877a..c921d6e2dd51b 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -1729,11 +1729,13 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 				cifs_put_tlink(tlink);
 				return rc;
 			}
-			if (mode_from_sid)
-				nsecdesclen +=
-					le32_to_cpu(dacl_ptr->num_aces) * sizeof(struct cifs_ace);
-			else /* cifsacl */
-				nsecdesclen += le16_to_cpu(dacl_ptr->size);
+			/*
+			 * Worst case: every ACE is rewritten with a new SID of
+			 * SID_MAX_SUB_AUTHORITIES sub-auths -> sizeof(cifs_ace) each,
+			 * plus the cifs_acl header replace_sids_and_copy_aces() emits.
+			 */
+			nsecdesclen += sizeof(struct cifs_acl) +
+				le32_to_cpu(dacl_ptr->num_aces) * sizeof(struct cifs_ace);
 		}
 	}
 
-- 
2.53.0

