Received: from cu-gy11p00im-quki08141502.gy.silu.net (cu-gy11p00im-quki08141502.gy.silu.net [157.255.1.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCAB3D091C;
	Thu, 10 Sep 2026 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.255.1.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026054; cv=none; b=kQTDESifXAj9Q4+4kWfEWKrltIsidQdsX3YuYSJRKselPjVm3gVwpuO5ruSw9huonhNgIEQ23AW5TbbLQ5Ycun3o8FZg/+GUsQCvhxgdyjSSb3dOaXU4Bv8JqiWERJyWjYpVZ9IFsgqr9iKffHPQ+B94qkbiHeRHecbGkEteIxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026054; c=relaxed/simple;
	bh=CiHeKqiTjq0E1HujjU4OQMJPEc0A5j8S+aRiKeV4PaA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TX3lpaOTP9XmB5kovGej5siKxZ4/CO3KckyJfnnXuZ9sQh+3SwQa5vE1NO8E4TPmia/ilT1kwG1Zl0aVop4n6fAH9ABKSZyZIkPDK/j4jY/V+bAt/Xyi4r5ntclRRt3XNB2azL9DdFRF7j7Z/E9PXIApCtfT2e10O6VOHeUnIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ptKdMN9c; arc=none smtp.client-ip=157.255.1.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ptKdMN9c"
Received: from smtpclient.apple (gy11p00im-asmtpcmvip.gy.silu.net [112.19.199.76])
	by gy11p00im-quki08141502.gy.silu.net (Postfix) with ESMTPSA id C14033520061;
	Thu, 10 Sep 2026 07:40:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1789026045; x=1791618045; bh=i+S2+q0H2kZtivapYxr37lzPiIeUPNhD/UThB0AKCqQ=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=ptKdMN9clkgvLx5aqxhmlY85Af7XXZwJzegQ596jjP4/KRnDmc/rjUOcQPaZVcoo+ja05+UTGarIohIsLO7fY2jSa2dWzh1hZCSyMtSZe/G6DpCgELbYQzluNz6QlZDzo6Zb3Zo5gW6j7kdQgz3FFlIT8zlCak0NamK7Nk4YzDPxqDrxeX5R5H2hcDPLVIoD/hXCJ7tYx9LgDfpJuwJpkR+bEv/mV2vk7uX7al/2QaGgdc0MI43/zKAuRercX2kNYSB59dPpwMGClvhpg6Byk1NsPTu2PjY4MjGtudY7MZGx2OlYgHj7AARfFLqAj5p0LAQrK9i9riCfMyovj4yeSQ==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v5] mm/memcg: clear folio memcg after changing per memcg
 stats
From: Bingfang Guo <bfguo@icloud.com>
In-Reply-To: <20260909225904.6d60c722ba21f26e18c98767@linux-foundation.org>
Date: Thu, 10 Sep 2026 15:40:23 +0800
Cc: bingfangguo@tencent.com,
 Bingfang Guo via B4 Relay <devnull+bingfangguo.tencent.com@kernel.org>,
 Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Barry Song <baohua@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>,
 Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 David Hildenbrand <david@kernel.org>,
 Michal Hocko <mhocko@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACA7AFD8-432A-4F77-BEE1-64230F67B06A@icloud.com>
References: <20260910-memcg-swapcache-stats-fix-v5-1-033f510ba748@tencent.com>
 <20260909225904.6d60c722ba21f26e18c98767@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA2NSBTYWx0ZWRfX3fnIBa6Z8kjj
 ZvTupFlHCm8I6c68kIn9HHOnmjMqGSdEoIJOci/j3Y26dfjB926gfwcrhgd/HO8PhwI7JHr6ToW
 qpasdvT1OAksSkYb83RA11WfMfapmwvn8Rlfg89MO6VBDOMpZ4L6Oo6gDl9IfFdmcoa51BonDWz
 yd8/NFOGUqKzFuyyPDGypM/DhO3XwZj9iBhgHu2d/2/RmR1Nonv6WyHNHNyyisDBnco1OahiVxQ
 rUu9YIjmeS2qV2nJ+U2NGc51l4fboro5inPoYa1IQg3Corp/uCXHUUXd6beM3Tp3XyYAL5OQEkv
 glxldHk9sqoehEKD9t9IEXFlBh+9H/MEnRN6C+ZcQ==
X-Proofpoint-ORIG-GUID: i5W5EbpEo-xfd81TvEJcl7e-9BUU7JuA
X-Proofpoint-GUID: i5W5EbpEo-xfd81TvEJcl7e-9BUU7JuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 clxscore=-2147483648 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2609100065

On Wed, Sep 09, 2026 at 10:59:04PM -0700, Andrew Morton wrote:
> On Thu, 10 Sep 2026 11:46:58 +0800 Bingfang Guo via B4 Relay =
<devnull+bingfangguo.tencent.com@kernel.org> wrote:
>=20
>> I notice extremely high swapcached count in the per memcg level
>> memory.stat when running tests with cgroupv1 setup by swapping pages =
in
>> and out.  It seems that the counter never gets decreased so the value =
is
>> rather useless and confusing to users reading it. So I think fixing =
it
>> so that the value can reflect the actual swapcache usage correctly =
could
>> be helpful.
>>=20
>> __memcg1_swapout() transfers the memsw charge of a folio to its swap
>> entry and clears folio->memcg_data as part of that.  In the vmscan
>> swapout path it runs before __swap_cache_del_folio(), which then
>> decrements the swapcache stats through lruvec_stat_mod_folio().  =
Since
>> folio->memcg_data has already been cleared, folio_memcg() returns =
NULL
>> and the NR_SWAPCACHE decrement only updates the node-level counter
>> instead of the memcg's lruvec, leaking the per-memcg swapcache count.
>>=20
>> Move the __memcg1_swapout() call into __swap_cache_del_folio(), after
>> the NR_FILE_PAGES and NR_SWAPCACHE updates but before
>> __swap_cache_do_del_folio() removes the folio from the swap cache.  =
This
>> keeps the stats attributed to the folio's memcg while still recording
>> the swap cgroup with a valid folio->swap.  Add a swapout parameter so
>> the plain swap_cache_del_folio() path is left unchanged.
>=20
> Thanks.
>=20
>> Fixes: 2732acda82c9 ("mm, swap: use swap cache as the swap in =
synchronize layer")
>=20
> January this year.
>=20
> How does this affect users?  Should we backport the fix into earlier
> kernels?  If so, why?
>=20

Thanks.

Users using swaps will read totally meaningless swapcache value
from per memcg memory.stat, like 200GB of swapcache on a 64GB
setup, which is quite confusing and may trigger monitoring
alerts, if any.

So I think we should backport this patch.  Although I don't
really know user space programs relying on this value to work, I
think it's always good to make sure that values provided by the
kernel are helpful and mean something.

Regards,
Bingfang

