Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327387;
	b=0OfpR81IPFECslJLwQIFDJM47YdzbFWYpIdwaRTI09bQEIA+Mn+Sl3ZIaJ+mQxJL4GvK
	 NY8RBV+f9tVrsqYnh4zxNTEYuS2hpHaxCszgAPDBB0vO5Wl5C5AZ68bxAa+teBdZGsYdC
	 8hzt0zeHxK6Je4++WjWn9J4PK9ybDKvC0I8mjq52osZvKC8LjVn6HgwM4XfvYrl+5laok
	 IIGoaAcfhDC94grLMlSdrUBL1e3gCTzYwFarJwjE5orSwsl4qq5hlbMaElRsoT0OdYwDl
	 sByVIk19V3dWcG2YAmgqCwlIzAe4ak6jGX3lD6YFyZeNvDj73fsng2DMCmgyvl9qW6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327387;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d+CLizAY8ucmqS84L+EOQnDECftSxV1SZgkG4zZEVzs=;
	b=aC10/VhOMy2xRk+VWLex8PZqqh6txT6poH2dUK9bVLKwqlSKhfZwFNFMXCth3wP3OGMX
	 mmQi1Ti7GSY0Gw+dJj18NovTXV13ZmbhTPPeJK3PfmuxqPR7KG2ILxXeNmeILhv3Vx4xU
	 JO1hO5CO1TFTLbHXW0R/WF2cOcO9S1DskArE9SHgiTORiwYbidOzqOAOYinFBWqm2M5ZC
	 0vbgCo1Xfs5TQIVpn0/W1GjTbPoH6/jDkbawiJz83WH3dMTmDTc2DJmbYtg6PCKx+GVal
	 9kaKUjZCDz+/celpPoQpML9WaylgjMEnbiiVeHYhNI8viUBBRLNXpkJt0uErwOtLd3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YngkATd3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E65606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YngkATd3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7168C1F0089F;
	Tue, 10 Nov 2026 16:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327386;
	bh=d+CLizAY8ucmqS84L+EOQnDECftSxV1SZgkG4zZEVzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YngkATd3ftCcY7iS9eBAHFIjzA4pp9276NrpVd1HJrnT+SUdX5ityD4ocxACU7ZsC
	 1h4ZYWS/yM4/QIDkTa/QJwSxV5/6ErpqK853x7My3DSuEEK3UjX0DCiFDKBqmiB8tb
	 dhfPf1JCL8rwZpvQBGBQcGysmFvGyqEmwXsmVl7OBeYY7rA9vxP4PSoua5f78bR/u6
	 kX3d8/uz+e+DU9uRQ4DEhwnAXSDU+0UViJ0Eyc+VLP9v+L8oUeBI/Hp+dwbpPio6GJ
	 OkP1a8mlXkpPXJxsUSqRuQYP6TZl4NQ7F5wMh8GRGY26zMtE3QKu6Sl3cMVyF2pKyI
	 KIDN/H40gBQLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	patches@opensource.cirrus.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ALSA: hda: cs35l41: Use auto-cleanup for put_device()
Date: Tue, 10 Nov 2026 11:16:22 -0500
Message-ID: <20261110161612.2453887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052118-failed-6.12-8d70e364e866@kernel.org>
References: <20261107052118-failed-6.12-8d70e364e866@kernel.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit c437a83cc69645edab8e0bfc450a3b706abe759e ]

A temporary refcount management of a struct device can be done
gracefully with __clean(put_device) for avoiding potential leaks.

No functional change but just a code cleanup.

Cc: patches@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260803140100.919071-3-tiwai@suse.de
Stable-dep-of: 8d70e364e866 ("ALSA: hda: cs35l41: Fix ACPI device reference leak on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 031978a62cb99..d01691c13bf33 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1895,7 +1895,6 @@ int cs35l41_hda_parse_acpi(struct cs35l41_hda *cs35l41, struct device *physdev,
 static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, int id)
 {
 	struct acpi_device *adev;
-	struct device *physdev;
 	struct spi_device *spi;
 	const char *sub;
 	int ret;
@@ -1907,7 +1906,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	}
 
 	cs35l41->dacpi = adev;
-	physdev = get_device(acpi_get_first_physical_node(adev));
+	struct device *physdev __free(put_device) =
+		get_device(acpi_get_first_physical_node(adev));
 	if (!physdev) {
 		acpi_dev_put(adev);
 		return -ENODEV;
@@ -1925,13 +1925,9 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	}
 
 	ret = cs35l41_hda_parse_acpi(cs35l41, physdev, id);
-	if (ret) {
-		put_device(physdev);
+	if (ret)
 		return ret;
-	}
 out:
-	put_device(physdev);
-
 	cs35l41->bypass_fw = false;
 	if (cs35l41->control_bus == SPI) {
 		spi = to_spi_device(cs35l41->dev);
-- 
2.53.0

