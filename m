Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E41397949
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342220; cv=none; b=cFkwoPiJBqLFUVmaQKx0NVUu5A55Viul6HSUSVVoI6a1YJloXxi3iecHrybZd+TzNJc5xuHr3M6Wl2WmoqJ3OvOnA3/6tTlfdyhTRwo6RjbbUWOmRNStC1gPLTnHkI3wexUyLcrcKYwLAra6KitHvGHAol4CpQCIu+0rfvHgAOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342220; c=relaxed/simple;
	bh=m/ZVzvZYYb+Yp6JDinQx5z3BKBmTrgHECC9+2anINSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o77hDkUoesRXBq5rTrkU3Hzbd+2hU5XEIqoSgFXI7nKcp2TlpKT4FzCaVsv9cA/TDYyhM84E2LCObLn1nTqRdOV3INUsbE1fqCd0VuZn3JC8hxrCnMUvgwuWXBo/18DGz0I1CjIBox8pALlv74gWcTht+2m7hDBfx74kdjQB+xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=eO+YNOEv; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="eO+YNOEv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785342187;
	bh=9xru2j4oR9eg1iERmMhUlvPGV+wRdurZPQ+tZawaUs8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=eO+YNOEveylLqAITTclgBGlMGc8KuzPNk9HYwYVHvMO5rJRCDz3OAyK2dHrspxQsu
	 LUdJ2pukIhxpYuy3sWb1qXlH1NysEhzfwwMc9Csx8sA1B74vskpc9lUR3cI5oduyk+
	 UqyNkQx+nYidsRuOT23szPJ6lfD4MgGXQMshtIkI=
X-QQ-mid: zesmtpgz6t1785342182t4dcbbd9f
X-QQ-Originating-IP: VhFRX8rr0xn7SWXSxP1XunEUW/52YKo/3JyRsYQxNbI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 00:23:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 907281197811098043
EX-QQ-RecipientCnt: 5
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	stfrench@microsoft.com
Subject: [PATCH 7.1.y 2/2] ksmbd: restore DACL size on check_add_overflow() to avoid malformed ACL
Date: Thu, 30 Jul 2026 00:22:54 +0800
Message-Id: <20260729162254.2169992-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260729162254.2169992-1-guanwentao@uniontech.com>
References: <2026072935-handyman-fascism-82fa@gregkh>
 <20260729162254.2169992-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OGbb9vXWxeDDg1kQwZMpQFDW8ZW2phMRk9ACkHSZnHcCg+T19kQF/Jv1
	zyiWw11afLCg5M77zlpsPvkK8QAJS2k7Lub2F12PRkJjZXU4BA96um4IoNsTh1hXqUl1ajy
	gfn6rt86HIpi9gus9s+95M9kcZ5qOtx8kLLVUePiJRnD67lsfwAUwovV1gRlqo/Fgmk2Llk
	CfRyWYclS4kMioQ94u7UTOsL76QG46TcEjEEZeq356Kan1ZfycgBfi5Bch3i5nkekHvvm2G
	uoX8x3+OZ0Dl+68c7W5MkdmEtY76zfy86BmZQk8cq9HUHhHkG5+Pqi8yMwsgC2V+cRZeeq5
	HljQtilsGevxHlNz6OJMt+EVAmp3Rpv/rSwQ8J5OyxXIwGxxCGWXLwnvc03YLhVBjBfybQO
	VlDEDUytFRTISS25P8ltuZBWwPfPcokwOk3GTYZHxYF/CdtOhxa16kfc+/jMzjpKzfmjoSo
	jEHXIfnPlSJb9bU38ZTtOTh7OZivcoa25zYOg7UeiNZYOMFbmbIiFEIqkD5/Qm/sy9Yjq+P
	noQcmGIimmG9Y/BO5WJAl8ZxfCYl6hqROBAwLdvmt2xVs6YpnF3bx3H5/Q8wwg5+DX2s/Sr
	SE07M4I+p3T4uv35z+vlJYUR3oj7gNUpSaKQ6DM+UXvzMDd7+r8WhiksVdtJQciuYNQbIfT
	1mKqJ2KF5vjsDFQpNRq7wJjg3Wu3/XETjZL4BbKCwWAD8dSSkvQPOQjglSc3LXRHX4R7fEs
	+0oHrpNzMIJTgySMfn9wrubolUrSbj0u4embVoPbrdvXJ9uovjr2YkJNo8qj+VgQMEFY0ID
	vpX6OJIV3IS/vyi8uM+NYcDkCltdLITdlWBr/WzTuxJFptnMnUwTCyxJxz3cI+E8BjTtYtj
	2Kj8HGYYhkEKCxjlqj7w0omsS+5G4R7V/Ohy9GpJ64ccMg3BrcrrBhmL25Jrp7W6qXH7LZg
	G/159m/ctYDVtsPTIlo6VetFnB4Llt8c2Yo4dSuAn72th01PpNirXuq9FL5UyJZf3hrg04E
	hrFi4dB3XkFif93anwhoM9ZEwaK3dWLTEToPjQfEgNnfiqEhh2wnBAIc6l/KQDIx5YVsEIc
	h5cK8UCES1+
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

