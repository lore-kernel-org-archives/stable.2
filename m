Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432996;
	b=c4RGL49L+35vnzWfFflxwZQ+40j9gEdyMoHqyARUv67ARy6uIJguXdsNNTsEec0RgMXL
	 AilwY8DRwrO3Z9k80lHALUgxFxtf3+rh34xmYs2cxawX69Hn2nzm+MO5z5luGZV9ci0K2
	 v72ooaMrwg9pSD/lPntUIyFBeJbnlwoHA04qUT8MihqOFeO0/I5EA51SR+GvbrWoo1rSi
	 r2Cw6LE6GgGoPXgTyXHLLNJUfZrf8BUSG0dShtdIJmPIORXzBqbD8+nnGCLt/a+/lY04H
	 E18/OgQzqvSL1iKhjTfysWgb5iLGgJLeYiKEd8jxUKU6wAUKPnzZnGH2sK8lfjQQrnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WiD3veyh0lMkZup/sX4u7RZCTs4WLYnqELgkUTqE04M=;
	b=hifxa6R2HIphkiRt6MqjFkgV1na+If55N2uS1DGZay0jxC0AwiSCwTvCULAgyUZsckMf
	 xdDIoW/VE8NvC006xhdPYJ9/phEwv5gEsmU3Sxv6q1/hVQ5CxfIwVzyXh6vrxCtwAP+BN
	 6/ONRIzpXN5NNVTTCytIUBNeBHN0ro+WNPUOwocybghSVLbOwKMzpyAmZHp4qMgHPuhAM
	 XM9mlBmgzeHm7gvIuizvwjKnO+mtPIw1DeEdLjtKBdZV1soVl63Dyd86PWOog2jtdo3cd
	 7CUe+36E6/yJ83PDWxXWEErz6j6A0jAz0Y0jIYs4OQiwBtKkGNKafwWgumsURUORlrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SNfYXzPm;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B05606A31D
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19B05606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SNfYXzPm
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35f036b17easo658904eec.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792432995; x=1793037795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WiD3veyh0lMkZup/sX4u7RZCTs4WLYnqELgkUTqE04M=;
        b=SNfYXzPm9iBLqSA0U13gdAC3q1FlFaQjtkhovh/TAGHaBGyxh3c52QfzsrpM9Kvgfh
         1l5IX8XMtJvBiSEk3hewgZ92O9SccinDkgVqRlxal94Pz8dNDMuTVvM6AIV9z47jRGSR
         jcLRu5xmxT+zg6SjGV4v0c9Kyq4kmhRJ7cg+MGhncb3RbGu+wWblIX5kO16bInI3qqNR
         w9ltKC1zB1rnahRGhZWGsWkdyT7uvqLEWg2mA/MJNZET9HXZVC3NiqS9ICS8oNCUTqE2
         DiAKCPHyWYr/w8/uW/pOoCKlbQ68DphIGLoOtFZ6ly2ZBQmfO7c/uhfFfmWEecbirr46
         HlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792432995; x=1793037795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WiD3veyh0lMkZup/sX4u7RZCTs4WLYnqELgkUTqE04M=;
        b=DhQ/pG+1YAE8La5x2L1ITEjk0Hbbj+yq4tMXlSKCQnztK39kLqo7M2EWgRXmaSG0r4
         f4Bia87WgD6a2GL7t9uqxW9Tu/smas0a1WkiTJx5doonwU6FapRGkkBzGdTpDee+H5yT
         UoN4377c/EyOPXsnGQUoZckqV1nKSnyrkQX4KqjEsj5L05s31pMWjSfAV7RrcDeKtCDQ
         gfZl2qD4ypHqEts+R5cXKCRijPa04Q+KhZwEJvYHmsqWz0czycEVK5Gh+MfJ9LWbQ6Am
         /CYja600p51xowfkyNATQbD7v3PSl6Rsvrf0JyY/O+m4KmaHcbELITYNfEZwlv1m5U3H
         ZLUA==
X-Forwarded-Encrypted: i=1; AKwUvBzAhkDLT4fO2T6X1vYrGn5zPyy7DNJYc4huRNXn3TPMmbzPsFMjFrOk9AUBw76w7lFKbnQrpFk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOLxrLVzOJTEogQE+/6Oz3ashfKzPGmKVFrT5C+cJxPndFZA38
	Hoy33jbL/cg3P95ijIEXgFTRyZhlmn0JGMCeUpOE0sF7uB2Id8sPMkHQ
X-Gm-Gg: AYBFou0+BNp7mXb29Jh7O2nuVrEi/ZzOP/QxG0FnGHmTV0JUcHnJzliK9uxWAkB87fg
	KFDMkuMPZtXqjqkHxa4ZX4KD8ixgmpVP3H1kNqKuQ858yZXr17p0IW3a7di9k9jESZXxu2g+IRq
	RQz/c9isfSR6vidAEtViBPL8BmcvPU0hGRlk+VH8znnEIN2bmGr8gR4OUIABdFRG8cDmoNhV1Za
	VaslZz3aXCXGCF/ZxlEZP3R466Thjvnjfmu/MY6hnkYS4iKvfb83JJdgxyiV7QZpx181za5gtSo
	KMCJdjXvdXSE1eo51NQGEL76QjTFCjUkeaxseKeWEnR1h9i/Wurq88PVnUkxbNKU0YmM2j5v1+A
	JtQy/eR7xIgHHUt32Gq/m9BQ6LawDKdLpWoDK+IOF9EBYo3EQYT7bxhidL99+CbXSSwjGaOIRnI
	yzXs4HQmU/xygNAPKj/LwmoASCufol6FjV7/lIlpW+TzU8LOyTXHa/oguJuNd20jKW1XmABlltY
	n5Bd9Z9
X-Received: by 2002:a05:701b:2908:b0:153:52dc:d04d with SMTP id a92af1059eb24-18512e23ce2mr10318015c88.22.1792432994780;
        Mon, 19 Oct 2026 11:03:14 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18319d3b880sm28400604c88.10.2026.10.19.11.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:03:14 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v2 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Mon, 19 Oct 2026 18:03:04 +0000
Message-ID: <20261019180306.382039-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019180306.382039-1-w453y.me@gmail.com>
References: <20261019180306.382039-1-w453y.me@gmail.com>
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
index d3014bf57..fcb5b1c85 100644
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

