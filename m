Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA5A569F0C
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653739; cv=none; b=JSlebnmizYX90at9IzbItRW/98eGEa+aEOB0Qj0QczmKMP+fteT4nlVmhSt/eDxCvSS13dAX7IbHv4YqWfcrs4bW1jLGpJkMNAP/FNCJl8toknVdhztT7j8PViZ3jdcnWH3TygrA8V3MAoVDCwa/enZ46mXfQ3fwvl4rhz+kt+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653739; c=relaxed/simple;
	bh=p9cd7vriGXFbA5UKZhGjnU38OmiyU0F1OgDNF1DM/3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opGTJlmGe2BVqBbxiONq4kQCgADeD0b4VwN9JgexqSleikxUblJWPtl10keQj0UuzqseHsjJOOe2ZbnFTczL8/YtJ/j8HmaDSbcj9Jrqe52Vqa6P9LkCcIYMN27Tf3NIZySgbrtkna4TGIJ5ta3J3emZMdOrMk/PBf7rcY8M9mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdtS1LhX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdtS1LhX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9576F1F000FF;
	Thu, 17 Sep 2026 14:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653737;
	bh=cUNIUuzXL9LCXjp4BJFCqQjS6jNzRx7i6nQAM++Hskw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WdtS1LhXHHQZa00g3ZJhfy7QWLdQbWvHXCDgq4WtDQ/LDEivjYsQzxU3qSqfAfo3H
	 DfiYHdwo4Y7+LEx9UJJ+obe5fUnDbCw6ete0qvucLuLWjUH4kd3MCV2UtwGTMzQATc
	 hvXryuSqdVQnseWuRkiI/ojBIo2soLhlXqwv1aW+OSabQ67QjA6IzH6yh+VWKVik9v
	 QInR2KdgLEMH9ejCy7sTJWeNPuSmZ246viPD4yyyU0kwxMa+FRryzHKq8WimbBsBtI
	 y+Zu/ZnjCWN/VcU3wPqPV3i+o3vRpSR5W/QKABWiXN0zsxfEgroXkz0Qi4AhALemp5
	 67yBA21UMhvIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjoern Doebel <doebel@amazon.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: fix heap overflow in DACL owner/group rewrite
Date: Thu, 17 Sep 2026 10:02:15 -0400
Message-ID: <20260917140215.506730-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091606-uncoiled-disjoin-4b0d@gregkh>
References: <2026091606-uncoiled-disjoin-4b0d@gregkh>
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
 fs/smb/client/cifsacl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 3dbc71556cb00..b234d050dd1ce 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1733,11 +1733,13 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
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

