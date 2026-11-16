Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.203.187.115
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839532;
	b=XWDhkHHj2OyeeuKHoG0CCaijwXdRmkpTn7H6MUK6KvNACgDbmRmaIETqCqN0Jb9Kyn6H
	 DlnVMqcAzE8o7qgMNquuO4suEJjK+A24PNJh8Cq+J/tlFppGCVlVK8zkJr8Ub2aEgT2e5
	 yLX/B04KDpxvke6aQ+M6r0/G8CIxS4p+IrPdB1gIIrRkWHh4zs4Hdd7dYVhhEFUPNbJNS
	 Lo3z+Z/yHpK0i6jxxxcbHvuhhuxmi+81FX/ew072cMwdH8wEQLko5Y0TYZMJ71vemwZvg
	 xXPSnBTbRLPfrPcbZYSCT28c28yZp3cvvKB3C227UfTuaYt9qgIhm5MMJoVzosIiQOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839532;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Classification-ID;
	bh=BtgtOzbB0l9pwyzEIO2q09M5Qz2h3fBu0wufeRTzwoc=;
	b=kl9KmE1Y6jfzguD1zagI1Btr5dEa+4P1rl09+QJ+DqPEAQlMJAc91d1hErq6ylZfZQVV
	 JDu5S5a0wY2LrAej7PD8dFV9feRCRY/JhxDvcJAhqdC3VSzczjS8OMsBSBwFT2cEu9sc+
	 XH/m0njFI+ZX7BRocXUMD5hcNB2UpOc8dE479dMr9xwGeEh2dnKDQaeoQ/91th+Gchv9Z
	 eJXJYmLAVnIWZEWonse5ahPRL97Meb3pA7fRcb2hbTJlOVi0hIeMQ/NdJe6b7TQ6/1kLA
	 uaJrd2EnT4sNQuvfD2IFLQ1C2QJ4Hmvl2Hn3nN8oOdNqTddTym/U6DweN1aSniRmOSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=tqSXlDnU;
	arc=none smtp.remote-ip=173.203.187.115
Received: from smtp115.iad3a.emailsrvr.com (smtp115.iad3a.emailsrvr.com [173.203.187.115])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06689606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06689606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=tqSXlDnU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1794839525;
	bh=aYArWBQ1pAOF/v3HbifxrESRLRxUFpthqsJ5QNSbvQY=;
	h=From:To:Subject:Date:From;
	b=tqSXlDnU1J36hV+YBYqaCKu6EX/bxMzbT/IQD1rBaTh77c646NGzzB82gIACGK11B
	 oo04u6PkEmCE0Xh93HGxXWT+ILtjPVfxF4JfQytHAlytTy9OIdmhoPUf3ZPh2QG0X8
	 ytv7q/3qsFlpl8W6Cn5qO5girJB4cK+LtoRS8GqA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp39.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 17E955940;
	Mon, 16 Nov 2026 09:32:05 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	syzbot+a4cedab706d0a8a3f988@syzkaller.appspotmail.com,
	Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1.y] comedi: dt2811: fix shift-out-of-bounds in IRQ check
Date: Mon, 16 Nov 2026 14:31:49 +0000
Message-ID: <20261116143157.115090-1-abbotti@mev.co.uk>
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
X-Classification-ID: 00d20541-dea4-4f59-a216-d3d960992f7c-1-1

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

