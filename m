Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E53A5438;
	Thu,  6 Aug 2026 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043019; cv=none; b=NFyh4uRmTUtyCsZeW/RNSgjV+MEuyGa/XTpXhIQpKxXmII7ASIi1OKzb2S6JdmXXmeFFjgVqyaNhJ5/InxeMgVVpQkyS5UCwla0z5AE4upYAvvClrQIHfWrwNBZtGPzjtwYW0ZGKYSkHOrbumSuqvDpur8N9ru3LrrWayGaXZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043019; c=relaxed/simple;
	bh=rWIN3CAoTOmn/dHplE3EM/vqreNCuPNk0XcMox2UW4M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EYAtHGbMJFBLVATPNzfvFcaEiXwKeRfSBPR80eomPV90E+ZQDK1V4DDCI5DkqrV6mUMy7x9dyJ/3aAny/FFTnr0wb7MqJtg3zfVgR/vqHAFjyhqtI1Q2j353loKTRRmXGXQI+DTUTQui7Q+flU+1K1OKGl++pfoHOhTG4D1gg+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S6HabWo4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S6HabWo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869D21F000E9;
	Thu,  6 Aug 2026 19:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786043017;
	bh=dRt0s7vfM2bnz3NqZRZ9IExdeacv27vJYYUrCTtxIiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S6HabWo4OztTo/PiObEDh6luKFIDnwMqPcGG/RkJg9S5pUwEXj8utnavmqMb/S1+t
	 YdwJzCVygJOtG352PEat3qf+0bzmGKHiWhmRT1DC19OPC6j8ZyjN9m3mXkBKdw0Cxn
	 Kwru4dhgGBMyzpD3DN/wJTzu2U6z1fu54kScQfIA=
Date: Thu, 6 Aug 2026 12:03:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Hugh Dickins <hughd@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, John
 Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Kiryl
 Shutsemau <kas@kernel.org>, Ackerley Tng <ackerleytng@google.com>, Frank
 van der Linden <fvdl@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/gup: fix always draining LRU caches in
 collect_longterm_unpinnable_folios()
Message-Id: <20260806120337.2c7d65fd7f9d534bf4ffed1b@linux-foundation.org>
In-Reply-To: <564e64b2-1b71-4d8e-a29e-dc98e8deb006@kernel.org>
References: <20260731-check_and_migrate_movable_folios-v1-1-e0002d7b791e@kernel.org>
	<f616e9fc-339d-4430-43ea-0ec8810c5f3b@google.com>
	<20260801122040.7230a8eb0dc846ce357fba67@linux-foundation.org>
	<564e64b2-1b71-4d8e-a29e-dc98e8deb006@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Aug 2026 18:29:39 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 8/1/26 21:20, Andrew Morton wrote:
> > On Sat, 1 Aug 2026 11:49:39 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> > 
> >>> Found by code inspection. If someone has a testcase that can easily
> >>> trigger this and result in migration problems, please test! But this
> >>> change seems to be "obvious the right thing to do".
> >>
> >> Sorry, I don't (as perhaps is too obvious). And I'm a wee bit afraid
> >> that some of the problems which those changes happened to succeed in
> >> fixing, might now reappear once the drains are finely targeted.
> >>
> >> Am I arguing for a delay before advancing to stable?  Perhaps, but
> >> I think not: it's probably best to get that working as intended,
> >> then deal with any fallout if it arises: just be on guard.
> > 
> > This patch is in mm-new, so it's still some months away from -stable
> > eligibility.
> 
> I hope you meant weeks :)

I was unclear.  The patch is (now) in mm-unstable, aimed at 7.3-rc1. 
But I don't expect it to be released in -stable kernels for some time
after we've added it to 7.3-rc1.

I don't know what the latency is, really.  Seems to take a week or
three for Greg to grab these things, but how much longer it takes for
it to get into the 7.2.x and earlier kernels is probably quite
variable.

> Can we get that into 7.3-rc1, though? There is quite the overlap with
> guest_memfd work, and I'll send another patch that depends on this.

Yep.  In the second-week-of-merge-window batch.
