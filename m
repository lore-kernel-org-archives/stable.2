Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDEB37189C;
	Thu, 25 Jun 2026 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782421261; cv=none; b=DqMtjP0AamvoQ05XITk9wBDDKIqRf4lRK1UaHwwBgQNfBn5fhTrE14zJXCua1IxKRMXReIYzkjWs0p+Tbxfud3eR5wgMBWyI6xh713IUxNaT/8UuxKSG0KwYgfX3gY6n3w2ROPeN66Wu9Mf3vyvABhYnEc6H+wBeqdwVTJ0fWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782421261; c=relaxed/simple;
	bh=ko0mX7Afs1yy1jOXU0GvZ+uicWQcPJLYDI+ylanoqTg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HR7RIrVt33+T/NSqADJzgo83UGoqma9aGArjup1H2hgHlC73yGzsiK0lx6bOgnfc4FjgRzAHs2yPfaI85rCukftWrEWCkWVJbsSE/Z52+JHMPTO8iucVsRrxih3NxkpEkMSCsvMxVA4pnMJMqX3LlkjVQehOzOxRabJvNr9LSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=GxvgJFkE; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="GxvgJFkE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782421250;
	bh=64HTg0uFKX95Q5pSeC9H32PA2JC3Aqc39eu22kNWJLg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=GxvgJFkEbpITe5DBm/v10raibSet+yGLFH6b9hw3t4LlZGM5OKX55kIEwOEsMaq9k
	 koxzBhKyAYCPOnf79CwvO/Fh8mq+B1sbVRPziffuSYgzSsayol1qmNeMDLYuANBKqO
	 ZHzVdiK4eHF+RMoF9UzKVA8dyPW4EbbSThCr4BTs=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4gmWRk19Vqz6vy4;
	Thu, 25 Jun 2026 21:00:50 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4gmWRj4tZPz4y2q;
	Thu, 25 Jun 2026 21:00:49 +0000 (UTC)
Date: Thu, 25 Jun 2026 22:00:46 +0100
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>
CC: Feng Tang <feng.tang@linux.alibaba.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jinchao Wang <wangjinchao600@gmail.com>, Kees Cook <kees@kernel.org>,
 Rio <rioo.tsukatsukii@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Pnina Feder <pnina.feder@mobileye.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Douglas Anderson <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>,
 Tejun Heo <tj@kernel.org>, Zhenguo Yao <yaozhenguo1@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Michal Hocko <mhocko@suse.cz>,
 Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jkosina@suse.cz>
Subject: =?US-ASCII?Q?Re=3A_Fixed_tag_magic=3A_was=3A_Re=3A_=5BPATCH_v2_1/4=5D_sys?=
 =?US-ASCII?Q?=5Finfo=3A_add_helper_for_callers_that_handle_all=5Fbt?=
In-Reply-To: <20260625113814.9372b8a78b374560393fd879@linux-foundation.org>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net> <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org> <aj1Jh57McGH94gGY@pathway.suse.cz> <20260625113814.9372b8a78b374560393fd879@linux-foundation.org>
Message-ID: <B0FE0A33-91FF-4914-A535-73505C01F9E1@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 25 June 2026 19:38:14 BST, Andrew Morton <akpm@linux-foundation.org>
wrote:
>On Thu, 25 Jun 2026 17:30:15 +0200 Petr Mladek <pmladek@suse.com> wrote:
>
>> On Wed 2026-06-24 13:34:19, Andrew Morton wrote:
>> > On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net>
>wrote:
>> > 
>> > > Some callers handle SYS_INFO_ALL_BT themselves before calling
>sys_info().
>> > > Add a helper that strips that bit without turning an all_bt only
>mask into
>> > > a kernel_sys_info fallback.
>> > 
>> > I assume this patch wants a Fixes: and a cc:stable also.
>> > 
>> > It would be nice to have the conventional [0/N] cover letter to tell
>> > readers what this is all about.
>> > 
>> > The patches all have different Fixes: targets.  This risks inviting
>the
>> > -stable maintainers to merge only some of the patches into some
>> > kernels, resulting in an untested combination and which might break
>> > things.
>> 
>> I do not agree here. The Fixes tag should should point to a commit
>> which introduced the regression into the given code. And finding
>> some magic common point beause there is some magic undocumented
>> process for maintaining stable kernels sounds like a way to hell
>> to me.
>
>Well, as said, this potentially asks -stable maintainers to cherrypick
>individual patches from this series into various kernel versions. 
>Potentially resulting in code combinations which nobody has tested. 
>Heck, the individual patches may not even compile.
>
>If we're to add the series to mainline as a single atomic lump then we
>should add it to -stable as a single atomic lump, as that's the only
>thing which has been tested.  To communicate this to -stable
>maintainers we can choose a Fixes: target to which the series can be
>added as a single atomic lump.
>
>Of course, we could always discuss this with -stable maintainers ;)
>


Hi Andrew, I ended up deciding on a generic fixes tag on V3, if you
would like to have a look.

Thanks!
