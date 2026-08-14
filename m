Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957EF3D9043;
	Fri, 14 Aug 2026 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691204; cv=none; b=QFKy0+FkjmwoYgFvTSyer6pbd1r0MsT+9Ue/xq3MI8eNNEQ6NAxehAdvnR50n6qpH4rvKSM5Po8DmQKIs2hCRSIJjQ/2bJQwFYrfrHL2nKKDaPLp9hzUQKxFyWXK2hCFyVtxYrrqUqO07dVosgFvwhb1OkDRh9m7LtEemOCjSKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691204; c=relaxed/simple;
	bh=lzmBQ0ZVlFnUMtHbHruswaN8lYW0MwwWCO7BX0ZBFA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oPaPSp+VvTPDscozV9Os1nChyr8Llt8ELwb0tES/f7ZkQPxQoRUSnsUzFKK0sJ6f+NVwxttBasSqIS8VvLjmzcTIaFWlFqJHwHB8fSK1VnC5Yvey1riXgA2yuZr9FzFepd8gzzTdxDtj5Ptjs57usWjDjZWVBRk8mGElSBfMxOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ade93e4697ae11f1aa26b74ffac11d73-20260814
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8e2535c1-ee32-4d81-aa20-1ca546f43662,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:9a7178f2d1d7011905d6b71a73858bff,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ade93e4697ae11f1aa26b74ffac11d73-20260814
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2087165878; Fri, 14 Aug 2026 15:06:32 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ccc194101@163.com,
	Chen Changcheng <chenchangcheng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] HID: alps: fix use-after-free on input2 registration failure
Date: Fri, 14 Aug 2026 15:06:21 +0800
Message-Id: <20260814070621.68557-3-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260814070621.68557-1-chenchangcheng@kylinos.cn>
References: <20260814070621.68557-1-chenchangcheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alps_input_configured() stores data->input2 before calling
input_register_device().  If registration fails, input_free_device()
frees the input device but data->input2 still points to the freed memory.
alps_input_configured() calls hid_hw_open() before allocating input2, so
URBs are already active and raw_event can fire during the failure window.
A U1_SP_ABSOLUTE_REPORT_ID report arriving then causes u1_raw_event()
to dereference the freed data->input2 -> use-after-free.

Fix by only storing input2 into drvdata after successful registration
and adding a NULL guard in the raw_event path.

Fixes: 2562756dde55 ("HID: add Alps I2C HID Touchpad-Stick support")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 drivers/hid/hid-alps.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 370635f5b704..0556cb5645eb 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -407,6 +407,8 @@ static int u1_raw_event(struct alps_dev *hdata, u8 *data, int size)
 		return 1;
 
 	case U1_SP_ABSOLUTE_REPORT_ID:
+		if (!hdata->input2)
+			return 0;
 		sp_x = get_unaligned_le16(data+2);
 		sp_y = get_unaligned_le16(data+4);
 
@@ -738,7 +740,6 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 			goto exit;
 		}
 
-		data->input2 = input2;
 		input2->phys = input->phys;
 		input2->name = "DualPoint Stick";
 		input2->id.bustype = BUS_I2C;
@@ -762,11 +763,12 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		__set_bit(INPUT_PROP_POINTER, input2->propbit);
 		__set_bit(INPUT_PROP_POINTING_STICK, input2->propbit);
 
-		if (input_register_device(data->input2)) {
+		if (input_register_device(input2)) {
 			input_free_device(input2);
 			ret = -ENOENT;
 			goto exit;
 		}
+		data->input2 = input2;
 	}
 
 exit:
-- 
2.25.1

