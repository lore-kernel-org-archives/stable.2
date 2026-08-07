Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934F53DDAFA;
	Fri,  7 Aug 2026 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106603; cv=none; b=iM+iLc2sKyfmOi8VFUgJ9Y62WOK/z/LAQFSaW3UiFvmY4UTs3FJ5z5AKVlQx6jB+mOUtgQJHaYOWZ+P5cV2FYM2/FhLdDBGVWCTFWo4gU+nm5qjgfISHbzTeJz75YX18b7F2mLS3smTd7CFcp03XFNLgFoEJ+UkwepHkDC8ei80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106603; c=relaxed/simple;
	bh=Z2tpQELTJkv3OPU11PMOnQB1hQoYBuVGrBkTMIQ995Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khmYm5X7mKGwwksv7MC0o9xC+1N8HXQKvNW+TG5B/p5FNTAlxBTJve9z32JC1WWi0bab+TKXE4hHKjqnGfZcKNQ+MyD3//Ee7lwC9iD+wDe9FQdERUnM4gNCCZ0ipCPY1pRNrHnGPqIEvZLfpt8SspPQw8TECPXqIZIsybRfT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 4B9714033D;
	Fri,  7 Aug 2026 12:43:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 455FB2002D;
	Fri,  7 Aug 2026 12:43:00 +0000 (UTC)
Date: Fri, 7 Aug 2026 08:42:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Song Liu <song@kernel.org>
Cc: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, mbenes@suse.cz, jolsa@kernel.org,
 mhiramat@kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
 mark.rutland@arm.com, corbet@lwn.net, stable@vger.kernel.org,
 linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
Message-ID: <20260807084257.56a5984e@gandalf.local.home>
In-Reply-To: <CAPhsuW7vPwX-BGWmtMhA8dYwDOQYQLVXOUddZPbTvoazMpaKgA@mail.gmail.com>
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
	<20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>
	<CAPhsuW7gOs2Opo5DRm+YKxBxwU+ncBmEAKHYO5jPjzxM9S8i5w@mail.gmail.com>
	<CAOu3gNi8i9m7nEuKF28G8cYqJULvE4W6CuDeYVFk58z1xSbBoQ@mail.gmail.com>
	<20260806205144.743c45e6@gandalf.local.home>
	<CAPhsuW7vPwX-BGWmtMhA8dYwDOQYQLVXOUddZPbTvoazMpaKgA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 455FB2002D
X-Stat-Signature: i9ecsa7xz9i37xuy954zjoktkfq9ms3u
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+HubzqSoruDjDW3Q7qpDXcMyS3FS+UntU=
X-HE-Tag: 1786106580-345906
X-HE-Meta: U2FsdGVkX19vRGycf/vqMn7wZTxDwKkkJj+Jup2KS11ylAAcCBlJftUi/wKsCTprU5Qq122tD50/kFLDXbtb1gK2Tq0Lx+GXMa9niEaA1X63KGy3gsmIW2FITre6sTyUi+x3gIV3Gfvr1jPfm1jSzbwkts+Me0CQQwjJgwctv2TajrI+j0rni+aZ2XHciJxvXBZIE/3hZvT25YajD86/VUmLR2+C7xnwzBDXm3GHe9TumbGvjm0AjxFGdFBavL/jGO/JPdvAAklxXrZGPivR1hV9Ct59MbLcgsJHebdPWKdR3w3FyVivjzAd0R3YvIBXfASNvNfS3MKtvD0icvQnPFXZGt0RodqS

On Fri, 7 Aug 2026 00:17:27 -0700
Song Liu <song@kernel.org> wrote:


> 
> However, requiring compatibility in selftests has its own issues:
> 
> 1) It makes writing and/or maintaining selftests harder. For example,
>    shall the selftest for a new feature fail or skip on older kernels.

Skip. It's a feature of our test suite.

>    Either way, some extra work is required to handle this, e.g.,
>    someone need to remember that this kernel-test combination is
>    expected to fail, and it is OK.

We explicitly require that new features are detectable (sometimes by just
updating /sys/kernel/tracing/README). The ftracetests has a way to see the
dependencies to know if a test should be run or not.

We have a "requires:" field at the top of every test case. For example, in
test.d/filter/event-filter-function.tc:

  #!/bin/sh
  # SPDX-License-Identifier: GPL-2.0
  # description: event filter function - test event filtering on functions
  # requires: set_event events/kmem/kmem_cache_free/filter
  # flags: instance

If "set_event" or "events/kmem/kmem_cache_free/filter" does not exist, the
test will be skipped.

> 2) It delays the actual deprecation of a feature. IOW, the feature will
>    somehow stays in the selftests for much longer time.

We do not deprecate features. tracefs code is user API. We do not break
user space. The ftrace_enabled is something that is being removed because
it is broken to begin with. In fact, if we find out that anything depends
on ftrace_enabled, we need to revert the change that disabled it.

The removal of ftrace_enabled is the exception and not the rule.

> 
> Overall, I think requiring backward compatibility appears to be
> attractive when we go from "having very little selftests" to
> "having some selftest coverage". However, not requiring backward
> compatibility will help us achieve better test coverage in the long run.

The ftrace selftest requirements are different than the BPF requirements.
We have been supporting this since 2014 without issue. And have actually
found making things backward compatible helpful. We are not going to change
that.

I hope that makes sense.

-- Steve

