Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.203.187.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838960;
	b=uUtRWJqZ3A8Hjq1s1Kd3VmEMwyH3gPrzsBfNdIrwt7HwgfUV8uTcqOMsI26TJEr5J9eY
	 XvZY6K4wW6c2yoQYFKBUbdbKp9O3ebCVOqMVG7dxTDgStW7aCqn2W4IQYNuKREZeET0PK
	 t8HLCixp6Y6z9r/OkQYVbQBXb08NJd+cJhI3+EJQrPtlNrfVzZq8U5ah+YG7X2WzB84mC
	 V0Uf/OuEJXzDbj4dThpjBt9WSHm2lsyoqB1zRktV3b157JNCJ/uKzJBE0Dr8z1P+KNKyc
	 dxIvvl1HqDci5WQYNH4M3hnNOAS6dj9vgTrBNN1TpfLEGBmFY2kYzIWwamIOt+4+LhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838960;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Classification-ID;
	bh=a9+21ydc3B9xSsdzROeSzxwQIQB9WozdWox79Eaw03U=;
	b=FOmat+83nzjN6kZoRUiq+I7hQr+BhatLFXy6paJyYswLJqYz8+BY10Nr9IdlZMFv83f9
	 mmHxMFEGYATNIlhtVRTl5Y7HYvRCgFjLT5nw1teRfEXbkHvx81P5Hk71S9qY2wjmX+Jfc
	 FadzbRpKl4zrytmqaxwhm0nffFK4GJV84Ccx0nCnIqOrsuR5aedjgivJcFch4ol3/mefB
	 VcRgHE4pochjeMezOgcvrwq17o94lekWz6fEuyE7hpI203uACJ+qvBLmWuAimMFi/aMGx
	 u8iiQ2EaIYQP+h2JeQMGOJ/akoTyTz2Dr/QmbIa3z9qE6HhuPuohZjLD+alWAnue8KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=d6Hq8AxB;
	arc=none smtp.remote-ip=173.203.187.111
Received: from smtp111.iad3a.emailsrvr.com (smtp111.iad3a.emailsrvr.com [173.203.187.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08DB606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B08DB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=d6Hq8AxB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1794838953;
	bh=rtMWaOtvn8EzMxI8ZmUVCKQpZdYinBStkSBmJB1XZ+Q=;
	h=From:To:Subject:Date:From;
	b=d6Hq8AxB2vp8dFTkM8ph11OIfndir6PiDL+APxSACoF418dUWugY3fRVEbIeJpRCN
	 fklLm7TCBPOBRzZiV/q8zJwUzqway3JBkCZ0+gi/0bMiNF88o5GzXZ0ybO/Hn3a72E
	 kEEI5Dq8lPpiEo71+pC4U7SPP/AtvRvNO6rqYyts=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp30.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id D1CEE42D2;
	Mon, 16 Nov 2026 09:22:32 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	syzbot+a4cedab706d0a8a3f988@syzkaller.appspotmail.com,
	Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18.y] comedi: dt2811: fix shift-out-of-bounds in IRQ check
Date: Mon, 16 Nov 2026 14:22:11 +0000
Message-ID: <20261116142225.113461-1-abbotti@mev.co.uk>
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
X-Classification-ID: efaaf5d0-90ad-45f7-bdee-76033403302d-1-1

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
index c2ec5e4fb689..c422317ef139 100644
--- a/drivers/comedi/drivers/dt2811.c
+++ b/drivers/comedi/drivers/dt2811.c
@@ -566,7 +566,7 @@ static int dt2811_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	dt2811_reset(dev);
 
 	/* IRQ's 2,3,5,7 are valid for async command support */
-	if (it->options[1] <= 7  && (BIT(it->options[1]) & 0xac)) {
+	if (it->options[1] >= 0 && it->options[1] <= 7 && (BIT(it->options[1]) & 0xac)) {
 		ret = request_irq(it->options[1], dt2811_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0)
-- 
2.53.0

