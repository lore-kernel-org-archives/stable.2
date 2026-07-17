Received: from e234-52.smtp-out.ap-northeast-1.amazonses.com (e234-52.smtp-out.ap-northeast-1.amazonses.com [23.251.234.52])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D29C3EB107;
	Fri, 17 Jul 2026 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286036; cv=none; b=m0TPomCCIz6clfgt7kZw/aPmshVdfqINeV0Ifbo+6LR0R/0qv6dXHfma4qjy1vTWFGSBt1SIVYtNqUl90dbnVA8GCKj5rnV5nGw0IoSguuqjxfCRZZ5jNH/o6/Swx+GaOwazUC8BRC4Y+kpIN6iD2SpftvLD9HHWFm/IL1Nn9pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286036; c=relaxed/simple;
	bh=Q1FN4qnshm5xeIy75yKaGL9RQWH6W+NxPoppYKpNsKg=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=nEGd8TMCgiHmiL350RDOjtmbpBIuJ8hWYl/hCeGCRqe0zsyfai377Mgebp/KSFsEjrI9hbQT1neHgIYj3gEAcgCvrmPBm5DqXEgXzkzhCRJxn8rrM/BKWDQSHyh43LhSA0RKAPdkQ44o29zWdVDznzSREYrffz4hj4NeFCmkaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clipsneko.cc; spf=pass smtp.mailfrom=send.clipsneko.cc; dkim=pass (1024-bit key) header.d=clipsneko.cc header.i=@clipsneko.cc header.b=T+wrfrQb; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Rmq9WJ+d; arc=none smtp.client-ip=23.251.234.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clipsneko.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.clipsneko.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=clipsneko.cc header.i=@clipsneko.cc header.b="T+wrfrQb";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Rmq9WJ+d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=clipsneko.cc; t=1784286012;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=Q1FN4qnshm5xeIy75yKaGL9RQWH6W+NxPoppYKpNsKg=;
	b=T+wrfrQb5jFNFoJ/y/FNt2E0l6mDiEsfUNvsCxHKkfrxvPST86TOmDANJPMPL03W
	IkEA9GKJ+y1IOV20n8vc5AHkPaUL6XjLJ3NFCXoqRIb6Zahm2Yo+KwLVCfzZAnJWjRh
	PRDrLze8dV+wibMbDWH1rQc62qShwh6JVJm8Blp4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1784286012;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=Q1FN4qnshm5xeIy75yKaGL9RQWH6W+NxPoppYKpNsKg=;
	b=Rmq9WJ+dijdpmG4PdMdlNzw9I86Zr/ZkJHftl+H+exEC4tMZZrqSHSSj3tKrYD0g
	L/s77NJ6S5syBOfngDnmk297hqIt2pJpb/AwcYQxW0NZ/Drf3o91zLFHGQCImard4YP
	mQH3WeK9v9uZwTyZrZmUjMcNg9GaNbqXDfUDOhdg=
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717105748.1194693-1-goliath.zhu@clipsneko.cc>
References: <20260717105748.1194693-1-goliath.zhu@clipsneko.cc>
From: Goliath Zhu <goliath.zhu@clipsneko.cc>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, goliath.zhu@clipsneko.cc, 
	stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: mt76: mt7996: disable RX NAPI on driver removal
Message-ID: <0106019f6fbbe2e1-f7f219fb-cd73-428b-922b-a73849e36569-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 11:00:12 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.T/9jWCDXa31y4gauYStyPOpWTrkJmzALuy1iq6HUX1VjlgPUmzq7ZFI3EvLLZ39jJzv+2I2PP/uhCYcS7tWi4X9gcnDJGZZVVULSu7C54EK8m7rG19VNcAtmWQSUeF+Ydw79jCgmJ2QuxiKzKA17O4fInWrH2kml2UpMwmQGC6+Ow2RWdTIMP19sAecDaYp3:1.ap-northeast-1.tL27A1JIpKR2Y51a8BkHZBekDcSR82jwOhKrSwgRw2U=:AmazonSES
X-SES-Outgoing: 2026.07.17-23.251.234.52

Commit 9dd05df8403b ("net: warn if NAPI instance wasn't shut down")
made the NAPI teardown ordering explicit. An instance must be disabled
first, then netif_napi_del() removes it.

mt7996_unregister_device() leaves=
 the RX NAPI instances enabled and
eventually calls mt76_dma_cleanup(), =
which deletes them. This triggers
the warning in __netif_napi_del_locked() =
during device removal.

Disable every RX NAPI instance owned by mt76 after =
unregistering the
device and before releasing the DMA resources. Skip WED =
RRO queues
because WED owns them and mt76 never registers NAPI for those =
queues.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek =
Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Goliath Zhu <goliath.zhu@clipsneko.cc>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/mediat=
ek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index d6f9aa1ab..73559c60f 100644
--- a/drivers/net/wireless/mediatek/mt76/=
mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1797,6 +1797,8 @@ error:
=20
 void mt7996_unregister_device(struct =
mt7996_dev *dev)
 {
+	int i;
+
 	cancel_work_sync(&dev->dump_work);
 	cancel_work_sync(&dev->wed_rro.work);
 	mt7996_unregister_phy(mt7996_phy3=
(dev));
@@ -1804,6 +1806,15 @@ void mt7996_unregister_device(struct =
mt7996_dev *dev)
 	mt7996_unregister_thermal(&dev->phy);
 	mt7996_coredump_unregister(dev);
 	mt76_unregister_device(&dev->mt76);
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		struct mt76_queue *q =3D =
&dev->mt76.q_rx[i];
+
+		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+		    mt76_queue_is_wed_rro(q))
+			continue;
+
+		napi_disable(&dev->mt76=
.napi[i]);
+	}
 	mt7996_wed_rro_free(dev);
 	mt7996_mcu_exit(dev);
 	mt7996_tx_token_put(dev);
--=20
2.55.0

