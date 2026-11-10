Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326639;
	b=4o2qv4vqu6fOOmgjWRlRvMqzaraqC4Nv6FhMa8ZmO6aAPYFv+QNtCBhKobkzI738mDhX
	 hzKb48d2Ts+ENnN/GGymydd8m+2yYWvSQdcfdMiJfai5U+2WPO7pYz/WeXWSZp9Q90n0U
	 SAi2wRPqgKxC9L1IwajxBgRtdTVCCn2SqjXf1ZMIRBO+Oby2vtvykGEz455e8KvnjPcRq
	 JEp4h9b4CvDRtikLhlMxakQOfI2rbup5rFgdlLBjC1Jb8iND/eIHzgm/ZSu/QzQWhwD1f
	 rA4cgQokb8VJmtT7HxNSifHsFcZkNvTLfOK0C27aMnpQrz/aIL8PsOSlj1PD4/6Wwog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326639;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DNeXnAs6dbLbCLxXIg/3v4UXdaHiJZN4qyM3u/7gAJ4=;
	b=LwmRDRXQmTVE4o82lUpHuRNyptv3SW9/dc0Y995jjyn/p4rddxAxSluOjCvFmrzMFPFx
	 vWkgDHVOttkuQA8i+G3GkmC3q7wkhJyxAiDah+2020C2WFbqewL23jTLGmWu5eJp7eAG2
	 pQ/rOvzgvVIw8yNHmCWeUdyHZo0y2VkLCO4i6Ado3XtIJN14deGREIR9BDDfDUYST2J9k
	 j4psiniMz0CN3JRnXBNNG8Dp3Adwqz8TkKajWUHib61XYw/ohAnnHK7ByiveTvzhS1cIm
	 cRDzqqUzgNUP6WHQhXc4qSE3nywNO0vp2spLJ2m+HpzdvTBx28faOg34fqHKESyN2WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUC6xjo6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C24D60A2600
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUC6xjo6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FBE1F0089F;
	Tue, 10 Nov 2026 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326639;
	bh=DNeXnAs6dbLbCLxXIg/3v4UXdaHiJZN4qyM3u/7gAJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aUC6xjo6vtyuoOVaYguhaYBO5LFQ44CDs+8+Yz3uNs8zKPGNd1/bBOyvUrh+xtv1V
	 MN6Dc/oxpQnCj3pysNC2//ThGcK6eAcsKToBCBnWBpoWbr6etL98JuMrwcAFNGdlzc
	 YSesUD1BiuWBS/GWrfq+me6eA+7if4yINm0YDNEoObmQZ4z4qElfbOXcrHsW6gUZQ2
	 B/qB48ObAkVWr6dbMlM736+F/feDy2EuEwAwjLmdwN6r0MWURs5Icm3qi9D7mvRSbz
	 OFkJ380w7EG1eR4z4DVCAnOAkXtRvrT4KmJJJmM+40H77xCHadRG+/vcI1EVEntLEG
	 cBOK+i5/hhCGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mfd: twl-core: Use i2c_check_functionality as boolean value
Date: Tue, 10 Nov 2026 11:03:56 -0500
Message-ID: <20261110160339.2387037-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054250-failed-6.1-3c5c55d979dd@kernel.org>
References: <20261107054250-failed-6.1-3c5c55d979dd@kernel.org>
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
index f6b4b9d94bbd3..6c589d71df2a9 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -786,7 +786,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return status;
 	}
 
-	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_dbg(&client->dev, "can't talk I2C?\n");
 		status = -EIO;
 		goto free;
-- 
2.53.0

