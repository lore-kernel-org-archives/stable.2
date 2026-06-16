Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E846020E702
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569202; cv=none; b=htoV2lnydO5w+vMmHkSX1rjI+FCkFfzpBnqvxgOvSGvLHOI+W3YIEEDFXRzjMbK0/j+KFeqo2Mk00etiF6bR6FBkknI/UO2IKQB1FSkYOFtLjxzQnr7eupbcEOHUDUTuJmmKHFyQ4IqptFgDvrAzG3OUkZEruqIAKpQi0lh86EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569202; c=relaxed/simple;
	bh=2Wd+TqdB/cPhMX8DiKH3EA6d/zbresNVyPvcPqb+bno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giwJiqnx38wNhJy4VreImr+AjgyeqTwui++eIVbrQ7ssintlO3j/nxfFQbLWcs6icoGqVWDMB2tNZspVY1acjSezJF0CKH5XjvQ68TNO0i8UW2vcv9HSsJM02IfBuqpfk2M7XETjfkoqGKVmDzt4M8kWfGMtui50rg9X1IoK7zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgbwJ1wT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgbwJ1wT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073501F000E9;
	Tue, 16 Jun 2026 00:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781569201;
	bh=S+ESaddiXe7C28jZQPx8qClgWsqdOr5KZvHiPK3fH5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bgbwJ1wTBfypVEnFvnBLf6N6PMt20MwI8Ne9W6+j/zQYf2arGMKEkLb4e/lvZGyDK
	 zbUJx/yQoqTKnR61uzOuMWe2e8hU102I3B0jqAQ+ihCV/nkLt4L3OlNI1EkDfK9Etc
	 k4zIVMZfqw2wigeuFlynbwmJ8xv7EndZx3O0JXmYiPbjPfaOZY2WcyReiK5JOx9Oau
	 2WSGVnWLti+BMrH8n9wFv3fOg/n9iURCnwV7/63sCR7tOsm5F5S9TkcDkq5IZ833ts
	 THu2sSA2fvTOxpFvO658+/xMLkAMTkL0vKemcdWCW5MWxDv/BIOqmTXwuLOMltfxhd
	 C1zxtww9S++xQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] mptcp: fix missing wakeups in edge scenarios
Date: Mon, 15 Jun 2026 20:19:58 -0400
Message-ID: <20260616001959.2587348-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061533-ninja-scrabble-539d@gregkh>
References: <2026061533-ninja-scrabble-539d@gregkh>
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
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 32b2717b97ae43..f42c552ebac3b5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2181,6 +2181,10 @@ static bool __mptcp_move_skbs(struct sock *sk)
 	__mptcp_ofo_queue(msk);
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
+
+	if (ret && mptcp_epollin_ready(sk))
+		sk->sk_data_ready(sk);
+
 	return ret;
 }
 
-- 
2.53.0

