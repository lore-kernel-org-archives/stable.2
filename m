Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94B53AFCEC
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348616; cv=none; b=gOQ+LTV6vzUMsXUPIAlrKvcZXWqjJmwS6wVZHsqb2/NRCsuqNF4ogEVS+ts6FmNZw708rSIGLPq3oMw3N7FYleMZZFs9PE/7cdNuXB5W5Q6n5wuPymxQ0/q5rBsOVYarsMkabF9Q2Pw32mu/fDIvsUcsotTO+/Uz0l2+UYbFqgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348616; c=relaxed/simple;
	bh=FuhMChURjhJmIapD7fiarsigxON+OKdVf81UpGjqr4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZQPe+jm7Sel4vKH3x7d2uMJJ0WYTYnH6pBxSxgwOGmqE3nWhly06Qiii9/If70/H8GgfWw+iQxPtSpn9YmYf23W9qnDVUcF0uwRZkY11XQ8kmHPHn1n7m0KGbME7CZUsmMBEghJsjHaAIBLBqnlGD1D0O4TcJ9IyM5hZti0Cnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=mSfqjVnT; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="mSfqjVnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785348581;
	bh=rP0N+Ue7SS95afFkjKCtSOEhydB4E8Iz5D3HOBG73bY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=mSfqjVnTliKGNat/vBOeAtzlKzwkb9w97GqmYZOg0cBKuKlXO7JACcaAkT1Anqwjy
	 gYUrHKHpml2wHmqGJLE7U3K0HFOe9OHbH+cHtV/zVZasqfVQF9l0A0E33vwy7KvR+k
	 HtCxBS1RSL1jVWuwQiTkSld002HPK9DdCJcWsD/8=
X-QQ-mid: esmtpgz16t1785348562t1f3811aa
X-QQ-Originating-IP: tyVwSKaNkHmqyQKERKD7Ycz3azXEOvFlOnwXW4bGwlk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 02:09:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8607606712488970247
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	stfrench@microsoft.com,
	Haofeng Li <lihaofeng@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH 6.18.y 1/2] ksmbd: validate num_subauth when copying ACE in set_ntacl_dacl
Date: Thu, 30 Jul 2026 02:09:16 +0800
Message-Id: <20260729180917.17776-1-guanwentao@uniontech.com>
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
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MDn50qcE9aI1Jg9Tfp6wFYrQNEbyt1p3aY6tGxaqZ/8sAhaViIjPGrKp
	PJeQSiJ1JC98NKByWdu5PCsc3ZkUWdgd41qJSU/7/NHrwdh5w8RZaoZR/9rXd9CqFyDbnk8
	9asuiET/MKIbEOZTXEjRIuwvD9ZxUjTKzN8hM06B3JA1BCd7fFhUneljCQhllw8gHrxDI2D
	5Fbuer49UOESN9xbhVyDom43dqPh4Ibii/WsyKj+rz+CkbvUII9JrgtFAGuHJf1VCvEwmJL
	OujRw0ZassMaeENPb8LleNGoyxgcw5wO2Plql8MP9Ak1vdi10WbDe4kY+jfBX8szs2yciqw
	LgR5YUmNklxLrcT48o2VuDKHOFePrWlVFj82AV4tQqUoWd1hYPCJFlJ2y4rZXP47yQrxdbQ
	oRarU96R5aI3QbWUwtV9Fs1lOTeidtB3JlR7/hCiW/x4nlu5FBc3WkOm92k+0GEPf9PDtx1
	Hye1hgGUvOHRL0BUe5IzDdnF2JZhAyiTDGVhNpM0DkgqdnoPK4KMIoiUv00BhkJLhukIWau
	4W3o4ZMy/KQZisUfYZf4IBY48I4HxR2kdbVfO3aoWXZLAyPFEaUgn49lCvS912jm8KyycD4
	/mjRuc48VXSoJg9DklUE9xWUmXWxKGvhhU/qhA3aGj6183Y1IBjOftVUgASIEB4MYdVHDxg
	eF5AWPxRdImRu5qnFQ45RkZRQid0+3jSVwh8z/IYjIahB6yMMUYsiKJUFihf3eUvtHUiE0l
	9mdC09UbyjK+LSBlGB0meLzzwzbYAjQVgIE4ylxdxtRxv69cDDDlfE0rcHxeiL22+ej3vQw
	9K7sBaavkZOz7rL8njDV2yzt2N9GKCTM8g2dbg43Onf5qFLeLPB7ky8aH61JZjJhsCgcBHb
	ppWANslZ3aENhev3QvJQj8Asy4ISNIccNHH/Y7BdpJwPv5R3POjC3JggLOg3uKWwWKMTP9B
	VQjThn+JdcNZk0dSGIRrcSxviNIUhdRBU/W2SZayl4/4Lu3oRdjjGNtQLLJIB8PqRk8OoT7
	0LQPSNnFW38wE3596qCrwGrMh7PG/cuhF/SBTJ9mfgXAKZdjVrgk4nUP3o92a2q/YOkMhxM
	qAUy4mFhaQrcI3Lj15LvumFPP6K5gJ1KaPgjEYShMld+K4x5kFqdhk2N53hw1huhQ==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
index b09bc8d9389a2..173469d112f10 100644
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

