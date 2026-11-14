Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794661788;
	b=H5iA0Pwv1IFxWGw3wHHfBmD5LHFYKB3aEAcWOg2xqfOJuH+E959nlEsvsOtv0NDzH05A
	 mcxDMxICm1vcyAVmfU2XI+c5rtCrK76ki/xezFu/bK9K4cmVT1iaOu96zK/eHIUNss9Pl
	 JgCsTcgFR0xh2oF20YsAiIvIoa14/tS/OGagSefQb/WmZZVNU8ingxZWQDBptygJzh68c
	 ahPWyrQ5+4SJG3f3W4ordRXtfJSRoWwzeg6k15EPPs6YUuJF+wbrgLI8TT37QCp8YGTu6
	 MsPsCBlTalFwAQ6GU2UwQbN+VZ8CE0bqKQVHjjQCzmFCnYclU8PmU+OT/H414jTfZSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661788;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3VoQXyEijSo/xuq/fhROFbh3/2Km0UUjaAcWVlWjklI=;
	b=Y8pnhbZCR5zr7Xw38zSevIc9qQjmYmfsuMlyUmLzp3Tkzu9TacXRLPPFgag+xMFtOllc
	 cWgBj2o3UEvwCWVoSroyt2XY8/P+wI355uNjEQz++0Qa5zpGpkJGzDmjy8JPmsTUL+uUA
	 5Zrty+iVrF0YgeCeWO0PzJtAt/YtBhnUy3r5OOJKcZCkFquCspF+zTf+VsdaTfiV9m4Fb
	 90fLI2ZF4YVx6bmK+fg6XLHcoJXcG+Yt0YCyPVfxskwS1cGCZB1VrqorSye4gJlCQq65Y
	 hsHB++AAKyNoE20q5zTb10Am8HHL46qqoBgpzBnQyVSwBJKaBa0M66YYuloXZaqA7Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=faDmI32Q;
	arc=none smtp.remote-ip=203.205.221.190
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF796079E25;
	Sat, 14 Nov 2026 13:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DF796079E25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=faDmI32Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794661780; bh=3VoQXyEijSo/xuq/fhROFbh3/2Km0UUjaAcWVlWjklI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=faDmI32QRcBwVGSdy+cTxOF97AFSNCjinoPMweml8LiQ2ap3yA+AkxePmjK4kWUWA
	 UNz4tG6EJ/bXEVRsYeAF9u1OeclGM5LUyhoWKpG51DWMmA0o3LdWCnfmDpbeR+325L
	 vu3dnqoHLfzleH5hIGbP2EuZP1TZFp1K44mp3UHA=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:7443:873c:1230:8af8])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 25C3B2E4; Sat, 14 Nov 2026 21:09:28 +0800
X-QQ-mid: xmsmtpt1794661776tbemqpb4v
Message-ID: <tencent_280CEDB388319F3A9004BE64D245CA3C2F09@qq.com>
X-QQ-XMAILINFO: N1yXN3LLlHerrKeu4kPi7XH9fWy3OE1gLAJ44HzdrrWiY8ns/+tD6LCNei7lPl
	 fMb4P6i3UxvXxIfnzFuymfXp6VHCWmW7wHeiRnGLTSGIX+ofr/jbtJbluPGFGbQg7vJhECgIJpF4
	 LYhA+zd+W41enCBmkvBeyjRAsApEnrAQt2UVyB1bZ4t4aCxX1qfAOBsoPLaPtL8vk8uoEO/jK5Yk
	 SPLRRx/XBR+WMjPd3qUZ7A66gqum/CUTXTjtcB8euz8Yun+Ejj7o20c6SqQ9uNI/VeuioEmEz71r
	 AH/8rZmBe//EoqzJHKIto2uljBCv8ajOWVTBR54uGFh+vcIBKqqF0dVFdCTpFEj6NpXgy8vU02mW
	 onpJw13IR4xCVFvfnJEVJRxoFsIBCFijoR/AmO75hFb/iBFqfn87hWxee1740s24ycATqskPBlZm
	 NW7MeDP7kxNWHLpoVyQQN5ZNapiw+Mu/gZyDqQV7IA0+Uwgc3ynpbXPaK1XFsCb4yY8q7yvd2IaM
	 t163252iZK45pxh2L9rO2TmxuyX1duGXqlMiLBMQo8WjiArKciBdb8Gu9c2a9IlsBI3TYf/N9dhY
	 H6qBPCr65gAmzeuDCOQ7kyTGLWlMHatYspfs4JKrCgWs1XELkspB4U6oSViQX7wc3s8fTsVUcOhM
	 arH8dHYV+a2K5naK5GmYmwNLaE7Tny799I8hQiie4d7YZNeZFnHZBHj/iv+Ss7jZNTg9NUsgrmib
	 PtQSKsaQE9IEokF4+rQiRY5cA/8rqPh1M4PnMD+Ixc1/sqOQXjNRRsi5B+Bp5STP+ToRO1t5Fb5J
	 vR2BGT1+EeJRmHRIsqRQiuriNUivFWA3Ov8Uimidthzpa/96H2X9fSboSmjSMBxnAXnHdw+FFi3v
	 9HORVJ8asat4aJucWm4iDb2laXUBXYiwzXOyfDIkA02QGi4qSnOg3yguhq2WmZ62+Gm4Ny43fLdK
	 caqAujUjY/ozkYQIJ6WZtjdCY/J/OLfH3rXgVt2HMMhqw3UqoKxhqKqVODqGPDNsOd9Fh9Kyj2X7
	 Rl1lPw1XLg7pVS1EZl0XvCGxuqU8piUaDbjq24pYU+A9vebpsOv/9YERGKcJD0nQCGlmqGKbcvCM
	 6kJnsq2tUBag9YGrd6WZcTI7voyfn0yfVPN0tvPch2t5j7HKAYtj/+YAQbOCy5xES5e9f6
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
Subject: [PATCH net v3 3/4] net: mptcp: reject token 0 in mptcp_token_get_sock()
Date: Sat, 14 Nov 2026 21:09:26 +0800
X-OQ-MSGID: <20261114130927.91839-4-2122295973@qq.com>
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

Token 0 is never assigned to a connection: __token_bucket_busy() treats
it as busy.  It is, however, the value mptcp_token_destroy() stores into a
socket that is being torn down, and the value a freshly allocated msk
holds until it is hashed.

Both validations in mptcp_token_get_sock() compare the socket's token
with the requested one, so for a request for token 0 they cannot tell a
match apart from a socket whose token has just been cleared.  With
SLAB_TYPESAFE_BY_RCU the same is true for a socket whose memory has
already been reused by a new msk that has not been hashed yet.

The token comes from the wire: mptcp_parse_option() copies the MP_JOIN
SYN token without validating it.  A lookup for token 0 can therefore
return a dying or half-initialised msk, which subflow_token_join_request()
then hands to mptcp_pm_get_local_id() and, when the subflow uses a
different source port, to mptcp_pm_announced_has_ssk(), which walks
msk->pm.anno_list.  That list is only initialised later, from
mptcp_pm_data_init().

Reject token 0 before walking the chain.

Fixes: 2c5ebd001d4f ("mptcp: refactor token container")
Cc: stable@vger.kernel.org
Signed-off-by: Hang Nan <2122295973@qq.com>
---
 net/mptcp/token.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 3429b43a9f7c..8a603fc8dc05 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -299,6 +299,10 @@ struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token)
 	struct mptcp_sock *msk;
 	struct sock *sk;
 
+	/* Token 0 is never assigned, but is what a torn down socket holds. */
+	if (!token)
+		return NULL;
+
 	rcu_read_lock();
 	bucket = token_bucket(token);
 
-- 
2.47.3

