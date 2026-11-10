Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324602;
	b=Jmy8/jZemQ+aIZtuSUzibQQkemsadO1GqXG226Xb+i/Yvc6knxRSnDjqDzDF6pGEVrwv
	 Oa++CuslXfOeUl4NtKaxh9B0NrSh1+92ZE0rh/Q1i37/DY27mYw4I7U1wTFDbRGpOg9MP
	 2UXnTh+kuP5Y1fPJPX9xKJWwO2aArnl0UxZRtyULxcygw92wOxPa4qIBowKK6ppjeVVpv
	 802suzhfeRAvPYWIb09/0YxEUEg9562jfO9zbR+sKGr4nHVaWxemFMqRoNIMQWJsDxFif
	 YSFAGII0VeKaj+puW7JOqhcuzb+wL6ySSc3yspc82jZK98dYolzu8lL2YKtQhcvWIEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324602;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0FyVQrS0Z+WQadj3ZrN4BIJIgTtyVn2ycRF9NHgnNQI=;
	b=MWGq6qa1Jh+a+bpzcXAVHQ/OKcZEIoIzWDb/pQFbILdNdpq8BhmFFxZ/oHGask6tjx05
	 8N6CXLHRAfFXO+8P21TjFJhqiTgNuMAUv4LXl7CnLNTRSOIe3JA/7CSu/sHUHg72AprVe
	 wLdR7pz1VWS3ctb2I9e312PxmLzFaPXCPpcJ175YhVZAihWATj/lPqDpdPaG3ryacw9x+
	 SUhuSBboIGaUXL4qbvtJezL1E0Xh/jHKTe1XD8XsM78j+GTbM4Mb2EmJPvWS9Z2n1bdDV
	 1ltNcPonIdrm0/TdCJk2/6L3JiWKO93CSNw7oXrEYZjVfIWoUenTecyYK8YmLmpn57Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRFhLl1F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94B9606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRFhLl1F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE111F0089F;
	Tue, 10 Nov 2026 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324601;
	bh=0FyVQrS0Z+WQadj3ZrN4BIJIgTtyVn2ycRF9NHgnNQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XRFhLl1FxhfiXiSV2/45kSIZBHgdHb7iylUmqpNuwct3ktCGF/pXcExs6v+QYnHJg
	 5FHzCiyIhM1XjGi7dRUqErP9fKLiHfqr6b8Kfdckp7nWfHy9Ln8bJRBv2BRCBsW1gy
	 Z17uicZdLne8V7+fd2/D16stCZ4ogt7QrbA4sFL1jtRjL12TR8derw0VKougoJbV4Q
	 nbmGc6bdKgFM2Fn00CnYblVe+mC5zzxuTKW5Spvl8Pr4D+0lCGoxG9VSERRbvxeerm
	 ebSCEH9ENHZlKZiqK9IrNjaFVOUpUO6kzbkoQFMQR4kfKeM+bryhqfI4mBjmmTdjV8
	 SEKephNFgvcfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] mfd: twl-core: Use i2c_check_functionality as boolean value
Date: Tue, 10 Nov 2026 10:29:58 -0500
Message-ID: <20261110152949.2135243-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050717-failed-6.18-3c5c55d979dd@kernel.org>
References: <20261107050717-failed-6.18-3c5c55d979dd@kernel.org>
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

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 7ee4fa2674e51a0d100b9240cd8a50355141362f ]

i2c_check_functionality() returns a boolean status rather than an error
code - directly use it as a boolean value.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://patch.msgid.link/20260505114543.159381-2-thorsten.blum@linux.dev
Signed-off-by: Lee Jones <lee@kernel.org>
Stable-dep-of: 3c5c55d979dd ("mfd: twl-core: Unregister the auxiliary platform device on unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/twl-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index f89eda4a17fe4..c024a28b057e3 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -754,7 +754,7 @@ twl_probe(struct i2c_client *client)
 		return status;
 	}
 
-	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_dbg(&client->dev, "can't talk I2C?\n");
 		status = -EIO;
 		goto free;
-- 
2.53.0

