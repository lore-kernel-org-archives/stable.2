Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB6249F129;
	Fri, 11 Sep 2026 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143271; cv=none; b=cy5uk+0updHwnl5exDqKawMToBfXIdebokWGiQlSvveU8cNIuWRX34245VPGGD7KSdcH/PzKgJjOMe32Urq9Uyr5/DkUcIZix1QvLUNwqckkXDOft6hlyjFAnyOHEwPwUeb96AgMEKNvOk65Zm9b/O3kJ703LuCkqWVmXASwexo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143271; c=relaxed/simple;
	bh=Vo2Rt84flTHlrR53SeRzoexTdDxvQ6xCAHE0Squalo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV94TOX/Hs81VIyUXM9mMl8PxVX92wNT21UuctxYXcHxhVq1M5MkF4WcqVFVPgVpn7waFv/sxB/yhuDhV1jxens9nMt4tA5duFsctucN3zoLGe9EYHytAA2NOnfFUOKpDlk94Gj+V8Ef35eCzZvZoON9RP7ZTnGkWK+5k1dWQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EU2O9FOA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EU2O9FOA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C99C1F000FF;
	Fri, 11 Sep 2026 16:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789143269;
	bh=Vo2Rt84flTHlrR53SeRzoexTdDxvQ6xCAHE0Squalo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EU2O9FOAB0RXReo+iSvWswTGe1awdFIAnYGnrXnGYnVSP2HyZEg4Z7HQCYGkECsik
	 AS0iKBwdmRG9VPYKOCMv29gdni4e3xzrC1bQnplAVcyt/C0C7L4+sjQYhD6RERV7SM
	 d0zByqGON1lPzs33WE6quZxD3QHwahYW5VDulos1TKKYOf/g7u2VLgM5JhyYUMaCTm
	 DGtvYjQUO+E8h1l7Mb5ZZdJSKoFHxQd8VMVh+p23fYYE+09w+l0tpWvFb9W9xeVX9D
	 ep14jnMRUI8QQoptrvLF+eQQ40O7nhzZIqddhcwpqTBPKTkF7Tnzx0pPITV0y2HOX/
	 VXNumPXB4syEg==
Date: Fri, 11 Sep 2026 17:14:21 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, 
	Tejun Heo <tj@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Dennis Zhou <dennis@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH] writeback: report a Tasks-RCU quiescent state per cgwb
 drain pass
Message-ID: <aqQorKUtZgMGFHxa@gremlin>
References: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com>
 <aqQb_Jzl--8So9p_@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqQb_Jzl--8So9p_@gremlin>

And of course neomutt managed to hide all the replies from me so I hadn't
realised it had been replied to :)

Anyway hopefully relatively in line with the assessment of others on the
thread...

--
Cheers, Lorenzo
