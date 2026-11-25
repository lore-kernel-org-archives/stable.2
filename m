Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617646;
	b=1Yc1MgIVwZwzskN8Qx/L9vyaSH/4vpWXv31rmK9k8pLI09zigMrd9BxCfW9lugaJ89u9
	 TRP6P20jh9fPWP5xJh4ZzfZTTdo0WaZI/byBCxLRAdrugCtlK/LvEPxBwi4Gx8aKJbklU
	 bXOSttfMbZJYVOv+4stTqZY3CI5u+gB1AwekhjvtJic2P2PMPyEtYRw/SK4zBosiDEcpc
	 CLa6yQAkmJU0bHiIiJlA3AX0ZAeeFHQTleYSd+o0HreBt69RpgNe5Ls7inZQMtVQAOaVT
	 4M/9huN9QcJ+0KolxIhzgOigdmqKTDbJknEF/xdGXaGGT7h8P8ArGZMqyFKtjNhvT3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617646;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jGZKHNETnUIrnzDLr1EEAgSFc/+yGzaG2BJTwxdKe+k=;
	b=sCzbwsQvEEcuZX/bKnQh77bwFmx1AxqjWG1ySLh6DQgJ2tUJNMRSraDZgFsN/JZwIHUU
	 IaLpK8ZXKoFjflNBqdgxuZR1wyxaOIFKa2vvQSBWsa96Jk4nNZGAui7wVtKqHN4ymCD2d
	 Ete+tc4pOBC6Aiv2s1YYpFuVOQq9eZ0cnKexlk+eOFqvD6Jb9NJJH3ca/Jc8ggCxPjVZt
	 esUFkRPHlF+VKO2FtaSfYoEaHIxjWLEN05L6W8sAPMSpHLkQU3ceN2GBOmL4grjLKlJ2a
	 8pVsgdSfqzCsSWZ7JtJ48cUWFup0Od+3lWbtrLOHsq9BESepWubWwqgFp2IDQA3Pb7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YARZT9ho;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10E606A6A0
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YARZT9ho
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8961F000C6;
	Wed, 25 Nov 2026 14:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617646;
	bh=jGZKHNETnUIrnzDLr1EEAgSFc/+yGzaG2BJTwxdKe+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YARZT9hoaDKvqEZ0Y6aycF0IvKRDmwbwy7D22GfEg5pS1SknBqjTs4WfmVkEWU+aw
	 l8A0zPMUDaPCJXtc2m24hNY+C06a9zQkXtAQl74+TaPFKBACj1uHOnbKiD9EJEjjqm
	 nnpvrnx1OwF53+fhIMUoQpA+s+6XlrWksdRj/23WfINtfi3f3oxQJSzzrCtWgfMy5W
	 fjFvK5kLI5QpopBGI9rYxbQMFrwgV9goUzmKjLtskpXEp2NR7uzUqZoHPls/W/hwT1
	 9z9CtBm4d1sNucn/J+0pnccQ/J3DWOYGYl4Tckn/48rihjaHr+4fA/uQULC+Xz9Vjz
	 /bladhg1m6Bzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rongzheng Wang <testwrzwrz@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xsk: defer software checksum until the skb is complete
Date: Wed, 25 Nov 2026 09:40:44 -0500
Message-ID: <20261125144028.4032388-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112511-clergyman-gulf-c3af@gregkh>
References: <2026112511-clergyman-gulf-c3af@gregkh>
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

From: Rongzheng Wang <testwrzwrz@gmail.com>

[ Upstream commit f2eddafbfcc004098425fee7c5664adbe29152d7 ]

When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
calls skb_checksum_help() while only the first descriptor has been added to
the skb. The checksum therefore covers just the first fragment, and
skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
fragments are never included in the checksum.

Move the software checksum calculation to the point where the last
descriptor has been added to the skb.

On a checksum failure the packet is now dropped instead of being returned
to the application for a retry. This path is not reachable with the
existing metadata validation, but the behavior change is intentional.

Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
Cc: stable@vger.kernel.org
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
Link: https://patch.msgid.link/20261104034809.24545-2-testwrzwrz@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ sashal: Open-coded the final-descriptor software checksum call in the xmit loop and removed the early one inline, since there is no metadata helper split, and drop uses cancel-reservation semantics. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 1bc966669ec96..028791b80fbbc 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -952,12 +952,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				skb->csum_start = hr + csum_start;
 				skb->csum_offset = csum_offset;
 				skb->ip_summed = CHECKSUM_PARTIAL;
-
-				if (unlikely(xs->pool->tx_sw_csum)) {
-					err = skb_checksum_help(skb);
-					if (err)
-						goto free_err;
-				}
 			}
 		}
 	}
@@ -1052,6 +1046,15 @@ static int __xsk_generic_xmit(struct sock *sk)
 			continue;
 		}
 
+		if (unlikely(xs->pool->tx_sw_csum &&
+			     skb->ip_summed == CHECKSUM_PARTIAL)) {
+			err = skb_checksum_help(skb);
+			if (unlikely(err)) {
+				xsk_drop_skb(skb);
+				goto out;
+			}
+		}
+
 		err = __dev_direct_xmit(skb, xs->queue_id);
 		if  (err == NETDEV_TX_BUSY) {
 			/* Tell user-space to retry the send */
-- 
2.53.0

