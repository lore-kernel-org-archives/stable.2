Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868926;
	b=rGxiKGdg1vxbwsmC4sH0HC9ES8eoKmZz3bYbWXL8OsxMUgHz7py4XA2Wke/hvl4Iq/W1
	 WkXZIkWDXmZp/jNR7fBKffyx1QTZ1KJeUK0x7tAcv8erikg6zpQ67rKoqwW9QCposxHfq
	 Yfjx8UkSuX+n9CHtNj/rO4s0ys10sOq9W7ucM7tTDwNwmtlmIt9LMZYHEAu9L4x+Gxvzs
	 WkDwSkqED9QQB1o0WroVXGfAEFOZoDsnMEWeFo+PxL+pkNKBsUisM2LeTuy6ZeGWBe1am
	 /xxnnsLzqtbl7JXowh/WdW7l5+UGkcAcjakUchU3c5SRzR3e3A02Cw9OiBcMIU7dvdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868926;
	h=DMARC-Filter:Received:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=e4d6LbZwiMMDmNdoTGrrJaaz6TI7Gu1U+/P7GqUpsu4=;
	b=Q+MNOEIVcow5+R1cR4TxA5trjdPyEoHSDNeek5ibYc0G+soiNl7ZZdg3FfPdSFP+AKWt
	 eKHOzYczkr+oU1oMiQebOIwVcJ7zAD57f8Z1KYto+jIXYSBA3WeaIK98+CiKAlFbEUW+R
	 of/d3KbL7onKWThawilCITWRJ362jxJghgsgv0IQT9IOVRSaIZ/7WKCFu5hf7F1UOD2dW
	 dXIGwKc4hRnY54aCAcrihzNDqdk10R28Ms+oCuWE+dVgNI4177QuYzAMz7DXvjUD0wb1r
	 U6Vnf3vJpX66lGtGznk3pd6VEP+zARywwXD3YGYT1A97GugtFnz+9d6uqZPjWHXV7Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD01606A326;
	Thu,  5 Nov 2026 08:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BD01606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC3ULZwROxqX1lcAA--.2626S2;
	Thu, 05 Nov 2026 16:55:12 +0800 (CST)
Subject: Re: [PATCH 2/6] clk: qoriq: Fix clock reference leak in
 input_clock_by_index()
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: andy.tang@nxp.com, bmasney@redhat.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, lkml@vger.kernel.org, mturquette@baylibre.com,
 oss@buserror.net, robh@kernel.org, sboyd@kernel.org, stable@vger.kernel.org,
 vulab@iscas.ac.cn
In-Reply-To: <1jik3qadhr.fsf@starbuckisacylon.baylibre.com>
References: <20260915042829.1725639-1-vulab@iscas.ac.cn>
 <1jik3qadhr.fsf@starbuckisacylon.baylibre.com>
Date: Thu, 05 Nov 2026 08:55:10 -0000
Message-ID: <179386891087.2018036.1506540529183878937@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
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
X-CM-TRANSID:zQCowAC3ULZwROxqX1lcAA--.2626S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF17CF15CF43KF1kKr4Durg_yoWDurg_W3
	4ktrZxCw17JrW7WanIkF4Yqr4xtw1kZry3Z3y0qrn0gry5ZF1kXan8WrnIgF1rtFWFgF9x
	Kr9xA3y7CwnFvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	ACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjU-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYCA2rsPlMYWgAAso

Hi Jerome,

> This is PATCH 2 out 6 but there is not thread, cover letter or other
> patches. I can't tell if there is a context I should be aware of.

Thank you for the review, and sorry for the delayed reply and the
confusing submission.

The six patches are independent leak fixes across cpufreq, clk, driver
core, and perf. They were grouped only for convenience and do not depend
on each other; there is no additional context needed from the other
patches to review this one. I sent them without a cover letter or proper
threading, leaving this patch on its own despite the 2/6 numbering.
That was my submission mistake.

> Please check how you've send this. Consider using b4.

Thank you for the suggestion. I will check the submission workflow and
look into using b4 for future submissions.

Sorry again for the delay and the submission error. To avoid adding to
your review workload, I will hold off on resending this patch for now.
If you would prefer a resend as a standalone patch without the series
numbering, please let me know.

Best regards,
Wentao Liang

