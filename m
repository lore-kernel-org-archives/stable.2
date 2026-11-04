Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816535;
	b=FJcqGEl7LasmXEVffyuMB+7KuFfadtsGIlsGhui8u5uhaDOG8Mk21v99EfbU9tbd5odH
	 KvV1eIsNW8FYaqWAHedkfRv2klrmBWgdWba22ZWApVAbI/WND61P7G5BcZ3NRxVxhlEuS
	 /+AJdyrTNtOpEzqRdf+WBPT7eVl3xGwZkAd9WdugpRlREwiPATB1Vc1kcPd7/+8buLCOu
	 agY4PkHtEWZTdibbKj70UC4LpFF5T2eQ3jwEM965gV41LyxDxfPvuE+bc8yqYOouQFmKX
	 ALQ+cks8XziT8iNFWou6NpbI9IiGxAfMuwncC7EuMBfau7D8NGreKMk/HIibF1aDIuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816535;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qPPpN4ahLrF8o8TLPRgTarwvhVY4ABlVCELeHfidc/Q=;
	b=r61cSqknbrsWLT1wpPfPuArDJXOwo2ewo3OM30+ZCaF+kDD58ihonNmCOAbEpo8qy2+R
	 3mB1OxHkIc2ffCOw/jZaQ/S53nxJhZkEJUAok01fOH/KLxCS4CfFnqXkjTv+aVXI9x1iW
	 VgSfHtntgLTP7jiBNxm7B9nfpTV+GjhOkKiW3+ksgOhnTHVaUmZRTtiX3LLJea+bMC9FQ
	 GCQXc2pW3ST6yMHWkNI9Dwu+L9bioby67SEngBOf7caLykq+PBEljnrHDlDgVj5iz6Rqt
	 1adeLWPf8LWgXftNzyigQcFmAzVc1ytUeBjPXVNmIjeEMJdxDLkZ8vZoq5szs5Y3LFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AyO0ICnc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D84E606D2EF;
	Wed,  4 Nov 2026 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AyO0ICnc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2712D1F00919;
	Wed,  4 Nov 2026 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793816535;
	bh=qPPpN4ahLrF8o8TLPRgTarwvhVY4ABlVCELeHfidc/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AyO0ICncZ/G+WVzrSQnHEGMG5uhpXeVqKpOeFqJtFLXeKIaJqfd5rcaKPfYmOzQo3
	 Yt3/8Qk0h5qML/MT2uNhamu8T4HIz3niXHEFCmFivjkeuGkd/Xm9fVhJ4mF5F6GfBg
	 idpCp0I5MgXiYSfYOJ8XglNTw5G/we6/PndnfyuRxEYtR8o18cQ/TWQKLet2rDWF59
	 AltzOO6GAhb2HXBZxCVXXmxh6CU9/5MfHEucQQwfoBLr63lRid0JvlxJF7/BXFNjxx
	 l9UAmjzVpqZauUoVatAsV1ZdbT5OrQK/IpwrLABHQFrOzUXJTyi8YGBhKUmxps0sF+
	 XNrwyyNJ0bQQw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/10] regulator: core: Flush delayed disable_work before releasing supply in regulator_unregister()
Date: Wed,  4 Nov 2026 18:20:53 +0000
Message-ID: <20261104182148.1176116-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104182148.1176116-1-lee@kernel.org>
References: <20261104182148.1176116-1-lee@kernel.org>
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

regulator_unregister() currently calls flush_work() on
rdev->disable_work.work after tearing down and freeing rdev->supply.
This has two bugs:

1. Because rdev->disable_work is a delayed_work, flush_work() only waits
   for work that has already been queued and ignores an armed timer,
   allowing delayed_work_timer_fn() to fire after device_unregister()
   has freed rdev.
2. regulator_disable_work() locks and disables rdev->supply via
   regulator_lock_dependent() and _regulator_disable(), so releasing
   rdev->supply before flushing disable_work races with any pending or
   running deferred disable work item.

Use flush_delayed_work() at the start of regulator_unregister() so any
deferred disable work completes before rdev->supply is torn down.

Fixes: da07ecd93b19 ("regulator: Implement deferred disable support")
Fixes: e032b376551a ("regulator: Fix deadlock on removal of regulators with supplies")
Closes: https://sashiko.dev/#/bug/linux-6ee97926-52f2-4842-ba55-b554f9b39d53
Closes: https://sashiko.dev/#/bug/linux-aac296d1-789a-469b-8bde-8e110c4447ea
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 14422cfe80e2..935fee27f126 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -6299,6 +6299,8 @@ void regulator_unregister(struct regulator_dev *rdev)
 	if (rdev == NULL)
 		return;
 
+	flush_delayed_work(&rdev->disable_work);
+
 	if (rdev->supply) {
 		regulator_unregister_notifier(rdev->supply,
 					      &rdev->supply_fwd_nb);
@@ -6308,8 +6310,6 @@ void regulator_unregister(struct regulator_dev *rdev)
 		regulator_put(rdev->supply);
 	}
 
-	flush_work(&rdev->disable_work.work);
-
 	mutex_lock(&regulator_list_mutex);
 
 	WARN_ON(rdev->open_count);
-- 
2.56.0.385.gac671c819a-goog

