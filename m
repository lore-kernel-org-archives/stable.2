Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994672;
	b=j7IiKG8RwNffwa2dmXtU1C2SGgFlo5PFuiqHsZ8nQj+02yF+P5rz89R9c0Am5lU08g8G
	 N4MsR4Rll7zMtK/SYRE2xFt1a6WN6DoHWVxg+UJya0Ki7uVfGkCqqkSi3bLu9iJcnVzEX
	 B05CNJtzFqrAIkbeeRNZfadxgg/8bEvMazvFQU3XX1FVu3CoYmd4krEKRpnqhomPFN8+I
	 45d6idu48BVqRf/5ZqiFXEVYVwV1jd2K+k0iR6tS3jIUcz1TNtMffTN1ec7C9GgARiEF2
	 oD06YffHRqYK5Xy1HS/YtXoMUXkx5IjuNNIA70tVIvjvRrNZeJgRngmRHwtBcQjR5+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A/VDrnF8rEM8ik2qBI8UieOOtJ2qpXz9Tme8jmSivy4=;
	b=MRFNW8w6tytj+Y8PhNJGxGBUquyi6Yb5ZCSscuKloTmvUV3lJXHzCT2tevCCUapDXT9G
	 Ldn0XJ0jJGc4UgasGh/0CmUshvyr+4Kmpe0sYibQxlvhfP9TTvBal19vYitWwSaH9cwwI
	 P/ZnTD14JQ/XqD33O0wuB5kGB5p/hO2iZzZL+BV8hJz6EK/Xm6cVqMSS/pyT7ocEs2JfN
	 DHkMkOjt5ufBsMiQiqxeKzT8wIPb8xn5WO2Pk5UtDGcuXRzJD/DtqNF3tE0QXEz3QgvXb
	 s8eAfDqsGGdxf1L8w2K9iEDdNiT6A7V4DRAooxcZFMnqGs7v24as3Wac+SytNW2GXow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sx3up4GN;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BCC606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 09:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42BCC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sx3up4GN
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-372bdb942dbso990868eec.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 01:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794994671; x=1795599471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/VDrnF8rEM8ik2qBI8UieOOtJ2qpXz9Tme8jmSivy4=;
        b=sx3up4GNHY4PV5rpOWK47NqZzOdor01MkE+cmqVk5CeWHjoo9GXylbdQA+Q5hFY17F
         hbtsAlxm7oNEClUH2xh3iFQevvMmES3ILQTPcUCAIxKZSxqr5i5uv0RhmRCz84MQH/Zk
         t9Y063SLDopdZ78m2xHXJmSmd73V339XkkfHqrX6ibsnOYD9ygTxqbYXzSlpar6FKniR
         9m/1y6lV9VfNeGLLVayMyJh7nxtzTcIUuJOxWOYHf8GWfhW4JAkA+VD2kx06uQs8O2a1
         GwZ1hoCqbFRIIwySi3viwLEhjRmMHYwYdJ2PNE3s02PZTTuz3juyL3ZtHLsj6qawoNWE
         +BYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794994671; x=1795599471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A/VDrnF8rEM8ik2qBI8UieOOtJ2qpXz9Tme8jmSivy4=;
        b=gcHavvcu9vcIx4oX1jp+wOV0EnIKnsPtpPL4IBhWVtm1P3mFGPaA18KJeDUkOhjJqi
         rN8AygyR7tyWGxLTw8EjIfRvwrCkp10SNP3N3l033lQFRlZ5GInOWZD/uwQeZwjYJw8C
         2WKuegZEAMset6awGbsMvyU9d6BEFnQBT7W1pdYLQ7eeBTEaR5L4VVC9OmOgI1+pcISg
         snCMMd9sPSCdNAG6bwY3Tzocf3mjjptfHOEqtIA0z6kBgTvCUJSEGHHqBWPvRrBUt68T
         un3SI93ZKmmxiUH+76rP0gDnCjXeaTINQD/W34cNRx70Dr1z8MsCRPXzdo9/wSoO9BEL
         aGnw==
X-Forwarded-Encrypted: i=1; AL+hErHvnYPHPeOwuPkubHYwHoEK5Z5eTECyz1UBK+xhRSi2yG5qoCut9YjBffSypcYuBYeXUNm6As4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+h3aeqKXAptRNm/VjsZheaDd8CHFPwaXG7/30NIEU1ojbRpl0J
	pkbdlYC5AANB4Ep9j2czQyVioJMJPQJbWLW3drvP++q/HQJ0nvhurzGp
X-Gm-Gg: AZFdTZcZ+bvRUWb8oTErLrXTiDSgIhUQ/ilCENjab05BxuOsD9NoCM2BleMCb+lwsDp
	7jVJNOhd2C8lLfd+Yyu9YBVELTbYZjtSKd4qd+az3kIYXPB8BQzg4ZmSdjdfo/sI/hnCX2l8Wnk
	qKlaxTCn/ZciRhMyxbNVPuLf4nZ6FtYGiGTJqAn8VkbhrIBIEqvlK9+K1Jumdm88LkYPCynfUlG
	uXcRGskg6DsNQS4MFpAd3dec6tumaqkC4POlwNgoDB34k4/9h00rOPg0hQQgfEKhru96Ee0tunV
	ElG9PmcYEf2GUkVSSZBEZNRdTVaDTQLu1y0FVwWHZlpDMYVTI7ehPzGY9k6v9IWXjnBjb96M0+/
	Esbfkll2uIUclzwAc0AH+eNCgg1boEgYBkz5elFqj+o7wAKEDsOvXNTBgg44LOBLMufXlbECFWI
	9/Gl2tnkdnntiMhmlfgxPZc4vIWdYkix/OdwazgIAagdZZptc4cQEB2SRB/w26ZUecb8CqHjRHw
	bWOf7214mOl9ukW7jFv5YAgBWSil/13P07YYQmBT48J3/OxbGlp37XHbJwfeJRHHO8ruPElTqHu
	EwGFjO0az4BLzIB2CDCnFsZgEjIZtGZazp0q
X-Received: by 2002:a05:7300:6a90:b0:36c:dbac:705d with SMTP id 5a478bee46e88-382815247a2mr1735354eec.15.1794994671297;
        Wed, 18 Nov 2026 01:37:51 -0800 (PST)
Received: from Zoro.lan ([2409:4090:2022:b216:787d:f4f4:944d:f4ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a76d70fasm6353460eec.22.2026.11.18.01.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:37:50 -0800 (PST)
From: Vishal Satle <vishalsatleit24@gmail.com>
To: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vishal Satle <vishalsatleit24@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] PCI: mobiveil: Drop unnecessary msi-parent check in ls_g4_pcie_probe()
Date: Wed, 18 Nov 2026 15:07:31 +0530
Message-ID: <20261118093731.43980-1-vishalsatleit24@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027094427.143733-1-vishalsatleit24@gmail.com>
References: <20261027094427.143733-1-vishalsatleit24@gmail.com>
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

ls_g4_pcie_probe() calls of_parse_phandle(np, "msi-parent", 0) solely as
a boolean existence check without releasing the returned device_node via
of_node_put(), leaking a reference count on probe.

Instead of keeping the check with of_node_put(), drop the check
altogether. The driver does not use the phandle directly (the irqchip
layer handles it), other PCI controller drivers do not enforce this
check, and without "msi-parent" INTx still works even though MSIs will
not, so probing does not need to fail.

Also remove the now-unused local variable np.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Vishal Satle <vishalsatleit24@gmail.com>
---
Changes in v2:
- Drop the msi-parent check and the now-unused np variable altogether
  instead of adding of_node_put(), as suggested by Manivannan.
- Link to v1: https://lore.kernel.org/all/20261027094427.143733-1-vishalsatleit24@gmail.com/

 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
index 4919b27ea..f31be6327 100644
--- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
@@ -198,14 +198,8 @@ static int __init ls_g4_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct mobiveil_pcie *mv_pci;
 	struct ls_g4_pcie *pcie;
-	struct device_node *np = dev->of_node;
 	int ret;
 
-	if (!of_parse_phandle(np, "msi-parent", 0)) {
-		dev_err(dev, "Failed to find msi-parent\n");
-		return -EINVAL;
-	}
-
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
 		return -ENOMEM;
-- 
2.53.0

