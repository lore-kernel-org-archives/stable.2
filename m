Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017D441600
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854018; cv=none; b=kpry0V9Q13VD2xdfE9hK1VYJCp78pRt7Mr0WmhDW4V68XBsyO0O0w+H5Nmh0QqlJi3cdyaLi8taI1WOuLHTts7NBf5J5DVSiKOqliE1R+dlnfkjCVxw/iCk3hdlFeo1SDZLgX1A7DdWZNxJhyUB2EuJV7RkWRIrtGlmKDsJwm8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854018; c=relaxed/simple;
	bh=BjP9z76Z68AgBQQePVV0nStVVznHGb7fbiLCMYRv2vM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M1pM44K+Jhd7iPfju0l0PLyvaE5wgbP4NA8R4JKEKyVRz0hIMbq7ZBqM+uwggeK7dxTlgWv51ltY6B2I2Ds30GjSlfCZtUBV+hGWTz3RxmRDyP/6maGwO45JTsW0yEodWyKJPYmJ7NFuZS8zTPF0OXnZ/h1zROaJ10zG3SRV7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IA2fEYOA; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IA2fEYOA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787853976;
	bh=8fvYzigmIaHBclVtoxZt/Znc0+dppTLvTfG04EkK7Zg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=IA2fEYOAr+W2JYcQRLrqKYl2UGynLLemDvGgpP76SFQy7jxNseCMX5gcSL40DrHFZ
	 6XgLRHoCKl3dzFwarEAkY2XyyDwZrcOtzMPQVBKnNT58cNyzWENOh9O0gz/8ZF6Uwy
	 XSwxGvUH4kMRmSkyOwg1T3KDFABUYcrnX11/5KkQ=
X-QQ-mid: zesmtpsz9t1787853971tfa33f842
X-QQ-Originating-IP: vw8vO6Mvq5Je/RuOavWHu80sOY2vxT2lGVpPsZaIQME=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 02:06:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17252097616795653787
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.18.y v2 0/5] Backport bugfixes for selinux
Date: Fri, 28 Aug 2026 02:06:00 +0800
Message-Id: <20260827180605.4187309-1-guanwentao@uniontech.com>
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
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NKyKeo1CJKGEushPvccyBHQctUcWgScHjhezcmutBKpqmTWrw4eYdnze
	XQcPA1JM+5SXmiy/t57vbX+rKYX3MDfjs8MVc6GDMLNAX3Iqdue2Bv0SqhyZDHXNxfE66tB
	D+GQhqu47Qu/cSZGjExn8RXC78P983Tyv6j/WVTv5U5LoDqDZ9JVk/5q5818LW0vrDaDP9h
	syqa2qDyU1KjiER2utjxLSwdg5qMkXYq+GvxT2ul1zqbpfRqGTZ5jzs1bEfWN0pfKxFlTko
	YIB0SRHa669fiTwyfFswsRe8R2q9rpUZYrAvwlzmvNjfiHAqjP+AXWIflHfdzrdSkpMIuge
	FwMMhMsPJc1C4vYKhCheGjNrN4GyjRYDX29c2NAM0PA63lw4bScW0HushIDvyqr0evrRCkV
	WTxTjIqKaEfjbI+Jmc+RKnqcV4Gm5o6ZYfK4ZXqyNEhVC7NbHcU7QySxHXZRd14YMMGTq5h
	39znXaBfWrL4xUB0nmCznSltfk9yw4iseMQ1OIMiZlE1pMRd/I+QNpu8plAWc3llU30R91w
	tO+b5zkdYIz3vjWfL+4LwsvNOqVPelKzQSEPh7uM6GXG3cXH+dLhYj2UKWG6n0WeTSxmsm9
	3Yxk0f9kVYZiHxvbb9uegMUiQPOLPO8BQxHnYBUZXBWvPFV5SGY3FcZXVt8+395j3lN1Wry
	zK1IsvCNe0Doh0GKlsjC4bYGMsmzi+5pF8xk5WHDA3xTfSMmVC5+0M41g/aOLPatR1FkkVb
	xnHpv0PbfWrmdyyKsJSgr65euPcYvqm7zOjrH1++r3dYCG/ZJF8b6JlGoOmF4SBUDjx8k9p
	Vd2a5BzENf5hK787IxtoOTXRQjKuIpdDFooWK/32DXnqRwC4t0isX53/JZ4u/2Cdu4/W24A
	1Ado6xb06xPeEKkESUyoBuW/gsj6oPlkBd7gwBizbtsnBSHexkZXGosjNMW6VKqoujF8YVl
	XM0Et4GgT63ZrIhJTwcPt3ruKWtmT785Wvq3Qj5GmZFh3qs8+rLKGqKAtr0fIXpWVLXRO57
	ubOBO78zSKTrrPPjuIcur23mfZHaGyzjaRmHv1YPskVQpb+hkekQ1ArXc2WtPd/0I08HY5E
	SiqfAWetFOp9JNY2Bvp0/9jVVrLVIzII/hpR3T6jltEZqsgwk6LsKM06M0cl7WPgasgJ8SN
	qs0x8yq6/7K92Ic=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

changelog v2:
Rebase on v6.18.47, and revert only necessnary commit.

v1 link: https://lore.kernel.org/stable/20260825100338.4039846-1-guanwentao@uniontech.com/

Sasha`s original link:
Link: https://lore.kernel.org/stable/20260824220022.435960-1-sashal@kernel.org/

Bryam Vargas (2):
  selinux: reject a permission value exceeding the class permission
    count
  selinux: require a class's permission values to cover its permission
    count

Christian Göttsche (2):
  selinux: use u16 for security classes
  selinux: more strict policy parsing

Wentao Guan (1):
  Revert "selinux: reject a permission value exceeding the class
    permission count"

 security/selinux/include/security.h |   1 +
 security/selinux/ss/avtab.c         |  35 +++-
 security/selinux/ss/avtab.h         |  13 ++
 security/selinux/ss/conditional.c   |  18 +-
 security/selinux/ss/constraint.h    |   1 +
 security/selinux/ss/policydb.c      | 254 +++++++++++++++++++++++-----
 security/selinux/ss/policydb.h      |  31 +++-
 security/selinux/ss/services.c      |   8 +-
 8 files changed, 288 insertions(+), 73 deletions(-)

-- 
2.30.2

