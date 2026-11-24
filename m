Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541025;
	b=mILOME7BGclUkA9p1ZMqaKU3LjH/1ca7rzaNXau5of4/IFLL3nFWypGiqLMupB873ZDa
	 pgdZeS5737kg+NVz/rQlsoF1/XyWGhcX9OmDcHykBkKE9cZYBCU2dNK59iAcSZlUy66LF
	 P22AqbBG+st0BOvQNQ7Cpb+FAvVWbmHAtngWKTCpUxc6ZriybpHpzcwT0mTK1fopLTnir
	 pp26TmrLOiaUJXRLTuOk0OgMBw95NO+yMbKUxWsrf0tfKyP4SojcOkeZP007aQhX/HB1r
	 FFxCsKXIffSxbQJj3zakEOHr4koNSnbBcMZH4l8JS+hFVE90lF/7f4g2RsVrOsAJTHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541025;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=fS8UX0zOG7y5HTbRfTEb+A5QmGIQnuTVBZNrsVPO3QA=;
	b=sq2uGb/2/WjKcxi0zlQ55QRYoNBZeu9A86Xvk26kv/4d6ZTthxvORN8w/SBu8Uqt2gZJ
	 Gfs20eJhmhLkGUSZpVzol2P5Xhy48mBA25L9UTWx5yEj5WL+yG45BZ1sRa7VsnT9mcqvX
	 N6lV5XA6q/rrvUIOSn/Qsu11kWjGk4RK0UohI6RxSS3prxURfGT4GrAyf0InLLR5Jw3K+
	 x4CurLYMBKX3HgUyi7mf99JLQw8tfuO2AL0RKgViNig4PM3usE4cwgyuO4MlfnQTdYhXK
	 gtgUNZJMnBONqYhFGq03qfm8oobQpgvnasx7pxOHqHawITXdhEoxYIrx7LkOlIASyyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aIER/tK9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA15606A32A;
	Tue, 24 Nov 2026 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIER/tK9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F0E1F000D1;
	Tue, 24 Nov 2026 17:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795541024;
	bh=fS8UX0zOG7y5HTbRfTEb+A5QmGIQnuTVBZNrsVPO3QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aIER/tK9Xj9J7xTkM7cNMYCpdtYq0gOZ2/0BrOQlgPEO6oQ5XstyYWIMiG9xBv81o
	 dW0o2fsXWJ7a0R3kzyAd7SW3xgwAyK/lFagJBx9SUiAJivswcb77/aFDQis9KITn4z
	 2hQCWdu8XGvvjs6cR7zxu41TDaqS1fRg7RPlbK6qgQsdkTQWIKRav9VBIUJDloU4/S
	 T2qG0m0Y5nYwqLVJD7Bxbjy8GBYXbO+AkFaxmZ6p4feLXekf2YjojAswcGcH7TtM8d
	 Zjm526349OF6EKBgApdu6YcK8jHdyS6sID2wuiZijTsgye75nh3feB7scItYNrqYsZ
	 zfI0e9bBZJN1g==
Date: Tue, 24 Nov 2026 17:23:35 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, 
	Pedro Falcato <pfalcato@suse.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jann Horn <jannh@google.com>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
Message-ID: <awXHR007d8MlhJUC@gremlin>
References: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
 <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net>
 <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
 <CAJuCfpEd1rz3P7fB7W_mHkyzbpq9TscRE+QNwvHdYME=WJj6cw@mail.gmail.com>
 <awWz3nc_b8x3mIXq@gremlin>
 <CANk7y0gAxY18Ew+6j5YsqrOsf5Dx+v5M78r7_8JLXh5RHZj4qA@mail.gmail.com>
 <CAJuCfpFuDCUPTUi3SuAhmbtw5tubRZ0+YEY3PotjyJ8Or8pdQQ@mail.gmail.com>
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
In-Reply-To: <CAJuCfpFuDCUPTUi3SuAhmbtw5tubRZ0+YEY3PotjyJ8Or8pdQQ@mail.gmail.com>

On Tue, Nov 24, 2026 at 08:34:40AM -0800, Suren Baghdasaryan wrote:
> On Tue, Nov 24, 2026 at 8:06 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
> >
> > On Tue, Nov 24, 2026 at 9:28 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > >
> > > On Tue, Nov 24, 2026 at 07:51:42AM -0800, Suren Baghdasaryan wrote:
> > > > Actually, VMAs are allocated from a SLAB_TYPESAFE_BY_RCU slub. With
> > > > that RCU unlocking move you don't need other_mm copy and the comment
> > > > that comes with it. VMA won't be freed until RCU lock is dropped.
> > >
> > > Yeah but they can be reassigned? They won't be _freed_ until a grace period but
> > > they can go back to the slab and then allocated elsewhere  right?
> > >
> >
> > Yes, they can go back to the slab and become a different VMA.
>
> Yeah, you are right about that. So, we either have to keep the RCU
> unlock in place to keep other_mm comment valid (my personal
> preference) or update the comment next to other_mm to explain the new
> reason it is needed. Either way is fine with me.

I think let's just change the comment?

Andrew could you change:

	 * stable and can be freed in the narrow window after vma->vm_refcnt

->

	 * stable and can be reused in the narrow window after vma->vm_refcnt
	                     ^
			     |
			     just this freed -> reused :)

Thanks!

--
Cheers, Lorenzo
