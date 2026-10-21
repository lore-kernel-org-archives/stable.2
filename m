Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566214;
	b=N6xnmB7vVxFkbFtG+Il/Oh7PhkKFN3x4lq0mGT2hFSwrmu7nWFmz28EG+5zCPqD4gyW1
	 2ASgo1Mvm2stZn36NTZGc3OBQEdBM3hS4rvS0WdkC7tdx1k0U88Aze8F1KlCLSiMWxzU4
	 hHGhMN4EzzEis7PAa/DfWLb2t2dPkL512r884nkr/bBpPOwvbEciYifzUHfEupstuP+zj
	 CsghySkyes4U8xZSIrpxpr+Bu2GJ9eDtxK4uCHn3dPCdwXRl0OscXfHnl5RsPCRqzjHut
	 mJbkX8PlJAMn6p7RO6dKYHgx/LvNKs5tvDFjpiecEaKL7kNNn2iOXRrbW0+kmBhz05A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=r7UgBzkOgkIY49aE7RQgGmpl5vSoNjCtBQrLqqDS2II=;
	b=iJzBMe+wgalwkvshIk0UdkUG/n4jOdXdwv4TbfbZGCAUVz5Ted0foS6wu1/+xMMmqSjU
	 vN2ccrs05eVuDQOFn9ajfOVxx0EJiv03hwtvYy0L3xAkuO1nVr7Mxe8UTmOVFPykC3nXr
	 2wV9wA70TBLUkx7QkF5XELKUBRtYBWCSzouq4swRFSPombCbhaP2RWJMYafKsqLaqp8wg
	 BfizW7PUPurWu6iSX+Cb7mWsXa2UMUvp26lv378TpxhvA4BDfj4cEAD6N48CF0CAPM762
	 yA7gkgHamQ1s3wSndl4Ez/XN5Wn/WUOzi/Uiq75ZbRNo494smlGsxUyal8UBqfwmpDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UksyWeWV;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C8606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 07:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C2C8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UksyWeWV
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3514b90bb89so1051829eec.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 00:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566213; x=1793171013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7UgBzkOgkIY49aE7RQgGmpl5vSoNjCtBQrLqqDS2II=;
        b=UksyWeWVP3Qt0RFJMvVgwQlYkHFrtm0fMDKCculAosfhmGO63sqKPgH7axVhCJtJsX
         BPcSyrWjieqUNkaP5U9rdjwyRLncjG00lssdOSizMCyfAD8Ff4zzHHYlHDGuAbB/zPeW
         b0F2y4mY39WWHbbGI5s/K9n7t/BlAcwDbtbI3sPKNkeBsqewUU6ndWdbJHiBUEeoitPz
         uMIMBhetFjtVGm9LZtYWF+Yhz6ZWpbsolWJ8BIUbKAHKqSjWvb0A9qqiOrmSdXh/7y+s
         eSKK+sZ2QPOlLDhFNVIYHoeRT08hlET4R2OjdCnaMzPwDAeKFAeku81N30eOLIRTtsQW
         EgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566213; x=1793171013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r7UgBzkOgkIY49aE7RQgGmpl5vSoNjCtBQrLqqDS2II=;
        b=KVYjyNELc7bpw+0aff+aIbYaX2YO/0uYdHBBwZU5lNzNuI0BDLirH3emmwMLSM/56Y
         n+MT2VuKjWmUj9tIaAX1bqHIUyuNro/MceCQ4sLKqa/WrGVNVzAMg3alsn5mk62uP8CN
         0Me95yaOOuPQ7Tzni0ULZZ+CKRn2Y7nXYxRIervZin0G+djWIThGJJzJN6KtWHX5sh7T
         M8jbJodkJbdGT4gAbMrYV/ncoNO5gRZ+ErzBrn6N6ALZ9ZykIdjfo6KSjbRbDeknZeo8
         xey/TnoADQC+TCZJ2VErWlM2Yu14JDlW0zsFLla0iLMtPGGuz2wIjbyD5f4oeFsgidAE
         wtIA==
X-Forwarded-Encrypted: i=1; AKwUvByBgbbrg3UnXzHpKJyJjIGC5Ej1iiQ4dpd0VpU8gcVqJ64ENT0HKuSBX+rtvfI70+gmYZ+lTqk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaFGgeuOixX+YFoztbrV66yDHzV9wno15mhC3IIeZMpZW7a5xk
	H9tsfiL5yr3quSSS9iF3vBdl+Z02V6h4d5ZXhfDqUp/Zl/PuX1DnexM0
X-Gm-Gg: AYBFou1G5cNSu/NJ9A6SIsWRq0/cVu2xvPxPErbk8XAW44Z0nn5mvEQnQ9m4bivL2Qr
	o7KoVGQ5vIH8B3ck/s2+YoGNStTY5i7eANxF9zoLMBbLqMTVpTqzwiioac1mgHTCmVqB3dwHzdr
	vsda3xL/dQ13z+JYNn4RU7UVgYPC9jPDC9v3wEJ2HWhXRYAADMJ4OfEVPUU2hyIBd7buSK4AJUr
	GGPhBDEDdp2VXC+Gz3SUIPm3A/TDaEDRYd9nAvQGNJZ3K6+Ijbl9rsmG/YkKYY3SvejUKB57lGF
	Gh1+LvH05BRDmkXJnQ+bqemLnmU6kxmtpTRgLtztaTbEqgb1cHklXDWW9/y3mAovEYxFe+j1WUf
	0u+lB2rvnKp8Bvr4LiltbuYgtJEXogYwtIs+NqY4ZrXu4gcDDoPLxOKyw5EdnxyVm4Z/S5bJvfA
	lNJjumbXbGv4oHx1I0oXgDVelRezf6vo3Y0dSrzdLCVTBg8gkk0Ywwh/fvUV5Q+EagmZY4xcJkP
	ndwqhIJ5HjJFgX6Y+qkYjEP/nsNrN4jAXKHe2P8A1iZawSYvBMRTajC8Vun
X-Received: by 2002:a05:7301:1885:b0:351:29c8:643 with SMTP id 5a478bee46e88-3674cd33c0bmr2256286eec.18.1792566213454;
        Wed, 21 Oct 2026 00:03:33 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1d8sm6468910eec.24.2026.10.21.00.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:03:33 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v5 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Wed, 21 Oct 2026 07:03:23 +0000
Message-ID: <20261021070324.50533-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021070324.50533-1-w453y.me@gmail.com>
References: <20261021070324.50533-1-w453y.me@gmail.com>
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

