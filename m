Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.16.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882167;
	b=4QhPUm3CDwlyV5FLdjd7QZ/IxVyqsDEfUu+MbfxAYoStobVZlMzMrHP2iapWrZBsWMn6
	 B1oGWeHTEsosk1flHQkXVPao3zsV6zuGoxx5rmwVeUDfK3ExGMgfCodcx4B5KpCKQMRwY
	 k3dqhaJOYZSQ7FB1kWdBVb2ENqE4BjMdk2upEl+fOttgm3h3N/9ChXrkxF2kBOMpD+jqX
	 2LWexcl7FUofRVOWmFltlEmGljDd9mUWFrY4fqxxhzUeoJ7B8RKZtf4Pe158m5k4b2mP3
	 ECq6eC6kKv/GAtZRjYe+3p8CCrKX+rhBv+VBAe0Q4Jxbn/rwx2Bj1fTufaff9VxJ4oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882167;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=YFEMt68OTUAuLc8xbBf8qhNhrtZH4z9jKejIQ0be8PA=;
	b=pKS1/slI5Eq/iA856y/ftIVvPtVf4NOH8hs++yq9iyrZNIj1kqF1sDXjrUy35R7QtU4I
	 bZN+JYH+l4oPI9b3kHtZ+A4m1urcuMN6ic+6cnVrqzLsIjHQE/sqXANRj/4C4N7jCOJMj
	 yRdHwPwpWlYz3Tu/5JPfIjAfCgwylDJ19gf5XH2JL7aHAd1nbKTZCKDqrPodPgTN3HKtg
	 yH6T8Dp5tHecT5+BPfZgZ4ERsnUJpHg4dORq9VHARDnJAmHLlrBZFZ1NWh/+a191DP1x3
	 VsmLuSLxezvRRSJVANhDA6dMQTu2b4+cYUpFW5pfXy3yJYsp/2DXtP6RZSjicTElU8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=WtvC0lCv;
	arc=none smtp.remote-ip=54.206.16.166
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203F606A335;
	Tue, 17 Nov 2026 02:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2203F606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=WtvC0lCv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794882129;
	bh=YFEMt68OTUAuLc8xbBf8qhNhrtZH4z9jKejIQ0be8PA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=WtvC0lCvdz+ozCGLRNRQ43WF5h73ah/IcSFA2T7pditxkLHV0E3N9RW8PX/qPC4KF
	 U8321eTgdshv4JvyWX/+VoeQ66jmI38MeO/p+5APZsk7nVWw1ZdYq4yVgTve9TKHTp
	 iPovXmA3cxgVJ+TFeIfpLxIQSLwglEnyRKcTWNi0=
X-QQ-mid: zesmtpgz6t1794882123t8dfc0e95
X-QQ-Originating-IP: sQqB+ujerewejO2er3hRMdg9WLwDzslkW/qZ6voe2Yc=
Received: from localhost.localdomain ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Nov 2026 10:20:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4569123318179278308
From: Xue Haolin <xuehaolin@uniontech.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: sstfb: Error out if pixclock equals zero
Date: Tue, 17 Nov 2026 10:20:31 +0800
Message-Id: <20261117022031.252357-1-xuehaolin@uniontech.com>
X-Mailer: git-send-email 2.20.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OE2SNMSfMbmOkbcXtbV6xEXhgffGg4Q6JEDvh2xvbnjUCoAQJRu9zYX/
	slXsqg46L7AOvOhu/Wd6LqcjwlSObMfkM96Zg7sbL7GqWZYQDDUL/+0AgL7yeSMq0Kw9qjI
	xZldi5hM4ODMHlCTDJ05IqN7RSbv3eB+gwp2/crzE/aZvFrd7rcOLgLWhOAO09GDNAPNCql
	TRhJGmKLXfJ99JK9TzROCK39G35FqoSZ2CbrkS9C9vm5ETopPAWD59CL6PtZvzIIvn89IAn
	MCh2ToWnMhZVFQXOizzq8tLm8ywGjL7z/Jc8N4o6FsCPDCJuNtE+mrNhNVyEYVEDmnBKpau
	0pDbw0IS7V/VGLYaVrKqr4BHuSve2DmMbXjB5Lt7ll4CJz7GUuG41SnKt9W7k38u2MWErL+
	Qz1rxHd66FslN9Ry2I6TFSaH71JkCU5JM4vuokxZrokbHbcH3CetvZN5rLLU+5YIjgj/xH+
	00HtH9VglGojgUjxLaTcwXpm15DjgxwXjWHD9gX+VRz+rFbDaYZInRJFKyt6iFdzGj8eqiM
	Fc84ayzivAC73O2ArQ6Csr6QKYpB9D+k11b3dEQzPWJpjwSuttdR4XnV0IgIYXbhIp2tp1J
	dEdSZxmXPDUoLsjWfPhRAfzwyWjQS/8hP+xWTR9IyEHlz4KMO67ylIYhuprlbl8+9/g0ATM
	gX/e5PwTvKk3Ea+rj+Tm3FLE/ttTP6A+Y8wmTIqHgACUYKto9JltECaeHSBFsp7ULgLdBtL
	cuGN+uicz4r+SSYuaEcOMtyPskEPgHI9kiFSPXaYdO+MZJpz8kWGZGyh+SYhHW8BZ++irTS
	0pTVckcpPeAmEpJpwVa8+VxpIfdnj7DSX7M/4aQc+C7DatkgQHxlaReoWaUlSmacQYd8MRs
	YQGAK1uY+I/D/q+gSgX9O7kaYv9ZQcemL/RYELkyKf+99Z3HlQZlE3uwoixBpzjddsJqfTz
	ISSHan7jJDzv9edlPdqeFIqYFXayeEVEwzxDwMC7P/Js0+ltwZOQQFXGv2wHMjVD5yl/ly+
	g0dE3OvHTnn0gCgxUtKhp2OBk3hQgUq15vgu3evQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

From: xuehaolin <xuehaolin@uniontech.com>

The userspace program could pass any values to the driver through
ioctl() interface. If the driver doesn't check the value of pixclock,
it may cause divide-by-zero error.

sstfb_check_var() calls PICOS2KHZ(var->pixclock) which expands to
1000000000UL / var->pixclock. If var->pixclock is zero, this causes
a divide-by-zero exception.

Fix this by checking whether pixclock is zero at the beginning of
sstfb_check_var(), before it is used as a divisor.

This is similar to CVE-2022-3061 in i740fb which was fixed by
commit 15cf0b82271b ("video: fbdev: i740fb: Error out if
'pixclock' equals zero"), and the fix in savagefb by
commit 04e5eac8f3ab ("fbdev: savage: Error out if pixclock equals zero").

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: xuehaolin <xuehaolin@uniontech.com>
---
 drivers/video/fbdev/sstfb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index 8e2c2421028d..de0769eb4a2f 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -359,6 +359,9 @@ static int sstfb_check_var(struct fb_var_screeninfo *var,
 	int tiles_in_X, real_length;
 	unsigned int freq;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	if (sst_calc_pll(PICOS2KHZ(var->pixclock), &freq, &par->pll)) {
 		printk(KERN_ERR "sstfb: Pixclock at %ld KHZ out of range\n",
 				PICOS2KHZ(var->pixclock));
-- 
2.43.0
