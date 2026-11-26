Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695815;
	b=S497cPU5Yk8Peu/AEyl793fP8gf+CMOoEzKPxwnyf2MdR1+f9hQL2nqqObDM+2B6uqcq
	 +1hSIkAm6rtId+IbtcpjtEYAqPzYCcUA+ewO1QIE7pgvGpftNKhcBUWUxGT5nUOLNQqWX
	 OPod9BOqPt5vYczWljuoKA7mOlAZO3ZJYomfZpEm2hY4DuPjbW4h7lY7PZrVie59ZfZUp
	 OwiyqH3iQWg79LwwZ6GlvhMmtj7KM2irXVWX+OkfolghrxBihSBwfRR75mwtvrOKy2VSW
	 VEdoQjwptQNe8co3YCH4ULMH1FUpCbG+jCoob6OwPpZj68XeCWuvlMr8K1oU7im/nHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695815;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=cahhcaJkLSgbEXecUz3sF/BpNciuZTRujvnzV1iz1qI=;
	b=tyd9IoRYgF70wTjH/nZwh65IOMRCMG/4975dVY10VcrtvL6qUR5CoWIYYZDua6mGUa9r
	 SPg/5AGafBA1PMCOTkpvb5voE7AgT+lkItXm/xBn87a8W50BxwfzfuhTOVJg7MAGCJQtk
	 r5oxnjRTnp2ybUk39K+jZ/cCqI3YFyRmfHwwX+Sby88rcPKMfGsmVgPd2GXcB0XI9CLX/
	 cR1a58XnYoX4xGlTxRbDI/+D8E6A23HLQFUDu72T+1F2SGmHVga9+/q5dVUnYITR452zL
	 m2rnNcZa14O8FntgXsDxaNF9jNQBlwln1kQAtK+ybVQVHRpA3C5LnrYboqtkUra+x+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=b2GdKWKk;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F56606A69F
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34F56606A69F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=b2GdKWKk
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F0B21C2B;
	Thu, 26 Nov 2026 04:23:30 -0800 (PST)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E77E73F86C;
	Thu, 26 Nov 2026 04:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795695813; bh=z+IdbNawuD9ltkD6CIHv0qQogSEt72dKkCCiWg6ydoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2GdKWKkzhHp/0Yq3ixGcL40x9Vg7RS9//T+G4j/CE4kZ9YHIKOqvwfoeurOofIcf
	 38qlwg/L+TWUehuri88N67jYwpOUSatWUrC3zALaQ5pvD8p8dULHGdQuFu4Rp8Zm9E
	 ist3QH727Y4pzC5YNdvXpS/KcNtc3Qzr+tLTT0eY=
Date: Thu, 26 Nov 2026 12:23:28 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>
Cc: Aveline Noir <jm5905938@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Ralph Campbell <rcampbell@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] lib/test_hmm: invalidate all mirrors on device-private
 migration
Message-ID: <awgkwFE0P9miJj-n@raptor>
References: <bae41f6fc4114357a8a74c8b958f2bdc.1@linux-foundation.org>
 <awbtZjtII9h1oJ5R@raptor>
 <CANOyQmGPHrHAzVW70Q8T3AYtzFi3C7jCQdd-QW0rQCPEf=ycyw@mail.gmail.com>
 <awb5agUP80qz8iss@raptor>
 <be640357-419b-4c78-8d96-3c698424ecd8@redhat.com>
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
In-Reply-To: <be640357-419b-4c78-8d96-3c698424ecd8@redhat.com>

Hi Mika,

On Wed, Nov 25, 2026 at 06:40:12PM +0200, Mika Penttilä wrote:
> Hi,
> 
> On 11/25/26 17:06, Alexandru Elisei wrote:
> > Hi,
> > 
> > On Thu, Nov 26, 2026 at 01:25:41AM +1100, Aveline Noir wrote:
> >> Hi Alex
> >>
> >> On Thu, Nov 26, 2026 at 1:15 AM Alexandru Elisei
> >> <alexandru.elisei@arm.com> wrote:
> >>
> >>> Might be something on my side? I'll investigate further, but I'm not very
> >>> familiar with the code.
> >>
> >> I reproduced the same 0 versus 523264 assertion on x86-64 when the separate
> >> mm/hmm: account for subpage offsets in device-private PMDs fix was absent.
> >> With that fix, the test passed. May you check whether it is in your test tree?
> > 
> > Indeed, I didn't have the patch in my tree, now the test passes!
> > 
> > Tested on a Radxa Orion O6 board (arm64 architecture):
> > 
> > Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > 
> > Thanks,
> > Alex
> > 
> Did you run the full selftest? 

I dropped the ball here, the output of the full selftest is a couple of screens,
so I just focused on running this one test while I was trying to get it to work.

> 
> Without skipping own invalidations the normal migrate to device test fails
> ( With no skip, migrate_vma_setup()'s invalidation erases the caller's own entries) : 
> 
> #  RUN           hmm.hmm_device_private.migrate_fault ...
> # hmm-tests.c:1023:migrate_fault:Expected ret (-2) == 0 (0)
> # migrate_fault: Test terminated by assertion
> #          FAIL  hmm.hmm_device_private.migrate_fault
> not ok 14 hmm.hmm_device_private.migrate_fault

I can reproduce that:

$ sudo tools/testing/selftests/mm/hmm-tests -r hmm.hmm_device_private.migrate_fault
# [INFO] detected hugetlb page size: 2048 KiB
# [INFO] detected hugetlb page size: 32768 KiB
# [INFO] detected hugetlb page size: 64 KiB
# [INFO] detected hugetlb page size: 1048576 KiB
TAP version 13
1..1
# Starting 1 tests from 1 test cases.
#  RUN           hmm.hmm_device_private.migrate_fault ...
# hmm-tests.c:1023:migrate_fault:Expected ret (-2) == 0 (0)
# migrate_fault: Test terminated by assertion
#          FAIL  hmm.hmm_device_private.migrate_fault
not ok 1 hmm.hmm_device_private.migrate_fault
# FAILED: 0 / 1 tests passed.
# Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0

I ran all the device private tests this time. I don't have a device with
coherent memory on my machine:

[..]
# FAILED: 77 / 78 tests passed.
# 40 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# Totals: pass:37 fail:1 xfail:0 xpass:0 skip:40 error:0

Thanks,
Alex
