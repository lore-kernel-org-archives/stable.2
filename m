Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D923AB88;
	Thu, 25 Jun 2026 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402375; cv=none; b=mLcTU8Oash7o/drCRT/z7pO9kZ0QoGP7SxyI8xc9x6fLDdY0WwxYQpJDqlYu6H1pzJmDeOReljey4sFRZtcnuFrzTB2o9PbbkhiF0UCM3Ta62LQFWws0nG2CWP6Ip23PC28vhC4q7fnX61GI24+pi1bKfz3P8zxTSfQPsBXag2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402375; c=relaxed/simple;
	bh=ctQP3VPKD6CQ9xcdX1wHBqM6moohqyJGKm26xeT3ve0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=LIxRITDVArkaHEJ1o6zPwK3tF1PIX8ZwksKBJu/beY3xuzlasaGwK/ttgzaUfBKFEjQxLSbN96cGNVNV61CjQBrVTbd+QhoUmZaZTpOoXV7MfuyClQdLmRBZbKmPjvhqBWR9Ooc0Ctj1cHk8ex2y/USTiIJrKgmU1gwNa/lmXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=uAzffgZL; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="uAzffgZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782402371;
	bh=U6zBlHANxnpDz7llNiEOZIWgsNjh1OmIXCDrGCn9Yj0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=uAzffgZLqN0ys8V/+4qfRkhK0rdpUE9WOxnxdUFKOdItD65j+CZMJy5YeyBvEy+PF
	 LLHYEiOlrZTgpujkvRwdmnRWnlXdnNZES5yilmG6WGs7ieyIT2wyX3UlM1Jaq1oEgc
	 NSf9mTJzzvjc7bLAS789xdVAFDxtV9fnORgww8oA=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gmNSg21jszGpDl;
	Thu, 25 Jun 2026 15:46:11 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4gmNSf5HbVzGpDM;
	Thu, 25 Jun 2026 15:46:10 +0000 (UTC)
Date: Thu, 25 Jun 2026 16:46:11 +0100
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
 Feng Tang <feng.tang@linux.alibaba.com>,
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
In-Reply-To: <aj1MdKcXP3uIW7AX@pathway.suse.cz>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net> <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org> <aj1Jh57McGH94gGY@pathway.suse.cz> <EEB33A51-758A-4A67-8AC5-7200B53F8C1D@grrlz.net> <aj1MdKcXP3uIW7AX@pathway.suse.cz>
Message-ID: <A9C69766-159B-4A79-B409-AD56B2856F8F@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On June 25, 2026 4:42:44 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
wrote:
>On Thu 2026-06-25 16:31:47, Bradley Morgan wrote:
>> On June 25, 2026 4:30:15 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
>> wrote:
>> >On Wed 2026-06-24 13:34:19, Andrew Morton wrote:
>> >> On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net>
>> >wrote:
>> >> 
>> >> > Some callers handle SYS_INFO_ALL_BT themselves before calling
>> >sys_info().
>> >> > Add a helper that strips that bit without turning an all_bt only
>mask
>> >into
>> >> > a kernel_sys_info fallback.
>> >> 
>> >> I assume this patch wants a Fixes: and a cc:stable also.
>> >> 
>> >> It would be nice to have the conventional [0/N] cover letter to tell
>> >> readers what this is all about.
>> >> 
>> >> The patches all have different Fixes: targets.  This risks inviting
>the
>> >> -stable maintainers to merge only some of the patches into some
>> >> kernels, resulting in an untested combination and which might break
>> >> things.
>> >
>> >I do not agree here. The Fixes tag should should point to a commit
>> >which introduced the regression into the given code. And finding
>> >some magic common point beause there is some magic undocumented
>> >process for maintaining stable kernels sounds like a way to hell
>> >to me.
>> >
>> >Best Regards,
>> >Petr
>> 
>> 
>> oh no.
>> I added the generic tag to V4, no worries, it is the earliest possible
>> fixes tag. But I really don't wanna be doing a V5 just to revert my
>> fixes tags.
>
>This is the risk when sending 4 versions of a fix within 5 days.
>A good practice is to wait at least one week before sending another
>version. It gives people chance to react and helps the discussion
>to settle.
>
>That said, I am not going to block this because of the fixes tags.
>But I suggest to wait longer next time.
>
>Best Regards,
>Petr
>

The whole fixes tag thing is unfortunate.

because it should be Fixes: then whatever commit ADDS the regression.

Not a common fixes tag for all! 

Maybe when it's merged, Andrew or someone else could do 


Cc: stable@vger.kernel.org [5.10] for instance, for it to be backported to that version.

That should fix the whole fiasco

Thanks!
