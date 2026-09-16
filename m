Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D770431A3C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587280; cv=none; b=oDpAL0kgzqH45I+s52DMUozlJlm60QcBDpfypq4josb8qTD4KThrCvvwPhU6c72rULb/XqaFeKnAzcQCh2t49qO5CXHp+w5Yw6fm9HkKDcvRvLd2knzX794Bs0M+U1zahSTL+Jlw0r8Qed6RENcNZcDZXxVxjYKqQEAsMVCA7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587280; c=relaxed/simple;
	bh=ilw1SB6la13Ug3youe8i2CB50w62E/CBmKDv+j7CDhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bpio6l1ULJKSebpHhK01ERps/y1nuLSPdVhIzz6fiKofLO4sjradU65fqkY5SdzrdbWh6IvcM0hZA4sklKajXSzP2zRbsuRYJPRLaMcrsZu7JRMs+QBlfs6H4iH8P4k309G2x8joSWlPxEewpEytqEX0vi/x9O1+HBNZDlv6sck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej2IwQ1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej2IwQ1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6266C1F00899;
	Wed, 16 Sep 2026 19:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789587264;
	bh=wf4ouioXFJVicOtBIVKJjmi5ayrItmQ251SIiyh9b2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ej2IwQ1KRo/aS+WQj+8tdMzWzn9QYUR2OgqG2RqgOhJx+FtQ2eXS9oiM9lk6ds821
	 MV5NoizkqhmIzK/kiwWNEGLtm+2fkQjc2dF6g8Z3vBsU0HdR3Vml96j0Ez6CbUBm1f
	 fIhvDXjqplE9tjHNxcwsnLMl6twx/EaKqxpi1YZhFshlD6eCPQlyHZ5JuZI+6++3ra
	 Kkh5gjb5F6a+a/5uff00/0n0aWbOQEiUB9976pIMRoQ88yuJ3m6D2FLMo3u1mSOJ2r
	 S7cg1iL1DSCEJvtSLTQXDPtFsndL/bG9RpSSC5tELaNY8CGDQ106h1Lb5FwDC77VM5
	 8LWPS01OstmjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing hci_dev
Date: Wed, 16 Sep 2026 15:34:21 -0400
Message-ID: <20260916193421.2305743-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916193421.2305743-1-sashal@kernel.org>
References: <2026091651-directed-clerk-0992@gregkh>
 <20260916193421.2305743-1-sashal@kernel.org>
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

