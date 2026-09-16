Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5A41D11A
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587280; cv=none; b=sGKA1/8trgugOCeA57ie5XZNyBctxrubm4iceAeYIZjK0V46tcfjbtnVDw0YKO/a9Ib6Ig2hrSnD3FmUuhxhXqJRK2gKLpEOo/gKbJY8DUsv8dS+rin1cqKvVp6/FDsYSo3c8WiVvq0K4DPU9TvVASbMAWvahX2O/j9eiNDjY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587280; c=relaxed/simple;
	bh=aoudXyBzh8fTBxtLjSq/mvk74M6fjLaG8dTwZGwhkuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EucHFGjGyhsXscasAIwxH0V0QQW3ts5VtgrE3TqEPL9LkIOWtIavkbGMCEbTfWnCXUvd/V+xwxz/zkEoclDSH0YjOjBCitAKnuHr/1m1qn2XP+A/bSTFJTL0ONAY+LAYQe3/rZTMic6yDkGNX/+ZRLLZPviaLlF97kNBWz+9JNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIOWVi6o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIOWVi6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F41B1F00898;
	Wed, 16 Sep 2026 19:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789587263;
	bh=ufN6RnXV9j9eXotuwXtTarCFNFL6uYsrCutZJb07s/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TIOWVi6oVERzvCHhaIq8trFzdHRFvgD/hBT7hxmsp8CqtB6JzaMrsEthBPXwGa6VL
	 IwlJ8PE1XKpFl4bNcXgJ3ApV3dltUVRA+zb4uTF/RtAWHw0oVHUQGmYjVDSRKQOQNk
	 CK4WVpjGq4B+u21O0Bj9onxY1Of1IwScpcE8kz0kYCI7dE+MbsghbTQo3tz4jP7/Pc
	 BK2EFhGEL8GEKVbRTZ3k7qCyLezbISn/PA19MOXJKtAEhmhFpg2xbBwk0uvTqDw8EK
	 clKtTjjpOjX7ZONv+7ZZaod7Tk4wLVPtPGp3fg5UEY57KJnzvOUU4Pt/7eIdiRyA7t
	 o1BSpVa8ecXcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] Bluetooth: btqcomsmd: Convert to platform remove callback returning void
Date: Wed, 16 Sep 2026 15:34:20 -0400
Message-ID: <20260916193421.2305743-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091651-directed-clerk-0992@gregkh>
References: <2026091651-directed-clerk-0992@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 4a62832f565c950d645a4f7b199a0a7985815940 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: f5a427b16e45 ("Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing hci_dev")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btqcomsmd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 11c7e04bf3947..88dbb2f3fabf9 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -197,7 +197,7 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int btqcomsmd_remove(struct platform_device *pdev)
+static void btqcomsmd_remove(struct platform_device *pdev)
 {
 	struct btqcomsmd *btq = platform_get_drvdata(pdev);
 
@@ -206,8 +206,6 @@ static int btqcomsmd_remove(struct platform_device *pdev)
 
 	rpmsg_destroy_ept(btq->cmd_channel);
 	rpmsg_destroy_ept(btq->acl_channel);
-
-	return 0;
 }
 
 static const struct of_device_id btqcomsmd_of_match[] = {
@@ -218,7 +216,7 @@ MODULE_DEVICE_TABLE(of, btqcomsmd_of_match);
 
 static struct platform_driver btqcomsmd_driver = {
 	.probe = btqcomsmd_probe,
-	.remove = btqcomsmd_remove,
+	.remove_new = btqcomsmd_remove,
 	.driver  = {
 		.name  = "btqcomsmd",
 		.of_match_table = btqcomsmd_of_match,
-- 
2.53.0

