Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794661785;
	b=DGZFYhqKl8wXVPvHag6OAuMDxTYebfDwKxyKNxQ0koAUyUJjvxUF+fEDKeHbADEFYl8c
	 ZSPEzGaFrr62KC+sOKZ2SeskbiIZbEFP1oxWs8xxPO8Bbb+cFirfwQ8K7/bdzwj0sdSFQ
	 ZyNMoBW59TBI6+uLlX+JzcwAN6izBNpJxfk63FP9re+MOJq4LMgRWm49NCuooBE2ip2I+
	 RUyRSqJSBKhgDdJ1CUXvy+FYj2JYu+gynCdrfOPKL0bF/qvsHLrV80gj4oD3jDC0Xb7hT
	 uvZTJBmHweVXJ1LJr0rpvYIdELSkXcHTI9gNpsHDC/nPYJ/tmpaBtrDC8YMsWEn+Iuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661785;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P6Yuh683q5aNH3HN18bjb0/+LSo0udXf08N/NrFxA9s=;
	b=wiMCX0uOPs3SODGeYkavevVcu2X0SKWl933784gJt5MxZ93c59z64r5T32lU1mjRmbD/
	 N9qDSNKwKoezjla1BAdPXCPHZmVGWY5R0zHb3K88UG0HgHqKhQDtfN5Pm7LOQiKSeRBab
	 KujcsoUqwx+0fNAgHnRDPhXXYMw7QBuCRsi3teG5XaBdaCwNNrFzm7rslzlFqiHvTEbzQ
	 pYzjS0a+/neNByGQMYdgzWBI/fb1DrG5lOo6iETFcEGHkD5QZlt/90VT3kjBgaewztWaw
	 jOBHGuzhPLbfmGtN1NhuLJ5dU9q1ULrNRGWwllBd/KoyA2gSLsPYFVlGDJMpvNVikJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=aFa5JwqW;
	arc=none smtp.remote-ip=203.205.221.164
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C7060A6F57;
	Sat, 14 Nov 2026 13:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58C7060A6F57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=aFa5JwqW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794661782; bh=P6Yuh683q5aNH3HN18bjb0/+LSo0udXf08N/NrFxA9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aFa5JwqWvTYPesigACA0Omj4TNQendrt8W6ZBKDd6oVeNVU0ysB7AO9PR+7xuHxBl
	 D0uMi3vq5Pzo1dVyoZwpMZl8F83VVzp5CXVGYspKaXN3MsGfq461rMmsM9wPa2PE1T
	 YxJ9PmRzmnZEiWPkRJtW6HoI9M/T+lMQLwqAD6eo=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:7443:873c:1230:8af8])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 25C3B2E4; Sat, 14 Nov 2026 21:09:28 +0800
X-QQ-mid: xmsmtpt1794661778tlw5bgnh1
Message-ID: <tencent_735D19C1C588FD2DF1F0532892DDD768FA06@qq.com>
X-QQ-XMAILINFO: MaHcj0GmOzv95xuNXONc1Jg81SNQTcimdqmtrArM4YNP3GhGawe0+rkXxacuuW
	 OGyR6zQmTJo0MXiKM4cOAj3xqBuE2Aesu1uE2PybsgbAp9yNZLTGc7og2ZjF8MBC22J13jXyRcQX
	 ar9mZ0fkdhHJjzgz6H8lALrgYP6Ob+g0cVOMU+iT2hpyOSfsnYMI7o8bRTm7SXNH1FwkRkH9UuMz
	 gND/z69qSsl8wWplAPy01mwzYJMiNfEQF5+9NDNcDYs2rsgCTf+sskzjlKefRLZZY/CtuyH/3QXb
	 KUgrp69poRt8PHmsNl/lU528vtztdcdUaSMvgvuJ+0aLDeRMXXAcjeXMUWOHsrMX737zMzApV7ar
	 AvojxUCg5qO9TebCn6kyg85ZxgWprMhDM7kKZfqIJeWUj+/YX+p1fxTGjQd2Iovbs+MSD6vkUSFq
	 MpkGduln6LkIxoIxmXMryHHO1c7A+wD5VBOzAsym/saxAN36NySuzm4EpPCVNPysyPvAse1BaSFl
	 dCJz94pnMSQ+bjm11nwzVrhySH3/eIsrlcXNBxi9+VAUUlQMOLi8WkNfq5RNzm32bAqfemwJaqg0
	 kB1pgQIzNkXIf8IFZ5HA2uoWnEEE62uPPJ3y+EvULQInHmziV31QwKmfKl20CzVOB+nWMmbjIDE7
	 fzkiaLx63bPbViGThR7XQ4ApajM0FxtmMQrab6qSUwfR+ptEuskpllltNmnBHsnTT7o/5IbbtqQv
	 Pd3mI7pcZtmUuqQ2WQfb4ZTe5brIiro89Vs8yAlIawg5jW4i32rttZ50W1kfekaLCOng0aou36Hx
	 NZHvWs/BOQckZCxTUubBbVOpv+xgM+0L1RDkkeHQxgUPAteJLVxYtsY4w+TQO1dP3VEdsW1qPZB/
	 xLls3032JpUUbfR1Qiy4yvpNMoFwfCIUpc675rHC3bJCJTEySH0m2iwUKIAoHjSRrgP9yDMVcPdA
	 DOBz+UmNrAuXGdTbanYcZnksudzu1NMSU7jYEKY3EAxd0GPDYdk3jlbxQQZDBKO+xXFdCOzZKeNG
	 FB/s6zfok1Sqp8oXQ3lWUCfwdmqLB6BhEHbA03CFpeQ1vuB+kiaE6nYi1Qp1FHvNnweQMwGW05Jd
	 jieRZyZ7Bp77FElj6/14MbZZzBlV/Ru4WxUtUHiZSNkzw3hcHftaXU3u2L8ptK+zisWqTkdH6+zf
	 0e9/A=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hang Nan <2122295973@qq.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	2122295973@qq.com
Subject: [PATCH net v3 4/4] net: mptcp: verify the token slot in mptcp_token_iter_next()
Date: Sat, 14 Nov 2026 21:09:27 +0800
X-OQ-MSGID: <20261114130927.91839-5-2122295973@qq.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114130927.91839-1-2122295973@qq.com>
References: <20261114130927.91839-1-2122295973@qq.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_token_iter_next() takes a reference on a socket found on the chain
of the slot it is walking and then re-checks only net_eq().  A socket
that was freed and whose memory has been reused by a new msk in the same
network namespace passes that check while it is still zeroed, and the
callers - mptcp_diag and the userspace path manager - then use mptcp_pm
state that has not been initialised yet.

The token of a socket on a chain always hashes to the slot being walked,
and token 0 is never assigned, so re-read the token after the acquisition
and drop the socket unless it is non-zero and still maps to this slot.

Fixes: 96d890daad05 ("mptcp: add msk interations helper")
Cc: stable@vger.kernel.org
Signed-off-by: Hang Nan <2122295973@qq.com>
---
 net/mptcp/token.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 8a603fc8dc05..48470d6e751d 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -355,6 +355,7 @@ struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 	struct mptcp_sock *ret = NULL;
 	struct hlist_nulls_node *pos;
 	int slot, num = 0;
+	u32 token;
 
 	for (slot = *s_slot; slot <= token_mask; *s_num = 0, slot++) {
 		struct token_bucket *bucket = &token_hash[slot];
@@ -377,7 +378,9 @@ struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 			if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt))
 				continue;
 
-			if (!net_eq(sock_net(sk), net)) {
+			token = READ_ONCE(mptcp_sk(sk)->token);
+			if (!token || (token & token_mask) != slot ||
+			    !net_eq(sock_net(sk), net)) {
 				sock_put(sk);
 				continue;
 			}
-- 
2.47.3

