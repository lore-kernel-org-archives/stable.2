Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6CF33B6E8
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789231035; cv=none; b=ti5LZpdzfYZXyDoMk/X/Pzj6Y74pt8oExdI/2luWbDw7IBYopYEYrbgddHraPCG8bLiJDZrV+Tyr4bOleO/472W+cX3Pn6WpnGJLUAtclWtlpj/B+tHZirsh66d5FYqFab6ielT++uoh5XIKrXwyZsnyVC+sWJejokRXPri/++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789231035; c=relaxed/simple;
	bh=ncdGORt4YTsa3caxYQVmUIrI0T5j6xXD8OSgGGCpVXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcBQeXOxbbkXlbt3wa+ah3Szcks9UtRAChz3vjVAjNRmX+9krI5DXxZUYv7bi8mXmGJwEq1YSV1AAQvxnaJZ7Ll8WL3UXBblF23wmT9eLfgWzwUpNQgYAhzxsqL2UW6cD39mzq7nFv1XLqXrbZdhGtXXo0G73KkiJhcqjbBhGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ85dFbH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ85dFbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09FC1F0089E;
	Sat, 12 Sep 2026 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789231033;
	bh=IyY75ZktjG+8xYUMFXOFc8IuGytW0oy2EcipOSDbcQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BQ85dFbHpyy+fs/gUKc+13vIz1nlJz79d1sTBTx6eEj848ZPhOD9Cv1wDlxAI6Oib
	 2t1TIUgC1+84zvzRVN59Q7H5OIlOoTYq9rASOXradihYVbn8q5sd8gPK7m1EE+ogQs
	 5h8nuCpl4iB+KKYKNZnjl1tMJDYEeLVGRjLvkD3PkYpoC4DWSqlc9RXKO0WmHFJJ2s
	 4R79KPO5YKTFA43dxVmfGr+UWsy65hs65YGfR6bDKcZNkNwIwcEEnW/sStgkWbP0Ao
	 dsSCQvR5DBCIsQFMMZJ4AXa2GATtgTXYkksJ2VpBd5ho+kTSQ/EEsbvG9FaXk3b/+y
	 U/lpkdrUoTp2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marek Czernohous <marek@czernohous.de>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] drm/nouveau: unsubscribe the channel-kill event before the fence context
Date: Sat, 12 Sep 2026 12:37:09 -0400
Message-ID: <20260912163709.3673876-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912163709.3673876-1-sashal@kernel.org>
References: <2026090931-importer-stinging-410c@gregkh>
 <20260912163709.3673876-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_chan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index b706b6dd9a88b..c6ee2bfe27873 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -90,6 +90,14 @@ nouveau_channel_del(struct nouveau_channel **pchan)
 {
 	struct nouveau_channel *chan = *pchan;
 	if (chan) {
+		/*
+		 * Drop the kill-event subscription first.  Its handler
+		 * dereferences chan->fence, which the fence context teardown
+		 * below frees, so leaving it armed across the teardown leaves
+		 * a window for a use-after-free.
+		 */
+		nvif_event_dtor(&chan->kill);
+
 		if (chan->fence)
 			nouveau_fence(chan->cli->drm)->context_del(chan);
 
@@ -100,7 +108,6 @@ nouveau_channel_del(struct nouveau_channel **pchan)
 		nvif_object_dtor(&chan->nvsw);
 		nvif_object_dtor(&chan->gart);
 		nvif_object_dtor(&chan->vram);
-		nvif_event_dtor(&chan->kill);
 		nvif_object_dtor(&chan->user);
 		nvif_mem_dtor(&chan->mem_userd);
 		nvif_object_dtor(&chan->push.ctxdma);
-- 
2.53.0

