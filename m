Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1761FBEA6
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789231033; cv=none; b=ceYWMEpZPUoi5YgW3E4esfs/Ye18IhihKfTePCIW41SeuIhTTMw8h6t8/NOIkut2svlW4ZxidSjNMloGu2Ofu1yVysMW6/onEyrUBMD7Ef7sTka7IjyPIDNQxGWgFYFKf62XmA/8r8i6exgsCCK2iVWoRRcttCdfk/d6hcf2jH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789231033; c=relaxed/simple;
	bh=ubUYwXdZos3H5lsjjzVx3RIPWgl7maq2K9xfy3Fkhso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4duCcTOghnzMuBW8IFR7Y0I/NUc83ZqEf5HAGNg48ITLOsT3v/OY6DdCozJZCp4ijc4eRh6dtyfzRiz56ws7vnzwgIJKj/4X/VqZoPMA4axHEAwN+8KexdXq+/DFSIY+pOI+evDSHl0PzJWlt7Nz/5r2g0GFWTTXSzzQIMipqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmLBh495; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmLBh495"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6F61F000FF;
	Sat, 12 Sep 2026 16:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789231031;
	bh=bjvXsDlEHQxboROn8OVRfITiAWYAHwnIXWaPv09OP28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LmLBh495gn/iHUUVJOJxNHsdzqlk7pYlKGxfmlZLEPlJQNElfXVsIEoCrQiEm8OG1
	 I6kVHY0dUWcPWFJGzgBbFAGfQx8dshm7VfNnV+RCXJ3uXQZrMv857O5rWSX/CzEIc7
	 I4C4mqTss8zIR0Q/g9OcNtrl5dCEVNXkc9ORUzmqMvYKFCiKS+ICDCzN4NjpKb2bog
	 DyScDIBJqOrkgfPo8WbYhd+ZpE7+WZdAIwNb3nynDNb3DM5uoalA8C889lYoCfzLlJ
	 32nTsB/Nlpix5tvtCk4COTptQ9nwBmfcjTPyUveKyO92Ip94aCk3kaA3qYfOiI5zSm
	 FB39GJKzDjpPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ben Skeggs <bskeggs@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] drm/nouveau: remove nouveau_chan.device
Date: Sat, 12 Sep 2026 12:37:07 -0400
Message-ID: <20260912163709.3673876-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090931-importer-stinging-410c@gregkh>
References: <2026090931-importer-stinging-410c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Skeggs <bskeggs@nvidia.com>

[ Upstream commit 2eb58f22e2761b75e4f35847be03ddd425ae2b5e ]

nouveau_chan.device is always the same as nouveau_chan.cli.device,
so there's no need to store it separately.

Signed-off-by: Ben Skeggs <bskeggs@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240726043828.58966-33-bskeggs@nvidia.com
Stable-dep-of: 511585987d27 ("drm/nouveau: unsubscribe the channel-kill event before the fence context")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_chan.c | 6 +++---
 drivers/gpu/drm/nouveau/nouveau_chan.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index cee36b1efd391..db2d01d013138 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -157,7 +157,6 @@ nouveau_channel_prep(struct nouveau_cli *cli,
 		return -ENOMEM;
 
 	chan->cli = cli;
-	chan->device = device;
 	chan->drm = drm;
 	chan->vmm = nouveau_cli_vmm(cli);
 	atomic_set(&chan->killed, 0);
@@ -365,8 +364,9 @@ nouveau_channel_ctor(struct nouveau_cli *cli, bool priv, u64 runm,
 static int
 nouveau_channel_init(struct nouveau_channel *chan, u32 vram, u32 gart)
 {
-	struct nvif_device *device = chan->device;
-	struct nouveau_drm *drm = chan->drm;
+	struct nouveau_cli *cli = chan->cli;
+	struct nouveau_drm *drm = cli->drm;
+	struct nvif_device *device = &cli->device;
 	struct nv_dma_v0 args = {};
 	int ret, i;
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.h b/drivers/gpu/drm/nouveau/nouveau_chan.h
index 260febd634ee2..18a9cbfef8ca3 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.h
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.h
@@ -13,7 +13,6 @@ struct nouveau_channel {
 	} chan;
 
 	struct nouveau_cli *cli;
-	struct nvif_device *device;
 	struct nouveau_drm *drm;
 	struct nouveau_vmm *vmm;
 
-- 
2.53.0

