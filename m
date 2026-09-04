Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB237F75D;
	Fri,  4 Sep 2026 02:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490549; cv=none; b=gSk988m6/l44X6Lw7y652qPggg9NnG5wtWRQar1MTWyA5gAhEHrEqC0dg0KyXEPlSrhJABtNU906cc1XkopPXjgXKZmb5R68TR0WaUsTNVrQXb8xo0Y0+0iWMzJ1mB3pxT4wkbZ50x4dWSbIZvo4QLgDUiDNCUjgUAivIT8Iwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490549; c=relaxed/simple;
	bh=ayJK+HZz42MN9d+6Jv+414RKqVEQUF61wxmTPGFP8GY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWzSEVnpzoI3TYb0Jh7tA/iyOMSO6mq9BX0D7ciLMlQC29xGpxDHDDij5PvfFXd5lYY6MrQxj2ytkmtfQXji/HmsJ4WVLFwJLv1KbBLSS9Bxit7kwqHiD5+JzmJhbzkAR9wKStUKf69BaZgge4Cp5Td2KAs7MoWwjGxAXa5TzkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=nKuAQAEJ; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="nKuAQAEJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1788490506;
	bh=vNJNcmINo8z0o+qLjxXN5uDfE3solxvp/+KUbiVp1HA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=nKuAQAEJyn+2r7UCBrrL5k18wbNX2FpTlxduV2yv7jm0HR2ENEZLmG60sfE1yexlv
	 2JB07XSeQc8nH2Fn7DLVAZHYtK/swfs4cl4Xf5q3w91hY4f4ptedxNJkMYIJ43E2oV
	 oxUF/lOM8qWlcI+R42hCocArvDmkLydh/+BPBXVo=
X-QQ-mid: zesmtpgz9t1788490501t82984c02
X-QQ-Originating-IP: PNHvcRxiT/yvDV9slVVTV8ms5SAzjho/q2+6CCMqSBw=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Sep 2026 10:54:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6873530075859553180
EX-QQ-RecipientCnt: 10
From: raoxu <raoxu@uniontech.com>
To: brgl@kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2] Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing hci_dev
Date: Fri,  4 Sep 2026 10:54:57 +0800
Message-ID: <049D60B81C44FFA9+20260904025457.3523467-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MkYdL7H1i+/EVbNJ6Qni/ZIs8lgbVIiHQXwwvHBwUKHO7w37/NEyKaWr
	80Ofl+3lMHBHFEoJTUJGGieNj+X5ZTjLN8JZ6L5sBkMkpLc+JCBihfm20yJIS2x/91B3ZYI
	wQOhR5SYhwu1PSqSe6Xa3odJS4wj5YIf5hvhzdqPH43v7dk8A+/pf4bXL9dIl90J2wXgNWO
	zYMG2ljDHxx3LjdAOH2GBV022ccQ7PnLXWajmWcoEZXtfvMN058liuHy8jxnd/5yMuIflfy
	XLvyO7WMmGHK/AAbd/lF9E1p14QrmmhNWYdGpYxD+9EtpImQjnmmcQrjK6Tm6OLgsM4dGUC
	3EC9HESzSfL1DqtQfCQzgrh7lzpmEHM7/gk7+Q7uGohaaAt8AkRa01F7J5eAOigMcE7Pa2c
	oLvr+J17bfSMfQuFE4KA4gJeWScO0GT+OmvXtTuiQudQx0Ge37xVMOX3mCaqOb5LKYnkyHf
	xWKnQnqvHTkNeHyzlqie59+p5Z71f+IQ/Qp3G+hvt/WyLmVA8nSNpKQ8HGTfuoiO/h6Su7l
	uZAgKDo3GBkEBmZEtOvopzzKgewKbAv/xlFCM8Y6sfPt94H+Ga3QspADTHUGpniLOMxT8f3
	X3e0BAVxu3oHbfkwdZOlDexa0+qfEVgYwaod5m9PjnsuNL6C5i58zo8zb7QfcdWZLn/nrlk
	bf5gVwJqeW1CQAszuDC+HMl+RIL1OA032dM4DcBSH5bz/WMdF2LiNO1IHWeuxSwVEQ6nVhB
	lmNPKG4csuINhNYqf9B5AXYwk/UxpHkIvIEom/HvjICBMbIMc96l0k4I590HQedZtF/I6rG
	SM2ak18xgvVO2Q7kwqnjLG51p3Tqm+9uC7+W5mrgmg38zEsGUQuWngcZFpgcgY0wCFI1yuP
	hJCUQcx5VBGsC8uAmFbrfuGguSKeWohQTWLiAao1nPyEDYMThmvFlxFY9fmUgNcsaKUZ1/9
	YlpoUuFi2kMfh3k/GfFGfyQXfbkd5dxaoMPfaSuPvXU+kAiGyB56uZWonkNwf0urNV6s5Pi
	Nn1Rjh7hTlEUkA+9KUurQjoH+rY5ly6wfwyFzJkYubxv7Mzk5w91x8IeUROKYHCkkgYjDM3
	n5LjdblA7Zh
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

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
---
v2:
- Add Acked-by from Bartosz Golaszewski and Reviewed-by from Dmitry
  Baryshkov.
- Resend as requested by Luiz Augusto von Dentz.

Link: https://lore.kernel.org/linux-bluetooth/0CB2D8D715AB9933%2B20260713072543.3348755-1-raoxu@uniontech.com/

 drivers/bluetooth/btqcomsmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index d2e13fcb6bab..d669ea4eb3eb 100644
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
2.50.1
