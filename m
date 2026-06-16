Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33CA46AF3C
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635046; cv=none; b=WdOarALzMTJx29Xqi71MI7sN4a9ocPwf8SbqJgjp0cr0eCRXSr3uCI8uWiq3WsK2Y74Z4T8sZ89rop6b74+E6mmIuKGuU2WBQlWacmbbfKEKQepVtUwdzanDDpvJIfoF6E3ygdZWPfTJvie51iYTeTqXBIKSH27MNhKmCaufDDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635046; c=relaxed/simple;
	bh=PZj2PhEExW/XMbCoVcIF2FAPE9rDiiDv6veCj5ow/94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ec2xRy+kyiaAVFBy+Bnh7y/SpHWiNJd+1Mys1qcqWNJfVHraTkfDehhP5SazeZDHx/MpunqN0NDVBZwKBwFceVDUX47UvbNi7ie0y8Th6bK42Bo64iHzbQg+04AU8B6w8YRYCCwBrNGIkZu9eLC/H3yXwtswgOJZeZ4f+MzIjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/SXEEpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/SXEEpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5131F00A3A;
	Tue, 16 Jun 2026 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781635045;
	bh=o5kwQyGbwZN/HYo7WG3uiylOYXq4OJItZtNKK4B7iRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m/SXEEpwU537u5xdhg9Aex7I7P5k420O2wz0DvEC4M6en6KMqbnE9uY0BfG9yQdCr
	 f2SX94n5RPmCDU415x+14tbOIPjLPDFdKivU3dSAwSekjqYJSuvWOWvm0NftmnSP3d
	 UL/OipZNUOy5kslJATWlTRTbhZQUg/2JKevSh17SspZPU5xPYr21MkuX/MB+s23g8/
	 h+sspJiungWe4jInZCim/DryUFmnQwHgwJBpvl+crQSYNuRxe8oaiJprgvcHP++kZZ
	 EDs8qkbG3JAHqev8sKnhgQcpODcxjGjehbg7nD47ZN7a8LIFg1UXNeBe8sdydKzG2/
	 GVlclo9IDRzOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mptcp: fix missing wakeups in edge scenarios
Date: Tue, 16 Jun 2026 14:37:23 -0400
Message-ID: <20260616183723.3474931-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061549-throat-iodine-b864@gregkh>
References: <2026061549-throat-iodine-b864@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 9d8d28738f24b75616d6ca7a27cb4aed88520343 ]

The mptcp_recvmsg() can fill MPTCP socket receive queue via
mptcp_move_skbs(), but currently does not try to wakeup any listener,
because the same process is going to check the receive queue soon.

When multiple threads are reading from the same fd, the above can
cause stall. Add the missing wakeup.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-1-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 70bc440c615d7f..136f010d4b26ed 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1555,6 +1555,14 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 
 	if (mptcp_ofo_queue(msk) || moved > 0) {
 		mptcp_check_data_fin((struct sock *)msk);
+
+		/* When multiple threads read from the same socket, the caller
+		 * filling the receive queue does not try to wake up any other
+		 * listener, which can stall it. Flag the data as ready and
+		 * issue the missing wakeup here.
+		 */
+		set_bit(MPTCP_DATA_READY, &msk->flags);
+		((struct sock *)msk)->sk_data_ready((struct sock *)msk);
 		return true;
 	}
 	return false;
-- 
2.53.0

