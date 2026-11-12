Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794504477;
	b=NNqt/LhKbcxJ+F7uQNSkQSDauO8OlTK2KQQlvnT9XlPDS3Gg2PQvaHsKpdRhHf0HkC2w
	 mG9Dx6hhf3mXC4G1TfMtXLwRqRx+NcKGiYypzuZ/kObXTgZwb6JRM86gh7iok5Fq5N3ow
	 PzA3ZmXkymZFCrCFKdFccWHcMDhUCSUGTmArnijH0u8Zrh7kT8i2GNvF0if8ymyrtkU0I
	 eqDRm8VhADd5GOahyjttsBoFlhZKgMPO0qVr9GRdl1wS/bTFCzbJ9oeRVzN7S5HsRa38J
	 QvJpVJWqsNA/3Uuv6uzUrrte2ovlBBkaPtNSgQj+YA21mioTKtX5iLEN3TTJm/gTQzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504477;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6NxaIFuj5GbBs4gkgvfwhinm5enDeC875ssfNTLlQX8=;
	b=x3rylX4/0ncUzk8Y+7UMAlCrsBrk4K40juNFiHLV5Kki8BCbXCBL3hhwyj0UQeBP5dmi
	 eGEXaRo3wQcAf7C1UURs0kFUSKkd7YHkzAN2xh66ZFqwjBHlheFjRa/JOsF3i5swL7uOe
	 q0ua7aoEXBw++adNXYXjuIqChj9YRrIhuIeoAO3m4AJIeFevQRp/5ONIHf4GWkkL8iVPg
	 pczZRqKVryW8mwwayklL7p8scUzqnkdjdd3PGg10JOTztdJbPWzjmE7I4naAoINI5WhZs
	 ufCtbkoFNFBpUgHcrVkHzJ7W0GeY4Ubpe/x9+zaE17Xv9VWOXU2mw2XkJ+3PRK5Y9yA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kr8Wv+cy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F5860A2600;
	Thu, 12 Nov 2026 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kr8Wv+cy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794504477;
	b=FZbc2YwOUeboXnh7olht+76KxlT5tAQ58DXzqPUCUWDcI5MJaIN8QRwbce6zU04iIl10
	 J/pZ0X0wfrigFgbisr1Wl+Fh3+7/EmGG7Vy6oIQ5nBTCPTvGYgqb9ZvwI053bXSjyOKf9
	 1xL/L50uedYTVtn2wETqZ+gMWQ4q4qvf8TcWZ2/GtoqT/DfEwYek36QHv4Ffn/w3nt3z/
	 Xzb/6cgWkT280PL/YcR6x08MH4JLXdqEUcOvv8QzvdlNASUraC4tme5dbLb0Tre7Sn5iV
	 UfuZkordU8sWuBxHMRVoGlWGdgw9SS/ewkOJz8kNBSrqIKxILXVckiQ43my3MkbInjA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794504477;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6NxaIFuj5GbBs4gkgvfwhinm5enDeC875ssfNTLlQX8=;
	b=rCOGsQd56zNpLjbMsuyoIXjI41XkXqxukyYK3c+L1ywYJz2wzDXzM1zD3Fb88+5o28ef
	 zZ/8Y6AmjnwbyMOW2deIEETtRrIFAgg6i5/5H1GpLR+C6R7VlEU4V4BahhS1Lahn3vrRS
	 OvmkXXo/ESV9BaISjjZcmJhUZNK7pOWZgb7sZTj4g4ghLDM/Gzlxzsf+0atgMdzCfA0BY
	 2VmZkaHKyf/NL4eK7a7uP0xPWXMkEJD3ZcchsXCh4MYbNwYT2SSWMPBUIP8obeyBPxyug
	 uLQh/umnCrTjjJXn/L3lC4nf32RrCWqInTrJNQk8I2jt5lTttDqqCXPGbrM9PvZLkow==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E2BFB1F000C8;
	Thu, 12 Nov 2026 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504477;
	bh=6NxaIFuj5GbBs4gkgvfwhinm5enDeC875ssfNTLlQX8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kr8Wv+cyiwzN7t8GmpdGN/urE0UFjkd+OZ0fdBbqpr+tjGDQ5NpuSxtR+Vo7Q4eNs
	 gjt5sS45ye4qc3FWrm3r5s1I/FZJy1ucSMgA8b4M34A/f0Iqf5F4o+D8vmOpsD7s4L
	 hsoh305Q+eptmUixjQZ7kNGBWISdHBRQTfB+4zT2zIn8iwmmcAkQuGYOcrO/hBxITi
	 l8h/yyBDEQLV1rEajC6i1fQ2dQ/wSCwuPPZAnlVFS9WGoNporx9BFV0jB/+Yk0P6h6
	 Bt3nRtVXL4k4BFOGpjefIsfr/duU5PkE9d7v3dXegFDtVLn8UnGaD+hLZtlRufl8J4
	 delv5hM7I7IZw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 56DCF45A86;
	Thu, 12 Nov 2026 17:27:55 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 17:27:55 +0000
Subject: [PATCH v3 1/4] can: kvaser_usb: hydra: reject commands shorter
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
Message-Id: <20261112-kvaser-usb-validate-v3-1-61587f639508@gmail.com>
References: <20261112-kvaser-usb-validate-v3-0-61587f639508@gmail.com>
In-Reply-To: <20261112-kvaser-usb-validate-v3-0-61587f639508@gmail.com>
To: mkl@pengutronix.de, mailhol@kernel.org, joasantonio108@gmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794504474; l=3068;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=2FOyrmwYW2SkcrDKPo4yzypedyTsO5ugueU8GtgBM1k=;
 b=eRQg02qT+BOyyqDv5vYqI3PrpcGWQowocu2/eBfAybgeA42tAUiVo5cbIN94MatRI0dLnw9FU
 59E6hcJCUiaDAHj5P1TtSOJdm+qP+9AQWXRCcax0A9U+dVUrIsqN1lY
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


