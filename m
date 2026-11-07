Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049311;
	b=rqCn0tlYYa0xYZEsKGWo5WlzyY8haSPzk5g+jApWE6Shx0y7cOOZe03eoYwCeAF+tvsp
	 J9LW3ywcg5szXN+Iv7lZIpy95lEv+FeYMWUQe0B6u/gjXLrEwEyV1OrzqRkuSVtaTDScM
	 iatYOI/YzzDDXVv6gBIoAKojPtKv80XaD/2U7XCzUN5Y8c6cYUhJW1CfAuQC1mXwKuSfg
	 kFFCvB13XivQCDh7FX7G9guaPqRx3j4HhmCgz+CX2+TxWWAig9t2fTRCi0iGq6j388gD/
	 Q1yuaEa4CkE3/st8i7KcqXeYP1hUC7/0Nla21UD5xM+yGTpFtoXVoz8nSRB7On73alQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049311;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uD9e9VQ8AMxo3JkGW8GoOUFmWmQ++ZsJxjyygRaFx5w=;
	b=TEsUxFPRsAekIFeA+RlU9oTv6EUdh8BRoLXcVHGtkg+HFVoRo479FjaukONtaTuRah8h
	 woicgs841Al2/lo58SLVKMpr9ZnzhSJEJZ7PGq7awAoJCq7bVgz67e+Szvl+67XvfE0Oj
	 NOcQHz8oAD3c0NkxlL3JUaZra4dHlOu7Z4Xmxbfz9M4uzMV+PyRYDhojjdNa+udr2Ps2o
	 +FD7zyVTUlcJl0W+g85jep2VPAe0JcKN6MjGIzhdf5ip/0HmSHCwoWDOICDHs3qOZBD/Y
	 R1Kmp05ctRpzJTr1t/9xkEINMPMykUmfvSAMkN/+dfoVRN2e1iZXs4btBypVaC3eD6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFfTzI+k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6237D606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFfTzI+k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A512E1F0089F;
	Sat,  7 Nov 2026 11:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049311;
	bh=uD9e9VQ8AMxo3JkGW8GoOUFmWmQ++ZsJxjyygRaFx5w=;
	h=From:To:Cc:Subject:Date;
	b=HFfTzI+kQcXCKUccIKQWIB1RYbiQEet5c86XEcNCLtNSDbu9fW9d4dllBtKEF4itU
	 WfnhahYTguh8wQxGUicB5lTENCVQq6X0c3PFNbfTneRASzDBF1YcCg7eAew7/OxcXH
	 cPHuEJcN7XUHFJptkqKehne+U09is+ytAQeL0sXwmbpCqz9iFfnX1VFb5ONTqWJBll
	 F8vBJluwUz154YCdWu8E6+CKdJLXGZ1P96DNVIrwEp6k6+SAmJnhkExXNtqlZ2u1cq
	 EGTRDJBl+hWOMjVh9py4WKJJNSiH9Z0LxdZR5ZfcPF3FsFilD7WLoE2HG3wOq8Bkng
	 he+Le4jvdRiiQ==
From: Sasha Levin <sashal@kernel.org>
To: fanwu01@zju.edu.cn,
	songl@zju.edu.cn,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: mediatek: vpu: free IRQ before destroying watchdog workqueue" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:01:49 -0500
Message-ID: <20261107060149-failed-5.15-2c50b58d4105@kernel.org>
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
git cherry-pick -x 2c50b58d4105f6dbaa36d6306087954b9100e9ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060149-failed-5.15-2c50b58d4105@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




