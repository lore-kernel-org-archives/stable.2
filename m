Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.203.187.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838779;
	b=vf2Qdi2Af6/QAEVPg3H+807J4+J1Ipss1bV2GHMJCVzSAHqIdFFf0r9C4x09HiTh79Lr
	 Xy0mUltFD3zfepVi5DeiKhQUFMva8cR04YIPyey3oJyMRcs2ckcud88c+d7KVsADUTj+b
	 t+1BTRoR95kab06nk6jerPTY1a3MsHhw+0GTb7FOIPjkLngajPnaO08OiyzsZ7w+/DJnk
	 +zay3KEbJOR29DSCQ4aw77MKZfMXqXH7hmJNnLlj7keYI0dvv61mn+cpFXeHv4Clp/Nvh
	 +1EciHRWrmDxXhbVjb8uq6Hkmxv6SzmO/RpiBE5fjQ33Nguzuzo5Ro2U/UM/DQ40p1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838779;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Classification-ID;
	bh=OqN1DOAMuLQ9+9GOzq0fUU7KVDMi+b8LxbPVnWHn8wM=;
	b=FRfqHVAGBoMIws4SYkR511iPVSAAH5Ylxbf4vCe0DyHMvPSGFANV7c3fEG1P8mG+dF5s
	 zlYX1JGi0aRdN5vKPTI089tueVZkQdl88KDmixeKT/aaOUpyMxjacbAM6EpK9HzcEhVWZ
	 T3/cgdWvEUYyiqKLF7Qnd1uASh3B13FFi7t7t3d5hmwOhkC6DV1Q6nPVEKfrN47NoLSJV
	 Yy/TJa6l07TG/psoUKEkGNyb8TPKaUR1I0ZyL5oaFSJiUKcJMgw88nldee+OlG6qdZTfw
	 r+RabK8L3BnwJ1tdyuoa5e5Y2LHMt2UyF4FTo4I2WzxR9v3B8YuxwIfy8QexMDa/mXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=fTaPHzzH;
	arc=none smtp.remote-ip=173.203.187.72
Received: from smtp72.iad3a.emailsrvr.com (smtp72.iad3a.emailsrvr.com [173.203.187.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1902606A331
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1902606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=fTaPHzzH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1794838771;
	bh=/Mn2I+Cn2UjhsYhz+k9MZr2YV9us0+ffGx459V0Dj9M=;
	h=From:To:Subject:Date:From;
	b=fTaPHzzHqvG/6b7o8alwEZCzVy5b3jnPpCEdlA9cjZ2MopuM0sSRrIid3MWlsIQFi
	 paA30kSL+s3Iso/K+z/mx831K9R1ujpj0M2fwO4Mgsllki+jJVat4z+V4+Eg/1iudy
	 ihHEzcaad/kWpIJ634oetIPrDfdsW7L+XB6cprfA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp10.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 097C56348;
	Mon, 16 Nov 2026 09:19:30 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	syzbot+a4cedab706d0a8a3f988@syzkaller.appspotmail.com,
	Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7.3.y] comedi: dt2811: fix shift-out-of-bounds in IRQ check
Date: Mon, 16 Nov 2026 14:19:13 +0000
Message-ID: <20261116141922.113138-1-abbotti@mev.co.uk>
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
X-Classification-ID: 800804f7-6982-484f-aaf2-b3ff9e6b760e-1-1

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
index 0438b8c90e44..53cb17993ae7 100644
--- a/drivers/comedi/drivers/dt2811.c
+++ b/drivers/comedi/drivers/dt2811.c
@@ -567,7 +567,7 @@ static int dt2811_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	dt2811_reset(dev);
 
 	/* IRQ's 2,3,5,7 are valid for async command support */
-	if (it->options[1] <= 7  && (BIT(it->options[1]) & 0xac)) {
+	if (it->options[1] >= 0 && it->options[1] <= 7 && (BIT(it->options[1]) & 0xac)) {
 		ret = request_irq(it->options[1], dt2811_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0)
-- 
2.53.0

