Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794746627;
	b=GZmd6X9wumk6HHOO7x7iIfb1hESpUCgwN937bBCUJqqMB9GgEPoZNqevVnvgG30Z45Nh
	 xT15VgyoutwuG7lO+9jAdVWGbI4RmfAOsiTIWJJdlOXmDktydVNS8bL7FNs7B66PLnuJN
	 mGpIwsWEqZsIFt4fBSEUOGVmIv10uGPxp20HsNsNVFe+ZoKZt6objBW8myAHS9HcnXIz2
	 cG/AW5KNjzQz8z4KS6/1bRoKiF4GUAdWqZvIaCdkRLFPKxVbastHVE/dxe6Pug729veoB
	 TLTGxBatHcmCw7RoWsOHI1w4/IG4kp9VAtlnHFItYTy0qmC8F2f9/uGjPxIpo6v2V6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794746627;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ItLIVfR1UvySuEEyBIwhJcSgZBhLRZU0DncWL/OBsMk=;
	b=h/jtpU/dMDfMyeCgxzuOuSQrngFxnzLWzUurPD1/Qf9NwI7RvzgvkBGlW/tz60ipXRHd
	 Dvoc0r0Ql7K510Z51nfv2phBSQUt5WOvK8OaykDGIGPuPC2DCo7pNBu/V8tZjwKxX4qBJ
	 TZLLMWolYuAJ5KPvCl5sDE/oy9ClWaDbLV2uK4QT/HSQzvch4Wy0hb0zTUnwWnuq/Q9IQ
	 Rn10Lt4CtXohs9wS6HNYkD8HLJnBOjTk1Sx2722Bz+lg4lUdwhj2DA9fcFAU0sR8HWCZO
	 3uh0FCs3GZm4OK4UMPxuoSjj0E+fn3wON0wKnf0PnBt7DpZYDyfS500GIxn+Qhk+NFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQUCoZgo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A334606A327;
	Sun, 15 Nov 2026 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQUCoZgo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E391F000C4;
	Sun, 15 Nov 2026 12:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794746626;
	bh=ItLIVfR1UvySuEEyBIwhJcSgZBhLRZU0DncWL/OBsMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kQUCoZgoZYY0fcgF/LYN5sg/FhigfV0RmeA/86U/4sCjPuPGBE7pd/oHPIVJVMHeI
	 2IlWDFrE2uywqCCL3Jj4I0gGH96okLxf/UhYvS5kk81lBsUXiLT0XG4bnC3fmIIbQT
	 FAXlrPGLPbzjzk/slqBIXIi2bdAAItZxNHxkbUNb2Djd2SOHBSqePSUK+11mTmke2o
	 pFbiltFhIDDUt2GyBFurnDfb1H58W6ugxVtf1bPJT4VmYgHVtu2+LnWlCcDTfojdcw
	 G5zEG77A/QC/3H4C0a3ofuIthVL6eskpAnW0W6WqaYJziKQzUOtpAXQO19MXd54q0C
	 fv05uW8CCyplA==
Date: Sun, 15 Nov 2026 12:43:34 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Chris Down <chris@chrisdown.name>
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
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Yu-cheng Yu <yu-cheng.yu@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 08/13] mm/migrate_device: fix ksmd oops on a migrated
 KSM page
Message-ID: <avmojuNNO_ZRKL1P@gremlin>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
 <20261113-mason-migrate-et-al-fixes-v2-8-50a2ed382b61@kernel.org>
 <20261114115657.f63de4714929f7af@chrisdown.name>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114115657.f63de4714929f7af@chrisdown.name>

On Sat, Nov 14, 2026 at 11:56:57AM -0800, Chris Down wrote:
> Hi Lorenzo,
>
> Lorenzo Stoakes (ARM) writes:
> > [ ljs: tweak commit message, comment, also refuse device coherent ]
>
> Alistair's Reviewed-by on v1 came with the argument that KSM pages should
> still be able to go to device coherent memory [1], which is the opposite of
> what this does now, so it's probably worth checking that he's happy for it
> to be carried over. Going by what ksmd does with zone device pages, the
> change itself looks right to me.

Given the endless waves of AI fixes I think giving a little slack is fair
on details :)

But, yes, that was a mistake so - apologies Alistair, let me know if that's
OK.

>
> I've tested the device private case. Without this the process hangs the
> next time it touches one of the pages, and with it the migration is
> refused and the pages stay merged.
>
> [1] https://lore.kernel.org/r/avTu3LmscsttRVRp@nvdebian.thelocal
>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Tested-by: Chris Down <chris@chrisdown.name>

Thanks!

--
Cheers, Lorenzo
