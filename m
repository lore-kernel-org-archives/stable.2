Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E993438AE
	for <stable@vger.kernel.org>; Sat, 30 May 2026 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158677; cv=none; b=ZPW84AErbPz6C9NM8qrJgGxS5vntLNB9/FjeFQ0vwwaSUQk8UY87BmBZXMb6sZPQYR4UEcRGndtxSkGd6wfUxXQBsUqPg2wsDFGkQHO8DmIIj4H9vg3KUYUh/2QxOQHB+Ovq8YDIwU12zQnH5zMbeWxo8sMOx7I4flN/mjoloxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158677; c=relaxed/simple;
	bh=2MPD0O1Anqt2jyEgCnr5+/rZcHdiM5vHzClpJMQwdj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLyuPWdqITObrWaOJ5mNRRlzcLLa5qHcd81FN1V0dllQc43leImrIwWM5uZrmZAe5XlIp+qjnNKArkV9kPVgkXe8U1c27v/LeSNUX8U4+zOh+QxCLVK0hrneOAlTvhpzVp7fFX15YI3hiSauLH15lAYLh8pQuiYVG0DDwy0B/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iS3w8iQR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iS3w8iQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506881F00898;
	Sat, 30 May 2026 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780158676;
	bh=LhK76MYsPnJGotrE6p4yuLiHET4clj3tJvvdZkKTznI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iS3w8iQRp4S3BZqZRwm00STMrAU7lA7cxaTcvNJUDFoYN4T73XUHnG3/0+50X4UMj
	 EU2c4aBTCzOx0VCLFD0FRP050ghX+qtlLqP5t7tG6BB3JgWhxrfIiGVPNDZgkyv/rQ
	 Oq2HOkEnTujN7GYaZJ4d9ki6wotmI5ocdlvOoYO58nMyhokk7ZCaNIEL65MesiDyFN
	 4t+/MUKX2dK2g6Me/CCAIvm9boSeS1Y7/ezYizUVyA+vBxpSVmmU8C2PAbSFTuIg4C
	 vTehgqj3CMK+drNpWxSiV4ifLrXMfvyd1usu2vocugYDcmJgm7MfKYCzcxu1LIwWUn
	 +aCmSmb1x4skA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: reset rcv wnd on disconnect
Date: Sat, 30 May 2026 12:31:14 -0400
Message-ID: <20260530163114.2911574-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052852-legend-goldmine-0cfb@gregkh>
References: <2026052852-legend-goldmine-0cfb@gregkh>
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
index 965819ddc04c9..7aaa1c9f2d95e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3293,6 +3293,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
 	msk->fastclosing = 0;
+	atomic64_set(&msk->rcv_wnd_sent, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
-- 
2.53.0

