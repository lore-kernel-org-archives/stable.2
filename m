Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423379;
	b=4qxgHoTKD0GROBGUuhcIHfq31CHXDbvgQu81JkVw3cvttWuVMo2ACyFFeHznysi/xEDh
	 YMziITHFJNlkIgA8aUFjjVcrQVwiUcS9I3qzfxSnUqpCu/OGM3Ta9X1ZbXfn6n+fIYQ9B
	 WNuxDJo5HLDpJEuByvkEaqWs5xi8qtO/PxSU6L1OiTNnjzhGZIjpS6CHtN4zV2RWuZTrR
	 inzW93SLceyPG5klBg7N1DtjMDDqQ3WI59e7FFcAhGNHts8vDFgrERB5x6gW6sxGzGuw6
	 WOvISTDnihn3mNJf090IXdvFFffrDrfyMEWA6zo1EWcaYY4tWivlWUlB86fNvuCJKWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423379;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ES6PScTn//8O/kb4uLeXWJf50MrCERiG7IFUfR8gLMA=;
	b=pc/eBOJ/BmKx/JLKsWFDDpaWf7Br8Zcc7cp2z16HruS+lkKiWfMcgwm4JHdjtcqndgjT
	 Ubcrq/yF7MMyylvGt5rVhIx1P7fycs4LDeOJbY/pVCIhPaA4YLAeaxm+yLpkEYJ2d+GQP
	 tF+wXNfnqfH+jHoCukdIHQ9tk7f0okrMFUrOfUAlUC+XtTgDdoF+Jl0ZSTam54WGv5szI
	 yOfpeWoXDBY6LcxLXjpYPhpbrmTamibKEY/ra80yttQPsrJYEz1p2PlVvJ14qpQU4zRgp
	 lz/CGMHwPMpkNYsNc6ERI80X/Mo9KY0qFlaT5AruwhTF9kD5ZuPU9pZrXALQEj7Hjmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=a0NLp93G;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E9760AB719;
	Mon, 19 Oct 2026 15:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86E9760AB719
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=a0NLp93G
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B83E1682;
	Mon, 19 Oct 2026 08:22:54 -0700 (PDT)
Received: from [10.164.19.55] (unknown [10.164.19.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7207A3F7D8;
	Mon, 19 Oct 2026 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792423377; bh=afNyowLBYnd/bJcBytrONkPV+T5KeD/gmV5hsWmX/oI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a0NLp93G3qNigo9o3p9//UAu6QuGjeI7Wda5F+kjTem5KJy9fD2LHN8hQo3SVJTzp
	 kdsfz0SYrBlst0J3RUOENQkFxluaiflLW4x4rEZeyAje7QbLwdwbuhsMiRvYW8KR9X
	 DaxRC/1RaWLCyOmHY0TvnlublfXFBQ8P31CrE8VM=
Message-ID: <3cbb17e3-e201-4138-a070-0c64289a12bb@arm.com>
Date: Mon, 19 Oct 2026 20:52:48 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm/kmsan: skip vunmap_range_noflush when KMSAN is
 disabled
To: Hao Ge <hao.ge@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261019054531.87652-1-hao.ge@linux.dev>
 <20261019054531.87652-3-hao.ge@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261019054531.87652-3-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/10/26 11:15 am, Hao Ge wrote:
> kmsan_vmap_pages_range_noflush() returns 0 when kmsan_enabled is
> false.  The unmap side does not, so it still walks the shadow and
> origin page tables even though KMSAN never installed any metadata
> there.
> 
> Add the matching early return.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Cc: stable@vger.kernel.org

Cc stable without fixes?

I guess without the fix nothing is actually wrong, except doing
wasteful work?


> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/kmsan/hooks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index a706666db097..107f66841274 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -138,6 +138,9 @@ static unsigned long vmalloc_origin(unsigned long addr)
>  
>  void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
>  {
> +	if (!kmsan_enabled)
> +		return;
> +
>  	__vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end));
>  	__vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end));
>  	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));

