Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261EC346E6D
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789246920; cv=none; b=T9bvHgYZgAq7WsdwAYjriaDb417H/m2gM1XAwCRl8dM0tS1H1nf5beBgaWrt1D3olOtV7s+aZjQu1KUPygvBM1x4mODhfKqoSNZlqe82hDMiyUshuLIWTaa/7nZ9lHX1SktFQaA1+uZLQZdI3SuaTWeISLruZpFwmJgvgP7tR7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789246920; c=relaxed/simple;
	bh=e0oJB8ggHjykOdK2WiZad4gVFm03Z/+y2C9PY5Jk8Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giSbGZDN8sXTDwSd0yvVqEiyHI58WQBc1aXED+BR7VFwQdw1QCRyW2omT0A56DyO7Sw/Vos5szq/b6PA99cY15cpT8PPUlh9W8Nk/lIZSCQY7ABGzr3u/w5hg/meeqgY8yyJPMuUZ15Jyt7/75RaL8V8aGxAeZBA6B+75UArsHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUptBtZV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUptBtZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FAA1F0089C;
	Sat, 12 Sep 2026 21:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789246918;
	bh=rlZZN1/aACrp3RCT6mQV0wKEunp9OTnPWK7SXpQW3b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PUptBtZVxv1T5ZLX8DmEtjdNbB16Yh3ZqC66KVbmObSprZ03Z4vDFjDrik3aNhTsj
	 AGBC+RmJzqYQtUo5mUYeUsd+ybHsTUXl73R803CgRC1cFrUQAbEulvKK5zGPWU221X
	 qa3KtCMm8Whvnx+ha/kwMprvKeBtqHwVkkEPCYGh3YcwwdMHzW1w1P5eFdfqvZgKEe
	 Mj0xEcwB5z2byC2fPMFhof4SH2RqI2DVWt3tQHQUYt4pnm7kET/VGMXmNLpuiC2UvZ
	 C0e+GGCQW4zLQldy61UqWS+D0WVoicdHhyxGyrsBWt1iIczbjVocWCGSCnMFTKT8jW
	 DqE16oEMPb4Kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marek Czernohous <marek@czernohous.de>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] drm/nouveau: unsubscribe the channel-kill event before the fence context
Date: Sat, 12 Sep 2026 17:01:56 -0400
Message-ID: <20260912210156.3935765-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912210156.3935765-1-sashal@kernel.org>
References: <2026090932-flatbed-quotable-d5a9@gregkh>
 <20260912210156.3935765-1-sashal@kernel.org>
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
index da345b50769cf..baba2f4509496 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -87,6 +87,14 @@ nouveau_channel_del(struct nouveau_channel **pchan)
 	if (chan) {
 		struct nouveau_cli *cli = (void *)chan->user.client;
 
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
 
@@ -96,7 +104,6 @@ nouveau_channel_del(struct nouveau_channel **pchan)
 		nvif_object_dtor(&chan->nvsw);
 		nvif_object_dtor(&chan->gart);
 		nvif_object_dtor(&chan->vram);
-		nvif_notify_dtor(&chan->kill);
 		nvif_object_dtor(&chan->user);
 		nvif_object_dtor(&chan->push.ctxdma);
 		nouveau_vma_del(&chan->push.vma);
-- 
2.53.0

