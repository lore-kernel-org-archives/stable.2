Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188502;
	b=YftmBS6GO/Kk3lGig19CFItRhRCLs/9qQN1gNosS+xMTCvxO5t3EwPsQYlF3DzZoVWDf
	 rDkch4TtZqchnyymAWF+luAF3hTI1PLrKjxPbZp6PBABlT3SxlwclvIs4rlTp4dmvdnfU
	 s/wxD9Egpjdb3JJ5qJZD/Kd4rHrdjbXCx2odclmnsAvDOmAbRbiHoeVbiljR4o2VqD6Gi
	 H+aWXQivY0r5aYsEfV4v0ToNkqvoI2Cq5n7LK7scr2FbUFvx6JCCq3OT3RuzO+fG7NGWy
	 97OQbx7iVDo1wHJ6R9nMO+CzBNz0M6Dy1+b20zz0C9b/cR+6peZf/aRJjHslrD4whnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188502;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=R5sS84RUuIsde6dtEZDQh6SjVzDhGMV4LOTpA/QBjDA=;
	b=c3fQMWRGFlwNt6XdcRspFmwt6vJSmoZDcmfLtXqZA9dadx10UNhdv/GnzmfL1riiUaA6
	 yVZLCHugnlKE8yicpj0NglzsIDJiKgw+ANtcahKETiFtD70uKLDZwhmyRm7GeGq+fW1VC
	 bAsDZ7TNmATLlDCqusdF51n+5ovOArCA2/on7uzidCppwg+y2i+jqDz4RkevQgHAkynhL
	 k/BBNQyHYpCplDgj1r8ZBgw6odydmj5uF/horaq0UPA8yXiAInIQdtZvMEvexP5xT50jv
	 ELavmItyNc0otAsh5GFOLSMpYZzjmPbBcM9rHpxEr9/e+Cq1lh84jBOHsg6R8p3EDEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E7560A261A;
	Fri, 20 Nov 2026 15:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E7560A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=R5sS84RUuIsde6dtEZDQh6SjVzDhGMV4LO
	TpA/QBjDA=; b=E9gLED9XYy9MWDcTvu+5Y0Vn5Y1NNAg3D2In+EI9SUdZPB89gB
	Mhxw1ie42eaAodYQkwldlvOhLOiB1cRgGgTo1hHB0UCb/TZsxRtmzYn+ie3nITza
	KKbDWauUXRpmjFfGTScLsrb3h4K2WEW/SpoWOXxKVCArwYW3usTY3oeSs=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkCWnP_2ZgBreCzzAQ--.23017S2;
	Fri, 20 Nov 2026 23:27:53 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v2] i2c: usbio: check the return value of usbio_acquire()
Date: Fri, 20 Nov 2026 23:27:50 +0800
Message-Id: <20261120152750.5497-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116020850.10526-1-25031212351@stu.xidian.edu.cn>
References: <20261116020850.10526-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkCWnP_2ZgBreCzzAQ--.23017S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw13XFWrCr4DWFy8urWrGrg_yoW8GF1rpa
	13GFWqka4DtF409an8JrWI9a45CanxXrWj9FW0kwn8ZFn8XasrArZrtF15uFn5CrW8Crs7
	ZFWqqr9xCFyYkrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBKb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r
	yrMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uMKtUUUUU=
	=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUDD2sAYlgFTQAAsR

usbio_i2c_xfer() ignores the return value of usbio_acquire() and always
calls usbio_release() on the way out.  usbio_acquire() fails once the
bridge has been disconnected, and neither the transfer nor the release
may be issued in that case.

Return the error instead.

Fixes: daf161343a39 ("i2c: Add Intel USBIO I2C driver")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
Changes in v2:
 - Drop the mechanism paragraph and the crash log from the commit
   message, as suggested by Sakari Ailus.
---
 drivers/i2c/busses/i2c-usbio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-usbio.c b/drivers/i2c/busses/i2c-usbio.c
index 259754e5fd05..232397efe8a4 100644
--- a/drivers/i2c/busses/i2c-usbio.c
+++ b/drivers/i2c/busses/i2c-usbio.c
@@ -178,7 +178,9 @@ static int usbio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int nu
 	struct usbio_i2c *i2c = i2c_get_adapdata(adap);
 	int ret;
 
-	usbio_acquire(i2c->adev);
+	ret = usbio_acquire(i2c->adev);
+	if (ret)
+		return ret;
 
 	ret = usbio_i2c_init(adap, msgs);
 	if (ret)
-- 
2.34.1

