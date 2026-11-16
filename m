Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.203.187.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839236;
	b=SkrIu6QfKaBecJtQ592hlSJbDYlCYm31pikMfFVgU4uq1xGe9w2O8L6CGyAsIL6uUq7r
	 EySJrJy652m1x9FVreCAgRn+Ho3cI6bek10gG2i+8aTw6+EeESRV/qUAVxYLTzyLpL7Mk
	 ThRC3BpbIntUa08DeNxhccb9LCmcGsI9KWYYJRH3bUdMwsW5gB47e/wDO7VDrsnSn+4oQ
	 aCqaEih/HntESEOpf0qCwb8jDTFkGnFvh6rqEjKbYA9VgRoUb9LRWvJu71LyzaMeuBgEh
	 BFNALXd0h0B6GUKMtERcRnv7B6AtTu/8KlI35K7dfonmMqkwfK6JDay0qXN8MwcXYqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839236;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Classification-ID;
	bh=VQ3YeRHwI3MrkRmNiZMDbwPTTYvVwwgd1WHuRMFva8Q=;
	b=1d8Z7iyLu5wEIPSxcB0O5PoUfAKlBqK3ZE/LJOV7dsd5cGsnLjf4sMxebkYf3tcqxhPQ
	 6yLdnU1eXNr837JLWTvhL3raqwLGpJvYQKphUZhDCo7XLZQcb3Zlt8TwnmzbZGAp+ztoj
	 ubYgW1kDXftYP5+CPzHv+8G8D/X0gnJDcEBocu8VGeHePG/zbCoXtF5Y6bt2z3HKC1kD5
	 kgEO+VxHzttyRM3jCWmRBV8WSuvD0w+t7FGIvgXZwWvvYpqMPR4qp44qNIMFDyZ+vHBua
	 sBOijI1keboC33O4QTYqyXygxF771IIyoEj09hEulVrYfTSUaXmHaelSthnTwC9gWcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=IVcOdv1V;
	arc=none smtp.remote-ip=173.203.187.113
Received: from smtp113.iad3a.emailsrvr.com (smtp113.iad3a.emailsrvr.com [173.203.187.113])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC0606A32A
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7FC0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=IVcOdv1V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1794839234;
	bh=RWxgcjm3KzeVMSTEJdoZ4zYT0jBi17kDCX2UYtzBi3w=;
	h=From:To:Subject:Date:From;
	b=IVcOdv1VeNQR7J9delFiF8WNpdlaWT3OEWXmbqdrgWo4QBiC+nlj4cWqWb0V5X+FB
	 /VOspPnUHkoVZAZkMQmRq//Za1vogn3r5c8aPKlXMKlucsT3Ztw2LvsHwr3cSkZxCi
	 3BaEzT7e6jZs2QuxV+p1UN1JyDQRALfhhRqoZHo0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp39.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 3B40C5922;
	Mon, 16 Nov 2026 09:27:14 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Yang Zi <2959243019@qq.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1.y] comedi: addi_apci_3xxx: fix subdevice count underallocation
Date: Mon, 16 Nov 2026 14:26:58 +0000
Message-ID: <20261116142706.114307-1-abbotti@mev.co.uk>
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
X-Classification-ID: ad503688-7a1c-47c0-bc52-0a44c851b200-1-1

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
index bc72273e6a29..7355ec454cb4 100644
--- a/drivers/comedi/drivers/addi_apci_3xxx.c
+++ b/drivers/comedi/drivers/addi_apci_3xxx.c
@@ -787,7 +787,7 @@ static int apci3xxx_auto_attach(struct comedi_device *dev,
 			dev->irq = pcidev->irq;
 	}
 
-	n_subdevices = (board->ai_n_chan ? 0 : 1) + board->has_ao +
+	n_subdevices = (board->ai_n_chan ? 1 : 0) + board->has_ao +
 		       board->has_dig_in + board->has_dig_out +
 		       board->has_ttl_io;
 	ret = comedi_alloc_subdevices(dev, n_subdevices);
-- 
2.53.0

