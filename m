Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094280;
	b=YznCwaAiJI83tx54iVXBTl0QQzLu7cqnDsKIouBIPX8O1x0uNw91pr/e+pV0oKHssh7D
	 /kUZArPR+WklHhCQo5uwWo+0kKvHx8pQoGCbE0Z7Fi40S0yh2bN6kTHWahwcHHhRW6VH+
	 KMDG0KQNkBJOCTXethu7OxVTkC3LtUnCkDy3/LrKHCuv47HHNWrdpe79qiVxR8ho8qyZE
	 a+9JfwiDbdYrR6lhEiG5s/8AZhrzYW5ylPjGUHshfkSOA/Fzm/1zw69h2Qwj54T+SeReL
	 kFDVIuyQOSX4x5vYvsdBJ3udyTMrdSBJjDw3oT8LkkzLYs7z9XbP17ebEn3dtI52F0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6hl/Nai93S8NAs/Tww+fCBXzZpo040uYm7bnamGWTrs=;
	b=Pto7UfsUSVDoao3HqhQYGeki8vNtBWYO19jUbc8cBcoT2CkkMbANnful1wIFJbNwNjDW
	 vAQYDnJzDyJxqEE0OcpDDjJ8s/Vp+Bp+PdN0bK/nowtJdmEbD8DpeSBi1I9MAKFPAshab
	 GwHReFRyThiNLx/WdJYWZEXcWNWHTnIGpvxbhD27l3Ws/Bxybp531YDF5foOYrsQdHPaB
	 bmqgbdeN10QafNZJeXUK2B95YpYvujW7wtghmNO71VST4a6FjcLiLPhgGvAAB8CwYji1J
	 hmyLU7S2a9H+JkzNadNie2sjW1NNRvkcynX0ydGiygVKojsgn10kEfqm5wweifkeD1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T566VoMV;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC43D606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC43D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T566VoMV
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso11450097eec.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793094279; x=1793699079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6hl/Nai93S8NAs/Tww+fCBXzZpo040uYm7bnamGWTrs=;
        b=T566VoMVoI8gPHc3pBnX86446rdqho7Ga58ELgz7gtGP86o8Gqxt9sSR8VUqcybwST
         +7Y2CMSLBZ1YaQzOuVYNJ2ODg0iTOhhk2/U/j9lVblNgM6du7jmTpKemVDs6qrXzRP0q
         eMbHC+bX7ZmhqOZGhdPFx9qJiMWZaQcigFsttzAmlRlvRP74wIDlk5yeEdNAd6ILDbgV
         8x+hmTHkWIbuMBgFEsFHBUyZgQ7OjjxcUrt27px/+rReaxgQQnKjD6nv9h6W8g92ziYF
         Qrq4Tzre1y2Wh4IObTkQJnRbZx2rmUOR+NiIt6FscI55phaHbi9SblZIfB+GPxydaFeU
         k0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793094279; x=1793699079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hl/Nai93S8NAs/Tww+fCBXzZpo040uYm7bnamGWTrs=;
        b=fJPl9XCr0LLsK7FSnJ419JiGTwOJDXMJ5DjA3AjeooSYBGCkTwiyBrxvN2uSr9VL2q
         w/S5OxRzOc4QUL6apkbxpYpAQnxsL621ZjPhTPrb+3NV+6SIwio+QbXFT4QYHufrslXU
         tm40WX9H3h8GJ/LWYIv/UCmi76xQckiK6dplUGBqn6GiF0oeCIOiX4iOTXdtu7NZ/jzd
         X78T1/GCPsFd4DNAdRRwQ+31VoIoQ5QKcbD0kuplH+uCoX95Po8oZBqea2wpgvdQnvnN
         /RtNujjj60IOM4tZYndCY1oLpMBx4PGgnG481trRiMxQ7lR9z8o+wuuLY85XS0sPc0BP
         kOMw==
X-Forwarded-Encrypted: i=1; AKwUvBzdrTT3lrfr2ImAbrhCouNIQlgyLhijKlWkFL+rldaV2mQ49wZ4AOpvjrYTixxxaAVDpLirTNU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJX3yWwahLNdICjcuIUbsYpWcMAdYxpFtHb8c8V0q/CNht36bnv
	+6X3ZdXQIGkco9sygE+0iY27ZY5LduM5Bfm+7DMDDNmT95l+5AvF2C6g
X-Gm-Gg: AYBFou14wypSgfKpxxuL/F0Lklc9AMleB+43qaJFBjoKkkwfdjvFbedQFQNt7+1bQLT
	YkCc1UPBMV2vuTUoLUj2wSsh/qRgDX1AojfHMBdJkxrEsKFDI3fhxC9EnPfZ1id2IEIHlQHRW7h
	hxZRCoK+ceTffNYuQ6FaNY9W41lWcK48k1wqhRDh+Zq0Rs6B8NjcFx/1fxli3146AGBL2/MyNOG
	1UDruexnN0I/ggkXv5TYygtW62gWfMT9euDKZ+es/ocZdKkUWgsDvOxuWEYv1ETk112uYcOW8e8
	8eEHef8szckycfdqE8fsxFEYUBKEj55ZAMJLqh1Lig+asajtNQxwT6dOFKuZ07QGLplEOaM5FL7
	QkS8zhkIcx9/CsgHjDiw5D8dsKKZR0yQBDlaz+cCwxG/CiZmZ1DMrn3yqZlInohEE6AUybHPzyg
	+fhDjgtTU9kqv2abKNre9+i25dV2Hx5/zrTy9BbM8VVe6T9nA7LESHQRRic9x+oQzE2YwzJ7ayx
	5OqoouoHgIrxIy0dAUmUID9m+ck6sSHdbaxVKHGl0zfUXbxEoT6uCdmi4WWYWhWFQQjyhZLjPOs
	fGurprtjQw==
X-Received: by 2002:a05:7301:7d01:b0:366:c497:610c with SMTP id 5a478bee46e88-369e8610133mr12065401eec.33.1793094278730;
        Tue, 27 Oct 2026 02:44:38 -0700 (PDT)
Received: from Zoro.lan ([2409:4090:2022:b00e:72eb:d31b:8aa6:1b54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm60252926eec.23.2026.10.27.02.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:44:38 -0700 (PDT)
From: Vishal Satle <vishalsatleit24@gmail.com>
To: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vishal Satle <vishalsatleit24@gmail.com>
Subject: [PATCH] PCI: mobiveil: Fix device_node leak in ls_g4_pcie_probe()
Date: Tue, 27 Oct 2026 15:14:27 +0530
Message-ID: <20261027094427.143733-1-vishalsatleit24@gmail.com>
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

ls_g4_pcie_probe() calls of_parse_phandle() to verify the presence of
the "msi-parent" device node. of_parse_phandle() increments the reference
count of the returned device_node.

Because the return value was evaluated directly as a boolean condition,
the acquired reference was never released, leaking the MSI controller node
reference count on probe.

Assign the resolved node to a local variable and call of_node_put() once
the existence check is complete.

Cc: stable@vger.kernel.org

Signed-off-by: Vishal Satle <vishalsatleit24@gmail.com>
---
 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
index 4919b27ea..5b1862fe0 100644
--- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
@@ -199,12 +199,15 @@ static int __init ls_g4_pcie_probe(struct platform_device *pdev)
 	struct mobiveil_pcie *mv_pci;
 	struct ls_g4_pcie *pcie;
 	struct device_node *np = dev->of_node;
+	struct device_node *msi_node;
 	int ret;
 
-	if (!of_parse_phandle(np, "msi-parent", 0)) {
+	msi_node = of_parse_phandle(np, "msi-parent", 0);
+	if (!msi_node) {
 		dev_err(dev, "Failed to find msi-parent\n");
 		return -EINVAL;
 	}
+	of_node_put(msi_node);
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
-- 
2.53.0

