Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085142;
	b=bd7NVBPokaXpQZGY3eCDcCABhPavXfutD28PksVLhnw28/i4FSG/iAdYKfzdv6GcAqbX
	 hdLQcR87KTM7cLPpPX2e6vOJBtolJzZyQqHS437Rf7SHK9iGmoXpECQVBhZ+tjwR8v8wj
	 lxeEyyostVIps5NWfc3LfxVLYVkqTbG8o+d6snl1J+EqvwNrXNziZiM6/Zci9hOF0F5LD
	 qU2Kz7DNw2wGeF6xPglNvyM4V41C5yZp76ERZi7ZI09DLtMaPdwEuiLWfOkhxCceaPfbV
	 /TKFMxEr7lbLAJ4N8IMxa0NAkCJtGuphyV4/wmcyi5lwaVY8McI6x49xRAd75AvprpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085142;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gtdNnLom4qpn3DvgmzGMm6xPHdf4ojR1KNUGjX1eUNk=;
	b=b06YF58U/JBOOkYaRJ+6CtRIl3pYkTa9oECvTuU9SxFaGlxvOeEMmbQMWJcgh7Vp/qAQ
	 eccszM5VDWOl5GMBGLbZvjUOd7vmRzScO3vvHq0JXAbopz2O5ipMxQ0+sAgXiZN/HaB6R
	 XYSGBCXobVm4VGRxSbtAdXECHqKxWJckiRT2RvfPDJwAoOTBZq4wZa0frFUFGlZvVM72v
	 9r4VvA3VlnDtB7ovsFUlodzxRJw9EEXVmv6qRyFGEOLb4OG0liIEa07bpZ4iWoFAPdUqI
	 K293K8CEC/iRae8vTxZjnH5It54+pqvdAA5GeQhYWt6F90X1RtU/VjMg8nRayureXxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FfiDc6lQ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE6B606A31A;
	Tue, 27 Oct 2026 07:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FE6B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FfiDc6lQ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CBAC1655;
	Tue, 27 Oct 2026 00:12:17 -0700 (PDT)
Received: from [10.163.152.160] (unknown [10.163.152.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F06B3F673;
	Tue, 27 Oct 2026 00:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793085140; bh=a8GTRJb/qeXzyezkSqk5mOqJzNR0LEKUkQ+3k+5mvZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FfiDc6lQo1cXuVWAHm7sZJKVPvB1uBSZcBxPlRTRTKZB9P2/HqL0iAsLKLf/ssxMF
	 ewNuKCyCho5VuZn4COMZ36FF9jRRuUEgT7JmcRN66+bZPL6d1ZNnonW1F5rlGHUUuO
	 xoTW+Fk8ljZo+MhZo0XWRWOqXNpvgAySN6D+/GdQ=
Message-ID: <0757f1b0-9af6-417c-a4cb-eff0b05ba277@arm.com>
Date: Tue, 27 Oct 2026 12:42:12 +0530
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
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
To: Kiryl Shutsemau <kas@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Harry Yoo <harry@kernel.org>,
 Usama Arif <usama.arif@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>,
 Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel-team@meta.com
References: <20261012192834.6934ef85444dee4a60d6d876@linux-foundation.org>
 <as5q14OsbK2CmOrh@thinkstation> <20261014202936.GC371161@cmpxchg.org>
 <78238103-3a7f-432c-b1df-bd14d7cf4bb1@kernel.org>
 <atDMN5MoGrwJNpAj@thinkstation>
 <4aa14b41-9b89-494c-8825-55fffd5a541c@arm.com>
 <atiCG2iPrHwDznSZ@thinkstation>
 <d2b8edf0-39ab-4a44-bd0d-58230dee2fad@arm.com>
 <ats7oFM-fsYdUS8y@thinkstation> <attOFXch_TchIfEv@thinkstation>
 <atty0n4UzTfI46eN@thinkstation>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <atty0n4UzTfI46eN@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/10/26 8:16 pm, Kiryl Shutsemau wrote:
> On Fri, Oct 23, 2026 at 01:12:02PM +0100, Kiryl Shutsemau wrote:
>> The diff below replaces the previous one. It needs cleanup and splitting
>> before it goes upstream.
> 
> Proper patchset:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git page_alloc/nofrag-watermark-v1
> 

Thanks! I applied the 3 commits on top and the results improved a lot. Your patches
make sense to me.

But still, I see more compact_stalls and a worse compaction success:fail ratio. The
limitation must be by definition I believe: we still won't be able to use 64K blocks
from non-movable pageblocks.

