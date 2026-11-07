Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046251;
	b=H37Qvwp+UdP3mf2YCohRI1bDI9ozY+b/1qleYtfyb0k2hxIUV6ZUW+U/PTGk5jnBNzvh
	 Aki1Rqr2ZEPAlHTWZVGJbVGitrAvvOwn+BYURFNQQkL9QQ1cUClENXm2VHAmVjB4zQGhg
	 VxsaIkFfNEl7tAW/L2bRDX7Q87YAO/glEmww0YNzPxMAQLJ/1DdAn2twi+PCwK2NZajgC
	 P978vIT/Iy0zBV/Nm2AD6GOmMsRvLCDtv5g9AiHDnZhoFSMX8LnS3334Gm+o4t7S8Hu86
	 5j73PDsjsd4m+BFazqYzcws2OFoWCUiNMS+2/vMeraWxAqluXwEJXQeh4Vk/PUglgxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046251;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UdHyFGYFF3FNMlY0XemVUkEJ3rdiTCgIpAd7C8ypSNo=;
	b=5Ps0l1GmcFj0E/uiWztvr5vQxzHW/dd8xtki4Jsueqjbj5dp0TQH0xzL+y5ik9wuwKKh
	 6MsfIsKzAXjECWh/4VkrbckwfSTrfbfbnMljXf1UaYD/BSGjznxVGFTknAV82pDAIoGav
	 S7R2t/cQnD+VgJfBBFVQLo+ivB3ASZkr9zJXXwhAs+eaNKsvV5EnCNrmOJDdHXSxvL7Rw
	 j85u1GNFz3IRe06CynfJ23MLspMLZ2vcKFkBDREdzNKY+IvyRmP4JiBve7aD2hQpB6QNB
	 hoOt5bQfQ4TZJdM5p2CZwJLn59Io023qUE8/Yhe2qeB1N7UDpZMOCInQvgR8vCkS2MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gT/Dqpnl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366E9606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gT/Dqpnl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D641F0089F;
	Sat,  7 Nov 2026 10:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046251;
	bh=UdHyFGYFF3FNMlY0XemVUkEJ3rdiTCgIpAd7C8ypSNo=;
	h=From:To:Cc:Subject:Date;
	b=gT/DqpnlV7ScCqnLljZLXDuSzFH30B7ogmX28h6igaMYWO/uf99u36XzLwR0dP3/C
	 p7yMy93QegGZxPy70kJ7vaHvoR5APEGPUzDPzHei0RXT7I8cSddF4Q44PJ1qEdAqvZ
	 BHuubR8fimIyvTsAGgAHSItVFyg/WP+WYb92QLoGzzm58GMxW+lb5+nNCx8bdAzvQ7
	 jnQRQvkWvY1oYyeFxvgvJNz7+96Bx/d/cAvKrSmz2jHjQiIp/u6ZGVvzQtS6Csok9q
	 p1oEFXRLxnRr8d6pYwAPVZ3h+BljWGLPlodz466o4AN2hyhGye2Qg8F5zwO2XgGkFq
	 rgETHp98vob/g==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: nvidia: Release write-combining handle on probe failure" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:10:49 -0500
Message-ID: <20261107051049-failed-6.18-8710af6a3520@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8710af6a35201a6d01b5af8f7e4bad29cc40467f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051049-failed-6.18-8710af6a3520@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




