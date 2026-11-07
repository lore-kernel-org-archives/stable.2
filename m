Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050116;
	b=y3iMO0beZFhFvx77/fQCyWThG7bSAFRcaVfaWRKLf5iTyAgBfJpfnf85wShW/lMg8Zsb
	 kM1wPNzTAV8Wn1ug8S+rRvSPhrLIL9zuaYdy61CAzVoDBcF/omLvpR0Rz1BoXuNz9jC2E
	 hkrTBZ4M9FdBgfvISLTvTE9/kEbFmyskV4/Y5u7k9IJbaJqp6GL5QQfpy+vKW/W0roEJs
	 lZtELmPk+BNoEn5CCWx7D0zlagYtT14K2gbMl6yzsKl08lF6zxI9TvEM4KmxKF2kDMuIy
	 /2vazvgJridiujyRvD8c49sz5q8zoXoAjUeyrJQDPY130d38PMRMVFCWtvVu8zW4Lvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050116;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hztmqY7Y+MGcUg1JzJTU+IazNJVURSMUYIBtmKLPn2U=;
	b=XiFwdEbwtqNwmN+6z6UMqY+ygIJp5bMZGt7737Znf+V0c4wrzQm5FBXUV3OmoZoS4p88
	 0DZfZtJm9rholwOpf3/XbhbUAIQuKWCbAKJY0rGmqQw7NY72Mkprjd9JhNhjig0R2xSfK
	 ULUl+p2YrJdbKnoEt73Bbof9ZZyB95aMhK6k0AdccwoDPmiuCJB42f4yqxdths0BazUmQ
	 JH5tizmQUcIQo/lYjeum+udWO4pP8DCeXq5mNptVya9boBftVsXzkoYgLi5I6inaMucg1
	 O02vqTW3ZMWaxsqp8yCxoJKdxp8s8K2KaznRcguPt7Qlzz80B5oZivVpr4m5DDrMZsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhUN3bvh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D6606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhUN3bvh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F351F0089F;
	Sat,  7 Nov 2026 11:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050116;
	bh=hztmqY7Y+MGcUg1JzJTU+IazNJVURSMUYIBtmKLPn2U=;
	h=From:To:Cc:Subject:Date;
	b=lhUN3bvhGXCQNQo6Nmc8W0+M5Vjj8bfppgyyn3TfvDRp/G0OnDrtIyUdAJtcpyBRI
	 51ebgdbh0l57KWSlfcizPk2YtntLIDfLy8LGGfzbwQXL0K1qm0uTE8Z1FildAcfey4
	 5SLNsh9jicZscpGyvw6Vi6IMdvfaW3h1L3BWRcxtJvQUKJNNTGYwpMg/POW6wY3uEO
	 0oATGXaI09NFsAElgF5G17dftORuQbE5UfkuKp2RGjgYDf5nLYC2RS+4DDfOFsBwcs
	 MZvi/YQG0iD423lNIqhmrtolD965poyehmM283riDG6oMjASyVhLw2jnjz7NhvcyXq
	 ANPzAmwlIhRvA==
From: Sasha Levin <sashal@kernel.org>
To: pengpeng@iscas.ac.cn,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: require two-byte Cypress type 04 records" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:15:14 -0500
Message-ID: <20261107061514-failed-5.10-e22872703386@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e22872703386c3885d8c6bd595124587bc4e5081
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061514-failed-5.10-e22872703386@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




