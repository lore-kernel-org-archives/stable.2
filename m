Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792840731;
	b=uVN2WbCbfHSoenKbth9VM7l8gHI9ttkl8Uth9H80Pi/8tyTEaS7Sie/iqG5Z2cMjv3GR
	 iLXgcn+nygPdKb+FM6hKPDQfUGfggg65u+HEIHcldyMLJ51/shoOf9yWUT5wqnOMgynlS
	 TQnxpO5hI/Ehljq1FXc9/OOBbQMExI5DdljMPnipAVfUpwWMo2LYrZONJLaUey7iVlyRY
	 K5h66u4nQD18lZ4HVruAfdcgIk9ic4HNcPaW88aRwFq2hc+oMWn2Cf/wTeLK8NDvSkZ4Y
	 bpfMXPbilpPcnfmU4+x8Rd2ud+AWGYSV6yp1zuLCml9lbvvnwm721bstJxcC4tKKKpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792840731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BVxBaOD08DfGYfH9jEwqVQmzZ6pV+ioii7FTsj+LKiE=;
	b=1Q3Y2khAy2zr3Pr0DKmdacluWxf1QGz7eTzPeSvoKhAtRaxJEYKBpRN3/riOzQqX5K58
	 FUixmlAojOfI6Ifz+YQsoxLFQtiuOKdWQt6Ab+q8YsHDGMgDa6lMA8lcdHBrhe2o7Spqw
	 oLd0+A4VUjTEt9T9XSgp1PSRfSIzaCwu52PBs6C6HVJJngRSFMlPB0rBjTnsvYKD10yhG
	 nKuQyk3CY1HmusW7SDoF08MH6JaS0oVtZJSNdg5Km0AGTlPcUS+674g8dV/pVSx3eo8R2
	 WaJOeUVw5zNO4KUvC0Q2W088yYUYafTDg/XU5N0f5by2Mu/DGy15go83JBmm8oAMDzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DsFe96bB;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25241606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 11:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25241606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DsFe96bB
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-353804b591eso2884769eec.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792840730; x=1793445530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BVxBaOD08DfGYfH9jEwqVQmzZ6pV+ioii7FTsj+LKiE=;
        b=DsFe96bBqWQOm6RJWP+8sMOV1np4UMSsUqd0YSX3kdHan7+6W1FMWSqL/0NA9Vyjyp
         uXFkRJQDy63MseOibOqSCmnYV/2uhp1RUPWE4MJt86htvTzjXHjhOw6D5EUeGKgNAdUG
         vv81bx5RgzkI+LcSca34ZAfk5Xogk+0fs6SApL5qWS+b3Igf/yndKcgwDojWsibIrU5v
         T2aEsggjjhF9KBpf4ek/nbMl/XEQjNyn9l9U8f454N34o7XH/ltFyb84I7d22aG5ousP
         H3Ji3Q10vQtX7pKok0hGsbyBbqg0pdEjJ0RauzEaatY7nFdiMxMd6UnbLauNggG1hkWF
         0kAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792840730; x=1793445530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BVxBaOD08DfGYfH9jEwqVQmzZ6pV+ioii7FTsj+LKiE=;
        b=rlX0Rq5PL96aCFiXy3B5kPHB+cps2jwy1Jj1ngFzL58OwxIIgq4sqeNb7afj1qZzU5
         59b59WO/nL1ob0CdH+4mzlSMlF41pUoGzokaGMQkTmspBPMnoiWDc8f9zSDyZRoHayb5
         KAwKmMw+H+cVZOco2Irc9q2K8sDZjS6BeBz1sNGY9aA3tZ2kEpXxNrhBWDibaBnJKYac
         m8YG8OtKtJXGTgTdHsMqtL22JPcc7W/EM3ZCDvgswIL7z3i34EBb7smI9Uk6bHZ/Bq/8
         hgwvjgsxFZGbK3qj4F0A/amRpPOLihIvDq3nq5bzCeyoQB4V3Ru3+JqW/b35ye4GKdWQ
         Urhw==
X-Forwarded-Encrypted: i=1; AKwUvBxnbx7lU44g9d5a1CGXar5r6MBzhP0JVa9y18i2lMngMccAVwOVrxL5x+Ydg4qw64/WYWt/e9A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLh7MdqRFr1EtGh6xFl8jF/97UuOr/9Yhn5hyMrDlMl6uGMhbP
	GEc2Y8iUfkt+VNYqvvWCSrLxZc9MzgVO8UdK+e1sctaseWdgx1lCz9Nf
X-Gm-Gg: AYBFou0X6F3aGLFuDxDXAC887Se9sG26stXTkIdjLcDJu1prZZNkNG83NnNnY26e7OJ
	4DtZZv29OxEJbbFLFvAsnTvvs2pQ7HT2XsfsmpwzNGOphMXxGSctpyb09u1/pvfXpV2TLwG/qyz
	8K3heu/7gMogtjTU7kJhNtay2yc3RX9q1c8nJgefGjMU1/KWFMOJta5XnBVSFhOEKV3bmTp6yFg
	mmljzGFgKkxOiNtJJuLwInpaubFW6QSOSVH4o6PhuMclhfAjPtQ/a/g9A4b5zSmJavL94Hy0KAx
	aZjlqklhNG08eiLsqjCL0fZwmvi6jStPoK6d8Bvkqa+X/eHn8J7Xu/Qo+xSzBAP3rW2NWt82wFY
	I8kodVtOsrhXK6gzHXI6F3lMNcKRSV03OyyXqfUA5SwJ8QMv5iS8kE0hDTNUdJk+Zg7EUo/wsRV
	bA63G7W39eXcKxOT6FJSHLXHs8LxfAz5wVo+fUglYhSywonM/kOSkbNu70Syi5whkIgwBfhaB56
	LZ4xMFlIVcvsZS2q0jtfm1Kli/gAB0zrSIobsh5gcXGnVmdSQ7SRaWIkn7gbg==
X-Received: by 2002:a05:7301:3d10:b0:35d:ea6f:b85e with SMTP id 5a478bee46e88-369e8358affmr3908622eec.1.1792840730104;
        Sat, 24 Oct 2026 04:18:50 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8afd64fsm7458774eec.0.2026.10.24.04.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 04:18:49 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v8 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Sat, 24 Oct 2026 11:18:41 +0000
Message-ID: <20261024111842.1069878-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024111842.1069878-1-w453y.me@gmail.com>
References: <20261024111842.1069878-1-w453y.me@gmail.com>
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
index 1a7750813235..c240c1056a59 100644
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

