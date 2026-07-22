Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664594334D6
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741414; cv=none; b=hv33Fnqs3bqLJ6K3+sl/X/Fde0E87l3XEPTz9ocUWTorA90wJHi7NaVR083B5+Atogs1XHABhHB98n1fNcHLY3xq3cICLUylSwuqMzPW+8HnGgMKQ9UKQS6pnjDKjEmaDPGmoWDSwSsaC+EsaGlNWaQViMz2R5+KvpP6e7H/Xm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741414; c=relaxed/simple;
	bh=/+FMQoSsKAJJ9gd49/NOQUkYrBeALCJmKAF9kBGS3vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDM15NDYuTZ/PHxkKqbBsAJrvbiP//WHI1gAxPhBc0oDp6QkTPuRR+sNjalDdYLfQCUofMMrc3Beo8vZMe0fLTxaXvr6KUCI8VWYevieKnBm7gVMxaoD7w48vn0VeJm7AQruvANXQK+hDMLX0AYdsr305cqgdCYS+Gga+d5sL6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR9aYSbS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR9aYSbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF141F000E9;
	Wed, 22 Jul 2026 17:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784741411;
	bh=DpqZcEMC0ZFJSR27Q0A/015mqiYWig+t/9fVPNmEv2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oR9aYSbSNZYIGe579cLKXqaI3i6PJj+ofJ08atOSnNU4az0LeEykOYBDH18dVY/KU
	 flTC3CcmAsZ+rw/+eWo/6HCrtPPdVOTeJNxMNNa7ecFKBhcJCEa/SPgmtE/M6/IBpk
	 LWjl710vRZn/kQpXpCe6Dr3rFPhtqnJT8+z5UfyvC3RJ2itZ81fmM42rRVBU0GNkEj
	 atXQ0ozhkdxt8AuujUxzvZLBUCHWYcT4ejqj9Mf2TvCecAVbbmYyqFGOSCMBY4pdnr
	 jdp+Er302vEQV7nUUjhBZFAJvvg5TBRySR5r1M75kdfzrDcLs+/BZk/Xv4pBELerKP
	 Pa6mCnIJEToMw==
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
Subject: [PATCH 6.6.y 4/4] rxrpc: Fix socket notification race
Date: Wed, 22 Jul 2026 13:30:06 -0400
Message-ID: <20260722173006.2069029-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722173006.2069029-1-sashal@kernel.org>
References: <2026072024-devalue-womanly-8b22@gregkh>
 <20260722173006.2069029-1-sashal@kernel.org>
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
index 3ff5a9b78ba083..7bf9727d9e5568 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -27,8 +27,6 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 
 	_enter("%d", call->debug_id);
 
-	if (!list_empty(&call->recvmsg_link))
-		return;
 	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
 		rxrpc_see_call(call, rxrpc_call_see_notify_released);
 		return;
-- 
2.53.0

