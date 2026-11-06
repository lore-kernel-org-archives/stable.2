Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965469;
	b=N0YBs/7EsPthre6+zBFE7rzh2UidQ5wgyQDUtKco/EQtSTvwTiJKOipBznmv8lw5jWI7
	 +g52QXAhjrHfItGHPTIO+3jRnXGZNpG62TUNfHW7gHPWWPwb9JQ80vlThceHnk/pNbRJi
	 FZ40ToXD3/d04EmzIKKkXvSb4MZPmf64uC7P7qcjzPVq0yF5y2pcwd1InAM4XcJDd4IpH
	 BKy/HJJSKFxEpAJNbYbq4qUfk4U8Ieil+sMd5Wz510l/dbhD3mupmaDKq36sgYRgF/7s+
	 3YK28QfixSKQ/3D46rWN0jAOGLL+TptkzLydXsjso/eV1WKWcoG44nN8l+5T4qzQnDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965469;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=VCwC09cnno+tqr+oLIW7Qixi9w0adICGJtp8fL9fLtg=;
	b=5elbqPwjfhF5WLaixI/KmIVnL42Ej+joVe1Aop3ZYaOfhw5eT00AVSY1+986yOp6bI6E
	 zX83rIN+hg0CjpU45cUrcAJo6PkuCrwgceMtB0YCQDQIFjFuANUSRLKxijeH7JR2TkpcF
	 gSueq98jXmioWCAc49nqP0gADn4AP6xT2cRlBKQIlUX22byU1J7ClW1mgY3V7j73sBrEZ
	 fl35VTUrHxBKqde/LIatPCdEJMqk3BNE7ibS59ODdJRAH8ug1PsGiDTTYCPCxN8Psvwvm
	 a5/Shn/DAll/zm7tf0AVzI+J68/v7gBjU62r+ppxT1YmRlCYdthoq1HrC5hM9RA+dbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48285606A905;
	Fri,  6 Nov 2026 11:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48285606A905
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnro8RvO1qkOpsAA--.21855S3;
	Fri, 06 Nov 2026 19:37:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy@kernel.org, dan@dlrobertson.com, dlechner@baylibre.com,
 jagathjog1996@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, stable@vger.kernel.org
Subject: 
 Re: [PATCH] iio: accel: bma400: Fix trigger reference leak in bma400_probe()
In-Reply-To: <20260917012143.1ee8ddc3@jic23-hlaptop>
References: <20260916160825.2082355-1-vulab@iscas.ac.cn>
 <20260917011724.1b0f181a@jic23-hlaptop>
 <20260917012143.1ee8ddc3@jic23-hlaptop>
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
Date: Fri, 06 Nov 2026 11:38:03 -0000
Message-ID: <179396508383.2291875.10410747579980805826@iscas.ac.cn>
X-CM-TRANSID:rQCowACnro8RvO1qkOpsAA--.21855S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr4ftF1xWF17ur4rZr1UJrb_yoWxurXE9a
	yv9343u3W09Fs2kr43Ga1jvr43Aayqyr17Cay8X3yYk348XFW7CFZIk3s5ZryYqFWFqr1D
	KFnav3yYkw129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkYjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAI
	w28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5
	5DG7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgADA2rtkziavgAAsO

Hi Jonathan,

Sorry for the very late reply, and thank you for taking another look.

I understand that, even if this change addresses the reported failure
paths, it is still not the long-term solution you want for trigger
reference management. The lifetime handling needs a broader solution
rather than an ordering constraint in this driver.

Please disregard this patch; I will not resend this approach as v2.
Thank you for the explanation.

For transparency, we use static analysis tools to identify candidates,
then DeepSeek and GPT-6.1 Sol to assist with auditing and preparing fixes.
I am responsible for verifying the findings and changes before submission.

Best regards,
Wentao

