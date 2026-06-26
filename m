Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105D233951
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782447313; cv=none; b=eEpl3qCId0DkWZz8pmQBio4VWI9PK6NMHRzOSMVN+0y+2YOpHmpKlEDpfMIHBj64WMDkXo/FWgZxlkbhA5qTEKwWgtvslszt1s0dzJUCRM5OZZra2WRwA+qmphKdVMNXJKx/dvweafoRdkCWvfYlI33qgjky6p/u/ItzpxCQjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782447313; c=relaxed/simple;
	bh=z++v/tOAkB/xY5xp6h5Efl3dYmC+M50gpEF/JuT04ic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g7985iqt9m7mSAd8y1faXUbfaJihObhtBGisRrh1/oyPU3zgIZH3OE0qWz7KGsEKfAHwFiVziBnlwV0ZY2tHRZ699KO5xMFKUdKv5tQG5VruvXYY6Wjf/Nsqh1W6PZt/fj4R6uLd7R7I5Y0cDgcivY63ctK/5x9tcO/0oQBdSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ZUdAwHCJ; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ZUdAwHCJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782447275;
	bh=vB3sV795Uip7jngFsQultFYfOEDt/kChAFd6+YNtQOE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ZUdAwHCJ1qN5DNpmDLe7xlg/VIRu6UVhvuaxuXIUyYvMykPIJFrgWhJoTqWkexx7l
	 +liNkl73eJmbTY6OXrxGxyjG26jTTckI+7njIBN3QPUB53NwUr50a/H8OxOFTRN/Ek
	 1PkBe9yS/TtR8gMzf96SyBc4urNw0crn0ERfj9cc=
X-QQ-mid: zesmtpgz1t1782447267tadb7af20
X-QQ-Originating-IP: ZsDvMu+xmAK0S0o9RNmGVGxzI0ks3hqZcG726xrxkgk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 12:14:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7067703450046998064
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	foss+kernel@0leil.net
Cc: stable@vger.kernel.org,
	brauner@kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 6.6.y 2/8] eventpoll: use hlist_is_singular_node() in __ep_remove()
Date: Fri, 26 Jun 2026 12:13:57 +0800
Message-Id: <20260626041403.85968-3-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260626041403.85968-1-guanwentao@uniontech.com>
References: <20260626041403.85968-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Of6ml/llp+z5a3urhMmYEYPeyXiO9iU0Gy8tPu3xm3he2ojV79OmTSIs
	nWVF6c/NRlfd+EIRgarVefbAN6PLUa7hQf2kKCpPoluPSiGMX82AKHJdX9b2dltKewJtOWA
	UjG/frThsvxxsM2uiscdKtu7N10a75Xlxi3ElyOe+QJWZYDffOm94LLDzo32ABvByU+6X9B
	ufoSnchiTGWah6O7UGhWQYlgko09O+B7rh+Pj05nkAuR8fT46KfoiGQtsG9kaz+XIGMV9w6
	ExAX+ChcFm1vdx8nc6/PWW/2GmgIpT3MhiAkXpqEBwVN5wM9iY+lpFcPRSnB5J1/WZ+jm0/
	2lzriAMaZBZS1GyB1Hxa30uSCt25SuVWTUJXc70gJ4jENf+HqRZfcB1rNI+gww7qmp2x9c1
	p95ZUsomjxTsC2kwYn8XjiVCIj0hNX8zyPZwM4GazyOHqi1rJOqjVair+woJvokZ3PPeIG0
	5DfhrFHPQbsSlQdv9yLUQhOgzFakZtc4NP+kq4U3gOuzcE9ZMQeXg/9z4Pcnc+figoW8Hpy
	g7tAx1VfmRKxBL+zy9l7S3n6cnHYSdKa3Arqdh4EZ1vLOXImoGCyQ0FW+PTERUflxLd4dYD
	lf4NcuDshN6H06I712mLR+OKv0SmxOsbR1DKmAyFdCXNRNMB4xtqWduQoEwoNCtqhJW0Lm7
	6sJJY3oc498vAMb9bxmhA0JfFTJbzM/ZnWDV6xz3uKr8iWhwLcKEwUyTHao291zOIluZ/FC
	K7REq02FqWZ9jM/ryaFN17ztqn5nH2vNlrtL762D8UcYh6i+LRpI2s2/cHBBRwjRsAzS/pU
	nnm+XXw7XvnPyHdneHL0DC5MdnjIyIjbRwXHTs/ZymzgmYp8ZkTQKJBNJlwvCo967ixP6xq
	oEOLkdIWSQ4JqpnnKDCavoF4sTP5dR9KBJcELabN6vzlFKhLwAiGnAIJ8YXDhRvjEoqtJ9c
	CdPtKypD+kG41lduOjT9uwqNkDoqhP77fYGd1obssaGu0i5EzJ+eod0zKkFINyi/pygqZ+X
	S8D90AqnoyyRL69Na0I4GTCm5rNZjwJ29PE5nE50pgkdBu+mFgcmPbjTiBZS/W0SHvziVQh
	x8cqoeKmkiczKcRBnlvgHs=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 3d9fd0abc94d8cd430cc7cd7d37ce5e5aae2cd2b ]

Replace the open-coded "epi is the only entry in file->f_ep" check
with hlist_is_singular_node(). Same semantics, and the helper avoids
the head-cacheline access in the common false case.

Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-1-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 fs/eventpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8a556560a5b2f..4f05d12a05031 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -745,7 +745,7 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 
 	to_free = NULL;
 	head = file->f_ep;
-	if (head->first == &epi->fllink && !epi->fllink.next) {
+	if (hlist_is_singular_node(&epi->fllink, head)) {
 		/* See eventpoll_release() for details. */
 		WRITE_ONCE(file->f_ep, NULL);
 		if (!is_file_epoll(file)) {
-- 
2.30.2

