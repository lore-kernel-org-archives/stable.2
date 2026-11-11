Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794417840;
	b=rGtV8fWt12S8tD/WP2q4fbfv5FLF1kFNkbd3rUPCX7lj7b/EEmBf/hWGkzY6cJzm3POd
	 bZYRfCbMkA8p6aVrgTLyMdMq4yE5h2DpL7Li5mp+ArGFsRAqhZeQVZd0BrNDOZ9EpB9FM
	 zZH8oBLvImqP6AhdsD8hANqEfAEeyxJZimBzQ+2vzPPE6YWBiLeO3ikVj+qClADVW+b6c
	 gz1rIba7imwyeNiOTUHipcp0xwAyIiOeE57avI2jI8Uu3A/Qftkn3pQWkaZrDqDkhFOHS
	 lBLhS7V6BxSgXP3QxFOtKior85Mm0lhj+QsjdgWohFngqZ0DHoDtKeFITZYe680T1xA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417840;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6NxaIFuj5GbBs4gkgvfwhinm5enDeC875ssfNTLlQX8=;
	b=CsWrDhLiK4YGT989QlqQVb9iJB7d0IomtRjM2cxhTC5kQbWSMLwJ2f0tkSVzHHISlO5A
	 2k4qhlwH30FFaPXt1tqkIexQMOjz6/WuCc4t06KMnSkEnwqD5zUDDSrGWk+cuLSFlBaie
	 dL1UzC5KYoyMyAC5H+b10C8mGioMjxsvUFyABJkzzaA8IvI9DfQX9HGQXzfvJvhXXY7+L
	 6VQAyAJQRgCGh8y9oA49I4UldDWG4UCiVjwDaiA4fTfw92Idz3yULSyESqQ9jYgFTZom3
	 38orgPEpH9l9u8qSKyDe15Z1FsBX1Bsox22v6SzUDdeghHgj4Io0kOhhRkhyYbrwwMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtePFse7;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE4A606A333;
	Wed, 11 Nov 2026 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtePFse7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794417840;
	b=xiW99ndAbkL485YmMLZDBxzPT1TH1TSdq70lqj/7h9SxUthp2FGWQr+NpB7VAL6S5btb
	 P2dVyQJT7Um8EXGs8Pb+C6ElqtmI9vArYxtfbP6iTXY+c5jP2iNNv+837R6MuOPQ02q48
	 YZs2/TH+BLL2ZeZAyJU3FcZEBrM3XK6Yr9nV1nX4PTfsT82jxnYtDpcWAwg0MYFYolzoG
	 3nVVLDR6dUDWDpFyLKnoLc6xtt7Fd8oW1+RCnTdwHlQle0ycCHvpLz9dR1vAQMFMmu3RL
	 tJESeVUQPZ06iZtmv/RDQgBKVv9Koqtvyk4tXp2oiyPDkK4RKKUozDyV5bj0fVJBKDA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794417840;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6NxaIFuj5GbBs4gkgvfwhinm5enDeC875ssfNTLlQX8=;
	b=rRsYNgad1JJ/QjRWYI/dXsOZRtKD6Zv+vk2TgO/ZWrj19ZKiBH6HqAvlaO45Tu63cSP1
	 PR2wFGcJ2YOrNSy0io8ydzntssKNwJI4UGYls8IVEQAS5LCcHUXHtDLEL5nVkdu4564+k
	 6RZWv5QyLemj0RDbUV3vMZUaZeGh0Zj6Ko9XJIDzgrsBtQw+bxkREmhCuskz06hxxOK+y
	 k1mt8K+OQe+M7g+o3w3S1av9+4Q4xxJTaA4XDfhtW5753xDDa5xMuE+clZzgb8Vkvknka
	 UCdWUpJA83Qcc2Gn4daM6/dVj7Lb8VYBlTChQ3qllMrxvV1kcp1a34mjnZRrog3Xjxg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7C3BE1F00A05;
	Wed, 11 Nov 2026 17:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417840;
	bh=6NxaIFuj5GbBs4gkgvfwhinm5enDeC875ssfNTLlQX8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YtePFse7ofcGaSh1NgHOdSnuwJvkjrxfW9DrSoyTbVVtOsS0qvEjMOrIyabvsbfqn
	 m33guf/4H+7D2MlUsNPKMkwaMW1mpdxnJoiJzEbniLe6CDnUQRcpWVHig44XaA8HSg
	 AhBVlpQ1swsLF7YO2IBIvQv/+j7QM++Q3ZoiRnlhLDJv898sRuKbipprdfH24uRDI6
	 4cDhER7B10+jhTdJvcKELXcImaC1TerTvzvqeRwAtX4+cn8Yed5DxYwoaKkP8wYpEL
	 g/5wHJ55GizJmM83k2tj5AQKEyxBDM/JMNwPDsHfMtE5am11dCJWK6ZKVTep/OoVt4
	 0gHf9idWVViUQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0324D4903F;
	Wed, 11 Nov 2026 17:23:59 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 17:23:58 +0000
Subject: [PATCH v2 1/2] can: kvaser_usb: hydra: reject commands shorter
 than a standard command
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-kvaser-usb-validate-v2-1-193dc10ca19b@gmail.com>
References: <20261111-kvaser-usb-validate-v2-0-193dc10ca19b@gmail.com>
In-Reply-To: <20261111-kvaser-usb-validate-v2-0-193dc10ca19b@gmail.com>
To: mkl@pengutronix.de, mailhol@kernel.org, joasantonio108@gmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794417838; l=3068;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=2FOyrmwYW2SkcrDKPo4yzypedyTsO5ugueU8GtgBM1k=;
 b=vKFH6qpUghmLa7rLBGqIk9d++ppksgy7ubAleVHuLrzsAxXjbja4eCdMgABxDVHkPUORiyLcv
 iwyUxoFl+PoCcPl5a2vuwV/te+0q2TyKYcZi33r5xMu9vvEDGx0Rv97
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

kvaser_usb_hydra_cmd_size() returns the length field supplied by the
device for extended commands.  Both command parsers advance through the
received buffer by that length:

  kvaser_usb_hydra_wait_cmd()            pos += cmd_len;
  kvaser_usb_hydra_read_bulk_callback()  pos += cmd_len;

Neither checks that the length is non-zero.  A device that sends an
extended command (cmd_no == CMD_EXTENDED) with a length of zero keeps
pos unchanged, so the loop never terminates.  In
kvaser_usb_hydra_read_bulk_callback() this happens in the URB completion
handler, which also calls kvaser_usb_hydra_handle_cmd() on the same
command in every iteration, and locks up the CPU.  In
kvaser_usb_hydra_wait_cmd() the loop spins in process context without
ever reaching the timeout check.

A non-zero length that is too small is not valid either.  The parsers
only check that cmd_len bytes are available, but the handlers of the
extended commands read the fixed part of the command without looking at
the length again: cmd_no_ext, the flags and timestamp of
struct kvaser_cmd_ext_tx_ack and the fields of
struct kvaser_cmd_ext_rx_can in front of the payload.  That fixed part
ends at byte 32 in both cases, so a shorter extended command makes the
handlers read bytes that are not part of the command.

Standard commands are sizeof(struct kvaser_cmd), 32 bytes, and the
extended commands that the driver handles or sends are never shorter
than that.  Treat a shorter length as a format error in both parsers.

A similar infinite loop in the leaf command parsers was fixed in
commit 0c73772cd2b8 ("can: kvaser_usb: leaf: Fix potential infinite loop
in command parsers").

Found by LLM-assisted source review.

Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 687911d764de..9adb4eb36e39 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -676,7 +676,8 @@ static int kvaser_usb_hydra_wait_cmd(const struct kvaser_usb *dev, u8 cmd_no,
 
 			tmp_cmd = buf + pos;
 			cmd_len = kvaser_usb_hydra_cmd_size(tmp_cmd);
-			if (pos + cmd_len > actual_len) {
+			if (cmd_len < sizeof(struct kvaser_cmd) ||
+			    pos + cmd_len > actual_len) {
 				dev_err_ratelimited(&dev->intf->dev,
 						    "Format error\n");
 				break;
@@ -2156,6 +2157,11 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 
 		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
 
+		if (cmd_len < sizeof(struct kvaser_cmd)) {
+			dev_err(&dev->intf->dev, "Format error\n");
+			return;
+		}
+
 		if (pos + cmd_len > len) {
 			/* We got first part of a command */
 			int leftover_bytes;

-- 
2.43.0


