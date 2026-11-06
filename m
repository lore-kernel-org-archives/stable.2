Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965081;
	b=k92wZULwwbtAxbQMroKJLhsp5/C8XUMlDY1PEvuzuc3ixcQCbRbTW1EGAi3bSWPPKjRP
	 0t+3Q8nCmcM0i5SJnbciisoDnakqDQ+wqCEobVzlue/6WOeaRtGNpsbBFoZu5w7QUx0BX
	 lONqjk1T8gqsBEFi7Mfp5sWSkFaVeLaO1V8KjywP1h7C6oer0UwILoDtBuO88K5vxZMI3
	 umXIOnYP7tQmvlE0+A2lRcCUan4vcFb9LbVdfl4ZyaDR88ZXrEQfGdKZk50W3ilvO/MvD
	 pSUPouxl6GLk9xneHLvzcISM9Mrb2LRadpv+5PyQRcRIdd21jb1GpXYlAL7gRh4XXkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965081;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=yZRVvWiLJU6lKe1IgV0S3vol1scJQqPQxcRJ6n5s7aQ=;
	b=2q0s1BzPmbUXlzYmyfteKuc7dZJi5mHXh+pZ+MkT6c+pdiNZhpYwrh8J78Fpr46ZST1+
	 ZIcV0I04uBGIAouEIIXjK5mrOqiqx/puqGLKWDeAJjh3wnYAJBXlG5krqssfMxRD+1VoU
	 JlAI4E2e4BwufKUCAVJnV9cSlOSJVIMW8oLwFEktGduV5AJXE7MNdvzKIMu56jhqdTrfO
	 FgLtNmM7OKfEbw1JZoo84N6jETxpsoXsyGg/kNo292QW6yvjmffvjN/F3P3vBHYvLgWpc
	 ZM91tZ56Tgdl78fE7spe8O49azza1ikXB2cgllJ1diCOglLr0JnhZ9QcVJp7O8aTrjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D277606C7EF;
	Fri,  6 Nov 2026 11:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D277606C7EF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnro8RvO1qkOpsAA--.21855S9;
	Fri, 06 Nov 2026 19:37:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, cosmin.tanislav@analog.com,
 dlechner@baylibre.com, lars@metafoo.de, linusw@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: addac: ad74413r: Fix trigger reference leak in
 ad74413r_probe()
In-Reply-To: <20260917012859.4007a80b@jic23-hlaptop>
References: <20260916162251.2083286-1-vulab@iscas.ac.cn>
 <20260917012859.4007a80b@jic23-hlaptop>
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
Message-ID: <179396508459.2291875.1363988535664914750@iscas.ac.cn>
X-CM-TRANSID:rQCowACnro8RvO1qkOpsAA--.21855S9
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUOb7k0a2IF6w4kM7kC6x804xWl1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_Gc
	WlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4c8EcI0En4kS14
	v26r126r1DMxAqzxv26xkF7I0En4kS14v26rWY6Fy7MxC20s026xCaFVCjc4AY6r1j6r4U
	MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
	AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
	A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73
	UjIFyTuYvjxUDqjgDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgADA2rtkziawwAAsz

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

