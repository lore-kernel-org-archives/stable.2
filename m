Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794519147;
	b=p+0rYXMq3qzCK174JTG4IXIfE9DgDwOoDu9gI85JqI2Y7knEhxffY2H8JMC+qzwA4Ybf
	 3DAEWFP+g6Ljpa+ovWlPB2xGpxvw5HfKKXiJzto3qvAbyqWysN4DUu93nBemk9/zLPAIA
	 a2s3PT7hwIWVl7p0pzBuyJ5MP3S32LN26lWhabA/r4KpI+80MOla0x0KHSVGp5TM26TBe
	 aSQZh4gPhRsOTyzXpx8TEHrCWUG8BPtQo47P/f/w5HDYqL7Q/rP0LeR6yEsvA88PptEnJ
	 UM6eRBGAqBhphKkhh72cB449kQVu+y22gqtJrwfboAmSHJ0HQhj0KYcbWldyfl5ZP8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519147;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aZzeYCyAJBeLRT7TcBnHWQ7RP0GX2clQIvp0IYxDGls=;
	b=EmqPxKYTwiM/8p6u53ElS0zVhruezLCdaNmkrZNxAAJU3WbdssDPLAykc6d5nz3kkmH6
	 GApsj15tdefiC1Q/y/S0JrMSEl8k3jLM/7aEx/ofRoZkp/HxihnEpILecih5NhQRqU2wi
	 YEPaLM4ZVeC9q+EYo7+N5wowDgaTJFTuu7Gx/CPtcFakS9mDeCpUJTMJD1Bi6JXd8yLBR
	 tuBPTQGPg0Jm0Uwff6lgeusWg7cZVBYA899B74ki+WSTdYhz2UNCJ+iSAPuTMEiYFelF6
	 S4uphRNPRsCW7FgWiV5aZL7GhDkmwzY69Pnz5EtPj2P9R3KKbfh/Y/lqafC0fGXJfQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gma6Pdh0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92EA606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gma6Pdh0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34BF1F000C4;
	Thu, 12 Nov 2026 21:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794519147;
	bh=aZzeYCyAJBeLRT7TcBnHWQ7RP0GX2clQIvp0IYxDGls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gma6Pdh0WvwzZpGBuNqsS2Y47aYj85+tV6ZE4NfS0rYkzc2ByCsIz+gEzo6w9iXW6
	 IfprcO9PXs3Vmf56cTx2DK9Gin8LlgrP3MF8UiuYr/ZtIwBh5T4yYZYAz6EvSKYaWb
	 YbJN3en0YwVFkbMFqWB9tRpHbD2enNWoCC4F1CJKCa1cCLiJh/UI3aazsfNtGmmQme
	 CQbxZp8QA7c71xexj/VSA4UEXeSvmQGhaM3RbWR2VuNQDw2Ntj9rlag+gHoQPwftAl
	 ylCoaUCJy8KThfbll6VbSAbIwtRjQ3mwsMmXIQD9vGb/D0e+w3NKb0qCgbOeMtUdzT
	 kzznRfVHSgIOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mptcp: pm: kernel: use RCU to free endpoint listeners
Date: Thu, 12 Nov 2026 16:32:25 -0500
Message-ID: <20261112213129.3829777-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201446-failed-6.6-49b09ae0bf57@kernel.org>
References: <20261109201446-failed-6.6-49b09ae0bf57@kernel.org>
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

From: Kyle Zeng <kylebot@openai.com>

[ Upstream commit 49b09ae0bf57b4230187d4cdd0a370558e44a6e8 ]

mptcp_pm_nl_create_listen_socket() starts the TCP listener directly
instead of going through mptcp_listen(). It consequently misses setting
SOCK_RCU_FREE on the parent MPTCP socket.

tcp_child_process() can invoke the listener's subflow_data_ready()
callback without holding the MPTCP parent lock or a reference to the
parent. An authenticated MP_JOIN racing with endpoint teardown can
therefore access the parent after its last reference has been dropped.
The ADD_ADDR error path can also close an already published listener.

Set SOCK_RCU_FREE before __inet_listen_sk() publishes the TCP listener,
matching mptcp_listen(). This protects the parent on every subsequent
close path, including a failed endpoint addition.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20261030042255.74216-1-kylebot@openai.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ sashal: redirected the unchanged hunk to the original path-manager source file because the code had not been moved ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8eb7fed89d6fc..81d78a5121fb1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1273,6 +1273,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	 * old status is known (TCP_CLOSE).
 	 */
 	inet_sk_state_store(newsk, TCP_LISTEN);
+	sock_set_flag(newsk, SOCK_RCU_FREE);
 	lock_sock(ssk);
 	WRITE_ONCE(mptcp_subflow_ctx(ssk)->pm_listener, true);
 	err = __inet_listen_sk(ssk, backlog);
-- 
2.53.0

