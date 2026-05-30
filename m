Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145333090CD
	for <stable@vger.kernel.org>; Sat, 30 May 2026 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150656; cv=none; b=l3IAhYK0n8O3FHmno/ZnaMM7kU/2kQ4kBrPtBSMXtqhEtF7/sNACplLr9vAEPWIVFatNqQFnZcSs5PlTrdW4/3HRtyxhE3I2xfSPlJsAeFBLgzFSQh6SEBXu9fx83eG5frlQ73pnkcW5PqMsB2YGIlDsmalOB4IvzdCu6AVHo28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150656; c=relaxed/simple;
	bh=dOBxQo3pWcHKvhVF2CFqUzeBL2ZCvnCXbqiQrB181IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5D7VIPSeuyOU/949yEZADScT1wKAqb057ah1qjA6EZwSKB5oOqcgD7lSdmhU/EJHzL4eX915x1oBdq4RTnzkwU0p+y7COj5ndpwHL5+BwUJQk9Ki6YhrD9qmg8wV9S9jW7gq0oAFq4JR7rorJuhXhz9pFtPXppQxcgmcWzlII0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYTrO0K9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYTrO0K9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E3F1F00899;
	Sat, 30 May 2026 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780150654;
	bh=D8SQnT90rFd8RI2cYE/Gv2p8k5/YRbx4yJaiACH9LSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RYTrO0K9PaVUrP2EsVXm1pfooSHBmzoP5+/8Fu2gZO3UxHVcK3LqcMm0qMPwQyJBo
	 vTC41G89PzxfkGMOVRBm9maH8ky7xIIK0PagBTsFt9qP+H/pUulXCBPWIzibGw7uNU
	 MCWzLOTTMP5xFFdCfSMzngTQj/bU929W6Iobf0XSNYCO3QU1/sUbDkWMdfBlPMDWu+
	 L9QJaKkqF9N4ne1tZzhSFfvZDeWDcHESSxXV4tZkrEnLiWDffWd9OHB1f470BEokmy
	 temZb1ilxv6y2Vu18rkQhKV9EZDaJlHqg0PfNDYn2TdPe8eRGt5CpgZ+iTOGrSz84e
	 34KqGOEElEMoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] mptcp: reset rcv wnd on disconnect
Date: Sat, 30 May 2026 10:17:28 -0400
Message-ID: <20260530141728.2398427-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530141728.2398427-1-sashal@kernel.org>
References: <2026052851-deskbound-cardigan-c96b@gregkh>
 <20260530141728.2398427-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 0981f90e1a05773a4c29c6e720f5ea1e3c8f1876 ]

If the MPTCP socket fallback to TCP before the MP handshake completion,
the IASN remain 0, and the rcv_wnd_sent field is not explicitly
initialized, just incremented over time with the data transfer.

At disconnect time such value is not cleared. If the next connection falls
back to TCP before the MP handshake completion, the data transfer will
keep incrementing the receive window end sequence starting from the last
value used in the previous connection: the announced window will be
unrelated from the actual receiver buffer size and likely too big.

Address the issue zeroing the field at disconnect time.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260515-net-mptcp-misc-fixes-7-1-rc4-v2-4-701e96419f2f@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index abb9a9764b61a..59e852c4226f2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3329,6 +3329,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
+	atomic64_set(&msk->rcv_wnd_sent, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
-- 
2.53.0

