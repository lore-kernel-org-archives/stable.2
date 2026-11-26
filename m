Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688308;
	b=ayGgsdrWJydKKwStY4Sn0Tq1PFk0ql8yG1Ii8fIQoXQPVVlhVZf/D4y8JHQ+FVPAvZxf
	 rh5M8eUbiv8QtMebmFLYOjiwANG6zIb3Rv4+AR7yMqfXuuTS4owoOHhuTcbInAcp72jCf
	 LFFgz8o3w5g1a3xY3rZ/SkykLUDKh7w7VtEcTOUZVa/nUy6f1MywTVoJQKjKERS6hAdtR
	 i0FnTICDFsjNJTdbq5j7G6hlMUYrqs75G5U90ei9VzaK9mK++F1NAUsBJxwsYV/J6WDUs
	 UTI6nLo6h4O6uAwr0p2hj9VAnK/ymCGVZYVK1W/aCD4yXJKXLCF60VP0vGJGDhsM3Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SQ18LAQ1HnU801OItuw005RCsDZr9KcDeT+UKU9QZrk=;
	b=eKhgalk9cAxmDEEbSUNa9iTp9mItntVvizzutKhri/r22Y/wHN4HQ/x7iHdYAIAtIz4/
	 86il343dPoUz8OPyWM3bSXcKNDWcTQFxPF1O0I2q0FykFH0G3KbQf4pOAPkCr2v4ydaje
	 UqPE639pFxU6bfy/C5WcAPIH4h8G0den7dLyDi3lZnkWNtpTf61fr/aSM7r/Dc4i7Sra4
	 ONuwku4wDGfSYmL3PH72T5VhAmBZplnRYoOY/MZh08cR+jEXGmxFIv4VjG4Oa0M+HhDl+
	 ShAbMxaonsDsICA+wdXe4SX1F2YgYkwao3S+lT4vofd91hFvTAZJXat+F3Dk2Z5cmaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n4ipSRfe;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6E0606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 10:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A6E0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n4ipSRfe
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38190551625so13341773eec.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795688307; x=1796293107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SQ18LAQ1HnU801OItuw005RCsDZr9KcDeT+UKU9QZrk=;
        b=n4ipSRfe585AiYJganVy5ezuAaIHTsmG3RD87+5ZCOqcHtb488yP5R6v8XO9yqBrcC
         dmXwPygmt7glXEY8qVoqJfFK9HHN3MRZIgmVxq5muyj5gbZM/ZILnLoku8MvjZ8ssRg2
         e+YIMMMII9szW7edcKWh5h6Bn47V6WnJlTBXjp1AW2xhgGT8N/6IlGVrAVdOXUyr1qKw
         AHWjbgmDFz2qAyFn6lZOEmVxk+UcK+7vj6SgjDU/eCmTIznnSwZO6GjA5lj/gaze3bDx
         UZHuSML3TJKuPWu/O0GI4HnTcaFEiLa6irnK3RIOyi1Y2hhyFmFAfjQL0NX+no3TvoxF
         RKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795688307; x=1796293107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SQ18LAQ1HnU801OItuw005RCsDZr9KcDeT+UKU9QZrk=;
        b=TC3smueRJQr7yduIyzjNCbl8K/8l/uxQETOO1SJL9LYA0nRyGjmetyeq+MR/rEireR
         cPbkBQxB6pK9lg7690bNAQ3Pr5FfgPaIew2GJHdIGM6AXA5WoF0mOQ4fsgc//kut0R4v
         vshkzS/f6vDagfWNSw6GBparhAiMeoRXIhDK9IgVHFq+uIVK6dPDW1vZn7OxHBw9xxdu
         u4XFPYKE6bieC2+Ng2ss5QLwOnQXMfqPAJw5cBAyq2m0mmPgO1oqtYlbz9cFJyZ9pjMV
         3lKqRfaq28pLxKQsf/BYD0xkOkqg6dtJ+siLIh9mdabeX9MV5dOcqHgS9gcMl3sFpgCX
         ub1A==
X-Forwarded-Encrypted: i=1; AL+hErHDpvHR9IV42e3Z5awv5Uw4QKufYCFukykoYl48Y0J5aDvLLFcx1flddJXeAM5F+fxa4fcpO00=@vger.kernel.org
X-Gm-Message-State: APuU4Z/84m2Dt5d89ZvOSysQSN/CxBp6LYJ1NZVEpHUt/6wveabNdsDp
	31WxPFCLZrhHAkoDqBp20rm/kqA77CzVn03TcIiZQ+jAH6+ViA39wR5j
X-Gm-Gg: AZFdTZeDuPCNc0teKRDN1rEPKd09j0emAyuOJRaIYipDHqGHYemrgTKHTwrUA/+qAVi
	QPXY1KQ2AVknYw0PLORoZ7R/yMIghpDDSg+wrI5gGcRhjsny6MfxYwIsGFLHhChD5EepwIw/IAu
	6gMKM86OmqcqeeYSrNrh+HiKNdV6HinCyvJM4Sp93i7ZAaFQHqyGhYgVT0YXwN7Ide6ZvNINOYL
	nxG62ztqyIaP3/yrysR96EmKe4znzwP3ObD2qq1wiX4XUJUbHiT2sr+jzSqrmZEGTDTknBUHqE3
	xSR50llsLi3GV47/RMjPeJ4Jdh3v900CZXR37bp9DfZ9TOEZCcTelgYcyuUU9PGSiW4n40oxyOX
	6CDbDtfcKuwcGgG/JBWM4M4/7Omg/t1UeOexk25PPo2zfBBYHIJo7CaR5WXkW4JLVKIgdN4x98h
	Rk2pcy/o5DWhqKji7+VFZB0hR8pwnT1PAkqlDn6UF4m95lPSeXAc3i6IGFaFAmghc2s7pk87b7B
	bkZRXv62y1XuQW01WFgeafHYiSHCBVeVJRTBbiO3+8iW7ZOQlZRyMXfTWl5SvpPoVCx2Z2kILTB
	Ow3/lHkoYX2tjh9dZqgJ/kop+bo0OeEwdnQ=
X-Received: by 2002:a05:7300:bf10:b0:376:b957:bfb with SMTP id 5a478bee46e88-3856f7563b1mr25741485eec.17.1795688307302;
        Thu, 26 Nov 2026 02:18:27 -0800 (PST)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm74221227eec.10.2026.11.26.02.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:18:26 -0800 (PST)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v9 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Thu, 26 Nov 2026 10:18:17 +0000
Message-ID: <20261126101818.3916631-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126101818.3916631-1-w453y.me@gmail.com>
References: <20261126101818.3916631-1-w453y.me@gmail.com>
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
index d465524902f0..af3b092e45ba 100644
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

