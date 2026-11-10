Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325267;
	b=SvOB5iug/HvCVkO7TzX+KfOeYH8Y16jv3sVxKiqhrhbdotKxb+LST9GGiOTrYGLbNNA1
	 IAOq+Cya6RAIURtKu/SKHLf+CvVS+VVtlBbxek7DUH8jcbFwTabc4hUlMRYd38wSRqy42
	 f6QEO2kUqxGBEb5k6EqDlknlCvOIEVSXizPIvcOtl8zAcyd5H6z6Au2jUpBK+X8NomnlX
	 1/nst4mGlJ9u1ogBPF4xADvLRht7k04Ch1zvSuzyVqsbK+HaB2/OjpFRB8LdWcPYPNQff
	 XBiodhiYcWDKiEdXv6sp9wmLVpDzEnEVaJ7pARtO2dkAoivr2pR4woKZHGy55XDoV+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325267;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EjfKZeOugtKvcZ4o+J7r2O4lxdMGd3B7QENgcbLtcbU=;
	b=FXqYyhQjqG/m0h9pIfuYDggZm88Z31gEMpFQWzGob/HVCyO1Eg70Bt7gE26ndv8xY8W6
	 HyRwR+lRF00WD5dhk/Bw8ilONb5tcGI59eIpNtQ33snDjNY6d2keXQA+pP+5eeXbpsX82
	 llt23q5LKYWuvEtdcvTQSL6mj5u/a3Tz8MX3Ty+UZQVqPp7kjXiMtof+pnN5Ut3wm7maj
	 UcSlOIziqGY3T8q451Glaish7YeSQjJgpDSN3oH3iUsMqoFBhtaTxbNrFyZ5WagY8zUeF
	 8TLvYvH+BM05CNyU6uDFWJZknLdvq0dHycuceSjPGa1bavujbDDAtIYlWkEzWD1I4mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHojkEUL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03ED60A3816
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHojkEUL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FB11F008A2;
	Tue, 10 Nov 2026 15:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325266;
	bh=EjfKZeOugtKvcZ4o+J7r2O4lxdMGd3B7QENgcbLtcbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHojkEULYD8YnaVDZWFsdKkLv8/xHzYfPersxKwR12NmLUrSkvVKhQwn0jDfomzkH
	 Gc2/IOVmiD0HJMEjkyQCO/HqKc1Qwu6R+13XkcSRX9rQhGk0uO+G2WGqxDnHMoXe52
	 Cv2zl4fxiaTBH7LPVrDqdn4HCsXTV2OaiCL6Divrpp3XVuXqzHSI3WqY/uZuc2FzN8
	 I7KYJd4W/vsg7yrIZJ0VrACbuYCMkWE9ap7wr4l5W1rvUfArwhv3WyYNDMJJn7vJ3F
	 UgsKXYEUxDzt4L3kMD9pCM9keXRXcL8xy/HWgUUc1in80zrUGn+mMCWiUXlv8T/579
	 N9cQu95GqXj7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: mt76: mt7615: restore DBDC state after ext PHY failure
Date: Tue, 10 Nov 2026 10:41:04 -0500
Message-ID: <20261110154039.1991987-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061924-failed-5.10-7907d5270dc5@kernel.org>
References: <20261107061924-failed-5.10-7907d5270dc5@kernel.org>
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

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit 7907d5270dc5c13b6a95754c08a77d5b06bbc786 ]

mt7615_register_ext_phy() limits the primary PHY to DBDC capabilities
before allocating and registering the secondary PHY. If allocation,
EEPROM override, or PHY registration fails, it returns without restoring
the primary PHY capabilities. The EEPROM override failure also leaks the
newly allocated ieee80211_hw.

Route all failures through common labels that free the secondary hardware
when it was allocated and restore the primary PHY capabilities.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 0f2173f093b3 ("mt76: mt7615: add support for registering a second wiphy via debugfs")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260910215441.76683-1-mhun512@gmail.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
[ sashal: adjusted context for older mt76 PHY API signatures and omitted the unavailable EEPROM override error handling ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index e194259c84e90..b579dbf173f1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -398,8 +398,10 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 
 	mt7615_cap_dbdc_enable(dev);
 	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7615_ops);
-	if (!mphy)
-		return -ENOMEM;
+	if (!mphy) {
+		ret = -ENOMEM;
+		goto error;
+	}
 
 	phy = mphy->priv;
 	phy->dev = dev;
@@ -431,7 +433,14 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 
 	ret = mt76_register_phy(mphy);
 	if (ret)
-		ieee80211_free_hw(mphy->hw);
+		goto error_free_hw;
+
+	return 0;
+
+error_free_hw:
+	ieee80211_free_hw(mphy->hw);
+error:
+	mt7615_cap_dbdc_disable(dev);
 
 	return ret;
 }
-- 
2.53.0

