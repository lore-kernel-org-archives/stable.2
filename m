Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965082;
	b=xN/zPcoDIyEt2XepgzvWSkOjYztQR7FeanLy1BGgEVWKxfOy+dHwA3TjGqA9VRV2eB38
	 Q7qJEZQa+RVpjWkUUdsnPb8bxwPfxibKUyAKj/iT+6SAa7Xl15Gh8iCUlcg9qx3gGaY/n
	 5xAnZbbIyGI6CaZOpz0jInNQsZh4zQMH6gwj9eNIB+Nj8KyVRyjkLqWwurywEbA7F8IGu
	 LkAbSPJNoZ9vv/Ub0vlCQgSXOc0gB0UqsfmrzMz7vlbpgrhlBIGrk9/NggDo4NZ3vUsvi
	 S4uF21o4Gp2hjOTSfYKjJQe1pRuiAah8KnMCBCRHqFSHbUpc7GmuJAk6uKQ6fkC/mSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965082;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=loNy5yxtgbefGJOtNWgnnzCtRhKDS9Y0/yzCKPzloKg=;
	b=pnDui94jz+/r0NENwo/qQ8ATOVaLi3w8qKv0NQnpC5ZbWa79FEo8goXP5qGDz5rzjz6B
	 vnBsa4/6RwM/NY48vyahN9ExUzb8eVkWkZvBIkRD6vOY0lT4YCZfby09uapF//5H2bhXR
	 yp3m+1sJ8ESOZ7THqnedVrwJM/dNfSo2Ziyn0EfPQ/CtQBv5YH8GvQehzNHe9PiLqbG6R
	 EbFzldexxVa4vJhiNMWmTJElSAZabRIXQeQ/de2Qz0999jPaaclhNacA7EAcJXq2dVcHd
	 dU0qyhjN92vAPAhOeHyCvY3Qs1zcgFjQMfyEyKOfDOEn7QvKEbGGiio1/GrCG872S9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2F6606C7F1;
	Fri,  6 Nov 2026 11:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D2F6606C7F1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnro8RvO1qkOpsAA--.21855S7;
	Fri, 06 Nov 2026 19:37:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, dlechner@baylibre.com,
 lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, ramona.nechita@analog.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7779: Fix trigger reference leak in
 ad7779_setup_without_backend()
In-Reply-To: <20260917012809.77af8721@jic23-hlaptop>
References: <20260916161917.2083043-1-vulab@iscas.ac.cn>
 <20260917012809.77af8721@jic23-hlaptop>
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
Message-ID: <179396508442.2291875.13320681703099109954@iscas.ac.cn>
X-CM-TRANSID:rQCowACnro8RvO1qkOpsAA--.21855S7
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw1kWw4ftw4UZw47XrW8JFb_yoWfZwbE93
	yvya4qkw18Jrs2ka13tr1jqrs7urWIgry5Z3yFqF4Yy348WFsxCa9F9r9aqr12gay8Krn8
	Kr4rKw4YkwnF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkAYjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4c8EcI0En4
	kS14v26r1Y6r17MxAqzxv26xkF7I0En4kS14v26r4a6rW5MxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUDg10UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUDA2rtky+cCAAAsz

Hi Jonathan,

I am sorry for the very late reply and for making you repeat the same
explanation across these threads.

I should have checked the earlier discussions and waited for feedback on
one representative patch before sending the other similar changes.
I understand that moving iio_trigger_get() past buffer setup introduces
an ordering constraint that is not an acceptable solution.

Please disregard this patch; I will not resend this approach as v2.
Going forward, I will check existing discussions before submitting and
will not send batches of patches beyond my capacity to review and
follow up on personally. Thank you for explaining the submission process.

For transparency, we use static analysis tools to identify candidates,
then DeepSeek and GPT-6.1 Sol to assist with auditing and preparing fixes.
I am responsible for verifying the findings and changes before submission.

Best regards,
Wentao

