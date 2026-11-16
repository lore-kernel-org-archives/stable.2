Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=184.106.54.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839590;
	b=GTzRE+9Bt9vZwL87qp1bOvKh+xug6eIJA81ubklLHqEn13zH13VSYw5PXFoH4msVBCfk
	 q33MmT/AJT0kG6+PUiZlX7kN/31PcT/WKTRQpCBmJ4WwvRJj7FcbdTHRFqEXdSESzq7uj
	 OIlO59bVczzGevULJ3ErdRI0gJOifUy8NLICUuTHviSdxn2Dn70U26/Np8BHRFz2cA+tY
	 qjXUa8q7AXYhIxIkUAf8I6cgtfZaKx/cBJL7OcH7N6VGS/GPJ5eRb6875Z5RNxuIelIG0
	 DrrLlRUrdCbqm+vg9HLCfLTQgNxiqa0W6EsH0WjO4YDNanjB6egwDw3EebP8h9rhzwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839590;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Classification-ID;
	bh=na+52K5Vw3QuTveZpUPzhnaKQFwpkpbuQ7pSOrZ1flE=;
	b=4ji0woTmsN1PAbUBlp3ElpU/GlSEpDEFIqYzhG44F1GMUsZgG/pWDXrtD2GR2atbWOxl
	 3omzK54o+K/lx8BROTm8NZ6q3u9LLz8WDxsule5TmWngIFSS2Z5Gh4OP2AYUGAy9G/J95
	 nw2hOEiXd8ErHqkCpBkcN98QlOacGdgACOLLLpwFZaLq88AlPeU7Zz29Haz/Npv7ORZLC
	 1mUjEju0RWt1i9wdkOZKwF9CpP4JSfHs8ARoaeohDqcck3H+wueUzMXpcEQTB0jikBx+3
	 RTlo9EjQu6+S1vid3yEy1PdDV4LS+GLV5ofYI1sRCItwy704EVLrrC8GyIXDXsTCLMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=jW7SDqyl;
	arc=none smtp.remote-ip=184.106.54.124
Received: from smtp124.ord1d.emailsrvr.com (smtp124.ord1d.emailsrvr.com [184.106.54.124])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1817606A334
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1817606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=jW7SDqyl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1794839583;
	bh=rAmEbSy8GgqfuxJ7C9oFCZjW5c+Bb85rqk1J7MQhaXw=;
	h=From:To:Subject:Date:From;
	b=jW7SDqylbASYQeeMyz/5721OgHeeEf/afbrS6XZmugGX6VpvrDCE3qgOOaqxppy5l
	 KbXSRudo8Q9ksDZY9kKhd114OSuv4NsUQEqkL5N5tnH5DpFLzMAfE992NnbFmV05j0
	 7pzmaW4HXGi+ZsoTVrodmn3Gc9r22YOfeFdtGnQA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp24.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id CA46DA0246;
	Mon, 16 Nov 2026 09:33:02 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	syzbot+a4cedab706d0a8a3f988@syzkaller.appspotmail.com,
	Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15.y] comedi: dt2811: fix shift-out-of-bounds in IRQ check
Date: Mon, 16 Nov 2026 14:32:45 +0000
Message-ID: <20261116143254.115307-1-abbotti@mev.co.uk>
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
X-Classification-ID: ec0a2cd4-9251-483f-89b2-b14764c7b2de-1-1

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
 drivers/comedi/drivers/dt2811.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/dt2811.c b/drivers/comedi/drivers/dt2811.c
index 0eb5e6ba6916..68716c3b8d94 100644
--- a/drivers/comedi/drivers/dt2811.c
+++ b/drivers/comedi/drivers/dt2811.c
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

