Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06AA2E764D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 02:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788836191; cv=none; b=umSa6apMDYqGqq3Vr92mvRtGU4rvvSpCxFI3Le2lk+LruLrjxDQqTJnem+kGaZCpMx3mlXJM+R4KPina0vLpekvfeQEsX2/wKxnZ1MeQ1ZPNb6y8f9OkkHzsPEpfLaFfaLodHrsW5+mX9iv8M6Th7y439HMKWYV1GVdJjkdQJcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788836191; c=relaxed/simple;
	bh=hKghPMvsY0e6k+kW0WDfNUw/HDe44DfIcOTDHpt0vfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYdv26C5HXWrRdaATtMxKFzPWB+5jwH9q2uAhY33HiOFSeDaPxquQ7E2NmEIaF7x83b+F+ltvRfOWfmG2JeewWcGBcwd29HLxp73UuAPBG3Qf+oQD/AyaJSmTcjDsihGFO//Vq8QiJuhmW76Zy4Go5v5sw6WEjdBWyEIvUW3IiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=H2yCuUhQ; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="H2yCuUhQ"
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id 3l7yxsMJRc3Xs3m0Vx7qJj; Tue, 08 Sep 2026 02:56:23 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 3m0UxdekjMSoY3m0UxtpZn; Tue, 08 Sep 2026 02:56:23 +0000
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=6a9f7957
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=Zo5euW2OAAAA:8 a=hKUfJe5KFNZvrTfkyfoA:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pzu+31EHQDtgHMoLr2rB9t7rnhgD7c+9/SW4rLIamaA=; b=H2yCuUhQ80IFtzJJi9mKVHXYkd
	ARjvM4XvKTcyW9NyOHqGhSy+LZ1eebRRDRXprtFQsZ4y7lPn0DQlB1e2GPjt+4JDIPf10AhD+Tb7a
	KPMZUhUpvGuSFqxgE3ShWq2UaPEygEoU1ouJhMP0mDFn/RybUeH4/W7LToQb32i4U6FOeKT6Lc5S3
	qG/5idH5Sm/Vcn4OEy5Vh4cpVhUQ2wZvIQG//Hni3F/uz2Oq2/nDFg/pTY5v++32GbZtH+dqdLXvu
	IBS9NoGg9ntY7X29R+ioKks6R2zag5HCC8V4tUpmcChTSqAPD9dR+fE+xegcRgzot1Q4Bsz7xhVvA
	0707Ua5g==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:50500 helo=[10.203.100.33])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x3m0S-00000001ua5-4B56;
	Mon, 07 Sep 2026 21:56:21 -0500
Message-ID: <ce401b42-9dfb-4c8e-9051-7ba08c107382@embeddedor.com>
Date: Tue, 8 Sep 2026 11:56:12 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: tenstorrent: Assign .num before accessing .hws
To: Aamir Ahmed <elb12345@hotmail.co.uk>,
 Drew Fustini <dfustini@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 stable@vger.kernel.org
References: <AS8P251MB00013BD9A093C06D2D60E10EC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <AS8P251MB00013BD9A093C06D2D60E10EC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 125.195.69.90
X-Source-L: No
X-Exim-ID: 1x3m0S-00000001ua5-4B56
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.203.100.33]) [125.195.69.90]:50500
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDUIaO6373ILC0J7zTT8X74khN8BwXzMoZf6XSiejyBShQDV6x/5JaMOZ3xtuK2oIOVnUdbYWixl5EkoWjku+PuI7sQ9AZPlkXIMgzT4fIttU9rh27ZD
 IILBPEtkiiqxL6AQYok6Qr/01cxCaTarEFm3B16xrQAoN+3WvNc8ApAN0IAl29P9kopYgjM3ISIaLeQ/FxiKQSqQBmPhG+gJCDM=



On 9/6/26 05:48, Aamir Ahmed wrote:
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
> about the number of elements in .hws[], so that it can warn when .hws[]
> is accessed out of bounds. As noted in that change, the __counted_by
> member must be initialized with the number of elements before the first
> array access happens, otherwise there will be a warning from each access
> prior to the initialization because the number of elements is zero.
> This occurs in atlantis_prcm_clocks_register() due to .num being
> assigned only after every clock has been stored in .hws[]. With
> CONFIG_UBSAN_BOUNDS and a compiler that implements __counted_by (GCC
> 15.1+ or Clang 20.1+), this triggers an array-index-out-of-bounds report
> during probe, and with CONFIG_UBSAN_TRAP the first store traps so the
> clock provider never registers.
> 
> Move the .num initialization to right after the allocation.
> 
> Cc: stable@vger.kernel.org
> Fixes: 23c8ebc95284 ("clk: tenstorrent: Add Atlantis clock controller driver")
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>

LGTM:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Also, see more comments below...

> diff --git a/drivers/clk/tenstorrent/atlantis-prcm.c b/drivers/clk/tenstorrent/atlantis-prcm.c
> index 6d4386eeb7d..a68534a295c 100644
> --- a/drivers/clk/tenstorrent/atlantis-prcm.c
> +++ b/drivers/clk/tenstorrent/atlantis-prcm.c
> @@ -796,6 +796,8 @@ static int atlantis_prcm_clocks_register(struct device *dev,
>   	if (!clk_data)
>   		return -ENOMEM;
>   
> +	clk_data->num = num_clks;

Looks like variable num_clks can be removed entirely, and just do:

clk_data->num = data->num;

Thanks
-Gustavo
