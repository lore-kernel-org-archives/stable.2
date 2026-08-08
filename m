Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1051E3246E8
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786209275; cv=none; b=D1HmQavkpsNtiBpBQQXwCHIMw/RU8OUdJ9OfGIkIBZ0S5ZdibBnXSyKApi+Rh4C+fhq2m/FBc8yEW1XzC2DVHDyvFyIj2JEO2FuBbudGW3fYzVVrdYRf1Y8hX2+xoXXebQnwF+ez4Kf2syG1ZYdk0M00vcA3pYxPsJ62VoloThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786209275; c=relaxed/simple;
	bh=tKKLom30fhzctplID8GH46NaLx+YloT6q1RrHOPycxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpMfQCcUrhXOtzNkIKcWnY+iFJtwOkyH8eQvkt3bZMBw3PoUiJYcUyS72aJ9Dvie+SMh6G7QKzg6M2pDW+JXgTCTDwfpbPw7D276LKy9tZYwUfBFjMpMCHirq+J1WYK4t6a2K/2QHTdigF6ZdRhQAmQAjF/iVUDVUyP1ySVdruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLim2PSO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLim2PSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEA71F000E9;
	Sat,  8 Aug 2026 17:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786209273;
	bh=J7lpXyFjnWUkqqZSkNoht33BN3yo+/sPmjDBK9qwvP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cLim2PSO18xbboAQWdNgWzyduXhK6z951+klMXorxxMSyaozOtepcxR5SCO0wS8m3
	 gHd/k7R1KZhgeekUpFNlA+KzI9Xxs4qNp5XN/VZvxZvHMK8YfohMQ1nsDW1RewgukD
	 2IC13ZHbOLsFWmvNKKMPHFQNmaRgcHigiuNcNmSCYwkjkh4Xjnn7GEVNiSnu9RhkMR
	 giTeV9vhj9a/mqmcL5fJBznDXrLc/3kTMbgbZKsgVEdGRh38QsIE5nryNm6Lfttlcx
	 hrJwKQ8RLk/QDxH7QmIEMuAuzcE/RlfjPnhA8Mr6trT8mn4mjkaAx/h9ayuv5yrK6L
	 X+prxKur6X7GA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ferry Meng <mengferry@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] ksmbd: fix SID memory leak in set_posix_acl_entries_dacl() on overflow
Date: Sat,  8 Aug 2026 13:14:22 -0400
Message-ID: <20260808171424.498621-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072937-broadcast-renewal-0307@gregkh>
References: <2026072937-broadcast-renewal-0307@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ferry Meng <mengferry@linux.alibaba.com>

[ Upstream commit af92ee994cc7f7e83a41c2025f32257a2f82a7ef ]

Commit 299f962c0b02 ("ksmbd: use check_add_overflow() to prevent u16
DACL size overflow") added check_add_overflow() guards that break out
of the ACE-building loops in set_posix_acl_entries_dacl() when the
accumulated DACL size would wrap past 65535.

However, each iteration allocates a struct smb_sid via kmalloc_obj()
at the top of the loop and relies on the kfree(sid) call at the end
of the loop body (the 'pass_same_sid' label in the first loop, and
the explicit kfree at the tail of the second loop) to release it.
The newly introduced 'break' statements bypass those kfree() calls,
leaking the sid buffer every time an overflow is detected.

A malicious or malformed file with enough POSIX ACL entries to trip
the overflow check will leak one or more struct smb_sid allocations
on every request that touches the file's DACL, providing a trivial
kernel memory exhaustion vector.

Free sid before breaking out of the loops to plug the leak.

Fixes: 299f962c0b02 ("ksmbd: use check_add_overflow() to prevent u16 DACL size overflow")
Cc: stable@vger.kernel.org
Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: bbf0a8e93120 ("ksmbd: restore DACL size on check_add_overflow() to avoid malformed ACL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smbacl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 47c6b509cf21d..3a250ddb1a2a9 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -643,8 +643,10 @@ static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
 		ntace = (struct smb_ace *)((char *)pndace + *size);
 		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, flags,
 				pace->e_perm, 0777);
-		if (check_add_overflow(*size, ace_sz, size))
+		if (check_add_overflow(*size, ace_sz, size)) {
+			kfree(sid);
 			break;
+		}
 		(*num_aces)++;
 		if (pace->e_tag == ACL_USER)
 			ntace->access_req |=
@@ -655,8 +657,10 @@ static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
 			ntace = (struct smb_ace *)((char *)pndace + *size);
 			ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED,
 					0x03, pace->e_perm, 0777);
-			if (check_add_overflow(*size, ace_sz, size))
+			if (check_add_overflow(*size, ace_sz, size)) {
+				kfree(sid);
 				break;
+			}
 			(*num_aces)++;
 			if (pace->e_tag == ACL_USER)
 				ntace->access_req |=
@@ -698,8 +702,10 @@ static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
 		ntace = (struct smb_ace *)((char *)pndace + *size);
 		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, 0x0b,
 				pace->e_perm, 0777);
-		if (check_add_overflow(*size, ace_sz, size))
+		if (check_add_overflow(*size, ace_sz, size)) {
+			kfree(sid);
 			break;
+		}
 		(*num_aces)++;
 		if (pace->e_tag == ACL_USER)
 			ntace->access_req |=
-- 
2.53.0

