Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0B1339375
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716244; cv=none; b=blPbIRBzP0eFlVhvziAmUt+UsGlCS0vfrS5kMDqlkNq4Mw9sn9NnsYRD6PQnWcij+Z9GJ+52cBrW9sJ2Msh/LKwkC/ro1Db4c+sfmiQ33ACZS56hCgMi0Aeoq8ixzbkQfoVD290IhrkDr5ooDZ12GJ1jPDIyf6VzVdAv3NLggTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716244; c=relaxed/simple;
	bh=RhehwHHBb8H4OBjE7eqWKzTTFv6N/2VV1vQcwbnVPZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U55a/qgrPVlLEaZLnfOqyoQHlufC/erGH2PosGMc79N8uzuBtPjbtve9E3FKTUkxf7oNMcJt7PFb9uQphzr155GIyD71vCzwO86o9q3RhI/yB8URkgSVVgGjvLMDC4b16MC7mvQCrL82KKlUloYLdUKD5Q+hnC8ltorFVUci0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDuhMV1M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDuhMV1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BB41F00A3F;
	Wed, 22 Jul 2026 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784716242;
	bh=64Q4fCb7iHZWkyyvPNGmWvoD0jglG3qdOb4ULx/Yvo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mDuhMV1MrT7eae7ryFCvrHyMDZ+ZCjTrPo3Gn7gMHbAAzo6umU2zTom5ofv3nVv0U
	 aHhdfz1KqGiIc8Cu2Oa6zRWyVokAq6jXnUaWh/OOjO26Q36GpXItlQtvUwIvE2F80z
	 nIYpLT0litq15OOoq3AZfH0B8Bbuj0uqh3aRUvQDGT81w6frldxq1ZkVE9LUeETQF8
	 EaYyr7KivLJRilw7/5LfnoKzzMapGSLbb4trsIqDxhqGw3GlyH3cjdIshnHnAqQriS
	 fHfZZ5Vk5dD8jF3fz/NsSbRGtkZ6XImMc5cnSsJ/MWUPm0GzDp8z1G1c4WIgLp/k4w
	 j3YySALqh7W6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] Input: mms114 - reject an oversized device packet size
Date: Wed, 22 Jul 2026 06:30:40 -0400
Message-ID: <20260722103040.891331-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071645-latch-matchless-9242@gregkh>
References: <2026071645-latch-matchless-9242@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 66725039f7090afe14c31bd259e2059a68f04023 ]

mms114_interrupt() reads a packet of touch data from the device into a
fixed-size on-stack buffer

	struct mms114_touch touch[MMS114_MAX_TOUCH];

which holds MMS114_MAX_TOUCH (10) events of MMS114_EVENT_SIZE (8) bytes,
i.e. 80 bytes. The length of the I2C read into it is taken verbatim from
the device:

	packet_size = mms114_read_reg(data, MMS114_PACKET_SIZE);
	if (packet_size <= 0)
		goto out;
	...
	error = __mms114_read_reg(data, MMS114_INFORMATION, packet_size,
			(u8 *)touch);

packet_size is a single device register byte (0x0F) and the only check
is the lower bound packet_size <= 0; it is never bounded against the
size of touch[]. A malfunctioning, malicious or counterfeit controller
(or an attacker tampering with the I2C bus) can report a packet_size of
up to 255, so __mms114_read_reg() writes up to 175 bytes past the end of
touch[] on the IRQ-thread stack: a stack out-of-bounds write that can
overwrite the stack canary, saved registers and the return address.

A well-formed device never reports more than the buffer holds, so reject
an oversized packet and drop the report, consistent with the handler's
other error paths, rather than reading past the buffer.

Fixes: 07b8481d4aff ("Input: add MELFAS mms114 touchscreen driver")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260612-b4-disp-dc4b8dc4-v1-1-d7cb0a828d92@proton.me
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[ changed `&client->dev` to `&data->client->dev` since 6.1's interrupt handler lacks the `client` local variable ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/mms114.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 9fa3b0e421be2a..566a95ab0cc347 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -212,6 +212,12 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	if (packet_size <= 0)
 		goto out;
 
+	if (packet_size > sizeof(touch)) {
+		dev_err(&data->client->dev, "Invalid packet size %d (max %zu)\n",
+			packet_size, sizeof(touch));
+		goto out;
+	}
+
 	/* MMS136 has slightly different event size */
 	if (data->type == TYPE_MMS134S || data->type == TYPE_MMS136)
 		touch_size = packet_size / MMS136_EVENT_SIZE;
-- 
2.53.0

