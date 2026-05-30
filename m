Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197E3A3E76
	for <stable@vger.kernel.org>; Sat, 30 May 2026 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141856; cv=none; b=IGn+rh8j34rNh+6RmkKVsuSDp3iv1fWotFeNoiNPHpFlIdhcg4WFKXezKyq1R4WL46uMuQm9M25USRdddxQzTwwtHGjevtO6LyGTaFSA7mnIFAqcSFZ9KmXjnEE7yJyFNN/llFqCImKBoy0fNiXSeI9/d8vatuXnQacQ++xuBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141856; c=relaxed/simple;
	bh=F5C3Wrap+D4btL7V0Oev8bPaDgvePv+d2kCSnrCQoOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saFvLYiq27YX+z5MMfjUNXv6NupilzotmXcbL6u5ERILygFvv24UpQQxnEE1ZSvK+DMmEXmWduRL/mEp6FBHQ6I//ybjUXQhhsHwLFt6nhi4JhdW51PkypusTn3S52KxpCIgLW0LMhB9FJ0vlh/wto84S8r3N7ydW5H27f44Dj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsxYQ/k9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsxYQ/k9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DE41F00898;
	Sat, 30 May 2026 11:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780141855;
	bh=oLTTtYLQTtd8HcyIkA9RN+CxtDG/jaxm6lyA/Pa1GpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PsxYQ/k968rKAOhWI8jrfKEZC9A2P5Ay3MtNetBvJiDm5SNYrYfN3uV9XciAwThCE
	 RmLHMNp2B1ezPJ6vEU+NkkXdAzfvXRhCtQyZbFiaoln966aYo3+nh1V4LsBt+vz4DY
	 xjR29zvRyFiHWfYsxFG2ZDnzYGhNSODUUpn/67H3a8xYhfKSgAuD1YM5pYX0EzpXFa
	 g40yM3kVADRIenJ7IiayIXn6eICCj9jz/VG/rFBbFDu0VFj0ataMW83KvKerWpltg1
	 0gaA05lE2BGP63DxID+IOgNGmvkvTRfZDAhXlM80X24zeMvSSxFRVrOM55MpcbXQVy
	 ClVJdjUr9ntyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] mptcp: reset rcv wnd on disconnect
Date: Sat, 30 May 2026 07:50:52 -0400
Message-ID: <20260530115052.1973393-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530115052.1973393-1-sashal@kernel.org>
References: <2026052850-revocable-pessimism-d52d@gregkh>
 <20260530115052.1973393-1-sashal@kernel.org>
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
index 5aede32e47f0e..9c69bce744d35 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3371,6 +3371,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
+	atomic64_set(&msk->rcv_wnd_sent, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
-- 
2.53.0

