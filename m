Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622485;
	b=bsl6cEvVNMtK7rhbVNpjQyNsqXojmKvYmc1WzqXPyG5zjMDbq9FZJIqZ+ua/JYM63iu6
	 fYpOF8REkP5tOu3Z7NURhLxDYsrdM47EK3ExYcF55GnLsAXijGmJJK2F59e5K18BQ+tX4
	 89V0snaA2HMOaDoCBaURHmOJFl3iYf6tSMLp2AABPzQb0H9Gw55WwEe4HMwUP87drlFSj
	 EWSS+BaM5hDhdZKuavANC6IyMeewOYP0LTHyizoyX1JL8Hwm4cYSw8IcpB+Hk2sJpZ6se
	 ErcjFCHF6dqIVzl+zXkL98ZPa36HJOQG9YHot9S8SyFzefRKCM2vTSb1Ss5DZFDUHOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622485;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5wi0RTWvr5zNAwNppzKz6wh41SHaUYeBDlJyohBo0W0=;
	b=MKjs6HiRwFX4YpHGv1gMYG6tpsmhrUwtUiHCQ8NiV+O/nC6ByyKuHdckiRSTeIvG0ir3
	 CnNfWQ3I6Er8qw/z+nh3QX9vpzxksnhdvxPULDhp2DaoT7SIbjRZTDmLYW8EQKn+IBYSp
	 avDEpF12MiALraKPC4a2dzgpIG2nHTV6hOy8MrA5F6laM1pxeXbsbncsoJQxuyNnL4t55
	 Y+cuoVJCkyDjla6evFTh42YCvYVyWlfb6VTHt+UukDqczqWZiEesf9SxDPFDvBxRHDzem
	 DUSQs7+ZlRC8nre5A0iiasvxwde6u+x5S44xVLWSNRzO1kDTkx7HelREPMVgkuCHogg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUsWRpU8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B92606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUsWRpU8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76781F000C0;
	Wed, 25 Nov 2026 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622484;
	bh=5wi0RTWvr5zNAwNppzKz6wh41SHaUYeBDlJyohBo0W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KUsWRpU8VmT5B2rPsJqcDIUw2paO00R/2Yltpk5Lkj957nVXRUNNpDWsN22wku4zv
	 0KQEPHrcVW/Bd2Ra6AsCI+ZQvtGerXBYIIRJleh6s0HOhkiSzTlQKWihw2QS3c+0+G
	 U6IZ/UN6lewZOfjpe/gR7OSWzdUlKgwLVTf1yWf2d8i4/7rL8ybbh+FSi1+Gr5T/0X
	 GMZA1s5ExdhvaNU82if0+LIOXLwRvrXQetO67vskVjqugZh8sjyvabkJnfwoeofHP3
	 MZfI88skEAZTcz8HQL6HWrvowas9TLfygxXaGcYH6LdMG+VgJ9rg/4LM7NMVJuDfrd
	 ela9IQK5oZ2vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ignat Korchagin <ignat@cloudflare.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] net: warn, if pf->create does not clear sock->sk on error
Date: Wed, 25 Nov 2026 11:01:19 -0500
Message-ID: <20261125160115.575356-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112501-gilled-capsize-0004@gregkh>
References: <2026112501-gilled-capsize-0004@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ignat Korchagin <ignat@cloudflare.com>

[ Upstream commit 48156296a08c615a6baae514096c4b2e543d1157 ]

All pf->create implementations have been fixed now to clear sock->sk on
error, when they deallocate the allocated sk object.

Put a warning in place to make sure we don't break this promise in the
future.

Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241014153808.51894-9-ignat@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 82052e5b5ec3 ("netfilter: nf_dup: preserve guard across NFQUEUE reinjection")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index a143b8f577bd9..b63029bfdee92 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1559,9 +1559,9 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	err = pf->create(net, sock, protocol, kern);
 	if (err < 0) {
 		/* ->create should release the allocated sock->sk object on error
-		 * but it may leave the dangling pointer
+		 * and make sure sock->sk is set to NULL to avoid use-after-free
 		 */
-		sock->sk = NULL;
+		DEBUG_NET_WARN_ON_ONCE(sock->sk);
 		goto out_module_put;
 	}
 
-- 
2.53.0

