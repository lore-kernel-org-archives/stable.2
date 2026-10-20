Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489038;
	b=xiEnbwe5FHeAkEsRw8pFi3RbncHxSGCDX+zIa3fHrckYxZjy4aa8QKwVMgtyGyNz+u/4
	 YMDabYX7RgdF+sBmj/2LF8kVZpb2uMVSAFDAhdXn8Ls+R1sXr1BZbaCMoSOban12+QgzA
	 GkZ3cMANT190GG1suJ5xYwlLPRYBBxratU0DDuvWc2hyXJTK3CIXAVP00HgIsKqdoss87
	 RHS9eUBSxPbBJm4ey+GQ8T93zFdwGSgaVBOkNRPaP02mwGG6WvO0pqW8XW5+cGNSYLuy7
	 6gQ59e9BPHOVZG0bzjnAMqq6JJBlj8w7HCuTcpBz1PZIIvw555hJGT2SQ1vTjR/s0vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489038;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=J3R/yD9txiKhDcdkpR168UOWMiy5EvmjNi1jSQMpyTg=;
	b=zdEvRmlGs/JPvr9VcaxzN8gznDrAbGLs7fRmBqz44sIarzL/SNmO9OvnCfraDSQiDo53
	 75iDND/hJbG/JdwD9HY2thaZLfddy3OFxkVUQ+DyYOkzJANLAJFPU6mESvUa8Ia04UNtV
	 cfZvOUGEc987edAKLlm+rcLFJJcvOlIgy59uud6ZlPESp1OMysvAmMavjHz95srxVAE31
	 rnrVCNtBC4kDfnPmwQxXeZiJhsWS+Nt3HQPsGHXV5+YufQVRZVsLR31BTuOCrSuZijoLL
	 5tP4M4dalr3hK2+lrzeBwRm4qHHlfSLXTa6fWqbbhVERJzfRsdNFy/FujjPSLZT0g9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Japwh3Kf;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F56606A31C;
	Tue, 20 Oct 2026 09:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0F56606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Japwh3Kf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=J3
	R/yD9txiKhDcdkpR168UOWMiy5EvmjNi1jSQMpyTg=; b=Japwh3Kf6G0uYqhpEZ
	LW22YhLSZ2jVThdBByZYXRcWi3i6HfE2WMHbfKFjnAUR3BMGCGbcO40RrlEv0gsg
	/5ENuYM4Xo8AJp0E7SN1jD6Mc1g3sM//+IWoFF5pkXCQJroBAPQtemaAynYbC3/m
	d+mdgDB36u9gDcoklHYl8Xfeg=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3_4ImNtdqupV5Aw--.29320S3;
	Tue, 20 Oct 2026 17:36:41 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/3] bus: imx-aipstz: reject devices without match data
Date: Tue, 20 Oct 2026 17:36:33 +0800
Message-Id: <20261020093637.1654161-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020093637.1654161-1-yaojiale02@163.com>
References: <20261020093637.1654161-1-yaojiale02@163.com>
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
X-CM-TRANSID:PCgvCgD3_4ImNtdqupV5Aw--.29320S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr1ftrWfur45ZryxXr4rAFb_yoWfKwc_uF
	Z5XFyxZF15CF1Dtw1rt3ZxZ3yakr1Iqrn7Xr4xtasaq347Zw1fXrZ3XFWrCrZ7u3WIyFZ8
	Gry7ZF4fuwnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8qhF7UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wkoYmrXNimKSwAA3P

Platform driver_override can bind a device to this driver without a
matching OF entry. In that case, of_device_get_match_data() returns
NULL and imx_aipstz_apply_default() dereferences it.

Reject devices without match data before applying the default
configuration.

Fixes: 796cba2dd4d9 ("bus: add driver for IMX AIPSTZ bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/bus/imx-aipstz.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/imx-aipstz.c b/drivers/bus/imx-aipstz.c
index 83371e5b35a2..9f74cbcd47ff 100644
--- a/drivers/bus/imx-aipstz.c
+++ b/drivers/bus/imx-aipstz.c
@@ -61,6 +61,8 @@ static int imx_aipstz_probe(struct platform_device *pdev)
 				     "failed to get/ioremap AC memory\n");
 
 	data->default_cfg = of_device_get_match_data(&pdev->dev);
+	if (!data->default_cfg)
+		return -ENODATA;
 
 	imx_aipstz_apply_default(data);
 
-- 
2.34.1

