Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659053;
	b=tmzDg0IA2+smwps2iR/RVUS0e0VrEu7zjwwWQjkAef/KyXBLCtvXJSOjnVI5MblvnSes
	 MXzK0J96VPPOt7QSrDN37YjZwaJcAbMw0IedOYNhO6X2IemRF70jNJq5+ELOJ6YnVT4IT
	 MPNnsFq9BeT04/O3aMVS0bqEsJ5AYmDH69O6hl85NPqM9KSYZFWG0AjcYoeNaWj+sNWvi
	 8rP/QsdRZCmKRfMqOhBsnSw/jpqOWU63+1RbEyhss2N3dYyLiRJdAxnciT8tJ7T5MDY7A
	 zxg00fAI68s8bMIWcu1c6BxKa9YC8oIip2gvf9eZh++Pv0MDvcDEMMnjA8+wFvn0gUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UVqR+duwftiUfOBwuNa+BVRaT1Z9SvNCN/F0Dul6BJE=;
	b=ETk7b9LkW+lSjAu+jt3etVmt749JlTFKtaTN9Yaiu4fTqmPa5fFQQLb5qQaH4vBPnGN1
	 TgjTECXWPc+PTqo35E/sisd7ObX0FQfymbjLS/HUralc1WgfYRo9LWDc+Vl08opF0QJV2
	 5SRS+Tyh8XfJDmKCBVsauRlngJGYTQ380JIgTHtBAFvUI5JesXLQr9AZzAfoL4GGZNFj9
	 d9zwg/TItedV/2M6yloji57Gv98GeJ0jaPVDcS9LxfkoBhexQ/4AmWoudGFO2QpoI8paz
	 uga7dRhWLJSa6lLbfmwUmAPNuzT20hY6Funkboa3VUJjansjePYygXfLKe7yx0+JiUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UGEIoGpb;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611AD606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 08:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 611AD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UGEIoGpb
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35f1f76ea84so2336208eec.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792659052; x=1793263852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVqR+duwftiUfOBwuNa+BVRaT1Z9SvNCN/F0Dul6BJE=;
        b=UGEIoGpbpqOonS3a+jUkMnbgsuanjh4Xxs/5gKLO9NDnNKKOinghtFqO+qQQRsCk14
         iugsI3EyBPyTx9vmeENALXdEevUvWA9n2tOkGN8Mi+jR8KpuasRX/o5NEQVxk4r7QJQ4
         IcZ4Qe+PlzojyQIiVnR+ji3xkDERh88H5c2MEEjccaCUWfou0uSCjgAwK+d+MWtGARwW
         /9dgJLKAAvtgz2w171Mg/d+jjL3wbcPxnIdwoxnsy8jIyX/2LOfKYM60sr+oX3Hzvb25
         +wcNt5956BT1x2TomzgSUC2GfP+T7ww0vPvu3PIgl4s+h274U2OzmNJ01UbS3a5/dm7C
         t6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659052; x=1793263852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UVqR+duwftiUfOBwuNa+BVRaT1Z9SvNCN/F0Dul6BJE=;
        b=1UP7w0yDn1if5nlxd1gbH3QUManRsPJbWtC0NjW6f33LkviGrvUHqpytnRf0APQDlR
         X5TKEZ28KM0heircZGaxiiRr08MSmGHuFL+J56MK+8fEyjNH+9F3HkTLIqB1w7f42437
         OgoO3cwp17NVPIL0w3QetQy8Psb7vdtVsChFpF+pL17Kje22jWMmmSYtb+17+iSUg1ng
         blYNtoHBZk/g4IPuVoyvn4+dKsmFhkdKjb6R3LnUuXq4mLkhgPvcIWH1tF+Ii3qv4bPY
         CHPqgYKf+secrK6CmAwRZ88jpMSeyBbtGzOIvwc/DNfeshrgKI+QUVNky5Fx3nzEz991
         tQsw==
X-Forwarded-Encrypted: i=1; AKwUvByb/7qnl0OFrqZGPqFw97cLzrREonemnGdZIX838tO9MWElR1Qm1LI8svgk+4gjm03fxlBQLww=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwZ7ebryhP0RJROTFnS4ZgD51EcK5EHEyUbCOKrr7CG3lcJ+iV
	P0SBuha+y1X87h+D7/628fTo4KWWh8617tzWl5FOpx0Jkqc4xRpIdcOi
X-Gm-Gg: AYBFou29rdfRN33TcNFsNo9d5VHMNxVLs++pwnVaGFgiapTSOYSjsHR2ZVb4FxA+Ufa
	iT0MCbVX6oXJNCGlVsJ4Wvn6yQRDMVoHyXEePGe1DuooSRHW7BzUg74AjZqaxreRx+wrB4BYAzo
	XI3j7g+3ybUiEjShYcvJFMO0ZlR+6xyczL258h/sYeYqN3YoTEF7BWF0BJchUeAy6dVtuS1ZfP3
	wV2VAg8EeZMsOpkbFs4verADxBkKhfQ8lqyq+d/yOKJ9sQInEDOYJyRTGl2KxFWtf790vui2KOU
	9p2oloz3iMvuU54VkGYFMmWNEqVcC+uTOkU5uETB/Blh+xoArp/mqcDsruVyGqu1jgeCcz6kFqh
	nRQh+rkZ71nQgCmHjMF3PhwbEt5hjxHtjLb5kCYMl5M9+S8tI1omzdxLZ7pmh7NX8dMp7R/UTBe
	HMBGLyJ0dAzK09tD1JnobAuLqIb2UhlatUvcLleBAx2wWMNtQN9jxVgg/uV8hbRPAw/0x6iYv1Z
	YMNZylr5DgTRI0Q0Q/Q7ayVmjXTN2PPNkiTmPFvJV0FlrW2/YMv+J/IiIaq
X-Received: by 2002:a05:693c:41ca:b0:35e:5ca:e0df with SMTP id 5a478bee46e88-3674eb34d50mr5910217eec.35.1792659052273;
        Thu, 22 Oct 2026 01:50:52 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e15353csm25343328eec.2.2026.10.22.01.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:50:51 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v6 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Thu, 22 Oct 2026 08:50:40 +0000
Message-ID: <20261022085041.211318-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022085041.211318-1-w453y.me@gmail.com>
References: <20261022085041.211318-1-w453y.me@gmail.com>
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

