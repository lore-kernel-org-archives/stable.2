Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317225;
	b=I3vTUuLZoTb5gSIufrr19WNKb49CUKCcaFYpm4giLRKzd0QdsQnrYpIWpW4gQsRNG+3r
	 X4fBtrs7gTFSzoU5KGPGCZ33VyM/YqqcbeBK/VN0zTDF1Du6do1NfgF1VnwEWItj6Dpk/
	 +ZntTQFgdyT3zmmpfJU0IU/y1jbd4LBym7P2Pn2sMmY7AV09WLmKOcAgZENnR0X5iEZRB
	 5gYTgEVzi6pnWJ6r7Q6bDnVg0GgLgepOuq24D4d4BVlE7UCszI/yfRoQUSTWeKIhmKTje
	 ++je4f/iriilq+kZIsg/VQrsNmT4WNPsez0kaHMfnebjOgMJHiEz+aM0B2jPA2r2V5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317225;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ohCN1Rx51KwrB2hqupbuAjljEHF0I8b4r+9J7PlAJ7c=;
	b=5PecnpeBmGW3yeoqJJIOV7nU5VNaSl3mr3RbHstkTWUehCtUDN7i143gZ4YUq/vrRUot
	 HTE8c4Iux9Zohr3o05KQOtibk+hEVihNcddEo7oMwMOVptzlN4Kd9hmmYGWzNGg8rysdH
	 U2rQjOxvUEM7YTE+qTj+qUemzAP5+o/wm09ksBnxPohqG0aqFYcGFEvn70F3v4Bbf8dUd
	 WDZ151DgXdfbPKkIGTBXIKQWqa9qpr4pDNVrnaS15JovIuCeA4zsqsvHz+0QadE7ffK9J
	 K12JsXZsi1hPTw030ICPr0iXWszOUUH8YBT8WyvVLMqMi+QWwpgrxM4rmSdXJv+2C6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjPgzOE7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD63606A33C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjPgzOE7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8561F0089F;
	Tue, 10 Nov 2026 13:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317225;
	bh=ohCN1Rx51KwrB2hqupbuAjljEHF0I8b4r+9J7PlAJ7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MjPgzOE76tM3xhSaveaThKkWGTDf4OgfCeo/ncZeiQxeCp86Kr2sXsNlRPI6F+9f+
	 VU6RT06H97CzLWH1phJRfKGPmNruAz6gxz11A32KrY13QzN5JCwPzFXYkcdhCNA/Ip
	 XtOswnM8veOrTAY70OZm9ttvxez2adzHg1QOJ79qwTUWONUqu+NLt/ifGcSZ1dKTL+
	 BAE7y7NdhLwuEXVSpHZxqDWFlC/tq3FHTYFRVy0a0k/qLjDgNfO9//HJDS/lPRsPBf
	 8maqNEZzs7DvhfPPWcYXdB5UMmyNSZiFYufRKYkT0N5+bZavBsxbmpcIv3UVCpUSzw
	 9YfuF93sXbKug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linmao Li <lilinmao@kylinos.cn>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] media: chips-media: wave5: Handle polling IRQ thread failure
Date: Tue, 10 Nov 2026 08:27:03 -0500
Message-ID: <20261110132647.1725405-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051848-failed-6.12-1d563e3d718a@kernel.org>
References: <20261107051848-failed-6.12-1d563e3d718a@kernel.org>
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

From: Linmao Li <lilinmao@kylinos.cn>

[ Upstream commit 1d563e3d718a1c7c16355843374fbdd4c798ac66 ]

When falling back to polling mode, wave5_vpu_probe() does not check the
return value of kthread_run().  On failure, dev->irq_thread holds an
error pointer instead of a valid task pointer.

Both the probe error path and the remove path only check
dev->irq_thread against NULL before calling kthread_stop() on it, so an
error pointer passes the check and kthread_stop() crashes on it.

Check the kthread_run() result, clear dev->irq_thread and unwind the
probe on failure.

Fixes: e66ff2b08e4e ("media: chips-media: wave5: Fix Null reference while testing fluster")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: Adjusted context to preserve hrtimer_init() with separate callback assignment and kthread_create_worker(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 5ec14a7c70c7c..d38be4761d4e9 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -300,6 +300,13 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to get irq resource, falling back to polling\n");
 		sema_init(&dev->irq_sem, 1);
 		dev->irq_thread = kthread_run(irq_thread, dev, "irq thread");
+		if (IS_ERR(dev->irq_thread)) {
+			ret = PTR_ERR(dev->irq_thread);
+			dev_err(&pdev->dev, "failed to create irq thread\n");
+			dev->irq_thread = NULL;
+			goto err_vdi_release;
+		}
+
 		hrtimer_init(&dev->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 		dev->hrtimer.function = &wave5_vpu_timer_callback;
 		dev->worker = kthread_create_worker(0, "vpu_irq_thread");
-- 
2.53.0

