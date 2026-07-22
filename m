Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1673EA949
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736494; cv=none; b=cT55fjOY//pUtzOb8bmrJsF+lEcIqkF+Lvrr24FCeGWppliNQBvq3Ceh4OvnocCdr+SkP9cNwQIPmbVAPgOZv7i9YHgS19PgpsM13QGTOk3nmfTCpWOyTQ0ACl1TPP1AFVgl3iYNRQeh1V53TEIwAtSMRNXJYd2R/RI2hiywwek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736494; c=relaxed/simple;
	bh=/+FMQoSsKAJJ9gd49/NOQUkYrBeALCJmKAF9kBGS3vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foy7uCeVQzg6E0Z0Rq3Zf3JAjrWzr1QauSHaR5j18HCgRRi2SiwFU7QMjCUM1OPjd387r6O6GhsrhioEuNWkW2r08zmjVEGPhzlfxDtbijksbOyJkPE2gG8IX9xLwYLN2OMKZjW1cSkOS5txdso1BxmgKLwzYePlRBnXWTsIccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4YEYQQ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4YEYQQ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC0A1F00A3E;
	Wed, 22 Jul 2026 16:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736492;
	bh=DpqZcEMC0ZFJSR27Q0A/015mqiYWig+t/9fVPNmEv2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i4YEYQQ9hH78w1JCwMlaW0Tl7jZnV/7I2yazXaLS8gu2H5cq0mv01wNKRDAYp4Ggk
	 okbHRDnJOPnL8s9SCg3llqXP1C3TnQEaY94y3Une1wM0oLLJtg7fDWi7HXe0Ls7c7u
	 m+4Rlo8i77ljFDrpONyOrb82WyH0JWDPaeDPzAQ/wzv5vLe2VkWeu8yuR+fqUcCz0r
	 1dx0gMh+JkQQ/dwGYvff318H8HMQ8JCJqRaDLnh8yVNzepaYUK9LxAyBerS0GY8LxR
	 0JGIEo88iMYyItRtHi8gO7eSfw3Bsz5pjxyLhwMMB3OtQWyivbflQiiveC6qbhkw6g
	 4wr9dMGMVdzAw==
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
Subject: [PATCH 6.12.y 5/5] rxrpc: Fix socket notification race
Date: Wed, 22 Jul 2026 12:08:05 -0400
Message-ID: <20260722160805.1741176-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722160805.1741176-1-sashal@kernel.org>
References: <2026072023-cricket-devoutly-1a61@gregkh>
 <20260722160805.1741176-1-sashal@kernel.org>
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

