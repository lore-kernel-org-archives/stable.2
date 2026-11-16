Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841125;
	b=mHc93rfIJnMrcQeqm3w8JwigjjZi4QzXCNCnuXGsm/ib+kcoAoxHOVqpSaif3S+gxF7K
	 2HxyeM6By5OeHH1jxe0u1wjDveeEYCRqnoqJVd6VnUXzRz1JdA48SpcWKSzmZ77wW5Un5
	 dv8roiCuJjm8HOmRst7qAnUK8tnJfFRZmNthoWnreF0/oxgTU+cGdy5ykpvs0rPMs28tl
	 jGdukKu0aRCFJ1U+mJNoXKjPKlvN4ETqPIKdksAf+QV1JP6z0NSR6X2GnkbvlmVLYFdud
	 vQ+KRU0KMI8/uEavwBwz8/MtkPQBgvNC9cN3urc82j3P4nmiDiMGhE64qhJtz1mo15A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841125;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ElzVof/GVpIU9AskS2neeJrmrBfHGGZnOYV+7K82ykM=;
	b=IlewA7a+l7Y390ME3ECmhM+GDwQA7GHUMVVmMUpIaVR6KHlhRTnRCOJ2NrnD6MFMFBGQ
	 eUdBofnJBuvz1+vidVgGoO8ltKoUt+RUPYr7ZwVYuJWFpTRZbF7pFUdfIGYVLPX3vE703
	 3++1BqHWvHuj3Btei/TQcuzzabYlCUPqUFsIvVTIHzSamWSh7i/xhimtaJhyK5RPVhQuR
	 MEK7hzOzlY4vuR22PQsypCgtSPlZcb3Zi/up6zInRTu/zpDI75qorkRt3wWVbjHejCFxs
	 Qugj33TXHQn8vDwggMD7EXQgpGFvymqoDi4cZBR+GE7DMwU73LCQg0/lPwo0CNoLVNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=CIcWMdfH;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91A5606A8BD;
	Mon, 16 Nov 2026 14:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D91A5606A8BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=CIcWMdfH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794841120; bh=ElzVof/GVpIU9AskS2neeJrmrBfHGGZnOYV+7K82ykM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CIcWMdfHsUR/U80L3s7Lkav20ldEL8nXlgSWDB6gB0mIeaZTKPHMO2rTYXhAVnmq6
	 AML//SSjEtG1ZtqBqXQVbD+vmzChV6dyRIuDkZiSc0WtBDPnIpD2tsKhKY1gBTCWT/
	 klNJo03RnlxSaVGDlIUKumURY4lUvISGuVoeDA0w=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:2979:aa1c:9ec4:8698])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E9E14C42; Mon, 16 Nov 2026 22:58:30 +0800
X-QQ-mid: xmsmtpt1794841116tggf18dk0
Message-ID: <tencent_46FC62D4DE8FB8E6C90049F5AB28BDAA8C05@qq.com>
X-QQ-XMAILINFO: NG/xSrbj0lIQSMUD/+QNuMQGD5daRrLnmMzKd4bVoixmm4MoTnqMfQavP2PPyL
	 D2vXLAgk+RAs13qvqWo6gp7Qt51zInk6ia0UYmgqxZcf2ihIouqMLUhf/CFwAnx0NCDaEUT4gLNR
	 FY3MI6eDAkF1Xxm/YznU89VZGBXoy+nMclsbRj0mgEO2Zn+o2XvHEH9stnELZEW8rtxrVC+8NVVx
	 nb/xlV4nXdYbMGzbMb+Z63xwV9zBn2+Kw1zGaC/C6FdE57Mmew+ZKDKpU0IztN8SNOD3h2dvX29X
	 7OcafZ89XZ7fyN3hhuwM78BqT5fGVm6l6ssRrhCZULw5TZZ4IkYBxi6pYgeP/WKVPIUMaiA+V339
	 CFkHCPtqxz7rIsqLn5SrZ1Cmo1QwK8ykAIYgGtDpxKjTtQobtt206K29uQAlKPS1J6IXx2hKwdhe
	 T2iW7DN/OgsdkdPatO5nr6GMgZHa6x+qEjOZut4937KTfUBp+UbuvR8eH9ivG66+hKoVy4phQeTe
	 F4YlbtZJGXXK3LSRL/RPxrU49eg0RSH4lSENh/DQewPtYk8pOAq9bEB6rLFh1+nD+JrzDnDV9/Sm
	 pqLQ9qJNPzHy9969jlT2o0BD9JnuKgvYuG8iWJ6uTL5VaBQ4adR8v5TyBrN6ZJHdQwmzCICD8hwP
	 AhwDLrWzK75jjFE9o65d56KdJjxHZ/nPgNz8feIh0/Sq8dbo3bpZBuG7HdwOGmvk02KaXKEe+ox8
	 phj8chP8QGWi3aWZINN9TC5Pi4UqCQmicEBgYsmJsh9cNOg85vDGXL1E1H/DsV266LOHAies+yWj
	 xkPS8QgafpmYct1EmYF91vKhZkoFhR2Qjwx8e90pzoXeHwmm6AvFqPK6Aq1QKWqV/qzW2NRXMh/v
	 +X8Id+EBDWXKZPAHjQWg3/VifAY78vO518NJEQVhtp2r+2/btALNFvzakrXa+pkbN9KRYeBQw37Q
	 mN/vGqoUWy1ay5Vzqu+RCSUCil2MJ18klTjPcr0Kg+DQYtaTM5t9tOeTROZjWOZdy1THE+Om/VgS
	 5TM20WhU+tlXrIaj5uDQhMq6Qfl00ZGSTQfM49Wc/sPyFxy6N8qb22V2cuGGuHwsbafn3FhpTOMi
	 sCXzdWNedvfISpVFonp9mOQHbUSElp6yoJx0JRJloCA05sEY34iEJaivNqP2ZhZ8DS5xgstcfE2H
	 +A4iQ=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
Subject: [PATCH net v5 2/3] net: mptcp: reject token 0 in mptcp_token_get_sock()
Date: Mon, 16 Nov 2026 22:58:28 +0800
X-OQ-MSGID: <20261116145829.96849-3-2122295973@qq.com>
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

Reject token 0 before walking the chain.  The new KUnit case builds the
state such a socket presents to a reader - hashed, carrying token 0 - and
checks that the lookup does not return it; it fails without the guard.

Fixes: 2c5ebd001d4f ("mptcp: refactor token container")
Cc: stable@vger.kernel.org
Signed-off-by: Hang Nan <2122295973@qq.com>
---
 net/mptcp/token.c      |  4 ++++
 net/mptcp/token_test.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

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
 
diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
index be9acce8a567..2418d392ff7b 100644
--- a/net/mptcp/token_test.c
+++ b/net/mptcp/token_test.c
@@ -132,11 +132,62 @@ static void mptcp_token_test_destroyed(struct kunit *test)
 	mptcp_token_destroy(msk);
 }
 
+static void mptcp_token_test_zero(struct kunit *test)
+{
+	struct mptcp_subflow_request_sock *req = build_req_sock(test);
+	struct mptcp_sock *msk = build_msk(test);
+	struct mptcp_sock *null_msk = NULL;
+	u32 token = 0;
+	int i;
+
+	/* An empty chain does not answer a lookup for token 0 either. */
+	KUNIT_EXPECT_PTR_EQ(test, null_msk, mptcp_token_get_sock(&init_net, 0));
+
+	/* Build the state a socket being torn down, or one that has just been
+	 * allocated, presents to a reader: hashed and carrying token 0.  A
+	 * lookup for token 0 only reaches a socket that hashes to bucket 0,
+	 * and the token a connection gets is random, so retry until one lands
+	 * there; mptcp_token_exists() reports that without going through the
+	 * guarded lookup.
+	 */
+	for (i = 0; i < (1 << 20); i++) {
+		/* the token is derived from local_key, so vary it */
+		mptcp_subflow_rsk((struct request_sock *)req)->local_key = i + 1;
+
+		if (mptcp_token_new_request((struct request_sock *)req))
+			continue;
+
+		token = req->token;
+		msk->token = token;
+		if (!mptcp_token_accept(req, msk))
+			continue;
+
+		WRITE_ONCE(msk->token, 0);
+		if (mptcp_token_exists(0))
+			break;
+
+		WRITE_ONCE(msk->token, token);
+		mptcp_token_destroy(msk);
+		token = 0;
+	}
+	KUNIT_ASSERT_LT(test, i, 1 << 20);
+	KUNIT_ASSERT_NE(test, token, 0);
+
+	/* msk is hashed in bucket 0 with token 0: the lookup must not
+	 * return it, even though both of its checks would now compare 0
+	 * with 0.
+	 */
+	KUNIT_EXPECT_PTR_EQ(test, null_msk, mptcp_token_get_sock(&init_net, 0));
+
+	mptcp_token_destroy(msk);
+}
+
 static struct kunit_case mptcp_token_test_cases[] = {
 	KUNIT_CASE(mptcp_token_test_req_basic),
 	KUNIT_CASE(mptcp_token_test_msk_basic),
 	KUNIT_CASE(mptcp_token_test_accept),
 	KUNIT_CASE(mptcp_token_test_destroyed),
+	KUNIT_CASE(mptcp_token_test_zero),
 	{}
 };
 
-- 
2.47.3

