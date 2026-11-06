Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965082;
	b=Oxir2V9VD6qXSqkskiCQIP5SfFpGFs4DxpNnkHunVi6MQ5LxRxdLVm16uoKOAohMzA0S
	 3oAfeEq2/ubAsyz2s860DTKMYN8XPNMytfvQWu4m7L2zQimTjWFT8Ne+0o6sW7FYqzkvM
	 5K1zBQorjX0hmR2p4OxIGE8qf+bgYRXmcmfku2ovSkS7h6UIM+Q8g+poAODLD6jERc7cR
	 KpKqbDC7PLKzqxDzVAI17hSwivJ5LnqUOfgIwHtP7Aa307yFbXcp3sQLsdMlRIz9/6GAB
	 1w/FVkiL/ViLN3Vk/L20x6H9Zia/v7QZ/va3QQ1xG0RaudwEiaL5QwYJd875l7tS2vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965082;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=yZRVvWiLJU6lKe1IgV0S3vol1scJQqPQxcRJ6n5s7aQ=;
	b=q5clOwpy6RqGc7cFOyBlaV8PoZXLCWVk1+5wJO3hSwDxRWkH5A0721qRI8sbeRUKULL6
	 5E5etFhw19AVHLUKbQGrbGoHO/fPvk1pNhgBM9rFPNqBQlD7u3NtJWj0pD/ZTEjR7bm2Z
	 6Bf7Tv6ZUQ0nsHe1zcBq/VZZ0XUhpkyIA1gK7bRt3IgjWYFvQ3HAXLUTcosGmcm9PRX+F
	 oavBnAbHU1oGdrDcOyvRxUzJUnKhbT52ysvSrJAcYd7eefeb6UXHQmLRf6CCptx+8MrCT
	 Xlv8jr0S3fem83fTjGboO70LuxTbdqTqlcAglu0H/L/EX7TaDR+z2hdqeYyxZrh6oEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2A5606C7F0;
	Fri,  6 Nov 2026 11:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D2A5606C7F0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnro8RvO1qkOpsAA--.21855S8;
	Fri, 06 Nov 2026 19:37:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, tomislav.denis@avl.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads131e08: Fix trigger reference leak in
 ads131e08_probe()
In-Reply-To: <20260917012836.444a54ef@jic23-hlaptop>
References: <20260916162114.2083166-1-vulab@iscas.ac.cn>
 <20260917012836.444a54ef@jic23-hlaptop>
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
Message-ID: <179396508451.2291875.11438128501244247993@iscas.ac.cn>
X-CM-TRANSID:rQCowACnro8RvO1qkOpsAA--.21855S8
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYl7k0a2IF6w4kM7kC6x804xWl1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_Gc
	WlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxAIw28I
	cVCjz48v1sIEY20_Gr43Wr1UJr1l4c8EcI0En4kS14v26r1Y6r17MxAqzxv26xkF7I0En4
	kS14v26rWY6Fy7MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUDqjgDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUDA2rtlHmYHQAAst

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

