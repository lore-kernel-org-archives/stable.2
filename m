Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050315;
	b=WKziQgAAfZdEosNAxKcydRaQkyFjeahaGxmCEyWVuQlfCsDj4RDE0MDH7NdfudMtmznX
	 wi7NREuKr0ZM7yKMLypKQMEQo9rPHikEZGAbwd3eMmhvleB48Bwcz2jvlC/may6ChY71e
	 AysJ7usGVFIB07wtK2UWe5sojGdQ/haRDUzJyXDVA9Og8DDda0Cv7RaYwom7iTBkiRfWz
	 Grq/6xiKAwE6/p16moDoPnwJhcBOPVxlyO9AjDD0CXODP20n5SHEdYzTMzptc8ZX4sl7i
	 IfIHifA4aVI9rz/EwACcchZLlAbCBJ0ccVxPfF3q90/gOhO2NfpREc0Da55exHhz06A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050315;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bLfJJf3dpNZssEtJeS6jF2ZEw94AQ16pUOI/Np+Z2EY=;
	b=gls2khmJ0adddEymR+0xH/T6x8inZx5yIC/stMxkLPgFuUqhk/FHI7l8bs7z/88nnSoD
	 rKes9rSNhr5fXjpkFwssqeaZ/4lI+1/F1L64YhPLM7PwRg8OGBXOCzGpSKIQIDZqSkTn0
	 oMbz4Njg2gzsnW0rhakGqqUeL80H9WjsKouPC5QUBgpA5Qz4ScwBfHO3zrv3cblTIzhwC
	 uUaGxBvQyt86SZc63KnOyA2PANP7P5XSSc0dXVMd1atOBv+wFnw0Ydc3Nu4kdrugDJiip
	 BwPez/BPtsBdyXR7cSWv2yaVY0xNHaNi3ej1BTZFRPW7O4MWX/cbkCRrsnEfBLAiHGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJL6b+M0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJL6b+M0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7851F0089F;
	Sat,  7 Nov 2026 11:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050315;
	bh=bLfJJf3dpNZssEtJeS6jF2ZEw94AQ16pUOI/Np+Z2EY=;
	h=From:To:Cc:Subject:Date;
	b=UJL6b+M0PZCFwgferuySW8x0HoXslOyjVw3pS+SlkgJazMiYEwX1LTGGpgA2G3jmn
	 YMftOjBS3y/vmrSgSS2dEmM67oVs4uFO30n+NWXELv0xSeRPT4+8O2J+DB9p6dQigo
	 t8vg/mleKYda7slLoCxFEFzSks9j4fJ3bDSeW32snHBmNDvv6GD4okOt1CsNppQKm1
	 /IGFD3hx6YqeezdeIHrndQtPjztefXOlWWhZwaFkQ8giJa3ugeS3n4i9vskGdR82eI
	 69nJ+rJ2oyF0x6vGJ8+Yv3zWqR+dkDel/zn96sgoak9uO7aXn6LYFJvIq9NBb57QgI
	 HaiOlYY9yUVrQ==
From: Sasha Levin <sashal@kernel.org>
To: fanwu01@zju.edu.cn,
	songl@zju.edu.cn,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: mediatek: vpu: free IRQ before destroying watchdog workqueue" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:18:33 -0500
Message-ID: <20261107061833-failed-5.10-2c50b58d4105@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2c50b58d4105f6dbaa36d6306087954b9100e9ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061833-failed-5.10-2c50b58d4105@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2c50b58d4105f6dbaa36d6306087954b9100e9ae Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Wed, 23 Sep 2026 08:59:21 +0000
Subject: [PATCH] media: mediatek: vpu: free IRQ before destroying watchdog
 workqueue

mtk_vpu_remove() destroys the watchdog workqueue while the interrupt
handler requested with devm_request_irq() is still registered: the
devres core frees the interrupt only after remove() has returned. If
the VPU watchdog fires in that window, vpu_irq_handler() queues
vpu->wdt.ws on the already destroyed vpu->wdt.wq.

Fix this by calling devm_free_irq() before destroy_workqueue(), which
releases the interrupt and waits for a running handler, so no new work
can be queued while the workqueue is drained and freed.

This issue was found by an in-house static analysis tool.

Fixes: 3003a180ef6b ("[media] VPU: mediatek: support Mediatek VPU")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/platform/mediatek/vpu/mtk_vpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/mediatek/vpu/mtk_vpu.c b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
index 8d8319f0cd221..b6bd80b684459 100644
--- a/drivers/media/platform/mediatek/vpu/mtk_vpu.c
+++ b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
@@ -962,6 +962,7 @@ static void mtk_vpu_remove(struct platform_device *pdev)
 #ifdef CONFIG_DEBUG_FS
 	debugfs_remove(vpu_debugfs);
 #endif
+	devm_free_irq(&pdev->dev, vpu->reg.irq, vpu);
 	if (vpu->wdt.wq)
 		destroy_workqueue(vpu->wdt.wq);
 	vpu_free_ext_mem(vpu, P_FW);
-- 
2.53.0




