Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC88361DA9
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754946; cv=none; b=AaTvDDSGmp0ppANePHGdy6gxvodUlD8p/aSpNKQ1ka5bclMxMQwa2NG6A2ht2MvZmthlBKxr+vCw3bf3TJTqIHBrV+Y6DtoQ70oEI3hbpRHFDMoBGWheQ1l2+/AU9guqCCbVt00lIuIuRkTPVwJtZKhpi1ySil6S7ejal9TeSFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754946; c=relaxed/simple;
	bh=9XvQgKKW14e6ISnVyxmPqygAIaTJ25qIsNsBi/IhJlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uugCabsTCR/t4vRkE/FJQ7APeJTAshqDvHJkKnKlkiWd8tOuUrhLZmVKT9sIb1V4C9z5633cmfXEkRPfc8AnhhGwo84Tp3khi2q6SFik08crQnSJrfPnNZXPa8/NEhteohZs98czkHWq9xZ369o0BIzHSClZft+Jyyrj6eD882o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Fd4/AI18; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Fd4/AI18"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781754925;
	bh=3ix6uBCBvW31K5bhik12w2N7rNXat6Ewvad3mCbBjIo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Fd4/AI18KU1POA3DZQU7s74msjp+oZJTkyqz315FKDF39uHymVTR+7afjajGWjgZp
	 vG1kG+VoKEUho/UkZwVzUBiXVpnTIi88ttBcYGLPaqxtD4zKaANP0GEAC3DBAVwPG2
	 K3iZCTcsWilUoccjiP9WEaS5zXzZRPQXrrIe98Qs=
X-QQ-mid: esmtpsz20t1781754919t5bc77483
X-QQ-Originating-IP: kyCaQjQiI87qKrtp0NkBJSyLBBubrdg8nF2olaLT2pg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 11:55:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9903793249695214928
EX-QQ-RecipientCnt: 14
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com
Cc: stable@vger.kernel.org,
	2045gemini@gmail.com,
	dcaratti@redhat.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com
Subject: [PATCH 5.15.y 0/4] net/sched: fix pedit partial COW leading to page cache corruption
Date: Thu, 18 Jun 2026 11:55:01 +0800
Message-Id: <20260618035504.1536870-1-guanwentao@uniontech.com>
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
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MD4sJBF2yUQ8bW9S19DHonlVDcWvh/a44Yqj2Wfap1Ik8nkiNR1pMVWr
	Z/SJIu+sDVdgx8Qz89ZKmd8wbA+/sMQE9qmheUY3VMk3CR5TTuTd7Ani1aLXBaqHw77nqq2
	tgPjJCtmeFPClLMyomTp90Lz71dXdgSpFzukFf8MpdiVniobifGgQnknn0v0WQyO2fiYzbl
	Q4M2f7SFOSJy5L4wJOXTlOhKOoWsU28/8dOjRRyYCF+zjBaF0h/G1Xmc9JCjRjSoDJR8ueJ
	XrzxiEqj68p6JAFmpfYDoJDmBcsK4FoFitawvj+kUW/YrLa7kMqTwkkJqGhD4O9gxByZTgm
	CumtTBL0vP+j/3t+g/tb5j5u0zqepBrk6wiL8iqiI7SJ/po3lLxOB420YUVkhBnqRbOJHu+
	bGPJAJaSoLqpRZBu9hcghois9Mc2aAPmNvXluVbiB3dCreqqKnNzhMmbHoF5qGOngxx6j5G
	1VXcbrDZJG3Y1zkB7NoeRS1YHjLTbl8koA7QNGW8WsWtixuSvzx9/9qNTUOhxrQmm8dB5he
	y7rMv27snONDvnDuxFKLBLbxgVLmneEddSBY13x+Xh9TXQzIGxbM8seyI3eukhNiLu+SS+N
	ie+ToGDBQyKeKgKUGw0dEqRkTcL0gT2LslOHPHj/TKXR38ae0+h+3iRdW26r4DnscjiWm7q
	p8Cn8dhRtP+XGeaiwlUIV7o0LjDPZ3uex3mpZ09XIHaC64ALQp3pbODTWL98MrH2os8gt7J
	4kcHdHTnFaXI4C4qAdS0MKzfHTOvO/H/ZdUWZGKm4X61HJY4/6N8qLwarIpkXDE0FWiVRop
	yCoVLWlZrfU6L7BBApPb0ZyJZ/ZrPFrvjkXvKetcJfiN6Eg30jaey3m0ebW+yHdWPV4rqBx
	YBSWTeHmZTrLneCurvjK20F0g5HzIqQbFo2jDyWJxi8KGQwyshodGfbAAAd2/GX+f6htqiW
	+aP9jy+5LSQBYNyOAhCBtTNBU33mrVjhGED5aCEApX/oPkuTNt84OjriMxdP+aqx1k+Ul1A
	OAcBbVt9TMpaBlGbKQttTMv82Ai07VIjF7qT7HMTZfWzVR+bR5x3pU4tdr8/ecFPTNhtMlR
	yZTlqlxMSI8SuezNWLfoj5CWHtsVJgCWTCEWUs4eb+yG7zpUEorLQHUxMAup+VlRzeO+dw7
	jKzKro+kG5wCq8CY6uWQ1rPDYA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Fixes CVE-2026-46331: net/sched: fix pedit partial COW leading to page cache corruption

Link: https://lore.kernel.org/all/2026061625-CVE-2026-46331-47be@gregkh/

Pedro Tammela (3):
  net/sched: act_pedit: check static offsets a priori
  net/sched: act_pedit: rate limit datapath messages
  net/sched: act_pedit: free pedit keys on bail from offset check

Rajat Gupta (1):
  net/sched: fix pedit partial COW leading to page cache corruption

 include/net/tc_act/tc_pedit.h |   1 -
 net/sched/act_pedit.c         | 101 +++++++++++++++++++---------------
 2 files changed, 57 insertions(+), 45 deletions(-)

-- 
2.30.2

