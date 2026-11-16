Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=184.106.54.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839703;
	b=LT7rBCkFHFquo5jkfGxuGFQfrB68rhAzGODvkkJoajQbCFRQD5Isnkyu7OGlJGivO9Db
	 eBQgQS+JgFAibds8NKMECLubYf8b7dysoOwgtdlSqIaV6pvEZ68DUDu65q6IL0T89nZWq
	 HpVWhTLE6/bEikODKDF01i4i0N+dxRy4HxLgXZwTmCM1Y+6e7YYWWG/3LqjYskrOtQp4m
	 Yv1t7Qbqc7aAgwL1dFZbQWQpNXdRWeQBNNWlgqIk3wAtixfaFkeveW36gFbBXa5+SpbL8
	 Y9yfaUgOdiaZRAAI2ZblQy3W1la6rCn2tanjponaTg88c4e8o3Wg0HlcZNtnMFiioOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839703;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Classification-ID;
	bh=FB8PoxlB3pJztD1ooud7Vig2Sd3L2qeIF+Tki+fKhkE=;
	b=biwR5JvELoTTerxGeq9AhSjIJH4Gh90iuROriEE3VTTciiePntDIv4/jsA6cQxcobeQq
	 j8kQ18E2asIDy5zXTMBMw3amIRLDM1abMMyjpNdWFC8ZVFlbHC+AUnI7ysWdLnfdN0RDw
	 si7AF/qZhsHhdvfakFYQxXo/UlYDNAPHbv9jvAkweXcPS6+Tw/2B7g0klDYI5UWR9ukRQ
	 +ntoja8BrvNcExKt3TB7EWVEFGVpHKYIVMq3zWkGHV09Jg2NTbHZGXacVO1JLlI3MDMLH
	 Yku1Q/s6O9Dvxo9SY+wu2JcfaHQSLvh3EK6u+dcQF4gmZBozFCIYTDc2TVkFAD/X2xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=WqyNR4mm;
	arc=none smtp.remote-ip=184.106.54.122
Received: from smtp122.ord1d.emailsrvr.com (smtp122.ord1d.emailsrvr.com [184.106.54.122])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C577606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C577606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=WqyNR4mm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1794839702;
	bh=Jj42YZgF+IDY0REQ6okrz/4FTGOhWUN74pIyJcWhK68=;
	h=From:To:Subject:Date:From;
	b=WqyNR4mmSjl0tSKCegAESXl5YEqCQ02UU/T8YQmHnwZpzYwLl+3y53Vy8HYJrm0o+
	 ic2oBuj355sZeSyuhwUBcINXWdRPBygxAxh5oamXO53TgMS1mrrjpmhxj06BwOk2qT
	 1xenmgA3OJwIvBwMctrXqfFz7YG+uhFl4zSDyJn8=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp8.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 8A6B8C024F;
	Mon, 16 Nov 2026 09:35:01 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	syzbot+a4cedab706d0a8a3f988@syzkaller.appspotmail.com,
	Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: dt2811: fix shift-out-of-bounds in IRQ check
Date: Mon, 16 Nov 2026 14:34:37 +0000
Message-ID: <20261116143451.115557-1-abbotti@mev.co.uk>
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
Content-Transfer-Encoding: 8bit
X-Classification-ID: 5e85b5c2-a2b5-4719-abcd-6cc4906774d4-1-1

From: Pei Xiao <xiaopei01@kylinos.cn>

[ Upstream commit 471ce96a9c415b8a67bd5081ac2089a458cacc2f ]

The IRQ number passed via comedi_devconfig->options[1] is a signed int
that comes from userspace.  The check `it->options[1] <= 7` does not
reject negative values, so a negative IRQ number reaches
`BIT(it->options[1])`, which is undefined behavior and triggers a UBSAN
shift-out-of-bounds warning:

  UBSAN: shift-out-of-bounds in drivers/comedi/drivers/dt2811.c:570:31
  shift exponent -251 is negative

Add an explicit lower bound check (`it->options[1] >= 0`) so that only
valid IRQ numbers 0..7 are accepted before the shift.

Fixes: f2975a9b2ab9 ("staging: comedi: dt2811: add async command support for AI subdevice")
Reported-by: syzbot+a4cedab706d0a8a3f988@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6ab21240.e548f532.1ca396.0018.GAE@google.com/#R
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Tested-by: syzbot+a4cedab706d0a8a3f988@syzkaller.appspotmail.com
Link: https://patch.msgid.link/02c46315293a26169d2a3862a2047959a1651ef4.1790061387.git.xiaopei01@kylinos.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/staging/comedi/drivers/dt2811.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/dt2811.c b/drivers/staging/comedi/drivers/dt2811.c
index 0eb5e6ba6916..68716c3b8d94 100644
--- a/drivers/staging/comedi/drivers/dt2811.c
+++ b/drivers/staging/comedi/drivers/dt2811.c
@@ -564,7 +564,7 @@ static int dt2811_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	dt2811_reset(dev);
 
 	/* IRQ's 2,3,5,7 are valid for async command support */
-	if (it->options[1] <= 7  && (BIT(it->options[1]) & 0xac)) {
+	if (it->options[1] >= 0 && it->options[1] <= 7 && (BIT(it->options[1]) & 0xac)) {
 		ret = request_irq(it->options[1], dt2811_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0)
-- 
2.53.0

