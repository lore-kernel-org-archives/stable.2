Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965083;
	b=0qtOd1OLZ8g/uR2+J+0Y4oo/9PWzeviGNQTXcBiLHEnjrtuoFoRRXtq/ueiQX69oDZOd
	 CL3QNfUvWtDf1vJLNK0NA7o9pbK/cjdvIgBlKEsYlWOe3QJcSJd7Tdb/SSnC/zMLrs7P1
	 Yn/mdbsxrVNRfD/4xGrYfaXwhwAK2/7hox74Kwf2x2yn+R5WquOMpcPlV2oeXZqXatMf8
	 Kdm4fyQn8K1XjanCNvU5njQfVoRRIC1beZV0/1a5KjPizBYqmQhw048zI8+skib1TjgIX
	 7OeNFr8I+T4ovr8ZgxZgOx5svgyvfb9rj/QHn2MPbe0HaJD5fMcZALkWmjnF+kaZARQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965083;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=yZRVvWiLJU6lKe1IgV0S3vol1scJQqPQxcRJ6n5s7aQ=;
	b=cfurIhNxZF0BDoonTntKYJndP4+PSywxwj5xslvOHI0WQ9Xk0UBfbCoI3U/gaSie8Ro5
	 bfa6zHp/KkC6+A/AD6ml4+Mi6rHj+h9IdK0K7cMt2MKMeu/NGFZ9fTXsxgixguNtBUZrI
	 gSuAPGjB55Wf8uqymIxwnFKLZpp+SNA5yDlqY4XQu/Nou34Tjbvq3Tg65R5YqS997NhHJ
	 GoTZxp/oDY9RvrwmrKjqC5jlzLx0c0tvMrLiD8kA0D9zKWrZTnaB6Sm8pybioKJZRjZhz
	 tiFzaJWXTMwA9kLW/wEAZmMnKMQibDHGyX1Ytd2BAoYD2VwB/uR3zLSLqJx3jBj2o7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585D6607095F;
	Fri,  6 Nov 2026 11:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 585D6607095F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnro8RvO1qkOpsAA--.21855S14;
	Fri, 06 Nov 2026 19:37:55 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy@kernel.org, dlechner@baylibre.com, gwendal@chromium.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: acpi-als: Fix trigger reference leak in
 acpi_als_probe()
In-Reply-To: <20260917013528.137c154e@jic23-hlaptop>
References: <20260916163440.2084089-1-vulab@iscas.ac.cn>
 <20260917013528.137c154e@jic23-hlaptop>
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
Date: Fri, 06 Nov 2026 11:38:05 -0000
Message-ID: <179396508500.2291875.10724954361146568071@iscas.ac.cn>
X-CM-TRANSID:rQCowACnro8RvO1qkOpsAA--.21855S14
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYp7k0a2IF6w4kM7kC6x804xWl1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_Gc
	WlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxAIw28I
	cVCjz48v1sIEY20_Gr43Wr1UJr1l4c8EcI0En4kS14v26r1q6r43MxAqzxv26xkF7I0En4
	kS14v26Fy26r43JwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4U
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07bb8nOUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcDA2rtlHmYHgAAss

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

