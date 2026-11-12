Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794519916;
	b=yDPojzqyIh/Vowg2yxMXCzJ6TcPImABt4U54PGc5zooVvnxIvFLUvwqlhOtDA3fJsMAc
	 4H2XzB7foazf0nEiuaWDNYMW7knaK7nupP6l0mZhsnTkeykBNTbl24Q+8i2PIjVapICqb
	 gZvgnr2wMjiJGesNp0e7m1Ff4Q1f+zo03/oqczB5HEhT2GjR/islQNBb89PPIgSK0yJ3P
	 VWd+CQYwq6+75++1JEpKBEGK8QC6Ew/Zen3VcSDTijLhYt4nt1awZBewW5Gbkzh+A9bSM
	 EreUHqrHIKQFNXKaYheVYay4pSnceZZZZ/dgTlDp5DtBGOr8BDUHlcgeJ++j710rCnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519916;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+toVekQ7IBLFUV1IQchefXrt+LtBnlhqaYtPpyQwKK8=;
	b=tL0pHx5DxI95AFYcP3ioLQgz+ivIwmhXjM6XbeWzWC0BLWi2ZEWQv057STJKucdfgu7N
	 VInDeTEJOx1ijoKRaOMiyhjoladQgthlNZdiRjXg59uzxW2MoDYq2JAfhmnSFKSpaxgtv
	 CENHvR+KpaugL6rhtb6N2TIMcxcHNUJRgyhBiX+d8/kWr0+OczWB7osmmxUoiwQcsriC1
	 vEyrGphxUtcO6zhKfc7v6rbarAKjTsLF7xTk90fPyjiuhPyD6H5zfn9PQ23FHWMpYp6ZW
	 u3hT1PkdYHFV4uly3H8QRIWjSeQqOYshjIRMZsuK2Hzm6BkZ3gux0sX26OUN1dD3iVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xxf0zD5j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B242606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xxf0zD5j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507301F000C4;
	Thu, 12 Nov 2026 21:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794519915;
	bh=+toVekQ7IBLFUV1IQchefXrt+LtBnlhqaYtPpyQwKK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xxf0zD5jv6IuS5P/W8VXSMlSCAkYzdmLJ3ZsG4llphUis7Ced7pB6Q5QdVRio6KfA
	 P9S0oXzoet/NHJWGbvzp7sGJ4bEL56mXwqXNkF7IYlNZlOnNy5euJQHhlnj+yJDB4m
	 k0GBSE9M+KDh5Sts8B4rhqUUql/IHCuCvVJz5ikviXdUlh6NwnsNFS28l/Aj7gXT9U
	 Nm/+tL+JNkSbc/OKxrL14NWs+7YSQP+uPRQaG06E6KjPjspDlaeR7pPOU2RsqDI4kk
	 kzA4rbmobUlQ4X2Qi08tx6hoDT+xfuwo/Sqy+dWYGsnXBl/RD23QMAI1Hj8e+wgDX9
	 AxoIg02ms6tfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: pm: kernel: use RCU to free endpoint listeners
Date: Thu, 12 Nov 2026 16:45:13 -0500
Message-ID: <20261112214412.3870882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201949-failed-6.1-49b09ae0bf57@kernel.org>
References: <20261109201949-failed-6.1-49b09ae0bf57@kernel.org>
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
[ sashal: adjusted listener-creation context for kernel_listen() instead of __inet_listen_sk() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 05fb4d43187ad..a618ebbc42b09 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1261,6 +1261,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	}
 
 	inet_sk_state_store(newsk, TCP_LISTEN);
+	sock_set_flag(newsk, SOCK_RCU_FREE);
 	WRITE_ONCE(mptcp_subflow_ctx(ssock->sk)->pm_listener, true);
 	err = kernel_listen(ssock, backlog);
 	if (err) {
-- 
2.53.0

