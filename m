Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA063812EB
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470541; cv=none; b=lfvZkksh+4VS5C1wOaJnE+6KCgfQfYU5IDCCImx/BJUCUzSnn+y39vq2I2ROyDWIPssTStLN0AyctjVLXG6XjKQ2RU2trtWNC7QvVhUpDzgGqrF56pTOACwl9mVFn3bcj8ZtL3pYP18QGLvFrhrbqHNBUNT4Be3JE1VUaHlmTr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470541; c=relaxed/simple;
	bh=vKEWT6O9bP3DpdrhVvIho3UWnDQ9SYmZ2ge7bd0ghi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjO/HRCLCTrNUzlevl9L5vjbn2B8h5vhfLKWM4nhAhjbeazvbidacwaengLWKvEPGV/uMiXUL45xA8yDlkycdTgEqvveqoh64x6OnRrkgRYDlZGYVSCQdQ5O3zWiZAMBxwdKYVpez3SoZK4kYHb1MqFBcua8TD3ojKTJrI9+l6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHBy03Tu; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHBy03Tu"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30bc871ecdfso1100032eec.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782470539; x=1783075339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qP0J1iWyaoP+HLz+xwVairx0bDAZ93dXt6GX/Ei5LK4=;
        b=fHBy03Tu8aWNwiNoaYzg4OYrJP0AQIjPljRbJNW2ZHM7XRNAwgd/99RgeN1qx/cOlT
         Omt1uq7m+Z8kGKMbqlv2D+PjxXyZ5XafIf0F9wreEP419/oI5muTPFGv9qPdwHEzGf/N
         csma4i+FabdXk+Fu5vNUUbrdDHfDSV331lb+yGc7DiQEBuw3mnjxsiC0GXii7OGwLtRi
         rDMXdgnzDQWW6kMvRLWh2pKt5Gd5CLUHOKpCIY89fKb5D1m0i0Nn+B2yGPEfIq//0ZMI
         qIXRlHGAfUzLkEldaDZDKNWswOESWCXbv2vHY26GKCQkY7aw7cg4/3YQBSfaBoQjV41Z
         qtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782470539; x=1783075339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qP0J1iWyaoP+HLz+xwVairx0bDAZ93dXt6GX/Ei5LK4=;
        b=gg7qo04/xAJiIdM1PW9BvH7D+CDCkaHXZpGKuxxz/kaJXKGVtK8jt1wKgiHPBu/uto
         4mSGMqHu05mBCo4MWQaOIAJ9dg9k5JMY98a7M2SoSid/woAPi9SmOTfEj1UTnFWZ093W
         zgWssM1YzWqYwPXeJz4FmttmNkBOa7ekctXU9e2Dx/q/ku2+pEAzGCKF3j7h2+r3SLjv
         Oqme3aLLV3mnkwIdR5WSn9gkDp4E6f9UQW+9m7O1VEikuP/pv9EBgWn5ETWR3pbeMg5f
         +YGnX18Bjj2JJvY583og60DcL9nbcCAIs6MtMQ3HjhU1/DNz1ojbz1YHVchrWtydAwOx
         Rehg==
X-Forwarded-Encrypted: i=1; AHgh+RrVLirVFaXCz8VnHgnYVncSH2As7jSFf2//NjL29hyIyYYy4VlZAMkczloPs1hfe2x7Nx+AzYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUDAyF7x0d1/+lY42QVHX9FsSENFtUDW7GV1bZeLg1BTRBdCOC
	Tdj0ruJ2l3PxWTRWVoUMvBx9v6sTDSACktXTrmJR7l6OPd5/qnyBIpXO56OXpPA8f9bceA==
X-Gm-Gg: AfdE7cmSIQxa0+SL+1ZY3D+NUZuiVgMgpH4sDwJFkKymg237v9Mm1fZHftnbam8Ra9c
	ggKO1RVOrOFkQu3Iv7rWwlLzSCbY83nwEtQNruHocKxf4rOUDWWkDv1BAutmuuuc/4l+ESJfgoh
	WAazGvwMcg9PXsL+Uaa8v4pIDdUu5ygQ2ZZQXXRcfJFJULvDzBt6M4n7mlmzG/KQCnV7KlIjcmG
	wh4A3dddoiJE25WKVp0+kQ+kP9iEsnNAmeOZ6+DD2ZLjzPxYRvNhLUupfQsU3X2FgVvRsmm20Wi
	MiYRIjbI7ZbM4rkw0WbfNMi6IiNReGTZDcRt5FdcPrCUhWBVpBSNpAWyLXurz+Jcwv0W4B9kGMM
	3n42X8JYlDaYk86LDZfQsaQccbC9s56zd4VuIEzSjEw+BkK3AhjZJeRDAzss3b/IQ7LTbrY6eve
	NEVO9wczz1O8qvLBa6ss5sUWEYUyBmpPN6SZNJC9OH588ChbiBIB0BTt1JSQ==
X-Received: by 2002:a05:7300:8b85:b0:304:bce9:25fa with SMTP id 5a478bee46e88-30c84cf58edmr5969617eec.4.1782470539345;
        Fri, 26 Jun 2026 03:42:19 -0700 (PDT)
Received: from naduvan.timesys.com ([122.178.167.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1ae5sm18956056eec.16.2026.06.26.03.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 03:42:18 -0700 (PDT)
From: Siva Balasubramanian <sivakumar.bs@gmail.com>
To: sivakumar.bs@gmail.com
Cc: sivakumarb82@gmail.com,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] Bluetooth: btmtk: validate WMT event SKB length before struct access
Date: Fri, 26 Jun 2026 16:12:00 +0530
Message-Id: <20260626104201.3463460-2-sivakumar.bs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626104201.3463460-1-sivakumar.bs@gmail.com>
References: <20260626104201.3463460-1-sivakumar.bs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

commit 634a4408c0615c523cf7531790f4f14a422b9206 upstream.

btmtk_usb_hci_wmt_sync() casts the WMT event response SKB data to
struct btmtk_hci_wmt_evt (7 bytes) and struct btmtk_hci_wmt_evt_funcc
(9 bytes) without first checking that the SKB contains enough data.
A short firmware response causes out-of-bounds reads from SKB tailroom.

Use skb_pull_data() to validate and advance past the base WMT event
header. For the FUNC_CTRL case, pull the additional status field bytes
before accessing them.

Fixes: d019930b0049 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 634a4408c0615c523cf7531790f4f14a422b9206)
Signed-off-by: Siva Balasubramanian <sivakumar.bs@gmail.com>
---
 drivers/bluetooth/btmtk.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index ad8753dda826..5c6f4d4b2e7f 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -655,8 +655,13 @@ int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	if (data->evt_skb == NULL)
 		goto err_free_wc;
 
-	/* Parse and handle the return WMT event */
-	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
+	wmt_evt = skb_pull_data(data->evt_skb, sizeof(*wmt_evt));
+	if (!wmt_evt) {
+		bt_dev_err(hdev, "WMT event too short (%u bytes)",
+			   data->evt_skb->len);
+		err = -EINVAL;
+		goto err_free_skb;
+	}
 	if (wmt_evt->whdr.op != hdr->op) {
 		bt_dev_err(hdev, "Wrong op received %d expected %d",
 			   wmt_evt->whdr.op, hdr->op);
@@ -672,6 +677,12 @@ int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 			status = BTMTK_WMT_PATCH_DONE;
 		break;
 	case BTMTK_WMT_FUNC_CTRL:
+		if (!skb_pull_data(data->evt_skb,
+				   sizeof(wmt_evt_funcc->status))) {
+			err = -EINVAL;
+			goto err_free_skb;
+		}
+
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
 			status = BTMTK_WMT_ON_DONE;
-- 
2.34.1

