Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045753;
	b=y8Gk2AIxdqKaWPJsBKQNCU4HN2rQ44ixkoh9GlG2pzjDW06cTpKP9m6lAhF1n9Y19FM0
	 dKPEyYI7r1QHoWqjI4Xfsf69ELKhqYXEcBxoAf7eHQDSqgUlkrrnME6I9oXE8YeO4NzMi
	 O2LoFdvPKzwDApfCfEl2lEAiMGQnWQbFi/D0iGkw1XpJUNVnMTtVp7uBm9KUOxwgr9png
	 J9PtFBOHyVP01K2GDpqIMMGssmnywgrnL6D4Po5MYfQEjXQVxrdBxOyMgtPtIyPQjggmX
	 GCS0eUgzhDojgtH1qZaPa8Qrac0C78CPeNUfCdEwycC0Ilx0trgAUK/xgw6x7Hs+LMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045753;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8GyZjF+osm7FQBm9oX3hxXZ3iC4xbsgKq2KyufkDfj0=;
	b=KR2ncfzyz3fE5nJmRw+px+tAZOsManxMJgIqvya2uC6S9wPQaK28iPikF3nDfxzoh9O1
	 zc2Gt7Grti7FrKSZQTltsyyIQnJKcFdbqi0hJqfjUpseMuowa2S/ACic3MrCpTR8BjX6G
	 Sl2O8zLidAng8BUx1HI3FhKAPfhPWN7NcUMBXYhDaoiSV2MydNmfMEEPiLXN+nAKyZshW
	 rasksA2+D+nsQwjN5U1khi6aGIGPcr1Eu419MqUJkS9dp6RTeVzsbriGClRyMHfAjAi1F
	 WNSEa3yM5IFZ0HESdlxqvDZaWRkCoREggNyEvv9FQut9wQ9XgvLktOkEcHyuyvBl/uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dBSPhXfb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69798606A333
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dBSPhXfb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF211F0089F;
	Sat,  7 Nov 2026 10:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045752;
	bh=8GyZjF+osm7FQBm9oX3hxXZ3iC4xbsgKq2KyufkDfj0=;
	h=From:To:Cc:Subject:Date;
	b=dBSPhXfbmPGkHKVKMEKFaRmUSJxsHY9+TnYmwVtkV80OkGjRRI+Ho4zgXKv6LS+aI
	 RGQAH1LLzX52gHdD/fF4K+5jkI8hVsJ3IQ6/Iv7o+equU2t1b4b9si9jL2PJuIzc5t
	 6orkC+qPd3ypjfxIxrA2CapYYC9j94JIZ5exlTQJp6yvQNVhxfLffG3VQMQFAX/NW5
	 iFI3dLN6HPwZ2DGxS97oNysw9wHk94+CAdOc31DAPvdq2lgCVBfQ6JS/8L4xoKNleT
	 XBkxyNMNy90nB2HhRzH0RPxfSRQw2QQKVtphEvA9Og8MaxQ0pfhuHKx42q5s+R3xaK
	 LnWWyeHz/cJJA==
From: Sasha Levin <sashal@kernel.org>
To: lyude@redhat.com,
	airlied@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/nouveau/gsp: Increase delay for magic sleep in r535_gsp_fini()" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:02:31 -0500
Message-ID: <20261107050231-failed-7.3-09b47186a416@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 09b47186a4164f3aaa3591313f80794443117342
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050231-failed-7.3-09b47186a416@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 09b47186a4164f3aaa3591313f80794443117342 Mon Sep 17 00:00:00 2001
From: Lyude Paul <lyude@redhat.com>
Date: Fri, 14 Aug 2026 15:43:51 -0400
Subject: [PATCH] drm/nouveau/gsp: Increase delay for magic sleep in
 r535_gsp_fini()

As it turns out, Turing isn't the only architecture that needs this. On
this Dell Precision 7780 with an AD103 GPU, along with pretty much every
other laptop I tested, runtime PM is still somewhat unreliable. At first
glance it seems as if it's fixed, but lowering the autosuspend delay to
500ms and then doing a stress test of suspend/resume cycles on the GPU ends
up causing everything to start timing out.

After quite a lot of digging, I eventually landed back on this magic
timeout in r535_gsp_fini(). As it turns out, increasing the timeout ends up
fixing the runtime PM issues as far as I can tell, even during intense
stress testing.

Unfortunately after spending quite a bit of time trying to dig through
OpenRM to figure out what this magic sleep is actually doing, I've also
come up short with any reasonable explanation. In lieu of that, I'm going
to include the observations I did make while trying to figure this out in
hopes someone eventually does figure this out:

* The magic sleep has to occur after fbsr is initialized. Performing it at
  any time before that doesn't appear to work.
* In situations where runtime PM starts getting flaky, some rather
  interesting visual effects end up happening on occasion before the GPU
  fully falls over. In particular, squares that look like the result of an
  incomplete blitting operation to a tiled buffer end up showing up on
  applications like vkcube. Interestingly enough, they remain in precisely
  the same place between runtime PM cycles until the GPU falls over - even
  when restarting vkcube multiple times, and even when vkcube is actively
  updating the screen. Even more interestingly, they're not limited to a
  specific framebuffer - you can see the squares changing as the cube
  rotates around.
  We cannot however, say that this is likely to be a incomplete fbsr
  operation. The magic sleep happens before fbsr is actually saved (which
  happens on the GSP unload), so it's something else.
* During a short bit of testing with a desktop that I have, the magic sleep
  seemed to make no difference to whether or not suspend/resume works. It
  seems to generally work almost always. So we can assume this is likely
  exclusive to runtime PM, not S3.

As well, here's a list of the things I tried before settling on the magic
sleep:

* Hooking up NV2080_CTRL_CMD_INTERNAL_GCX_ENTRY_PREREQUISITE and then
  blocking runtime PM until OpenRM signals that GC6/GCOFF is ready appears
  to make no difference.
* Hooking up some (maybe not all, unsure about that part) bits of comptag
  saving including:
  * Fetching static memsys information from GSP
  * Adding the size of the comptag storage to the fbsr data
  * Adding a GA103+ workaround for disabling raw compression mode during
    fbsr (it doesn't seem like it applies for any systems I tried it on
    anyhow)
  * Setting bPreserveVideoMemoryAllocations=1 in GspSystemInfo

So, until we can figure this out properly - just sleep for longer.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
Cc: <stable@vger.kernel.org> # v6.16+
Reviewed-by: Dave Airlie <airlied@redhat.com>
Link: https://patch.msgid.link/20260814194542.781955-5-lyude@redhat.com
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
index 4a3b771ded255..94925f1590ea4 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
@@ -1761,8 +1761,12 @@ r535_gsp_fini(struct nvkm_gsp *gsp, enum nvkm_suspend_state suspend)
 		 * TODO: Debug the GSP firmware / RPC handling to find out why
 		 * without this Turing (but none of the other architectures)
 		 * ends up resetting all channels after resume.
+		 * Additionally, runtime suspend on other architectures quickly
+		 * becomes unreliable without this sleep. If you're experiencing
+		 * issues with runtime suspend, try bumping this delay up and
+		 * sending a patch if it fixes your GPU.
 		 */
-		msleep(50);
+		msleep(200);
 	}
 
 	ret = r535_gsp_rpc_unloading_guest_driver(gsp, suspend);
-- 
2.53.0




