Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965082;
	b=pAk/c+AbMF3yUV6Kd4BER2xfxFDYBNP2npqgWNjq92OsTvDvL1RXHK9Ee4IotPK6Z4M8
	 ojuu+LdAoQbmZ65NHdF6c685n7tPdt+UkeKYPs/omTyYe0dTb0rurxFm5ZeR2ddZyIYmt
	 MShNZEq7s/LZrvLh2IVjFLX3WYtawz8SjwnfhTyc7eCgEvPkC6whM1SP7shbGSUH1nfJU
	 flvNTdJEZoTE0SLeRW5GRt5L/p4i0k1cWC4dSXPUAsc3wKwlKHV3BMFZIpzhoV9Dt3t5N
	 JHzPujQy53QbH2MomjNwEZXK1OrFcLOUgSykUvFzpwIzFiAgh/uB9KXk/p1lj7yIhcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965082;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=yZRVvWiLJU6lKe1IgV0S3vol1scJQqPQxcRJ6n5s7aQ=;
	b=NJF3lcdTabGubxG0CVkOddpyumN2C2ukBjaXPXDdRzhMRyLfikTm6r90YHGnUxC0MYy6
	 L10GA6muW80WAuvpCRwsp504zY/1HKTrhRojmtgLjbpjOBaCV0g5YHQH8QA+sYbRPq7/F
	 a6iwkrnkdhXGp9pBnyd7zbtCS4P8cbOqmTGpZjOLpjm5KskClFVFrBbvxC6x7BQSm6aT9
	 86K4Qf0PHG4vy3N6tAqxsRtfhc2lD/SBggpKMt4n3HU/IRKfa4T6PByggdd+qQQwhxK72
	 g2BqLj8PMdRM7maSNugp3db5wFKd+R4D51BOP0MkpwYO4Yv8v+GAw75siAyB5f5eALg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324B606D80F;
	Fri,  6 Nov 2026 11:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E324B606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnro8RvO1qkOpsAA--.21855S5;
	Fri, 06 Nov 2026 19:37:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, dlechner@baylibre.com,
 lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, stefan.popa@analog.com, stable@vger.kernel.org
Subject: 
 Re: [PATCH] iio: adc: ad7606: Fix trigger reference leak in ad7606_probe()
In-Reply-To: <20260917012605.690b430e@jic23-hlaptop>
References: <20260916161454.2082753-1-vulab@iscas.ac.cn>
 <20260917012605.690b430e@jic23-hlaptop>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 06 Nov 2026 11:38:04 -0000
Message-ID: <179396508401.2291875.12867306451529784761@iscas.ac.cn>
X-CM-TRANSID:rQCowACnro8RvO1qkOpsAA--.21855S5
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYl7k0a2IF6w4kM7kC6x804xWl1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4UJVW0ow
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCF54CYxVCY1x0262
	kKe7AKxVW8ZVWrXwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUDqjgDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEDA2rtlCKYHAAAs4

Hi Jonathan,

Sorry for the very late reply.

I understand your feedback: this fix should not depend on a subtle
ordering constraint in the driver. Trigger lifetime handling needs a
broader solution in the IIO core, as you explained in the bma220 thread.

Please disregard this patch; I will not resend this approach as v2.
Thank you for the review.

For transparency, we use static analysis tools to identify candidates,
then DeepSeek and GPT-6.1 Sol to assist with auditing and preparing fixes.
I am responsible for verifying the findings and changes before submission.

Best regards,
Wentao

