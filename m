Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313062;
	b=s3E2eKP42rViKmsxLDQy0o7lMD4s0Fgp6o9V3t9ks/umtFY4EE0Z25suZ+BCJWU9stGn
	 U6koRfnZWQTY52eAi+q0DAHo+W957nEmwKpq3FPi8VZxPwEy//MCRju/Q9Nl990zlwKbo
	 hFI84N91rNpbpNrQUAmj7GedwoicYxbofTXR5DXfbN3xsOxKpKNzoMZXP0VCZzsCDplv2
	 klrpfFtRt8uUGYzlYblfZDbAovUt515No1SRKsCqvgKQCeSol1r6CsVBmNvZxS9+LIsPL
	 BkU9fpeWXcDV+3YM4j8wbykXcR7wq7Vqs8tWCXZdKT3zmbQXvgeUwFdDzlPQMiyxdYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313062;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aSmawc8KwOK30Xlbr1xcE8uaqTm8+5RSjzBk46FD1nQ=;
	b=N12dITizQ79mhwN9+Eb7DrAQlHgPPWYDsUGnw6gW8B8tSoyd2k5cyoL0dP243R5Q4r8U
	 k99MkdG5u58Op6pJ9Xf7ujWZ9frvgVj3BxTyhhCuqHSu/4q68EloqoyceZYE8mahXgG/p
	 M3EBvGgPaBM2NnyO/JC5Rs4kQCCoMJXv51z+rReT0/Se6wzbIhvwhdeTg0NqxSvU25E4b
	 VGQZF5jq5nY/a0PBZo+lUNLjjsZybQ2k5GdrbDR6MAWMWRwl6QQ/xNfqLiSpH63uxC6IY
	 drB+0f8y23onWCVN4h3zwpb0KFYo+soyKO82T/Vs3lMj6b4Eqpxfu47gLE7wf4siFvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gavOv0It;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07466606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gavOv0It
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB22A1F008A5;
	Tue, 10 Nov 2026 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313061;
	bh=aSmawc8KwOK30Xlbr1xcE8uaqTm8+5RSjzBk46FD1nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gavOv0ItnizObT27wXojjamiobu6rnz23PUBDNUuKjvzxqRGpsbrY8oZmE5O9KO2o
	 ytwVUu1veaHEQ9eXKo1uLfSWXnzPLY45IvmA+ESFWyzEzAFjgRc0zjn68JuH590g54
	 cIG4ZosRXtlMpQrYWqGIyqHjrReKVYTb/8G2Ge9YcEItKhKjMjmmfvzi0KuEipiBwj
	 I+GIpCrd0SYxH2DdPTvECH0mSjoll5LLKeGpdxJrhWQFUxGZ4gN3znhq9kC2KbOKe2
	 tyGqH95SfZHSb6jLfnsNCpAjKIluW1+dt32AM2PP58nb3A4O7lfmvkMSyRjwvdN6EN
	 cG6pqfgHA/Dyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] media: mediatek: vpu: free IRQ before destroying watchdog workqueue
Date: Tue, 10 Nov 2026 07:17:38 -0500
Message-ID: <20261110121716.1071164-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110121716.1071164-1-sashal@kernel.org>
References: <20261107061833-failed-5.10-2c50b58d4105@kernel.org>
 <20261110121716.1071164-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 2c50b58d4105f6dbaa36d6306087954b9100e9ae ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mtk-vpu/mtk_vpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index 98f043f1c8749..bb207a4ebbed9 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -938,6 +938,7 @@ static int mtk_vpu_remove(struct platform_device *pdev)
 #ifdef CONFIG_DEBUG_FS
 	debugfs_remove(vpu_debugfs);
 #endif
+	devm_free_irq(&pdev->dev, vpu->reg.irq, vpu);
 	if (vpu->wdt.wq)
 		destroy_workqueue(vpu->wdt.wq);
 	vpu_free_ext_mem(vpu, P_FW);
-- 
2.53.0

