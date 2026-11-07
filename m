Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045998;
	b=y+ZSA3aIQ2JxU9SOAMzolAbDSUqqb3mUBcfmL+M1rDkJgPkJo3Uwdy1FMDT4l9EzdJEw
	 SSyQfYE5uCij4P9vFr8Hh7wetRPC4UuSP30EFDqad79Y/UEGfZ/2DophklBqpvvDJWm52
	 LF0DCmAmWuWMkKoMs37f9khru6OVyyRQH3YBIzNLJb8jvAW2lBqlRnMgdCELVFrB5CesX
	 WXCPmrh0Eci3T7NRURH5MlSBYPxTU8TmokB+cnT9DsqU3h6oTGLD7lZnXgavdocQgvr/g
	 PLsnxFCYiO/TeT4roiSsoehuF38BGMYv9w6BiPOH1k2qSaiJZF9yZU9rYy94I0NqbxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045998;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/NPZSySgkrToTsw4LaHyqMeRr+raPOB1frF4/RbhQ08=;
	b=xr9pqiRyueX70ACxps8z+wXuR6rajKveFYZpvGxnkVpPru9JwK05EBRE5VRKmeoU0BOn
	 BbzNRLBSXVj7kBTNw6EFMpGnm6KX7yXbIREJARBhv6oZVyXBXKeLzzTL89YroQH7PDVyk
	 QXri5R9gg4tgeK9ms3Lq/LTkrF38/xr/4rT0UY1L6zz35ip4B8GB9x4LYHDd00N5sYTfM
	 7dmrXv7pfI5infyVhjz0+w3rNeT6QGbtokRNL0IKapgixfCjSsA6DjTilkXjCbY+ZefpX
	 7xdrkA5fvIQpaTGNGGLSMZu4Obshp0Ro9Jivy6yQcADiNKmfg5kUG+Vcgq0JuPkSoqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DN8zkXTo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C549606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DN8zkXTo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9A01F0089F;
	Sat,  7 Nov 2026 10:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045997;
	bh=/NPZSySgkrToTsw4LaHyqMeRr+raPOB1frF4/RbhQ08=;
	h=From:To:Cc:Subject:Date;
	b=DN8zkXToL/5fqvU/rqRUxJQE1bvSC2b3o7jYUNBDgN9lEO9d9fszASFmLf5yd0+Fs
	 Hy+LyuQIJFidaZBS4QD41fabIempzfuqrES+beFde/6M/62myjVjcmCY9BovSB7RO2
	 0cFZe8ll8JhuPU8pGvHJ+J1Tyq6evEheURhx8NfQyy+MZfiR9BsaB8lN0K2rLfG/XR
	 Q0XfLmlFz7ICiVNcthJxxehN/1nReegSWFYI4NHFCeXrEBLxpEO9pjwUc11p1h5QLl
	 JoPy/iI06x+oui8Lrv4Ki3tt6Oubp1bIU1R3Aevn2GXSNs3oBUd179YcOVqYnwVNXy
	 qJEt3bIYq3jGQ==
From: Sasha Levin <sashal@kernel.org>
To: pengpeng@iscas.ac.cn,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: require two-byte Cypress type 04 records" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:35 -0500
Message-ID: <20261107050635-failed-6.18-e22872703386@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e22872703386c3885d8c6bd595124587bc4e5081
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050635-failed-6.18-e22872703386@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




