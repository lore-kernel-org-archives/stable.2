Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4411FD4;
	Sun,  6 Sep 2026 00:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788654735; cv=none; b=NIu3422ftmmFHUS6AnUBb+qOiagzYlhmmVTdtfPoWrcPZeNshbMUMXW1e3m3CN64Bkzfw7Ybx30HCWMaZZTk7H0qqzaKtrkbEPKW8GfhSOeZ2sU4ecF5YzxUdMfy095faG2lVgwvnluJcoFMEpG93h8qTAQky+fR9TqVWZ+wPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788654735; c=relaxed/simple;
	bh=k1OFxiRBC1UnYpQy4EdqJFxB81tHqqUuMRCiIk37ECw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4QDUV5iHCrOF2XzHui2/meLooVPbfB0i6WuJZxCSI2wffFm1Qv0weD4lUWsvHvqXTOETd5NXSeFoogLhz6APqihYK/5C/ThsXm9fqlF6lspyO5gCkq8o5SW7SiDRVRe+nKK5+lzSmJpdhrggqt6bUnPcKjDU9qspocAHQHF+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AcJNDRPl; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AcJNDRPl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=4CwkqFElh4pjGctDggceZpagl1zjwDqBMqU8Kvoo5mE=;
	b=AcJNDRPlkkjmT2yL8nlyy1lbUxXLVrTekW/BqaM/I/Anz8A1nX0LafSztPkBxi
	IhovyoGRLWYPcw91g8AZN5/iPybDG+eI01f17BdYwh+IKPx6eNEWLElCmdkDAbkf
	a0aWk4EguaOt2XMLmdDg6bfN4K/mq6w/q0OIRjIwiOHoc=
Message-ID: <b2a66985-ede1-433b-aff0-4d2acc5c027b@163.com>
Date: Sun, 6 Sep 2026 08:31:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/zswap: enable static key after runtime pool
 recovery
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hannes@cmpxchg.org, yosry@kernel.org, nphamcs@gmail.com,
 chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>
References: <20260905125101.2970456-1-xialonglong2025@163.com>
 <20260905160926.9836f2ca0dc977b89f2f146e@linux-foundation.org>
From: Longlong Xia <xialonglong2025@163.com>
In-Reply-To: <20260905160926.9836f2ca0dc977b89f2f146e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn3xZitJxqXko6Aw--.557S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryDKryxtF1fGFW7Zw47Arb_yoW8Cry7pF
	W0ga93Kr48tF1Iyr4xAF4IqF1Yy393Gry8tF1rG3yIywn8Crn5trWxKF40gay5CFn5A39I
	vrZrA347Jr1Yk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UO2-5UUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC9wUIAWqctGU0LAAA3E

Thanks for taking a look.

在 2026/9/6 7:09, Andrew Morton 写道:
> On Sat,  5 Sep 2026 20:50:28 +0800 Longlong Xia <xialonglong2025@163.com> wrote:
>
>> From: Longlong Xia <xialonglong@kylinos.cn>
>>
>> When CONFIG_ZSWAP_DEFAULT_ON is disabled, zswap_setup() can complete
>> without a pool after a failed initial pool creation. A later compressor
>> parameter update can create and publish a pool, but does not enable
>> zswap_ever_enabled.
>>
>> If users then enable zswap, zswap_store() intercepts swapout while
>> zswap_load() still returns -ENOENT without consulting the xarray. The
>> swapin path therefore reads a stale backing swap slot because the store
>> skipped writing it.
> That sounds bad.  I'll leave it to reviewers to suggest whether this is
> a sufficient description of the runtime effects, and to decide whether
> a backport is appropriate.  Please.
>
>> Enable the static key after a successful compressor and pool update. Do
>> this outside zswap_pools_lock because static key updates may sleep.
>>
>> Verified with fault injection on a stock kernel (compressor builtin,
>> CONFIG_ZSWAP_DEFAULT_ON=n):
>>
>>    1. Boot with zswap.enabled=1; pool creation fails, init completes
>>       pool-less (static key off).
>>    2. Echo an available compressor name to zswap.compressor; a pool is
>>       recovered but the key stays off.
>>    3. Enable zswap.
>>    4. madvise(MADV_PAGEOUT) a pattern-verified 512 MiB region, then
>>       fault it back in and verify.
>>
>> Step 4 reads back 131072/131072 zeroed pages (zswpin=0, zswpout=131072)
>> without this patch; all pages intact (zswpin=131072) with it.
> And thanks.  Sashiko might have found another issue in this zswap code:
> 	https://sashiko.dev/#/patchset/20260905125101.2970456-1-xialonglong2025@163.com

I'll send a separate fix patch.


Thanks,

Longlong


