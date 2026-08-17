Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBB34B049B;
	Mon, 17 Aug 2026 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786929097; cv=none; b=IQrRVy8L6pQ+klvh1VEp7CYdeCrDy/l+9qH4kbjIKyU9oOyoXXK8+uHEUXg1jdm1FFWD+pklnRaChF3Kj45Wiajwq1LZHpMKLpDeNmj901vc5o7PydAgaEU6MDZ7G1fjwbWMgvriI7q0hcSEWVpiKXSj58sXvwVMwRYzX0uWWDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786929097; c=relaxed/simple;
	bh=55sK6iY6RD4u+dDMBU7miJe8yGV6QUs+UCA1biBiLrg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SrG/PeqQiwsVQEZKoUYWorkkNNWieL4hjtMTY84C8DPIhU5xQQujy3zwnPO2JZL6LIXiPO7JREAhkY0uikrca5eNtz2iD8lBqa4BNUeIhGJsWjEwokig1WM3C5hpqCC4knzxHuS3EEUJ6SHpIsbA2YZ/CcbitErr3sJhsRxnjZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.190.162.99])
	by mtasvr (Coremail) with SMTP id _____wAH0n2_X4JqP9KbAA--.12864S3;
	Mon, 17 Aug 2026 09:11:28 +0800 (CST)
Received: from smtpclient.apple (unknown [10.190.162.99])
	by mail-app2 (Coremail) with SMTP id zC_KCgAXY8e+X4JqxRHxAw--.21086S2;
	Mon, 17 Aug 2026 09:11:26 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] iio: light: gp2ap020a00f: drain irq_work after free_irq
From: Fan Wu <12321260@zju.edu.cn>
In-Reply-To: <20260816184602.2dd023f6@jic23-huawei>
Date: Mon, 17 Aug 2026 09:11:15 +0800
Cc: Fan Wu <fanwu01@zju.edu.cn>,
 linux-iio@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <57FF6045-673E-4848-8F32-3422A2917993@zju.edu.cn>
References: <20260806132923.468833-1-fanwu01@zju.edu.cn>
 <20260816184602.2dd023f6@jic23-huawei>
To: Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-CM-TRANSID:zC_KCgAXY8e+X4JqxRHxAw--.21086S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?RpKPQQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI01qnTEYltIz2y18Hxtsg55qDfFHwsOsvezGgbGfQW1zAoe
	q4v+vCITml78oZLupUjN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr47Kryxury7urWUGF18Xrc_yoW8ZF4xpF
	WSgr1jkr1DGr4fXF17u3WIqF1Iyw40q3y5Jr40v39I93s8Wr1ftry8KrWYga4UZr4fGr4j
	vF4jqas0vrs8ZFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

Hi Jonathan,

Thanks for the review and for applying the fix.

Yes, happy to take that on. I agree iio_trigger_poll_nested() is a
better fit here, given the device IRQ handler is already threaded.

I'll prepare a follow-up on top of this patch.

Thanks,
Fan

> On Aug 17, 2026, at 01:46, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> Hi,
> 
> Thanks for the patch. It looks correct to me but this is an old driver
> and we'd not use an irq work at all these days. The reason it was used
> was to ensure we could use the trigger from this device to drive capture
> on another one that needed a top half.  However the top half (non threaded
> bit) of trigger handlers only ever gets a timestamp, so we end up dancing
> through
> threaded_irq->irq_work->iio_pollfunc_get_timestamp->actualhander.
> which almost certainly gives a less useful timestamp than
> threaded_irq->actuallhandler without the irq_work part.
> The slight risk is someone is actually using that timestamp in
> a consumer and will find pf->timestamp is now always 0.  However
> I think that's very unlikely with a light sensor (sensor fusion
> doesn't really occur much like it does for inertial sensors)
> 
> So I think a better solution given you've identified a bug here, would be
> to rip out the irq_work dance in favour of a direct call to
> iio_trigger_poll_nested() instead of irq_work_queue() in 
> gp2ap020a00f_thresh_event_handler()
> 
> That would mean also grabbing a timestamp locally in
> gp2ap020a00f_trigger_handler() rather than using pf->timestamp()
> + dropping the use of iio_pollfunc_store_time.
> 
> A more invasive change, but one that lands us with a more modern solution
> and removes the problematic code entirely.
> 
> Do you feel like taking that challenge on?  If so do it on top
> of this patch because this one is going to be easier to backport.
> 
> Applied to the fixes-togreg branch of iio.git but note that won't
> go upstream until after rc1 is released (and I'll rebase on that)
> 
> Thanks,
> 
> Jonathan
>> 

