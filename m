Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6856653FD5E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954760; cv=none; b=k5tWK87v8jw9UESHXkWzX6WRMtb87GoM3KV63SywSEKR958aAERqsl+lGv+gzcON9AhvDA2IQ6I9TyxJI9AWfWwLwXEHnVyI3JJhf/kBDnf+z9rkx+La30hnw2RFoIoU1ED9/QTcEPHY7BMpU9j8AkPg8GaoL9jSXdL0pIz48dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954760; c=relaxed/simple;
	bh=z6OnPY8zoHDC0hmV0wNJaQpfF1IsLROSBWYirywKVLU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TBnVWFFfMhZuzvysZZI++CHt7v4BuxZo54ca3B3Buai/5U4JpACrsd9xlyfo/GJUdvmtH7EDq1z0uud9pEVNptaflfOImeCjN+ERlqgL5vbtSaDjtQ6FzGjgBe1ciTCAfanYKArnhEF/8cfoSn63u02YAi0kblA1V6zObhNDklo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hRaaYALG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hRaaYALG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C580D1F00A3A;
	Wed,  9 Sep 2026 11:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954759;
	bh=W/ziasFKeR0eHOtnPNcIphI6Hr/hcdwlR1vvbAmDNJs=;
	h=Subject:To:Cc:From:Date;
	b=hRaaYALG27/upoTDVShypOySFZn32qST1ZZVpzjzm5i7B5xtuOM00kloNvUelJlSJ
	 zvLHo6+EAxb2DcPoDzoImpHLZxDxP0JM99VBBsxkQuyUthf2VYtwNmz2OIP+GJpppl
	 cPXf6jiumzr0J8Ht8OFcip9YWwDyeSQMgqYYPbX4=
Subject: FAILED: patch "[PATCH] drm/nouveau/disp/r535: Add scanline position support + head" failed to apply to 6.12-stable tree
To: lyude@redhat.com,airlied@redhat.com,bskeggs@nvidia.com,bskeggs@redhat.com,dakr@kernel.org,faith.ekstrand@collabora.com,jajones@nvidia.com,stable@vger.kernel.org,suraj.kandpal@intel.com,ttabi@nvidia.com,webgeek1234@gmail.com,zhang.enpei@zte.com.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:51:22 +0200
Message-ID: <2026090922-celibate-moisten-846b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 804cb093b245c752f15d17186e0d404f10303593
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090922-celibate-moisten-846b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 804cb093b245c752f15d17186e0d404f10303593 Mon Sep 17 00:00:00 2001
From: Lyude Paul <lyude@redhat.com>
Date: Tue, 28 Apr 2026 23:03:40 -0400
Subject: [PATCH] drm/nouveau/disp/r535: Add scanline position support + head
 state support

That's right! It looks like this never actually got finished, something
which I just noticed today when I saw this fun message spamming one of my
test machine's kernel logs when enabling display debug output for nouveau:

  [drm:drm_crtc_vblank_helper_get_vblank_timestamp_internal] crtc 0 : scanoutpos query failed.

So it looks like we've been falling back to DRM's core fallback for a while
now, whoops.

So, while it seems that we do have the option of doing this through GSP -
that doesn't seem like a great idea. Mainly because reading this from GSP
would involve a lot more latency then we should have for vblank handling
due to the RPC communication. So instead of implementing that, just use
gv100_head_state and gv100_head_rgpos for implementing .state and .rgpos.
It seems to work perfectly fine!

Fixes: 9e9944449023 ("drm/nouveau/disp/r535: initial support")
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Timur Tabi <ttabi@nvidia.com>
Cc: Ben Skeggs <bskeggs@nvidia.com>
Cc: James Jones <jajones@nvidia.com>
Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Aaron Kling <webgeek1234@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Zhang Enpei <zhang.enpei@zte.com.cn>
Cc: <stable@vger.kernel.org> # v6.7+
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patch.msgid.link/20260429030348.3930866-1-lyude@redhat.com

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
index dbd984da7501..0608266188d3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
@@ -253,7 +253,7 @@ gv100_head_vblank_get(struct nvkm_head *head)
 	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000004, 0x00000004);
 }
 
-static void
+void
 gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline)
 {
 	struct nvkm_device *device = head->disp->engine.subdev.device;
@@ -263,7 +263,7 @@ gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline)
 	*hline = nvkm_rd32(device, 0x616334 + hoff) & 0x0000ffff;
 }
 
-static void
+void
 gv100_head_state(struct nvkm_head *head, struct nvkm_head_state *state)
 {
 	struct nvkm_device *device = head->disp->engine.subdev.device;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
index 856252bf559a..b642729c254f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
@@ -53,6 +53,8 @@ void gf119_head_rgclk(struct nvkm_head *, int);
 
 int gv100_head_cnt(struct nvkm_disp *, unsigned long *);
 int gv100_head_new(struct nvkm_disp *, int id);
+void gv100_head_state(struct nvkm_head *head, struct nvkm_head_state *state);
+void gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline);
 
 #define HEAD_MSG(h,l,f,a...) do {                                              \
 	struct nvkm_head *_h = (h);                                            \
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index 1155f079b0c3..e77733a5d9c3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -625,14 +625,10 @@ r535_head_vblank_get(struct nvkm_head *head)
 	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000002);
 }
 
-static void
-r535_head_state(struct nvkm_head *head, struct nvkm_head_state *state)
-{
-}
-
 static const struct nvkm_head_func
 r535_head = {
-	.state = r535_head_state,
+	.state = gv100_head_state,
+	.rgpos = gv100_head_rgpos,
 	.vblank_get = r535_head_vblank_get,
 	.vblank_put = r535_head_vblank_put,
 };

