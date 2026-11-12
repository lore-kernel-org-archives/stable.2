Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485912;
	b=rgkS94d4tEwX9bEm+cdI1PYAEycHg1sCLxZ86/Hd0kj5OUjGXKXKgErjCgvkFRw8Qeun
	 accbPZnmCBnDSuEP8YTTwt2b1+uOOzM6WY1n8mntpaKhI6eowjkanRq2FKxmiBNYUynnM
	 0xlP918+vnzd34IylaN7C1MyG1iHUwvJVwUdj8bV4WsI73d7TBeHD+XtP66/q0+TN/oXe
	 2weEIC3N8BqUdQxkLLKYC43QmKVCX8YLEqiJI+0WSgCV3oNg1F73fKH5xcynLQfttYHrs
	 m4/usZJ/iaA8Z0j4RMiDF6sw15nqaU46BdIQ0wYXtlKa4nhXWLOktimIe+N4MpQkErQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485912;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=TK3aRkLRHP/iqzsQKw5rkUdu5ikzTBwM57q8k3Ae9oU=;
	b=nxfbQt1bC81z05acWAt3IjaEGVJCGXZe9AHhwrciJ5bKQghEg0b7d07y2BStZlOwuBhM
	 Us2uOfx8bqreUzJmzDJPAvukGUGZeOcHSlWtecOk/pI0kmc/BwNEFwDz8YFy/9S4RcvHh
	 27HrUQBwm5t2aLhhGEa5mbOaP2fD1/y23uCJTy1EziwmWc18FHb09tmHANctbb1+R1X9+
	 J7ciuZiBNQHQ82HUOOtvQ8kl9tPnFNjGWn2N+iPJ7SPl1JAADxX663rWrDKaNCI9DlgoW
	 dAt+FEs0lAeW59N0eopDYZSu3oOXWnzetHuXZGYJEbBFcKfxYDgfIJGGIxDEaBs27wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZH94E7p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F70606A31C;
	Thu, 12 Nov 2026 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZH94E7p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E8D1F00A05;
	Thu, 12 Nov 2026 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794485912;
	bh=TK3aRkLRHP/iqzsQKw5rkUdu5ikzTBwM57q8k3Ae9oU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TZH94E7pGMxvMIthbP4IOtLV3POYGe9pY6rVMkwD9Xv0CEZmQqoO8TYZSjuIQJLu7
	 h5UdVya5Fuw+xEGSg9KDgiYYKslo7REsw6t5vSCYAmBfsc1EO43pIV5o7YguuaUTR4
	 b1IYE/pcUNQpWqwTNaUEE5LSdKXQsTX0A3C/CNJ2J3TU5LnUrIGjWowtFGzsZrtcQj
	 gbGj+5Q9kyQVOjMtMphKQlBe+7D6qM71YziIB9zjPGXcgSmpxo3B6dp1s36MozGJho
	 F+ypjaDlZBLArB++wBEHgYOsJxEw6KhBigkY93fvxGAgODc2x5bdDvY5Qt0KIOL5IA
	 mStMyb1AEULow==
Date: Thu, 12 Nov 2026 12:18:19 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Kairui Song <kasong@tencent.com>, 
	Balbir Singh <balbirs@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
Message-ID: <avWuajpT8RU9_0PL@gremlin>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
 <aa4c71b6-f81d-4544-96fa-ed54e78b0de1@linux.dev>
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
In-Reply-To: <aa4c71b6-f81d-4544-96fa-ed54e78b0de1@linux.dev>

On Wed, Nov 11, 2026 at 10:49:34PM +0000, Usama Arif wrote:
>
>
> On 11/11/2026 18:13, Lorenzo Stoakes (ARM) wrote:
> > The OOM killer can quickly trigger again after having selected a
> > victim. That victim might not have freed its memory yet, but its mm will
> > be marked MMF_OOM_SKIP by this point, so the OOM killer will ignore it.
> >
> > This can cause the OOM killer to kill an innocent process when the first
> > might have freed enough memory to relieve the memory pressure.
> >
> > Fix the issue by freeing the memory before marking the mm MMF_OOM_SKIP.
> >
> > Note that the task which calls mmput() might not be the victim - if it
> > took a reference on the mm (e.g. ptrace), it may hold the last reference
> > and release it when it calls mmput().
> >
> > Therefore we cannot rely on current to tell whether the mm belongs to an
> > OOM victim. Instead, partially revert commit b3541d912a84 ("mm: delete
> > unused MMF_OOM_VICTIM flag") to reinstate MMF_OOM_VICTIM, which
> > mark_oom_victim() sets on the victim's mm, and check that.
> >
> > Reported-by: Chris Mason <mason@kernel.org>
> > Fixes: bf3980c85212 ("mm: drop oom code from exit_mmap")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
>
> Makes sense, it will free an OOM victim’s pages before setting MMF_OOM_SKIP,
> avoiding unnecessary additional kills.

Thanks, yeah I tried to find the smallest way of doing this, it is subtle
though!

>
> Acked-by: Usama Arif <usama.arif@linux.dev>

Thanks! :)

--
Cheers, Lorenzo
