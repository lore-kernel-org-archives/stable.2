Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795279777;
	b=2SwukDHf28Y5XOSPG64PZ38V59cTuoN1Y+uQJlvvmLulZWG/vCaiaflTRs2noaYd68dD
	 l5q4XR76tra2QFqVKyLsaLMWUxH/mLNxQFONksyLxF120M29DtEwBhwjYrnb2YoizvVP4
	 /e9Y6JojaanR0JPU/Dcqsa/LH2h9BHovsQj3jUoxdTE+qEfMLtqvgoMK6t6ij1Rk/12XI
	 wIU+DIXb0xcZ34vKB0SHMTltCf7RI0x0Oi418MGb0Yk674UwP3CpUdC/JYmWAxZT7gth+
	 urGrf4xOrrqhVKyEIAj5D6UMJ9NZO0m16isgm/faxWgMUuget0g1h0K9lvxE+p0msig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795279777;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=5G+9ewNfiZuudG7vEE+47Lp1fAf9KEyf5+kMjiFZROY=;
	b=VhWdpTZLp4LTl4G6Ib34J/IBxqWI0CrQ4y9j+yEuJemg0wcA5EBGPsTfJuULcfhb7GaG
	 MCH+pTKvSlhixNOmUz0DnOH5L4dNUVSqsDd1MDtnWSKLaowo0FYx+kxk8YOolqw+GHcXA
	 TrgdL3uB4fm4QH9tNDHk/nl3xKzgHJM+/PQKvPIHS2bb+kSpnvQarUmQxhQMjsNRQ/o8+
	 YZ+bICY8G0xl/b7A6dtpfq5rWDbGc2ESdc+P6qH7lD6KlZUGoMV92lPy+0rgU136CIFJE
	 XErI7bAgrzP31Ip+h60VGWoSzdrV0RKb9xD3nKr+Mld8ZmnAECPzB62qPE8H2mLZe8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DC1606A32C;
	Sat, 21 Nov 2026 16:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91DC1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=5G+9ewNfiZuudG7vEE+47Lp1fAf9KEyf5+
	kMjiFZROY=; b=JroaGme853vLP1sT/wKM2HmyyD/Dg86J1UdphcnBwbVaijUYF8
	LNs4DJuJnvOyp+s1MWYWeKfbT4Jy8f5vr7Ou5IhxwG6mCFrAp80N2ddyCZdkLqMZ
	m70eAoREgMCSdgl7QxESN1Txm2pw3lUVrDQ3I1bNW3hNQ7zru7KdkYLSE=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkCGyP2UywFrA1QFAg--.46581S3;
	Sun, 22 Nov 2026 00:49:29 +0800 (CST)
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
Subject: [PATCH 1/2] wifi: mm81x: report a failed command urb to the caller
Date: Sun, 22 Nov 2026 00:49:22 +0800
Message-Id: <20261121164923.8862-2-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkCGyP2UywFrA1QFAg--.46581S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4UAw1Utw18Aw4xCw45KFg_yoW8ArWrpF
	45Zr9Fk3s8KryDCw43CFWI9Fy5A3Zxta9IkFyvvws8urn8JwsakFyYga1agFn0v34Iya42
	vFWYyry7GF9xG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm2b7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
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
	xhVjvjDU0xZFpf9x07jTiifUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUED2sAYljOOwAFsu

mm81x_usb_cmd() waits for the command urb and takes the return value of
wait_event_interruptible_timeout() as the command result. The completion
callback stores the urb status in musb->errors, but the wait only tells
whether the callback ran, not whether the transfer succeeded, so a command
that completed with -EPIPE or -EPROTO is reported as successful.

mm81x_usb_mem_read() and mm81x_usb_mem_write() then submit the data urb
even though the command that programs its address, direction and length
never reached the device. On top of the useless transfer, the device can
interpret the data phase in the context of the previous command.

Return musb->errors from mm81x_usb_cmd() so that both callers stop before
the data phase.

Fixes: b1906cea00b0 ("wifi: mm81x: add mm81x Wi-Fi HaLow driver")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/net/wireless/morsemicro/mm81x/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/morsemicro/mm81x/usb.c b/drivers/net/wireless/morsemicro/mm81x/usb.c
index ec94936b157b..98ca9575b990 100644
--- a/drivers/net/wireless/morsemicro/mm81x/usb.c
+++ b/drivers/net/wireless/morsemicro/mm81x/usb.c
@@ -266,7 +266,7 @@ static int mm81x_usb_cmd(struct mm81x_usb *musb,
 	}
 
 	musb->ongoing_cmd = false;
-	return writesize;
+	return musb->errors ? musb->errors : writesize;
 
 error:
 	musb->ongoing_cmd = false;
-- 
2.34.1

