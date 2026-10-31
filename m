Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793426349;
	b=XirCWwWWpsmV/uOAeEE7NJnmEaAYVrPQDlOZnoxHIChSTCYxud0r6MZbL9vRAWRqbNJb
	 OcLCraUUA3XqVll7UcRmFm+C1Id6Op5CrcDr6ODCSU2Im8vbqgzLc/2CVrwPuFHUfr+Lh
	 UqMKA5Z9VlVXKgr/MLzDjbdBawxt1/RfhH+51kbmEvlhs4feQJu8KMgdra3TuBJGrTede
	 NtZeoYwp00YR4Ktq2FkxcjWuvhpJb54TUKw+LpDeT5TFpdeACW9b62TpHHRt/XUqp8Rhc
	 nHS6+EfFTSrBL9kZl4hSnpZ7a60Vm/8VLv7MblznsFaAjHSThHLW5wrS/Qg1mRsBIwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793426349;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wHHnuTTmSOXbH6E8lHg0GEvp+GQz96PM/IlXLU1wjgs=;
	b=DcWZUEZ92Ps1KteO4cur18oTbXLRjSXaU+qAbwxG7OctZIo/R6bZr52ncyK9q6IWHHOD
	 pps93MpTC9Bm5VaKCJQF6eJ7P+227mn9QunOvFSiM/dox0hxvPatHVNb/Jj0FMuWWKKSz
	 ltee6rj5xaOQadBwwdZGr+5qnUvJVxmRBBAfuPdWYmRimUKvPlZkrsKqOXksqpqV+WFpr
	 smpvJ3/+Ewg/Zu2KttW5X68M5sR7qnDriMbYEzQWaorvtTw7Sp6TFoacSSS/QfDYBgAaX
	 dzP6nSrqedD6mXkQPNl4hCwYnixLokLvLbK3suX0XotI6FixBFjSIz17SApE77mbR6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WvaC4FsD;
	arc=none smtp.remote-ip=95.215.58.24
Received: from mta1.migadu.com (out-24.mta1.migadu.com [95.215.58.24])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0C606A31F
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 05:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35E0C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WvaC4FsD
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=r3xzYw939vN9vzH8UsK6AomPfxJthDwVeWo/3xRQ2Fo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793426343; v=1; x=1794031143;
 b=WvaC4FsDcAHQ2NQ2JuiHYy56AQRK9rpDlaBUPZSd+xgQihu0+x11PWIm4iqwRFyZyy1U2XAd
 No3BIBUDoNW7w/V5YVqDdoRSxK0L8ZNvB0OPSou2EJq8Y5jatu2VQdepv+5F4j7PiwSI/BjV5Zc
 4e5m+WqcgzPmPI8SJmGlTm5c=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 14fc0ff97d323868;
	Sat, 31 Oct 2026 05:59:02 +0000
X-Mizu-Trace-ID: 14fc0ff97d323868
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: muchun.song@linux.dev,
	david@kernel.org,
	kasong@tencent.com,
	ridong.chen@linux.dev,
	baohua@kernel.org,
	sj@kernel.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	josef@toxicpanda.com,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v2 01/47] mm/mglru: don't use stack pointers when walking PUD and PMD tables
Date: Sat, 31 Oct 2026 13:58:38 +0800
Message-ID: <20261031055838.60138-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6FACF8FF-F943-45C8-BDFD-3AFB5C060E0A@linux.dev>
References: <6FACF8FF-F943-45C8-BDFD-3AFB5C060E0A@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Oct 31, 2026 at 09:46:37AM +0800, Muchun Song wrote:
>
>
>> On Oct 31, 2026, at 09:41, Ridong Chen <ridong.chen@linux.dev> wrote:
>> 
>> 
>> 
>> On 10/30/2026 6:21 PM, David Hildenbrand (Arm) wrote:
>>> On 10/30/26 01:20, SJ Park wrote:
>>>> 'get_maintainer.pl --nogit --nogit-fallback' suggests adding below recipients.
>>>> But I can show there are already quite a number of recipients, so I'm just
>>>> noting here.
>>>> 
>>>> - Brian Geffon <bgeffon@google.com>
>>>> - Oleksandr Natalenko <oleksandr@natalenko.name>
>>>> - Steven Barrett <steven@liquorix.net>
>>>> - Yu Zhao <yuzhao@google.com>
>>> The CC list was so long that I limited it to people that area either a reviewer
>>> or a maintainer of code.
>>> MGLRU not having any real maintainer is a big problem; because that maintainer
>>> would know whom to CC.
>> Agreed. FWIW, I think Barry Song and Kairui Song would be good candidates
>> for the maintainer role.
>
>+1
>
>It would be great if they could take this over.

+1 from me too ;)

They both have been really active on MGLRU and doing great work for quite
a while. No doubt they'll continue to do so :D

Cheers, Lance

>Thanks,
>Muchun
>
>> 
>> Both of them have been contributing to MGLRU consistently and
>> substantially. Barry is currently working on improving aging and fixing
>> the swappiness-related issues, and Kairui is driving the MGLRU-FG
>> optimization work.
>> 
>> They have also been active in reviewing MGLRU patches, and their review
>> comments are usually to the point and helpful. They have been looking
>> after this code well, so I think they would be a good fit as
>> maintainers.
>> 
>> -- 
>> Best regards
>> Ridong
>> 
>
>
