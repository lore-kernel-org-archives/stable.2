Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9149246C823
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351718; cv=none; b=Uu3+0ClHp3pgbAkxgJwfwjiXhkjndc+5gPWyw/uXQ1UHTurfzt1dSE16jRAPOV3slx3V3VOiPR60gVQkTNLyuoBvbC4GM6jm6R49A+2005T8pkWeqH5WF28sch/vBicGDlYd1QLUHnt8fTruqDEzesXzZQmf0+WZtVrxwt4StWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351718; c=relaxed/simple;
	bh=m/ZVzvZYYb+Yp6JDinQx5z3BKBmTrgHECC9+2anINSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNW2xNglDTjLfKrpQnU4UelZ5ZzAK8EZ+8Zj+gMNjhft/EYgO2Esq8PRVKuTm9sXnDA33OYA8mlAawNUMzWah8H65Uhaj+nvQoJ6yjPSMk4dMU/Zyaw+08c8j9H4paWO5tcFkoEdojqXPTUWMN6NJ/8O8tPojrQJpxNSZ1o/KJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=dmKS2KUp; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="dmKS2KUp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785351693;
	bh=9xru2j4oR9eg1iERmMhUlvPGV+wRdurZPQ+tZawaUs8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=dmKS2KUp68OR1aWqnqzxfL8clW7H+TrR/18Gpda2jLjnfTk1teYltXgVSXKg5TTzA
	 1JsNGrPybMp4MzUJ0ZwoRj3Km+dP3nqN1hvClo5fIiO3OyPYnDJ8hj5FaBphNNOGfm
	 6RLlEs8WP7nlzNN3SYDByUEEAHqXo7G2Oj9DbbmA=
X-QQ-mid: zesmtpgz8t1785351688t651c2c58
X-QQ-Originating-IP: bnhaALlaIJuccbgdNw0MtNmTgbZe7sN+rMMp8xCTm1c=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 03:01:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9863531088391076654
EX-QQ-RecipientCnt: 5
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	stfrench@microsoft.com
Subject: [PATCH 6.6.y && 6.12.y && 6.18.y && 7.1.y v3 2/4] ksmbd: restore DACL size on check_add_overflow() to avoid malformed ACL
Date: Thu, 30 Jul 2026 03:00:24 +0800
Message-Id: <20260729190023.46584-3-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026072936-equipment-calculate-e753@gregkh>
References: <2026072936-equipment-calculate-e753@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OSfhd6THPdBeW2d/TBXN1e9ulKEculLCgEdf85eSHR4YpbkWarxz4abN
	Rv+tTNyq6/ix0CAj/OzUJRcFPE3h6IV71D0WAs7B+CrXIO1BTi58IrzO39lJGUyJQSB6h2I
	iPnChWwFSnQs/VjiTzLju+bU5Ez3OmP3epYSDDKEdca3wnEbIwKCgDL1YVfcm3ZVFM2pkmS
	nJ3Er5Z1YF6STfWOg10igpT5Uab6iAPrzUDmFK7NtS3afhha6M6PTk98AqWdBpyjZsfUICN
	+jE4OpkEoBw1xmNU3oH8hPB+JuicNdu0K+SUqutQlF28YGn+17kvy9XAwFpktBQhdhk4Kky
	U3+DeLJCbccnZep+dnxzMHqUVh4HGEXdrTuLdjmKd/L0PiEQEyiUWZ7YWf1fioUTPRT6pNa
	XNLGPts6eANyxZ3odn2NAFuTVDGi4VTrZjAZGoIGv6uGPjxjLZROrNcPFQWoG/dTGH8BkJ2
	T0ytDw8HEVLhpO6HU3B1qEKhkulCCMmh0J33LibAWNyU2hDZDGLXbt3UDu11WsrldwPnMP4
	wZJPi7oQc/KC4zwcXMjgoT9zAtXyIZcFxNNNMSCP3ko55rWNsqnwwkDPgOt/ueqMx6lwJCz
	Q82ejHlQrFrqnWDciDG0YgwlzVWgSXUkWmo0BlRhd598VI4o/E+PQmSG5TlV8c0SGovQVsC
	qguRfba2JzG44z/TA+Nglhe3gkDjThSan3ZcWkFHeO+lJpVXlqO70LM6PVVU9DrmXjKcQft
	GvjgAtW5q09W+70uflLEn8Ld/TZp6RChA4KslXa7k4wFO5RVvdug+aPMxx98/WWMk20YDaj
	h9ia4UNeMo2zTf0zzSSvJkmxLF1mACTo25cIWu3DwOrQDiPh/cBz+uFZNnHG0H1gQXBnvNK
	WFszUv2tcCp9pDqAJX0UE1oMpV+cn1bdcTwzRANy1FeWQx6Qw7UZ+bHYtDhnxAs7ZAtN/eV
	SOhSmnmt8ulZtHqQ9SXKOTswfRxJ8M8mQedxImVYP1P/19z1idOr6Mhxqz4vAMuJOL6TyLM
	NWEbpAu9b0SwKUHSyNHusIRRejb7LgPvXXqay/CG4Zye8LMn2ZvFvLlme9GPhHDh+2CTGJH
	Egge2rLwNRgqQ/Xtz7q1lcMw/aK6C6TTeCNmIBBGIVIcwwQuIHNKxaeLJuH9yhZQItKGA5l
	SgyVu3ba6OTLKhECfP1XTKrBTKBFTU4XeEo+vxMc9g6wju4=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

check_add_overflow() unconditionally writes the truncated sum into *d
even on overflow, per its contract in include/linux/overflow.h.
The four check_add_overflow() guards in set_posix_acl_entries_dacl()
and set_ntacl_dacl() break out of the ACE-building loops on overflow,
but the truncated *size is then consumed downstream at the end of
set_ntacl_dacl():

    pndacl->size = cpu_to_le16(le16_to_cpu(pndacl->size) + size);

This produces an on-wire NT ACL whose pndacl->size under-reports the
bytes actually written by the preceding fill_ace_for_sid()/memcpy()
calls, yielding a malformed ACL that can trigger out-of-bounds reads
when re-parsed by clients or ksmbd itself.

Restore *size to its pre-addition value on each overflow branch (via
`*size -= ace_sz` / `size -= nt_ace_size`) so that after the break,
*size once again holds the cumulative size of the successfully-written
ACEs. The committed ACL is then truncated-but-self-consistent rather
than malformed.

The ksmbd DACL builders are the only check_add_overflow() sites found
where an overflow path breaks out of a loop and the destination value
is consumed afterward. The other nearby break-style cases either
return -EINVAL on overflow (transport_ipc.c) or break without
consuming the overflowed destination value afterward (buildid.c).

Fixes: 299f962c0b02 ("ksmbd: use check_add_overflow() to prevent u16 DACL size overflow")
Assisted-by: atomcode:glm-5.2
Assisted-by: Codex:gpt-5.5
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smbacl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 9c59c8f73b667..5621c50a80571 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -649,6 +649,7 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, flags,
 				pace->e_perm, 0777);
 		if (check_add_overflow(*size, ace_sz, size)) {
+			*size -= ace_sz;
 			kfree(sid);
 			break;
 		}
@@ -663,6 +664,7 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 			ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED,
 					0x03, pace->e_perm, 0777);
 			if (check_add_overflow(*size, ace_sz, size)) {
+				*size -= ace_sz;
 				kfree(sid);
 				break;
 			}
@@ -708,6 +710,7 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, 0x0b,
 				pace->e_perm, 0777);
 		if (check_add_overflow(*size, ace_sz, size)) {
+			*size -= ace_sz;
 			kfree(sid);
 			break;
 		}
@@ -750,8 +753,10 @@ static void set_ntacl_dacl(struct mnt_idmap *idmap,
 				goto next_ace;
 
 			memcpy((char *)pndace + size, ntace, nt_ace_size);
-			if (check_add_overflow(size, nt_ace_size, &size))
+			if (check_add_overflow(size, nt_ace_size, &size)) {
+				size -= nt_ace_size;
 				break;
+			}
 			num_aces++;
 
 next_ace:
-- 
2.30.2

