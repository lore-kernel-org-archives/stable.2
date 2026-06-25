Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7CD1A9F87;
	Thu, 25 Jun 2026 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411723; cv=none; b=JvvYgKGqQDCvFu5FP5xj9mS8G6DKkGRzsyBN2Fg0zF0MgCRPwITck4/ibFeNu/H4BSyKEPJmoVaZ9YtqLcETY8/SnfBn4mK4MDEOeVKrGx186iomk81bbQWryKIZXWvTUMJ+2bIHsv6PWI3iGg+ZTPK8kzKc80F36GmJK+APZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411723; c=relaxed/simple;
	bh=4kcohas5CotEUtuW1XN3cQnyi/ZXv7ymOPLjK33VnLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A5FQnE38fELWzDzFWpQcsUKgPRVi1RHkZOleVmLm2eN44HZ5hya0n2wC+H4goHoWKmLdwNz5roB7sknP2CTNtjP1i7MRz5MnY81+ceMB6/wPt2zK8A9/YfvYxRjGnLIt80FlzyjylZutQuvAW109n67vek0+SsQupo3+brRKDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw00Nwie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw00Nwie"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7ED38C2BCF5;
	Thu, 25 Jun 2026 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782411723;
	bh=4kcohas5CotEUtuW1XN3cQnyi/ZXv7ymOPLjK33VnLk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Gw00NwiePhxGqj93/zs7gmQ7fUk5KDFgNn6JmCojEw7JsbzPhdWwvgUDp418UyoG4
	 wdI6qO8BAUooBerF7oh8IFZ4Y3VCB7xzUINeett+wWy/rLY8Kepc5HQFA08A9qV4G7
	 ldATv5EIbU7lzucvwPChXn97ponDYLPC4LUk/R4rEHu3rstxzX2B1rtsHrzTMJFtbW
	 H+/O1ckHeKTjMkkdxA0iKbAYf3IC0R7dyAnPW6zw0dbAiJDZR5Y6VJwz0Zm7P/tSMY
	 eKke1mXr+AEWSTWTSFCItR9AGM2RtS0ft3jd7KFlhumiQxlpiQCyFy2tU3NvhxhcIs
	 Vfn5FXEZxjFXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BBCCDE000;
	Thu, 25 Jun 2026 18:22:03 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Thu, 25 Jun 2026 19:21:41 +0100
Subject: [PATCH net v3 3/3] tcp: Decrement tcp_md5_needed static branch
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-tcp-md5-connect-v3-3-1fd313d6c1e0@gmail.com>
References: <20260625-tcp-md5-connect-v3-0-1fd313d6c1e0@gmail.com>
In-Reply-To: <20260625-tcp-md5-connect-v3-0-1fd313d6c1e0@gmail.com>
To: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Salam Noureddine <noureddine@arista.com>
Cc: Michael Bommarito <michael.bommarito@gmail.com>, 
 Qihang <q.h.hack.winter@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782411722; l=1079;
 i=0x7f454c46@gmail.com; s=20260625; h=from:subject:message-id;
 bh=3nejDl07SxPQHPLWOUILyQffd40iVMwRdwvbto6+Q+g=;
 b=1z/VwT3MAPmFWz84HE6RimvnKtCVahxfjaRzbgTMqNxF5IGu7IsK/61L8Hc2WaP41sdb9eXS3
 WjExpgfhfjkAhtHHXccinyLQdcJpeswDO1XIjDX07Uss+c3E7Lb+yX0
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=clHVGbfKfZMeCUp+xCL/096jI68XK5EZLytgy6lSyrc=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20260625 with
 auth_id=841
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

In case of early freeing an unwanted TCP-MD5 key on TCP-AO connect(),
md5sig_info is freed right away (and set to NULL). Later, at
the moment of socket destruction, the static branch counter
is not getting decremented.

Add a missing decrement for TCP-MD5 static branch.

Reported-by: Qihang <q.h.hack.winter@gmail.com>
Fixes: 0aadc73995d0 ("net/tcp: Prevent TCP-MD5 with TCP-AO being set")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 net/ipv4/tcp_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bc03809ca3af..d7c1444b5e30 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4334,8 +4334,8 @@ int tcp_connect(struct sock *sk)
 			tcp_clear_md5_list(sk);
 			md5sig = rcu_replace_pointer(tp->md5sig_info, NULL,
 						     lockdep_sock_is_held(sk));
-			if (md5sig)
-				kfree_rcu(md5sig, rcu);
+			kfree_rcu(md5sig, rcu);
+			static_branch_slow_dec_deferred(&tcp_md5_needed);
 		}
 	}
 #endif

-- 
2.51.2


