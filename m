Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9252222A9;
	Mon,  5 Oct 2026 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791204845; cv=none; b=k+iidGdduWGzGQFya1Z92Nu2di2vav++9wbOL3mz5GkG04vTNQSLSbyxxFjv+/TJqbqNzTOmMExLhSHPFEr8SyW5RR/ISEdanYh34Ei9qWfhcGNkcU/DeSzvk83vsG58NkX9DQF7J7fnWPVqzk8+l1Rg1XG80vbMEbUmuqyUmdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791204845; c=relaxed/simple;
	bh=QHXMqfCvgS8poFHJ2hnBrzonA+Ie7PSmWuuk17LQehw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P3ItEL01FwadooouM4nGAaOvVOd+CM3wJ+TwWL79TAZiyNq0yDJQzK3Bna/dw6GOOGIFSTeb78s3bVtYe+F03REck/eLeBMZHxbWTO/ba6gxveL6+DBycvFsDAJuoGuD9fXgNkkTaNff04T5IHsb77huJFccLjbC/H/N8na1jmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yyipCU4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yyipCU4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A667A1F000FF;
	Mon,  5 Oct 2026 12:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791204843;
	bh=L0WZ+X3bCrlqT3aScryv2WGhSJF2SKbCE0Wf2Qf1Okk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=yyipCU4al7wZUCxLPJtBmtOl5273fibvVCgLfHNF7po9bNlRLGzN210UCpk8JwAsi
	 doC9AmMcNB38C98pfORUq0o7zRTx6j3Dt14cazQjO+uIbCyhbpjfb5aJVWVrHAS8kP
	 Cm+cpgWnTUI3Up4Tp9CQJNZTLyemXpfPW13JBFn0=
Date: Mon, 5 Oct 2026 05:54:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: david@kernel.org, kasong@tencent.com, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 hannes@cmpxchg.org, mhocko@kernel.org, ljs@kernel.org,
 roman.gushchin@linux.dev, dave@stgolabs.net, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: don't count per-node proactive reclaim as
 memory pressure
Message-Id: <20261005055402.61065464d9c66f1540a08c94@linux-foundation.org>
In-Reply-To: <cec875e1-2afc-44bf-929d-b8f2b2a795f8@gmail.com>
References: <20261005062236.564210-1-vernon2gm@gmail.com>
	<20261004233615.df26e580c1bc916c7f3a23b2@linux-foundation.org>
	<cec875e1-2afc-44bf-929d-b8f2b2a795f8@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 18:10:45 +0800 Vernon Yang <vernon2gm@gmail.com> wrote:

>  the phenomenon resembling
> > > senpai will appear again.
> >
> > What is this?
> 
> This is commit e22c6ed90aa9, which addresses a scenario mentioned in
> memory limits of a cgroup, in detail as follows:
> 
>     Currently, this reclaim activity is accounted as memory pressure in the
>     cgroup that the writer(!) belongs to.  This is unexpected.  It
>     specifically causes problems for senpai
>     (https://github.com/facebookincubator/senpai), which is an agent that
>     routinely adjusts the memory limits and performs associated reclaim work
>     in tens or even hundreds of cgroups running on the host.  The cgroup that
>     senpai is running in itself will report elevated levels of memory
>     pressure, even though it itself is under no memory shortage or any sort of
>     distress.

ah, thanks.  It's arguably appropriate that the procfs-writing process
gets blamed for the I/O which it caused, but clearly that's the wrong
place to account the memory pressure.
