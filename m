Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.203.187.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839467;
	b=UGwHVDi7M6e5hSmxli7Crf9uEkPdyobS0Q+PpC7m6ewZC+/MG+x/RG10UDdvZEaPplsN
	 TOBRrrn6DoLlDBcWorLUwtGFTah7ZvQ+snBO8X0R8kY9mC7B9y2/j9nsleZQM/2jrlPkh
	 f2CDUkANHktv86gppT53Gy1nIGR0e5rgPNTZYcEEVspkVVHWBBD+WIoImbPA8rhYgLEGI
	 ZWELZyVA0sszd/+RzAXOwWe6c/jvqIiaB6Nlz5azUjTXHv6wWk7l9xPLtT8ADUA+sPayt
	 7EjCG/XbnbOKLiXHR5JvdVYRqCzIsvmFhoIn5+/SG9ImCrcLSOtMHA1sXBCTXMWymxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839467;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Classification-ID;
	bh=BtgtOzbB0l9pwyzEIO2q09M5Qz2h3fBu0wufeRTzwoc=;
	b=CLNZk14Qwqoi1riJZRD3SlW0LEAQ8GDoGvOkFb4mZqq9Z1SX+fhI4CUvTCOqBTYJUq6m
	 iECnw7OHvB4PtSq+k0dOALgodnakXr0DP+nmkKhHvj9CFGBvDcsGhGLD4NL5lwVM0weS6
	 8b6qyKCxt8+j9Lpn1JOHbfq0TtnCYn2R+aKDBVXBSW0TZ4T24lHKgkVK1q/FzBBZm94Fp
	 9VTp8sm1GtxdoG9dFk2MyicxoH3+BE9NpG0DPxLMDRae3jVUCFZL75zfD1GvTcmSE0hzU
	 c/gnvDdoCHvW318NGZavv+fi27phnM8kLKpRjHtFOu9c9igAV0k/ePj+L+1PZN6tZ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=Yjgg5Pbj;
	arc=none smtp.remote-ip=173.203.187.70
Received: from smtp70.iad3a.emailsrvr.com (smtp70.iad3a.emailsrvr.com [173.203.187.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F51606A335
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5F51606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=Yjgg5Pbj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1794839459;
	bh=aYArWBQ1pAOF/v3HbifxrESRLRxUFpthqsJ5QNSbvQY=;
	h=From:To:Subject:Date:From;
	b=Yjgg5Pbjf/aPhXM2HWP9tJMWlgk/0E41dn6McRpQAK8SyLC150oT1S+TWYRL8KEaG
	 kN5bwrmXGR7P9dEG1axWDh8gOMk66UpG2/YkBedFnfBgv6BNJJTldr83NM4GSsXdX6
	 pqCQiS161FtsmLyoQTmM1lCrjWmzj7mEvyUBX/Gw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp25.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 83191252A0;
	Mon, 16 Nov 2026 09:30:58 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	syzbot+a4cedab706d0a8a3f988@syzkaller.appspotmail.com,
	Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6.y] comedi: dt2811: fix shift-out-of-bounds in IRQ check
Date: Mon, 16 Nov 2026 14:30:42 +0000
Message-ID: <20261116143050.114869-1-abbotti@mev.co.uk>
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
X-Classification-ID: a35c00ca-d7bc-4258-91f9-b64356d0a7ed-1-1

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
index dbb9f38da289..01ff86ec5473 100644
--- a/drivers/comedi/drivers/dt2811.c
+++ b/drivers/comedi/drivers/dt2811.c
@@ -563,7 +563,7 @@ static int dt2811_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	dt2811_reset(dev);
 
 	/* IRQ's 2,3,5,7 are valid for async command support */
-	if (it->options[1] <= 7  && (BIT(it->options[1]) & 0xac)) {
+	if (it->options[1] >= 0 && it->options[1] <= 7 && (BIT(it->options[1]) & 0xac)) {
 		ret = request_irq(it->options[1], dt2811_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0)
-- 
2.53.0

