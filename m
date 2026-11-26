Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681686;
	b=UdR6hUpIvqJNou9sBZxKXVajmGtKYV5jax3AFgry6TfpedEldbRYsNEIOq3P8hrgrxkl
	 iDTurygOPetaw50JjQL+zRrXGAFnWu0yaNH7E+0+GUHX5jcaDBk1BODRYLM3WqGNh2tkO
	 GiLRP7cT9H5yUVpmON6NrHD07T/2cR4JbWJaRbVTBCf5ctmIULhlmX97XVRQO4OyYe3Ef
	 kflV0QqsoGYm24feO5/oShEiKJ2kGdK6BZqP8y7uEBXrzKNUSoZd7SmjV/zG6CLP1OMSz
	 8XJbvwJRG1f0GP/09sJntw+jhxnhek834WSQzDx+2hXs70QFP5lmYlApQ+ZskjyeV4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681686;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Tvyoumzgqi7KLyjbaj6PRFfPo7ZxGlMt/3jupVpnLaQ=;
	b=Rg53hb03ozlwzhYTSWSVIRNuLfqAd0Y5gI82kbxF/cW1JGTB+gwwizcqyMltepGHyF5X
	 J3TS21a3X3G4cIUCGvO62aNCawQk/VZEGxLWSyCf9c94b2ntkKiJ/UB0SajA774OdsiLM
	 8QJMqBOxXjajN0C9m7hFj4PFB0ezkCMmtmNPBSerSk3QLWXIaOp8FfnYzd+OUcbdZ2sPG
	 pswW5LLnI8fZ9TEXjFIQsqVanMY8/GtqdQpq1CgiyUDAgkHhhQsxblGEcyhaXBzU2wo8Z
	 /uQJ8lRXwJL/SwL1nACe5hDEB7w4uuBtWCwofDFPsy5DTbQ2OVNTCXG7kbaazco3Bbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4C606A31C;
	Thu, 26 Nov 2026 08:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CD4C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=Tvyoumzgqi
	7KLyjbaj6PRFfPo7ZxGlMt/3jupVpnLaQ=; b=MNgNmLSgu/pFzwV2w1rVGPdUbw
	TabZLLSVEROch2AcOFgG/cZW4eiHikD5P150NPn3lkZXgf0R1iHIhn1+0nNv4kLI
	XiXl2aHoIKCZoA5YNkANhXJ1AYgP3hvYY+Yxh7fbUzv/CTaEk7JnaINpMhyfrj9Z
	x+c5mKNUM3GCf/d2I=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.43])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkDW2fyE7QdrNlZAAg--.48351S2;
	Thu, 26 Nov 2026 16:27:49 +0800 (CST)
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
Subject: [PATCH v3] net: ethtool: do not call get_regs() for zero-length dumps
Date: Thu, 26 Nov 2026 16:27:48 +0800
Message-Id: <20261126082748.2798-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkDW2fyE7QdrNlZAAg--.48351S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1rtw4xWFy8KFyDZr13urg_yoW8tr1xpF
	WDGay7G3yjqryvka15Ja13t34UAasxXrW8ury8tw15Zrn8Za1kCa40ga9Fgr13JrW0vF18
	tFZ0yF95Can8CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBKb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r
	17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r
	43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ZL0UUUUUU=
	=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUJD2sG-Ev87QAAsK

ethtool_get_regs() passes the user-supplied regs.len to the driver
unchanged, including zero.  A zero-length dump has nothing to fill in,
but the driver callback still runs and may use that length for its own
I/O.  A zero-length transfer cannot move any data, and some transports
report a warning for it, which becomes a denial of service when
panic_on_warn is set.

Return success without calling into the driver when the requested dump
length is zero.  This does not remove a way to query the dump size: the
uAPI tells users to obtain it from ETHTOOL_GDRVINFO.regdump_len, and
the core only clamps an oversized regs.len down to get_regs_len();
ethtool(8) uses regdump_len.

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
v3: describe the ethtool behaviour instead of the USB stack, and document
    that ETHTOOL_GREGS has no zero-length size query (the size comes from
    ETHTOOL_GDRVINFO.regdump_len), so the early return does not remove one
    (Andrew Lunn).
v2: handle this in the ethtool core instead of the mcs7830 driver.
    https://lore.kernel.org/r/20261126015239.6038-1-25031212351@stu.xidian.edu.cn/
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

