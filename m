Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681328;
	b=L/wB+veZCytprEaVYy7gSws50QhRx1pjEG8GvoGCiML3r7P8YmTwPmODZhhrLQ0LS8WV
	 Wft5tiK9ZFLIa6UlkOl0BXAvqNEc7YxIuIkjM1D1NiAfganKWwlG9RYdE7yJXeXg8kFPP
	 BXH+/kem3HGkVx1t1IteDTfYilvFc18flOxHqBvotoLNrsHKrA6QY7McAKtfDo7m0jnEn
	 u1ofh0O787jGocIPaM39LUY+d2TD4WZAK/OCJpQxQd/A2LwG4Hdr1hP3YeDEjLqpckb9L
	 Dfwqewjm3ja7gGABbjnlYsh5i1MyXVjGNvWkLjFbGTmwGThw9qgal2A4Ga+VY/dWsNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681328;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=FmikAp2+qSipaQtzAupGaAipdwzh2wlO7XfeF8y0Ows=;
	b=OGs2g8hwkCyNX5mwEJCxkjYAjxSXiZh4A5JbQqefUyoowd/h56KMUAzYqx+9GBargfaj
	 ZTK4CY2vWkoJ7lgVIsUk5eSgC4EbWJAha9TvNtEwqoTRJp8tZ00Vx2Upa0m8Lm+K3ZR1P
	 pWlitHW5oMWmZd9GQLW76VFXBKkFcMMJTFfJNpytcjnNfG2cVgA+odgEkLOpoctkL0Fi6
	 P+QENkECpm8JyGogqaW1Z/SjXYDcB1JMX71dnk5eYAk4dig6iYSpyTeCb/oC3mKhdwVzW
	 CjKXqXoUetCTX3tLktdzvgvAGrjiI5dYutEhF/PrYQsJkf5IVejdSX1ERHJQvEWp9rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6089B606A337;
	Thu, 26 Nov 2026 08:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6089B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding; bh=FmikAp2+qSipaQtzAupGaAipdwzh2wlO7X
	feF8y0Ows=; b=ZhkdlZ5jSMyjBAAWc+ZccNR6LIwwWKa1eTDCtK+UNMFcSrL+hk
	0JaMk2b//3M6fFt/jFtVd0oFe/OY88Q7MxRqBKq+cGthmlKxPeoZBO49985GwvQA
	BPUDIYTsIRCUfaShGKnoAtJ0/sD5xD6zVgxU0mcTNp8J8l98APp4NlZ5o=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.43])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkCm6wAZ7Adrf+JAAg--.50063S2;
	Thu, 26 Nov 2026 16:21:46 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v2] net: ethtool: do not call get_regs() for zero-length dumps
Date: Thu, 26 Nov 2026 16:21:44 +0800
Message-Id: <20261126082144.3295-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <366216bc-ccc3-4547-8587-87cdf35f552f@lunn.ch>
References: <20261126015239.6038-1-25031212351@stu.xidian.edu.cn> <366216bc-ccc3-4547-8587-87cdf35f552f@lunn.ch>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkCm6wAZ7Adrf+JAAg--.50063S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyUuF1rKr4UGw1DAFyfXrb_yoW8XFWkpF
	WYga4xC3Z0kFykAr12ka1rA34rAwsxXa43Cay8Aw15Ar15Zr1YgFWfta42g345Gw4vqw45
	tayYqFWSkws0kaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
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
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2vPfDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUJD2sG+dmttgABsV

On Thu, Nov 26, 2026 at 03:58:03AM +0100, Andrew Lunn wrote:
> Your commit message is focusing on USB too much.  Very few Ethernet
> drivers are USB.  Since you are modifying the core, you should make the
> commit message generic.

Agreed, v3 describes the ethtool side instead of the USB stack.

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> Who does this bother?

The zero-length request itself is harmless, but it now trips the
direction check in the USB core and, in setups with panic_on_warn, turns
a privileged ETHTOOL_GREGS call into a kernel panic.  That is the same
class of issue as the plusb fix (CVE-2023-52742), which also carried a
Fixes tag and a stable Cc, so I kept both.

> Some of the kAPIs consider passing 0 as being special.  It is user
> space asking the kernel how big a buffer is needed to hold the full
> dump.  The kernel sets the value in the structure and returns.  User
> space then allocates a buffer of that size, and makes the request
> again.
>
> I don't know if this API actually does this.  You need to look at the
> logic and decide.  But by returning this early, if it did, you have
> broken that.

I checked.  ETHTOOL_GREGS has no zero-length size query: the uAPI tells
users to get the dump size from ETHTOOL_GDRVINFO.regdump_len, ethtool(8)
does exactly that, and ethtool_get_regs() only clamps a too-large
regs.len down to get_regs_len(); with regs.len == 0 it does not fill in
a size.  So the early return does not remove a size query; it only stops
asking the driver for a dump that cannot return any data.

v3 to follow separately.

