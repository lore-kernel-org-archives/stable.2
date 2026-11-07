Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047657;
	b=Zw4PMpiF8NNckhIWz8sTqZDYCwcun2TATRBmSohYUtwwu9jtOn21mRYmi7MT8lcm/TWq
	 cPjiFc4iNFdOebxd3nr9MY67WOxNqXi1pS02Y+fc2SbFoEJPansWyxC5Gks0iVRO+Fjn3
	 tzBGWD19VrBLO3PL3w5ChM0YnxlifPu336Be+VlumNbTUHDl7O6/D3NkjVwuePYZjgzHg
	 AfqXz22X8W0l/70jO0hIvZayP697ptwOc1be6itmXdJGPadURgnjZeIRdZQrBfvTMG01o
	 hIvECAbUXHudGanqTJKwETQRAMSF7lWKCojf7C4oGS787OEdbptvujQMesp2o7sejTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047657;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ryeL5DZoZRTbCavDUs0XRWLkzvSSbHBROTGBLYRVg7I=;
	b=15wWnhZCLhDWQGlr2oW46nqFlefcslFH5cbcMWQBeHU/DvPqyHiILSUdcuuArqbWiE0s
	 zjJBSygTAudHRsb9JR0a6cHhjys1x49XFJ3Xy2+b0xXRLijboGeB2yljay/bzIH98yixi
	 5rSApDIn8LEWLiiOPtc5f9+IHDLapiBA3YMno+DiWY3vp15xkVkso7qErLkbPWYAtth8J
	 BEBGUA5Zq/RTjUHDpzY46dSGbsAHZCDDaawYO2czrqfr1N7XQvvdRMmL9++cUBO871Rrf
	 XmjofpW3XHKm5uHkGajgbG7kWgsnYy+C0bjfC8tKZIb2p5b2PzKmdqU1Tvl1VkxH7DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oX4PVAGP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FABA606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oX4PVAGP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB9C1F0089F;
	Sat,  7 Nov 2026 10:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047657;
	bh=ryeL5DZoZRTbCavDUs0XRWLkzvSSbHBROTGBLYRVg7I=;
	h=From:To:Cc:Subject:Date;
	b=oX4PVAGPlwpKVPraV8zb2Z3znMK0MGa9k0bOt3CMG44W0sPUCOVuKM+tS7xPnp0NO
	 nxRmENun37zi0Xnw/oXXVCYvxomZdf2BnrEc6YyMdvmfsYBDQgcvWFd8TnFvac9ymZ
	 bMeIR+ta4LGGzh1QMoFl/CxUmGw1z51EC2qI8yEBIWMi0X0N9e2gRXHWS2XTFMr7n8
	 vtOlIZlH4GnKpP/PU7z9ql+xr3Z87dzDcxGKS1CVAEWoRCkFXxfz6FYbxgj0Bgs7a9
	 lQcT6oRuFeWqnBRdWsvs6Su5gxojrLfUXPpJa36b+eHzAh5SgW7CV565SFwWE4NCVP
	 1Cm1udMzCO0CA==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: nvidia: Release write-combining handle on probe failure" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:34:15 -0500
Message-ID: <20261107053415-failed-6.6-8710af6a3520@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8710af6a35201a6d01b5af8f7e4bad29cc40467f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053415-failed-6.6-8710af6a3520@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8710af6a35201a6d01b5af8f7e4bad29cc40467f Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 14 Sep 2026 20:54:47 -0400
Subject: [PATCH] fbdev: nvidia: Release write-combining handle on probe
 failure

Failures in nvidia_set_fbinfo() or register_framebuffer() leave the handle
from arch_phys_wc_add() allocated. Release it in the shared error path,
as nvidiafb_remove() already does on normal removal.

The missing cleanup was already present in the initial Git import,
when the driver used mtrr_add() directly.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/nvidia/nvidia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index 4ef7a5ba43cc4..395f5d0455fa4 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1423,6 +1423,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	return 0;
 
 err_out_iounmap_fb:
+	arch_phys_wc_del(par->wc_cookie);
 	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
-- 
2.53.0




