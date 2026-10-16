Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3243009F2;
	Fri, 16 Oct 2026 04:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123469; cv=none; b=QsKJIM3g38WezGsY0dmEMx0Z7kDjNo7tnJrxRId9gzBvdYU4uuQezQ/QEYqA3MH+ayAPO6VVrOEYEeKsg+j/wp3zmxja/AmO9Nfx+fgsmYlj7XUGFDdHboOkSiuDJi3MsbFhwVEUSfiLr+6Gj5oEbiErevppNs/qnL2vl5HQWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123469; c=relaxed/simple;
	bh=h87naY7RnHqXfoQX6aaL788b15IXb90ueQxSxvAx4W4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KopoO+2hQPqregzNStUHqXzNE5FsfWquml9kpizWhIlkE4Z6LzbXa5L2HtQX6cNXyB/oPG76s/t0bQhRDa69dIAZJmzdo/Ez2HQzbNTojPpbWZTyrcjD4s+9Mjfeaee5q+Hv1Om5cFQ7DhNQv2H2RNH0PYiPKjpWb7VZDp+9lIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=ATHFzLZK reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="ATHFzLZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=xRmRnms+zV
	zYh0Y3KzMMuYDjvDit7pvXuCmYcJKfhoQ=; b=ATHFzLZKSHBzu+LsEvcCIOAw0F
	D5mXXQqAMX1ncfPTXtuW17csgWkKsKmqgFvBm4h21dt8s0xmg7yLzJ3+liwIhJfJ
	Ixd5luS+a2cUcjdAOQRh7p79NBoehRwTAZuog9at6wZNoIJqBYLMNKdq7EFXmP5f
	vc/UBWzE1ElUcH/WI=
Received: from localhost.localdomain (unknown [113.200.174.90])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkDWGP5CotFqbSqoAA--.50587S2;
	Fri, 16 Oct 2026 12:04:19 +0800 (CST)
From: Yuanzhe Liu <25031212351@stu.xidian.edu.cn>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] media: gspca: check return value of usb_ifnum_to_if() in gspca_init_transfer()
Date: Fri, 16 Oct 2026 12:04:04 +0800
Message-ID: <20261016040404.1337-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkDWGP5CotFqbSqoAA--.50587S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyxur48Ar45Wr4xCw43trb_yoW5Gr4DpF
	Z3GF4jyay5Jr4qkr4UXr4Du3Wruan7Jay7Cry5Aw1kZw47XFZ3Aryj9r15XrsrArZYyw4I
	q3WUJayUW347CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeL0eDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUID2rQ7FFu7gAAsE

From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

In gspca_init_transfer() and gspca_input_create_urb(), intf is looked up
via usb_ifnum_to_if(gspca_dev->dev, gspca_dev->iface).  According to the
USB core implementation, usb_ifnum_to_if() returns NULL if the given
interface number is not found in the active configuration (for example,
if the device was disconnected or had its configuration reset).

Currently, neither function checks whether the returned intf pointer is
NULL before dereferencing its members.  In gspca_init_transfer(), when
a bulk camera is used, intf->num_altsetting is dereferenced immediately;
for an isochronous camera, intf is passed into build_isoc_ep_tb(), which
also reads intf->num_altsetting unconditionally.  This triggers a NULL
pointer dereference and results in a general protection fault crash.
In gspca_input_create_urb(), intf->cur_altsetting is likewise accessed
without checking for NULL.

Fix this by verifying that intf is non-NULL before dereferencing it.
Return -ENODEV in gspca_init_transfer() if intf is NULL, and return early
in gspca_input_create_urb().

Fixes: d43fa32fec44 ("V4L/DVB (8156): Many bug fixes, zc3xx added.")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/usb/gspca/gspca.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/gspca/gspca.c b/drivers/media/usb/gspca/gspca.c
index 594d73e50b9f..1b76f871b672 100644
--- a/drivers/media/usb/gspca/gspca.c
+++ b/drivers/media/usb/gspca/gspca.c
@@ -213,6 +213,8 @@ static void gspca_input_create_urb(struct gspca_dev *gspca_dev)
 
 	if (gspca_dev->sd_desc->int_pkt_scan)  {
 		intf = usb_ifnum_to_if(gspca_dev->dev, gspca_dev->iface);
+		if (!intf)
+			return;
 
 		ret = usb_find_int_in_endpoint(intf->cur_altsetting, &ep);
 		if (ret)
@@ -765,6 +767,8 @@ static int gspca_init_transfer(struct gspca_dev *gspca_dev)
 
 	/* do the specific subdriver stuff before endpoint selection */
 	intf = usb_ifnum_to_if(gspca_dev->dev, gspca_dev->iface);
+	if (!intf)
+		return -ENODEV;
 	gspca_dev->alt = gspca_dev->cam.bulk ? intf->num_altsetting : 0;
 	if (gspca_dev->sd_desc->isoc_init) {
 		ret = gspca_dev->sd_desc->isoc_init(gspca_dev);
-- 
2.34.1

