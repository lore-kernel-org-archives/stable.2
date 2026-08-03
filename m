Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898DC36F42D;
	Mon,  3 Aug 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750356; cv=none; b=WQRHz19wt3zyzNceZI8RWM0Na5CDDpvBzMB20plm/BkZXHvxSiUuClCTv/lZYLGGOoh1HnlQuuZqVp2MYAB6c8HWDPZjx0DIX+HGPLfN3w2q7Ba6PKgSsXmpMTvJz7bt4o5hqYVXiBwW/OkyhCtre/1goJqxdV60uBHM/QzPqw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750356; c=relaxed/simple;
	bh=udAEIJylS7t/IEQhTibNthSXiZkK1prZKZ0rvTQhJBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mP09fEEVQMPofiBKfrwrU01y7AbKKC1oB5DZKGCovxT22SiIJ5EgvqyDUE1rngB4RWi9bCH0jqcW2ueb2ALZ/kqVqYeNAqdlzyGAUJFoXAK7YuhhoXR5FJ3hExGTkPwvPdLVXM1w164PpskTxHG/p7fIg1zV7OL3KmpR3KObXJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 192982ac8f2011f1aa26b74ffac11d73-20260803
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:dd875203-74eb-4cac-9658-d6158c07af40,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:2270fee7dfe588a50a0c9ee97627c6ad,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 192982ac8f2011f1aa26b74ffac11d73-20260803
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1235745383; Mon, 03 Aug 2026 17:45:44 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: mchehab@kernel.org,
	crope@iki.fi
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Changcheng <chenchangcheng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] media: dvb-usb-v2: fix URB double free and use-after-free on allocation failure
Date: Mon,  3 Aug 2026 17:45:38 +0800
Message-Id: <20260803094539.242495-2-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260803094539.242495-1-chenchangcheng@kylinos.cn>
References: <20260803094539.242495-1-chenchangcheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb_urb_alloc_bulk_urbs() and usb_urb_alloc_isoc_urbs() free the URBs
allocated so far when usb_alloc_urb() fails, but they do not reset
urbs_initialized.  The stream is then left with a stale non-zero
urbs_initialized count covering already freed, dangling urb_list[]
entries, while every other user of the stream state
(usb_urb_free_urbs(), usb_urb_submitv2()) relies on "urbs_initialized
valid entries" as the invariant.

Two failure scenarios follow:

1. Probe failure path: dvb_usbv2_adapter_stream_init() fails and the
   probe error path runs dvb_usbv2_adapter_exit(), which calls
   usb_urb_exitv2() -> usb_urb_free_urbs() on the same adapter (it is
   reached because adap->props was assigned before stream init).  The
   already freed URBs are freed a second time -> double free.

2. Runtime reconfig path: while the probe path above is hit whenever
   allocation fails during probe, this one additionally depends on the
   device's get_stream_config() returning a configuration different
   from the one used at probe; such devices exist (e.g. af9035 shrinks
   the buffer size on full-speed USB ports).  usb_urb_reconfig() then
   frees the old URBs, updates stream->props and calls
   usb_urb_alloc_*_urbs().  If the allocation fails, the next
   usb_urb_submitv2() call with the same parameters short-circuits in
   reconfig()'s "all fields are same" check and then submits the stale,
   already freed URBs -> use-after-free.

Reset urbs_initialized to 0 on the allocation error path, keeping the
invariant that a non-zero urbs_initialized only covers live URBs.

Fixes: c79b339f9292 ("[media] dvb_usb_v2: copy current dvb_usb as a starting point")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 drivers/media/usb/dvb-usb-v2/usb_urb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/usb_urb.c b/drivers/media/usb/dvb-usb-v2/usb_urb.c
index 2ad2ddeaff51..9ba9aceabb5b 100644
--- a/drivers/media/usb/dvb-usb-v2/usb_urb.c
+++ b/drivers/media/usb/dvb-usb-v2/usb_urb.c
@@ -145,6 +145,7 @@ static int usb_urb_alloc_bulk_urbs(struct usb_data_stream *stream)
 			dev_dbg(&stream->udev->dev, "%s: failed\n", __func__);
 			for (j = 0; j < i; j++)
 				usb_free_urb(stream->urb_list[j]);
+			stream->urbs_initialized = 0;
 			return -ENOMEM;
 		}
 		usb_fill_bulk_urb(stream->urb_list[i],
@@ -175,6 +176,7 @@ static int usb_urb_alloc_isoc_urbs(struct usb_data_stream *stream)
 			dev_dbg(&stream->udev->dev, "%s: failed\n", __func__);
 			for (j = 0; j < i; j++)
 				usb_free_urb(stream->urb_list[j]);
+			stream->urbs_initialized = 0;
 			return -ENOMEM;
 		}
 
-- 
2.25.1

