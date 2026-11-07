Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794033663;
	b=X0HC4+lmJEu1CZ00DALbObep/QIN5De1/mSdS40X1ORsZBUz7UwMfROoBH6XABc7e+mX
	 k+8MEihbiq9loBAsYVJWzHthiSyixGbOnar6mQUqhM7U2q2QCxDCUlWtvePnAp+TQEkwD
	 aKecToo9L0/UEZaIA9cfi/qa98Z6kWm5biG7wWSdEePWFEanpyAcJ8mgtrlavS7BrrTOp
	 gkgNQ6dHvE5kpu5CjncpIrQsCFnfn1mw4Xcp7uxILEEPk6yhZoy64w95CClXlfiy9R/Zq
	 /receienV6YeLRfKVXoQODa0ZA7/HXAnFK4Z62oE/+jXLaM48vDtBhDm5/6Hs9ZNYHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794033663;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=XUSUNbMJ34FAOBuYZeh6t3d5EPTvLm+TMnooa8Q/6iI=;
	b=l27ehLlhzv1VdpQoti4f9jOflvcjVmrniB/NqEvZ6fNJ+nPLxyWjNDFfPcCuAmZZrv5F
	 Skk8PuSM6UlI+ip20CuO1tAjCNG/HJ6LVMjVLdV6yUXs4Gos+AohH7Gp55KqklbIdOj3h
	 oX+UJubN1da1n1AcZzxPuPIFoXHH2BWo7E7ydY3O52WARDqIhnTXsPT89dQptVw03GnvU
	 6sWem1AB4PTCQR3zxnkAR+f4Q9ZpYIiISLaB8QkLwGlYN7gqtwVmSg2k8AeXZ9KhhXmOy
	 dUEZ3Lfl9LpppEO6kUYvtpdZNXcCsF7k0peJ4hiZdDOGduc+w1Oqgr+m1R4ILX4HNdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2A4606A336;
	Sat,  7 Nov 2026 06:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F2A4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAHV7vxx+5q4huAAA--.416S2;
	Sat, 07 Nov 2026 14:40:49 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Simon Horman <horms@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: hns3: destroy the page pool if RX buffer allocation fails
In-Reply-To: <20261106180307.GM865646@horms.kernel.org>
References: <20261103100533.1310018-1-vulab@iscas.ac.cn>
 <20261106180307.GM865646@horms.kernel.org>
Date: Sat, 07 Nov 2026 06:40:59 -0000
Message-Id: <179403365938.2343286.17861555527343646407@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHV7vxx+5q4huAAA--.416S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYL7k0a2IF6F4UM7kC6x804xWl1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr
	1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
	xwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxAqzxv26xkF7I
	0En4kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU81qcUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAEA2rucfyZAwAAsY

Hi Simon,

Thank you for the review.

You are right about the NULL check: page_pool_destroy() returns
immediately for a NULL pool. But checking again before posting a v2, I
found that Jijie already posted a fix for this same leak, four days before
I sent my patch:

  https://lore.kernel.org/all/20261030095633.377289-3-shaojijie@huawei.com/

So I am withdrawing the patch instead of posting a v2 that duplicates his
work.

Best regards,
Wentao Liang

