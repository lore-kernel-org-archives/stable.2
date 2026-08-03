Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574343876C9;
	Mon,  3 Aug 2026 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750356; cv=none; b=qMijbpFZXcJgRcAQzsc6WKXNVwDU6KcgzWzBfHFYbq511f6+IcqEoi7L6MzsNVwwu28Arhj+4k4RKBRGlxUezjmI5K7bhd/WOvQxZwjFePK6ygQQAcXmEoBmIwrrk/8enmucOqWK5VlbJ525cYlcqRVNvx2jJH+K8FnjOCOpeMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750356; c=relaxed/simple;
	bh=ELSJCgqOhg11ARt8mfy+vrMr2W578dYLcTEIel+Kzv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HF+H4M5m0rNwt2kaLZ9xvrFT5TqXzhLVfbgJDdV1t8vrUnFNmcGlppYtkqsoAZQksD8T9mumxQdamFFOSl6bAQHzWeGgEBPuvV5fUwYj2OgyGjI2khfg2zAn6pZhCWAdl1PwicfAgG5VIg0U6uJ8H3KeVmQMD1zpNDBjRvea4BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 195fda968f2011f1aa26b74ffac11d73-20260803
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c8b04289-20b1-4458-949f-d877ccb269a8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:a8465eb09277316421c3ece6be80f4e4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 195fda968f2011f1aa26b74ffac11d73-20260803
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2097077048; Mon, 03 Aug 2026 17:45:45 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: mchehab@kernel.org,
	crope@iki.fi
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Changcheng <chenchangcheng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] media: dvb-usb-v2: reallocate URBs after a failed reconfiguration
Date: Mon,  3 Aug 2026 17:45:39 +0800
Message-Id: <20260803094539.242495-3-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260803094539.242495-1-chenchangcheng@kylinos.cn>
References: <20260803094539.242495-1-chenchangcheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb_urb_reconfig()'s "all fields are same" early-out only compares the
stream configuration fields; when a reconfiguration attempt failed, the
stream is left without URBs (urbs_initialized == 0 after the allocation
error path is fixed) and every later usb_urb_submitv2() call with a
matching configuration skips the reallocation, silently leaving the
stream without any submitted URBs.

Include urbs_initialized in the early-out condition, so that a stream
without URBs is always (re)built on the next submission, no matter which
configuration is requested.  This makes a failed reconfiguration
recoverable by the next start_feed() call.

Fixes: bce1c0290270 ("[media] dvb_usb_v2: dynamic USB stream URB configuration")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 drivers/media/usb/dvb-usb-v2/usb_urb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/usb_urb.c b/drivers/media/usb/dvb-usb-v2/usb_urb.c
index 9ba9aceabb5b..15603d448fc1 100644
--- a/drivers/media/usb/dvb-usb-v2/usb_urb.c
+++ b/drivers/media/usb/dvb-usb-v2/usb_urb.c
@@ -276,7 +276,8 @@ int usb_urb_reconfig(struct usb_data_stream *stream,
 	}
 
 	/* check if all fields are same */
-	if (stream->props.type == props->type &&
+	if (stream->urbs_initialized &&
+			stream->props.type == props->type &&
 			stream->props.count == props->count &&
 			stream->props.endpoint == props->endpoint) {
 		if (props->type == USB_BULK &&
-- 
2.25.1

