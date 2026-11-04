Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781058;
	b=VOLsqiVRT1kS0VMshnbBNHf2guEYgSjTA5w5DMqZGcgieKgkKXZcaE1iq6+ucCUIXtGp
	 NhkLZTvTkOCfrplTUzbyxyoQGVKtcj70xssaJdCZom3jRnzYHfZXmJrJLBKyDENcBEulw
	 RY2YbLoQVkiJP3DRIZtKWfzPytojZNkmtz4W92fwNwZ/SAkzgTfYIFq3U31DvASxnpyOO
	 KmZ9//rC1Jq+KjpNbhvKZs8KYUbjiLGkgIIvSsQkXkJIxMgliRcpyQlMH9ix8kM2mUsAs
	 a5EfIMOcIoGbR/E91qZ0osnVOBqAqZf6kpVtWGTi+Ba57rQ1CE60Vsd7Chp+uC8BW/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781058;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Uj8tvQfzebEib49IP4TwO7biv2xdB7sPLDoMB1lqXfY=;
	b=3ELyIG/SFCvdlxJBAguBr8r7kFSQ/b6+XhuKkkpp0zonC+ux+maZBh0vNOqnFHfkCI8K
	 axwAOh9XGdCAUJhFYI64F1rpAfgBrKYARFEb7yJFGxiDa9QVdKHlgJkJh2lByrGhZf0dc
	 zl8WFfn6QHLSrKFqa3QzJzx3WVebPsefzF06StnQ3MI5/C2GX18ihXuIo+xPM4BDP+hIv
	 PBrLp2qJ4P5cgfvdtl9JmTSbp586TnIRlzVoXWMTr0j0N6FVFKvbqJqrVa+qV3P+oTQYz
	 eUPYAHnsTzCC4+WjRhFjjCI4g2eJ2x5UTqfU1BmswMy90oaJeMwi0TdNvEPf53/Alpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E1D606A31B;
	Wed,  4 Nov 2026 08:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47E1D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0a48e63ad82a11f19a56ed5b684f684d-20261104
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4457f2ba-a248-4bf4-9933-fa9fdace82e7,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:9eb46779cbfa0239073993231c2a8354,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0a48e63ad82a11f19a56ed5b684f684d-20261104
X-User: songxiebing@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <songxiebing@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1147232008; Wed, 04 Nov 2026 16:30:49 +0800
From: songxiebing <songxiebing@kylinos.cn>
To: tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	songxiebing@kylinos.cn,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hdsp: Fix divide-by-zero in DDS offset control
Date: Wed,  4 Nov 2026 16:30:45 +0800
Message-Id: <20261104083045.1939479-1-songxiebing@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

From: Bob Song <songxiebing@kylinos.cn>

hdsp_set_dds_offset() computes the target rate as
system_sample_rate + offset_hz without validating the result.  A user
can set the DDS offset to -system_sample_rate through the control API,
making rate zero and causing div_u64() in hdsp_set_dds_value() to
divide by zero.

Reject non-positive rates before programming the DDS value.

Fixes: e4b6088c8cf1 ("[ALSA] hdsp - Add support for fine tuning of sample rate support to HDSP 9632")
Cc: <stable@vger.kernel.org>
Signed-off-by: Bob Song <songxiebing@kylinos.cn>
---
 sound/pci/rme9652/hdsp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 7dce548b9f36..694816f966d2 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -2802,6 +2802,9 @@ static int hdsp_dds_offset(struct hdsp *hdsp)
 static int hdsp_set_dds_offset(struct hdsp *hdsp, int offset_hz)
 {
 	int rate = hdsp->system_sample_rate + offset_hz;
+
+	if (rate <= 0)
+		return -EINVAL;
 	hdsp_set_dds_value(hdsp, rate);
 	return 0;
 }
-- 
2.25.1

