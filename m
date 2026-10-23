Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753416;
	b=ec8zy/1PI0M6osdBvaO+1y9vw8mKqTO0w+lZ/ySWJI7BOD9f8mHq/AVcraQCXvaeWzFg
	 osh9eXEQ+MZMJLR87V6NCoFPtglJ+Drb91g00sY8P/8IyIidIgfzBo6OrizC3IsfqFqI3
	 GhWnpWRigiW7h47sL73ShPgccIEqQBVvOeiB6vmNXsNljPigUlwiW+7AUUGypLGjYqOqR
	 XiFDx3Qe4pQNDj8q+Q7M7yPVjRZBj/mab6gl4iZZiry2UbIW7ynPlDciqG9313BIC/tVX
	 zft/c1klI+wo9axQrxhnZJ2gEt4ms0alGWFNJeMMLKzwl9L1Wtb5F25ZFLdUDYIa2Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UVqR+duwftiUfOBwuNa+BVRaT1Z9SvNCN/F0Dul6BJE=;
	b=JaHPPcAY1OMeHWw+Ewo1kKACV2MkcGqJMbHO0Vy/TAB15XU0SYGbZmigUDkPX1HuozDH
	 okpMKjboreKPNPmM7f7+ZSiHwG3mvMwL+wY6x+GvhhQOWA6dGb7dfwnb9RMVIz7pYag8N
	 0FHLXQV3Avr2J4e0rEQU4l4pQ92GnqrjtTtmbJlbJKDUGTdGnddQlcLV47+TVcZB58kKt
	 5mo7DdYqjs8zc3rKCWB0e9MT07F6e5eOUPdepnCK94N33odbJjc88fJrfc3egBHqOss+J
	 qRcriSJWFjfCoDYS6v1MtgCeGVcw6CqPXExO0b989rdKMA3RLz4beIQyUTHvOPlGbOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O5HEY5XI;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5267606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5267606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O5HEY5XI
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3514b90bb89so1711508eec.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 04:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792753415; x=1793358215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVqR+duwftiUfOBwuNa+BVRaT1Z9SvNCN/F0Dul6BJE=;
        b=O5HEY5XICcPAddypDOo8czZ65wjboB7vvLeJeA0ebFqVPf81mtDLZpz/FF2MFr1jNG
         D/mxfkiB+lhUS6V0BYyChGQ+o38shXkGHExaM2VDjqeFlAZESCs/pkoz2v05iPSkRz6t
         5coh5rSaWeeu3tkQd8Vvl8w7WbYtvFzJ/wTGRmghEANLY+14a1VwzDNsTzNLVuexSZAD
         eYy7j/i+VljSx6dFgfCZFUV9jzBSGLhMP0vK6U6GQ22JffGLku3QDhUQTx9sDG3WFZk5
         Fnu/GdzfZSvetWmoGTivTKsIhLXjTg/EqEUCK8rCRMt7m0JhU9n0KHWGXDHUA51xOQak
         dGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792753415; x=1793358215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UVqR+duwftiUfOBwuNa+BVRaT1Z9SvNCN/F0Dul6BJE=;
        b=zIekZFO56asSUV0CFsYga6H6Z+sWyG/OJYpsJLe5VUax/Vio9RJD78+cJh4SmPR1XD
         Kr1+HjPdcFB4nxPpTom1mGbji2EOPxh7EKM6494eAlR+cV/7Xo+OEvGYe+DfjmrbeoL9
         81TKfetW64dnp4sll2U4mHyD+CuTl5HQo/xE63EaCfXzc2vPSpd38/OWTI15mNjtWm/p
         vXXMvfIVffTZuWTJXflu7VFKYzT7sB3ihVk7PDO0ekeb0f/olK1HlRz8zYti3p7MUKru
         rW9XMmAup2e+XAxZxWnLXRCrbRDTHgMQ2bLxrKT4le0T5S7Pv2sa9dhynqg9RnLkFYhc
         0hRA==
X-Forwarded-Encrypted: i=1; AKwUvBymMgE0wKW2JdNqfVIwT5VMqjx2Hj3m6kDtwZ7SknacT3DGnXtznXIw5B/YXRJtklpXx6WbfYI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJb7+gozx75t94GDv4sv9XQdc+YlDRBoCuNF2RUjeVvlJ9K6QL0
	P5Zfl1G7XYLMaIOKd4AJ8bgE7SO8SS4O4mO+escc4sHmShYU4IOitHM2ZBQU2Q==
X-Gm-Gg: AYBFou0ZfzfJdoMqhdXShH0HEvXwGLRfXV5n8wNvwImFbwlgjYqTs1TPJE+3++U8FSV
	U4CCL7evUIgBk5s0v2hsMtmhKKR7o2QJjzpGzUbcSkp+8ZvMaPjAvLE3bsCh7pxINwSuJhR61ek
	Knq9P/aLGCF8oPcHXValYne+nSyVwd5jN91Sqz6G+skupAR8QB3hDH3tUKBghPake1pfPz6kmvs
	thvrNl3wU6kNBxNPIbwNP6erkZd2olc6/SUEg1CJmMdIVwZL8yTtw6/Uc47UphO+zNHKxOOPJMc
	4FZGJ0YrCzWi/pDjYjLKVPZ4xlbV2L8wcil/vNv9VfmP0FuYuitA/xm6W+EsO1OQ5OJvIRXrEMg
	ZPoMocRkWCkz35eVjA5tTnZWR610fkH2UBxNzTc5jP6Yz83YYAxpQIsYTsK7y8tUISgJYKPFiXE
	Pet0Bmt34RRssuPA6WhKGQjyu2IngsZamHAaa8Zs8em9x9RZMsDIRqlNYGD+uX2EoePqDONEtJO
	tzp0AhuHgahkSLTcfurpBzDtBsYQWS/vFmq3ZsKe4xIgJzS5Xm18wz4epdi
X-Received: by 2002:a05:7300:f48b:b0:356:23dd:3c72 with SMTP id 5a478bee46e88-369d964640dmr2476046eec.4.1792753414507;
        Fri, 23 Oct 2026 04:03:34 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9defcdcsm12695186eec.23.2026.10.23.04.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:03:34 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	Abdul Wasey <w453y.me@gmail.com>
Subject: [PATCH mptcp-net v7 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Fri, 23 Oct 2026 11:03:20 +0000
Message-ID: <20261023110321.403874-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023110321.403874-1-w453y.me@gmail.com>
References: <20261023110321.403874-1-w453y.me@gmail.com>
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
the ID used by the re-added endpoint, and
fill_remote_addresses_fullmesh() then marks its remote ID as
unavailable. If it was already in TCP_CLOSE, e.g. after a reset, it is
disconnected and its context is reset: the 'closing' flag and the remote
ID are cleared, and its destination port is zeroed. It is then picked as
a remote address, with the port 0 and the ID 0, which also marks the
remote ID 0 as unavailable. In both cases, when the peer has a single
address, all subflows use the remote ID 0, and no valid remote address
is left.

Skip the subflows being closed or in TCP_CLOSE state, both when looking
for the remote IDs already in use and when picking the remote addresses.
__mptcp_subflow_active() cannot be used here: subflows still being
established have to keep their remote ID marked as in use, to avoid
creating duplicated subflows.

When no subflow is left to take the remote ID 0 address from, e.g. when
the initial subflow was the only one, use the remote address of the MPTCP
socket, as fill_remote_addr() does for non-fullmesh endpoints. Before,
re-adding the initial endpoint created no subflow in this case either,
and another endpoint only worked by picking the closed initial subflow.

Without the fullmesh flag, the remote address is taken from the MPTCP
socket, so this issue is specific to fullmesh endpoints.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/pm_kernel.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1a7750813..c240c1056 100644
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
@@ -243,6 +260,20 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 			break;
 	}
 
+	/* The initial subflow can be closed: like fill_remote_addr(), use the
+	 * remote address of the MPTCP socket for the remote ID 0.
+	 */
+	if (!deny_id0 && !test_bit(0, unavail_id) && i < addrs_size &&
+	    msk->pm.extra_subflows < limit_extra_subflows) {
+		struct mptcp_addr_info remote = { 0 };
+
+		mptcp_remote_address((struct sock_common *)sk, &remote);
+		if (mptcp_pm_addr_families_match(sk, local, &remote)) {
+			addrs[i++] = remote;
+			msk->pm.extra_subflows++;
+		}
+	}
+
 	return i;
 }
 
-- 
2.43.0

