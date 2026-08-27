Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7A41BA61
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858049; cv=none; b=SAp3Y7BFYX5mAb6TdAevxl80lfF37i5JKKytHKTNDiz0l4UNLHp1NqGBUYfEvLcB1uks3rDMw/OArvpWtoBAHjoy9haxFLApVfog6iCS8aIwqWZ+0AeFIuz5RXM77j17qivNTZg6UaCHzGRSfHL+WmefBTY4GcDV+z3/qi4Oa7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858049; c=relaxed/simple;
	bh=fv288bfpPP2vb/wKLjyXyeFBiEZdm2rpRgZVgXItemY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WJ2/4Xou0d6ypJ0SpFnI49sZYf4euye0abhYORIBtJd6z+++6xdA1SLqz5qtJV15tDkIZpyLLi8IxJ3nTXBSSCghmkc+wRiEU5yzfysh1OgMmbHNt1N9oo9PpsBJnB/AbFT2q56V9Knjdi8f/3vEKVr/OVAt6bN8Y2Kte7nzXC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VM8b3Bn9; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VM8b3Bn9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787858007;
	bh=MiP66az1ZbIx12zB1/VBIL6a2SdjBxPDU5WuWqVcJcE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=VM8b3Bn9/KHHl/hEefpvXzpawl84E8ZyFkzbmzstk70sEPBb37JHEdb4mKOy3J35S
	 UCPO119oi7uwJe+ShDQMVjcF+lhVzMC693xUndiOQiDitmz71i/HX3vwuqa/GjPtUN
	 IbuMIWRK2HpI8zCt8Ont3zXIbZ8udCMgSbPMIlnw=
X-QQ-mid: esmtpgz15t1787858001td12925d6
X-QQ-Originating-IP: t+A6z3UCWrBW/a43jQ/zo6Ogjsrs3oZ5dk3N/M8cdAM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 03:13:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7827614739459102309
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y 0/7] Backport bugfixes for selinux
Date: Fri, 28 Aug 2026 03:13:10 +0800
Message-Id: <20260827191317.18119-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MRgdQjHFXWe69plgssvUs7+kdWKLjbCOUJJiY/eS70ASuNPsOzT9qRTQ
	IZqymZiP6Pu7jLaaNTEsWgG3hh2oPmgw2gjv57O8lIyi7CUsxTWtOhbjbbqd3tvZrYaoFo5
	aO0fJ9QJUfK91Xs0HBcfxavUr5kpHIWHJROD5pViUhCyL8CnMQAtjv7Dw6xuCN6efakZvGs
	9INmOAsdZ9ML4/M9aTXvU81wI/zboxvuRzw+aRvcOGv3Ie8cofEBcN3XRN9RwcEhH4z2u+7
	3HGJNfnS4vXnYI1z30ChHqcSvtQgwwPSoM0OZ1ZPsSRk/GWZ1hrJXeape/iJWXspfvAOrFe
	+5h4QiHgpomJFl7ofCzBRcj/6Yp+n93Vnk4jfLx0sI7fBHmgW/hE2PHZjNX9iXIiW8vH2Qe
	4bpU8ycFgFsnHJGK1oQS+qvWl8Q4bHhCOIt8Qj2F3U0ZZoyTcbO70TqUGL6xCP8XJAKadVf
	ruZPrfCJDs31vgYrGhTm4VkESHhN2moGLC5z/DnCwq63jhMQmTxY60mWDrVRovwk8L0mfmX
	dvztWNeuenJm71iKfts28xtwr75W8cRzyakL3GPGqP7CG+zs8DvNAc/2WPeeYD3L2AWueuH
	SSUdDPLBZwCkt7IWLBmw5Vhb4aS9JC6gmYDZQL48PIKzjcsL1Rfp5Ir3+yfV0gceZHqKnyb
	F9IeCS5hxTiXGB1iHu940287EQfcqu/WkuNjyqaNl51bg6qNQpZrIPTzA2iXFJMkHnzQWmM
	BwQTR7rG6YAFBD1p4ddMwadNJooE6zG3+9jE90eYBTEC2ITLY3BF/UC37zknal1h6mnjXuM
	l7UalpluB2j3/Ge320jAGg/q3aK1tCwF4016qgNHqBobCsNhtAQApdPn567216yTBO/Ie4h
	gSf+jQ6SZpkOnA8JQHwNLw4Yt7N6TeDA1Y/prbFb1wNwtzFICIK8QrGXmoBZS3KWEFYLTMW
	NaG6zq47Dcb4eU+uam3sQhIPEw9OQpMM4fQXLyAn5ILKNBLpGXqCult9iESzN+GoEBS65qs
	1lS67O4Ud/Nz/5lyN8vGxLSMnln6A/FMR4mPmnGKsB4KqX0iU8M1C0X1VOH9PmvIzJ3WJE5
	ghr2SpkKhQeSOLNR+EmKz4x3PTCtkTfMfhqGwRKoZNojvE0XPffV+FtGuCuz0poDI94mmzQ
	emUW
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Backport "selinux: require a class's permission values to cover its"
more cleanly, base on Sasha`s backport for 6.6 before to point out for 6.12.

The only commit difference than upstream was
("selinux: more strict policy parsing"),
use trival way to resolve the conflict instead of change more:
adapt sens_index() to this tree's pointer-based level_datum;
drop the AVTAB_XPERMS_NLMSG case, netlink xperm support
(d1d991efaf34 "selinux: Add netlink xperm support") is not present
in this tree 

Link: https://lore.kernel.org/stable/2026082735-footbath-absolute-3048@gregkh/
Link: https://lore.kernel.org/stable/2026082021-tubby-passerby-6f34@gregkh/

Bryam Vargas (2):
  selinux: reject a permission value exceeding the class permission
    count
  selinux: require a class's permission values to cover its permission
    count

Christian Göttsche (5):
  selinux: use known type instead of void pointer
  selinux: avoid unnecessary indirection in struct level_datum
  selinux: make more use of str_read() when loading the policy
  selinux: use u16 for security classes
  selinux: more strict policy parsing

 security/selinux/include/security.h |   1 +
 security/selinux/ss/avtab.c         |  43 +++-
 security/selinux/ss/avtab.h         |  21 +-
 security/selinux/ss/conditional.c   |  40 ++-
 security/selinux/ss/conditional.h   |   6 +-
 security/selinux/ss/constraint.h    |   1 +
 security/selinux/ss/ebitmap.c       |   4 +-
 security/selinux/ss/ebitmap.h       |   5 +-
 security/selinux/ss/mls.c           |   6 +-
 security/selinux/ss/policydb.c      | 375 ++++++++++++++++++++--------
 security/selinux/ss/policydb.h      |  51 ++--
 security/selinux/ss/services.c      |   8 +-
 12 files changed, 382 insertions(+), 179 deletions(-)

-- 
2.30.2

