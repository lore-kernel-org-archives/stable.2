Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273591;
	b=sgMEBKnB8K6zQBwz2cB9wGKpJ+N1WVvNs4UYyVB4QBsNqua9UUHSsrA9jvjPGTnud8+l
	 VHb+cppHWxPJHgoAZ/ZA79MqLRrlhY0NmyvTnTEUeh+tALZ+vro7IUbHjNLEOEQO3sPYL
	 +BxJAs+0h1fGstvf0r6hvZ/OflVH7TlswBImSR99qenSnu1KWTbvbrPUE0J9r65nXbZxm
	 Tfkbv3syeeqCdqxjhp83o7rYrwDIVa4HlWjH11aLwq6tcpIrnCLXw2MR+fL4btpb46X8u
	 /PNrxibZoUnL7nOmI7DFiNZy751XfY3U2JpAHLYc3nRCUDk486oZXe/nO++lSmRiVZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273591;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QD9yBGn+tDF0mr/ojccIRckXVs5vU708t29lNBL6WwA=;
	b=hi3vvmq642Yq1FW/+WEB8i/KjfVSItkgdl7+d1hikjIkc9V8QVjQluULmTKiAzNJ/r4U
	 EVsKpQaHfZVjdYeN4rUc9favTWhWxJ6Khhv/88zXr0E830INlARcS1wuWk5ArIUxW1K3a
	 AvZNN/eLaLBXuhVgknTbvqBd/KI0GYVczN4dM0UOjuqXV/BQ1QsjnMxPw6jyvFgdAqD23
	 +wjD5S8LHuzB2vCa2/HwRjbAOZqT50ErdBZAreniKrPKARxsuacG6iiYhUF653l/M/SpP
	 0XklrtYVqaG9kjp09FwJC8f3S6Ju0oJn+Tv0/rc0jg6N+WQXwfkJ9DNTLuXTRGQyx2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k/e/Jd+Q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA69606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k/e/Jd+Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA421F008A6;
	Tue, 10 Nov 2026 01:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273591;
	bh=QD9yBGn+tDF0mr/ojccIRckXVs5vU708t29lNBL6WwA=;
	h=From:To:Cc:Subject:Date;
	b=k/e/Jd+QuZrzK8En8Juv2PbOT71Qv2FEdDfPvHFw73RgbnPDB6N5GuhwSBAUfNnmr
	 xeJELcdcA6aGsYRiqUWB5CAe+ww6V+wacJy7GF+92mq0yzWcTRuDugj8wNGQrjPuro
	 eIAE63eXTJGZb90q2jPR+paDEk4SN9rH0J4qBG1D5e9IY6xqKojhuik6kmtlu/0Pwu
	 rVGdn6ygTl2AV8QxFU10mGNdb2/G5Go/Sfvy7KyTLCsS70M3CiZPbZM3qeIo0yvrDr
	 PHS08ayXvEjBMZeAFBYg6YzF8C9yUOsVMxashwtRUBmmcUO7Uw6CZC7eMpKtL+OnBm
	 BXZm/kMJkr5WQ==
From: Sasha Levin <sashal@kernel.org>
To: kylebot@openai.com,
	matttbe@kernel.org,
	pabeni@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mptcp: pm: kernel: use RCU to free endpoint listeners" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:19:49 -0500
Message-ID: <20261109201949-failed-6.1-49b09ae0bf57@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 49b09ae0bf57b4230187d4cdd0a370558e44a6e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201949-failed-6.1-49b09ae0bf57@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




