Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907753;
	b=1+kl4y86eSzVocwoZhlQWeeUiRnLNGf7a28XB0nCMNHDh9iA3WX+XuBzjGJL7/ZAZjxE
	 x/Ubo2nVFVHEk2tF60FK/8grPueUX59lQdNqKoHUoIuiPuEXtSYEmaEV5lsPWamC4fXDE
	 S6FJO0AJU7L58PjYiYNTBUt6kA2r3fsFHmEQBOJ/3MT/5pUiPs5EI5WNxOYUrT4z3lkna
	 dt+WnWRtw2KkXevA283FfU3WXmDmNxJVNtRkfp1RM836aciYp/BdgCMSGoFOSazotYD0b
	 YQbGWnjwrWW4Y3+g51DBnQjs1U8D2+JLLuy1b6735PdfYWcUm2Xs/mkTzXCLm64iFUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907753;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ACgpJl1wl/GvguWP4efDlRKwUACVNViIxZ0qwarMfdY=;
	b=fT+rMszq4AsXpI0W99OuVZG55MnNSXWLTdT/JOt9Tz8lX0R0+SnGkxjiIDlZ/c4geZt6
	 bYUje+P9pNKtgzPe9oZwJQ5AmmQK4U2Z8l4ru+sSTbGWDnwj9uQIARDLiG+FkKXMbh7h9
	 i8Mi9OYztpaWsKttVt75ngZL4ij1Fho3h+f4GD9zc82J7q0NppcBG0TogB/TEdUqIkkkB
	 +iDhRcPGxe7Q0KIYKmlUc3i/UeQLA5OtWMIu/JKWWyMMtlLO0nboET304RpXlJIYAsDLE
	 Q/w7pahvF6uWXrg1uZ7KiqhhyqvA7ZY7jou7TsHnv9ico7pHnjdmybHhlQwCI+U3GAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfW6H5na;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A370E607854F
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfW6H5na
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE801F0089F;
	Thu,  5 Nov 2026 19:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907753;
	bh=ACgpJl1wl/GvguWP4efDlRKwUACVNViIxZ0qwarMfdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VfW6H5nas+ESD9KWbUHmu7vSYNc5+hpuUqeINrn3BZu7vELhsxiu/JlYbwoG004I2
	 8aI2jZerOSteS20u9I62oUq2AKSHw4hiEv5izeqEhHaVuVZQy5oWHT3e7z2u+vONfi
	 0SUsvblby0pMPGbxr914K/RwDObzfGlLq3K7TiVcSbiMit7u5Kfk5RWugd9765an4K
	 NmMZCcKWLBZSrzCblzJU6e+nMbFvuJckgA7v7NYILyqZrzizjxR2h52C0RGkAb38a0
	 0CQumNVbUbms2KQ4Oo1tdZ3aYiYy3FmNT0GXbLkP6tpTuskoYSyQ5W3V/qZ0Uy0Vwp
	 aM9E+lulZmuIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dominik Maier <dmnk@google.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: fix slab-out-of-bounds write in id_mode_to_cifs_acl()
Date: Thu,  5 Nov 2026 14:42:31 -0500
Message-ID: <20261105193921.2635422-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110441-marital-prelaunch-5744@gregkh>
References: <2026110441-marital-prelaunch-5744@gregkh>
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
[ sashal: Adapted the allocation calculation to cifs types and the existing nsecdesclen initialization in code lacking the POSIX branch. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsacl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index 3baafbc12f1a1..defd9493ed396 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -1725,6 +1725,8 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
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

