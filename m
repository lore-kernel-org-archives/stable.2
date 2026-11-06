Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965469;
	b=ewv8+HxeO4uhi5rm7jbpb2vylIMs7bIF7zH3xE/GZoBYpSECm2vJppOgLL9pJ/pxlqaI
	 AD63Bc2GFJXIbmGOwEHuyO8Et5V5wySXQuHpORtQdYQ9rsdM/s1iacI/6GT9OGuup3DI7
	 09xyYhWlZSWvzrPLe+rVFVLiaqmWrsdR7mIuSqrchxmu3RXdzDCkSlGLFWGtY2glDzYdH
	 YzFVKCwJbD2VqnYtRFRnrdPwjHSwWgRDbSEBd17TiITXWsdBYDvFT82NwHsqFS4EYi0tZ
	 KNYCAPH+xZRw9tozJx7vZo6MvTZHm34SZlA5IUwXr/OPMrHob6ybgu+McEtkf6NrV/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965469;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=yZRVvWiLJU6lKe1IgV0S3vol1scJQqPQxcRJ6n5s7aQ=;
	b=uewIpyo+g1j7cWLNRahsoLPMlGJX3C5rBLpd4X221hKM3WQPEVbckecbeQBCLcmSmEkU
	 c8jPmD3/yEThtI7z8mAhC4vx4xWEHsEJaVjzFEZFvDPhfkx2pm1/aXJrk6YBu4kbxm7ur
	 Udc0rJwq8VimgptFSnYSctJtv4VkOgKEd1xNPDtobwt6/yKqP/fMinl2EngH6KI/AmRuP
	 J3701zhGBn0tGsqL3P0ot/dHBcOdMpoxngqDAEkrflPoXA8HtQK+EUwT6v9FoG1D8W/fl
	 sgXc7ptu9H4/edvtvPkQSXch4NVxE6ic6ucr1i3wiTuHdZiFR7k0VeG8KRCzdfotUCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806D6606A33A;
	Fri,  6 Nov 2026 11:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 806D6606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnro8RvO1qkOpsAA--.21855S11;
	Fri, 06 Nov 2026 19:37:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy@kernel.org, dlechner@baylibre.com, gustavograzs@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: ens160: Fix trigger reference leak in
 ens160_setup_trigger()
In-Reply-To: <20260917013000.40ba0e90@jic23-hlaptop>
References: <20260916162638.2083538-1-vulab@iscas.ac.cn>
 <20260917013000.40ba0e90@jic23-hlaptop>
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
Message-ID: <179396508477.2291875.2529383718180003858@iscas.ac.cn>
X-CM-TRANSID:rQCowACnro8RvO1qkOpsAA--.21855S11
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYl7k0a2IF6w4kM7kC6x804xWl1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_Gc
	WlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxAIw28I
	cVCjz48v1sIEY20_Gr43Wr1UJr1l4c8EcI0En4kS14v26r126r1DMxAqzxv26xkF7I0En4
	kS14v26rWY6Fy7MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUDqjgDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAADA2rtlCKYIAAAsF

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

