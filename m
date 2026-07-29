Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9E396B8C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349610; cv=none; b=QF2R0N/vop1mn/p1Cgrmrc/rqzOl43UXmV0Q+22QHSGubMK0DpHijtNmkxF48PefPpllbdtpaj4WMnXZD6ZPMRiw3UdruG0PnUZqkWYuvMcmSuWLjc23VqexmZvn8WxRXc8mAZkRzz9LmNaaRtVYMfA3B6ZAvEGSOmcm/0Qr9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349610; c=relaxed/simple;
	bh=FuhMChURjhJmIapD7fiarsigxON+OKdVf81UpGjqr4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HCG3HhSZFwqEvzFdQ2Kzf5I8bfY35frEuoSfROloplY4ZpdXMBcvBkyeyXURfFJGHQUollTf2js7AWr4EomxHv1DS32d6IVht4QbFOp5Z8nJaP+cLE0uio42LGTLGxbOb923lZOs4+g+6BYsHU9G19I9eceYBpLr6ZQ+BfXcxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=nXtIq5nI; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="nXtIq5nI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785349553;
	bh=rP0N+Ue7SS95afFkjKCtSOEhydB4E8Iz5D3HOBG73bY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=nXtIq5nInh3+3nfY/+2m88pgoWjos3BnbfPtAPkWKwycND1r1naEJprdNQc9w2eoU
	 7D2ts027aUVJvOihPFUtsWOtd/c/NP/OzWvyL3+ACzf0/7KMUUg131QAk+jHf2xm0z
	 7QUhiHcySnnybwKOxlPJ9ZrMJNn65T8CRKpcb8co=
X-QQ-mid: zesmtpsz8t1785349535tdcb50d89
X-QQ-Originating-IP: bBogijdz4XLrX+FSWsrJ9OrHfr/7VyItszJNUwg4ukQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 02:25:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4576993740533542291
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	stfrench@microsoft.com,
	Haofeng Li <lihaofeng@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH 6.18.y v2 1/3] ksmbd: validate num_subauth when copying ACE in set_ntacl_dacl
Date: Thu, 30 Jul 2026 02:25:28 +0800
Message-Id: <20260729182530.31304-1-guanwentao@uniontech.com>
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
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NBi/QPTU2d7kpU3Y2rWW7Xq8uVeWGdK6JBRNGyOKbl7URnMIhISxEuns
	nkSJHoNFY782RWU2lMOuXF3IEhIxdigHJmRek6dujLRhxUpej9BEXqSsm8EQSkZOPlgf3lA
	27Nw6zj/d9IfH5+STQ0jWrTrgxMrJGHpzkNUgZuH3w5OIfGArwsPquE3zWyo2XTDtWuiEyM
	2ELIzHstGCMvQNtELssH+NPS8I4BuqhXvN8pTzZl7F9MCbGCzFzRVmGXy+arzRRwjyExSof
	EerxE4myj3VfIUZwRve2BGiL/R8myP9oFkcW4cnC1Pf31vmqYH/GHqtphrIyutCuWMKAWox
	7IHzGB9pI5Qt2djp9Xu6/ytpRXIsTbnXXumKwpfeyriqBHE6FBD1RbVL7arijZa2n4ARckg
	rxnd5kQwlMSUlFCjue6ypL8FamhrifMzCssttmO2NUsRGJ0ASNPSZSZkSTMFAZNu7Fej/y7
	bt9mtWYKA+urukz443cWSouhR4dfFPTbKhnToMmW55Kkmq8m/Ndwg94BsHUjAXkiLvMj316
	9+MeSXpqUSNjuY0U7MHlsRfIL6k54jiltR/Ih+LtzOA/N5RpLLe/MjYyubhfQv7MTdRVGXE
	K+f6AgjxRqS1HKjsuQJ3N+Xm/ffGT1wugNjwDNZYEikxFayLiC01rfaKwwKUTonX9mhG3H2
	CjhMYL6CrgLGJgkJxxhZY7Urk4sRI8bwXEAgIr8QIE7CeVyHjbjdweaZE9C/512HJlmCvx4
	I3XMfhLf7N1hzGOAbpplQwHUIyvUixls7jH6EaEAxWgjoW8yDnnTeEBNwm802adl5dFU6H2
	BdeFPXOx+b4iA9+GP9xP5DSzgKYWBONNI2/mC3uaIuJ0B3ekTThlr1N6wjZwD6zOji1jCcc
	iRzVqAkkmoqDuw9f8igwwjZzlomlJcSpAOAWNoCm0O4aht9XQGWMAxuNFmTfgTGxkpYlFYv
	nxXFW9qbyGUFY9C7axL6ru22p5+J/7nfSXES0GRw9rln3hcx7IRi8JY/ad/hpNNn2l7hoFJ
	bo13u5wqCUw/4pF5wMmV3fmjH+/NiUT6UFJ6oBy2xuuefqtCSbESvC3s/xCq1WN2rFipX89
	mmejOT0zKVqcp7y4TMW1Wqds1xxR6cyV19WYqU+oqG4qhbFsHN6/o2z9feTzjh81PFSfTUd
	e3VTLaddYYxT45ZmkKpmDfrjEw==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

