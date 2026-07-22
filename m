Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4A14C6EF6;
	Wed, 22 Jul 2026 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715506; cv=none; b=iwZI089NuGkwCcpTF7Eg/xBi8XFDxO3vV8eAW7K+lQ3aua8h7s0afcw5/ylmW3xdLZjArGS+n6FdfczlhYhbO8D2HyGqCq40TnXOdxwHoykn9GROiS4jRx14MNJe1eE63/vLd0bddHQB7Jm+J0nN73YXhFxsnwXFIYkfCF8rrTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715506; c=relaxed/simple;
	bh=xUPP+gW7Bh28AmP5Zq+ucqDnbAHFzTCozSVPSf9w7N8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lpM/wsTaAXAW98y5THpimup1uC9b9fvWCZDUYsTJYK4HizA4zwItr8Fh/94O/6rDb0UwNYJ8yWg0TBp6GuWj/jq6YhA9XM4RaurToy5dw/Ahs0GVTrAgqMTuAfi6Z36PcafiC4OkCyYWDjlLnQ9xNh0+87FV8lRfW/mdV/MJyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a6a038d885b611f1aa26b74ffac11d73-20260722
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4a1b28b1-e874-4562-a05a-acb9cd6ef726,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:9e6fc850c72f477a14dd7304f7672c5e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a6a038d885b611f1aa26b74ffac11d73-20260722
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 491663018; Wed, 22 Jul 2026 18:18:15 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: israel.a.cepeda.lopez@intel.com,
	hansg@kernel.org,
	gregkh@linuxfoundation.org
Cc: sakari.ailus@linux.intel.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: misc: usbio: check ibuf_len against rxbuf_len in bulk msg
Date: Wed, 22 Jul 2026 18:18:10 +0800
Message-Id: <20260722101810.458634-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ibuf_len is the bulk IN (receive) buffer size, but the EMSGSIZE check
in usbio_bulk_msg() compares it against txbuf_len — the bulk OUT
endpoint size.  Both are taken independently from different endpoints
in usbio_probe(), so the check is wrong when they differ.

Use rxbuf_len for the IN direction.  This matches the buffer that
actually holds the response data.

Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/usb/misc/usbio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/usbio.c b/drivers/usb/misc/usbio.c
index 3c2474dca810..fe093e7760d5 100644
--- a/drivers/usb/misc/usbio.c
+++ b/drivers/usb/misc/usbio.c
@@ -265,7 +265,7 @@ int usbio_bulk_msg(struct auxiliary_device *adev, u8 type, u8 cmd, bool last,
 	lockdep_assert_held(&usbio->bulk_mutex);
 
 	if ((obuf_len > (usbio->txbuf_len - sizeof(*bpkt))) ||
-	    (ibuf_len > (usbio->txbuf_len - sizeof(*bpkt))))
+	    (ibuf_len > (usbio->rxbuf_len - sizeof(*bpkt))))
 		return -EMSGSIZE;
 
 	if (ibuf_len)
-- 
2.25.1

