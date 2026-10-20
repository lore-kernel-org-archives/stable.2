Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.202.115.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488007;
	b=yCuBwc3gRKtUE2InmNz2++xmoSwjhFh1aXCqOCdfgbvLx5UAM0KjiamVR8sSElSXVGee
	 QMUpv3gaCLVey5M1gDNuAqYqGhTLZmQYZpedH6L91ar+hbsr9R33ocKE1CQ6p6O/gdOK4
	 dRt70eiKDI8+aMpGZKbRV1MJEm9ApMyqik5Rg4JF7oCoEzSjrCgp0USVcBGndDb2yo2IQ
	 n6Oao+e6dC+9zVTDMiynVb6qpRhXYzHSjyqiqYFKNYnJoG5Z0JMq7ezab10zJMK09XJAN
	 +Kq1bDu4vbVuVYK5jMoYBJY7t2Z+2kaPEUQ05rtMu07GjjaFyyMSQQ7n2agGlYIfPzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488007;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=jwuobWmR9Q8VWmW6gJ1VH9w4uh3ahrR+9ZGTOu9b6cc=;
	b=za3G3MbAHKYLbutjIsFpM45fwBnV+BeCh/yElrcYCIImLcCz8L02T6839RrDtQVkpmAV
	 eEPrfcLqc0k3GukMrwwawfQfUloxJp6/QMrzkp8SVx7l2Z1dEyJ52134CI1nqnnlvKQ8y
	 MR9BzJvDB++k7gi0ZiNgGlIP/+NCX8wprWZoZnCoSBguCJ9qTsT0QKfTEPj5migbFCBXf
	 Q7hjpeSUJ94C7cVzu9BrY9jbQ+Gvs9FcymyZkk2AcWR5Fodl1p08cvAX9c8pbBzlgozZr
	 1x9VuLynFCDcKCht2+fWh/nUtBTPDtQNe/cuU6ZRVY4JizAy2FxxdJ85Oy6CqkEQkJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=cH+ArPJM;
	arc=none smtp.remote-ip=111.202.115.100
Received: from outbound.baidu.com (mx15.baidu.com [111.202.115.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2D491606A32A;
	Tue, 20 Oct 2026 09:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D491606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=cH+ArPJM
X-MD-Sfrom: zhangyili01@baidu.com
X-MD-SrcIP: 172.31.51.15
From: Yili Zhang <zhangyili01@baidu.com>
To: <zhangyili01@baidu.com>
CC: <alex@shazbot.org>, <ankita@nvidia.com>, <christian.koenig@amd.com>,
	<dri-devel@lists.freedesktop.org>, <leon@kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <nicolinc@nvidia.com>,
	<stable@vger.kernel.org>, <sumit.semwal@linaro.org>,
	<dawid.osuchowski@linux.intel.com>
Subject: Re: [PATCH] dma-buf: Fix IOVA offset when linking phys vecs to sgt
Date: Tue, 20 Oct 2026 17:19:45 +0800
Message-ID: <20261020091945.27327-1-zhangyili01@baidu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924065508.27245-1-zhangyili01@baidu.com>
References: <20260924065508.27245-1-zhangyili01@baidu.com>
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
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc7.internal.baidu.com (172.31.50.51) To
 BJKJY-Exc19.internal.baidu.com (172.31.51.15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1792487996;
	bh=jwuobWmR9Q8VWmW6gJ1VH9w4uh3ahrR+9ZGTOu9b6cc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=cH+ArPJMOsQJO7iUm+7EOvEi+++pZU3/JaYxUs6ekdZc36JciWX8UgH4nc4QjhMAo
	 25DxzbBvwwYSxgVWtm7MKy1B8GEmlFqz+FGPZyDvpQgJyZWrVwy1MBN5E2MxlVhFsd
	 lN1aEdG+86PH/bjosU81pIoiUR6IFTXO6nvXdkBm8zsYgWi7zEOhFacSzGGI+56FHs
	 nf+Q122GlQP39P4HT40PmltyzY1Vw1rZch4Ab3uQzmrJ9d3oGd6KY+ddGnG762opkT
	 og7Jlo4+W9K+zoO/66G3FQ3P7zl6ke2/rEgurgZIuE3KcjWGZr7xPjRixd6CouTojx
	 TIE11Txfll2qw==

Hi Sumit, Christian,

Gentle ping on this patch.

It has two Reviewed-by tags from Dawid and Leon, but I don't see the fix in
v7.3. Since the 7.4 merge window is now open, could it be queued for v7.4?

I'm happy to resend with the collected Reviewed-by tags if that helps.

Thanks,
Yili
