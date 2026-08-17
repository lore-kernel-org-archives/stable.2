Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3773597B;
	Mon, 17 Aug 2026 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786947122; cv=none; b=KTo4ni3h0MeKIVOB/X/6cvKGUFsMAWrZF9RYcPCbQlufaUj+Nh8AXjdD2wDCbxhujJjcUukcdrdkTiLWrmxgOWiIx39tfb6aiINpv85+4/B4q1kSvB0eWvxahnPK7ovox6lOEmguDiMciL7qS5XUaiz5WlP3sIryrKnS18jZcrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786947122; c=relaxed/simple;
	bh=s9UAeJR60h0VHDcHi71qG51ge/be9xTLPwIYRVp97G0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KEEkxbe0026JGHivSDnUE/5PgqHvADoe0hpoVo0EU8cKKsC9oH/ongaai6t8mhUFxM/ZK+/yyhKVEYgn1deFusoAG5gvYWkOqjEFAbNg1Y0+RNp+Pmh+ZWdLxvPnd4deTAlr3SHzs7gfmcqcbmhKHhpfyM3E1k0ZXG5Y0WQmL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 89a6dd6c9a0211f19a56ed5b684f684d-20260817
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:424cafbb-b322-49f9-98b0-1b1283aabe62,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:53efb00edb7d9c2a38f00012189898f3,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 89a6dd6c9a0211f19a56ed5b684f684d-20260817
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 696438549; Mon, 17 Aug 2026 14:11:51 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Zimmermann <sigmaepsilon92@gmail.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	John Keeping <jkeeping@inmusicbrands.com>,
	William Wu <william.wu@rock-chips.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Chris Wulff <Chris.Wulff@biamp.com>,
	David Sands <david.sands@biamp.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkai Gong <gonglinkai@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_hid: do not copy_from_user() under a spinlock
Date: Mon, 17 Aug 2026 14:11:41 +0800
Message-Id: <20260817061141.82597-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f_hidg_get_report() already copied the report from userspace into a
new entry, then called copy_from_user() again under
get_report_spinlock. That can fault and sleep in atomic context.

Update the existing entry with memcpy() from the copy already taken.

Fixes: a139c98f760e ("USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/usb/gadget/function/f_hid.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 3c6b43d06a6d..e4621e5a0b69 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -667,14 +667,9 @@ static int f_hidg_get_report(struct file *file, struct usb_hidg_report __user *b
 	ptr = f_hidg_search_for_report(hidg, report_id);
 
 	if (ptr) {
-		/* Report already exists in list - update it */
-		if (copy_from_user(&ptr->report_data, buffer,
-				sizeof(struct usb_hidg_report))) {
-			spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
-			ERROR(cdev, "copy_from_user error\n");
-			kfree(entry);
-			return -EINVAL;
-		}
+		/* Report already exists; data was copied before taking the lock. */
+		memcpy(&ptr->report_data, &entry->report_data,
+		       sizeof(struct usb_hidg_report));
 		kfree(entry);
 	} else {
 		/* Report does not exist in list - add it */
-- 
2.25.1
