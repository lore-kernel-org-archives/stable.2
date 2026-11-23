Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443939;
	b=aZSqswl0t4QyNAZsAnoEedyoa4t+/VjpgcMFTszcreSjTo70bg8xdFK315Fe2weXnhEl
	 t2rOV+TvBwZi1K7xblbEccXtcieSq0aRBbMiKXtm/NWWWuUB1EjxYchDPrvp5LZ8N/EbP
	 ovB+L8HRxddV7ADlGJDRKrvfFr+NZOaSUcgiu1AlmigdC4/9sw+SokItPqNIMusWYzxid
	 fa2hYiy/ijq1r188bubQrOEPPR/iL01KklS/+bkSYpa1PkbHOFmNWZ0r03O/LRoj/q/pD
	 /9P6d3ZMgcjek/ngheXhyy/fa44b4ApsAnEUtnsVoOZset73KMiOaXED1QFBK4UxWKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443939;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=7b33Jap8LbKbkO4Xoms8+UwJkMsmtqS+GX5xZmwtFzw=;
	b=NefK+hQLemvHVh8InswUv6PpAbLVFoVwfUBt1ju/eDJC/l2vVS9zF+rkybhcHtNQFaqj
	 OSKaJT7Seb17WYJA/Hax+GhiH3TggKDzwSxM3qKAUwtwkL/fEmM9IeUydvqoNK1F0Nw4O
	 Sl4emyl/hqy3sDIPKQplqGWwxs9UsO9YSJ/EiuPgrwaAQB3mwY0Vi7nLGhej59Ayixec8
	 1bTRr0PMnv4GBTtaPbSQCQFBzhcE6z/Qd0SKJQmdE8mve9ERfCBiUahSpji7fLCN5i/0t
	 vffrAa8Tv02k4RWaNimowXIzg08YtHZOfUoWrA4w/XGK3EXVRdn4Mv/NmGn5Ha7WX5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=eImv0GLz;
	arc=none smtp.remote-ip=217.74.67.63
Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25021606A33F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25021606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=eImv0GLz
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Mon, 23 Nov 2026 15:25:30 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: gregkh@linuxfoundation.org,
	jiashengjiangcool@gmail.com,
	yun.zhou@windriver.com,
	zzzccc427@gmail.com,
	bigeasy@linutronix.de,
	nab@linux-iscsi.org
Cc: Slawomir Stepien <sst@poczta.fm>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+2799146a53c356f8017d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] usb: gadget: f_tcm: don't hold dep_lock across unregister_gadget_item()
Date: Mon, 23 Nov 2026 15:25:11 +0100
Message-ID: <20261123142513.204652-2-sst@poczta.fm>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123142513.204652-1-sst@poczta.fm>
References: <20261123142513.204652-1-sst@poczta.fm>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1795443931; bh=7b33Jap8LbKbkO4Xoms8+UwJkMsmtqS+GX5xZmwtFzw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=eImv0GLzOVl1GuwgT/+stU7op8F3SlOoXxrYXDhjCnGYRRRp7DTpCYZXKnlK+0mVZ
	 wS3XCZqx0MLNPy7I7sTHo0xK4TQrEIXt6M6cpxOtbNgqF1ZT38a0VHYpeQiZXRYzQO
	 s3reOYiLNW1L6B9nQRHCLKdwX5A69INe/EMeh34Q=

tcm_unregister_callback() runs when a TPG is disabled and unbinds the
configfs gadget via unregister_gadget_item() while holding
opts->dep_lock. unregister_gadget_item() takes gi->lock.

The opposite order is taken when a UDC is assigned to the gadget:
gadget_dev_desc_UDC_store() holds gi->lock across
usb_gadget_register_driver(), which binds the configuration and ends
up in tcm_bind(), which takes opts->dep_lock:

  CPU0: echo 0 > .../tpgt_N/enable    CPU1: echo <udc> > .../UDC
  tcm_unregister_callback()           gadget_dev_desc_UDC_store()
    mutex_lock(&opts->dep_lock)         mutex_lock(&gi->lock)
                                        ...
                                          tcm_bind()
                                            mutex_lock(&opts->dep_lock)
    unregister_gadget_item()
      mutex_lock(&gi->lock)

Disabling a TPG while a UDC is being assigned can therefore deadlock.

Here dep_lock only needs to cover the can_attach update, so clear
can_attach under the lock and call unregister_gadget_item() after
dropping it. Once can_attach is false, any later tcm_bind() fails with
-ENODEV, and a bind that already passed the check is undone by the
unregister that follows. The function item, and with it the gadget
item reached via ci_parent, stays alive because the TPG still holds a
configfs dependency on it.

Fixes: 4bb8548df632 ("usb: gadget: f_tcm: add configfs support")
Cc: stable@vger.kernel.org
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/usb/gadget/function/f_tcm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 9e6d4f39900a..110a7d334afa 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -2637,10 +2637,11 @@ static void tcm_unregister_callback(struct usb_function_instance *f)
 	struct f_tcm_opts *opts = container_of(f, struct f_tcm_opts, func_inst);
 
 	mutex_lock(&opts->dep_lock);
-	unregister_gadget_item(opts->
-		func_inst.group.cg_item.ci_parent->ci_parent);
 	opts->can_attach = false;
 	mutex_unlock(&opts->dep_lock);
+
+	/* Takes gi->lock; UDC_store holds gi->lock while tcm_bind() takes dep_lock. */
+	unregister_gadget_item(opts->func_inst.group.cg_item.ci_parent->ci_parent);
 }
 
 static int usbg_attach(struct usbg_tpg *tpg)
-- 
2.56.0

