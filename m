Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456016;
	b=FrygRzUuYDmK5cZnl7uuIJt89ZZq5lfaPa9itnUXACx29l61irAuwHED2b3jRcstsDz1
	 KLaT35+kujJ9kWsECK+dJqPsqCTw9EtgZ0x/ASff2v+b0U+N/H9l4oU6foFZs9XAO3FPc
	 GghfNRtjpG5eiWlvu1zpNJoYgCOIu/NViLEGWSeMYgYZED+YoJRnhBAl6Nneqyt0SMO5t
	 +qnZF6LTdQ7xnL2LeuKD27+L2SWpHMePuzfXkRq7n7Exa6p19Ak/nUXvlyOGKIJVF1Xgr
	 wy120o3bcjrOvmprsH46bEuaKJa2Sxv6HdTxwzQquHM9hgJh9khMWQRMxCHANld9LbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456016;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=KNv41jA8q+1vr1ybXb+ci7oKXbVrazZL7oRggdFyj4o=;
	b=u5Fg+QbKvA7cCOaqMY9P3NlZLVp1OrURMLLztXI5+jCfpzY5cOIol5ONo92lZlTpJTTr
	 PtTVdqgu2qdwcXCXbhZ8tBHhvXXXbix+6vdpJzIsZn1lWnPGyK5F50A+s1KcFYM/Nwhu7
	 VXHZnzXtLFHD7dPrh7EBsp0U/kjVwdnp/L0LbntqhUbojgZG2tilal+jcMSTxgkmp5fhW
	 WZiGbEAd3PCX273dq/XxbU+HZoDAHNFnWvSbSSzO6ZUaOthS529VvPJcD3UnDELIDsSRc
	 c6Sg9p+0jMPNhGSR/I3K0spTNrOrqJOS2SWwrlQHDj66UFBcDlfssybUNYd/liczz2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97B606A324;
	Thu, 12 Nov 2026 04:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF97B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxdvDMOfVqq8oeAA--.22868S3;
	Thu, 12 Nov 2026 12:00:12 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBx5czIOfVq6uEzAA--.13029S2;
	Thu, 12 Nov 2026 12:00:09 +0800 (CST)
Subject: Re: [PATCH] lib/smp_processor_id: Don't warn if there is only one CPU
To: Huacai Chen <chenhuacai@loongson.cn>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Huacai Chen <chenhuacai@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261111092421.3771992-1-chenhuacai@loongson.cn>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <1c59d1d6-6ed2-f84e-49ce-2d1baeac6834@loongson.cn>
Date: Thu, 12 Nov 2026 12:00:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261111092421.3771992-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJBx5czIOfVq6uEzAA--.13029S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GF45Jw47GrWxGrWfAr1kJFc_yoW3Xwc_KF
	4S9rWUCrW0vrsxG3ZFga1UZF17Z3409a1kW347trW3Xwnrt348Jrs7K3Z3Zw43KryxJrZ5
	Jan3Wr1avwn8AosvyTuYvTs0mTUanT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUU
	U==

On 11/11/26 5:24 PM, Huacai Chen wrote:
> When CONFIG_DEBUG_PREEMPT is enabled on a Non-SMP (single-core) kernel,
> calls to smp_processor_id() in preemptible contexts trigger some false
> positive "BUG: using smp_processor_id() in preemptible" warnings, which
> are harmless noise because the process always executes on CPU 0 and CPU
> migration is impossible.

...

> Reported-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Hi all,

Just for reference, here is the related LoongArch patch that
fixes the specific callers in cacheinfo and local TLB flush:

LoongArch: Fix preemptible warnings in cacheinfo and local TLB flush
https://lore.kernel.org/loongarch/20261111113738.862-1-yangtiezhu@loongson.cn/T/#u

Thanks,
Tiezhu

