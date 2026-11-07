Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048097;
	b=RkR6Gq93RIOd5eEVkUMnFe+TaVH4++wZpSV0mQCNuJjq7I/kTTz6yes/0ACNd46SRmhE
	 R8F1daw3maEvN2SxTVggBeirSb51Rnr9I5POL8+FBNB1URnGAsv5wFoYhV+ZJWoaJ050T
	 64MNxJzdyh3+9JowbyNYtEp3A5i6Eg4EelhnNW1VDEgkd1R0PYCQIaXsSbxlM8zwZWghI
	 V3W+N6mz2tUdYdn1aooAEkr/dvwt6XAh4RA4AT5AxHFtctg00r5Th+48Oa7KJeYKUx10w
	 uMEzrewtTm3SW0I7LIxqfGMXhQimCdhKUFHew2c7wmeIp6hMv4zoH3U3dUQ4fNr/DcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048097;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XSCJ6rW0ufR0NlMw35VRwH3F69HwjSIj4HPbOMajhXc=;
	b=ObHt/TwOfoiwFRXamFaSfSXasqMGUAJf3AuUVpl4XoBt9EWSqbcCVNe0SODHBuANtB6k
	 oxGk0cC6StJINNtONqbCPsdsYwAPNYjOMNKecbr3sSQNdIyINWdE6ykNYsEtVKBvOb+YR
	 DWqBYsQsenvf1AGclvg3a7aTjXOUxerycnDBqVQ5fPX+joQa/6z8ivH1cYEwntojw3h6S
	 rm42ZlE6by94Q3nxMlN08wMD/QH9OSauLfXoReZGq2nJ6u113zbnCnXZqUMboLVTax5ei
	 esCg61oPayeQ/J/bAXjSHZyEXrlOtmkdeGsf5vnpiB+Dwp3iSOKGsxcGwx/JEd+pzDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GkHMBvvf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55759606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GkHMBvvf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C492E1F0089F;
	Sat,  7 Nov 2026 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048097;
	bh=XSCJ6rW0ufR0NlMw35VRwH3F69HwjSIj4HPbOMajhXc=;
	h=From:To:Cc:Subject:Date;
	b=GkHMBvvfnRPdv4zuYUcSdb/8zkzeSMnDHiSowgkifxmQSn1d4W2z5UzKBmDgjOPfV
	 pFu3hdlhfPRY8G0R2N83H7WNK9cj8Ke5drlMtbyGf+SbCVq/5cDLyGoebcsUoPi3E+
	 N7YE5AUpqPWcsUPr7ZZp/q/Py5cOGS4TYlyr0rWWzpi9cppn/x+3rlNHHfbPL4ULKd
	 0v52ti2zrpW+5ZY9zNtkqu0TByLZwgkahtq/7hCurXt4K3uE61xudLfvOjTB4HSYcG
	 kIKHdpxo9ik0sMcDtAdXbV845B0SshoP9yZcMt57VfQn7a+hgWK+gbg+Kg2RDBcLYx
	 UF97l1wcTUaqQ==
From: Sasha Levin <sashal@kernel.org>
To: pengpeng@iscas.ac.cn,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: require two-byte Cypress type 04 records" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:35 -0500
Message-ID: <20261107054135-failed-6.1-e22872703386@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e22872703386c3885d8c6bd595124587bc4e5081
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054135-failed-6.1-e22872703386@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




