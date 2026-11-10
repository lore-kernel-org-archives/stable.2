Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332111;
	b=A4CgmyHPXhekVM1iXqjCk612TRfXpwaG0Nb+eQ1r4Rn3V9G07Zw87cRSYJdHjB2j9dEW
	 F896Pjm9ueMdz2bFLV1NpMRViLYP+75jhkvV6mzt+PVrd796GQyfZOR7d/gQibVixaW5d
	 kvIooaluzgp2ic8rO9Q11hBsuTBFiD8+251DYsQXRbDOP3j2Ewwi3zFLM58zsWHeAXi/6
	 nXlVyba+sqTpjNQGFZt2XtjYCAW5OCUI5a99i8/bpXRGGWKwE+FnWFcQeNFqiIgHD2XMT
	 9884NLlAuC6dmuOXIc2PXkST4nPiu8LjqcJilDA6JkYzsiADcR2x+hLvbw5tk2Lx3Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332111;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cFmWaPs5D0yGL0O3YjXPv/YW8X/BYAv3BWmaKhJv2no=;
	b=ODKRHbVOT+FO98zRMWB3Mv7xolPvbXVUK2Nbv7Yjq/DA//+bnv7EZlaPIPQINQXYeMCW
	 PkTsCThDsQ2D/5SJe+QxUVKfg0k+bLbyqgj0evWCpO8SgBk6MjO1ANPFL6k4JemPNAdqp
	 8gE5bKNrWhdjKPX4iHCA200vNhBJKtot2rrKgl9rx3XcqqQL7q8PcIz1RPTsf/R1qPdwS
	 sVsroPKG3bIZokVFUaxDE07uMzOrxlAngcOIzFlZQsqUeJPEKx8NLvqlVkB7oLwGMvAAt
	 iToGWygTbrNbGjbwd/cjbQrp+UfrrwGWAGvZnVPvgrA7FOVJbJFicYT3drgwResO19Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IPn6BnCG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A48606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IPn6BnCG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF961F0089F;
	Tue, 10 Nov 2026 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332111;
	bh=cFmWaPs5D0yGL0O3YjXPv/YW8X/BYAv3BWmaKhJv2no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IPn6BnCGd5FHQ7SVFOvgkTp09+JL2xedmfZKJLIcHTtvpYSKjneJb3VPZj1qeYFm7
	 AxLzxhvX8y37BKBPoYg7X+qet1AueMKwGFnXqee2fTFTpYHm7svJ36f6Ft71Hus8v5
	 9a9nJoh1oeC9oljY1CVTl7mHsq3h148Wc+oJdAghMeAA31vmC+ApyRHyGP+6p9IclY
	 VcSWiNIjiMVbOK2qjkdGC3VsjYR+Pl/Lrmfn//NyPVT0J9K20bNgviI0gJN6PYc1W9
	 hfqStI0QX5o/xr2ZAkUNUJCWmJZLktfj2w9sp1H1RpOLYjasYVHafKs6yH9qi0Wv/4
	 ddmhfKJakvNqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Quanye Yang <quanyeyang@proton.me>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: reset msk state on early connect failure
Date: Tue, 10 Nov 2026 12:35:08 -0500
Message-ID: <20261110173312.2889107-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055040-failed-6.1-29afe67082b2@kernel.org>
References: <20261107055040-failed-6.1-29afe67082b2@kernel.org>
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

From: Quanye Yang <quanyeyang@proton.me>

[ Upstream commit 29afe67082b2d33ab2e90c56c337235d725f023f ]

mptcp_connect() can fall back before the subflow SYN is sent, for
example when the netns is in an MPTCP blackhole, token allocation fails,
or MD5SIG is in use. If the subsequent subflow connect() fails
immediately (EAFNOSUPPORT, ENETUNREACH, ...), __inet_stream_connect()
returns while the socket is still SS_UNCONNECTED and never calls
->disconnect(). This was reported by Clashiko [1].

The error path only dropped the token and moved the msk back to
TCP_CLOSE. MPTCP_FALLBACK_DONE, allow_subflows and
request_mptcp were left as after early fallback, so a later
connect() on the same fd stayed TCP-only.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/633 [1]
Fixes: 0235d075a592 ("mptcp: mark as fallback even early ones")
Cc: stable@vger.kernel.org
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20261013-net-mptcp-misc-fixes-7-3-rc8-v1-1-932c9b182fc7@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: retained the -EINPROGRESS exception required by the existing inet_stream_connect() error path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bdace644dbc6a..2084503567789 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3937,6 +3937,14 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	 */
 	if (unlikely(err && err != -EINPROGRESS)) {
 		inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
+
+		spin_lock_bh(&msk->fallback_lock);
+		msk->allow_subflows = true;
+		msk->allow_infinite_fallback = true;
+		clear_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+		spin_unlock_bh(&msk->fallback_lock);
+
+		mptcp_subflow_ctx_reset(subflow);
 		return err;
 	}
 
-- 
2.53.0

