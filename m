Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520669;
	b=MhWCU1mhwUSc0xNV6ymZh54nDyEJq/gvqJ2vCNkoxtGel1sz2SWc8O4vAOLoP1+Dz0Uy
	 NgM4L0hoyVF3h72o2pgYfS8jmQp6fuUd1nalxoawFRIuBkOQPKbNf3K0m/ipTuRbdQiAr
	 u3jR+s3htAULskeJnGsaRTLvdYbc4nMsgOaS6it7hEHzjsQTfUUdpa4GUwwTzNRHATO71
	 yTLLSRFzhBbOKxgyOWcccabHEnf5YlL1CfhGW0jpUkef8/5nSWzIi4Wu1pgLRI6V1tAI+
	 8RRPaCV7HzQLy4pKBWWDxoBd8FadIk8avYVht+1GPFalRoHdicbKAfHnEIiXzCpzAkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520669;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YIcAatM9lLgopjMYOpAidm6KFqZNJ7St4aXap4jyYYI=;
	b=CgLgRXfuNLFZJdCMxMfpx6ViItI0PGQWDYbxcfUOxn5ehf2J5jpTpFTf8kVAfWQUEu2M
	 GfmWXGmWY1218MAm/5s/anUTYy3QKv7kiXoPz5bl2VTGS/eTqd98TVoPONfmNMnD+bMjq
	 L+ByUSSWX8f+MH4EtTxlwRFmXjxTdOSsj47lkVjKUzxE86tFrK2roynlBHOs6ysbS/+A2
	 ylwb3tohBYisncO5axNjedPuDCtM+MCM5Wq4S1M7LZQCkjWnDKrQHn9ptJNS+IFxd6Aau
	 0J5OscSW2GByVdXEbVzVkffFIW5wxwjBH4lvCudMUqZDk/JCD4SomiaMfDelXeR9MGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6LOEh56;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6718D606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6LOEh56
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583A41F000C4;
	Thu, 12 Nov 2026 21:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794520668;
	bh=YIcAatM9lLgopjMYOpAidm6KFqZNJ7St4aXap4jyYYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T6LOEh56YVH834FEfLKaO5TVzqoenYRpdAbNtDgt8cQQDiTQTpDZr0skuRuF/gh1Z
	 uqaDgDyBJUSFZ+0OHlt1dIEHgSNqPTpb1O8zo/8Ep2R6OK8DZqRuV51Du7u1JJg5J7
	 tK6vutLrUqfOp+uQMHTy6fVhdCJ7Ct31cyGDI6I2YAcCYux7n7dQRjrzurqJwb5UMK
	 WaUki+78/VSYFvd3cLTn7vqNIhRMBs5mOZAILOeOhnxx9m3S67myFhUVr3xtLFZi0u
	 /SMU6e4uwjdEK3pv/2LK3aRunEFGWPegfAWKUJMpIXbXHKM0L2bJ0jR0UZaGa1Bz9y
	 IuKp0ig9ZEnbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mptcp: pm: kernel: use RCU to free endpoint listeners
Date: Thu, 12 Nov 2026 16:57:46 -0500
Message-ID: <20261112215659.3919615-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202450-failed-5.15-49b09ae0bf57@kernel.org>
References: <20261109202450-failed-5.15-49b09ae0bf57@kernel.org>
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
[ sashal: adjusted context to insert the flag before kernel_listen() instead of __inet_listen_sk() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e912615e008f3..b748558fd27eb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1111,6 +1111,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 		goto out;
 	}
 
+	sock_set_flag(newsk, SOCK_RCU_FREE);
 	WRITE_ONCE(mptcp_subflow_ctx(ssock->sk)->pm_listener, true);
 	err = kernel_listen(ssock, backlog);
 	if (err) {
-- 
2.53.0

