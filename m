Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273892;
	b=SoNMnB8uLnGbDUOggfflDjzmh1J7Kt6aI+AHOsp0FHap2fFlAkG3fY6Cgne5uGzryvP4
	 trVivLI6yizb3/ZMmgZeQ8F8sOX+XaGfaSh3MXi6ICgYT7ESTBQaQOFbTHmLdfF7ibIKw
	 jsbnFKsOP1tnbVJ7W41C8+TYrDnUL3gmAW03ER1TF2roiiAFD3AtzXnVRuNuIzhMswBTS
	 Dt3fUIqR5EmOmh39Y9DhVCgS5nfmRHBfnn+kxaQUXpyI9c9N/sIchBaMghICs8vlfrtbR
	 vGIwhYA5HMHzkBvM5q7ImlCZzwFuUVxnDijRPaM+uYW+9DUgRy7ycm97vFZuBq/wlQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273892;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VMRJDsizkCliTPgYUv9N9trYSD/O/bH5jmkJyjsm+2A=;
	b=l4IttzV8vMT0UIDSHBN5IGoL5kmkc14lNMIOqe4VK0iMBGfe0g+++vxk8M8VEeX+Ix/1
	 G4YTI2gV6vjZLkhaIi2J+dj6mKdIi/2IPzSqf19NRiRcPvWXO0Dis7qIobPVyUN5z4DnP
	 1QlzctpKsgYg7jgwRL89+VZuSHGC8va5MvcPcCIpKc+1vN3/hVk+rPxJIyZrpo0h/uqja
	 nmp7BEPgMB8uwaFtuMXsSDYdw9yjzMZ5eOuZy3SjhyaCe2WqqOHPCXFRjM2YMiv1hzVjy
	 6E0yo3rFsaJtYOcO7/mpM8A6pnRgRcGMn/qPSsTFdNNwa8kdQPvI6H7cIl0JoTw4bEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1KljhYT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFE2606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1KljhYT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601DE1F0089F;
	Tue, 10 Nov 2026 01:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273892;
	bh=VMRJDsizkCliTPgYUv9N9trYSD/O/bH5jmkJyjsm+2A=;
	h=From:To:Cc:Subject:Date;
	b=P1KljhYTUSnk4Dvt7hyABORUWWrbrUoxM/o1hzq4ZoSApzcvYbLK8XSUPXo0bAdQI
	 wPPJs4xgSvUu8olpJr4X/T8583DFs8KViOLOEdi6m/G/d2BHiYBXjNXYQN3ZXzFFIe
	 /QA+/dozRUBczltNgejyg5WPtie4x5wMQGxTPw0ZkYL44dAbMcnqihAAr7H7veTfrs
	 dft2nYc7rUpTGBqEX2IVuVZZJ9kgmP/ZQaqVnqWJdTfw6nwpB8+KGdDOAJvkFWEo9j
	 +Gjfn/5yxjCWZF8X/fgN5r+3Qtwzmn/Gsv6g2vivefBNEaXPzjhLm4dWeGOjNdrWiy
	 +fYtUPDYXUq/Q==
From: Sasha Levin <sashal@kernel.org>
To: kylebot@openai.com,
	matttbe@kernel.org,
	pabeni@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mptcp: pm: kernel: use RCU to free endpoint listeners" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:50 -0500
Message-ID: <20261109202450-failed-5.15-49b09ae0bf57@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 49b09ae0bf57b4230187d4cdd0a370558e44a6e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202450-failed-5.15-49b09ae0bf57@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




