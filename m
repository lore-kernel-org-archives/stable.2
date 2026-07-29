Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE14052CB
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342235; cv=none; b=qblVzuJJ3NzIXS0L6kQdi6DKF8dCX8MBNj2RSvZQxbSu3vsFUXNwLaSxm9utYVRxYjkJGzdZpHc/tVMbQ5hHVZqkc/1TCpkwntJZVr+2NPbZ0dJ/zeYUf4LUjF5PYokA8Sy2EoQC+nO/eO+W7d2+F3yWVVvxqPcSz8hVUtNDbNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342235; c=relaxed/simple;
	bh=rH8IvXaLHHE8At0Ybgif9JtIay7VpjKuuqFFRb1P0Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hVmWpMUpzq0je9cKOM4s2zHJ48tf/A8LVnJ4RXvl7E4ov0H74cx489s4PzmbLlLtN3M9zWBCKxW7eRCXKjQIIecSHd7/Qo9tytHtdDrWIPziHXoAl85CbxTY64HUojdvfdE8AFFqrBTwgOrfo+wq4/ADeVaX07dEmlPpn+jJe/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HjFyOWbF; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="HjFyOWbF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785342197;
	bh=nOSu4CKzjyF+VK3K64pFnSQWJD3WQWCUZ/Rehn4yNtI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=HjFyOWbFo6rBiyyYGg4vRB4e681dcY3SXOgLi+XM/1EvpT/FL3ROncilKh6jC4yvx
	 o+vb1L+cul+11RFy80XPeltK60I0xBJnd6ZVeW/EWv4emPoz8JVwlke4NmGjk222aB
	 nX1hPcHx7C1hgY2GImrxKWD9RWWz5HIpULKEM4YI=
X-QQ-mid: zesmtpgz6t1785342178tc54f2ad7
X-QQ-Originating-IP: 2VPv92T2jCwOSVbFV7B2E9FLFPW3eb4U20uwvxfnu8o=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 00:22:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17569455866306087282
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	stfrench@microsoft.com,
	Haofeng Li <lihaofeng@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH 7.1.y 1/2] ksmbd: validate num_subauth when copying ACE in set_ntacl_dacl
Date: Thu, 30 Jul 2026 00:22:53 +0800
Message-Id: <20260729162254.2169992-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026072935-handyman-fascism-82fa@gregkh>
References: <2026072935-handyman-fascism-82fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OKkKo7I1HxIeOMtWw7VTBd7OVDlHQANBQQNefOSsjdOvE02mLFOc8+Sy
	cSYJe8xQ5xu7SF6/ToKMDUYVftv/aqCSYYwXLSLtPZSbcHu3+aKHRWvlnixZZAiwLSv1y6F
	wLl+Jiyx3n0VS+l97Y9q/pGIPyANtLNXILdVG/aihnQf6aLFpap3TeKnJhLbP73lMm3hEhT
	IFXAP/v1MGZttA4ocULl9qkOo7x8ZPtjy6I+6V+hiMcujlhXA/HDRdYzZHmYk2NscXg1AUm
	5Wyt+PaBcFJre3yapbGNZeDVXs/qwct8HDBI7HigwxIrwowitQvAOO6G1OyDMkCKWPK8CyX
	OAUueVPG+M8cPoSKhlWiCIrhe2fLm8vz7Tj76pxB0dmcxJfN1dSDvLhkT5lfXajN4IKZuQK
	FVoGxA+DH/8+CalIiWYc/WBTDO+uAzxLYgkpl6MeNtNC83T7xBap6XCX3d6QPPM12pju2xq
	0QXg1HleZ6ZMZYk1lvkXaUQ1u8neDw3GCOvemOZUv8hyao5lHUwbAzfkwhvdev1ZROZOqcj
	rACQG/60maogssCbK4+zHcj8wROpOwnpdAfSBDzqIj6nm2rXz/LcxhjKWOx3+0ixb9WUiCV
	QkcmQrRAK447O681vFMmTj1xnlyTxHnMab+bxmfmgfZZAJ8zhMKW44O8qd9TJXGV1gCSC9u
	teEP4Cp4CZMMuKnbvnlU/9E16yUQJcqhVCNBWZeGk2dX06xn4wxbavuyIj88Rnpa02+5HTh
	k3CWFq94kPNcjC61zYI/ATjaFsupv/ByZDmuNmLGmO9+EZNcvz6mRp1s/n9+wwbovTiWJcz
	J0gYFP8FZDSCpEQqLZcXMGwX28ENChEW6w8HUKj8MXh373EUWKNIc3lOsUNVJ59RtQxRECr
	fsPgXEDzY5S9pEDLPq1oqsJCaduBKsYSWUPupBhk4OtzsSOFf1c/kT/YsApD1W/RX9FaxN3
	Pwc5ZvYu8Hb79rLvOvmuI/RazwB3GxD9y50Wv5B+zz1zEfVMVR6lo1EqEBXN29yXpoat2AG
	oUKvKx0VqJpY/HwjJEb/UUAslIFNVG1UXgc1VwsPqus152Cfm49aNj2HVp2MU1naS1aqvPy
	GtYbeBslmWy
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

From: Haofeng Li <lihaofeng@kylinos.cn>

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
(cherry picked from commit 47f0b34f6bc98ed85bfdc293e8f3e432ec24958d)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 fs/smb/server/smbacl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index fc9937cedb012..9c59c8f73b667 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -745,12 +745,18 @@ static void set_ntacl_dacl(struct mnt_idmap *idmap,
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
2.30.2

