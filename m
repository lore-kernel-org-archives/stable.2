Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7566E46C823
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351703; cv=none; b=MF3emUU4DtpTbM7MIxD+z5Mn93j5SMT8Aqafq9+IAOV8+CEkKUlTF+hLOgmQx9FjLbLnOzPNMIs2+GH6flYDk0IBiErGWKEHCpXzGvFkA5Gs5N0zvhX3KknmFikpVfQzLJFgTAglYz2S7norOGRt5OJJnQSbq1kfKBdwPGZo+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351703; c=relaxed/simple;
	bh=CVJmSWantLXxhYIeVnGSN/uuuxAQe8bVS03crLQAJuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oyNvMdGPAUmuGl4yuqRCLmag3+f2RT9yfSv3HpmV5I7ZOP3VbRroVg/DpzN2OQAyVjugg73PzRcJGOZamHMCBWZSirf70fQqz56Ltd6Dgsy7Y56GCqsSEnjM0k/5Mu1shgmNIP9xtdOYaEmT8NUsW95PPvamTU3dxBMK3JnRUbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=i/1rOQKg; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="i/1rOQKg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785351655;
	bh=8PBikEcQ41keEaQyoWxLBiV2nXtRTQVsVI4WC58EHMQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=i/1rOQKg064SGBaA7s+H8iFUghaHhIzn0tmnhZQHb3AWlyio5K1iWdZfO5YvbCwMJ
	 KC/0ajxwgpPrixuC1F2V2yaxf0IcNKsM/Ry7pISJtuGyjtdjXOAsHmbI4hI8cul4Ag
	 mSnNE6g/4siahx5stjUNutE+t0ku0U4m9BbVAmpY=
X-QQ-mid: zesmtpgz8t1785351650t4e0f6e60
X-QQ-Originating-IP: q0cle8GeQlCVp4fHj8FygaRKRZAUwtr1Q+k6aPOqbVw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 03:00:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2419217697218369978
EX-QQ-RecipientCnt: 5
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	stfrench@microsoft.com
Subject: [PATCH 6.6.y && 6.12.y && 6.18.y && 7.1.y v3 0/4] Backport fixes for ksmbd
Date: Thu, 30 Jul 2026 03:00:20 +0800
Message-Id: <20260729190023.46584-1-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: N1g+NPRwibcMhwr9Zfnl2z9QeG/2XRlihU4aCigroB8z0TfhYseflV6B
	bZV4p+9aI1Eh41pzu9+Mvy50ssY6hG3FlSf5Xj/At5fPfWbDZIeUzi7y7Qi79gPmrTh1ZUC
	JsmOEL9HcmaUQJ+XH+voAEyhUHB01/RqEjnCTNuCnXDX/3rHHDX9zRTR9wUyz1e8ixhZdm0
	UK2BY37LaUg78yePBN/voQer/VeZz5uUyQt6VMWbiU2vc2gNoglsZbMVPiCQvzC/d/EyP7Q
	0S8/f/mhhsxcqRkKvT/pKVFVD5N8KXjTxOflArHmBBZIkfZ5Z39D55kE+DAo6GH/sQwPPze
	BqZHNWJnViseno9OW0jUgsR+wZGq7R+WAWUHqTnrVGdXEHU9GNEOWPympvNV8zDfvOvuA0w
	/hz1GT7CllEipugyDKXvpwQcgTrlFFs3rRLu8SdTrVoHhTWYiLG4InqzAMmWQIpC1DWM+BP
	nRW1MMlDWLgZ2DVgqfD83V13FwrTzILcnbgM/T/vlSidPq4lYfUnsJWJDgmyLeYbAySy/68
	Ktc9r556ZuYprfdpgFWlBjO3oHkV3c4nledDnbnGQvXYQtkUQPvApamXQccy1PAqQYKgoQG
	T6Ja14WK+f7Ee2Is1ZioFRWmyg/DKvEYHQ34zLjC9YLkATF0M5gmymiLZxjwZw2T7vojAA+
	Ghgwe67m9He2A44hXvob2qEOzQSzRtu9E/+FEscpJfVDsgcCE8469mYpvpGaYRRrykG6WGU
	Sm1O8c70+GDCnmdEmnqI91moOfF/+xP3qof11mDPIk6BuV/7bKb2r+s4kWitTss7Y6yh/CM
	Uq+WVqpyGWIIZB0e2B2XpnlHuIg0LfrHVUJ5U8hsIgxbC++98oEk0tGFEMGRb2zmhRLOMQR
	deMz3ipI9GfKsbpOGBwfi8s3wgl425/cQwpwnYyyjGQUPzZMTnz35mjcChEnYl/5R9lZGQ4
	suYBOELJ/pQjVhJ9aWEhilrqldYXC5FpGC2ImXZqw8hC0P5++SPXGtbADmcVUJ3gndkBshi
	wU5ajHLf93AhVFP5JQ3BH8SQnNoN3vu1+W2VXKXZvxlivzLvhQFh1a6aZh/mhiRztkqMrLT
	hRO5YHpl30oN6Kt0mtoVFA=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Backport four security harden patches for these branch from mainline.

changelog v3:
add ("ksmbd: bound DACL dedup walk to copied ACEs") to patches and verify build
for 6.6+6.12+6.18+7.1 branch.

changelog v2:
add ("ksmbd: validate ACE size against SID sub-authorities") and verify build
for 6.18.y+7.1.y.

v6.18.y v2 Link:https://lore.kernel.org/all/20260729182530.31304-1-guanwentao@uniontech.com/
v6.18.y v1 Link:https://lore.kernel.org/all/20260729180917.17776-1-guanwentao@uniontech.com/
v7.1.y v1 Link:https://lore.kernel.org/all/20260729162254.2169992-1-guanwentao@uniontech.com/

Haofeng Li (1):
  ksmbd: validate num_subauth when copying ACE in set_ntacl_dacl

Namjae Jeon (2):
  ksmbd: bound DACL dedup walk to copied ACEs
  ksmbd: validate ACE size against SID sub-authorities

Wentao Guan (1):
  ksmbd: restore DACL size on check_add_overflow() to avoid malformed
    ACL

 fs/smb/server/smbacl.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

-- 
2.30.2

