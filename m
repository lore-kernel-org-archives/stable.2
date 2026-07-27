Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980E53DC4B3;
	Mon, 27 Jul 2026 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135692; cv=none; b=HX2e1LmP1sbTvt4D7WcrlHemB0GaW2/NFZ1hZUhKHIHP5Pebil/jixZ4n6m8XhvpFi8eEBxLrcuuFUwcs0oXc6bU0sFr1wFIe85tTuEmH8JFkbZEkvvqvWFYurGLBWjhCcaA1nfX5bftcBtaTeWnI/8eDteWMb9zjZpHV47wQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135692; c=relaxed/simple;
	bh=hkwOOki2RqLJgHnzvIKyiilqnxhTHu7gUnV6xBVS8d8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M+douqFdSmVLZaLmTF/EZ8GqmgLx0g8BsUUsB+35CGjjqjzwR2SffDn/Peh+A549jDRTGcvocB9W34uCjqtkdP1+WMAq0Rokj1++UmqZVIkNbIx9hEI4iIAidIsyLkQbrZrTrwO7ndHNhqepHlUpHxcV848d885xqm0UU6C9yPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Ef2NwGKf; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Ef2NwGKf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785135668;
	bh=sINvD0bskv+vJHonYANAwnvBnaUdmZEFu+17EC2edy8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Ef2NwGKfWfN45RDziYlZx4PElTGlZBW1HKglZM4Cfc1LKef70UNtZ6RqK1JyThfSt
	 yjzcmgoowwBlgPrr8YO3kBjqcwT4dbHJzjB/p3+7vcFUcqVImCwLoi8RmFYOJpjyhY
	 u4fkZMfvewWpDjQ8uoPNeIWtIB+HZ/eO0de9nb10=
X-QQ-mid: esmtpgz10t1785135656te941c837
X-QQ-Originating-IP: TxbFc6MXXXXNp9OuBI6vjNOikTHCSBWW+JmFAUs28qE=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Jul 2026 15:00:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7978217712569346620
EX-QQ-RecipientCnt: 7
From: Yang Shao <shaoyang@uniontech.com>
To: shaoyang@uniontech.com
Cc: akpm@osdl.org,
	kernel@uniontech.com,
	linux-kernel@vger.kernel.org,
	marko.kohtala@gmail.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com
Subject: [PATCH] parport: fix inverted daisy selection result check
Date: Mon, 27 Jul 2026 15:00:47 +0800
Message-Id: <20260727070047.328913-1-shaoyang@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260624013603.1184198-1-shaoyang@uniontech.com>
References: <20260624013603.1184198-1-shaoyang@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MEKKfKJEJa0u1H3f/6QHZABH5BkMaM2lSfIgQBPJsGmlHtJjnveETPZ5
	/0nn47RkB6VH+GuBM2GZQfU7mDMZ1rU3w/CSVocJuWkLDjltSndNQJi0PBeeqTz9FgfrfVi
	6mA4StwlV8HdrOHNdAmV92pm/x0kTqvbY+0LaFXSukJAy9RY19eA61svPfDAbN6KLmEks4s
	K0dyj7ImHeUJeLBKUwsxgG+FTNKK9jSYRnk67rR26J9ykWMudbWA5QF7eTmFm3zm7jkDzXM
	TaH9Qzo9efjvYG/V9Y8ZN3qp28DcqZnieYrxpniVIeBJrbaX5H/8aU3WF6PB3XouGNTRPt6
	+FyX4eUy/IgwkkF0et1WXPYOmQQ378WVqA2EdUlDvrzHGqm0p/e94cDYhg+zQ6AcbgyQN5L
	jvdE9L0drYo9brpSU9lkZETOg94njMLFBAI1VuM9HkBvGCq4b8BJMEp7H8YnEPdtd8d/uC2
	ATyYjWdJ9DjZny/2lq6DtrEA5NQlQtAr7UPPlBF6HslJVZyt9lubBm3HRe7vNe6E3vYHwWR
	sQFJJSvhvH3Actyxx0S0kRFNtbWbILlvm1N4DGXNdFrQYUhMsu7BSYmfytprY6YHS1twxFV
	bS1R5arfPFeCLJCenclypbSvGgV8P7v9pVJX8SQWAkooxCwUMUPi/242vPEhAF4YQfUzI8M
	zqIUD5gsKLwbUeIwUXmE8BEee0YqWIy2KXpgKhFIKKezum2Ifhi8cxDf1tXIp2Wn3Urudbo
	kzhhyahQB1TLFGcJf+iRdbiSiXFT5fmERBJEgRhmOyShYcT3Y6Rg6FalGB4BgpLJc3bZCc/
	hDCsvCLyQ1PCYShOY+uzjNmpOBh9bZPleIpt858bJzxB8TC6Tux0g2Kfc29lChHa1CGyojS
	ZzAjxqk7Jxq9erjnAQd+VkStSbsg6qLMrJzxbSkQI4vDtkKMYGqdZ3738sKjqH0Mk2+9A1h
	gaRx1QTuBylJiQM/J2cdFWT7JgfGilyE9pg+0+/FCU7h37gyD/sjZGHHobAX5dCsAuZXmgL
	mI77Qz00OFU85022OaJ7rargZ6kpLDFir93nj7JTe5uZrrqkoD
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

parport_daisy_select() returns a boolean success result. It returns 1
when the requested daisy-chain device acknowledges the CPP selection
command and 0 otherwise.

Commit 7c9cc3be1094 ("[PATCH] parport: parport_daisy_select return
value fix") changed the helper from returning the raw
PARPORT_STATUS_ERROR bit to returning its logical negation. Selection
success therefore changed from a zero return value to a nonzero return
value, but parport_claim() retained the old zero-is-success test.

As a result, a successful selection does not update port->daisy, while
an unsuccessful selection can be recorded as the currently selected
daisy address. parport_open() later checks port->daisy to determine
whether the requested device was successfully selected, so this can
reject an existing device or accept a device address that was not
selected.

Test the return value directly and update port->daisy only after a
successful selection.

Fixes: 7c9cc3be1094 ("[PATCH] parport: parport_daisy_select return value fix")
Cc: stable@vger.kernel.org
Signed-off-by: Yang Shao <shaoyang@uniontech.com>
---
 drivers/parport/share.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index c4c5869..2888005 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -1025,8 +1025,8 @@ int parport_claim(struct pardevice *dev)
 	/* If it's a daisy chain device, select it. */
 	if (dev->daisy >= 0) {
 		/* This could be lazier. */
-		if (!parport_daisy_select(port, dev->daisy,
-					   IEEE1284_MODE_COMPAT))
+		if (parport_daisy_select(port, dev->daisy,
+					 IEEE1284_MODE_COMPAT))
 			port->daisy = dev->daisy;
 	}
 #endif /* IEEE1284.3 support */
--
2.47.3

