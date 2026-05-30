Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00503AB293
	for <stable@vger.kernel.org>; Sat, 30 May 2026 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141708; cv=none; b=AMUZ79u/ci/KV/0rkE0yxSE4ULeqRPJnR3g/6ehnGkSqaU9zgQIqY5Dgg6DDYlpW3u3BywZ/t8T7DAeQ4OBH1jBvHnaJY/PMRPz8K7sokdS/MVQhjBwD086wgvLQwoZxDiEppCa8MKrANWVcgIQaVmZxf4yKdRc/rkG0f6JyrBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141708; c=relaxed/simple;
	bh=lFRuATeNARUTQFt+bHBqyWHX02b64yEgk9gn9cBjCpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAw2USJq89QG+zO3iK/in77jdzK4I9faEDdQVdnk5ZPeEc/6X3Vh0pp1I2pEqdARXVdShwd7tjWtrlifrxSmNdXE6qc0Wbi1QNcklZnfulOC/ZxKR3BRuIxkLe7DPbRNaDqcfVbu31nZUC1dQFKRAAjSV1ZiVrmoSjSToOYbuh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtILWyAs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtILWyAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1443F1F00899;
	Sat, 30 May 2026 11:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780141707;
	bh=ZHlB9igaARf9LiBT+bMJ/Y87Rmv2tH8XIIOn6/MOwRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RtILWyAsT4mG7PhQEnUO1k9vPKwg/LcqjwMvZm27rvWVA7EmLTV2OL995e/uL17cu
	 rPhEW84pq94sAdytBb2UryqyDWBR60YZDTg3gel2ypIjOaJ1u1dwXywrJrbkvx1Hoi
	 GsYhR3ysiqZDl8yjMjvUAG3BvY2PPtCSNcwJ78JCKLHRGlDu/NmhtKsh7orSM/FMIY
	 TflD8g1FEdiRsHGbtFfD+8Sbc+bJ2yw+LwwD5z9K7jIUpIQVvQACly+yOxJDJEshcR
	 /YxoSAZPDMp5Mz1s7tegmNaicY841dCVPUpG9/yB4Ikce67JV7xeGfEFxkqLTWBvhB
	 vbW95vB4EhbTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] mptcp: reset rcv wnd on disconnect
Date: Sat, 30 May 2026 07:48:24 -0400
Message-ID: <20260530114824.1966673-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530114824.1966673-1-sashal@kernel.org>
References: <2026052849-concise-frosting-9b5c@gregkh>
 <20260530114824.1966673-1-sashal@kernel.org>
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
index 16ade718b27c7..ffb492816d0b8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3310,6 +3310,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
+	atomic64_set(&msk->rcv_wnd_sent, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
-- 
2.53.0

