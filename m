Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049100;
	b=ObM4pvlIdN90E/TdisVq9B6sWYAAY4jD/HjN5uChs+Jhzfr2asNNFmC2GsTkmZYS3ryw
	 j3DPjfzxyztW/Y7dBVyqPJ1MeuNbojm5eqTPj/kWdAHyar4MX7FWLVS6/k14Wid7Td90w
	 BysN1RXloEDx3d7ph8KYQop/lmULuczsSeNkr64gwwyeK45TbdP8pYNmJdGOJQZ996WX7
	 gw7uaWTzso1ThRdEBaS0Q6CzcOrzqprCPySviJ7vUUBGvItEQnVmG2EXRaIw62S24KPny
	 FKnInOwWX9cj+lbxEVT1PlwHaEAUrxr30lFvCXaohHZ7fhZEMruxYb7KHqof1PgStaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049100;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HUj/seBiW9LT4FSm7zd2z04esNTSuyr3VmgjaM9/lSk=;
	b=bYaIvc4PHsoZpvNRewJWgYb/yI3rR5yJVvECm35J1BCwA/MurSWZVcuJ89x4lZo0AQ/e
	 JnzDIWUrfWaWZ2hp7IGFXpadEg9gVgUNB0Hdo2UAYnQUmbabYuG64bxsnR0TPWeO0y1LF
	 dcYuAnUsDUgNvqricgG4ixEpSQc6fIgYb+GDX/om5I73ckfGR0kJM6qww/knyMJkWiGp8
	 qrZl9wSldOD0zdGMSBZ8dzTAp0ATYIWwv4LsOnIiRozEQCiFSBkaJl7hySuRuelo7hkIj
	 YrrGu3ErFjuLVGOI3pAjw7iWXRrU4fDtsP0n3sTUifRqGs3kXXCPpgiZj4pCNUX3UtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMVshH1K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E59606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMVshH1K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9CB1F008A3;
	Sat,  7 Nov 2026 10:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049099;
	bh=HUj/seBiW9LT4FSm7zd2z04esNTSuyr3VmgjaM9/lSk=;
	h=From:To:Cc:Subject:Date;
	b=lMVshH1KpVWrfxffc6jMGE+CvzBKGf77IwDzT0j7TRpiBs7Y/f/klZ6QsMsxJg+cN
	 a90cEuNT4GNAVthBHn+eqdV4RwJbcBMVUpu/9S43VflgY/TiU0YJiPIKAi5eT+0RDh
	 tKyqVDI/sHcrP3l5PWolW+lQu/aucLKyFD9uxIj1DYbWgyzeFSNv2zruIYGbRdfGUY
	 OaFaFGEs/mgyUTKW57kszMkho+u7R2O24Cfkzi0DRMiYuLbqmwLoS6RRQUHaz3IKNI
	 55p3QAP8oerC7UNzdRonMPOBuuXN8yGw9oAzZ7ebRwTBgRMllZLxXlH7lZavGM3dDh
	 g5vWlQP5L9sZg==
From: Sasha Levin <sashal@kernel.org>
To: pengpeng@iscas.ac.cn,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: require two-byte Cypress type 04 records" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:58:17 -0500
Message-ID: <20261107055817-failed-5.15-e22872703386@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e22872703386c3885d8c6bd595124587bc4e5081
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055817-failed-5.15-e22872703386@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




