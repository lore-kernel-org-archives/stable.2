Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0318125B085;
	Sat,  8 Aug 2026 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208030; cv=none; b=p3ph8wpgql3dIu4m7GrRXbPOw/2bmTpKDe++if0h4HcY07agki2QC8FO4FB/cqsd3utr6VG27YHnX5Lq1oWbwViLJyMGwkkPpm3XzmeGFGpALW3AqEKzUvorNwWRiLqNYz+iMBjmy9/5Bs4ux1R/EsgmrdUQ/YC7eThFYCR+NDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208030; c=relaxed/simple;
	bh=gZRaFiBukDh3EZxovMXnuh60OG/dMwucPpfGT5gaD8Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r8/d68ieCIUedVBN3UkiKXpV0XxTOO0h/dj04Bys4rkcGILPFFxlGK/x7zBnBTp75JApufEPptEoXLeQrc9h2MwdXns7XkK+Aem4BQ9hhajBjSi9wv4TiN7NwlmVI6HiBcgN66AJ+HHyl/tQks9MsUJHTaBU+YESMevu/ExX6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TOCoY9zj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TOCoY9zj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CA01F000E9;
	Sat,  8 Aug 2026 16:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786208028;
	bh=Ax9y1xfFH3chaxJ3oaEZM1cwYboqVTK0vjI4kxFoY/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TOCoY9zjFfXkLgyDmi66obQzYFxAcWbQFoGdPmRWiDqW3K9Uod304Z0AuSwCz8zFY
	 jnBfK+vzR6CYIXRaqDtfqt0uWSB39jpA7C5a8+WGZN30dnWG1pdY0ghByl6GVRJYBr
	 LUP+dzlKMd7iWUtO02S92Hn+UPZKtAGOKQFwflx4=
Date: Sat, 8 Aug 2026 09:53:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hui Su <sh_def@163.com>
Cc: andreyknvl@gmail.com, dvyukov@google.com, glider@google.com,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, qiang1.zhang@intel.com, ryabinin.a.a@gmail.com,
 stable@vger.kernel.org, vincenzo.frascino@arm.com
Subject: Re: [PATCH v2] kasan: fix cache shrink race with CPU hotplug
Message-Id: <20260808095347.d9335a79ea6513d613784d48@linux-foundation.org>
In-Reply-To: <20260808093803.3138988-3-sh_def@163.com>
References: <20260808003921.fdb0df9ee4417b38f15e8c68@linux-foundation.org>
	<20260808093803.3138988-3-sh_def@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Aug 2026 17:38:05 +0800 Hui Su <sh_def@163.com> wrote:

> Thanks Andrew,
> 
> On Sat, Aug 08, 2026 at 12:39:21AM -0700, Andrew Morton wrote:
> > AI review suggests that there's a pre-existing quarantine_size
> > accounting flaw later in this function:
> >
> > 	https://sashiko.dev/#/patchset/20260808031459.3032812-1-sh_def@163.com
> >
> > If true, I'm surprised this hasn't yet been reported.
> 
> I'll take a closer look at this. If it turns out to be a real issue,
> I'll send a separate patch since it's pre-existing and unrelated to the
> hotplug race fix.
> 
> > Also, I'd like to see a need_resched() wrapping that expensive
> >
> > 		/* Scanning whole quarantine can take a while. */
> > 		raw_spin_unlock_irqrestore(&quarantine_lock, flags);
> > 		cond_resched();
> > 		raw_spin_lock_irqsave(&quarantine_lock, flags);
> 
> Good point, that makes sense. Would you prefer that I fold this into a
> v3 of this patch, or send it as a separate follow-up patch?

Separate patches, please.  One patch per concept.
