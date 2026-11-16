Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841128;
	b=kRmOQ6bvi7CYdzz6HwBNMSxvxwFT7dRASJU7HVqvyTKAiO0Nlnh/y+JiA1kSxq5Hcovz
	 QD+AeFfR/lN6P4z6j5Kf1Ij1LXufTlXtpNNRKX71XhOUpv8u0/u6mpMSbjk3+bfAVhsrF
	 Nn9LkD/ySBtFRUNKfG+y5v1WUgps2nCR3xvwKbyvhBECtoTBMa7RD2pcaU/hxdMBVs/LR
	 pmLmrG7zBxMTr6Qx7j6wi4LIiqcW14B+S08RxL8gglksS4RTf3VjUlEYPFDr1tNvD48Ho
	 0FXfnLIyKkp/Jgh5WUiTQHMtkc1jTGmBTXIcHodtNWTLgGzKXNfYxFOM4KXCQiThL9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841128;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P6Yuh683q5aNH3HN18bjb0/+LSo0udXf08N/NrFxA9s=;
	b=mtIWC0RQE5I97jlJYeaRUygXsX9ciNS7L8bS0wPIN6D1eByU+ksgib14/uHKUkab34rQ
	 KvOsnVhT0wY6XFrADjkZgbBrh+2x0Qz9u+kgDiAJ6ShPeO/QsnWz71XwkZCd+Q5KAefOw
	 SOlUwbFeNR8GROROr45B5nD5+2UBTfNMNzqVYkI3OisffLTe+jWAlVdEboVl1qABTYrpJ
	 HpCpDb5zIZS2Xk+2wQUwU4fd5UDNmCmwX+ne46Iu5z0QWhBl8dFEJA+7SfRwdKR6v6Nz5
	 5Yo7sUVnagcpbvtNFZvHD0nWoKOyR9dNy1ZWFs15buCPTNZ3yTsFEXzOr+jtukeWtWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=CfLLH3rH;
	arc=none smtp.remote-ip=162.62.58.216
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B508060A2624;
	Mon, 16 Nov 2026 14:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B508060A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=CfLLH3rH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794841123; bh=P6Yuh683q5aNH3HN18bjb0/+LSo0udXf08N/NrFxA9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CfLLH3rHQTJmU9m6lcbgY7euwg/RSMt4uSpJv5pVw9nDAZbzgLuQKDhu86AKubO05
	 2HzCZsSJhG3UMncpxzzlUu4Woy1n0yB7rHDVDuDqroQJdbP9d05ixmWYc5VY6t6g8/
	 FOP1Vvdmj8kayzSX0SOvTZP1vKDLQ9briPKN2UMY=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:2979:aa1c:9ec4:8698])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E9E14C42; Mon, 16 Nov 2026 22:58:30 +0800
X-QQ-mid: xmsmtpt1794841118tximf9ax6
Message-ID: <tencent_4D4F1D48EA5FFFE96265141754F656C42608@qq.com>
X-QQ-XMAILINFO: NcCJkzr9kEID32ZflU5nxvDc+Cv6Nt6JIR5Ao6sFZJw1KBS0E+mKs+4zcL8jZE
	 Xe2dy4odEQFTWg2yAi3eBD979ar/0wBksUlzVJToXySn8zNlXMeCEpw0SFzZiTKPBcqv9HzumMcc
	 pXbhgv1er+WQYyTON5B+qCIZH93Nt1eIzllvYtav1XPa1oLilbD/jLUu0a1W+irNuMi6H9wKLU/c
	 5dmXspnWOgW2tWNsTr4TOLFJ1l7dTap/c3WBfa2S+hDIfMsHimWJnqm5TFGufmNQHhm9dVOgs1+9
	 WWn4yI6NLPr5m4qG1pG9WUZUtMYarUeLrm+CKCbi4wxDFBJs+vqESRHZ7hvpu/FJggUyzOQzIHHQ
	 WPNrrRlo6cmOWHRYiKWbfoFHu9VDEHNN4D4ybxz7zXdIMTZloXgowhu0BIYhtNy0+UqTpyZwpoK/
	 8Lny1ZZ0oj5ny5zpoJVoNMMRYNA6HjfFOwrWgiiWsBDv/W6H9Ppyxg7Q8QBPAfNo2ZsT1szi19aD
	 RJhx0bhfFyqw11MoC+iCOhONGcJxT/V4EandbFC/dqyi8YGHJQrie7SdqFjunMnaHore7hgvo8vn
	 HRbvYYNIlC0vrt7OWD2crtYqVCsmP5svnMkF9PlU3SOzH0sio1QJGWzC8U0I/6K7SWAIChfwuAjo
	 Gf4DT0Qob8wuhE69IKKEOYKyMSlUCeFBbs4VjpDfVZg91HLqskozMdHFi75yXZ9T/rQU6EwPCiHf
	 HCNLQoompOn6nNFf8FsWKM8LPstr1svXzG4F0KosCybIoVWtSb3294CM5S2wzq0FTwTeTQQw87kf
	 9JPLhipjDJsfE1GVNMRkeCShocPDP0xyXI6HvP0x7OtFiK+f7USyBfCor/zjiqOd6oTwIzlnFxTz
	 Dh5KbTBuyxtse3hyizV1cdI5EmcZq6MMvgBhww92R8CLt6nnSExgU2/DAC0PyrMCzyrJ5vwHHm0j
	 2hmJfLuZRdmnFaU26ljCCJecQ1YEzwctCeXEMh6FFjShmzq8S8h9DCRs23V/lCyC9LfNU3qsOevp
	 Jq2gcfq/dDjtjJC+sNGkpt8S1WUeqdhS7g3eBaEkLeRt4HUru3TanPdcI9nIszJ5OHJa/TJpNoCW
	 U4jSV+Id6BP/CMu42ISjw81JK/u/s7DPZkFe516q2eYNlVTYEeYfSsOnd4CV/6jzCfBRVmlQDTxF
	 JkTk2gTAmbni1+v4MbH7bPiXOx6nNIVmaYNr4=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
Subject: [PATCH net v5 3/3] net: mptcp: verify the token slot in mptcp_token_iter_next()
Date: Mon, 16 Nov 2026 22:58:29 +0800
X-OQ-MSGID: <20261116145829.96849-4-2122295973@qq.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116145829.96849-1-2122295973@qq.com>
References: <20261116145829.96849-1-2122295973@qq.com>
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

