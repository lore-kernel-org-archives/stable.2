Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E93AB5DE;
	Mon,  7 Sep 2026 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810152; cv=none; b=ZCZlHmjMjCscfMipqH5sQHKV0eY3T7zZ236tbJAl8WRXKywqlKTKPgxBFl23xEYDhkOFQa4czoWTZKdo1k9RKcg7tKSzutYHu6WLYvyo9af8YkYQrsMdMgopuJJhce8eOPAmGmh16Ilf5ZY3/aGMV1ka9gnZ4sYx35b5IElpYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810152; c=relaxed/simple;
	bh=IwH3FuM5Wbks8HTKxzyW4z/1bW+NjkDXu4BJZySaiG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5+lbGpud87iMsOepg7n6eWFQgkzpMmijvDCsX9o2TYDO9HE2ULEDX7J6Jj2mcghpvtqH+WbIlFzDXPABXedz0M3R9qj2IHKmH4VMt0T4s/Y5cmShO8460iwi+MYe5H0SY+q/9Rt5BjQom5M+UPooOgonISnoGIwv+nc4swNxEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEj9O9xu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEj9O9xu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748461F00A3A;
	Mon,  7 Sep 2026 19:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788810150;
	bh=IwH3FuM5Wbks8HTKxzyW4z/1bW+NjkDXu4BJZySaiG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KEj9O9xu/+6yoEgPy64ynq1F6oTS+ys2H+2YURc6D7yBeruySU57DmZG+OIHd9/M6
	 CAV9nkyt1eBeCSacTWcy/K3o2I1uvtfWtmSt46htZ/mFKL0T0NocdaDxEitD/BVqS9
	 nz+sSpq7HSPH9fZn3I9+xRl+yMB1g6jAuSXFonU0lgGQtnxi581INhLIU0XaUt3XE7
	 UMmd+8/a85xNHHTOYJDJfRA65FnQYZtXfSeq00kDcJnAApvRwR7XenQd9/EJCxaRd4
	 Itm2Vy7tLcOEfq4tyJ/Koni6vIQBkR1PUQDyx+tWjPND7cxaTyvMSQyxhkm1eXKa8k
	 8N0ytOnz7Nj/g==
Date: Mon, 7 Sep 2026 21:42:01 +0200
From: Daniel Gomez <da.gomez@kernel.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Suren Baghdasaryan <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] module: fix lost error code from codetag_load_module()
Message-ID: <20260907213815.0-da.gomez@kernel.org>
In-Reply-To: <20260827030503.49171-1-hao.ge@linux.dev>
References: <20260827030503.49171-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: lorebird



On 2026-08-27T11:05:03+08:00, Hao Ge <hao.ge@linux.dev> wrote:
> If codetag_load_module() fails, err is not set to reflect the failure
> and load_module() returns 0 after the module has been torn down.
>
> Also, if the module is a livepatch, mod->klp_info allocated by
> copy_module_elf() leaks on this error path. Free it via a new
> livepatch_cleanup label.
>
> Fixes: 044d2aee6c57 ("alloc_tag: handle module codetag load errors as module load failures")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

We need the unwind from codetag_unload_module() as reported by sashiko.

With that,

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>


