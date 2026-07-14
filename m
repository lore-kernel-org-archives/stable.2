Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F143F4CB
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023217; cv=none; b=fK93h9Cxe5RoKX8tMB6342KfzIF6jYU4R59mUkmXIS1pdLUutjTz96K6szS/tp9+1cyjiSfdOy4lzNKd/3FZDt8hWWuy4uW8BNVf1IbVDLK3KQjZ83Z4nkwx/S+AQDSP8PWl9i9sqMaOGufWV6aC1tohR8ZAY9Qtzti7QX+GuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023217; c=relaxed/simple;
	bh=2UblGA39dbyI7ZeOFYG/YtFBL4fddvdQz9/G0Rzg30k=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=d81KPyaavCbl0CVXcv8ozCV8tpOqv1urOU9kqTsbPXV79iSWoRATGOSMlgpG4v3l1GixQqVHT0Qq0GUYXAZuDvP2VhAlwOQ/6OoIcGfS371xCgv4yA18voBFR/jcbfPCe7zPFHt/NMYXVN+g99aJkHS/z+SWtmN2ER05oK6/DgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bkl3kYSs; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bkl3kYSs"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784023212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUPSX3E//W0AeV47HSxp4Kotadz3oWkmsbNwC7CKH3M=;
	b=bkl3kYSsZsZgtlbsRJie/vYiUcqpiiAwW8MCWKzmGVHbETWoW37cqDPc8+pNOw9B+doh+V
	YGZ8pI0v8PvVLrfI2RCbusZIbxrNvlwCFiTU5qX+XgbDOMQGVUs7GFk5mydNVB4W/PqqMz
	dn7Vgg+ePbQY/swE3bofW8pauXZpvWs=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 09:59:57 +0000
Message-Id: <DJY7FYRG6QAO.2WG6GBYXUKGSV@linux.dev>
To: "Brendan Jackman" <brendan.jackman@linux.dev>, "Harry Yoo"
 <harry@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Brendan
 Jackman" <jackmanb@google.com>
Cc: "Vlastimil Babka" <vbabka@kernel.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <sashiko-bot@kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/page_alloc: don't spin_trylock() in NMI on UP
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
 <20260710-spin-trylock-followup-v1-1-affb5fe5ed00@google.com>
 <20260710170311.e22bfd21c658e8357ceddeec@linux-foundation.org>
 <DJXILB94G82L.37YBL62YO9XBK@linux.dev>
 <4c969202-a8ed-41a8-9e9a-281a12f6dde3@kernel.org>
 <DJY7A190TSH2.B1XHHIACRSYW@linux.dev>
In-Reply-To: <DJY7A190TSH2.B1XHHIACRSYW@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue Jul 14, 2026 at 9:52 AM UTC, Brendan Jackman wrote:
> On Mon Jul 13, 2026 at 4:15 PM UTC, Harry Yoo wrote:
>>
>>
>> On 7/13/26 11:31 PM, Brendan Jackman wrote:
>>> On Sat Jul 11, 2026 at 12:03 AM UTC, Andrew Morton wrote:
>>>> On Fri, 10 Jul 2026 10:42:20 +0000 Brendan Jackman <jackmanb@google.co=
m> wrote:
>>>>
>>>>> As noted in can_spin_trylock(), using this is unsafe in this context.
>>>>> commit 620b46ed6ae17 ("mm/page_alloc: return NULL early from
>>>>> alloc_frozen_pages_nolock() in NMI on UP") fixed this on the alloc si=
de
>>>>> but missed the free side.
>>
>> Ouch, do we allow alloc_pages() -> free_pages_nolock()?
>> Didn't notice.
>
> We don't explicitly disallow that but I'd say it's "forbidden by
> default"...

Oh, the BPF arena code does it.

>>>> Also, Sashiko might have found yet more pre-existing issues:
>>>> 	https://sashiko.dev/#/patchset/20260710-spin-trylock-followup-v1-0-af=
fb5fe5ed00@google.com
>>>=20
>>> There are 2 cases here:
>>>=20
>>> 1: !pcp_allowed_order() -> This is forbidden by alloc_order_allowed(),
>>>    quite a bad miss from Sashiko IMO.
>>
>> Hmm but alloc_order_allowed() would return true for !pcp_allowed_order()
>> when spinning is allowed, then pages can be freed via
>> free_pages_nolock()?

So yeah Sashiko was right after all.

