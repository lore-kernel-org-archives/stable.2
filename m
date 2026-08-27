Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB74C6F1B
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853202; cv=none; b=d7tWHkbRFnqeZzIJnhjZCLvg15dkmtPKF/PPR1Wl8s/OtsN/gq46hpC5ktLHbPpHv+EFyOwudU9RhZlHZw7Jadew3wtG6Vc3jRWvDXrxSni/mEzsCPb2P8x3aBb+48DWkXb1VTogy1po26r6DfS8XEMRHXsCgx08DlXSp6qex6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853202; c=relaxed/simple;
	bh=hVNp82pyTXQONuy4VBxGPMuCv4e2YdgTiJuokG0YGqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pivrzHaqMGvXGdsd+x/gr88DGH0wgEKFktZztzNq2Nztrb+EEH5yQhNAjZ8pPjxgr78HYQCR4x7z7MHf7oI2Hgl6XSO7oBgu6aFAxNDk9uKFGjP8NDOQwCfvdufe6Z8Epi5DqGC9ELTQKeA4DknrSttv4NFUtqIs07KbC1be8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=H5VrBvdC; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="H5VrBvdC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787853115;
	bh=z78Wzn29XACuPLhOj6AnLWDDC+/WfESzF7T1X0kdMt4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=H5VrBvdCtAVqiSUA/+Az3CAbO3LyX66FggHrwjQZ5yPOylhgTdf7rfZLbDF1o4qdB
	 8ozgh/OHSefleY0VU1pNg/gIoPnhnhiq7F0Sv8cnEu8ryxEPRU6DaVfVTtudIlE083
	 QA7M6AYXEljQRi9+1QzjXbb86uwJLuzHVuZcIKps=
X-QQ-mid: esmtpgz15t1787853110t32e51db0
X-QQ-Originating-IP: 7P9dAT7HPKl2tfJyuSpwm30Sd+1yZ24DpkuEi5apXcA=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 01:51:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15811411992996364456
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 7.1.y 0/5] Backport bugfixes for selinux
Date: Fri, 28 Aug 2026 01:51:39 +0800
Message-Id: <20260827175144.4174620-1-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: OTFBPccPEb+dlYMqOUG76xNuZx6d7hOPTyfPyRVh5OngjQEgwM93f54K
	iQzqMoH83De3LDECAdvnU3+CxkNU9mvbAtSnV0RZ7PYEDzrm52aIQo35QHInEWXzbRBDVQu
	EtSTqSpdlMGJiQb/u9FzXwLvqLQBh9XlEyb54Lfc+J/3kuWNB0dqRx+/H8tBnsU6FoIlqsZ
	HWxOYBRaY7aouDcjdXlI3bbe4jZjHMT2g1muHqwjS3v6PpRhWVfLIZQkJfWwr01SGZHAD4x
	Q9ubSO3pO4W4frD9/fePkcEaylqcdTHM1ZvZD72I+SJV95RXpX/q7yExFfYxdEbWKyYnxmK
	G9iXwTogKKasxYE3qNCoq8N5KPWEG68lET6Pm5uIRRoFeFFs6KkKkzORMrHL/v4fa6y+/tN
	NgZXMzeZqu3LV51H+RbdVyggNd45xgbzEDYo8Gp1JGfl6gVp1FKMH87lKH6hV+9mHNeISGU
	fKrcog+xtC/6XoASEy0cPzDu8f3ZqVvntT7kWD5/J1aC5SYTwgXGhXeKXOiZo/uIrNynt/0
	duS3QePBx5BXV5SBma+BQbvn3zW04FQn8cMkSwnBXU6V0piUKvPE0SJEL6ee9RKAuLIACrK
	3nkz7s1VhK/I1ttOBw/4MvBxHGwuEpckCt4838XTDqORg7+iYqBqQf8jeUlaYufWnwy9Xfv
	bTOUooCs73DB0g7irLGXlMPryNYcTDJxsfsUI0s2xSCjFtR/+2bAgUT+sM4N7AM0fF7P/g9
	/kAYsbDbum8axKywOSKTN/aZdgQTlzEFAq1bC1CSYyutJoLSA6nLwnTcNy3qeV4GwjSBCQq
	cEzXHQFtn2Mx/A+PcZWE3dI15MeGlCemfjzklQeXJTbsKP5VQFkbykfCMNtosoMEb1lkpcZ
	yj1LsGWcPpCe/s1RU9Nl+v0pSqZ2EY4U0Vl/OAsLZBwDi5wi5URcT67XzgNSmWVvgLNRTpI
	f8Mu7EB0Dh6N0UTVUeBuJIA8K4/X81hUQX5zUtPVe2RxbtgEIotqeL9wbIek+WYb8csLoi0
	PzJzBTQVE/UXGsEm0gow6Sgh6neLaq96L6p/vt9VN2L5Rhsh81md20BLxCOwq+hztIkdSDp
	p7STxKe6cDLlZdiTCVy+dQ8PdzUcUsnPA==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

changelog v2:
Rebase on v7.1.10, and explain what and why the first commit need be reverted.

v1 link: https://lore.kernel.org/stable/20260827054709.4027356-1-guanwentao@uniontech.com/

Sasha`s original link:
Link: https://lore.kernel.org/stable/20260824215605.432476-1-sashal@kernel.org/

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

