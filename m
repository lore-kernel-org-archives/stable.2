Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929165;
	b=Ez20FqcuxPJN2gvgcWl+ZzB+46PIOQP0btNgv/xAqkQBaVSpr7Sj/4igqRs+CGaGucDv
	 o0OkrsCY4+wUsKZeCh3OBDrO9wDpvdTT6jBgugGcjcNlj0LTTz9dRqc4uOme0AxgYTiAz
	 GxKM2iJ2UeQ6rBaZolvabBi6oPKR4c0F3+SLEDNp02riHP+GyrjLAg3TftkMdFvLGalrR
	 mS1Fu4Q5PaPXbzWAyrbUz6A6RcbqX6yXSGgbr2diEV3OcPX9yVCWQa1987q6mMQ02DGLJ
	 VXxKchx/OvAXbbbr+byhpEC+oGoECZunl3OK4RDZKclC+wJfE0QqXTCzHYWCYi+jIwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929165;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=oBpg59OO1kMaPB0ujrex8ItcYhjsVpQfat0sQyio4SI=;
	b=XpWGazBpRz7yxwjyeYrfPFuxXaj+0MO61lxpYuPx5YcRg5wFN1wFkHywrn9uEBC3vKPB
	 LhX0asEYAIyyZ9R1pRQhOtlv9mGrxxy5RqbTyzCj2qJmdAAvBgUjVyi8cNUQ6w+J+HAA0
	 csNd1pgTV5Yw70GRM5IEaZfjkm7unZlYcobWcdSl4CqUkSK0g3eG+2o7m7oaOuN0kwyZe
	 WaxlgxKuBsmQ8CwEXN7TGW2yAJTHb4zV90UFpJC80oq2jQ295/U4jgiegJyqbNkJi1Ltl
	 bZ7Ez/w90JSY0I8poctJ0wq5OcBIsXFu4Tmw+dvEzFpH5oN+MeqIlJvvTCe2uInPtqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vy1t2YjG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80C8606A32C;
	Tue, 17 Nov 2026 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vy1t2YjG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF261F000C9;
	Tue, 17 Nov 2026 15:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929165;
	bh=oBpg59OO1kMaPB0ujrex8ItcYhjsVpQfat0sQyio4SI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Vy1t2YjGzqjMZcntV+xbquzX3R4FdjbRMSfzcUGsUeNgkG7wk7PUkAsweDZ0zo/59
	 Cf2X/Q/htUL1IPqC+zOEJH/aMCFoxvWjSnRyfMj+4yMInyoMpkuU1rcSd63up3Dpkl
	 myR2OocoagQ8P8Mlc5ZFyteAhh2LXSBBN+tpGQ+l7Hbwt9wXjtGP3WWKTXXjovywHS
	 nXVecMUqEh7LwGbrISLYB1UTK9GoBxH5WX2mP+1ujYb4B4o20fDQdH5wx59kRF0Fbf
	 fWQ4HsguvCi5jo5n+6JUIomIWOnH7TuEa5Vma7b4yPC3Sg0Hyf0f14mMSUCy1nOwW0
	 zM+vetAB/JAPg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Nov 2026 16:25:30 +0100
Subject: [PATCH net 1/2] net: don't leak pidfds through a short
 SO_PEERPIDFD optlen
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-work-net-peerpidfd_short_optlen-v1-1-a93f56288501@kernel.org>
References: <20261117-work-net-peerpidfd_short_optlen-v1-0-a93f56288501@kernel.org>
In-Reply-To: <20261117-work-net-peerpidfd_short_optlen-v1-0-a93f56288501@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, netdev@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=2132; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tExZvwBhUmA3JsuAEU6JO2rM1IjNALcWkfhx6o28kmk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9KWJWdshoOXrrpvJclkPvQrx6xZdGbXa9vEHMsLFoV
 ZCw7YrZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJzmdkeDOrorNC+LnnZIPz
 KpPmaYplyDz4y3O3IntG9sf/YvMOezMy9F4yW7nzzZJr/2a2F7B2v7n6MOGe2fl5jy1PZHqvf+U
 fxAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

sk_getsockopt_peerpidfd() caps the caller's optlen at sizeof(int) but
never checks that it is at least that large. sk_getsockopt() only
rejects a negative optlen. So with an optlen of 0 to 3 we still
allocate a pidfd via pidfd_prepare(), copy zero to three bytes of the
fd number to userspace, write the short optlen back and then
fd_install() the pidfd anyway.

getsockopt() reports success but the caller only got part of the fd
number or none of it at all. It has no sane way to find out which fd it
has to close and the pidfd stays in its file descriptor table until the
process exits. Calling it in a loop fills up the table.

scm_pidfd_recv() deals with the same problem for SCM_PIDFD. Since
put_cmsg() doesn't fail on truncation it checks the size of the control
buffer itself and sets MSG_CTRUNC before it allocates a pidfd.

There's no point in handing out part of a file descriptor number. So
fail with EINVAL if optlen is smaller than sizeof(int) before we
prepare a pidfd. Since commit e10899b2a098 ("net: add
SO_PEERPIDFD_THREAD to get a thread-specific pidfd") SO_PEERPIDFD and
SO_PEERPIDFD_THREAD share the helper and the latter inherited the bug,
so this fixes both.

Fixes: 7b26952a91cf ("net: core: add getsockopt SO_PEERPIDFD")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-205984@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/core/sock.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index ad414878dc5ba..74a00a5e2d116 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1746,8 +1746,10 @@ static int sk_getsockopt_peerpidfd(struct sock *sk, enum pid_type type,
 	struct pid *peer_pid;
 	int pidfd;
 
-	if (len > sizeof(pidfd))
-		len = sizeof(pidfd);
+	/* Userspace can't close a pidfd whose number it didn't get. */
+	if (len < sizeof(pidfd))
+		return -EINVAL;
+	len = sizeof(pidfd);
 
 	spin_lock(&sk->sk_peer_lock);
 	peer_pid = get_pid(sk->sk_peer_pid[type]);

-- 
2.53.0

