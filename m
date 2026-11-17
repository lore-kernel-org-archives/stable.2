Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.34.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794885489;
	b=n3RT/8PShNP+8drx/REZaId5iCz0dZriuQPkooEIDBsW8e9rTNF5YQljtZHw2SQYlcyl
	 BYESuX1gyygiW+5AGvedyL5lzpTYuzSZr/AHoqbVTlqrLmsypwd3VTkLm+kFckV8lY2xu
	 fgqKrJkqpEuyjKQjKg616lsPmmzK4Jgt4jZmU0S8zh5HINOt9wucmbucvM+J9CaFuDujB
	 IfyYnv7yodbQET5e+hCR0p7TSKjk10nEw1aCh8tbR82Tscr27NsHik7JzXPsTkCRsj1N0
	 WYqzVDejxlpi4gI5WoYJxqPQBvYkBL4yiwJeMmvdEfMPxqqGrP4BllJlt3G+Bt4a9QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794885489;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=XEX/B5fm61cWurYTFjfzhFA0YSoedPa2iWt3d/nCGIw=;
	b=GMZHzQV8ZXUBmQQCFZxWWdPJxFvyNUeddjPJL2ve71T+Z2+A7wWac466IBtaAEpWjKc4
	 Q6/kysCG5Q5RgS5TQYhf70Gf49twRmTvl8qnfJpjvrxF/1rgKID6FT9F5PcIEhR2myKHn
	 nBzO3QGzbR21lJhgIZsA+pPFSWjc2YS5F/cHuErP3YZvj3V5Fl9n8GlKrZSw7rGOe0ti/
	 95A1Vf/c7mx3Iup8S9p5oyfvlklHTEJfqMtXEEC9/aA9AqlzetGrqaIcORHzw8ahMKqoA
	 ytzl47ZQrPCks4AILF2+R1MXkS7q4hpzxdSjC1NOGtlZEZJ+pwnaGS2/COMYLnrMBog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b="S/6DBJIQ";
	arc=none smtp.remote-ip=54.206.34.216
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA09606A31C;
	Tue, 17 Nov 2026 03:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CA09606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=S/6DBJIQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794885457;
	bh=XEX/B5fm61cWurYTFjfzhFA0YSoedPa2iWt3d/nCGIw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=S/6DBJIQH+3DNa+hl5t3xxhlx0Jdf4a18F9ouPJpD6AsGVWppLRx3SCLQfl9KWXu0
	 3aQ38NcT+hgXHrF02hCdUva1j/4xkcRZ0hdqnF4cE2LeY9KVDAezkVxWkjERLBwtKu
	 IU0UG/h0mawXl97RctjQ4yLqKa7JJTRduLoO625I=
X-QQ-mid: esmtpsz10t1794885451t44789937
X-QQ-Originating-IP: yzdTpx+SJXNUOYYrApmlvTnIUsqXyeyb1ObAEMRP0rY=
Received: from localhost.localdomain ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Nov 2026 11:17:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18232043476698029590
From: Xue Haolin <xuehaolin@uniontech.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fbdev: sstfb: Error out if pixclock equals zero
Date: Tue, 17 Nov 2026 11:17:14 +0800
Message-Id: <20261117031714.259053-1-xuehaolin@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20261117022031.252357-1-xuehaolin@uniontech.com>
References: <20261117022031.252357-1-xuehaolin@uniontech.com>
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
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M6x2tnEVru4e7GBRUJQEC7FKeapgacBqX6rElXPVDGi2MWqDBI+0Sbdt
	1abI+CFtrobSXlj6X529C80d26SKma1p7SUs/ePSfVxkRJRMuyz7uHQa5gu1mQs+vWcq2MC
	aPDPF0Qm7smp5jfO1/33K5HleQ4dElzcyOHlEamMQdKNig8Xc01zAZbzb+LdaIaJXfhUfKU
	084BxXj9k6X40tCxxBDjOhSFEgWsiweqCP2qevBMSB0/+jaRLTzWpIzrUgotEgSNltxoqIT
	YC085xYb63Qnrs9BzVT4cQ1Ew7RscFI9bZ6hzzSRE6AvbM5M0W9M/dBHkBcpcm8NnPwxjpN
	8r2BNdQSwau0o2jjulsvYbPoI5M59MztiloVl+yDdMNy5vYnzq7f7pwfoaG4sXAQgKCRzvx
	JbRxz+6c2dindBKG8RgfeBbbW6aCDw5iBOM3RfPzZYM23m2pNlzAqN2umNmUlhMadc2FP14
	f6Q6qCNEH5cCLDbOmsapk+RNwwtLdpdHY36qOyfsqcpPCH/JhirlN4mSEJmbIayZF2a3Y88
	9Pjw+P1jXa3VezUK1bgStmaFIUxN26WvhjVFM1JvEfgiYqPF2mADA3tBpoR69OzEjuRNCp/
	vkbN9etDVuuR2ny57eYEvoKDbmaFz9BtgQYVof54mBn2+5289x0H2yJXMIAj4/tF7x7izmo
	K0MPP4gjgmp0ldGsSxAzlinQ0sJujGkbarjpRkAMBro1Zv9FumQhp6fO7I9PO2NBJwUc4Kv
	0zM9TdAndC4CQW76AFEiCqXvVlxP8bV4RivoR6rwM+TXPTRn4RS920eh/OItPqIMgODrDpC
	YUovNyYp1LKPmsb5S67VRhrbsExFr9QguTYZVAQSXt55aQ6L7tE/FN8MFAdOASRh7vr/bEI
	ZYqtSilG8EMqSgQG/9aSV7ppMHnEJGOgGIL7OYCdG/tWiD8l2a2yZQj0I40DHTPl4FGQJyx
	IICfUBuk1b5BI1HJkED6hAKNKPovTPs/nIUdCa/bzmy7yJ/qcjn1g7sLuP3jisdGkxMrosC
	EDgZt4UZPPZ+OPyof7Pf0bRQfrrwdqzbuka4C21aSd944rSSHQCBW7Eqhub72VZnBC7LPKc
	w==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

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
Signed-off-by: Xue Haolin <xuehaolin@uniontech.com>
---
Changes in v2:
- Fix sign-off to use real name "Xue Haolin" to satisfy DCO.

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
