Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580264;
	b=BceEfluTwYOkFuJVeV0/bFhvflwEYKdQ4azo2qHAHgRQtI+aYsw6L4lztDFtAjT3NPT5
	 NU1drXBinRPRCqjxK+N9d6of6+1+122yiFG7sblFA6t9O14IEAa2E91x3FHtM2hJpeiFL
	 CbPG9Qk8kMwc0NTre9NKAN4l7Cnm4pV70eOZ9tUQ6Nw9UrBS4UjKNfv+916TP41QlowKB
	 h668woTLaXBbL9wK2oIR8VodZzTaFEz5kVgewDk8u9wLk1X3tHw7IJOtSaL2eDhRkUJc9
	 BsQrTzzpRmVHNnHmdLdL3HO/DTlDFMQcmUPWJkXLl9iiDUDrLRpN1MjwbbEYOnd+dqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580264;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=fRs+dp/44SrGLjjHHguutQnMLuK82bJeTnuJmmdtx2c=;
	b=GwFfRBql52MpZKmCXA3WCce93vBoAOcDHwofnEabu0gswogbvbk9nWfL8WLXUlunqIOz
	 NZ//v1GfBwUYwmDhRGjO9x+PsXK7AZn7KwE+MxPN05wrJaddfysaT5mHBeN/h3EVOq+OU
	 Ny3pxIW5XAHuZrNapP6lv3Ap6AdY3wwbLbJViDBeS3o57V1Nf2Wy096fshG3gepOgck2K
	 KlRhA0cPxd1X/aw50iIbhWKzbZiJonHsTNImqNLFr7KVBpJUokbGfs6h+A1t5pnrXmtk9
	 F/hKzN04sR+MXoPsE0UQQG12bmssNjgHI37hjXpzkN/ltAxoxnjLEshnDofDCw03dnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="XKD10/jR";
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104EA606A31B;
	Wed, 21 Oct 2026 10:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 104EA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XKD10/jR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fR
	s+dp/44SrGLjjHHguutQnMLuK82bJeTnuJmmdtx2c=; b=XKD10/jRABazCNIMJs
	S7jMwCvVY8O3GY9nkIODN4njwP090Xl++9xjweyAXRYhInYOZhhQxFhJOUidHdlj
	9ZqjveXIuqUQb/rJeiPg92QjY+i5eXUSicfAeF15EQazQ+CtMj0jLnza4U8Lc6hI
	jt86mWQRGG/Aww/aZwHLHRjvA=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_1CJmthquYHTBg--.25487S3;
	Wed, 21 Oct 2026 18:57:18 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	MeiChia Chiu <meichia.chiu@mediatek.com>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Bo Jiao <Bo.Jiao@mediatek.com>,
	Howard Hsu <howard-yh.hsu@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 1/2] wifi: mt76: mt7996: clamp VHT/HE beamforming NSS
Date: Wed, 21 Oct 2026 18:57:11 +0800
Message-Id: <20261021105712.4124467-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021105712.4124467-1-yaojiale02@163.com>
References: <20261021105712.4124467-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3_1CJmthquYHTBg--.25487S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1kAw1UXryxuF4Utw43ZFb_yoWfKFXE9F
	navFnaqFW8Kr10kr42ya9xurySyay8XrykG3y5t3ySga17A3y7urySvFyDJrsruF1xZr1U
	GwnxXFyjkayagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbOzV5UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7w6a1GrYmo5BKQAA3h

A peer can advertise a VHT or HE MCS map with no supported
spatial streams.  In that case mt7996_mcu_get_sta_nss() decrements
zero and produces 255 for the beamforming configuration.

Return zero when the MCS map has no supported streams.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index cd7587ce5b8a..e6243dd33c31 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -120,7 +120,7 @@ mt7996_mcu_get_sta_nss(u16 mcs_map)
 			break;
 	}
 
-	return nss - 1;
+	return nss ? nss - 1 : 0;
 }
 
 static void
-- 
2.34.1

