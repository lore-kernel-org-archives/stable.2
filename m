Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427446C840
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351735; cv=none; b=JCU3wqFw66cPEQD4+sTQVQSVK9L9yRFi9pSk1oxXeY5LSJrfOs7XzoVmJPjS2jdIBgDOIq+YmT8GdNvxMvod1SZepWeBg5icnJA4uvHoBXKmWq5NqxqgBVlmhmW+lcDy9pM656B8QbnJYcYY2Py/61UMG5Or6WToJifY/tdre3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351735; c=relaxed/simple;
	bh=rH8IvXaLHHE8At0Ybgif9JtIay7VpjKuuqFFRb1P0Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jMuMjYydRz4RnrGTkK/DNWgm8j1GRx3S+nhwT0SNMTn5YT4nT0AgBU9cqsZF8ptRJmk4/FWAr7ubN5E40/M3dcK0DnekJd04G07Hqam+wVqSElUAgVmycqQeC+eZ00gWHU8qMuK0dlXiBgwGlXJBhkZnlLJkZqGvDwMhXLgQQRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gyM3Zh7S; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gyM3Zh7S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785351690;
	bh=nOSu4CKzjyF+VK3K64pFnSQWJD3WQWCUZ/Rehn4yNtI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gyM3Zh7SPh196fS4CJ6aXd+PSco+Nmjsb09lFLInPPa6uoQiqt+nPGJdmNjZnTxC4
	 vEUXCQbq1AK4/UASGx0yrmF5p2bY6lYutSP0IfCStyDhfHrwHJnujSgN1GfOXNcFhz
	 Uf0vtJWi/Pjtmhe7hhcMGcfq/Kim0NKk/CWVu8L0=
X-QQ-mid: zesmtpgz8t1785351671t09f03c0a
X-QQ-Originating-IP: zuiZSyPo0dn8lpYKInnWapkVeW1AKohrf8Y0HZg6/bE=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 03:00:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3011449756816812986
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	stfrench@microsoft.com,
	Haofeng Li <lihaofeng@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH 6.6.y && 6.12.y && 6.18.y && 7.1.y v3 1/4] ksmbd: validate num_subauth when copying ACE in set_ntacl_dacl
Date: Thu, 30 Jul 2026 03:00:22 +0800
Message-Id: <20260729190023.46584-2-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: MbY7GcL85SkKEXo/ISsdRS8VaHYON0C265VK5TL7eSzYxxV3v+dDyoqT
	kEQKeDhABJig7nUyPhSZqC5/zY+c1kiFTTZEp6ohkZvpwUxTw1Y61QGD7oMR80H+y/CV4tp
	1Y39LUc41qLejjT+GUwNRJa4Ogf/W9joaGuK91YYIE+ZGcL1ZaTqIIkttP04W+V1769zaXb
	FG/eW45oEZHMLyKkA+iH/8+JXsv5uoqptoPhCyy41kyGqTqJB4O4ypKJA3cCxyaflnQ0YSc
	v/yNeEVhWBm4PXubJA1AHRxUDIHTJeka8DmzJanGNsOFObCsIqN4QXTiz2F0RI5LDgBQdw6
	8PuQSvNskVzwXoJS02tlG/tSP4bMRBNKs/45MTBJJ05NQTAWxA/33dHouaWhu3iBITDh97o
	+qiLkglo2eljMKAcPx07m1TOuymu/88IoaIELhSR9rLM/1+WjnB/cBBdM9u6H3lryr5GYLd
	EgYyBphi/VsDOly6R0Ec7py74LyPBMh2qccNzFPPnk8nQuh15Um5KQ1dimcxmZm8Rw25hNa
	vwHwAFh0vGuiji/xQ2k1apl7SjlieE2rF+47Jp5APTd0IuTDPvskjKzV1C5c0osM4Yx+JGf
	Abtj2YDbh3baxWcAV1NoS8LhVq5+0vqwbI3RPtRQCGD0aQzFm56o+peQi4VamlRnuwca2UX
	fbrxTNb9jVFYvYJEnPVT787CiTPB1hS2lEkVl3oRbeugHPrf3HIAdmGts4QmoGw0pwf03Fi
	a0okbHRCd53xpFxjOSw626fXdHDjLQHiTgNXxeZQTvofNxvNFo1eaM+06VeqpHP/ZdogjyR
	l/Jh+EV4u7CGUMyh2EINK1w88y/3TIrsRW4jhhYeqCg6qeHKgkI0wp4VcsoOrdMPrNiK3jv
	Fd20yH8XLVnVa9CNHS2A7JaUD/a0OPQAq9bH2NLsv5Q3vwW1Haua37pfz61AemzewDzIQ3z
	az/5Ww3VGG3gOi3p/gAabTtOD2T7ZlxmU6ejqi9JQpB4pvoce9HfoxtvTZXNWAVhHioZLbb
	5s9UpQSBS720xb37rjCLqOCIvMzaZweBFiivg16anDvIxP8TcS65P/DfXID62aVE7/MlVqo
	46m6kHRJfMwbR+bib80UVA3wTKTPXenkTooqbzN6592VzPi8rFN1A4=
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

