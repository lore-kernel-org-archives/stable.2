Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795279777;
	b=lQjPss8xYahseJydkHw2YtvQPUFbj3Azku37xXuOftiUKruG1/nqwobYdHDqWdROD4lg
	 YeaXbz4JQtMdP9tl+UFnoHfvNQ7n+Ykrgd6risVf6t++9qFY4opO+DZWkMpvaOdudiiaR
	 gPH9HwmqE/cFBsfQ7njxMYB6r3SFdygPDCCvWjO3ZafrPjmapLUOd4lkSrv1BORU/HPvb
	 N9u6M1mXNalOnT6NamGrZ406Zp5SZQdkrGac9RYbE2IqKfC5mv2yWaOTxTgowxx+dgc0s
	 UcBrZoABt5jVokgY1EWqkaancTIyE+vU8wplvK23JmP5a6NaP4p3xDzUKhyUBHNXVWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795279777;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=XFkzGSrz7trKfXrVYSH/+33CUkHyV9zjq8Sdpnp/tVs=;
	b=1LTVz6Jj00rChmrAaJ80Gj/M6ceH9LHNHBetaLzY9BsQ1/dGmhPnW8HP2qGKRwsegCCI
	 G95OIWpuWdzOcPWH2B3Vup5xEvrWn7Zb8Rlck0Oe92xa1vHLJ/zjTVA3PhKvYXVFY8nuA
	 RyO3ERbGX/IFeRidsdsSKYEZPtWUN4SdEJpEzQTbcCliV9ywhGshTzJNeAIHoDMizLhW/
	 7q2WcZo93OPMsgHqAdRXR7g2Ia3AiPnl7tcf9CaVjvc9UTheFmCPx3vgzMJ+b/M2Kfzb9
	 LmRMIs5xpKMRiVEEBT4Dzm+bIQPDB9ADZKcK+OwX5DpJmXjtsicdzb+ByXLAw1pX8+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D1D606A320;
	Sat, 21 Nov 2026 16:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91D1D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=XFkzGSrz7trKfXrVYSH/+33CUkHyV9zjq8
	Sdpnp/tVs=; b=UsJCuSXTx8GVkAC0SJtalsW9+2+Ql4euUwn8AyJBiKACcdI8vF
	9CeZ+Lgagx06Zhlj+7kcCRuevV+VV7d6oPs2GsUQvUeO3M14Fqcq+Jy/gHljDWMX
	ZvNZDsX0Jw1qOSkyzL6LW11zPi7wn2BrmEbP1vJ4BHosyDj2K6h/BvPBE=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkCGyP2UywFrA1QFAg--.46581S4;
	Sun, 22 Nov 2026 00:49:30 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Arien Judge <arien.judge@morsemicro.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH 2/2] wifi: mm81x: clear a stalled bulk endpoint before the next transfer
Date: Sun, 22 Nov 2026 00:49:23 +0800
Message-Id: <20261121164923.8862-3-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261121164923.8862-1-25031212351@stu.xidian.edu.cn>
References: <20261121164923.8862-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkCGyP2UywFrA1QFAg--.46581S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWkZr1DAr17tr48GrWUtwb_yoW5CryrpF
	s3Zry5trZ8tr9rCws3A3y29a43Aa1vqa92kryYqw13uF15G39ayFy8Wr15Krn7uryxtay2
	vF4UXrWDWrsIgwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY
	1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
	xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2
	jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
	kKe7AKxVWUtVW8ZwCY02Avz4vE14v_JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07jBPfQUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUED2sBtkkLawAAs5

A bulk endpoint stays halted after it has answered a transfer with a
stall, and only a CLEAR_FEATURE(ENDPOINT_HALT) request resumes it. The
driver never sends one: the completion callbacks only record -EPIPE in
musb->errors, so every later register or memory access on that endpoint
stalls immediately and the device remains unusable until it is
re-enumerated.

Clear the halt of the endpoint that reported -EPIPE before returning the
error, so that a following restart can reach the device again. The command
endpoint is the memory write endpoint, hence the same recovery is applied
when the command urb itself stalls.

usb_clear_halt() sends a control request and may sleep, so it is called
from the process-context paths that wait for the transfer and never from a
completion callback.

Fixes: b1906cea00b0 ("wifi: mm81x: add mm81x Wi-Fi HaLow driver")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/net/wireless/morsemicro/mm81x/usb.c | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/wireless/morsemicro/mm81x/usb.c b/drivers/net/wireless/morsemicro/mm81x/usb.c
index 98ca9575b990..72cbe468969c 100644
--- a/drivers/net/wireless/morsemicro/mm81x/usb.c
+++ b/drivers/net/wireless/morsemicro/mm81x/usb.c
@@ -106,6 +106,19 @@ static bool mm81x_usb_urb_status_is_disconnect(const struct urb *urb)
 		(urb->status == -ETIME) || (urb->status == -EPIPE));
 }
 
+static void mm81x_usb_clear_halt(struct mm81x *mors, struct mm81x_usb *musb,
+				 struct mm81x_usb_endpoint *ep, bool dir_in)
+{
+	int ret;
+
+	ret = usb_clear_halt(musb->udev,
+			     dir_in ? usb_rcvbulkpipe(musb->udev, ep->addr) :
+				      usb_sndbulkpipe(musb->udev, ep->addr));
+	if (ret)
+		dev_err(mors->dev, "failed to clear halt of endpoint %u: %d\n",
+			ep->addr, ret);
+}
+
 static void mm81x_usb_int_handler(struct urb *urb)
 {
 	int ret;
@@ -266,6 +279,10 @@ static int mm81x_usb_cmd(struct mm81x_usb *musb,
 	}
 
 	musb->ongoing_cmd = false;
+
+	if (musb->errors == -EPIPE)
+		mm81x_usb_clear_halt(mors, musb, ep, false);
+
 	return musb->errors ? musb->errors : writesize;
 
 error:
@@ -374,6 +391,9 @@ static int mm81x_usb_mem_read(struct mm81x_usb *musb, u32 address, u8 *data,
 
 	if (musb->errors) {
 		ret = musb->errors;
+		if (ret == -EPIPE)
+			mm81x_usb_clear_halt(mors, musb,
+					     &musb->endpoints[MM81X_EP_MEM_RD], true);
 		dev_err(mors->dev, "mem read error %d", ret);
 		goto error;
 	}
@@ -444,6 +464,9 @@ static int mm81x_usb_mem_write(struct mm81x_usb *musb, u32 address, u8 *data,
 
 	if (musb->errors) {
 		ret = musb->errors;
+		if (ret == -EPIPE)
+			mm81x_usb_clear_halt(mors, musb,
+					     &musb->endpoints[MM81X_EP_MEM_WR], false);
 		dev_err(mors->dev, "error %d", ret);
 		goto error;
 	}
-- 
2.34.1

