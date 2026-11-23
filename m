Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464096;
	b=FLotbTwJ+MkZJpgK++gSi99TmiNWhutFQzb3nO8u2qEV9kLWukkDhE/CJlZXAwu+fpcp
	 78kq8/RN6wUn6u+2tg2EgeWvczLSE6/dJNcknVs3WR7v54t6XGulEOV51z2F0gM3y3P/R
	 RD7XTH2NTKLtCZN1Hl2/3NP8DyNaudHbLWLhaVFGYmTgoimgMTISymeu37oTXan+EU1Bb
	 zKmNkFBmR794MrHNIevfIMdUJx9eDTAzDcH2w8ZQak7ZzFDCKkTa15/KLyz/gRRZhIxkf
	 h3n6u9YFXtStZvVNZMvvYxMohKrYAchdGxRbWzCcKdEwX/spRWP7mt0iHOm0Jy4aBKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464096;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rIXsJMehOPg1X0Zqd0qk76Y3DfAiySDWaSSPKtHk4ok=;
	b=qDp4UmzcPEMq9Z5Cnt80TyzSKBo3GcsMaOWKPErY5rqwn33a7XMxXKhS5f0ux14M/Chn
	 fqKFOTyFZpY3WjF34VpzQYPz2Ejp+ipqNM1RoYfy4uvPbsnOcckj/EYyHy3Wfa6sefqVn
	 B9BJ5mU/UtwGpK1lsdDjkd9+WftBZEv6OzXn7tthEff5WFIlAgI2E/gfNeWV3C2K+vyNl
	 rnjd6eBdynJY38vE+QZVu99L61rNIxk0aLIqx0aeYSK/g/dSRge8EHqtx6qlx4KmFzeMG
	 Cw9eQaQCduoyD6MUDPMmmFezkcSJix/n4h9CGlhC8/SqwYX3rnlnDCWX0jvWkHRINcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kN64DBPq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E0606A31E;
	Mon, 23 Nov 2026 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kN64DBPq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846FC1F000EC;
	Mon, 23 Nov 2026 20:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795464096;
	bh=rIXsJMehOPg1X0Zqd0qk76Y3DfAiySDWaSSPKtHk4ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kN64DBPqSjG+Fugy/hLzaaFYsQ3XKdnGiJc35gj6B0l5HVSBpZWO7tALW84V8/SOU
	 /DGsf0knpSiN9eYQqOWEa9hIUf5TQ9uomQ/1a1VGerpHS+jjcM8g5l3ssK0gozDrNT
	 NFwcr+TyOoqJrwARQ0+8SItQoym+F/mav2ufDhzvvq+4Cuw3s6tEbfnu1p1z6aKprN
	 0WjpeJZ7esLN4BGRXrdr+Vcv1zpfAs14M3AylZ4K38QMXx3Syrgomy3o/BEuXwCfCO
	 PabL3DJY9YVaRN79QmXy2Qui1HhIZBizKhe7M12e3Pau4nAB36Bo0Pz6Aajy94OKs4
	 3Cn5e6EJtce4g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Adriana Stancu <adriana@arista.com>,
	Pavel Machek <pavel@denx.de>,
	Piotr Ziecik <kosmo@semihalf.com>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 10/10] rtc: bq32k: use u8 register buffer in trickle_charge_bypass sysfs
Date: Mon, 23 Nov 2026 19:59:21 +0000
Message-ID: <20261123200012.502284-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123200012.502284-1-lee@kernel.org>
References: <20261123200012.502284-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bq32k_sysfs_show_tricklecharge_bypass() and
bq32k_sysfs_store_tricklecharge_bypass() pass an uninitialised int to
1-byte bq32k_read() and bq32k_write() transfers.  This leaves three
bytes of reg uninitialised on the stack, and on big-endian systems
populates the most significant byte while bitwise operations with
BQ32K_TCFE inspect and modify the uninitialised least significant byte,
leaking a bit of stack memory on reads and failing to update the
hardware register on writes.

Declare reg as u8 in both callbacks.

Fixes: 4c466872d8ae ("rtc: bq32000: add support to enable disable the trickle charge FET bypass")
Closes: https://sashiko.dev/#/bug/linux-1ab3635e-98ec-4ca3-a4d3-58033a48c44d
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rtc/rtc-bq32k.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index 0f50cfce88cb..7e5080eeee3a 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -204,7 +204,8 @@ static ssize_t bq32k_sysfs_show_tricklecharge_bypass(struct device *dev,
 					       struct device_attribute *attr,
 					       char *buf)
 {
-	int reg, error;
+	u8 reg;
+	int error;
 
 	error = bq32k_read(dev, &reg, BQ32K_CFG2, 1);
 	if (error)
@@ -217,7 +218,8 @@ static ssize_t bq32k_sysfs_store_tricklecharge_bypass(struct device *dev,
 						struct device_attribute *attr,
 						const char *buf, size_t count)
 {
-	int reg, enable, error;
+	int enable, error;
+	u8 reg;
 
 	if (kstrtoint(buf, 0, &enable))
 		return -EINVAL;
-- 
2.56.1.750.gf70dc682cf-goog

