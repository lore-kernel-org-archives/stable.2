Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA87308F26;
	Wed, 24 Jun 2026 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782333262; cv=none; b=XNfpZcNS58rerFsyDAnMz3voA6YMrH6lCgSAJDavmd/ZFZCu15aqN2b+ez9xUCf3ZzcRo5e6E8V/u59/wHnkKKO0z9w+o50/IOe8PW768TY9U6RtfP6Gfmi2BkfhuM00eQQ5CrYluZbDxx7rnMuhtnmLXvG944jlR3cHc9Fo0D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782333262; c=relaxed/simple;
	bh=pXtqPC3xL1xDX7aO9UcYEPYrItrD+HVpL8P4/i9MiZs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eFetPlbkL4Fox0OUg4ql7W8GYVXEdA1I1OkJmUej7bO1RnS2Y9GI+6Bww9iabncy/PcW1cNw06LiUrJDaL1HGcg6G+lsFw6hM+l1j2gZlG4bJmFXupvE2tbAvqMlXE4tJb0289Z5BehCeqSF2wdSJHyMxEHqPE8PVNry1IlYGDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jNERU6yA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jNERU6yA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FE21F000E9;
	Wed, 24 Jun 2026 20:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782333260;
	bh=v50C9rmilrJSPUZRmZFJHXf8XpnOvwu3LDKb8v0nT/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jNERU6yA88PY6pt5GF3po/0MPuC5DfMcfLoCMASqAnAKjDV0fJbnH2eGL9mNBy0kS
	 zrVdwq8MXqwVqF3dYQuKSECoE6G7vDT5Qe+0wTRCcMXZEOCJpAHlFnpf/iFMw8Da4a
	 9e5tCqhsVDsJnCKoeO7J1EeLnnuqVFdxUPnGRf6c=
Date: Wed, 24 Jun 2026 13:34:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Petr Mladek <pmladek@suse.com>, Feng Tang <feng.tang@linux.alibaba.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <chleroy@kernel.org>, Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jinchao Wang
 <wangjinchao600@gmail.com>, Kees Cook <kees@kernel.org>, Rio
 <rioo.tsukatsukii@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Pnina Feder <pnina.feder@mobileye.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Douglas Anderson
 <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>, Tejun Heo
 <tj@kernel.org>, Zhenguo Yao <yaozhenguo1@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] sys_info: add helper for callers that handle
 all_bt
Message-Id: <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>
In-Reply-To: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net> wrote:

> Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
> Add a helper that strips that bit without turning an all_bt only mask into
> a kernel_sys_info fallback.

I assume this patch wants a Fixes: and a cc:stable also.

It would be nice to have the conventional [0/N] cover letter to tell
readers what this is all about.

The patches all have different Fixes: targets.  This risks inviting the
-stable maintainers to merge only some of the patches into some
kernels, resulting in an untested combination and which might break
things.

It would be cleaner to make all patches have the same Fixes: target if
possible.
