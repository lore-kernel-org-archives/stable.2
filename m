Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9723F482D
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664718; cv=none; b=G8JM/oipF4003TvRL0O0JX6r4N9H1mFc7OWipvbXwfBqyW8O5ZVVIxa+UxKzJ4n0g4p9SwNFstts4CbJG2aO0dnjDaAIhGQHbK9lQq0rH6sIdcD5dIzeQfaBkdLy5rdNkHgVKqGVkZ0qXN+LxXdVe8emNln7S64Idmmx7a7EjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664718; c=relaxed/simple;
	bh=7Y0n7QHpVv7Nw0bFsfTstE4MXhPALfEiort5yoWVCxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CP/I+wj1/6tsZRCFOXp6ZrFv/HH4BTsmLW6CRYSyZHmyh524T2kCFq2JE7whNScSgUTULFveO+byf8TM4VdavsU9KWBIkzDjmRjPiyzhGGefOy5Kh7w5/Aj5orCfT58kIGqcgcUo+utZsRxHmavWjalhQWh8Q1sAYOWgMhyLmc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9IoPUuV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9IoPUuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC281F00893;
	Fri,  5 Jun 2026 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780664716;
	bh=IG4GpsUDS/TACICdWeWDVQ9nYDNvKCPI/gDS1qt7NqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J9IoPUuVOpF+guiupgwxYmld239ppV9errAgUHKCEbeAj4HU67tONrcquIUGCMADc
	 GQ7AwWrr0zWKhuMHWVKazlcYv94GG4zupuiMj4Hp0KofUrdCAiue6IW2Vz2cCNrHbZ
	 XNI/+yJKQPeGA3d3OVDCk4Izv8OVITN31Hw8zUYwdvbrKoQhKJaiyKgiZkwAaWDDAJ
	 3Q10ihVwohr0JSOTYdWakPP112Wh7cdJWSBQjdB/MPbYQkDx1juDkC3qy5w799YmHE
	 Tu2ogUXTu06MjifpdMVd46qIdwWKv9mVHEXOnSuzSUMYgHmJIYi6Dg/sgYfq/jQ3J8
	 9NyjmKdhkUakw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhengchuan Liang <zcliangcn@gmail.com>,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Luxing Yin <tr0jan@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfrm: input: hold netns during deferred transport reinjection
Date: Fri,  5 Jun 2026 09:05:13 -0400
Message-ID: <20260605130513.410471-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060459-existing-wooing-a148@gregkh>
References: <2026060459-existing-wooing-a148@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhengchuan Liang <zcliangcn@gmail.com>

[ Upstream commit c16f74dc1d75d0e2e7670076d5375deda110ebeb ]

Transport-mode reinjection stores a struct net pointer in skb->cb and
uses it later from xfrm_trans_reinject(). That pointer must stay valid
until the deferred callback runs.

Take a netns reference when queueing deferred reinjection work and drop
it after the callback completes. Use maybe_get_net() so the queueing
path does not revive a namespace that is already being torn down.

This keeps the existing workqueue design and fixes the netns lifetime
handling in one place for all users of xfrm_trans_queue_net().

Fixes: 7b3801927e52 ("xfrm: introduce xfrm_trans_queue_net")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_input.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 0c3fa01ec67a71..7a2d7048a49112 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -777,9 +777,12 @@ static void xfrm_trans_reinject(unsigned long data)
 	__skb_queue_head_init(&queue);
 	skb_queue_splice_init(&trans->queue, &queue);
 
-	while ((skb = __skb_dequeue(&queue)))
-		XFRM_TRANS_SKB_CB(skb)->finish(XFRM_TRANS_SKB_CB(skb)->net,
-					       NULL, skb);
+	while ((skb = __skb_dequeue(&queue))) {
+		struct net *net = XFRM_TRANS_SKB_CB(skb)->net;
+
+		XFRM_TRANS_SKB_CB(skb)->finish(net, NULL, skb);
+		put_net(net);
+	}
 }
 
 int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
@@ -787,6 +790,7 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 				       struct sk_buff *))
 {
 	struct xfrm_trans_tasklet *trans;
+	struct net *hold_net;
 
 	trans = this_cpu_ptr(&xfrm_trans_tasklet);
 
@@ -795,8 +799,12 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 
 	BUILD_BUG_ON(sizeof(struct xfrm_trans_cb) > sizeof(skb->cb));
 
+	hold_net = maybe_get_net(net);
+	if (!hold_net)
+		return -ENODEV;
+
 	XFRM_TRANS_SKB_CB(skb)->finish = finish;
-	XFRM_TRANS_SKB_CB(skb)->net = net;
+	XFRM_TRANS_SKB_CB(skb)->net = hold_net;
 	__skb_queue_tail(&trans->queue, skb);
 	tasklet_schedule(&trans->tasklet);
 	return 0;
-- 
2.53.0

