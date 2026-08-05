Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8F348C4B;
	Wed,  5 Aug 2026 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894064; cv=none; b=DvNsu/U8/PCQjls/AAUoRWkuMLZ5esx8T4liXEQll83n2ek9RQWa8MGDOzaLDyNgFQFYaVIA+V95/aVysTlEGC0DO1fWic5uMYvkX/+YNTs2UXKuXjJO7Nw1gsSfKNiVMRYvRgv1eb8g0Dl1EBCwrigMgl/QwSzHuUxtz1xohBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894064; c=relaxed/simple;
	bh=m9lGJ1PPti98suGO6c7+JnypKTlaVN5Hx+xsrn3o4Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ICg9SnOLXScVaEinTE4iM2NRk07DSJTB7ZowuQHfKGl1Uc1RO8m4AYOd1Hx2Jw2eSKaczInf1N9u9uMcoYWMD1Is8hneQk58J65ODzepinTCxpXFrS8WxffXwhwWYi2RFEoMID88k93GIctZEbDRjIg3itpu2s7qgH3xEmjDBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b1a4fbf2906e11f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f424f8b3-04f0-4db9-8d31-5503ec6129c2,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:4edaa9e08d59eaa475e10643631151b1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b1a4fbf2906e11f1aa26b74ffac11d73-20260805
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 259595402; Wed, 05 Aug 2026 09:40:52 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: dwc3: gadget: Fix use-after-free in dwc3_gadget_free_endpoints due to race condition
Date: Wed,  5 Aug 2026 09:40:49 +0800
Message-Id: <331d1d5133496d2b4184e05f8848adb06930a138.1785893865.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In dwc3_gadget_init_endpoint, &dep->nostream_work is bound with
dwc3_nostream_work, and dwc3_gadget_endpoint_stream_event can queue
this delayed work on system_percpu_wq when a DEPEVT_STREAM_NOSTREAM
event is received.

If we remove the gadget, dwc3_gadget_free_endpoints makes cleanup and
the memory allocated for dep with kzalloc() is released by kfree(dep),
while the delayed work mentioned above may still be pending or
running. The sequence of operations that may lead to a UAF bug is as
follows:

CPU0                                      CPU1

                                          | dwc3_thread_interrupt
                                          | dwc3_endpoint_interrupt
                                          | dwc3_gadget_endpoint_stream_event
                                          | queue_delayed_work(system_percpu_wq,
                                          |                    &dep->nostream_work)
dwc3_gadget_free_endpoints                |
dwc3_free_trb_pool(dep)                   |
list_del(&dep->endpoint.ep_list)          |
dwc3_debugfs_remove_endpoint_dir(dep)     |
kfree(dep)                                |
// dep is freed                           |
                                          | dwc3_nostream_work
                                          | // use dep (use-after-free)

Fix it by canceling the delayed work before kfree(dep) in
dwc3_gadget_free_endpoints.

Fixes: dcfe437492e2 ("usb: dwc3: gadget: Reinitiate stream for all host NoStream behavior")
Assisted-by: Codex:deepseek-v4-flash
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: stable@vger.kernel.org
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
changes in v2:
add Acked-by add Cc stable
---
 drivers/usb/dwc3/gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fa0f16ffafef..fa944856f956 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3508,6 +3508,7 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 		}
 
 		dwc3_debugfs_remove_endpoint_dir(dep);
+		cancel_delayed_work_sync(&dep->nostream_work);
 		kfree(dep);
 	}
 }
-- 
2.25.1

