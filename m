Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C0E25B2FA;
	Thu, 25 Jun 2026 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401510; cv=none; b=VFpdOOaf/BKI82Oh7IlxlZNxnbnh4zWBNemi6qYiJrLO0z/2+rRbRlb7OjKpEvzx7ltPlQ4EsvJsZaeZsNVuCZ9a/EHenn3yMD00HLysiLfskBAuwjM3UpWxP3JjIpPtZRIqGQKC5b/+nuTWFb8yUm56zdNDRNYsq39PHWPllCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401510; c=relaxed/simple;
	bh=87Lp9ykGt6WUTliJpyATJB6LiKTSkngQqG/6se0Esh0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FrebnmThg32iTCakYVbIYYJHk/++p8384k+cPEC6QGZFb98Nj8QXCeyX+J6etiqdhLVjVZOfaIOda931Z5kQ70Gvc1h5qgoPlxn21chOunQzsrGtHFH4mgn5P/CpC6T7As5n3c56tON+YhKfr5QuDH2S/fJCKASWc/7Av3jQ2Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=f2SILeTa; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="f2SILeTa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782401507;
	bh=NixNq7qAtZ/8X0xtfv5u+m8JY5i7HeWwMBne1v0htc0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=f2SILeTal3qnKgVE5kNh6l6d/A3PZJcv62oA+S28jDTtfJBljJQOtOM3P6Saw787E
	 0jTGpA5fBARhVJLRyitw74lFGLAeELGYKslDMKknAcjPaESpiMQrtfa8Aa3Wg3kY+K
	 MOUTQWmQv7V/4grQtGr6NnVzyx++Ng4MFf427HVY=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gmN8336JfzGpDM;
	Thu, 25 Jun 2026 15:31:47 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4gmN826G0szGpDB;
	Thu, 25 Jun 2026 15:31:46 +0000 (UTC)
Date: Thu, 25 Jun 2026 16:31:47 +0100
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>
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
In-Reply-To: <aj1Jh57McGH94gGY@pathway.suse.cz>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net> <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org> <aj1Jh57McGH94gGY@pathway.suse.cz>
Message-ID: <EEB33A51-758A-4A67-8AC5-7200B53F8C1D@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On June 25, 2026 4:30:15 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
wrote:
>On Wed 2026-06-24 13:34:19, Andrew Morton wrote:
>> On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net>
>wrote:
>> 
>> > Some callers handle SYS_INFO_ALL_BT themselves before calling
>sys_info().
>> > Add a helper that strips that bit without turning an all_bt only mask
>into
>> > a kernel_sys_info fallback.
>> 
>> I assume this patch wants a Fixes: and a cc:stable also.
>> 
>> It would be nice to have the conventional [0/N] cover letter to tell
>> readers what this is all about.
>> 
>> The patches all have different Fixes: targets.  This risks inviting the
>> -stable maintainers to merge only some of the patches into some
>> kernels, resulting in an untested combination and which might break
>> things.
>
>I do not agree here. The Fixes tag should should point to a commit
>which introduced the regression into the given code. And finding
>some magic common point beause there is some magic undocumented
>process for maintaining stable kernels sounds like a way to hell
>to me.
>
>Best Regards,
>Petr


oh no.
I added the generic tag to V4, no worries, it is the earliest possible
fixes tag. But I really don't wanna be doing a V5 just to revert my
fixes tags.

Thanks!
