Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657989;
	b=IajSquxG6Yjqp7bHTxPsKEq9gsaCeTs5Xii7AIBnhIl3+mgSwPvvnDEWxa9J2YQVdz46
	 uXhOGJIin+lrMgWz6is2/Xt8TvhaRhnzR/KUen/vo0e2EZ3sAcSmNUdIyRh2ysL58A4W0
	 oD+Elfo/7hjQnmUEiX7LpmAGgjR1riulng5ipr8wY5YgCAu+sAYKgVofP3tqSakW3LKws
	 5y5OG4Uq0mRy/sTl+d9Pi5aJ70pKUjS9fJr/iGoTnxedVcBWPPab6+NUHiBA3EUdtB6HL
	 lPtTn7lJMDlMyrHmN2pb8wivoRjKtYtRlj7k19f0jsS3VFGvU87Oo83SzMOej0uiVzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657989;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=XYoKNhiIRj7Rk3BVZyqjQaKK/jkOxhj6H1RuYfK1i8I=;
	b=fIQhFH7zFMc0Ku958Nc2zlafp1QZqlFqkJvwMB+V7/vu17NZKvtoLP5vm3qBXRrWtuz4
	 rjIT6NAPqXIni9LeF8Dhjfkrd2I9ColXEqVnyrObXaMK3IeH93G0VJy7FG1gQCn8+9mi6
	 9hqPBoy49O84v2zJWwxjkI1eVz44W+29Aeevdx0+9lFG/za91teydp/Bxfs7YlghnBooL
	 xGBvpMZrmO+7t/kMlcYTDVA5H9M+m8JTcwuAOHdskeiAQfU2omfwBqONrOvwPflLWGzW8
	 veTa1ljs7XGeH8nEVCtGtwZuJgEymliDOqYPNnk6fIq8DPZfCF7OqBgk/9pfBr2Xupg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6718B606A31E;
	Thu, 26 Nov 2026 01:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6718B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=XYoKNhiIRj
	7Rk3BVZyqjQaKK/jkOxhj6H1RuYfK1i8I=; b=rqERrlG7xqtDTSJgHOWbLTNZwB
	5XZ2Gl6Iu9IaqLGFWX4fg9drRIIjsxPewxFYt06y+894G/zb9zgeZf9DwChv9TZt
	gw4WyvN70udSuaGu+piU/b9WROQpLe8r4bVGkggWHVm7P2ClhcVGbmtmHPB33Z9x
	S+F3SyHFR86rAR9c0=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.10])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkDG7ALokAdrmyg9Ag--.40827S2;
	Thu, 26 Nov 2026 09:52:41 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v2] net: ethtool: do not call get_regs() for zero-length dumps
Date: Thu, 26 Nov 2026 09:52:39 +0800
Message-Id: <20261126015239.6038-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkDG7ALokAdrmyg9Ag--.40827S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWfZFy8uF15uFyDCr13twb_yoW8Kr1xpF
	Z8CFyUCrWqvrWkCan7Wa1avryrJasxJrWj9ryUtw15Zw15ZF4rCFy8Ka1jgr15ArW09Fyx
	tF4FvFZ5Ca98C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBlb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVWkMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8gzstUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUJD2sG+dmIAwAAsE

ethtool_get_regs() passes the user-supplied regs.len to the driver
unchanged, including zero.  A driver that uses that length for its I/O
then issues a zero-length transfer.  Such a transfer has no data stage
and the USB core treats it as an OUT transfer, so a driver submitting
it on the receive pipe trips the direction check:

  usb 1-1: BOGUS control dir, pipe 80000380 doesn't match bRequestType c0
  WARNING: drivers/usb/core/urb.c:411 at usb_submit_urb

With panic_on_warn enabled this warning becomes a denial of service.

A zero-length dump cannot return any data, so there is nothing for the
driver to do.  Return success without calling into the driver, the same
way a zero-length read is a no-op, instead of making every driver check
regs->len.

Zero-length register dumps used to be issued so that drivers which only
report a revision ID could fill regs->version.  Those drivers return
zero from get_regs_len(), and the core has returned early for them
since commit f9fc54d313fa ("ethtool: check the return value of
get_regs_len").

The problem was found while testing the ethtool register dump path of
an MCS7830 adapter.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v2: handle this in the ethtool core instead of the mcs7830 driver: a
    zero-length dump is a no-op, so do not call into the driver at all
    (Andrew Lunn).
v1: https://lore.kernel.org/r/20261125071649.7052-1-25031212351@stu.xidian.edu.cn/

 net/ethtool/ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 80b7930b3fe0..e8af861ee5de 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1779,6 +1779,10 @@ static int ethtool_get_regs(struct net_device *dev, char __user *useraddr)
 	if (copy_from_user(&regs, useraddr, sizeof(regs)))
 		return -EFAULT;
 
+	/* A zero-length dump has nothing to fill in. */
+	if (!regs.len)
+		return 0;
+
 	reglen = ops->get_regs_len(dev);
 	if (reglen <= 0)
 		return reglen;
-- 
2.34.1

