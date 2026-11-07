Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047335;
	b=HhDzjRLPjOUHgkmOEzA6tlqLRxgl2O0GlzcyRILAxpBvuObdVCZXULF8IHgOexrxfF7C
	 loF1xpsXDWQccrL8mJEbB8yjPFVPOTSX7j+C8qMNyz1ROeXYMckL/5SwMXwO/yxX36Qzc
	 73FEjtmrXzV+dBwkUyokYjx+Af6fu8SkUWtcvQ1pvmOWs/j8/2aRgwNSeHHLlzyeyohGj
	 /5lufkc378JQjJ0MbIoW6g67jBCcCwsY14UYJm8m1VKG8FHZ5YuiT7CdBO4gmztz5c8Rn
	 7I62iYIWem7f38PLPcgJthmVP8NqocvOG1Toz9Dizpj2u3pbT4TtV426jqHd3vFxB2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047335;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oOEr115CZfv5uTMs/cbgfH/g+v99nIZtybVoBqwZIpY=;
	b=TDOd5cNoqhxshH6shSINFH38wsBBrvBGpnXhmMDqLreNnd7ZSGbCJwhRO2GMKNBtW41k
	 /pPzoryi8PgyZFpFsjhL17znRQfSbvxnwasduZK8zBAze/RLlvM5lLDY6Noe+3P53vG1c
	 OfNSSzw98OKS6I/vimF5LAtRkbJ9TKQ0gzXvFUNtuzazrepe4ap9KmIvjN24XNALj5gyK
	 GE6xNiOcrAan1dcYcvqRC/77DpeqNuSDEB+oNwNGPMQd6bPECFxnzMW/jDC+7uP4e1eip
	 ThJ46fzIKCWEzKZek5qx9YrGB8b+Aqbrn4ctzJWNPBBtBiizMfffKFOMTcatfMcZMgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5YVc0mI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90449606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5YVc0mI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ED01F0089F;
	Sat,  7 Nov 2026 10:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047335;
	bh=oOEr115CZfv5uTMs/cbgfH/g+v99nIZtybVoBqwZIpY=;
	h=From:To:Cc:Subject:Date;
	b=Z5YVc0mIOv/WiGKYIv38llTR6+mmQFTZ7lAdHjEWTTJrcrJltKpJD0qa3kBqXtIoq
	 M/EWktgxduK5CuHPsS0yUOnVKSwPQbpNLh3Vg7RQydrsEDglgrRjeoJwFqgUb7gTGS
	 J310LnAiE0Q2YH/F1kY76wxdZMXZamnOLWTy7yldUEEAu+hjUqneQUZB+gkZT9Oldw
	 PqNrAZovjnTr8RQv1yFivNwqEdFaQ0/l8vzLlm38Jv+j5OZLoNTC4DNgdeCidIIiKE
	 UfoMsDg85OngEtecDZx5Di0o5PCCJEKM+IHDgc788F2/JdfwN0JNtzOTokICUsr3aB
	 DEfbNKSVnJCMQ==
From: Sasha Levin <sashal@kernel.org>
To: pengpeng@iscas.ac.cn,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: require two-byte Cypress type 04 records" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:28:53 -0500
Message-ID: <20261107052853-failed-6.6-e22872703386@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e22872703386c3885d8c6bd595124587bc4e5081
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052853-failed-6.6-e22872703386@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e22872703386c3885d8c6bd595124587bc4e5081 Mon Sep 17 00:00:00 2001
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Fri, 14 Aug 2026 16:08:02 +0800
Subject: [PATCH] media: require two-byte Cypress type 04 records

Both Cypress Intel HEX parsers read two address bytes from type 04
records. Generic record framing permits any record length, so a short
record can make the parser consume the checksum or bytes beyond the
firmware record. A longer record also violates the Intel HEX type 04
layout.

Require the type 04 payload length to be exactly two bytes in both
implementations.

Fixes: 79a63c60a6a2 ("[media] media: move dvb-usb-v2/cypress_firmware.c to media/common")
Fixes: 776338e121b9 ("[PATCH] dvb: Add generalized dvb-usb driver")
Cc: stable@kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/common/cypress_firmware.c      | 2 ++
 drivers/media/usb/dvb-usb/dvb-usb-firmware.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/media/common/cypress_firmware.c b/drivers/media/common/cypress_firmware.c
index 66274fdf52438..d0f66ed01c4b1 100644
--- a/drivers/media/common/cypress_firmware.c
+++ b/drivers/media/common/cypress_firmware.c
@@ -59,6 +59,8 @@ static int cypress_get_hexline(const struct firmware *fw,
 	if (hx->type == 0x04) {
 		/* b[4] and b[5] are the Extended linear address record data
 		 * field */
+		if (hx->len != 2)
+			return -EINVAL;
 		hx->addr |= (b[4] << 24) | (b[5] << 16);
 	}
 
diff --git a/drivers/media/usb/dvb-usb/dvb-usb-firmware.c b/drivers/media/usb/dvb-usb/dvb-usb-firmware.c
index 0fb3fa6100e4a..675d9d1d4f472 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-firmware.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-firmware.c
@@ -141,6 +141,8 @@ int dvb_usb_get_hexline(const struct firmware *fw, struct hexline *hx,
 
 	if (hx->type == 0x04) {
 		/* b[4] and b[5] are the Extended linear address record data field */
+		if (hx->len != 2)
+			return -EINVAL;
 		hx->addr |= (b[4] << 24) | (b[5] << 16);
 /*		hx->len -= 2;
 		data_offs += 2; */
-- 
2.53.0




