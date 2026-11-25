Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591047;
	b=WeQkK9QLIC2PdOCXvja7rL8Q0E08u1Wd3VAfeRgzHgsqUdNIaLZRrQ6uokC08Ja/WaEK
	 7VfiWBtdejOn+2DB1uww8hltt6u/jfH4h0ShkX+M3WVIm2vaOe1Szn3aTa2uLeLNpQxxG
	 te+Cfv4Gl1ejQagaaJ+GzwhUwQjjul2etpFUaVzZt0wNkc5HeruM8xkl+e68ADitaVgOO
	 BWrGsf1ZJQttTh7H4aZYEmztjkILimL0l1As92laruRuSd1tbIKFsY4Y3YfEpkDjzCeCr
	 /5wdDv/XxVycCnwEuXyKCgxdsQYSkGFfhPMBvWd5Gg7k+nA/VIki0PWwWDUGmExiSnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591047;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=KhJUkQPZyN9y1v9H8Yod+/wivWEUr38YDDHMmnx/a9Q=;
	b=jOhlOQbUopXLhbPksieVU7o+jqovhqRtHF0BD9roKxfs78/qugQuHrko3ogL5QEVwuvi
	 rmkR0Jc1XlrmHlc1cl1JjQ9SzVCYUDKcocJnAbNxoFKzfH3l/5kmGz26BbU8+eJX89Yg4
	 RbRsRqk8c6yQe+19gLY6vI+M+27ZMMe+pJslA9PtIXoH1h86NHJ4F4H1dqkhL+LRGhErz
	 mJ0FgheTslbekkpbWs+32NDy7IgS4pv/gomtgh5yV6WiJ+KA/c+/LOo/lJE1AIX+xlGs9
	 S74VUdT/MG1kh3z4xeyMym4TyTcgHditbnFpG7boZX0jlSXVO9zF6dWkHDcRHTvLTMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCC2606A6A2;
	Wed, 25 Nov 2026 07:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BCC2606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=KhJUkQPZyN
	9y1v9H8Yod+/wivWEUr38YDDHMmnx/a9Q=; b=GjyI2GxJDUn0INHpCDiXfMdtu4
	AuPrR/zRrWiuA9dUyMbDeKbTRVh+qQjDVmMslc3pj+FEyHqaCvO1XUCIU2i0l0Zq
	CjBNqu5iYRCpemrTIYAc0BzJJSL10GGGGY9PNXATU1/s3ETZEY1y29yzJTBSy0KH
	JLF+q2FB0lOXznAoA=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.108])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkAGLQNiiwZriuEyAg--.64993S2;
	Wed, 25 Nov 2026 15:16:51 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] net: usb: mcs7830: skip zero-length register dump reads
Date: Wed, 25 Nov 2026 15:16:49 +0800
Message-Id: <20261125071649.7052-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:BrQMCkAGLQNiiwZriuEyAg--.64993S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4rCr4UCryUuw1xCFykXwb_yoW8Ar4Dpa
	y5C3yjkFWjqF4DC393A3yjqa45CanxArW7C340vwnxuFn8X3W7Cry8C3Wjgr1Yyry0yry0
	yFn0yr4j9F45CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2fMaUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUHD2sFqFk9XAADsx

mcs7830_get_regs() passes the user-supplied regs->len straight to
mcs7830_get_reg(), which submits a vendor control-IN request for that
many bytes.  ETHTOOL_GREGS accepts a zero length, and ethtool_get_regs()
still invokes the driver's get_regs() callback in that case, so a
zero-byte dump request reaches the driver.

A zero-length USB transfer has no data stage and the USB core treats it
as an OUT transfer, so submitting it on usb_rcvctrlpipe() triggers

  usb 1-1: BOGUS control dir, pipe 80000380 doesn't match bRequestType c0
  WARNING: drivers/usb/core/urb.c:411 at usb_submit_urb

and taints the kernel, which becomes a denial of service when
panic_on_warn is set.

There is nothing to read when regs->len is zero, so return early before
issuing the transfer.

Fixes: 2a36d7083438 ("USB: driver for mcs7830 (aka DeLOCK) USB ethernet adapter")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/net/usb/mcs7830.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/mcs7830.c b/drivers/net/usb/mcs7830.c
index d6698f30218d..f5606f2cea05 100644
--- a/drivers/net/usb/mcs7830.c
+++ b/drivers/net/usb/mcs7830.c
@@ -437,6 +437,8 @@ static void mcs7830_get_regs(struct net_device *net, struct ethtool_regs *regs,
 	struct usbnet *dev = netdev_priv(net);
 
 	regs->version = mcs7830_get_rev(dev);
+	if (!regs->len)
+		return;
 	mcs7830_get_reg(dev, 0, regs->len, data);
 }
 
-- 
2.34.1

