Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2FB490BED;
	Fri, 14 Aug 2026 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730790; cv=pass; b=Hn4MCDNKV45eUk7RJqDq1UlukGM8HsfzMCnO7MPpaT+HQocOoI6ZiGIQOlqd981L31y4KCOFgitSGaSWzLvAAkvOLSHBBoVzaqqhSv1LD/vls8AkSoAHNHg+Q5xCUYsO5qYO9i6g6VDZ/rRVc/1zTv93K5QB2ZLQ5CGOO04b0Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730790; c=relaxed/simple;
	bh=UMRJVZtJoMbK+QZv2LANLq1EMht5ioB8A4kmk8r8GUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OgYeTvkJF9jAEX9w8PA0O6hoTKL5d5fZ/icKtHP08aruVhHr5TCl3fe7iEBCbCc/QLFLnt55pIrsP3Qz8NUf4f06+CPPUlGwT8hhvCuZ25KA34S4OYsbY5S12uuZv8m1ky+SaY5YdUsxgPRkGrGSUNdDr8jIPIqT2vZ2Wjh8fEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikuyo.dev; spf=pass smtp.mailfrom=ikuyo.dev; dkim=pass (1024-bit key) header.d=ikuyo.dev header.i=eritque-arcus@ikuyo.dev header.b=x6ybNpgh; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ikuyo.dev header.i=eritque-arcus@ikuyo.dev header.b="x6ybNpgh"
ARC-Seal: i=1; a=rsa-sha256; t=1786730774; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Jx9EN//9Ney4NBz2XZUbto04e+IMDErGZ/RVhSQPWKb/GJJQal8LlzQvqG9ieFOaps+nSMakwbiKfZ3Hfj9MFLWr2yHHzYxQjJ4EM3a7UGsSJM9QrXLecDaFAAo0WHeyzBEXe/XUe7omSRw4eJ09oEIfE7b6ZiznaffHFK8MdWA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786730774; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=22kjejwY/pLLHVHpk/sXoxIreYEguRcnZytWbpPx2bI=; 
	b=cJVTrYG3smNOLXKSEcVvhKzDxW+KKg70Y8yXzGv0bhr7WAi8e8Al6NKi/m72JNpwmlO9900/ZSZeP6cNJQYRZcAnCjeqEIDMDtXDOCpDRSr1iKGYn35Zy2IvS+WhBL3/DAqZkOsnUA8WkjLiCWdQ2DbmQxd+kjcol8GqT40DRzo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ikuyo.dev;
	spf=pass  smtp.mailfrom=eritque-arcus@ikuyo.dev;
	dmarc=pass header.from=<eritque-arcus@ikuyo.dev>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786730774;
	s=zmail; d=ikuyo.dev; i=eritque-arcus@ikuyo.dev;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=22kjejwY/pLLHVHpk/sXoxIreYEguRcnZytWbpPx2bI=;
	b=x6ybNpghIR6deReojgJvfMH6o5MHKK7EthKy+qDlVQW76a+BWWYp9RE+XHD7p0su
	oQ00LJDmagVFQeBUh9pDx/LqTK3PPh4vGu14z0PbtTnHITDhXcLNcecioYSh109GaqL
	WvF1gZtGHq35+yuT3xdGV4aXFPC3CR92qofopveM=
Received: by mx.zohomail.com with SMTPS id 1786730773024540.0022960170999;
	Fri, 14 Aug 2026 11:06:13 -0700 (PDT)
From: Yiran Qiu <eritque-arcus@ikuyo.dev>
Date: Sat, 15 Aug 2026 02:05:47 +0800
Subject: [PATCH 2/2] can: kvaser_usb_hydra: reject too-short commands in
 the receive path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-can-esd-hydra-fixes-v1-2-de644cbeaec2@ikuyo.dev>
References: <20260815-can-esd-hydra-fixes-v1-0-de644cbeaec2@ikuyo.dev>
In-Reply-To: <20260815-can-esd-hydra-fixes-v1-0-de644cbeaec2@ikuyo.dev>
To: Frank Jungclaus <frank.jungclaus@esd.eu>, socketcan@esd.eu, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yiran Qiu <eritque-arcus@ikuyo.dev>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2298;
 i=eritque-arcus@ikuyo.dev; h=from:subject:message-id;
 bh=UMRJVZtJoMbK+QZv2LANLq1EMht5ioB8A4kmk8r8GUc=;
 b=owGbwMvMwCW2M2qh3ooTh9cxnlZLYsiqj+RhX5IxqXfu1RWX1xrxXpMKq9LIdO94oqs/+UDlk
 8vOWUx3OkpZGMS4GGTFFFmmG+xYzNluzbbMQCIUZg4rE8gQBi5OAZhI+mFGhuPTRQPOTmapkSoN
 Xa1i3nxu2jHDo3s+nXabl+Uo8r8n4AYjwzVv1bNvi8Vvzbo9+fm046W/j1979tjOS+WJQ+TU+3v
 TAjkA
X-Developer-Key: i=eritque-arcus@ikuyo.dev; a=openpgp;
 fpr=9730B8A309873B06A6301855B95AA12EA8C8C3AE

kvaser_usb_hydra_read_bulk_callback() walks commands out of the RX URB
buffer, using kvaser_usb_hydra_cmd_size() to determine each command's
length. For an extended command (CMD_EXTENDED) that size is taken
directly from the device-supplied 16-bit length field with no lower
bound. A CMD_EXTENDED command whose length is zero makes cmd_size 0, so
"pos += cmd_len" never advances and this URB-completion softirq spins
forever.

Reject a command whose reported size is smaller than the command header
before it is dispatched, mirroring the minimum-length check added in
commit 0293dd153f9d ("can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd():
validate received command extents"); that fix did not touch hydra's
asynchronous read_bulk_callback().

Reproduced with USB_RAW_GADGET + dummy_hcd on a KASAN build: after the
normal probe/START_CHIP handshake, a 6-byte CMD_EXTENDED frame with the
length field set to 0 makes the callback loop print

  kvaser_usb 1-1:1.0: Unhandled extended command (255)

without bound (306000 times in ~75 s), until

  rcu: INFO: rcu_sched detected stalls on CPUs/tasks:

and the machine had to be killed externally.

Fixes: aec5fb2268b5 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Cc: stable@vger.kernel.org
Signed-off-by: Yiran Qiu <eritque-arcus@ikuyo.dev>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index efbb7bed34c9d..d44f9875fbe2f 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -2156,6 +2156,15 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 
 		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
 
+		/* An extended command carries a device-supplied length; a
+		 * command shorter than the command header would never advance
+		 * @pos and would spin this URB-completion softirq forever.
+		 */
+		if (cmd_len < sizeof(struct kvaser_cmd_header)) {
+			dev_err(&dev->intf->dev, "Format error\n");
+			break;
+		}
+
 		if (pos + cmd_len > len) {
 			/* We got first part of a command */
 			int leftover_bytes;

-- 
2.55.0

