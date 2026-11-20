Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.130.202.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795137284;
	b=B1gsry5tnFkNsXWLSMoxtZ/8r7CVJer7a8KzgoMU/6d/PFrBcOxAH3loY2qeotroo3Dc
	 HZO9r4DeVd7JrCItLyaaQEFrjV+5y2e5HVQxPrDWV142H4RxenKJu23RzOrCGxF/AOZPo
	 Z7r/x2C6R5EKjiLjlUIigfLfLeXAXP/eW7fIs8tBRhskx6/6h4p2Ssi2DdN+movxZSWzV
	 +noCa1r89suWdrj9/QSIgmOCqiF3lbp5AuW9QrTy2cea3KF0l6uu1F3aia/JYcZdW3PLj
	 5GmPq5iSpI932UEKQmWOoCQtn521miAsxMJx3G7FCzo1k10WeiIUi2lQ9Goitun56bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137284;
	h=DMARC-Filter:DKIM-Signature:Received:X-Iguazu-Qid:X-Iguazu-QSIG:
	 Received:From:To:Cc:Subject:Date:X-TSB-HOP2:Message-Id:X-Mailer;
	bh=UoIWbPVOiohhKQTZY1cye2A8379e0Qeuqu5fWufwRPo=;
	b=kChmsxM1RWDRnd8G0QfHeglFLFnhPF6egKpc2Ul4OzlZRqk+foz9WaU0AEHrfR5JMO7c
	 Zq9OVCnPoUorJlpgjZVIqTrTeZ5Z0K2UZMJCrsIdbKB5v5XDI/SVimSLlvQW+v/bOk6dB
	 a6p2RNwi/iX0N3bDWFTe9cuvlfIG+de8gWgabuIut9736Mqst5axJNrM8SEgkioVHI3AS
	 1pOMW6U+dJhilnCF86Ghi2IeQUg/XJGNimEtUHxoX2t6vVyEDjcb7AXBbCi2gFHDIfi5z
	 YxX+9ZEamI/GKPQN41b3XsWS75l2mdFh8Q8OLF7cMj05eRO1SUDEdNTV+IegI6S5DSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.toshiba;
	spf=pass smtp.mailfrom=mail.toshiba;
	dkim=pass header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=oAOCRAse;
	arc=none smtp.remote-ip=210.130.202.132
Received: from mo-csw.securemx.jp (mo-csw1121.securemx.jp [210.130.202.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4D606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CF4D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=oAOCRAse
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1795137261;x=1796346861;bh=iKavwCCyMVkYvyOVr+m2Cp/4mN9To2ZoMZJXKv5y10Y=;b=oAO
	CRAse6qQrhVmK7gG9SsiKK6KRB35+SJ98HU6TcyJwFYSybiEM0091pMyrSjq54yi2KGn1II9CuG6l
	psGFw2D5UUXeEPGkeJPgX7iqRnCTrYHWScEVfyesFERrO22RJiwbb1L06FJP7tz41bcAolz2HY84w
	r3MURhM6lnL/5tKB6vijsfzAYbxTrQUPnszIYLrNQLti5W5u087l9G0OB2BvcdUjAnImrwJMA7OtB
	magtqZdJJIUoTEqufyQUhjMFKv7qEWu4dM9448QSpXgONfbCQevV36wCHhcis8n3Bsmy3ECX5Rkcx
	VFZqrS8JNZ8CngllYsiuW284vz3f8IA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6AK1ELS41801772; Fri, 20 Nov 2026 10:14:21 +0900
X-Iguazu-Qid: 2rWhqUWdp4badPbsPI
X-Iguazu-QSIG: v=2; s=1; t=1795137261; q=2rWhqUWdp4badPbsPI; m=OoWjNEOnWIxpLNo/DPmiQ936gGUJi2I2O3sgKC925ZY=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jVy6N6qZ3z1xnr; Fri, 20 Nov 2026 10:14:20 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 5.10.y] virtio-blk: fix implicit overflow on virtio_max_dma_size
Date: Fri, 20 Nov 2026 10:14:17 +0900
X-TSB-HOP2: ON
Message-Id: <1795137257-10563-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

From: zhenwei pi <pizhenwei@bytedance.com>

commit fafb51a67fb883eb2dde352539df939a251851be upstream.

The following codes have an implicit conversion from size_t to u32:
(u32)max_size = (size_t)virtio_max_dma_size(vdev);

This may lead overflow, Ex (size_t)4G -> (u32)0. Once
virtio_max_dma_size() has a larger size than U32_MAX, use U32_MAX
instead.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20230904061045.510460-1-pizhenwei@bytedance.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/block/virtio_blk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c87c6a4eb3b3..c048eeaf56dc 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -706,6 +706,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	u32 v, blk_size, max_size, sg_elems, opt_io_size;
 	u16 min_io_size;
 	u8 physical_block_exp, alignment_offset;
+	size_t max_dma_size;
 
 	if (!vdev->config->get) {
 		dev_err(&vdev->dev, "%s failure: config access disabled\n",
@@ -810,7 +811,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 	/* No real sector limit. */
 	blk_queue_max_hw_sectors(q, -1U);
 
-	max_size = virtio_max_dma_size(vdev);
+	max_dma_size = virtio_max_dma_size(vdev);
+	max_size = max_dma_size > U32_MAX ? U32_MAX : max_dma_size;
 
 	/* Host can optionally specify maximum segment size and number of
 	 * segments. */
-- 
2.55.0


