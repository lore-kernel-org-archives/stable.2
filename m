Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3363B27FB
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762500; cv=none; b=sgq/WxLy6WS8OrBRFHdjm6DzQiKr6DLueRKFrw6IYQSv02wmqCo51tAA7kV+UU1MzLv2Mxg9FKaroF4ydTWA7FhbktOXLyF39B59svQLhPYm7Cty540m+TPRz4ALVxf3OJmKMIW2GmQ32yybOxOobliJZzdGHWmmOl0ETTVMLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762500; c=relaxed/simple;
	bh=NRl0RVLzWOmbPibdQaZXMWqXv5eJgE7Yhe07QrODhGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUNAR735EBIPtBxYFPotH/P+ccIdvHV+yG9U7WdFj/Wlx3uept45Xtmz84RuBoU0HQUHazdqodPmnyt7f6pA0TkJK6DQxon6U3mGyyEDMf0LEQvlyMH+BWoZ+i1ihFuwhcTxdOfkR2xmli79lM6B43sionvFJJwgwFRzdebGT0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGQrMPfO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGQrMPfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97AC1F00A3D;
	Wed, 22 Jul 2026 23:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784762498;
	bh=7efNdlhQ2wsjQruZypIDcso1nLJitCyAVJxNs3TC1JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BGQrMPfOBJS8iYUc9RWXKNrmN8Uk2zu3FUlCwbhaoqWDvaS8mvtdVJKu03iHVXR0O
	 w1Os1sSoky0lHaupj7j5m7F2Z7SsZusVokju8p17lJt9VPnG4YYej2IdjhoZnJZVdf
	 Vs1rYYm2kQ9f9e1U67Wtk4tGN8dqoT3SV+AFqKR81IXWzEbkOvA9+fOiDUV8M8r8XC
	 dyeVR8r6Rgr32fqnTpM0Q5HB+3NesCk78Twozbm/0CQlakG3grfz5XYIoUlBpfOfUs
	 er9ulMrbBKdjNDE9V9EGzV5RhFPaNxjPxTc/tVcOZcL51W84RK/8d+HutFBT5+mOpI
	 vkM8fBEmHy42g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] rxrpc: Fix socket notification race
Date: Wed, 22 Jul 2026 19:21:33 -0400
Message-ID: <20260722232133.2553162-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722232133.2553162-1-sashal@kernel.org>
References: <2026072025-implode-raider-540f@gregkh>
 <20260722232133.2553162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit e66f8f32f50116670dbbee5bc9e692cd2cd0c8f8 ]

There's a race between rxrpc_recvmsg() and rxrpc_notify_socket(), whereby
the latter's attempt to avoid disabling interrupts and taking the socket's
recvmsg_lock if the call is already queued may happen simultaneously with
the former's discarding of a call that has nothing queued.

Fix this by removing the shortcut.  Note that this only affects userspace's
use of AF_RXRPC; the AFS filesystem driver doesn't use the socket queue.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Link: https://sashiko.dev/#/patchset/20260616155749.2125907-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260624163819.3017002-10-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/recvmsg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index db93b05067ac89..4fb39d765717d5 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -27,8 +27,6 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 
 	_enter("%d", call->debug_id);
 
-	if (!list_empty(&call->recvmsg_link))
-		return;
 	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
 		rxrpc_see_call(call);
 		return;
-- 
2.53.0

