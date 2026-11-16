Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.248.49.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794805867;
	b=HKaUQJd6vxpdpLM1FXy5BU4yETtVdrPE6KxeLZUlzg8ae1vp+8vgQ+/XzUYBemZj0bum
	 vVdQ2HY4m49hwmkpOiYgdGtzvHEzQyBQjoVFIhYxJ/J9SqOy3ydHAt4LMVgaxd5LM1VZI
	 1L31gN1oGiTxqXHULKzunDJ/KPP9Sx+gtdGGEqhpkqe00j8WbLPnVWPorQPX2jWh6lpgW
	 PK8/0ljT1OHygaOle81nofAQfWIiydkwfoUXPEbF4hZmmxOLz6b3NCszVuXByyucPzpIz
	 bF96itIr6SRG5YOjOy582i/sAn8rDK/D5TkIp9nMu9lAm85cFl43FA3XzdRbfTyQ+Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794805867;
	h=DMARC-Filter:X-CSE-ConnectionGUID:X-CSE-MsgGUID:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=z3Y5/y6k0p/Yew9uyaMnVEiLx5AALopiEmJW5nntoUg=;
	b=GYtn99/zz7yesue64eAt3+y39hVX2F2vavGKfw1tT07NJRMWmfaXxYCugBfivfgGyUSO
	 HZzFTDrZxn8F0TX593qzRD8za3Yw44Mxkgpn8BGIMJvxKCrhUtsC3R/mKO4/19ic2TFv/
	 EluvXa3OQlhULA47rAaGQhb0Y6FxM4dSzvPv4JUolXAOdtJZUdivoJ+PsURpMRhqCJa1U
	 BNE4vAsHswy1wbMBYgrl8vfy79ovUi8BZ0lb52FT9lb2phyr0Ka9bDEFwCBg2ez3dsmDS
	 Ei2bJEhzGFRuC4IrznQA7AKooYecyxuGVqF9GyzeS9AHkhXT9zHl/A6uwAoYvhflFEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=socionext.com;
	spf=pass smtp.mailfrom=socionext.com;
	arc=none smtp.remote-ip=202.248.49.38
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9007F606A323;
	Mon, 16 Nov 2026 05:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9007F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
X-CSE-ConnectionGUID: nbNQ2bVBQHiNPVp/Ylioww==
X-CSE-MsgGUID: F9IYLI47R2+n6i38I+hmCg==
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 16 Nov 2026 14:10:58 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id 14E922091483;
	Mon, 16 Nov 2026 14:10:58 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Mon, 16 Nov 2026 14:10:58 +0900
Received: from [10.213.138.143] (unknown [10.213.138.143])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 2A86E10D987;
	Mon, 16 Nov 2026 14:10:57 +0900 (JST)
Message-ID: <2caa5a50-d3c8-4195-889d-52667dd95974@socionext.com>
Date: Mon, 16 Nov 2026 14:10:57 +0900
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [REGRESSION] net: stmmac: v6.1.y clears xstats.pcpu_stats in
 __stmmac_open()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

A regression appears to have been introduced in the v6.1.y stable series
after the per-CPU stmmac statistics backport.

Since v6.1.191, DMA interrupt handlers were converted by

     commit 52002cae02db ("net: stmmac: protect updates of 64-bit statistics counters")

from:
     priv->xstats.rxq_stats[chan]
     priv->xstats.txq_stats[chan]
to:
     this_cpu_ptr(priv->xstats.pcpu_stats)

where pcpu_stats is allocated during probe():

     priv->xstats.pcpu_stats =
             devm_netdev_alloc_pcpu_stats(...);

However, __stmmac_open() still contains:

     memset(&priv->xstats, 0,
            sizeof(struct stmmac_extra_stats));

which clears the pcpu_stats pointer allocated during probe.

As a result:

     probe()
         -> allocate xstats.pcpu_stats
     __stmmac_open()
         -> memset(&priv->xstats, ...)
         -> xstats.pcpu_stats = NULL
     dma_interrupt
         -> this_cpu_ptr(priv->xstats.pcpu_stats)

which appears to leave xstats.pcpu_stats cleared after allocation
during probe().

v6.6 and later do not appear to be affected because the xstats
memset was already removed by

     commit 2eb85b750512 ("net: stmmac: don't clear network statistics in .ndo_open()").

before the per-CPU statistics conversion was introduced.

Has anyone else observed this issue?

Thanks,

---
Best Regards
Kunihiko Hayashi
