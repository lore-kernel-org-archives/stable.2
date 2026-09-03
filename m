Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0966A367B67;
	Thu,  3 Sep 2026 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479611; cv=none; b=jWrPLXc27fv8lMjHaGUSf2gRtIxx7orsGhV7MphppFlvrZzpeJeNJfvilIQiklDtqjyX7ohvNiBT6IOGPsQpjqRCm3Z14Vr3VRSk0dJyupfmBqLKOmQyyjQwJm23stUKNenVO4CfWWOiXmPkw6d+2UaXkeSn68lNYihBbsd5pLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479611; c=relaxed/simple;
	bh=1oX3pvRXVVEy28Z48yATJwM23C1A7pxgKjaHrF/bOXY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CH8hZ/4oUXV4M7X/c0K3B7zXIaqV7OiStFvx/0GW1Ur2nQbMb0MiL1HeOE/pZ0/o+b4PF+oQmxUGE/KWt2cnV37A4Yusk38j2ENl7CTf51MGfmR94SXtT/VEVMOqhx0nBLU+smTc7HRsWif5ySSPzvRqN2tFzQt3DrB8sksjuGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uk+m9wlV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Uk+m9wlV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770721F000E9;
	Thu,  3 Sep 2026 23:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788479609;
	bh=UF7yqAp8ad+9sMAMDxO8x1qaT7SamIPUcIuJfPgR/wE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Uk+m9wlVUndtTSDqMjlQ18780tb8+rvugNYeEio+29CXjGT3nCz5uJkUU4dmL/8N2
	 KLPVjhXRir+7Ku8w5RHFhLFfU308IBkFDEm1noTc2OaDDHiZKDYmuyCmKShEMvUmme
	 RXswuNalV7Mu1dLlbMS3bVXItpa0zTpfSefpfZqc=
Date: Thu, 3 Sep 2026 16:53:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Adam Harshbarger <handyhandyman.adam@gmail.com>
Cc: I Hsin Cheng <richard120310@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] lib/plist: fix plist_requeue() corrupting order in the
 last bucket
Message-Id: <20260903165328.2e781581d28ce1f4dbbc0da7@linux-foundation.org>
In-Reply-To: <20260903222456.1881786-1-handyhandyman.adam@gmail.com>
References: <20260903222456.1881786-1-handyhandyman.adam@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 17:24:56 -0500 Adam Harshbarger <handyhandyman.adam@gmail.com> wrote:

> plist_requeue() is meant to move a node to the end of its own priority
> run.  When the node heads the *last* priority bucket it is instead placed
> at the head of the whole list, leaving the plist unsorted:
> 
> ...
>
> Reachable from mm/swapfile.c, which rotates swap_avail_heads[] with
> plist_requeue().  It takes three or more swap devices: at least two
> distinct priorities, so that a later bucket exists for the ring to wrap
> round from, and two or more devices sharing the lowest priority, so that
> plist_requeue() does not return early.  One device per priority returns
> early at the node->prio != iter->prio test.  A single priority is also
> safe, but for a different reason worth stating: with one bucket no node
> is ever linked onto prio_list at all -- plist_add() skips it for the
> first node and for every node whose predecessor shares its priority --
> so list_empty(&iter->prio_list) holds and the shortcut is never entered.
> 
> ...
>

Thanks.

> Fixes: 95d4b3450ebe ("lib/plist.c: add shortcut for plist_requeue()")
> Cc: stable@vger.kernel.org # v6.15+

Why the cc:stable?  A description of the userspace impact would help
people understand the need for backporting.  Please always include
such a description when fixing things.

