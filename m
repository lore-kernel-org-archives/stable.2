Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436768;
	b=CkZPk8YzBQpGNtowOE2J1v7AMakbQckDwY+/NtpDGyCZ/PHdNHocvg8lA/3lIuOSgDAe
	 HSSbmV8DdWP0/zGW1a0DnA+RC+vhcRGH1V2UUIuKspq3Wix3mBFXuwRhLWyGsTR1iE597
	 Sc5ZR4SdjYldYAFVREJC5jQZrggODHgLCYtCezDIo9S912moxJRIvS6FLFO1SE5KwmNIf
	 qoXLfilTt0pkvNHmvGB911xB+HlpXEkbtBEbyQPVf2Q8jM920fJZjaZcFrdjtIfIr1vBW
	 I7ICeNeFz9qNIEKUWHjV9x2lFV8P0UO1g8m7d/Hhi2GYTY2Kyi/079fv94IivPlxA4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YMGKjMwOlq6w5EX55Ph8mpyGT/IFXfzZRRGc1xWK8zc=;
	b=DLWeeQdQYnVtxwVnQxP3lC0hsCICjEfHhM6/qjFeahvoQHokcyswH0XrNv8JyZippqsA
	 kuUsey44Cuc2TWhl4WZLzW6b7joOp/XqU9G3HVXhX4AiPwPSxDTuCI7kP3qeTKJW7K+Q7
	 iv+wYqoBtO0J+qd9zlSe6HnEgnbmNLRtR1pBn3H+8g2VxJ3/njl8Sk8PiRmo+c8ByKaMO
	 2I3aX6KRg/MChkClVtXzOnl6IKC3E9NxUIsxu8r49PddLKswktPNvjDwQohG+ABlI6Zwv
	 XLw0llpFuzB4n3oJRPDMTYqbqoRbRh/RoszPXCSsaSF1sIlpRSw9uQDOVeWCLH/CGNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NXV0Tb63;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD30606A320
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 19:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD30606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NXV0Tb63
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-354ba08cfd1so4485162eec.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792436767; x=1793041567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YMGKjMwOlq6w5EX55Ph8mpyGT/IFXfzZRRGc1xWK8zc=;
        b=NXV0Tb63VOMf+OISXC6JR2bdyqQe1xmZpWd4Ni2WJCuS+9ENatRUKtIZ6Zcw1iq0zd
         0M4axRouiMFzmWLPP9z8eEF2Q78c5niCcCkilBWnFug77RFmk2pzLgxd5BhcyQCxQjak
         njMOB149npty2KHSd5rNIUr/khILD2Ny/o4/EeMN85xiAMo826s4ruj19Bo/6Y4LgqBQ
         rcADtSRYHft3hSyrZaGIuaELgp2hq6u1RIqPrtDYEgE+HshPGzRLHEeleyuEyo1jg0mI
         DdgsR2O1oP8icVc2vU+nH9rXc9oLpKp/aNP7bxZwRLuB/rWBGzMMQMQZ6NMfQgi4sqEj
         P2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436767; x=1793041567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YMGKjMwOlq6w5EX55Ph8mpyGT/IFXfzZRRGc1xWK8zc=;
        b=CZY0Eb2Y1JJQ4NvZ9QSX0ECv05bG7eN8j/LLbYVIGBcSYlbb74Clm2JkVn8VMSj61W
         cbg22/O1TekmwyKxI42qEVjg551WBHOmz3Xvb320epeBTVTE4k25jOrjquarQeJJbyxM
         LRPund5PeugovJtnOx8SomrC/Nq/6IUkFCIjOmMiY1HPMVLPGCOAVOEc9nETykNbDdfk
         ZaoAZDo2Gzl1Rm0itzkRyc3wKPg+EbrDka1qqXxAh1x+P+YRHpFW9SaLGwPLKIUWSP7+
         n3ip/PP1Lo8U3kqZWiMDKFX0jlKiXV06u+cTjg9VchPj8mlH1pEqP0XgMiuowmsGBO6p
         P0bA==
X-Forwarded-Encrypted: i=1; AKwUvBx0dTUnsBBUh+49xBI2cZAm1spO+tTDIEHt481oTvGVerFjCrjnej/m53KCnoAVSHZ2zYZTKgk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfVfAflXENtYO3Irzw0fYvkrh9Ony+BLZDJDl5V2UyXV+YS7yo
	+Zp3dHohy5Obncy5noBaFmLwlixQpCdxWFILU31Py0aR8rby8O5VqpNv
X-Gm-Gg: AYBFou2L9oQxGFsi3MijlBqm3WNArjUw0QWvRz19SRf+ef5pvKWOicL12smdIKnaRfC
	TkDMDY3WxPXIUQ/x4HH8CC57yBvDFVtIc1LVZjsqgknXyzyn1m7vk+u27zUmFQ4wdjmNicvCd8g
	1SQ7t9rm4j/L4hLvk419UAHWotpnXUnO/6QLa9J9CUgxkZORlcd1cxpOHSKh7xVQkk5byReZWry
	KUitIFaTubaJZAAm/WvYF7DVKxe8LrETXu+yUiPYlDF6N4AUcP4KhwCKWGpj70EvGf+r/SO8Mhi
	6PdrBVNNJRwZjVrwEu+7ulQ3eYUBQckjlJWhAfkNN6OU0QtKOifUpDe3RJT1gYagijpfbGlP3Lb
	xtphFfKgb+eze+lhZzU6q0YPXGPPwS2zGS+3jj/+ogpjCC2znXDtR6iCqiF5W7Ox/l6dZLmXHQw
	B2gZxYstShcc64JIESQVDbRso0yxuQddgCPcpfX2dnSkLzH2gLWlOELO7MjDM1q0QvoEpA5Dlv1
	haJK1U=
X-Received: by 2002:a05:7300:10d:b0:351:1e89:66ab with SMTP id 5a478bee46e88-361a0e85fc5mr12489234eec.7.1792436766863;
        Mon, 19 Oct 2026 12:06:06 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm62848024eec.24.2026.10.19.12.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:06:06 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v4 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Mon, 19 Oct 2026 19:05:57 +0000
Message-ID: <20261019190558.465270-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019190558.465270-1-w453y.me@gmail.com>
References: <20261019190558.465270-1-w453y.me@gmail.com>
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

