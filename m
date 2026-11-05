Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904315;
	b=TW9lcw7NtyevJF1SvuGxtVRl/D7OdAL2nkzgrHvtk+zwBYV2836n9i5TgTRP/akmrjVi
	 YQpybbz7syACc3+7oRybBGiB+SAkuFexgQnD4YUI2sCgEOy3+Ba/96PA0W6O/t/htTfjQ
	 pLH7nSVarX5S2YWUfvYfcczmk79i0vbqoufNIzWKa+U5Qadj2UMt72BdcIAj/OR8SqnM3
	 Oi0bOjAJr5YlXONrhTnkJRjKvqGYdUx2kiRmUEMy6CNb+J54P1HtQ6CQlntYhJF7MrNi5
	 wSA1ACafuxXT1Q2Y2V0WSeclRrkNAOg/6rB0+rFhRYobanrYYHKXigcx0dYcuWSOLXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904315;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QGLbZmMRWSIP9b/2uqpBBPlGFhTwwNmlD3iY+rq5lIE=;
	b=sqfI14iPi42GQskZKNkflTem2Opx3x4EGyJb3/zaEsA6gIQsHMbdkisOFlB3yZ/7EjtP
	 dDTMdEfjdm3BEsjudwiLkAYPTD+ZeFeUP/ytjtZhM36FVg+fZgHu5vmj6+xi/die0UGo0
	 De9eOw7TnHqWl6bUutIqR/5KZurTbip1yrSzE42u94hLCdCaGQo8sEljMshskGbVcS21i
	 zbpzzjlaJb9HLgnH8iMXHBSCelNMgWTMJq4Y+a8fW3oxqcwFBL4PMYgnJ/Z4a6JbZYXpK
	 bCMw5Ds4AYjZy4lZS8hSwGusSqSzfU16L5SPs/AFfuNy/Pe3VTVQAsfD8LbOP1L3Y2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLzpg+Sy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3088606D80E
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLzpg+Sy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5D71F000C1;
	Thu,  5 Nov 2026 18:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904314;
	bh=QGLbZmMRWSIP9b/2uqpBBPlGFhTwwNmlD3iY+rq5lIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TLzpg+SyqkMCL6j2Q8OaqHgUxbelN35XiJ3lhUfC3Al7mvgjvZi5cVg6SqYiUCgT5
	 eVdwvlqFfKYiy4aeAVorrOG/HZvX1Jl4wwUHa8sMLTQf9YN2vCDGwfsBAUGp5v719p
	 QxVMvMoJOB7bFKSQPnMAZ2X2rFUp8wpU7FaM5b4gBSqCs+uak/7l2TG5dxKbeDOhHa
	 DeoEsMHavlR6VTUswDBpAoll+Cox3YeYRbTT12eXr1DeW7/HnE5JnI9nenz30clB3k
	 7wdwW5on7iWX4Kw0me86+nMnTUreD6O9FdEnmqpPZVa9ip8G95uJkf0sYaXM9asP9x
	 gLwzreXFhpqIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dominik Maier <dmnk@google.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: fix slab-out-of-bounds write in id_mode_to_cifs_acl()
Date: Thu,  5 Nov 2026 13:45:12 -0500
Message-ID: <20261105184241.2260742-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110440-whiff-untamed-56a4@gregkh>
References: <2026110440-whiff-untamed-56a4@gregkh>
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

From: Dominik Maier <dmnk@google.com>

[ Upstream commit a377a3645c7d0246af0bc4ef24db94bb2670bdde ]

In id_mode_to_cifs_acl(), while the chown branch reserves
sizeof(struct smb_ntsd) + 2 * sizeof(struct smb_sid) (plus
sizeof(struct smb_acl) and the worst-case ACE space after
commit 0ee150794c75 ("smb: client: fix heap overflow in DACL owner/group
rewrite")), the chmod branch only adds 2 * sizeof(struct smb_ace) or
5 * sizeof(struct smb_ace) to secdesclen (or 1 * sizeof(struct smb_ace)
on posix).

However, the chmod branch also invokes build_sec_desc() ->
copy_sec_desc(), which unconditionally writes the Owner SID at
pnntsd + sidsoffset and the Group SID at
pnntsd + sidsoffset + sizeof(struct smb_sid) (2 * 68 = 136 bytes total),
and set_chmod_dacl() always writes a struct smb_acl header (8 bytes)
even when the source descriptor has dacloffset == 0. When a security
descriptor has compact or overlapping Owner/Group SIDs (or
dacloffset == 0), calling chmod() under-allocates pnntsd and writes past
the end of the slab buffer.

Reserve sizeof(struct smb_acl) + 2 * sizeof(struct smb_sid) (plus
sizeof(struct smb_ntsd) on the posix path) in the chmod branch of
id_mode_to_cifs_acl().

Fixes: 7ee0b4c635c0 ("cifs: fix hardcoded default security descriptor length")
Fixes: f5065508897a ("cifs: Retain old ACEs when converting between mode bits and ACL.")
Assisted-by: ARTIST LLM
Signed-off-by: Dominik Maier <dmnk@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: used += with cifs_* structures because nsecdesclen already includes secdesclen ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 7bb35cdbc4d67..4d9481235b0ca 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1750,6 +1750,8 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	/* Potentially, five new ACEs can be added to the ACL for U,G,O mapping */
 	nsecdesclen = secdesclen;
 	if (pnmode && *pnmode != NO_CHANGE_64) { /* chmod */
+		nsecdesclen += sizeof(struct cifs_acl) +
+			2 * sizeof(struct cifs_sid);
 		if (mode_from_sid)
 			nsecdesclen += 2 * sizeof(struct cifs_ace);
 		else /* cifsacl */
-- 
2.53.0

