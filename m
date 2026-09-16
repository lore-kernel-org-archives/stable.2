Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2874A4C9DF6
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587836; cv=none; b=ndjSP1CnIxHxR3aTNkIqPV2uQnBu1HP1LjyoS31MAhcXvzW98GtTxwCdj5CW9k1Ldh1ClM2bSCGSxfUNDyebhiRF9yg0jzXV4Cbf1FdpheKyl5YxhEqSX1V1ZRY6ts6daNNKsCWVRgkqAAurepCNkDX0L62uHdTkFhycFDu1iD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587836; c=relaxed/simple;
	bh=ilw1SB6la13Ug3youe8i2CB50w62E/CBmKDv+j7CDhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pqx2/wAc/qbUFGyyYMXHUbELqVhSioeI9eqenjUES5O3/QRzAyfUsfrgnGQgOu9oTiUckKAkYVavLjApFYdOTIIQe7JLLvgij5iuhuwZA2sxiRrf+GtdXQS2449zDa1u+ORksOSJaVu2H3dmcYleKhtoi0hTJa10wKt8IPwZhd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HK2GP7l5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HK2GP7l5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704101F0089A;
	Wed, 16 Sep 2026 19:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789587820;
	bh=wf4ouioXFJVicOtBIVKJjmi5ayrItmQ251SIiyh9b2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HK2GP7l5zsZmfUWFidHBiCh+PsgQEiscQJtmOF/k+s4vEC/Isr+bvMp50Y8U70v/n
	 e788trrwDdxrTsV5IKjO7vNgRK5WcqjIQLmwAI3+xWWFYIicr9LoJpQS2ejEcqJWnT
	 xSCwUoEJMAOoQ4N8wQKgB5gSvbCxy4WE1Pu979R3zzciThwOMws60JO/LsDJr4a9L5
	 1RqJhNpGtYa2ib1slLtWHBRiT01D9hZrd2/OtBFWm70MvX6MHAxzWGsxuWzpVPpkFt
	 kyhjisQPJ3Zb6oPIts6+lxlPTBu1yJzHG7opXcmiyV1vkzW5eyHJC+ITwrpEjQbnyg
	 HPwedj7W50esw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing hci_dev
Date: Wed, 16 Sep 2026 15:43:37 -0400
Message-ID: <20260916194337.2394829-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916194337.2394829-1-sashal@kernel.org>
References: <2026091653-junkman-earflap-77c9@gregkh>
 <20260916194337.2394829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Rao <raoxu@uniontech.com>

[ Upstream commit f5a427b16e45210dee656b0860728f3d496dee85 ]

The command and ACL RPMsg endpoints store struct btqcomsmd as their
callback private data. The receive callbacks dereference btq->hdev
without taking an hci_dev reference.

The current teardown order frees the hci_dev before destroying the RPMsg
endpoints in both the hci_register_dev() error path and the driver remove
path. If WCNSS delivers data in that window, the endpoint callback can
run with an already freed hci_dev and pass it to the Bluetooth core.

For qcom_smd endpoints, rpmsg_destroy_ept() closes the channel and clears
the callback under the channel recv_lock. The receive path holds the same
lock while invoking the callback, so destroying the endpoints first both
prevents new callbacks and serializes with any callback already running.

Destroy the command and ACL endpoints before hci_free_dev(). Keep
hci_unregister_dev() first during remove so the HCI core stops issuing
operations before the transport endpoints are shut down. In the full
registration-error cleanup path, return directly after freeing the hci_dev
to avoid falling through to the partial-construction labels and destroying
the endpoints twice.

Fixes: 5052de8deff5 ("soc: qcom: smd: Transition client drivers from smd to rpmsg")
Fixes: 9a39a927be01 ("Bluetooth: btqcomsmd: Fix a resource leak in error handling paths in the probe function")
Cc: stable@vger.kernel.org
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btqcomsmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 88dbb2f3fabf9..4ce8354ebb86b 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -188,7 +188,10 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	return 0;
 
 hci_free_dev:
+	rpmsg_destroy_ept(btq->cmd_channel);
+	rpmsg_destroy_ept(btq->acl_channel);
 	hci_free_dev(hdev);
+	return ret;
 destroy_cmd_channel:
 	rpmsg_destroy_ept(btq->cmd_channel);
 destroy_acl_channel:
@@ -202,10 +205,11 @@ static void btqcomsmd_remove(struct platform_device *pdev)
 	struct btqcomsmd *btq = platform_get_drvdata(pdev);
 
 	hci_unregister_dev(btq->hdev);
-	hci_free_dev(btq->hdev);
 
 	rpmsg_destroy_ept(btq->cmd_channel);
 	rpmsg_destroy_ept(btq->acl_channel);
+
+	hci_free_dev(btq->hdev);
 }
 
 static const struct of_device_id btqcomsmd_of_match[] = {
-- 
2.53.0

