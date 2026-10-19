Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB874F55B6;
	Mon, 19 Oct 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413378; cv=none; b=k1cbE8gI6N+NaRBaHagAlP2WDPO3d2YSzn5BwuKrOKXWb0E1vlyVjLhGvl9GDn7VB5UEKQ8EAxxP+hMlU9YMw7FSGuNwrXyP4k6iTrHoNIrHPz+tVnFoMyUI0f7l6BPShWHqdt+auQ2EeOb4IIJgYX2eQluysCIvE/GpjK37iJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413378; c=relaxed/simple;
	bh=4UTjjMi+QFQ3ovjs60yqB/MRkxMf8om27tu1gAwwj4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=crRtlEkx2ftiw9uK48f52aKq4ClG9jim9hkCRrcD7Zyjt+rj5liOkojBkiFCi/JFo2F/q+AdlozgdAgx3vhiE/9b0+3prFIYJY3igS8SWKDeeEJDcCpdyQ34kKtMkLD4OOmRtNcrMNa7b6rNOC+kUX3JriFmtyvIDWEt95r5HkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBy50iAB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBy50iAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877BD1F000C4;
	Mon, 19 Oct 2026 12:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792413360;
	bh=d2V9bTKLP+pGrBO8HsBaQ6DWUHGdnb3zJyTrpo3zm04=;
	h=From:To:Cc:Subject:Date;
	b=VBy50iABV7mcayZYeOLa0kxobjAZKFKtI8WBhwSuDBc6lyDDfp1ab+uctLWkXhOSp
	 i6CJE3AbjWw4PSo9vuIZNgqKIKSY9HHej8WVQ3QgGXZ2SII0MHrLLptdzFJ9ys6/Cw
	 VzAzjVVtS8eB2+lfzVJILLiLJhZxeDr2C4Ts/7+eqZzT3G+XBNuJeOA4VR2xFejF+E
	 7WH/J1owKd1RxthKGXZBsAsSSvCgwbC9NfSES5i5POETn6W40Bg02nFxwHLLoGvhlY
	 JpmnOZby+4PS3F30UyZrqIEH9fvj10LpU4VMpybvJgDeyBBAOKFSHPamKWLcE8QRar
	 BWZ4opyOwDYFQ==
From: Andi Shyti <andi.shyti@kernel.org>
To: linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	stable@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Antti Palosaari <crope@iki.fi>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH] media: dvb-usb-v2: ec168: Reject zero-length I2C reads
Date: Mon, 19 Oct 2026 14:35:42 +0200
Message-ID: <20261019123542.4040472-1-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ec168_i2c_xfer() checks the length of the register-address
message in a combined demodulator read, but does not validate the
read message length. Userspace can supply a zero-length read
through I2C_RDWR.

This reaches ec168_ctrl_msg(), which selects an IN control pipe
for READ_DEMOD with wLength set to zero. The USB core treats
control requests without a data stage as OUT(*), triggering the
"BOGUS control dir" warning in usb_submit_urb().

Reject zero-length read messages with -EOPNOTSUPP before issuing
the USB request, using the existing exit path to release the I2C
mutex.

(*) is_out = ... || !setup->wLength;

Fixes: 2bf290be4f3e ("V4L/DVB (13364): ec168: add new driver for E3C EC168 DVB USB")
Reported-by: syzbot+ed3ada41c4eb1c4ab78e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ed3ada41c4eb1c4ab78e
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Cc: <stable@vger.kernel.org> # v2.6.33+
---
 drivers/media/usb/dvb-usb-v2/ec168.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/ec168.c b/drivers/media/usb/dvb-usb-v2/ec168.c
index 973b32356b17..f6b98c7d3704 100644
--- a/drivers/media/usb/dvb-usb-v2/ec168.c
+++ b/drivers/media/usb/dvb-usb-v2/ec168.c
@@ -115,7 +115,7 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 	while (i < num) {
 		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
 			if (msg[i].addr == ec168_ec100_config.demod_address) {
-				if (msg[i].len < 1) {
+				if (msg[i].len < 1 || msg[i+1].len < 1) {
 					i = -EOPNOTSUPP;
 					break;
 				}
-- 
2.55.0
