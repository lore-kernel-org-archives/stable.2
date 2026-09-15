Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F193CF047
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437855; cv=none; b=McZPsMbAKJy61Ss3xGRfNFFjvreyZxsMbVnWZWsuW5gRUaNUyd4NhZ9pqmG3nMd3DACQDJe6YYQaLnEuEfwcJOzpotFK+p8KdUXb719uPEwGHg54Rn6uae4UIPel70hAB95BI6jBa3TFYscfwraucsSHo6BL7nBC+zmdzcc0QDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437855; c=relaxed/simple;
	bh=Fcw039KrkxGKVWLTft+Guz2bGKn9Me6A8sWpvgD3JoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g65IkAPKchZZ1sclV3S7LdS/P2QbCvnpjiBT/lv3LpP7bWjbyO8bq38vcIAhDyEgVzHjuZiNgb3ZTeWx+3q5z9O7+HTNu1kAxzkkfAkmROoccSPB3Zd144zMopFLyPuUupQFGt0Ypg0ZerWoEqmxfbd4uAHYI3yYWftMBc4Jp14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbV6Edkq; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbV6Edkq"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91235f46716so1918496d6.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 19:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437852; x=1790042652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ijUVaQx/mDvllGL84fcjqcGETQyV2GszfE4nAG9CvaQ=;
        b=IbV6EdkqNp5fIWiooxErWZ5J7EFm08JEAa8ZUHbRnc13BSn0RFuCe7qMosqgLMWvEw
         hjuoczMMEa2t4J9779kWQwALKbCfDagTNj/yrAJhnDZ5eFtgSzVpfOzIs/Q2L4olrszm
         BuFGLnp0JHtqrEhbc8Cs0eHxNzNdyq5VQsG//pG/QfJDb8cpxTX3sBvMgc1XAVym2P/2
         ArD4rY4uwBAGmNUkcubP/7XSmnwH3kvP5R1sK90Q9Z4IltImxKB8HZdgpOkmv05coH/i
         OrNxScgBMf7PdSzoJPx2p45Ib8FYg6KZZ222Jmp7sd+DQnJS/G2nCS1B8WncooI4wOAM
         1Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437852; x=1790042652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ijUVaQx/mDvllGL84fcjqcGETQyV2GszfE4nAG9CvaQ=;
        b=kigPwP25X/bB0oznkeVkmmRjbpd+VUYMHs/s8hcLVjnxKDQe7NrLsCHwh/PVHFE8xX
         WKsO3Cl5OjrI5AnGjiPzYzriaUV+czTxsMEMThR2BRxOjxAM8aoebsBiX0WUIqD5yKgF
         ntz4Xk/3Z3BEHQv4wRp4/FlM5YL6cIEINaedQY/CWGJFupUpAszFQcvHjC5XdzCczN7i
         b+WPxbiDkz6q75EnStSoXvdJjOEzxIKXbR3rY0mks9Js/U2oN4N1bxc/A3TQ7k6/ESHG
         McDRG6TAnffLYP1kgJiKGBKXnOgnyfwavs9pmBse35X4Q8zsFDVjJcb+eh+ZzNEU1xZw
         gHWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwoMYSVK5xY8rBTwC16vWvWAyEsy+VkgF4Fdcqy6qm/GhM+g08fxqN5TiRp+bxqafXxxLVqnxs=@vger.kernel.org
X-Gm-Message-State: AFuF++ljzCev4TIFOHpEt6s3GdptveKbUEoEpERyfi7lUdIg+LHvn2ZN
	4YppSMlVwbw0hG6+RBia3K32MeK++sb14sgGCMYw3Bhqw4sCHYPhVKs=
X-Gm-Gg: AYBFou0E0OSlV+9zFVJAy14QihNdySpbHak8d5QgoKv9tv0RxAOkZ1YT9pDwwUVQGAS
	5tGhbcGa822Py8yOwtSwPEdOr6UvsnO+oG7+dCAq+2drwneTi5iee5r5Pu3/pYoN3sRk8A3hvhL
	HKaSsQfylt+YE1MsTeoJgYawV+2Q8BXBEUk7dYYJgbkHUImBnDI8AXXCLhNBQuU2Xvxcz8f47fi
	rxKvC9PaQHLQ+2VrcxOe2YWjIldY1Tgza2+x25wnI2wzknTJijI/yHkZaiJp9LJ2tAcD5SzjH5h
	dkNZHFc0BMHFu7+UXGefYx5G2WgaCZNBmhd79TAv0UJ+wJ1g7dI7JSx6S/Sci3ECRKXkaUIB8KB
	454iEiNHJ0uako6oSrB9V+TaAnZKuSjUv2A8EqrD+vYR+TznxZOSfeG8cXlz0RvGzfIQeyCXCfA
	qrBXq3eaNsmPlzDzR3pYBbw9BNpLc7Bjj8N0d9y6jC8zWkoGgDJ/kV0YplM9RfW7CNaRHP1Yzhe
	Ko6jeSJpZFwlO2StYlv9ccoDHSZadgCG+/6WdolSKCDaRcPsDibr1SXXrMP9xVhWdqwaqXwJLZc
	t0ZW/I3co9hN2GkW3g1U6JIeTivUR3qO9OJ//aTxjf/OubTOIbQslu+zo9yRmhXWv+qn3g==
X-Received: by 2002:a05:620a:4888:b0:939:d762:e2d8 with SMTP id af79cd13be357-93a299943efmr847619485a.31.1789437848647;
        Mon, 14 Sep 2026 19:04:08 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f18628sm1138775685a.13.2026.09.14.19.04.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 19:04:06 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: tulip: dmfe: Disable PCI device on removal
Date: Mon, 14 Sep 2026 22:03:59 -0400
Message-ID: <20260915020359.89842-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dmfe_init_one() enables the PCI device and balances that reference on
probe failures, but dmfe_remove_one() leaves the device enabled.
Disable it after unregistering the network device and releasing the
driver's mappings, DMA buffers and PCI regions.

This issue is already present in the initial Git import; its pre-Git
introduction is unknown.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/dec/tulip/dmfe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/dec/tulip/dmfe.c b/drivers/net/ethernet/dec/tulip/dmfe.c
index dabc091..dcf6848 100644
--- a/drivers/net/ethernet/dec/tulip/dmfe.c
+++ b/drivers/net/ethernet/dec/tulip/dmfe.c
@@ -528,6 +528,7 @@ static void dmfe_remove_one(struct pci_dev *pdev)
 				  TX_BUF_ALLOC * TX_DESC_CNT + 4,
 				  db->buf_pool_ptr, db->buf_pool_dma_ptr);
 		pci_release_regions(pdev);
+		pci_disable_device(pdev);
 		free_netdev(dev);	/* free board information */
 	}
 
