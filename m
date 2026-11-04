Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796813;
	b=FjzmTNCv6Vpu3QWMI2HP1qDD9vyIlt9cAMaTliDuI9pXqHk6CLbJXtwogJGAPb7MU8RX
	 4UgFXC3UTtr1lkp1g9AfPy5GdzDpffxDlfQcBmfN/7l37+9NGzXVykwd0/N3IcBOu0h4N
	 qS+Ux0qsTG+aZJ27QY48bW19eyIyiEKjPNrL/v/aUIWnPX5P3JgM4LZrpO9a6G1ihnlnJ
	 DZKEwaRaRyhjhTLktW3yzTonk1sRAMipxN8qhnzmv84HSQAogoCBOz8rlwrAP9joBLbvx
	 9R/8T31I3VD2pZS1RQeG0wOJS4aGP2toVeqNtwzQKwe0SyVeVARrhFyQDDmu3sup41g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796813;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=meHZgaDP7EQiThPb7VSaVkGbruiJlqoO7IqqSO1qRl8=;
	b=acwYH4ggij3JY/P5RSni7ujkKyrtEGAURXx0J4NUUwIbo93ljmWW6n3vsFJxWl3WWn3f
	 YF1TSHQsVvxoiDoPuRdMBf3Daj/m3/r1oxXWHAaKKVqMOrBck/7a1gRXZhgCmNaBFGTZq
	 kNyWOyUpxmGrKKB6ex3EjVG7luMLlCGAbQaAw1CAZdRpQLlv54IiNZgJfujMAwutjMrOc
	 TGJ1wmFiBuWLliMXwHbQOAQTUHIisyTf77xyFhhsEwAHy/yp3kYqyI0Oyd1CPFMxCEwKU
	 t5i4vGAnwsuaX5mqVAnThsEWe8ryA3DAVhCnEM///Xhx3+7BIk+DRfsy2WAWt32RY2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJPzqgEi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A58E606A31B;
	Wed,  4 Nov 2026 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJPzqgEi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1351F000C1;
	Wed,  4 Nov 2026 12:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793796813;
	bh=meHZgaDP7EQiThPb7VSaVkGbruiJlqoO7IqqSO1qRl8=;
	h=From:To:Cc:Subject:Date;
	b=FJPzqgEigSwBUn3vJ610F8fcOPTq18NopjcREO+GC3sNLA6jiRQYq2JNwQbdKR8i4
	 mRQbkddaUeuQaolIX28eEqOyVgJPqQs64fByk8ea6an23FXkEebctmYWlqiasvmA2v
	 NACBGbuWzYcRAU8TYFai/YdtpvDrbhm+HPp+9VGzpCuxiipKa7DUwAgwmEysF7lcdq
	 KipteTg7pacU5VjrYolTm+uCzLF/uuYac/Fmb/l1GsxBBUxxkyllqAe2s15kKf29Sn
	 9VhDjyzk+wAC/yYzr6vkLHG69OpizI8xmd/1ZKnSIZdBHCQzdJ4kZxcAUaGShAy3RS
	 FAIdv4Y1pt4ug==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net] mptcp: pm: kernel: use RCU to free endpoint listeners
Date: Wed,  4 Nov 2026 13:53:27 +0100
Message-ID: <20261104125327.1041456-1-edumazet@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

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
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/mptcp/pm_kernel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1a7750813235..f7396628490e 100644
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

