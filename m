Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=184.106.54.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836922;
	b=A0UORlriUC0MB/IwePDrocKV2imJavXieRo6XYt4akRNokfwxzdwG/tqbXeXp6daFRhx
	 XHnxsUeOZc5bdv9Od0/QD7GlP7Qq5ajgE+SV1G2CrtzyGletKqh2VfX6LysEWGcWJN7yg
	 5Ytj5b28U4gQ2BX6VQKnTUuzc8sSgjz77e55eC9a4sQM0s22qFd0zsJFoD0yXnmm34giI
	 SOUHKH8ZFob3UTQiwEAZX6JD2zLIve3TMO7w7xRdSEy5kn8qwPUy2uChigZDF08nWqX3W
	 BFUjh/ZDYkp3MOBPxrE0DOZV6g3xSFxQAq1exkEWeqYlbYgBMXo8DiX27cQA9fQPjeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836922;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Classification-ID;
	bh=/n36fvQnXNXJA442SRslvo+FhfWwgfTB+jpGoM0s3eY=;
	b=XEf9i4JN2oGmWneF1+qxc/ZF8d3NKWXNN9vbU9FGNrzGWqfViOCgbodQGGmXgYw3PnAN
	 DUf8178W/ZbPNDnN3OAO0HuYC1K+t/1BCUb9LK8jrF1/M55tvg0oTrVjEZ2tPjYsLNvCq
	 askPyspCdZ0MX6jVGYEGwmjzj4P5rs1nzIctTCeVQNHdJRGO8d1vrTSzX2jm38O7tSrNI
	 nizTqiFTupEUgmhXSEr00Gxb6a2tsiDQv5lsxQs5X+dGBqo4A4mPJKgvkkCyu9/GwxuuR
	 1g3A2XlcHd/SUe+KVSb6gnNYFlfZSZJ2FVhZSVqmBL6MnGK6HU27f4xG4FOmryxkzPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=ZBLXbxL+;
	arc=none smtp.remote-ip=184.106.54.70
Received: from smtp70.ord1d.emailsrvr.com (smtp70.ord1d.emailsrvr.com [184.106.54.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52FC606A886
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D52FC606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=ZBLXbxL+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1794836915;
	bh=+2qza1RlvfYO0xyfCCoAJcNylmS8nZ8LtZmyO5uwa30=;
	h=From:To:Subject:Date:From;
	b=ZBLXbxL+4E7mrVzZHxjMU6ylP5phFcacTzFwYzWgZS9DtBQc5Mq0s6o9kyJ4zBL09
	 yBgAvVyll/kkn/7LEtnOKDe1FHsZB1N6gNtNyxjlsFrH0+LtIvaEHc2zm35xSLYYVJ
	 cWMJp1y31k8KIhQvLsPB2AX4Jqor1IBd1LSQdM10=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp17.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 2122720291;
	Mon, 16 Nov 2026 08:48:35 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Yang Zi <2959243019@qq.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7.3.y] comedi: addi_apci_3xxx: fix subdevice count underallocation
Date: Mon, 16 Nov 2026 13:48:12 +0000
Message-ID: <20261116134822.109548-1-abbotti@mev.co.uk>
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
X-Classification-ID: 86a517c6-e829-4811-bbea-fd44f69c6bfc-1-1

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
index 695cce103177..1dcda82d9503 100644
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

