Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965080;
	b=uwjmMak13/TXH0JzpTEgYa+l87mBxnpvtB9kss7ZxwR6FDDYCsXvSeke3AhL9vdmGCq3
	 raWLcSX9pcNJJzDmaM3TFzJXcIVGaTxrZxf1ZpkwE4aDCMvn3VslDtls/vyNDr4g4Uprw
	 +eSJBB2yyI/tzYjrRwFNarpyz3IQFOHNoN+XI4qeJElreNdQjmzdvqvwXxbNa/XyPHkoW
	 I4RazWpGH3IsgHvNJOsYMg/3yyZKJenpNROPJkn7VeNvgUAALBUrznpSfbC+MvhUFGIKn
	 Q5tTbdYUMwcA4ch4kPLlQrGF+0hun0K9YOMAq8SvT9vtv85mEP5ki7YpauQ8wUuKLow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965080;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=yZRVvWiLJU6lKe1IgV0S3vol1scJQqPQxcRJ6n5s7aQ=;
	b=xAj/8ArfLpS8HEyuW6Ogmf10VWNd5iC43CY2Xxp8LTaqxvk+0JN0e3E15arLFTxDCASW
	 Vix2XT7jLT//JgsakbbiPZlt1Teks3LOUMjiq2XcOLO11IYiMARPXMN0BbsupF95QXXLy
	 /214n2cqRtJXpdaMdXcD+oe3rxbIdxkFMMroSgqPHI9K/BtI7NPLUGzwKzveNRruq3Gey
	 lBnx1DIhaB28Rt8+y/q0eCrHa9s/uFlbVIVZB28KV5jox3qUXcXTycpoApglVoDAs19nc
	 7P7tf0SDUDW16AWuauE/kqh4QXFizdJwnc+cZIO/uGazf2jIRTfdP6L+loA3+k5wsjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD826606C7EE;
	Fri,  6 Nov 2026 11:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD826606C7EE
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnro8RvO1qkOpsAA--.21855S17;
	Fri, 06 Nov 2026 19:37:55 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy@kernel.org, apokusinski01@gmail.com, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tmp006: Fix trigger reference leak in
 tmp006_probe()
In-Reply-To: <20260917014044.4f72b35c@jic23-hlaptop>
References: <20260916164517.2084799-1-vulab@iscas.ac.cn>
 <20260917014044.4f72b35c@jic23-hlaptop>
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
Message-ID: <179396508523.2291875.3803040514248547900@iscas.ac.cn>
X-CM-TRANSID:rQCowACnro8RvO1qkOpsAA--.21855S17
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIDA2rtlCKYJAABsC

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

