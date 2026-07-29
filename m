Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ACC3B0584
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349584; cv=none; b=a6MzRAOA/Eq+BgSLgLVKCMmK5xMWRZYFmfPei/19MiR+XVYITB1atnwv5lvnneGfsqLjpE69Jglq77EOFL0cTiCXl60a9W9yZZplG71pCD30oLDrUMz0Z3kingFt9QeEsJOf2cQ5j8EbdSicLC8cm/N+D7cYpxTFriJ/ZQXN1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349584; c=relaxed/simple;
	bh=vfxKFUfm3ozLAj5dw00zeB/Ee0MVjNwLKJuinmZCeSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RdcKwoCsaDmw6OjJlA0OcJfWOUewl2S51XZ+J6d2XDs5gANRgEgd3cqSDVOpQyp9B/wgWMHWV6i3Hl2Bc7vwsNTcD0Cex76INmw8i6qqVqN529k1S96jWsyk7qo5hHgGJ7lQf3qFlztswRUafU1iYAD00IE4NSCbsz89snOWqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=MCalAzQi; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="MCalAzQi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785349545;
	bh=EZy71iGeHobJNPpITmgOiBr3EUURPO4aIAiFtAy348o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=MCalAzQideLq3/edyJ6x1ZW1yij/hrBVeQFZVeAYBXOAxB3Dai0+gV/858xzzmb3W
	 TLVfR2iopLV8bhhaZe9b6Vd+pVZd2kOcndCAbyFz3AqKnNwIjTH+mRfWUML/qy//OR
	 BaiywZydFCDR/0Sj+Jy1fN52npHb7Ww01Nlmpc1k=
X-QQ-mid: zesmtpsz8t1785349540t3722d35b
X-QQ-Originating-IP: AFBuV0+JRee8w24g4OkoX6kf/W38TuG39qJlPTMSivM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 02:25:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8820537891434627252
EX-QQ-RecipientCnt: 5
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	stfrench@microsoft.com
Subject: [PATCH 6.18.y v2 2/3] ksmbd: restore DACL size on check_add_overflow() to avoid malformed ACL
Date: Thu, 30 Jul 2026 02:25:29 +0800
Message-Id: <20260729182530.31304-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260729182530.31304-1-guanwentao@uniontech.com>
References: <2026072936-equipment-calculate-e753@gregkh>
 <20260729182530.31304-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OLPPkukr/NyPt9yJvS0DTLdxuu/Sf55acKxDMRuWyWLzFKQZ0tnYsl7W
	E7Pov+qqlAxlA9aKKMuOSahQxBo8pWtABuT45tJpbl8Jj19EcH38B6rKUxwXYXET2W2vIvR
	u3AsIpzdTT1mpcDoqL4bqt3dLHdwwsDaCqBA5UFg7MrXy2mnvpWOUmWPF6NFIxNDPMBYMpx
	UkacrPEH6zcXEvReCGuA/wgqhmHcd6mKPTfVkizv95J9XHAawNTkiSLF6Nci4A3n1b9r+Y5
	HbqSsgtOxntEeeii9JwOEBcj8j+79MuPyT8uBKX6OCTSRBx8X8u4E788/gMUrNYvDVfanJ9
	Bh/jjg11Og0APIa1lVHphU+XdVCPPPDjIrel/HA1ggfkhADJo8mWgQaJ+UeXeNX/P0bHWPR
	b3sL2Xud1DMIKKJEoju5MQPxaYQx43nN/xSZTKTG3aEUZjxORAU9wxW4Y4pA6Ia7i367WyV
	0lxnCg6+CULh4MdRN3JXm+TVk97dy+FZij9maPHmcF1MOW3f1LBSIPD4waBzfl1rPsFqgtk
	v1J/B7AbWdEvG3UVa8wqxJga4VIYMcJp/1MB9Lk44IuoPN62kKQZZt4Ox/tZ0ByuHiTctbi
	wKfILemhG4PBEmuJ2955HfinO2bD/aBehgBie01zVaYLhyhA07Sp8j0EIJPchZTnFV2ZGFB
	U7FYhZMFRp1GrJ5Csl/JqrA+ewybwBlJNoA190dVyAChCoJZh3bREmKon5VHP4stqmo/lDd
	NJK8+EkfmlqSYvgimpXMLxytS4Jefg0GhmHCA8dgpiZ+ZSD1KIwqnq1fyIZg/+OjBz499M2
	G6FFVh5mc3cIEZBGdyUv/z0oFDfvkjx37EXIiVwpRPI5vYTsaC6QP5fsUiqsEc+QfKho/Nc
	RtHiXz1jQdB4sTjz60WRp+pHRpF9s+6zN4PKTTsbTQszudcJhfzxEtQOETyPY/+BFihbRft
	CWyduHhGSsTT6nDDRl1ye3DFoHuAXzOM3nGLWAjaJOK16qwA/E6JUBXo6CwePlnj87gFfso
	uONd9ZH+N+KL9jITLsCF8alLGe5/HjOJnZNCb8K7TkIP5tn5E0lxx1hCb3xwXzKeegQZLPs
	74S7gsYpKrVXYGNbEyWhQySr1D6gpbWjeI4HvI57Wm9CwQUfY6KS/BQlXzJH/kcpvPisbsY
	FrKzx5lg+Y51GyXFFrnkfSGR2t0Fi51Lc/rq
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
index 173469d112f10..ca0e4aab6dd87 100644
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

