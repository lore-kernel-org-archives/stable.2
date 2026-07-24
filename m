Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D34757EA;
	Fri, 24 Jul 2026 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784851231; cv=none; b=uTfBy/QEqvg8Cfm3k3N7he9ykZTO97/usHrUuVK7N4x3PZKuOn8+mVd7ctBxJxTCMx8jm5bMRF83Wd0tNsCSZ5BTvv9gbZSzqVhYRU9e825OrKe1OJbWXyxiCAzCamMd8zbsfsPCjcXfujtAe4n4rFr3bPyCn8ZLfLDbS8kRw4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784851231; c=relaxed/simple;
	bh=q1ziygtQt1VC4PUTg2ZCZRUNM1rLW4faZSZQIPXRlSM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qAaQUXGxpIvmN4uxu/mTDXYwISjRmmlsVgIpnCEvlUn1bhsuYGYOE5RvOE5MZVq2XnKb42uVvHJ5cF3VwsRa/TFlXgfm3hEiD4ltG45tgXDzpDFrgaT/lSfFIdHrWEIfqRHUgAkhWXvO74qFYJqTo8R5nRLBDlvOQYVU1y2zxUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VInGeHuM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VInGeHuM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF01F1F000E9;
	Fri, 24 Jul 2026 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784851230;
	bh=1882OtUsatNzO6ECKrSoNPT3ltj2l2kRQNMq1cLxwrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VInGeHuMf+dOL9WihIj2ynvAIWAvGRxj4xf1cpO87KGCv62xbra4Xz7hmdH1oNx1d
	 RCpaVX8mlvhbEYwBhYJCbURGchpSzpoANkU97W4dHmxaIlSibYuOlI2pVYeP4h3Fwm
	 Qlv2LGUIiQN6mXwbsw6LPs2oOQTieBF4ClS9h8QU=
Date: Thu, 23 Jul 2026 17:00:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan
 Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: page_alloc: fix non-movable reclaim storm in
 defrag_mode
Message-Id: <20260723170029.0c076f1fca7677fbf156eaa4@linux-foundation.org>
In-Reply-To: <67e1219e-9d47-4a30-a8dd-fdcf03229f58@kernel.org>
References: <20260722150006.3848560-1-hannes@cmpxchg.org>
	<20260722150006.3848560-5-hannes@cmpxchg.org>
	<20260722162207.31a2c491ffaf36d1e8948c14@linux-foundation.org>
	<67e1219e-9d47-4a30-a8dd-fdcf03229f58@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 12:22:58 +0200 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:

> + Greg and Sasha
> 
> On 7/23/26 01:22, Andrew Morton wrote:
> > On Wed, 22 Jul 2026 10:56:47 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > 
> >> 
> >> Fixes: e3aa7df331bc ("mm: page_alloc: defrag_mode")
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > This cc:stable fix doesn't apply to current mainline because the
> > preceding non-cc:stable patches get in the way.
> > 
> > This means that the -stable maintainers will have to ask you to redo
> > the fix to make it backportable.  And you'll then be preparing a patch
> > which hasn't had standalone testing in mainline.  All very cumbersome.
> 
> Or they backport the whole series, even if only 4/4 has a Fixes: tag.

Sure.

> I don't think it's necessary, the stable team are quite capable of figuring
> out the deps and backporting them with a Stable-dep-off: tag.

What's that.

hp2:/usr/src/25> grep -ri stable-dep ../gitlog Documentation  
hp2:/usr/src/25> 

> IIRC the
> "fake" tagging is discouraged? Maybe they can clarify.

