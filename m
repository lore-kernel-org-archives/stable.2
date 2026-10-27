Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092566;
	b=wLxNNO44rESRTAw17B1Z5KsOFJQi0br0dje0L2FIyj9KX5mcByyNN0kJdzdcUGImTucF
	 14+LyW/QFRKo0RNIcCYSRRA3HySJK6A+bKI31MnoDcAjoxa2o8Is++DNAmFQk26J+jUEb
	 K6iJ6L1yRjhmu32oBb19jHlFtzTyLbNkJgs7Ddn2jiyCab0OxF6z+BKcl246a0R69XYox
	 P8CIwYCUWMX4St/di6kOvS8LhQLAFvo6edMf18tq7qyYl9KPEd7wfkr4c0oipvIKmoif4
	 hAkjTacNFRrszphNnezeGN0YsD0AbWPMuyPYsvXghLAMHK82/tH2GDZ+LipGQcXb4Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uvIjmI+HRIAkGOyGjy/GnDVEBAcECg6oog9cRdexHmk=;
	b=1fipdBfIuXinzWv9YjSpFZApFs+RYJU4FJRrR52uPWJeKx9aOGPWgv6/mgQ8Gdhqsu7o
	 vIlbysGo6Lu8KkofuOnj492rejD7ijUt3QmoOA+6sipSO0Hoinau0CGSt4q6WTDxoywC4
	 XtYALCO2N7OOQzcq0gJ234c9XGCcjSBrbOyBZjVpo+TzygoQMe7mBMIhicyTk0L7RY7U1
	 uAgvNlskBYBschrfmJNYaN7mwNS95Kx448wJE4w1e52JpTbkJMlCQIIbt1n0okZrGvOTE
	 Iu6MnnrLCIu5Ys9gGJ0rRQSbuRVygZk5G307f1bxttXL/wE3IxwDFPSd5blfQ2oldgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tAkgNglS;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7C606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BF7C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tAkgNglS
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35c76e9614aso6134072eec.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793092565; x=1793697365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uvIjmI+HRIAkGOyGjy/GnDVEBAcECg6oog9cRdexHmk=;
        b=tAkgNglSz/+ybvpncEJVs1gO7yn9HYgmP0XNkHiEkJjFhVm+DYSgT9C6sAEWqkXtZt
         fZJgBvZWCrX5u7ND/7BAaa4Cu2+0hPN69tRHVe5s3KwCH1ljo+hSUggL5+FZBqnBDX38
         MvX1WQSghE6OYXMzbf/KlQJIHTr3Bv2/+L2Dw+yLTvAKAvVCIfg/MzFr/nFUncneMkN7
         jl5AS4hAnA9XyUMqBBEXHTXMcu2ubQjGjFe4ynLum6ibXiddWJAqNF5CAJ7Km1WGka3z
         Lll80hKtKAH+2rACEGl+3JEijyvX2JCYPvKOfmIwfGjTw1uVfsoy/zaGF6dDyyzclypo
         VMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793092565; x=1793697365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uvIjmI+HRIAkGOyGjy/GnDVEBAcECg6oog9cRdexHmk=;
        b=WMbKyoxeAsW9JNE7f1iPu6qsPlax28YauwU07hiBmXCT6pVYzXo42bwKTeqmasKhcC
         wDAyy5QXCHmxAGmWSGcvtYF5jsDVU/dWu1MUfC2mYrRY7agkUI7xjEHggNL0+jpLG1Fk
         /vV1NGZsOobl3zbbvpAtKXs/DvNakW7tL7ZNUL73xp8iEgJGk1UKK448TxMJLmOT5uJb
         Bx87L96yMROBnK2dsBd0430fPNLStujLLImT3dPHcl0s+qxerARgDz2Ju+SEstIrMiYg
         46ESTsmnbv9T0ZTcGys5sves0WNvI+0zX/Ed1GSnQFYJ5DKfnufTly3adsF4x7B6ySFh
         Gbfg==
X-Forwarded-Encrypted: i=1; AKwUvBxjgqNmd78FGHqLDy9tQKy5NbbrSDY4oa+cZ0lWgojlCBcT06q0rmO9vGpdT1lWtVHkBgRrhcE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWXWOJ31+GKDH2T+tkME3fxEGpxNoe/P5W85zTViEm+fzjoevV
	ufVzX+rdRL0VNziqTNAW3soz8RnxfXEI/icoaHcPZAAt/LsMSCUoMMmcmLQ2MaWu3Mw=
X-Gm-Gg: AYBFou1snqQKowV44iTO7ngEZXOeMHXXQIn/jlnbgOeupEVxh2/mmHW59g7nwl/4m/A
	gHmBIBVXVaN5mWQc3mjQbNIYUpESgwO0dpN1rF38NW8V9lLQ5ls5400xgiRUXW5IDPUdRnirlgM
	mf+q3toveEeYjRsceGYASpLaczzbm4Ls1jnzT01QmeHuGYDsD0atQJ4Il02+JSpQzAmhZHF0Hbf
	8DkRGVFWaFLLtkxbRxEUJM8plq2G515zV+lyZt+OqN4uFDv1vvt9Ya4Umu95Zs8RruBNKsGWm99
	NF/JHq+KPlYZybce2ysaEdmIQblxeg3RbpOsZwmKRemwFBiqrn71eS6IeGdIPV38kUu/OnrGjrD
	FK7c2fIEblRKOdRgU4xjQZZhtZSSzZSJRzNzmvTFLOJ5oepua93kA/yFWzetrzcuRYCeDGylVwM
	lyZrtMa0BGSlKtmwz326mW97m+PNXOBovewHtYlOn3uGczUuz8HuSKz+k3y1PeZbri62Z3ldZW8
	TVBiodAUtxmZ7udz1OMXXm5WSpIxGO8CO1sRX0KMS0SP5Fo/ZmNGy52uTIpZZ+EJIZsQ/9LkKQQ
	YAiGYITn4Q==
X-Received: by 2002:a05:7301:fc10:b0:36a:1008:5815 with SMTP id 5a478bee46e88-36a10085e66mr2611715eec.5.1793092565123;
        Tue, 27 Oct 2026 02:16:05 -0700 (PDT)
Received: from Zoro.lan ([2409:4090:2022:b00e:72eb:d31b:8aa6:1b54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ee71f5sm41232082eec.28.2026.10.27.02.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:16:04 -0700 (PDT)
From: Vishal Satle <vishalsatleit24@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Daniel Golle <daniel@makrotopia.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vishal Satle <vishalsatleit24@gmail.com>
Subject: [PATCH] mtd: ubi: nvmem: Fix device_node leak in ubi_nvmem_add()
Date: Tue, 27 Oct 2026 14:45:07 +0530
Message-ID: <20261027091507.130294-1-vishalsatleit24@gmail.com>
X-Mailer: git-send-email 2.53.0
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

ubi_nvmem_add() calls of_get_child_by_name() to verify that the UBI
volume device node contains an "nvmem-layout" subnode.
of_get_child_by_name() returns a pointer to the child device_node
with its reference count incremented.

Because the returned pointer was only evaluated as a boolean condition
and not retained or put, the reference count of the "nvmem-layout" node
was leaked whenever an NVMEM-enabled UBI volume was registered.

Assign the child node to a local variable and release it with
of_node_put() once existence has been validated.

Fixes: 34a5d8525b6a ("mtd: ubi: add NVMEM support")
Cc: stable@vger.kernel.org
Signed-off-by: Vishal Satle <vishalsatleit24@gmail.com>
---
 drivers/mtd/ubi/nvmem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/nvmem.c b/drivers/mtd/ubi/nvmem.c
index 2dade9727..15737d511 100644
--- a/drivers/mtd/ubi/nvmem.c
+++ b/drivers/mtd/ubi/nvmem.c
@@ -61,6 +61,7 @@ static int ubi_nvmem_reg_read(void *priv, unsigned int from,
 static int ubi_nvmem_add(struct ubi_volume_info *vi)
 {
 	struct device_node *np = dev_of_node(vi->dev);
+	struct device_node *layout;
 	struct nvmem_config config = {};
 	struct ubi_nvmem *unv;
 	int ret;
@@ -68,9 +69,12 @@ static int ubi_nvmem_add(struct ubi_volume_info *vi)
 	if (!np)
 		return 0;
 
-	if (!of_get_child_by_name(np, "nvmem-layout"))
+	layout = of_get_child_by_name(np, "nvmem-layout");
+	if (!layout)
 		return 0;
 
+	of_node_put(layout);
+
 	if (WARN_ON_ONCE(vi->usable_leb_size <= 0) ||
 	    WARN_ON_ONCE(vi->size <= 0))
 		return -EINVAL;
-- 
2.51.0

