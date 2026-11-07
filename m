Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049207;
	b=LL9/pfKmWvAR7mQvc1HDsYAiCm2D5qGx0AUX3MqGNtZY5KuEUMD/xnUfZkLgU+EovUM+
	 klrOWMlqDdlr3G5VjrAXKUKlTnCPOsMTQk/qDc3v79zMWZNZQEC/mNI52KFs7BiHBA4FJ
	 suEGHx+XsTvJjxTwjcYBV58TkbQjAXb4GFbVoDSTj95QUFCYNC235TNtfk6FvG52cvN6i
	 xCoGDaRi+Wp2/bAqGwse2vK8wBxZt3yaTbaK6FNG8FWVVU+Sb1TyMKBd8xl3Ja458qdHy
	 rGybDUO7BcSf/8aJjITKvzot92Rrtx6L/n0XvJqg2gjsCYOFxmfeOTedRZ7OfZmGRpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049207;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kpFsFhGT+onI4UruuCX7jMijZkabn0pfml9X3/73G2w=;
	b=m8EKwtlQG4bacdtbxOmohWI5Forx5KCQwVdpW6sMUuXmAEIzY89/DfzQp7U8bjWEY1Jg
	 7CRegf47MaDZUWhko2DPyURXDgv3fGAySyvFvDpT4PgZKqwNpg9dXHZU/2BlJCg0SHuIy
	 tE4IMDqnVImu9gRGgkFv8lbWpA3FROHimjO55W2UZBk8jR/tFmDN2bMHV7WbRPkfOTh9p
	 ac/mgirfMe6B36YjepVBZMx8oYtkY9wnsoHdz51bxTRW53Dbqt3dVt+9SbUFcAp/nVB3Y
	 BtWrmBEQsx5E0hnw3/lisGA/UckhK0jGgxCe+FGYApg0FhRVzxl3QElhsIDq3HRrHmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHEOa6Tb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9274606D81A
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHEOa6Tb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D291F0089F;
	Sat,  7 Nov 2026 11:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049206;
	bh=kpFsFhGT+onI4UruuCX7jMijZkabn0pfml9X3/73G2w=;
	h=From:To:Cc:Subject:Date;
	b=kHEOa6TbVM9GyuuZy/b90DjTPbG5TvEsyZbPQF1dsGH0zqwz18kd7FKUcsuTVfdTv
	 AsMG8zHswj23udYXCC2N5fuBXWvnlEfNU3884drC9tgqniTnQBuNW3FBIVN8NurNc8
	 lui6qYCElZNQA0oqj+jVxsVE2EcDnpMVwVlHPUgE04nDDo0lEc+ub+jEPq0+VMRtyr
	 OiGakuLrXh5bJzqlmBd72If6UdzlWecLfDvacQpnprKrdWIEGLW7ARqLiu45GT8GtL
	 pfYaW+MoZXuqrnN8kUXebODe1ld6wVtfs9tH2m/BlO/XMAgjomZON7dBQtC5DxS6af
	 nvshR/u5ZyMVg==
From: Sasha Levin <sashal@kernel.org>
To: david@ixit.cz,
	lee@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mfd: wcd934x: set DMA mask on parent to silence "DMA mask not set"" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:00:04 -0500
Message-ID: <20261107060004-failed-5.15-b296be1dc008@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b296be1dc008fe3a536341afae01f66bb302e67f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060004-failed-5.15-b296be1dc008@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b296be1dc008fe3a536341afae01f66bb302e67f Mon Sep 17 00:00:00 2001
From: David Heidelberg <david@ixit.cz>
Date: Thu, 3 Sep 2026 16:42:05 +0200
Subject: [PATCH] mfd: wcd934x: set DMA mask on parent to silence "DMA mask not
 set"

The wcd934x MFD parent (a slim_device) never initializes its
dma_mask/coherent_dma_mask. When the DT-aware children pass through
of_dma_configure() this triggers the "DMA mask not set" warning for
each child.

Cc: stable@vger.kernel.org
Fixes: f959dcd6ddfd ("dma-direct: Fix potential NULL pointer dereference")
Assisted-by: tencent:hy3
Signed-off-by: David Heidelberg <david@ixit.cz>
Link: https://patch.msgid.link/20260903-wcd-dma-v2-1-189cff560a28@ixit.cz
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/wcd934x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index 3c3080e8c8cf7..7bea64fc09562 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2019, Linaro Limited
 
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -217,6 +218,11 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
 	struct gpio_desc *reset_gpio;
 	int ret;
 
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set DMA mask\n");
+
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return	-ENOMEM;
-- 
2.53.0




