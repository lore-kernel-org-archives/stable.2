Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436121;
	b=SWdxdvYeXWbHHYA5Elw1P21GfJwrT9YtMJ1mXWwm9MllvnHzMRx90DQy1sR9LGci3p1U
	 85/CWSHLTyobbSPpcLo3XV6EydN7KIS7gOQ/kEU30Nl+hmhMyliawxkLQhgsShPJ3WCYf
	 JdiUisnpf2HEXphZWVjyYSaPjMmKP0ww2D1TIapOq6iNuxF4DZCNNr10keRsCSRiCTFIj
	 GzmopIqRS5gMCe5b3OCAi1F8ZUFFn791evhbyNt7nYBlK1e2nyXHaOZFwLcrTLyUTBYMi
	 +TMMkm2TdAhz7Ylsi5Lcl+P+dvBv9Guoc61jb7NHn6a/j7ZtBzNMUPgSH+yHPZ7Ffyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YMGKjMwOlq6w5EX55Ph8mpyGT/IFXfzZRRGc1xWK8zc=;
	b=yoAACkH994kLdHEdZ9n+Ghlg1VuNO72+vAKqQskBlwbqVckyxVnrTyX3mwN2cO76nGcd
	 EEedVdz0h55YI8z+Sag007SXIFlWmsQoywogrXfiuVXwLxiBUyG1Uzdh6h2sAMK+QVAv4
	 zU4LFuXOuO7C8RB3OoGwLVh8jz8iq2QONQF6Qhovu5Ky7htocmNQnpS3aoiYgDE3utTvE
	 Ww5z2EObnyBuL4Nkfsb49T3P+kvBDyrbNtIBaB9FtWMlNaGMWDIgtWV9GRohwclI/F0P2
	 Js4xJfhz//J8YvZenrDO7dRVNzzqgSdjJoEu/k1JCZ8/LC0lGhIpwLTVs9Z8dffgAeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j08Wgyu6;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB5606A31E
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37EB5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j08Wgyu6
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35d7fa491deso2969567eec.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792436120; x=1793040920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YMGKjMwOlq6w5EX55Ph8mpyGT/IFXfzZRRGc1xWK8zc=;
        b=j08Wgyu6ZSHRLrSSdjYv2GGTpLTtc7yh50UE8WwfcKzC47piQDB+kPqHFHxa2Yaqzi
         QajV12YA8PfMFQf22JSieFfqIZmGJ3Q/D4RMagOu9ILHZecB8coOlqNsRkBAxHF7Cbx4
         y1FiwQ8jqT8X2MDkrtUeMSlrXd5JgosG04G5VxPO163YCVP6pAVpCaxyZMhHMI9QdEwn
         Gt/nd3q77Wmohbe4EqqDSZZ9uHvAVRObJ0PI2Tndi9DxVcEPK1+a83Jbjea5uI/QpXVL
         cIUp45oX4Qi+KVSxbANv8RY5ITMkObOU+t7tWJonqgNEwLgbUrj3cABlWNUteEI+1jDC
         fKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436120; x=1793040920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YMGKjMwOlq6w5EX55Ph8mpyGT/IFXfzZRRGc1xWK8zc=;
        b=VzCpeHa/SDn0nK1o15iU0gwF5mIVs6wcjs7uMtElRQZZ0EAfAiEBH3m8+EeEeDxTzd
         Zy6CYg9WHROXsvPMDRpD83FHyE3MnL+m6RBzk1S/8t9HTz9M34+3bcBCNvR+/fH8Jgyq
         l1WE6iv+b0aAUGE7comAk6EOcwp7eyI3jiiLwBOyReWc7cwa5Hsk4xgcwh2Z9ZF9rgqn
         06VWBJPlKiqhWyXNs3KUADhHRz3icKYHZA2FwaKoACw9XPNMvDaO9AlpEhacw9zwrJ8U
         Me3Aqh3BfZxYWDuF+xdXWvnghaFyoqbQZ30XyzdZpUWPOTYmHiKIoeBG2O4ki949EWE5
         KQQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpfw5yTwT5Z2TByiKOfrzkem/EiNwevP+ANhDF9WcKGZZv/kFxhBilz6xqQdifrd1CorSSrBI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLw0DRo2RdpEBhrD3PYcgkzcr8repNV98NGPDqJr8u1t9FQ/nJ6
	oHPyo8lt4vSQf6KcmNIyySVhP1SuIu7F0m+XU+KH3jnDQQApy7IVKCQDcz96Qw==
X-Gm-Gg: AYBFou1w2aQd91Koq3mOmI78ZTdPZ/Fd7Mnn6mTua+TsS3KblOFcb5PJ7FKrBkwT15B
	5RZ0W4qz2qQlv/tKC04AAUjUoyf+J2FcA0TfYIh/7xYVHW9KHaiu3h+VLsXjzH8lEyWRVfYM02m
	QItt8JkpiXhw2XxQcJjPeCmzC1R26urEJupDC5soxduC+EvtLu4F29UfczemUbTRTMuUwzhpdOq
	6CNndqM9X/XW9a2SG87OFWsvIsRY6XJXyO3ocSJmfzJpNHMAwAFtAmqsIcdOZVcvOY7anha9Y9+
	nDubhQJ7dO5vebG9ppyi56ncWDcuGU8anQsitpoU+9ZKjlS4OZZvskIKpCBy3db9X3qu/bLwYls
	Ha++fMI/iV9isB0IxOpbctQWZ1XKITkL33Wzke3UYgrdlN8R+6ss52zr252tn9ZVzaT/r4qHg4I
	Z4DDdecaRMxrtBon/aW+EsSVSz5e44uydCmJ4bpDnC5azgQDDvtPyIS+VkOUbPxoiuvza+WMFZs
	x7XMiKK0VUifY8qia2DiP6Im8o6SC4ZrRfxzwPNWwqXFhpPdpzshnraoizbsV5I
X-Received: by 2002:a05:7301:6486:b0:361:8d0:6c7a with SMTP id 5a478bee46e88-36108d07524mr12626026eec.26.1792436120023;
        Mon, 19 Oct 2026 11:55:20 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm35749512eec.7.2026.10.19.11.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:55:19 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v3 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Mon, 19 Oct 2026 18:55:11 +0000
Message-ID: <20261019185512.458313-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019185512.458313-1-w453y.me@gmail.com>
References: <20261019185512.458313-1-w453y.me@gmail.com>
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

With fullmesh endpoints, if the endpoint used by the initial subflow is
removed and then added back, no new subflow is created from it: the
connection never uses this local address again.

The initial subflow is kept in the conn_list once closed. If it was
still established when closed, it keeps the local ID 0, which is also
the ID used by the re-added endpoint, and fill_remote_addresses_fullmesh()
then marks its remote ID as unavailable. If it was already in TCP_CLOSE,
e.g. after a reset, it is disconnected and its context is reset: the
'closing' flag and the remote ID are cleared, and its remote address
and port are zeroed. It is then picked as a remote address, with the
address 0.0.0.0, the port 0 and the ID 0, which also marks the remote
ID 0 as unavailable. In both cases, when the peer has a single address,
all subflows use the remote ID 0, and no valid remote address is left.

Skip the subflows being closed or in TCP_CLOSE state, both when looking
for the remote IDs already in use and when picking the remote addresses.
__mptcp_subflow_active() cannot be used here: subflows still being
established have to keep their remote ID marked as in use, to avoid
creating duplicated subflows.

Without the fullmesh flag, the remote address is taken from the MPTCP
socket, so this issue is specific to fullmesh endpoints.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/pm_kernel.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1a7750813..24cdb170b 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -199,6 +199,16 @@ fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info *local,
 	return 1;
 }
 
+/* Closed subflows can stay in the conn_list, e.g. the initial one: their
+ * addresses and IDs are not reliable, possibly even reset.
+ */
+static bool mptcp_subflow_is_closed(struct mptcp_subflow_context *subflow)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+	return subflow->closing || inet_sk_state_load(ssk) == TCP_CLOSE;
+}
+
 static unsigned int
 fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 			       struct mptcp_addr_info *local,
@@ -216,11 +226,18 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 	 * already created by incoming ADD_ADDR
 	 */
 	bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
-	mptcp_for_each_subflow(msk, subflow)
+	mptcp_for_each_subflow(msk, subflow) {
+		if (mptcp_subflow_is_closed(subflow))
+			continue;
+
 		if (READ_ONCE(subflow->local_id) == local->id)
 			__set_bit(subflow->remote_id, unavail_id);
+	}
 
 	mptcp_for_each_subflow(msk, subflow) {
+		if (mptcp_subflow_is_closed(subflow))
+			continue;
+
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
 		addrs[i].id = READ_ONCE(subflow->remote_id);
-- 
2.43.0

