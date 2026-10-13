Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179D15665C;
	Tue, 13 Oct 2026 03:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863469; cv=none; b=keJpFw6Ib00YWbOar0Hu2Nf/zC2upK9ga8qLQsdQTw2rbN0Ao8Il5GwSdWTs/7fItrDUV/ltySTOULDa0bL/er/q0gAmalNgoIwoatmgVRtxS7CWAN19/nG1WqPLrhXxFhxNnsQVFGgL/KDwzZnLhExTU/BXfuf3ZawHvy6Caf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863469; c=relaxed/simple;
	bh=yemglBArcwT8m9tPh4+FJtX/iTPh1X2pDNleCqgAQ1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fx5UL/32njRsoNMd6XUwAG+V6aSQcwDJB8y/GOmrV55GdyD/Tpo+L8ZVCZFEFPkPTztRSD3lBQGzgxDdq/yPp+mT/+SZfgFl5Ojgiqwk2DYc+9CPDZ+geR2+cftKGK1huMhYVan2wW54swBMHVu11Mc6OhSgxqRPMhG8yiGzNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=eikIS3Xn; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=wjcWPpb+; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="eikIS3Xn";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="wjcWPpb+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791863466;
	bh=yemglBArcwT8m9tPh4+FJtX/iTPh1X2pDNleCqgAQ1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eikIS3XnvcXI8sKH/qg51szWn36Rux2p+CSBSC/bwvLSyKbw1HcWN73yP+xRkQSyc
	 +otRABm/bBargQTVfYihFbX9PNbY2ep4dgz5ktDkqjSWfxE16tS0Msj04q2XmZRP6f
	 2ElJpkXvRw+7tA5e8wDxEoPTddxW9Ho6Mg1Y7dujIukbnpTT8+Ptts9+S3zyy4aCih
	 n8vqCExy85aWw+XJfeLgC/4D9xhgr8b9DF//NncGNAXoC7ocrHPHyf4qLrsRt9Aecs
	 5GMg/icqN9M6vSSNFST4gThF1gaZquc4tgOeOParImIAPbDXUmZjNP2I1GgSYY0C5e
	 1c9ESjOAuyviA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 54C8E48E0C; Tue, 13 Oct 2026 03:51:06 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791863465;
	bh=yemglBArcwT8m9tPh4+FJtX/iTPh1X2pDNleCqgAQ1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wjcWPpb+ehrtrjAZHt/L5vyOM+8hmTmPEYQ2BHglvLBPfRmfkyv/QkUlovg1rk10Q
	 u/P8VhE92Vn33dZlvmrd2wql3NVUe9luEvhE4h7U9eQSGD/s+nFd1565QOrRb0yM0n
	 vM+ibVD6dTNT0nplCf9I4z/f1t/DkmnB/IdnKXRBk127QhMh7wuDQ82M+2gjIsCd0O
	 TiNhZP6/pXJViCTpVlPm4ZNqr2Wpyl1iZl9+PsS+taChOaO8zDkRHn2DkCNMcADTqe
	 lp7Zv6ZqT/TjuSVU+AW14QCJrptdys8U0ofTrzqA8WKubbakmVP0aBu4c0xjNCCGLX
	 ecIHascpNvxMw==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5014548E04;
	Tue, 13 Oct 2026 03:51:05 +0000 (UTC)
Message-ID: <c787cb16-bdf6-4e22-ac4e-c427fd9849dc@birger-koblitz.de>
Date: Tue, 13 Oct 2026 05:51:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8152: Use BMSR to detect the link state
To: Linmao Li <lilinmao@kylinos.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Chih Kai Hsu <hsu.chih.kai@realtek.com>, nic_swsd@realtek.com,
 Xiangqian Zhang <zhangxiangqian@kylinos.cn>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261005105249.1281648-1-lilinmao@kylinos.cn>
 <ee122a12-eae8-40a6-bad9-086228ae76f2@birger-koblitz.de>
 <b56624e0-d1e4-4b52-9d3d-de923c471a58@kylinos.cn>
 <6030ce9b-1e93-4d11-b9f3-6101fec2229e@birger-koblitz.de>
 <e7ba57f2-092e-4801-9659-7e7533f031c4@kylinos.cn>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <e7ba57f2-092e-4801-9659-7e7533f031c4@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linmao,

On 13/10/2026 4:38 am, Linmao Li wrote:
> Thanks a lot for testing both devices. Just to be sure, was it the v2
> patch as posted, without other changes? The RTL8157 result is
> interesting given Hayes's comment about the newer ICs.
> 
> The next version will probably change the approach, so I will only
> keep your Tested-by if the code stays the same, and would be glad if
> you could test it again.

I tested your v2 without further changes and I can test again if you 
like. I also found more adapters, including an RTL8159 and RTL8156 plus 
some more 1GBit ones I don't know exactly what they are at the moment. I 
can test those, too in a next round if you like.

I also wonder which role FW plays in this respect. I would suspect that 
this could be configurable. Maybe Hayes can comment.

Birger
