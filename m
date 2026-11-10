Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273288;
	b=vtJVEanycXPo/IZa9WTAruiQuQT1S85Xn0W/U0hrpaRvt+dXgmG5W/Wpo/R4YNxTneLV
	 56nsuncI3W6/RqWYBom3lAb47hzRDPFtV/9E4Nvspq2TXPNpXXdVMEovzFMcGrbGch/ja
	 bHvCKAoE/WlBOgh6Lxp863ExD/f+B71IP6DBGKy06RYXD/CnmVWQ4R198nN3ZTRqHWEKO
	 RsgSgr8nRyfUtUfwl/wr4jPcgSRYnsAWYV+b6mY7CqjE4Scz53cfW9qfvRdcV4ZsyZyg6
	 yCcbTuTmCpjRBjxjjlkfrrE9TJW8ze7jvtsfplma02G5p27tRUFj1NK4mApMC6gK6cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273288;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lqhMMWKXpcP1B9MSKlpKrjhqNky4QXFHbXTnaxF1rYk=;
	b=KPIVQPF8z5mtMUeR3UyBTqzrxvk/Q2kywrt4L5xjsCWwE4Ab8gUx8JcsxCO93dDU6qxL
	 KS7Yc3WmR95WE3oiar7SlGT5ELVicadNdvDu+5seKqT3dwQR3j9uasH5TdUrV91wTmzBk
	 CVVaqaIoZSpl4bPeUYm9X7tuL6bV6vz6AGdOVgZhRKnDakIDjHcSnOvNkLxiUqzmTidBo
	 yGUbLybYzTFa4WkDgE6UwQhDCgyoTcqK1eI/L+ZJe5IRpnMeScMJIan3NJ+F/nbkQu5LX
	 L0nzvBUeWWcMV5/RrpRHObsoVDusrPiTj05KNw8usoojiZMkwT3XcgfT3Pd+w9L+y6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBj8j7Qu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23815606A332
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBj8j7Qu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393DE1F0089F;
	Tue, 10 Nov 2026 01:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273287;
	bh=lqhMMWKXpcP1B9MSKlpKrjhqNky4QXFHbXTnaxF1rYk=;
	h=From:To:Cc:Subject:Date;
	b=RBj8j7Qu+CGkWfVDKE+qcaoEwU5oaAX739cRP9CVYrrRiuFptKIEF1WGXFiNdsaf+
	 RmTte521N0PwiLIlQyjtpB17bex9bn8QIUtJJPByzmARvoEyoGg2F3+J3qRwqQEk0I
	 2PP91unEYBj4qnVmGfSAmxJv8ts+Ou8NabeJRQtojCGIrxmHesZ06eVvR3t3+O1UI3
	 dbdtsJ8azCquYAGwzFmKV/NW8r3KQzDnOdS+t6vL+G59+UtwlW3Nc3It99H7gu7ipH
	 dKHO4l9BtytHZ5BeXOte0Ff4GaWLzZ/YinNwFzp8kTdSRQ+sNihGB4rnw3JxYvuPgi
	 3DYQniXBhJGsQ==
From: Sasha Levin <sashal@kernel.org>
To: kylebot@openai.com,
	matttbe@kernel.org,
	pabeni@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mptcp: pm: kernel: use RCU to free endpoint listeners" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:14:46 -0500
Message-ID: <20261109201446-failed-6.6-49b09ae0bf57@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 49b09ae0bf57b4230187d4cdd0a370558e44a6e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201446-failed-6.6-49b09ae0bf57@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 49b09ae0bf57b4230187d4cdd0a370558e44a6e8 Mon Sep 17 00:00:00 2001
From: Kyle Zeng <kylebot@openai.com>
Date: Thu, 29 Oct 2026 21:22:55 -0700
Subject: [PATCH] mptcp: pm: kernel: use RCU to free endpoint listeners

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
---
 net/mptcp/pm_kernel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1a77508132354..f7396628490e3 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -906,6 +906,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	 * old status is known (TCP_CLOSE).
 	 */
 	inet_sk_state_store(newsk, TCP_LISTEN);
+	sock_set_flag(newsk, SOCK_RCU_FREE);
 	lock_sock(ssk);
 	WRITE_ONCE(mptcp_subflow_ctx(ssk)->pm_listener, true);
 	err = __inet_listen_sk(ssk, backlog);
-- 
2.53.0




