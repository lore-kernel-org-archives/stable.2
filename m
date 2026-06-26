Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D23AEF3E
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497325; cv=none; b=t8LuK1BEHU/UmtAvyq9XdTpwCilHXHOR1GQFKeUjHwT2XweNl54M3e2kGDk+8+ZhvKRy8npLlyOn1Dc4tdzqYYz5blU8ul6FrYIA31c5T5IlYXms4xX4leckhEOyPmtmuEC0LoyERJP8O406ASPQXrZ3HAM1aWTrZeT95bOvM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497325; c=relaxed/simple;
	bh=5IMepZ/Da3Y91Digr8egqHe4xMwDE3MqQTLyJVBWVpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxz7Sd/nFd5AFqmxWwUgFlcnVWkCSYuLb1NJg0M2oBd8FGa/8YH3+1rb4xsiYxp5ZuGnWrnW3iy6SXNio698JTMbv6ullBR4L8n6u4bx8Mka1aOEUVpUCWq5m6FWXwl46t+0a8XwT/lIQhrvTZhLLLcD84bVznQTfefo+mZsg9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gUrG8Dow; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gUrG8Dow"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782497282;
	bh=aN0VHnpgeIuDDuBFVLSyfGxovRoghhsjJFX244cZt1Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gUrG8Dowine10zSg4XNnadED4Yzq0QyilYBQOaeT5grC1Y+eW7CuUWAeya3yajEp6
	 4jTVOVtRsSg3dfqFOoLE2wOjYWhqjP75QuC6zIU+8uWqnC3clw2tT7G1HNKX4Ddj/7
	 1Us+/drZTxetegGUbh4BHDb/YcNHLjfoK5PtmHP8=
X-QQ-mid: zesmtpgz6t1782497260tcdb310cb
X-QQ-Originating-IP: IwmEtnmR2j5k3hfK2Sm5PoBjKg4pwKzgE1/RnZ9N8Mo=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 27 Jun 2026 02:07:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4986354597952941750
EX-QQ-RecipientCnt: 17
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: 2045gemini@gmail.com,
	davem@davemloft.net,
	dcaratti@redhat.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	pctammela@mojatatu.com,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	simon.horman@corigine.com,
	stable@vger.kernel.org,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com
Subject: [PATCH 5.10.y v3 00/10] net/sched: fix pedit partial COW leading to page cache corruption
Date: Sat, 27 Jun 2026 02:07:25 +0800
Message-Id: <20260626180735.297017-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <stable-reply-item001-act-pedit-510-20260626@kernel.org>
References: <stable-reply-item001-act-pedit-510-20260626@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MOfwHzgDpc8I6vAMhILsjXzxJha5Rprv3r0adgB5OdibKAlf+J77eAU4
	moHd6qkZwRrQwUlqPgp2pqMR+rtJritZF+k3PW7OwgS2GcV0KL2e4Mz4m10HgAmfaPBKAIC
	cUO+q361p7rq2Me9/s/e+qYApsP6JpnAjOt+VzO7BwJTynPYM1qyCveO6KwNuwxU3wYqH0L
	OpGnQjX8ffwl0v5uT3ccr5mdUhV1I2dqJDEtmZK4TxhYfOIwqCJNaHgrwACJZ3vLyZvRF1P
	nC3wMh0moTYwKq/HcjmAugRL+29taPFPXNw0uUiQKLciwvscR75pW3ZPqzZsxRl4IuetJ9o
	IGUeyHefb5Cghs1aku26yB5928Aa4eBJ9j0LXLKYDZH9mKJjrIpI8EbSlilmVJKtIQaepcU
	jqNFRaEOyvlo02AA4xEIR7UEqEwlXrRqYWIYH0lOTMHLX11NBqKLzkxD03NG9DTwPmHPEDy
	lKMNYs/+ucz5/qB7qP3z1PuBG8kSGqki137+HbelGlAoTUZj2N33cMbDU2GvSYJKU78RB5h
	VMtGMy7gvQNdHSFt7jUjJ6sV5gdUdjuziRfI5CGaFjducTd1JuBZu7C5coKmMaFq6CNfXZv
	ymAnNuKQr5pnm+aW32LTlY5jtLPwhnyeMKxjagU7Th2m8BMPNUhZvywib/08XK3LSCPBjlN
	Sq+Upb3tOhEJuUrhc+jM+VzrOxneMQ4gItYIYhD26h/IWRWarZvRUZgbd3a+EmTdNNcua7u
	dHEm8myHXyTYnqWTqP2foQB7PO15lK9sxEv9MRiZnRi1azNITcZjbz7fElCYL20+MZ4e9Li
	vN4Jt8tjmTew3DIVETZ1s1E8TIMnhUGx+dQQBDoAVlrgzo3+Y3AlE2Nuer3+OMmLEJCkCc/
	kbJ0vemiQl2vhaCkYf4lAciLlhduq+Fd9TEwPDlj18FdsCDc/WvWZolBgkS99l49c0W/+6z
	mLkYcUUdG7N/ee0MAFD7N/hJLOSbFqRr2ZyLu3vIuv3+pI8P2caefQGJPlQBa1RITyldN/o
	4G+a6i46um8ZlY7RMi1qMmDKm/Ht2RFT24Q1didH93476enLwGVwrkilQsRXU7rwOHpOb9S
	rByEfgnOWD7obGWehziDa4=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

Fixes CVE-2026-46331: net/sched: fix pedit partial COW leading to page cache corruption

Link: https://lore.kernel.org/all/2026061625-CVE-2026-46331-47be@gregkh/

changelog v3:
    Add ("net/sched: act_pedit: fix action bind logic") commit,
    it also fixed the memleak in tcf_pedit_init() -> if (bind) -> tcfp_keys_ex leak.

v2 Link: https://lore.kernel.org/stable/20260618075342.1599593-1-guanwentao@uniontech.com/

changelog v2:
    Add ("net/sched: act_pedit: Parse L3 Header for L4 offset") commit.
v1 Link: https://lore.kernel.org/stable/20260618043539.1557035-1-guanwentao@uniontech.com/T/#ma9ef6d260833405f60ae88a1686e967b1416d80c

Max Tottenham (1):
  net/sched: act_pedit: Parse L3 Header for L4 offset

Pedro Tammela (8):
  net/sched: act_pedit: use NLA_POLICY for parsing 'ex' keys
  net/sched: transition act_pedit to rcu and percpu stats
  net/sched: simplify tcf_pedit_act
  net/sched: act_pedit: remove extra check for key type
  net/sched: act_pedit: check static offsets a priori
  net/sched: act_pedit: rate limit datapath messages
  net/sched: act_pedit: free pedit keys on bail from offset check
  net/sched: act_pedit: fix action bind logic

Rajat Gupta (1):
  net/sched: fix pedit partial COW leading to page cache corruption

 include/net/tc_act/tc_pedit.h |  80 +++++--
 net/sched/act_pedit.c         | 390 +++++++++++++++++++---------------
 2 files changed, 289 insertions(+), 181 deletions(-)

-- 
2.30.2

