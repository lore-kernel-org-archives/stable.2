Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795815488;
	b=HLbbZ3HLeSPMmkpuRAjH4e0z90LNrpnbuAmmkXveLCwgApqgwPHMs3kBCpcJuU0FkRFi
	 IQkssS3pNvaKfCxLi9LJ1ZCHEIpcgzxq+iEL60sy6+BtOYUFPOXGOnQ4YwUezNH9v5C7z
	 gZL4sQFHRJvp9PHEJ4BS7BfsrVz3/suih7cb8OWr25daESkvH0BPu+NQZT/HOx6qhF28R
	 2ra8WoqxtKDZ26UJ17NDWzw5G9i6rOojSDmVGreaHgCYl2xEA5vIBqiVJQeDtbdUT1ss+
	 MsUAPVJm+Ih3lUiG5tcGd8oIVBDXPpG9NEcTQriC4BXIV4/R+J87jPt0yy9eBzvFKNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xqtBu2Wsy0B4Kw+r7BB49KJkb1PgkF+EWLfag1zttcU=;
	b=LikA29vq9bbX1xPkGtGcN6JWO7fygJy4fapPj0z72Lp7yCmki5Pf0uOmEzgzWK/ah7+q
	 rLZJNbdJI8BUAK2Lpdvf6WC59kHHm311/U3ZpQIPHW6bMdj0IO00qM2MsVG4Sn1m6dJEK
	 nA7uN5DevJuC9xcYMNl679WqvwISOprj8VJAEBntDZ78jHBNMFwMgcyiOYP32Q4vwLRqL
	 75g13V9xEYXB0vHVp0yMuv8wZL5paRgPS6bXiI6Gnu0qfwGLYe2hPi2PzuTLe88yIj/CN
	 JtUkb7c9hVHsHDcxN/L3H8Z/ExgoExuE5f+qvh6yiFKaDtij0fV2dFnBb7ewg2nN2+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MtYU3qXW;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F38C606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 21:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F38C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MtYU3qXW
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15ea896ddc8so13938815c88.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795815487; x=1796420287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xqtBu2Wsy0B4Kw+r7BB49KJkb1PgkF+EWLfag1zttcU=;
        b=MtYU3qXW0hHJ210fj7ECe+3dydOMUaRawlIjFu/Y/ubRiLjiU2TfH5VCKvOgvVPJiF
         K4ajMgGsGVCWNXRw76MQ9Qd1mcMwPgP9njMEAz7zTwSBXTX4IdoELXbd4qjA363H18e3
         ZlknN1nuJ3/C7JvvbEC/7YCPhOAdomQwaHqSGbRxfu++ny+pL1D70e9UEn09WmMgye8R
         YxkcMDMdihRUvJe5voh6OcSgg9pVuJ7uxz9r0MeDUeRTZ8j183PoF/Gfw6GYr67FRbbo
         M5PUTV0cxmg6K3iVyWX2v9XG85ikZq/NovlJMzb8Mxz9/bI5jUfOXM9M89jZCJDE6Z5f
         Ncjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795815487; x=1796420287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xqtBu2Wsy0B4Kw+r7BB49KJkb1PgkF+EWLfag1zttcU=;
        b=MoJPLyS1lO+7eqrK320PsZ4iIXrxsGQeZRidWJRk5PPJrxy1lvoP8RBaqC03VITEsq
         ofaDLHEi11MzrNJkcru6c25nMJu7V15NPl0Da8orRDrRfWEph7xtQkK/jaWr23uFTcya
         7H0n+rBl9sEh7ukDeUJ/WmSGrOi2QNcS2Fj1n0RUCh5CbeygUGcxnWkAk0NlYxp1W1Si
         hihBS/mVawP4tzHRp/swtw4bbFyK92NNC8ca0/Tau5Js5hQ6zDh/eI8on83Jm82G2xWe
         26/fWxJAMOMu5aGKcGmdnQYOiAP9T7FvJTyjBBZmi4YY+XClUKx+ar89stCwrBr9qjCu
         38SA==
X-Forwarded-Encrypted: i=1; AL+hErEFDp/rWFC8u0PS8wVJ5fmMxIV2J3BPSvz4xMZ9wnnFoXE6Wf7/7pvjQzV1GsJtfTsvHZatHKU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rQo7zM4pTVJ1tAMZZjCjklMlpYgb6mmKL4TBvHngzAw3kVVpt
	QipMaAbM7vNG3mqtJEqhv0xi+TCuRq4/0cRtOEZP8uK9ZqJ3E9O+bKGT
X-Gm-Gg: AZFdTZe9qVnb3A/EBFL2uK0Q/XYxcjFH4ce71tCChlIWsb0cE/wSZOYbKnT6fL5wimI
	OTu9F0p85r7PAVYgwMhBW/FnV9MxZLZ8Cxpqs7PdyyB2NBh4fn5CeN5DXf4RCUb6XUsYWMSa+p2
	6CtRkkT12/cVYLKyrrd7GnYx7fkYMW9gkz3v5ZWkfcKyP+5tgH0KevixfKWx04vhCZJDLadYDCQ
	YmGbcmHP3ZPuiQ8DvM13Q6RyX5+CnnmaQ6adMFjcN7KUAdXc7fa0ZSGv+3Zr7FAd9PL6qT0AAOU
	cqNjLLUyld7q+4WDiHox4xJsJK0mxj2sAbVnOCeSKMRAWPrBiRjC0PacYUwtjUcD9p+71mU2Epk
	RrH7dCtE/wcWc53kZZVFOQM98OU/++0moUCItxfb7m/MKh5lqnRu1U+4WSaDwpLv2aRKZ/plgJ+
	/IuH2y4i2KoysJKBbtWI3h0pygAm9WezURksyr5x5a2Nh3naSFzyossYYz39KxE+zoBjqrjFlTc
	RH4iPB759Ayts++W1cncQ3kkmTItV/n0mjjQnQCxpS6WRjAzfanLPHGCc10W/q0LoujLI7Qwm7K
	Id7946oIU6k37wBPO6Y4NGj8Xv5EAxrL/GI=
X-Received: by 2002:a05:701b:4502:10b0:1b5:3616:5968 with SMTP id a92af1059eb24-1b556898b59mr25806584c88.14.1795815486836;
        Fri, 27 Nov 2026 13:38:06 -0800 (PST)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm67825547c88.6.2026.11.27.13.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 13:38:06 -0800 (PST)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
	Gang Yan <gang.yan@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v10 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Fri, 27 Nov 2026 21:37:55 +0000
Message-ID: <20261127213756.4154872-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127213756.4154872-1-w453y.me@gmail.com>
References: <20261127213756.4154872-1-w453y.me@gmail.com>
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
the initial subflow was the only one, use fill_remote_addr(), as for
non-fullmesh endpoints: it takes the remote address of the MPTCP socket.
Before, re-adding the initial endpoint created no subflow in this case
either, and another endpoint only worked by picking the closed initial
subflow.

Without the fullmesh flag, the remote address is taken from the MPTCP
socket, so this issue is specific to fullmesh endpoints.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/pm_kernel.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 88610aed45a2..f1e1576fb375 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -199,6 +199,13 @@ fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info *local,
 	return 1;
 }
 
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
@@ -216,11 +223,18 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
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
@@ -243,6 +257,11 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 			break;
 	}
 
+	/* If the initial subflow is closed, use fill_remote_addr */
+	if (!test_bit(0, unavail_id) && i < addrs_size &&
+	    msk->pm.extra_subflows < limit_extra_subflows)
+		i += fill_remote_addr(msk, local, &addrs[i]);
+
 	return i;
 }
 
-- 
2.43.0

