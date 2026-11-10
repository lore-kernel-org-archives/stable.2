Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794283004;
	b=eFP6F4gbC28oxrRdWOCvOry9XFt9aARouX0C/CHC0YBOCAH83QXTId45r0nEQFqDID+y
	 xnTaxuwiUspWALaF496QLECLMztaCRVM7yUmLQ7GJo5ogzrCBwGLpUfYJCquAGp8TsNWP
	 CfUemOBeSPRQHAeVL+mr6oHIE/+hVNlRRLFwSg/wud3P/j71UVN3Pz9C0aOgAFicZvkMR
	 CKvFhi9XvTV4rsImoWsG1JDAhfSDJk4+0xwD0TomATc4enbGGqCQiE3wOfPaCeHkuoXvf
	 7ON8bvt1EG0UV0GBmS68xWm1ibkymT7No411v/CFSJhEJO7usXqZP80y+/0nVxqYb5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283004;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=i5sGpWqYVpkBUVvcg2WSc+pyAI26BH5xnR/IRZaX0Sg=;
	b=WsmzL86+glPNYSyuKinJBbR+Rr7O0Ts4VK4EHdFgGjqO7ZC7TRwtyGF3unbbCEePfX60
	 QOp64UszexIaarYPj7RYq11mxWMGbMbHKZRPNjXUrN62qenpkj5zqyko8DAEP1s4QbAYX
	 PerRIEUhw3nY3HqOFE/QXCCCGQaDd9YZtmjDcsIwisrKvVZMOtSL+tjz2luH5+uY6cOWO
	 WQ+hVBUImDIOlj+GKBrVueSTucXSu9EAuUqapSnic3oPv4MENwvTSY/fmOF2TOhQtYmir
	 jbIrf/xeMUJJqz5ItbgwENhhci8UmQSzgeaF9DjRUCLLI7yfNMEPzZBN6lZtetnesrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmN17FFs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F0060A260E;
	Tue, 10 Nov 2026 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmN17FFs
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794283003;
	b=zvoDGuMouaZN6HXJ8FeO2QdRGspWVogCNypMSiQ3VCSWMFpiv2wH8fSIZTnVGzQrEfyy
	 hES0afh3n+Ny0kQhFROI14hA1QgT7vHPqg4Jna3OtUQgUeUP6OIkFqZld5+PLeBI4ARQC
	 hb5D371SpJ40FBB4wNh6ruWVQy5RWj2UZwCizQul84XsR/bkrskJ/HIWvhI7KnCLpOvX/
	 HoAuNh98/xb0rVX2KiESCjNQgVYktjULy5KEcoNW3W3GKYK45kT3UV9Hhb6N9k+wjrKFe
	 7bN1aaEH3PsYHUQtEH+Ixd35FxpxkwhzrIIMxTFASoyf4AD8yv6PWY0f9STXetuE2wg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794283003;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=i5sGpWqYVpkBUVvcg2WSc+pyAI26BH5xnR/IRZaX0Sg=;
	b=vKlWz5nVc0+m2iQKAwHEOqhhBwNiF7SctmdlT7vm2xIQ4wSmlKw07xUINItOq6AOXgYw
	 aHjTFbJ5iGK9tOG93Js4GdUUoGF0XB3gIDydjNtz1rYCMRNWPg0uXjpKJ/T5qxQAZJKfN
	 cB+xtJHPkWSssH00025o4lTjr/YHPLTGyzsyBSSkC1stB1HbQ+YPZvBjPD2X8Ck3fTPdS
	 XAMGDOiQP59MYty/1bDJQrN2MJ6UGaxSnfyN0h5lfqfJrGO+vDLU3haIn8tUhC1inblxW
	 1fWR5JUVsryyryzLimRZ0RNnExlYFF1SRJvt4F9kWGbVH8yCWMVo91wnliafQyq8AFA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 962201F008A6;
	Tue, 10 Nov 2026 03:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283003;
	bh=i5sGpWqYVpkBUVvcg2WSc+pyAI26BH5xnR/IRZaX0Sg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DmN17FFsrw9xYVRrPVX+JE6wUyyV1gGSlVDBBjZy69oy1n2Lk+3xdLVNqWfzc8dJ4
	 VmxVmZDD8iGhaKzqnf2WABH7fq1yQYgu5fQBX66KOZ0e0wSpclxbd3g7QDkbxBd5AI
	 XLAP6DzuDyVjpbHq7z3s6gcUVaktV5D1mbWkTe3S8dtCupmhHbgcebef/nqO5Qnj7h
	 gA+G07PdCxjPIgxsr6GOhEd5kGQEj+IR8qs2D6hg8N/5TDwuWPGsGmhCqh1R6Wk63a
	 CYyhdCpCMJpFxFOcEh6V0vwDL9zBlImtHF9EdDeKYrJajrSXaHVGXvTyIxq/OA5f7b
	 kPR7HNQxak6lg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 24236487F0;
	Tue, 10 Nov 2026 03:56:42 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 03:56:42 +0000
Subject: [PATCH 1/2] can: kvaser_usb: hydra: reject commands shorter than
 the header
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
Message-Id: <20261110-kvaser-usb-validate-v1-1-f266b85aa908@gmail.com>
References: <20261110-kvaser-usb-validate-v1-0-f266b85aa908@gmail.com>
In-Reply-To: <20261110-kvaser-usb-validate-v1-0-f266b85aa908@gmail.com>
To: mkl@pengutronix.de, mailhol@kernel.org, joasantonio108@gmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794283001; l=2462;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=WQBZhSAEzA9EWg/6IUMTZ+5l64+D6iO6t2jMkcYHrcE=;
 b=ng14H4NFwqtau2GbY5NiuCX/iT5hnlpAX9ifCs98whCYgnYAJrWT+AIcUZy8C0/5A0YRDe1L9
 x10OoQtrEG/Bjci/MEbYlRuOCwcE4MDTnf9z9/2p/DRznsU4WRBih4H
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

A command can never be shorter than its header, so treat a shorter
length as a format error in both parsers.

A similar infinite loop in the leaf command parsers was fixed in
commit 0c73772cd2b8 ("can: kvaser_usb: leaf: Fix potential infinite loop in command parsers").

Found by LLM-assisted source review.

Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 687911d764de..92bfdcb04b01 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -676,7 +676,8 @@ static int kvaser_usb_hydra_wait_cmd(const struct kvaser_usb *dev, u8 cmd_no,
 
 			tmp_cmd = buf + pos;
 			cmd_len = kvaser_usb_hydra_cmd_size(tmp_cmd);
-			if (pos + cmd_len > actual_len) {
+			if (cmd_len < sizeof(struct kvaser_cmd_header) ||
+			    pos + cmd_len > actual_len) {
 				dev_err_ratelimited(&dev->intf->dev,
 						    "Format error\n");
 				break;
@@ -2156,6 +2157,11 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 
 		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
 
+		if (cmd_len < sizeof(struct kvaser_cmd_header)) {
+			dev_err(&dev->intf->dev, "Format error\n");
+			return;
+		}
+
 		if (pos + cmd_len > len) {
 			/* We got first part of a command */
 			int leftover_bytes;

-- 
2.43.0


