Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7573F44F5;
	Thu, 17 Sep 2026 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633129; cv=none; b=SOulmNazeCsYSNRy2XPmtrhKsaKxIRKkchMXTQjj4Xtk9j+KeF/ECmUJC0fW9pnlLVMNhx7iuYUQ59vt/R5MuBVX3/zFDnuUiC1JuLhc+tzRUi323JvWwInMNs5EQa2Wj0+deATJjIS/upfPpvYvlk4+yZI3/Dx1Bt7KTXtquZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633129; c=relaxed/simple;
	bh=aIXu9UU3o/cklA86DFtHkxXnr6iIX61FkqectxHHoiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ypof/k/1ZuBoZc5wkakVI2jpOFFHJ2qX7V3t3MK9F1i6kHokgOLoTrVS5Ne1IRt/0rpcJ/jGpXmsKU9ZlG1L07037R1pvzdga3geUibFRxLBryRsGaKUI6CWY3fxCaSDTnduXWx8DKU+xZsJ8ft/Du4QAyQBnWS82cLTOJA1tPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=OeA1PX+a; arc=none smtp.client-ip=115.124.28.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="OeA1PX+a"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789633115; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SUr+ZaiEoQhQmNJ9xnJURmcD60svSy7Qsgo0e6FMTEI=;
	b=OeA1PX+aq1knkx1Encgx1pJJeglYO5Vvmc6FZl79ojH0OgxFH+rZdMD5EeO4nuFQoSdjdKjI6AMrcGD8wrg435g6bdssBz9TU7MusogB12JK6Rq0LBkkhTwCij0yuSyOXFrZ3tNu4HVHY5Rc8QsP9isczk1L+btSud483Lg+Ckk=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2315185|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0052429-0.0005036-0.994254;FP=11527700046031867826|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jFpe14._1789633114;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jFpe14._1789633114 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 16:18:35 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuwb@xiaopeng.com,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH] usb: gadget: f_uac1_legacy: validate bRequest index in generic_{set,get}_cmd
Date: Thu, 17 Sep 2026 16:18:32 +0800
Message-ID: <20260917081832.187957-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic_set_cmd() and generic_get_cmd() use the low nibble of
ctrl->bRequest as an index into con->data[]:

    u8 cmd = (ctrl->bRequest & 0x0F);  /* 0 .. 15 */
    ...
    con->data[cmd] = value;            /* OOB when cmd >= 5 */

struct usb_audio_control (include/linux/usb/audio.h) declares data as
a 5-element array, so indices 5 through 15 write (or read) up to 44
bytes past the end of the array on the heap.

A malicious USB host can craft a class-specific SET_CUR / GET_CUR
request with an arbitrary bRequest value, triggering the out-of-bounds
access from an IRQ completion handler with no further preconditions.

Add an ARRAY_SIZE() guard to both functions.

Fixes: d355339eecd9 ("usb: gadget: function: make current f_uac1 implementation legacy")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/function/f_uac1_legacy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 3f52099a4..7c8d60c7e 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -797,6 +797,9 @@ f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 
 static int generic_set_cmd(struct usb_audio_control *con, u8 cmd, int value)
 {
+	if (cmd >= ARRAY_SIZE(con->data))
+		return -EINVAL;
+
 	con->data[cmd] = value;
 
 	return 0;
@@ -804,6 +807,9 @@ static int generic_set_cmd(struct usb_audio_control *con, u8 cmd, int value)
 
 static int generic_get_cmd(struct usb_audio_control *con, u8 cmd)
 {
+	if (cmd >= ARRAY_SIZE(con->data))
+		return -EINVAL;
+
 	return con->data[cmd];
 }
 
-- 
2.50.1

