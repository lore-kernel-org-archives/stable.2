Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046610;
	b=y3126D4tB/WvACND9kQAMTbeAvcSfjwssF/FOS2oHu2Io4pITcXEnEAg7+XwRPd1rzzK
	 6Rxbb2su6IPzJidX5S7p8DBuzFyTUM1h4ELgYUqgcuEysB8vSG++stWMC3j9Z2sp6yPBK
	 LMrmCa/7TymP7VfFw+uNCMCrobtuOlCNVKU+ui2qi3IAOQ4T5niKy5i6WHNAI7mIXTybq
	 +P9xqsU4IUcYTFdsr2rilScqo4eShqWVe7WaksJv8TzdLHjHxmjfpIPnEt0Vd3rjcVK6a
	 sdx4PHxcBAL/9jSS8U6C+KvyLV0uzb6GA01g91nf1yJuK+2mXDzfHLhAVGMvtkEE/vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046610;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7r/Nk7f9my6Q3Cvx6CREPW7jzE0H7U5ghEOIrOKH09k=;
	b=UzXW1Wn6bF4uQ4EKfDaZE3kiq0bTIx68/ECIutahF9KVMQwNP/yuj5y6MpmOK52xOECX
	 WT2YthEWY1Cnc+e/zVMCvqePBZMl5+lknxhzzd9qIUL54Fjl21b0LngpgQfnFEZTfrvhE
	 yzVNZy0KRfUkM+LKybCg8hv7w1OI6WZhjZnKiaHISR2+UaRaa0NnggbTD9GjGZJsEfkZx
	 Yji1DcSqSiBwyYDDp24TAigDfMaYH8B3se9QtBDPyCmkkyPDUzRwz40ChdgKmHpqz+q3b
	 3GxWptW9Qv90yBFx5Kt7MkMZbig4JPEgCFc3JIB7HmQMPWiwzIT+ueFIaoUz5/y+SFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BoGzAiph;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5994A6083607
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BoGzAiph
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B9F1F008A2;
	Sat,  7 Nov 2026 10:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046609;
	bh=7r/Nk7f9my6Q3Cvx6CREPW7jzE0H7U5ghEOIrOKH09k=;
	h=From:To:Cc:Subject:Date;
	b=BoGzAiph9VA3arGD7jgL/3g2N9yOM9JZO9l2kvrUH2/86bkNS/kexrWid9/ULrvbW
	 gx2JxTum/K2ZU62JjNGVp9wJjd3powVAcyuKytHWvwjtwPRFwuip7V2PmMFyzZTwL4
	 mH2/MTAgs94WBSXYL45yOGMMliYKgiRlhBlcCFW2oe5zD4E7Kb87/JuEgRofe2mmOi
	 yOTC75eubHRorVg0bKzQz2cDDTFapQ18WntZBSNoDowJqMUkWmTwExd9qWDwuLwXQo
	 ZoFR5PcXJ7GektXla/GKnrxJz7JlA/Nk4MTWhHtusju8l2cqvx/6bhmaLmZoiLr6ve
	 Y4UrvydiaQ8KQ==
From: Sasha Levin <sashal@kernel.org>
To: pengpeng@iscas.ac.cn,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: require two-byte Cypress type 04 records" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:16:48 -0500
Message-ID: <20261107051648-failed-6.12-e22872703386@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e22872703386c3885d8c6bd595124587bc4e5081
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051648-failed-6.12-e22872703386@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




