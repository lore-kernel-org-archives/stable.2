Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792744198;
	b=I8s1Qr48tZobQpbDreCFbku4QDUhZ5I+bTxgmHc+TgkSFo7PWD+DzLdVnTS7TRzpeSFW
	 fpjvPG1Vbvh+lNFTOIFH5yCiHLcrIHYgFsWMVb9NiOWJPZE1z/zOp87RgdoEXTL1hpnjM
	 VDFNgRF0UIUYiDyGvKdh5oddhY7sHBSG1rwrHar0brV/26YrFh6P7bKjMFO9ZCTbAqA0O
	 rnmow5qax5+yicmU7e9JkYddSLvsWzWyiF8yc2jyIvOf+X4Dup/bMXO90+SBxye1bCvS0
	 /8BBJOQh4wEMkDUUqQsFUu9Xyy8jt8xoicF0lgl4R5e5LgUWGZSR+f1I5TEa174qUNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792744198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VjvPviRplzIhgWM/q2jdDcLxkxdDLClBt75UUKoUPKE=;
	b=Otdf2BAmZlCO5FMzplsuVGPf35JCrn9CKHiODpeDXLpUrU06yKlp8z+UftTF0i+m9wW+
	 IOiCWGTy0YyeSWHULXVCa67/u+KGe2SM3+6nfFB1xyOgpfbNJHioTpofRMmSWfqVmCtFD
	 5FSSnlHbRbJqr8YnfBlu67dEh4RsD2LVgcFT/p0WTpAz1VSlRA58OXY5wLobUv4G8aSXB
	 thfE8obAVCznLx2F0WvBq9saohrxSj5XpFGllMgnPKKyOAs9bmo2yo9Y3tUziY2LFlxEF
	 baHe1nrolI2tr6NY7Zkq4fcc5hw9OpNVg0tr66Bv4aNInqzKmd5bSfllwgD3Jw0vOsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IJiBVQfh;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3D606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82A3D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IJiBVQfh
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-35eaf84cc66so553999eec.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 01:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792744198; x=1793348998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VjvPviRplzIhgWM/q2jdDcLxkxdDLClBt75UUKoUPKE=;
        b=IJiBVQfh33WgHPia3uVLnfpZvdwF6EZecy2uYH3jBNFdjsrFYFedic8cZchvyjTmn+
         b5WkwLUEVYlfkVYilk6xpX2kmct3p55Rh9HFVmtX7YJFQK27TqObmvPwir42YPRveSTf
         ci7OOLzI4ZR+fz53GxDwbyIpId0XVumGlM4bIcteU4oosxyhK5qBZxE3Fnu4p9TqPl2R
         2MJMhhX4wMXjURHwVhbeMHplbpB7y/XpEUNdlrxzkJlA/rgd6i9lqK4e0w/FKPpr1leR
         hNtFtq7mAAQS3qSmqjcxDma23llwdIBdgG5KwA1AGSZqQLRg9GV/FFopvveTLpR+UbE5
         T4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792744198; x=1793348998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VjvPviRplzIhgWM/q2jdDcLxkxdDLClBt75UUKoUPKE=;
        b=Td54i8ewxXCVlWEi9u8NbZ2CnQUoJbIA5blWe7SMMYTlDz2TgDyMFQqusIaCFYrHd8
         pDxgWgfGuTaGZt0orkRaS5yXrGO/aYqXFfIGZ84i8+Xe+9VfqXIRDAabk204EzS1A4Qs
         WZ4QJfAngGrlJhUOI+GT8WhyWg4Nn2/NNmehdnzG9zaySqmhL2PN+9h3WbZHFRxz+EEK
         gPtOkeS3vQxaTGHrSQOqZYfrrbqZCEyVst4yhejzNkAHOorinRxybgXIRCAV41yigK28
         HJI+3b5CEAs3/txovTvMuzthTga7QYnKuq/WZPkZyXdZMYEkmcybqFMcvlNmv7zOBNBl
         lsGA==
X-Forwarded-Encrypted: i=1; AKwUvBxQ3uvJ/0PiM5AGUhKDXpiaR/ducHUCmhtT1O+ziC2o2PVhx8rFqUtjCthtCQL2tMqch4uXD48=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAbptLHA36J4tE76EAX6g5HeMybmkXhvmzBcRmBVL9SAAbsRW7
	4HE/02dyQVb58gsfKWRMeTjpHk+a546uQncqR6UjuIePh37QdjKq2LBuhFdXYLsQbAA=
X-Gm-Gg: AYBFou2ubGVZQuhjSITbEtxK772+SPkznjefgew7qubMTS2kPej0qoVmqU6Pf7wWRAj
	P/JwExFKpxYkPIhHaO0IlaszlkNN/lWvjtJbEfMSByl6aVi8S6UMpegp1pJnBljchPq1Oj8fD5r
	PdwPWs3wqS1fDRp97NYrdkA0+a4WazmdEP7eAozdKJ5AEns3BllS2mlEFM+rgrDlFTTF743t/1f
	3fj+oP2ibtT5ve+ofIzviQsTS5zYVlB/dkROFTuLFy9MVEbMN29bSIkzPm4i5Nijb3g7dSNieBq
	xijUzcnmqjRLOjXKiytiADzKJiC6sRg+APNkHCG8uj7LDXWYOIfoWxjG4BaOKcd8AcQ58S+++no
	mU5qsVv8YNn3hW+mDeYtzTlDvz4eUmuTTsBKKjtfuIhHHB1kt+DX8ElS7TxfVK6rbnatbZUmRcu
	4Sko6gnts8IfX6+J+FOTqxkmUjFMfT/Fhsqj3tKCmIuRl27tERqJ5Sj8E0cifGKqK03G1hsN8Xo
	yQbk9YtcK9WV0gekAhjtc3GTtKDnhfQcJ22nVVZ0y7t6gScVx773r0=
X-Received: by 2002:a05:7300:a225:b0:351:6b27:d67d with SMTP id 5a478bee46e88-369d9802e3amr1997730eec.30.1792744197389;
        Fri, 23 Oct 2026 01:29:57 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9a72ff2sm4847349eec.0.2026.10.23.01.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:29:56 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Kevin Hilman <khilman@baylibre.com>,
	Roger Lu <roger.lu@mediatek.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Coia Prant <coiaprant@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] soc: mediatek: SVS: fix device reference leak in svs_add_device_link()
Date: Fri, 23 Oct 2026 16:29:48 +0800
Message-ID: <20261023082948.1854252-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
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

svs_add_device_link() calls svs_get_subsys_device(), which returns a
device with a reference taken by of_find_device_by_node(). If either of
the subsequent checks fails, the function returns an error pointer
without dropping that reference, and the caller only checks IS_ERR() and
bails out, so the reference is leaked on every -EPROBE_DEFER.

Both error paths can be hit in practice: device_link_add() returns NULL
when the link would create a reverse dependency or on allocation
failure, and the supplier status check fails whenever the supplier has
not bound yet.

Drop the reference before returning on both paths.

While at it, note that the return value of device_link_add() is only
used to detect failure. Managed links are owned by the driver core, so
the driver must not keep or dereference the struct device_link pointer
to inspect the supplier state; read dev->links.status directly instead.

Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
Cc: stable@vger.kernel.org
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/soc/mediatek/mtk-svs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 99edecb204f25..fecb09b9185c2 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2145,21 +2145,21 @@ static struct device *svs_add_device_link(struct svs_platform *svsp,
 					  const char *node_name)
 {
 	struct device *dev;
-	struct device_link *sup_link;
 
 	dev = svs_get_subsys_device(svsp, node_name);
 	if (IS_ERR(dev))
 		return dev;
 
-	sup_link = device_link_add(svsp->dev, dev,
-				   DL_FLAG_AUTOREMOVE_CONSUMER);
-	if (!sup_link) {
-		dev_err(svsp->dev, "sup_link is NULL\n");
+	if (!device_link_add(svsp->dev, dev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
+		dev_err(svsp->dev, "device_link_add returns NULL\n");
+		put_device(dev);
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (sup_link->supplier->links.status != DL_DEV_DRIVER_BOUND)
+	if (READ_ONCE(dev->links.status) != DL_DEV_DRIVER_BOUND) {
+		put_device(dev);
 		return ERR_PTR(-EPROBE_DEFER);
+	}
 
 	return dev;
 }
-- 
2.47.3

