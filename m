Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.203.187.82
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838061;
	b=0brsO5x3ywEV/GJIU/ye7GHcAqlrh5fQvlsvnG7F9NPyfLw9HpTG5inAb13tgIGqhjuP
	 BKnBDk6Is9m4oSIpNhLWIZxa75NUaiFeugcz83kLhbnHh4n24IMY4gG4g4EFiIqcUqLtB
	 e+WWXZNyY08RTaaXsMB29qA/1U8ljP0Xn1ld9d7TrP7e9U5JepHX83ydGcHcGUh6zHoz7
	 VbsCHhFKdzm9DkvniCXw8gHAwRDgcu2VQ+bi9e6vUG/vgr3bVNYuLm06Y4AD6GlaFQup5
	 1Ht33/SS06rZcjfipah8olY5hijoiW3a7dqFEXpolWcl2kmhcU2ILZwH7FhcpUJNDgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838061;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Classification-ID;
	bh=Sqz5nWhn454IIGlOISNNIBGkxESBNiDjOU2Raya6pbo=;
	b=lB+fFHjj2q/1rzndNsbdM/9u3ApPQQYQz1cUriq6iKpm3jUE4sQJMzYBL1eEthtp0DFW
	 iN/A1hQHruCPypcujzzj9A05CRkGE17TGrqVHFFZWqTeK6asPGinUHjcdU4AYHm6oMLG9
	 MLeNE2moBqwgfHYy2sB0X7IH4ePTLNSFCk3Sv5gN4EMY8nWOh9p40bp7XBEPc8VmPqscN
	 02GnM2/cw3SA/0GPsYSSOGvVf/oUWuQc+5hwls7uujk/7YaW/OcA8KTTBVBMIo9XEb24V
	 leJPVNR4uIIvsSk3KQ/CjfoZDtSQDwOPfcrwfasIn2DXZbcHHIl497pKZEWOdWZdIuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=cta0liaZ;
	arc=none smtp.remote-ip=173.203.187.82
Received: from smtp82.iad3a.emailsrvr.com (smtp82.iad3a.emailsrvr.com [173.203.187.82])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C770D606A32A
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C770D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=cta0liaZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1794838054;
	bh=INodCqha2zrKSJy1sThgclgxLErJ8pD/Uq9uRR1t+Xk=;
	h=From:To:Subject:Date:From;
	b=cta0liaZLl0sy5qXfuJXEz7Yp1WTVM+Cu3I66ynTSvwlPp/7iMCrrdhWQy/eEE8Hk
	 T1z1i+uwDE0pExN7IybFTx6MByprILPNqf8vAog6z/LLru2D4OhkCT8d2bvkp6Iu4W
	 5/0ctKzmdm84CD2+ZgZe0SbhoHZdo9aS+g+M7H/0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp35.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id DF4C46531;
	Mon, 16 Nov 2026 09:07:33 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Yang Zi <2959243019@qq.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: addi_apci_3xxx: fix subdevice count underallocation
Date: Mon, 16 Nov 2026 14:07:07 +0000
Message-ID: <20261116140723.111674-1-abbotti@mev.co.uk>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Classification-ID: 75bf72f3-b9ff-4c05-9cd2-6d16446f2a7d-1-1

From: Yang Zi <2959243019@qq.com>

[ Upstream commit 3de5aa458dede472a253266d02902bd95af8e849 ]

In apci3xxx_auto_attach(), the number of subdevices is computed with

    n_subdevices = (board->ai_n_chan ? 0 : 1) + board->has_ao + ...

The ternary is inverted: when the board has analog input channels
(ai_n_chan != 0), it counts 0 instead of 1, so the AI subdevice that is
actually created is not accounted for. As a result
comedi_alloc_subdevices() allocates one entry too few, and the later
subdevice initialization (notably the TTL Digital I/O subdevice, which
is populated last) writes past the end of the allocated array, causing a
slab out-of-bounds write.

Flip the ternary to count 1 when ai_n_chan is non-zero and 0 otherwise,
matching the subdevice creation order in the function.

Signed-off-by: Yang Zi <2959243019@qq.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://patch.msgid.link/20261014101803.11036-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 656e39fedcf0 ("staging: comedi: addi_apci_3xxx: only allocate needed subdevices")
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/staging/comedi/drivers/addi_apci_3xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/addi_apci_3xxx.c b/drivers/staging/comedi/drivers/addi_apci_3xxx.c
index a90d59377e18..4f6898e8827b 100644
--- a/drivers/staging/comedi/drivers/addi_apci_3xxx.c
+++ b/drivers/staging/comedi/drivers/addi_apci_3xxx.c
@@ -788,7 +788,7 @@ static int apci3xxx_auto_attach(struct comedi_device *dev,
 			dev->irq = pcidev->irq;
 	}
 
-	n_subdevices = (board->ai_n_chan ? 0 : 1) + board->has_ao +
+	n_subdevices = (board->ai_n_chan ? 1 : 0) + board->has_ao +
 		       board->has_dig_in + board->has_dig_out +
 		       board->has_ttl_io;
 	ret = comedi_alloc_subdevices(dev, n_subdevices);
-- 
2.53.0

