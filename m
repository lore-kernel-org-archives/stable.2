Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853FC1A6816
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789246757; cv=none; b=o+6DWokxpEpyWmXhOpJNq1Iakp6iNb1sKyEJhkWVxKrU5Cpcw8yReTLIO/i19fwT2xIJL130QoOutSwY9zgn/cgJAyYr4pkvYhHhXjefZS4E4i75r/jIeEjDYRbpRfhDP5yzcXzAX4AtTrOgajdV1Hdk7Tq0/eScJa6Tzj5niOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789246757; c=relaxed/simple;
	bh=jPI1FzCSAuVyjWSYscH3UfYg5Nb4hP7XV1SczOMgwU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9YS3k7B2tevO2p0/pcuIzRtgNH23UGrl8fPB6yy37wPI5H7REtAMaGvP7URwf4eLKF74qxy7YfotuwugSlYpyG2YQ4kvU1RL28qc4MtQDuQkh5Xq25LHKRNuF/i6O3XV2fc3JrTV7JvaZ0bfe9YB9cGmV7bTJWcZ2xJNcQSbXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9karWq+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9karWq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70C51F00898;
	Sat, 12 Sep 2026 20:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789246755;
	bh=Gjw72y5uBI9BUZayQPZXQ0Y8ZYOEDWEWdDcEV7u8L98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H9karWq+vGKwP6nUB+ofs8XjIdWQFRIcfwn0NhioCADE0fUIDYHovCZaN7e95sR1L
	 P6Pm60GfUhp2WBxErHXD1Wc5Xx5cycmfka5Cy57S92wDtZbWSLi+GKoBenfDORqj6d
	 3kJoNuAAR+aCNNuWqQCUP9uIRukD45EEg+pXyFOBpeDUpC1Px/BNni0b68nRFjHnEX
	 0Pog/idlWEpzHb4FdWMg8LsOPUTTYJnYGFroZn4FZPlHaIbgkLH290+hBAFjrpXCsL
	 tpQ0X4MKRp5lfOEpzJyXslqU365FXKu/9YgSnMxD47EqzrhkSD8ULnFl4kEWK8Rcm2
	 dQyLh+6+rwkaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marek Czernohous <marek@czernohous.de>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] drm/nouveau: unsubscribe the channel-kill event before the fence context
Date: Sat, 12 Sep 2026 16:59:12 -0400
Message-ID: <20260912205912.3934099-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912205912.3934099-1-sashal@kernel.org>
References: <2026090931-aqueduct-chafe-a114@gregkh>
 <20260912205912.3934099-1-sashal@kernel.org>
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
index 65033f3a2067a..9083bc7ea6fd5 100644
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

