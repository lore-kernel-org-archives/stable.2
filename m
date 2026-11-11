Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366139;
	b=xJb+/iv9ujg2/V0FgLixawzMOHKmMrZgMmRZsD0ZBPEp60Sgs7qc5cTOnOFWaqaMY8d5
	 KCxINEzaenW3p4KTwE/7pzVI5OaIp1Ck9P17aLjz2G5nK96wQcAVijfp8Zaselq/KuiKj
	 +kUPQ0PZyclKgXU6pjN7nWBBy56vH2xWRP5ouGdymLmD9HNswHSNORBE7fEH+OHr32ltp
	 vI5M9Wfy529oAXP4/xAtujs75okFIH9JfNzToIUZFMfIxEgOLf/UFzxovAsw401WX1+3E
	 iBEguWYny8Ok9lP68QJJiaXatQrJbs1e+OB0bLz54q/9qQ0rRCkpf98MNEwD9g3No2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366139;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KQ5hKSkXjTEw8NyA3dDB+jLHVek2ETy4pxYZDW9Dn5c=;
	b=JH979MaH60LauKm3p7N/wTiMQXIB+2mBZXprA5211D7JVTfMXrHbP2yQzp5dQFbykpfy
	 xwxyvAbMl2gE/XkHv8D/nTdPEm81ZihoXNMl8JXf1OBx5S1VzorvLoJTwtgmBjH5tLR5f
	 RSmHwFysJqbHFnzcTZkvj90oJThQOceTb2z+6eBkSPZsi7u+dQpC7yBHX4sd7FZoEBxr6
	 J6ZN255v+IiZuZ9GYYvOw9GJpyVUf2wB75uSZw5fCqs7AbKzyJwuh7iPjWXSSVM3SBkGa
	 B78T8YEBXmzUQG/25D9ZkxZB2e67jAJqB1DpeojJaLY64nFjWRcJgOwJ5HYEJmPovfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=fi7l2q1k;
	arc=none smtp.remote-ip=115.124.28.100
Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121F606A31C;
	Wed, 11 Nov 2026 03:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C121F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=fi7l2q1k
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794366128; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KQ5hKSkXjTEw8NyA3dDB+jLHVek2ETy4pxYZDW9Dn5c=;
	b=fi7l2q1k8jlVJtbdHxPLfcQ5y0LRan/bjZDyQza4bRHyZDvk0R6Qkp1a/lzkE/xIqENgbHFrRomJ+jH7grl/zIShNDXDauSd86Zw0VlPWA0pVtw8mm9SDThQW0WQ+SSshBiSTW7sgMUGbkdo+p8ousjdb/PC6wJXg4YUbX/TBoI=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04480233|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0194357-0.000237223-0.980327;FP=9691735388033927120|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083032240;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.k.Jtk90_1794366126;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k.Jtk90_1794366126 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 11 Nov 2026 11:02:07 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>,
	Paul Mundt <lethal@linux-sh.org>,
	Hongyan Xu <getshell@seu.edu.cn>,
	Slavin Liu <220245772@seu.edu.cn>,
	stable@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH] usb: gadget: r8a66597: fix NULL dereference for unmapped endpoints
Date: Wed, 11 Nov 2026 11:02:06 +0800
Message-ID: <20261111030206.64608-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

The epaddr2ep[] table is initialized with EP0 at probe time and
populated for other endpoints when the gadget driver successfully
enables them.  Entries for endpoint numbers that have never been
enabled remain NULL.  The table is indexed by endpoint number and the
lookup mask is USB_ENDPOINT_NUMBER_MASK, so the access itself stays in
bounds; what is missing is the check for the NULL entry.

get_status(), clear_feature() and set_feature() index this table using
the host-controlled wIndex and immediately dereference the result
without checking it.  A malicious host can send a standard
endpoint-recipient GET_STATUS, CLEAR_FEATURE or SET_FEATURE request for
an unmapped endpoint number, triggering a NULL pointer dereference and
crashing the kernel.

Check the looked-up endpoint before using it.  If the entry is NULL,
stall the control pipe (pipe_stall(r8a66597, 0)) and abort the request,
matching the existing handling of unsupported recipients.

Fixes: c41442474a26 ("usb: gadget: R8A66597 peripheral controller support.")
Cc: stable@vger.kernel.org
Reviewed-by: Liu Chao <liuc63@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/usb/gadget/udc/r8a66597-udc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index d190e16d43fc..d769ea530409 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1174,6 +1174,10 @@ __acquires(r8a66597->lock)
 		break;
 	case USB_RECIP_ENDPOINT:
 		ep = r8a66597->epaddr2ep[w_index & USB_ENDPOINT_NUMBER_MASK];
+		if (!ep) {
+			pipe_stall(r8a66597, 0);
+			return;		/* exit */
+		}
 		pid = control_reg_get_pid(r8a66597, ep->pipenum);
 		if (pid == PID_STALL)
 			status = 1 << USB_ENDPOINT_HALT;
@@ -1210,6 +1214,10 @@ static void clear_feature(struct r8a66597 *r8a66597,
 		u16 w_index = le16_to_cpu(ctrl->wIndex);
 
 		ep = r8a66597->epaddr2ep[w_index & USB_ENDPOINT_NUMBER_MASK];
+		if (!ep) {
+			pipe_stall(r8a66597, 0);
+			break;
+		}
 		if (!ep->wedge) {
 			pipe_stop(r8a66597, ep->pipenum);
 			control_reg_sqclr(r8a66597, ep->pipenum);
@@ -1270,6 +1278,10 @@ static void set_feature(struct r8a66597 *r8a66597, struct usb_ctrlrequest *ctrl)
 		u16 w_index = le16_to_cpu(ctrl->wIndex);
 
 		ep = r8a66597->epaddr2ep[w_index & USB_ENDPOINT_NUMBER_MASK];
+		if (!ep) {
+			pipe_stall(r8a66597, 0);
+			break;
+		}
 		pipe_stall(r8a66597, ep->pipenum);
 
 		control_end(r8a66597, 1);
-- 
2.50.1

