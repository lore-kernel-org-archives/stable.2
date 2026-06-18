Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82373BE632
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769255; cv=none; b=huTzlKFEAA8KuMVb/RsJAZWPdMPtKQF4kRxkDXVWACs9QWgbYMyq0SnqWhQIKZPNsWFvMZIn5+fh7NnqlLzzScu5TBHkbPbfUjp4bCjAglDgTHPxiJGu0hZ9oQSjnY86KMlLU46Nih67n6LrHB0DB3qC0mJ7BiYzL2i3ji1hZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769255; c=relaxed/simple;
	bh=6F2y4ZlnikioPGfFgow1EAUbDVX1Vi20GywbO9xZg78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rW4pvPAidw06bJYibTxu4dnM2tWZ4eCkjBAgQeDN36wDhCeFLWHaPJAoC56GNqLWNtBX3+x8ki9ZkLkJFuUjdJwlygiDgA9jcyh0G4RLZW+h5f8+0tLt5WgmSsIBftH4S0zNhIlBICnQR0q0J/+cZ1Fbq62TzHQw933LX9rz220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IFfq906A; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IFfq906A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781769238;
	bh=ixWQbR4S6QArwZ5JRb4bfQjRjzBfXulvNFGHfy9xabE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=IFfq906A+pdTO+Rs90zm8avfaPms1+QP2WSlUy8SaoFHLsis3slH4HezVjY0SCzLS
	 L/fW5/OiMibCjSjDJE84CPPHekvf71A6C+yaOy/DIH/oY2lJenOZYmZlsuvLem+/SC
	 l7UpL46Cs8UUgvw2BY4v1v/HNgXz3ii+0trjJoVI=
X-QQ-mid: esmtpgz14t1781769232t02de522d
X-QQ-Originating-IP: HJex80uI03DNawBJvCM4DRvZd71fzObs217Ybdljol4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 15:53:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12883385946568431589
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
Subject: [PATCH 5.10.y v2 0/9] net/sched: fix pedit partial COW leading to page cache corruption
Date: Thu, 18 Jun 2026 15:53:34 +0800
Message-Id: <20260618075342.1599593-1-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: NGfP4g+rgS8GRrY/kxHeIVjTW9Wo5a9kdwmAQEg+Yb1OMoKo8poAFpUx
	7Ue56oX9jakMsOBrPur/XvAfjIN1cMFUJYdWBIcEp+pq4dcpgbUhxZMSprK9NlmPB5QToVi
	9kSGJJvQk/7RDIHIYAIAiAff7ZP4SLpCP/8CjURTJdXIEZ6pMaYiENnWbOwetlJ+Rf0RNvb
	rPMMj4GH9qaoIU+4MQJTYUCf08yTP7zzWwwCRGxlSrFj6h7/VvJXE4oN0LVnHgoxO+5hS58
	x0jZ04os9mdlSA+bSSPdXQFgGHehd6qjD29g5roMAtN8hbF3QWXdTB321BqDrVtchtFYS6Y
	LkGwlNMrMALrSgVBVeK+HqSoIF65JFxizkl4Y0Sk2kekPbrxX+YpmQq5/lS2Qp33GGp4gyp
	75fZ8cJru23IfpMvEu0Mh/ypQOxzndySBB2Uuk7Jz6Zhf+AzpSZKdliXmgKoAqILhw5BdY+
	LW4pyQiZmO0teZTAO+s/3d6hykWCudJdGSGqRpEvNjmANy5aga/AJjleLpTB+Fq0BnO3R9f
	+WMXQJ7tJmbEkhwZqGPuTAfFVCQ6LngF/9D0HLNT8HIHqgdgWB6sSGXA7nuM697FHZ/+dhN
	izvKHVuGvYuLmQV1AP0t4kROgQvvBmL1hOKCY+avaEjmsQwf4FumcvKrqjWp31kPY6CF9vQ
	2CYrntd9MaH1Y7ojd3qRNrh9dFQ6ZxqpdvkaI/wXGiaonC/eqJ2AF7v5Il2kWcYmghp2Wnk
	WysA3/EPqGSLAoIhR3jBWbD2BSQjg4y7T2NcxS8QplclqU2hUcEUzEdNFvKmvIHvmkGV3L+
	IZ8yu3et0ytovHnRUqi9rZB8r9i3JF68hBySQajzdMAlKlm645XeRomRyIX42RWbztlq6+D
	vKVct4C0eg4gaMrYDdU5BrHEG7hZIl2/8KIYA4Ou+Pskx45SEemGv1l7fZisPaRM4hi3sKP
	sqaxJ/hrASS4hgKPA4g1tgbBQtPIfKoYsSK6DprWYHCbYGThC/ghxDUZYxfvl/S0Bh+RSOV
	wkEZfZj3rbifExRzOqB4KkmzVU+j9Wq2SXGnt4HhfvA/PKadHm7c5IjUZwZbo9JaO/eCDXB
	kO7cs1LD9b3FsJCm1MIsUMo8uuSimIifwKurgnXNN2JpYi4mBME/e8=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Fixes CVE-2026-46331: net/sched: fix pedit partial COW leading to page cache corruption

Link: https://lore.kernel.org/all/2026061625-CVE-2026-46331-47be@gregkh/

changelog v2:
    Add ("net/sched: act_pedit: Parse L3 Header for L4 offset") commit.
v1 Link: https://lore.kernel.org/stable/20260618043539.1557035-1-guanwentao@uniontech.com/T/#ma9ef6d260833405f60ae88a1686e967b1416d80c

Max Tottenham (1):
  net/sched: act_pedit: Parse L3 Header for L4 offset

Pedro Tammela (7):
  net/sched: act_pedit: use NLA_POLICY for parsing 'ex' keys
  net/sched: transition act_pedit to rcu and percpu stats
  net/sched: simplify tcf_pedit_act
  net/sched: act_pedit: remove extra check for key type
  net/sched: act_pedit: check static offsets a priori
  net/sched: act_pedit: rate limit datapath messages
  net/sched: act_pedit: free pedit keys on bail from offset check

Rajat Gupta (1):
  net/sched: fix pedit partial COW leading to page cache corruption

 include/net/tc_act/tc_pedit.h |  80 ++++++--
 net/sched/act_pedit.c         | 360 +++++++++++++++++++---------------
 2 files changed, 272 insertions(+), 168 deletions(-)

-- 
2.30.2

