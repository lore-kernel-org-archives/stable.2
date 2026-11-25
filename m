Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619184;
	b=iz8llx2NPEnQB9/kc189X03Y5+nQx/CqHey1S3ICeddZjklkju+RoRuM4DTwwkXVmFau
	 G2hHgaxVqX5P4y90Rr/aVpmnU8A8QB4tdvB4cAK+4yEtxeb1Rv4g/FLEziRuvyXQJqBhM
	 N3vSh1tTTpuMORLsjRtlH31M6I0EReG41FMaUMPyr+eyE4DuyQTIK78M4572pGeMIHpyV
	 HaOO7eyCuDJEge5mMMzNqTxug5/uc/PKC+bFbBQPZhk1mrhEx4bFzovtzjEbn/i+LkmFE
	 Tmk7O9POeUG87/0DN8in2llnbHReXCoS0GknNSyJaD8dMITKazyVcEynXwIbSM9X53Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619184;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=h1Dg38/TSL1Kz/srxgh6JrLfoKzHJgYzjciASNJ0TVU=;
	b=lOL+PcyJKvNEj814QDw6SmHN4w8kBJKqmUdMwHppz8PeKqCaLwHUn+9XDyAqDuzSGk8u
	 bs2Yx3CA/wzjq1S+ojSlnuktL8tfRrLU2pnE2Ln1lxdfU7wPxlONvqRUG8RMPkkRHeO+i
	 A2XtFZltyzuISLc9Gze4r0JyESfcYXaYLWnopFQdsKKQd0bv5P0d1HYuat+Z78LnUMfRf
	 rHpANY1pr25wkF35aJLMwvD9l1JAdBMlRiIL+JpqlqrJpB3TqfbCVI1tbS8KsFVeVbyG0
	 T6/3v+iMaGcbTpbQlekuMaelomdR5/cA1geE86Q/n/urlka6HXjsxnKifO63Z+ql/yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kIAXvQCU;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7139606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7139606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kIAXvQCU
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ED122F;
	Wed, 25 Nov 2026 07:06:19 -0800 (PST)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 814903F86F;
	Wed, 25 Nov 2026 07:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795619182; bh=wUo/6Std2BwKt/SvSAaU1+xDTODBfj83yfrYwoa5q8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kIAXvQCUE7siDlFw4JkX+Gt3B2vGsHfg0yI6O7uuMaK+jEevJJGPzbCrngt4QeKcN
	 d4h6QJkHo66G7qgOYORWqn2W3nOKRGcfsVmyGBdlAMg8S+3kGWTvvRtcg3rDtvC7GN
	 oD/ecGYKBS72HKPl48elYjYielJa/agf3FBjh35E=
Date: Wed, 25 Nov 2026 15:06:18 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Aveline Noir <jm5905938@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>,
	linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] lib/test_hmm: invalidate all mirrors on device-private
 migration
Message-ID: <awb5agUP80qz8iss@raptor>
References: <bae41f6fc4114357a8a74c8b958f2bdc.1@linux-foundation.org>
 <awbtZjtII9h1oJ5R@raptor>
 <CANOyQmGPHrHAzVW70Q8T3AYtzFi3C7jCQdd-QW0rQCPEf=ycyw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANOyQmGPHrHAzVW70Q8T3AYtzFi3C7jCQdd-QW0rQCPEf=ycyw@mail.gmail.com>

Hi,

On Thu, Nov 26, 2026 at 01:25:41AM +1100, Aveline Noir wrote:
> Hi Alex
> 
> On Thu, Nov 26, 2026 at 1:15 AM Alexandru Elisei
> <alexandru.elisei@arm.com> wrote:
> 
> > Might be something on my side? I'll investigate further, but I'm not very
> > familiar with the code.
> 
> I reproduced the same 0 versus 523264 assertion on x86-64 when the separate
> mm/hmm: account for subpage offsets in device-private PMDs fix was absent.
> With that fix, the test passed. May you check whether it is in your test tree?

Indeed, I didn't have the patch in my tree, now the test passes!

Tested on a Radxa Orion O6 board (arm64 architecture):

Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,
Alex
