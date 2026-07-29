Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011563A16B8
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348607; cv=none; b=VjfkReEK3dx/W9XhP278KFLs+Lq3pz9KfZYp0MUpahWn5nGQ/7HE/MGsceCE3RjrNQJpfSu07dZlog/0Kg/Meo/j5alowf7/SG2dIWqow8ZWgr5w9KUZSgZxuuyaY0MosAidvIsgUSYxKNuDeFp4k9b9dZzInrUy9eoH6C+2CA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348607; c=relaxed/simple;
	bh=vfxKFUfm3ozLAj5dw00zeB/Ee0MVjNwLKJuinmZCeSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P95tI5Ds+u8iX1/5O0Tk4le5opykCzjW/Y4OfeHqfk53Qe21c5RUq7CPNqA+TQ0YpNch137DS2x4A9IlNhrK8NrjWEHfpMXKOw+w5GvNHOHxq7vIppaKkHexMcH7chCa0i2efbqEv/KGSW6reEgVHBq/W3xJd8XMFN5AyCbDSy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=U4sdLAiH; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="U4sdLAiH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785348571;
	bh=EZy71iGeHobJNPpITmgOiBr3EUURPO4aIAiFtAy348o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=U4sdLAiHW2lA/BfZsdqXMWmpKSd/+nY1UfbN0K9SdWdU1ERPBpjs2uKmM6e1I7/H+
	 +YtPYKL2N29XiqHkWGp4QiRggdVuTjwPdh5zjnKj6D0uIwZ5JDBbuHsyp2r5L6MZt3
	 zrL1QZYMxZaSHOKXNypDR5WSG6cjIP7BggABjpCg=
X-QQ-mid: esmtpgz16t1785348566t8e6eccbd
X-QQ-Originating-IP: FJvWdJWwsuY+lL1q0dwaf0Q6tlQv4U6VWHnZyr0hQVY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 02:09:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5283120931942838104
EX-QQ-RecipientCnt: 5
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	stfrench@microsoft.com
Subject: [PATCH 6.18.y 2/2] ksmbd: restore DACL size on check_add_overflow() to avoid malformed ACL
Date: Thu, 30 Jul 2026 02:09:17 +0800
Message-Id: <20260729180917.17776-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260729180917.17776-1-guanwentao@uniontech.com>
References: <2026072936-equipment-calculate-e753@gregkh>
 <20260729180917.17776-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OE1Jsd0nzp8lpRsLu8aVYsE5v0X9WRn26EOCc2kT42Ah196k6pmw/YDJ
	tZCOsRWr4sdacvbwDmbx6tu92n7NDgD53pT/I6CKmV2bXTyc3XK4AsjKf5CiH3XkOQFUQzA
	4dKVYmds+cJhaQ8XX6AplcSaSUsFU4vQK43WA2TM0FKzjiz5hCk/hF3qr+q5Ex1OVS3UwWy
	JLGM/T4kamavh4DlB03/a64+pJbr+0DEsTUkhfVpnweaDl5uQiey2pDZYuLdRZ/cXT26LrM
	N9RGit3XfgkSIl72rHkFxSaTzh+j2G6qVCOZVu7946SNH33tCG1KYOlLSypAuNT18OF/ZPt
	o9NPObXcFcFYhJH5ywi/YUOD/EYSXUvoN0pap0p4bNFLL0Sa1/1J6dbILSWxc30OWoD2a1i
	cME5OKb7QM8O2WHOXcDmPJXOnPbDx06qGgu9stb1pCseFHd1XTPZcGBz7xJ5lyzCND6xu2K
	DrtCSz3Vym15rXI8UlswXMDRvrLj5fh3/KEaPdaMH9DupxAapHVW5A8DJZ3CdQBpTFzHvDt
	VVaqDsp5inFT65moDM70S4KI/Kin8L6BT+Pgj2DnL4iV/vbdVtmhlaonfHcVM/8cncQSvla
	Io4EsVlUiSx9KY+g0JpZ6PUrCrQFDiwIcciar612RTYOCLgNr2xE96ikGgqDwZm4n5gcKxs
	LUAW24F3Ws/FLvUaifNpXFvvVsMZI+QFPCHJXcAfCHwrWAI5l0+MlXDuofiIud/R4m0LGgl
	jnKCX3PViRNhkKo580cpO3qPh5p4wiVpczR92RHlk/Ezzx7FMtbqMlf5hD9OJ3cFwiebezx
	HV5bUeJF2esJzk2Tr+ILHoE7JR+SChi6mJFeNAmcx4aD1HqxoRTLUOAyO7CXWlIEIRrFG1I
	dFMLuZayIy5/vWjoAOsy3ISLkH2YxKvTnXr4YuJKRlDEXdlawOHxm1T8lNNM6JnBmE08QoH
	Rvl4dyz3RpPf6n3Euop2urnu1Dp6sDhE3SFlC/ZPl+aPCvUvFaLWU7EdlgenWRSzZYzpM/D
	zui2ogxW/cqmMfaN/nMRTnsYo6DSMU+q4ndnZ7vvJ3kxY/YeZ3khuE2ZtKAe12hfl1U0gFP
	IZmnahfUGPHWoSVXPBG3RdA08RrZ6wG99KapVdl4qM9jAzozq2N2qistkhoUdFsnvgI5aNn
	rRBW
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

