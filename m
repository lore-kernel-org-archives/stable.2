Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF0332EBB
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736794; cv=none; b=Eg4H1L8bsQGa/OnkxDpikUUDE1VXNoI6BOHPad0L8/K1L0edDm9Y5bGvv2chwrW0qQdrNVLSUTHVAcUXmXrfUgah43EvnW9+3a71EDg2lItLbu9P1DUZKEuVNkHRHX6V2zNNMXNWQtgTdru0nDqGgq0L/sBz9piH5w0HElAFU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736794; c=relaxed/simple;
	bh=5S7vfs5PRPttb90RKTLuThmDKuwMxYHwna2aEFa2CVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfh4LOlTK/+d/aa5TnK7aUIdGLEQAxeUVuip6sjaGWhyyv+NwIenuBwN014yG/pH87smNnMCo+z/a2J1qRMnf/UbhQeuMvdhdK4313NbpA0PF5P9LB62Paqssx+CzyIh3i8VXt7sD0R0eEVOtnLiR9ou0HB/CvIVdDSgeDl6u0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGBNdvWy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGBNdvWy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786736791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnaYVu/GD97GKQMIMPl79VFubCmSwD4Rwvc2jI8c6no=;
	b=HGBNdvWyD68Ld9Jes0tbagiJBFBvglWhQpHDKAGGGdHUawj+xeAJqbQVq+0WQe069hZykL
	ClQpuNB3YQR9y/G/dPfeI5oMORh3V4Vf7xXpe9ad1WOHGIMJnx+V7OWNY7IybqYPAo3FP0
	twdXhhMpOSdpYAuEyVCQ20VNcaucJ6s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-0Z7WCyE8MCeAVuvuwP9HsA-1; Fri,
 14 Aug 2026 15:46:21 -0400
X-MC-Unique: 0Z7WCyE8MCeAVuvuwP9HsA-1
X-Mimecast-MFC-AGG-ID: 0Z7WCyE8MCeAVuvuwP9HsA_1786736779
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E5671956094;
	Fri, 14 Aug 2026 19:46:19 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.233])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDA1930001A2;
	Fri, 14 Aug 2026 19:46:15 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	"Timur Tabi" <ttabi@nvidia.com>,
	"Dave Airlie" <airlied@redhat.com>,
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Ben Skeggs" <bskeggs@nvidia.com>,
	"Kees Cook" <kees@kernel.org>,
	"Simona Vetter" <simona@ffwll.ch>,
	"David Airlie" <airlied@gmail.com>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Mel Henning" <mhenning@darkrefraction.com>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v5 4/4] drm/nouveau/gsp: Increase delay for magic sleep in r535_gsp_fini()
Date: Fri, 14 Aug 2026 15:43:51 -0400
Message-ID: <20260814194542.781955-5-lyude@redhat.com>
In-Reply-To: <20260814194542.781955-1-lyude@redhat.com>
References: <20260814194542.781955-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
2.55.0

