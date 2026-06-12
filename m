Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0AD2F5485;
	Fri, 12 Jun 2026 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252280; cv=none; b=Cb2U1dNnvR+Q+CP/wRj+KFw+msgEgVPvc3jvv80nN8e+ko4+Is95dF9JxI9nBgDHbHgA54PKoCL9qECuAy4HOWL7NYeixTiD80lHg5jdY6U6MPLiPVOqRKt2R4NNtnphc6tMXLqmp037WaTLAwyTYXlZxjIi/MLwKVR1DrzoDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252280; c=relaxed/simple;
	bh=d9UZVK29jJEql6NUZAMfkQ8JdAbaLItWGUyRU5X8ztY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKRCpJNDX1se5Ctg4ml3RcioVbcWZul6JNfTSmla5bwBkIl8B8M719tulDReDVTM2QCgWK5uxmHH63JauZYePo5C5BNc/AhE8emAr2uGe5oPL9NvOk0iEmhjAtB9n1FWsGswRHRVBH0PfeoH0UOT3w+pwjAWUFEuOLTFvMgvcpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 12 Jun 2026 17:17:50 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id BDD322091480;
	Fri, 12 Jun 2026 17:17:50 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Fri, 12 Jun 2026 17:17:50 +0900
Received: from [10.212.247.31] (unknown [10.212.247.31])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 0C716107185;
	Fri, 12 Jun 2026 17:17:50 +0900 (JST)
Message-ID: <cd454dac-868d-43b9-9b50-9ba9f3f370a9@socionext.com>
Date: Fri, 12 Jun 2026 17:17:49 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: uniphier: Fix completion initialization order before
 devm_request_irq()
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Sangyun Kim <sangyun.kim@snu.ac.kr>,
 Kyungwook Boo <bookyungwook@gmail.com>, stable@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <20260611113137.139673-1-hayashi.kunihiko@socionext.com>
 <airBmzYhnxuK_xdh@sirena.co.uk>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <airBmzYhnxuK_xdh@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mark,

On 2026/06/11 23:09, Mark Brown wrote:
> On Thu, Jun 11, 2026 at 08:31:37PM +0900, Kunihiko Hayashi wrote:
>> The driver calls devm_request_irq() before initializing the completion
>> used by the interrupt handler. Because the interrupt may occur immediately
>> after devm_request_irq(), the handler may execute before init_completion().
> 
> This doesn't apply against current code, please check and resend.

That seems a bit strange. I applied this patch to v7.0 and linux-next successfully.
Which tree did you apply to and fail?

Thank you,

---
Best Regards
Kunihiko Hayashi
