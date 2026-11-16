Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=146.20.161.86
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837511;
	b=VUYFMvlotfGVAgifX0gfJ18Y9fphXkMWp61tUXu2FQdymxS0Gab3PaXjtqIjvQw9zidd
	 aZYoJbbtabMayBd9SyBOXbGrTZes79E8+QH3gWLyTG7OFHF9pzhHLiL5Ju9HwJ3X3MVp/
	 Woq7LXNrrO2djKZhvtWDEVva9AmOT9ypXEssHm46m1GjjAmTs9jVNev8yL3rNBwX8ppHK
	 CcT3qC8mem5g3mYzhCVjKbX/5qyr3ejZGXaXu1wffDm6oVab9r5abs9mAzJu4WWCkeH6g
	 Tu/piwDPjV05S5ngmX/OwObiCJJDRHvXpnFXxDeKiMHwsGb//iLaeZbgCFVohRiBfiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837511;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Classification-ID;
	bh=bB99I40xIx5k97RWUt9McfFgIqWPM2lFFKrJlS4n/Xw=;
	b=yw1yb8qM3jAlWbYYDYc233+T8f0lPPZtxTEvyKlPTUXBif5Zyk9Azt3WaoSpRIFi6B5B
	 BfTnijpcKCJ4zk6lYjS2GCrgL6JBQC3oHuM+jWW/clkD1Tsaquq2ScLvn8d7Zmugzu/TF
	 ttvBj3XSPuUgrWMSAHHvErmqFMjcuLBlfI85jD/A1GX+EiLQDcFrXM30N7nuZeq+NaEot
	 uitmfIHbvicprM/7opG6yTGVRIBH6hXj12dIsrl3gdMYFU5JIzNxvBYtO/iM8mUrFhIap
	 S/wqt1gmGDmlKFgn8g0AQbOznik2Hqn0tqBzETfJgp0akZNKeDI7C2J7lOit547q0fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=n+1U2Yeo;
	arc=none smtp.remote-ip=146.20.161.86
Received: from smtp86.iad3b.emailsrvr.com (smtp86.iad3b.emailsrvr.com [146.20.161.86])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA039606A32C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA039606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=n+1U2Yeo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1794837504;
	bh=1M4UoCucNH4KJSHZYpYLjjxggyt8ibkQr7RfwRZari8=;
	h=From:To:Subject:Date:From;
	b=n+1U2Yeogx+AVCfzo44RVF/vWaYY4EZS/R12UOEcDlUByk8+rWc386TCXumZsEKUe
	 y7RpIf1x/b4lNELNwyzXp5dmq9e2JwCx+NxedUCzyJLCUgAAM0a+v66aDbRvbTH3Zk
	 qdpUlrFQEcxasut63b0ePOHdG9kclpnDp+yPt3kY=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp19.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id ECDC74018B;
	Mon, 16 Nov 2026 08:58:23 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Yang Zi <2959243019@qq.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15.y] comedi: addi_apci_3xxx: fix subdevice count underallocation
Date: Mon, 16 Nov 2026 13:58:08 +0000
Message-ID: <20261116135815.110850-1-abbotti@mev.co.uk>
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
X-Classification-ID: ebfff759-2cca-4ce6-bc54-4aa70a6a539f-1-1

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
 drivers/comedi/drivers/addi_apci_3xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/addi_apci_3xxx.c b/drivers/comedi/drivers/addi_apci_3xxx.c
index a90d59377e18..4f6898e8827b 100644
--- a/drivers/comedi/drivers/addi_apci_3xxx.c
+++ b/drivers/comedi/drivers/addi_apci_3xxx.c
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

