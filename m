Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220436D9F5
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789247080; cv=none; b=Cx619V79nRSHX91R+YHmp7bfoGuSydtJYfqimYbthw8CsFFjbfGnJbq83B7CmNVJGGXBbC1ewPB3ew1gzPnd2JgboDUqLFldz4LfbI7Q0gel6LYK5JZBgAPbBPalRWsyLecS5LrHMU5M3CUDXFadyD+nTIKNv5ja1ndzgCM0iEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789247080; c=relaxed/simple;
	bh=26+4uDMqHSjkecVezK2n0989DgUHxKLblb9AeRgPeV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6YQDqQbEYqU4vVWW9kKPSDZkRtcu8B9kPtZU07XPNyXxMUqPiueCi6DieZNermodjl7F1HgQtf3X97qvJVZNALlpJESGBRV2Qz0rrWWRSuHgi5O/c266OkBRv+1VzlZs4igSIhW34sz8AhlWBTVMuOdaZPTbECNBQyLRIEEfto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMEhfeHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMEhfeHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E591F0089C;
	Sat, 12 Sep 2026 21:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789247078;
	bh=Wnpb1FzDq/KUuj4lI0HQQTwsLdQNnuL4DvQlQuAKtmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JMEhfeHWR6ihdeK8ew4TV2U8tNWsYEeYzpdrb8fX/Jb3VRFw92ZVDtWzp/OU5a0QH
	 71LdBeRefPl3qgdeldzzZHUACTj8nmxn3kwMPEb4Zp/VK/B3MvFZcvU3YmB1b5QMN5
	 oDLAi3Z/oD1H3dMvVRiTntg1OO6HO6G40KN8CaEEPXztimR1G8kA+B1g6YO5nF6eNa
	 AQVzcXvAk7e/4WXE1lwkAKG3m7Jt3fkq3oSGumkrLMO/EqEXJwqJyGzW68lfQBkHDW
	 F7SZgVfW6NLqef5Ng5rgunqCHWGa1GKd85WBO0ronsLYfR2ICiuE+Lrs30z3bJVtS4
	 zftnfEX8BI14w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marek Czernohous <marek@czernohous.de>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] drm/nouveau: unsubscribe the channel-kill event before the fence context
Date: Sat, 12 Sep 2026 17:04:36 -0400
Message-ID: <20260912210436.3939374-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912210436.3939374-1-sashal@kernel.org>
References: <2026090932-swab-frostlike-a716@gregkh>
 <20260912210436.3939374-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marek Czernohous <marek@czernohous.de>

[ Upstream commit 511585987d27d8cb668acebd399fc4deda23404c ]

nouveau_channel_del() tears the fence context down first and only drops
the channel-kill subscription later, in the middle of the nvif object
teardown:

	if (chan->fence)
		nouveau_fence(chan->cli->drm)->context_del(chan);
	...
	nvif_object_dtor(&chan->vram);
	nvif_event_dtor(&chan->kill);

The subscribed handler is nouveau_channel_killed(), which calls
nouveau_channel_kill() and from there nouveau_fence_context_kill() on
chan->fence. A kill event delivered in that window takes fctx->lock and
walks fctx->pending on a fence context that context_del() has already
freed.

Nothing reaches this below Fermi today, because the subscription is
gated on FERMI_CHANNEL_GPFIFO and nothing kills a channel there. On
Fermi and newer the window is real but narrow, since a kill has to land
exactly while the channel is being destroyed. That is reason enough on
its own, which is why this carries a Fixes: tag. The last patch in this
series subscribes Tesla channels as well; nothing kills those today, so
it does not widen the exposure now, but it is the groundwork for a
recovery path that would, and the ordering is better fixed before that
lands than alongside it.

Drop the subscription before anything it depends on is torn down.

Fixes: ea13e5abf807 ("drm/nouveau: signal pending fences when channel has been killed")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
Fixes: ea13e5abf807 ("drm/nouveau: signal pending fences when channel has been killed")
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patch.msgid.link/20260812231330.705425-2-mczernohous@gmail.com
[ replaced nvif_event_dtor() with the older nvif_notify_dtor() API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_chan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index bef84589130eb..33badbc4161a9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -93,6 +93,14 @@ nouveau_channel_del(struct nouveau_channel **pchan)
 			cli->base.super = true;
 		}
 
+		/*
+		 * Drop the kill-event subscription first.  Its handler
+		 * dereferences chan->fence, which the fence context teardown
+		 * below frees, so leaving it armed across the teardown leaves
+		 * a window for a use-after-free.
+		 */
+		nvif_notify_dtor(&chan->kill);
+
 		if (chan->fence)
 			nouveau_fence(chan->drm)->context_del(chan);
 
@@ -102,7 +110,6 @@ nouveau_channel_del(struct nouveau_channel **pchan)
 		nvif_object_dtor(&chan->nvsw);
 		nvif_object_dtor(&chan->gart);
 		nvif_object_dtor(&chan->vram);
-		nvif_notify_dtor(&chan->kill);
 		nvif_object_dtor(&chan->user);
 		nvif_object_dtor(&chan->push.ctxdma);
 		nouveau_vma_del(&chan->push.vma);
-- 
2.53.0

