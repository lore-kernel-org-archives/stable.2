Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7426137B01F
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789436399; cv=none; b=iskzavoGc1DIYyg+YIYozviRLuzFiqvVt+ZCnaTFhg1aArGk/dM1eEoL9qzll9doXZ3ATiOqIDecv2MLC36GPBgt9+M7AsbhxbwS+tTW79zgCtEoOydBdZx9XnIIDuxKwQ/I2xidomUwON95SYloJH68rlPA1u7KS4rtU668o0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789436399; c=relaxed/simple;
	bh=vGrgc1V20xnDibYfrrIi8qa8Tu+oEf6Obx12JO0LlVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMaXtMceDCGbC/f9PyD5OHJF6htoIvM57Y4hbY3lK25TMHXxo1wC6kKY8YTCbIa4iwDH8dBT1BL/PbU6b9SEFqdJlf5V08Y4Cl58eV8cuB0jT5auxUCzikI5P1/frscHrjLtvUkXTCVrKFn/7pHheaap0WS6z3ti0GrdGxaz+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwtIoB9u; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwtIoB9u"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0bso35423036d6.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789436397; x=1790041197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jA+Gm6Df8SoCPT+Ci3PSWeT1OW/hMiB/+pCm2kOG6rI=;
        b=NwtIoB9uBCJBStw43FF00dz/JUW8IcbSJkZDvVoj37TxtTAHnCCQjj938SAgjT9z4Z
         7HEKgUy7qeh+K6qUGSNqi3sfjTQien7T2sm/cVYNu5fI11NYgiSpGCjcfB0Oe4NNGEmi
         ok9s5EGBps2fliKtRo0bcB1Mc3PMY7bzh0AkJGtT5mjpK5MvweehQemXzyJuhN5YcKVK
         7TVtV3ucjGm4/ERWdbOJ4/qB/vV7RbkN5LM/27BTn+bFCUnIF4xRsT8KUdpb4wbyvY/s
         hYNDJbwaS8hVyWXf5258gdZ5RfS7QCcU5E4m5ue3simD8y3dk//pmf1sw9ESEIOnPZnR
         2lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789436397; x=1790041197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jA+Gm6Df8SoCPT+Ci3PSWeT1OW/hMiB/+pCm2kOG6rI=;
        b=Fn8hJFq1tx2cu8JNl/dVfyg6bdcvMD0qWI6LeFPAMehbSGCmGXiWQ1Pq0vmEctwsMU
         bTqBaCejkbaIX6UR4wIiEbRxTGk7Amupu6WHBv7yfMCHtq6GEK9yGwbIJnquMLPLT2Te
         i1242bH+tke3cJ5lg2PtXlG2fUj4CjEqJbdeeFXROy+pQxMF9MJCbTXCYb1NpERUcLtV
         hT/fiz6R2ins4NOyBN+ZetljFTSeqCX3t/Pob4lUC44lc5vb+o4KfmfbjA0Fwq0d6xMD
         08bobjmgvnFla/5fd7sF+xIHQ05vIkcPScoaOMB4qOKde8yS4zPJFEbI0auwN2pNFpkD
         vuOQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/eshsaTsc4hVuhghha07XTaE4CcO5uOGkcX2drJukN267NP0PqyZ9W2BP8gxXylxhxoWwyIw=@vger.kernel.org
X-Gm-Message-State: AFuF++lBOI5meHVzAkrv6PPkZq5z7JhlIAQFQ36c7rCBEiCgLZWZ5G6e
	kZWrQ03eKoUmoQCT5S4c9wdP1E7PC2vkVthliZCo35J39n6D5KweFzs=
X-Gm-Gg: AYBFou1KodWXY0si22MZ5xvXgaNTTu96bnd69YnfLPvtmfa1LLuGvQ87O194HqMYjAS
	oINBs78mYjMuDu9WQozcL6P7yVCLQfGxBPo0f7wCYc+f9DpyKlolF2wh0GlqNNUMy/ToaMuxIKg
	Ml+wScrNiA2Ei//8PcSy0D1YbeXWSb51e00eSDM4npNQ4phTdxdvlZJ7pWinawtoJDRXJvvZIPx
	1M4c7hqIWFaD3KrH2Lpu6k7GxcwqD3Mp0WLr5WVrQefHVd+MPlgCG+KOtn0JhP9fM8WQZD8qKxs
	7K54FR6kB1zBkMcXKWBpkNrD09ArCSUzyZsg6JAlcoP/CbpXzWkb67Z6gLQRIKXrzJaQbrUSKWB
	cE78bI+9rA/nkadurMrZIfUNqCF7g0alMSLEOEHIPYpRLpnvtYO14o2vmYP7h01Aa8dmo+QcjW7
	H4x9wlDM742cZssb7XcvEWJplP2sWskjKC+RkbREfmsVQCyflvWsWdpC8kvKWXmRhXf6czu9ToZ
	DQJEC8XobVuidQB8g6zdKV1tF1qsRYHt5DmpTAiZfnpfYaG6kx7KGGn9eBmkJod3bvU/XekG5v0
	7k3SA3jbLTiHKpuzMCELFSSSR/dSZ1cIAPlQ4iYX8W2UTvhexsMXv7EBwRA+20gJosG8kQ==
X-Received: by 2002:a05:6214:5f05:b0:910:6339:1888 with SMTP id 6a1803df08f44-9122e4d4ab3mr103911166d6.2.1789436394569;
        Mon, 14 Sep 2026 18:39:54 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4787eesm108637906d6.21.2026.09.14.18.39.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:39:53 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Michael Grzeschik <mgr@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: arcnet: com20020-pci: clean up failed channels
Date: Mon, 14 Sep 2026 21:39:45 -0400
Message-ID: <20260915013946.73963-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After com20020_found() registers a netdev and requests its IRQ, seven
allocation or LED-registration failure paths free the netdev without
unregistering it or freeing the IRQ. The unfinished channel is not yet
on list_dev, so the common remove path cannot clean it up.

Route those failures through unregister_netdev() and free_irq() before
free_arcdev(). Keep failures before successful com20020_found() on the
existing free-only path.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 6b17a597fc2f ("arcnet: restoring support for multiple Sohard Arcnet cards")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/arcnet/com20020-pci.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -243,7 +243,7 @@ static int com20020pci_probe(struct pci_dev *pdev,
 				    GFP_KERNEL);
 		if (!card) {
 			ret = -ENOMEM;
-			goto err_free_arcdev;
+			goto err_unregister_netdev;
 		}
 
 		card->index = i;
@@ -256,14 +256,14 @@ static int com20020pci_probe(struct pci_dev *pdev,
 							dev->dev_id, i);
 			if (!card->tx_led.default_trigger) {
 				ret = -ENOMEM;
-				goto err_free_arcdev;
+				goto err_unregister_netdev;
 			}
 			card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:green:tx:%d-%d",
 							dev->dev_id, i);
 			if (!card->tx_led.name) {
 				ret = -ENOMEM;
-				goto err_free_arcdev;
+				goto err_unregister_netdev;
 			}
 			card->tx_led.dev = &dev->dev;
 			card->recon_led.brightness_set = led_recon_set;
@@ -272,24 +272,24 @@ static int com20020pci_probe(struct pci_dev *pdev,
 							dev->dev_id, i);
 			if (!card->recon_led.default_trigger) {
 				ret = -ENOMEM;
-				goto err_free_arcdev;
+				goto err_unregister_netdev;
 			}
 			card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:red:recon:%d-%d",
 							dev->dev_id, i);
 			if (!card->recon_led.name) {
 				ret = -ENOMEM;
-				goto err_free_arcdev;
+				goto err_unregister_netdev;
 			}
 			card->recon_led.dev = &dev->dev;
 
 			ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);
 			if (ret)
-				goto err_free_arcdev;
+				goto err_unregister_netdev;
 
 			ret = devm_led_classdev_register(&pdev->dev, &card->recon_led);
 			if (ret)
-				goto err_free_arcdev;
+				goto err_unregister_netdev;
 
 			dev_set_drvdata(&dev->dev, card);
 			devm_arcnet_led_init(dev, dev->dev_id, i);
@@ -299,6 +299,9 @@ static int com20020pci_probe(struct pci_dev *pdev,
 		list_add(&card->list, &priv->list_dev);
 		continue;
 
+err_unregister_netdev:
+		unregister_netdev(dev);
+		free_irq(dev->irq, dev);
 err_free_arcdev:
 		free_arcdev(dev);
 		break;
