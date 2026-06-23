Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B54331EA2;
	Tue, 23 Jun 2026 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245797; cv=none; b=hJ5RA0gqKq0iW2I8hC3V/UiKV34u1K0VtzZpALKT09xOqL/4hCYjtvrd6zRKuiF6fd9+DTHI8amhoWX7RhdMz7fLGaScA/brhXrgU5vxOqEvxxGXCMwE8gffekjKYHdOHlPqHSdbKuRSK8kTeVGQl3E2MSL5r6s7kIqWt/IakzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245797; c=relaxed/simple;
	bh=8RqeGuKed0WW87dmUpG3J3VwPycQJqkB9qD1M2SnUx0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Lirc75iMOhuvt/HUdL/5XB0iQa6FJHxUZTu1SA4PxO8mzByfLic031x+VNwrMok5VPI7jJz76JCP2WA3Rj0kEIbHWQ/OlRdmwriGD7JlUG0yAibZ2VfQbjjQ727LhgQj2paNdydoLA9dPrpVVgnwr/v4zIvzqaoPqQ5Aq9NcKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=Zpv3AvJh; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="Zpv3AvJh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782245793;
	bh=IAfJFwEnmp1agnnfX2jU4/znEwpzF5AMDwIablcmerY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Zpv3AvJhgt1AJ+adOVBabJ3ndlVmvcsuP0v+O20iopTJZNegAtauD78JpvjX7MAnd
	 W9+1taFmIX0eC1TW6DN9IydnVTqtTDBk9eCMjFlDAw/qBRjM9//w73UxL7nuIjLEY2
	 hpb9VUQZvyb17oFkpsk4zB3S95GKuTcABZY1gJE8=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4glGYY3hh1zGpD0;
	Tue, 23 Jun 2026 20:16:33 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4glGYY1Lw3zGpCr;
	Tue, 23 Jun 2026 20:16:33 +0000 (UTC)
Date: Tue, 23 Jun 2026 21:16:33 +0100
From: Bradley Morgan <include@grrlz.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Petr Mladek <pmladek@suse.com>, Feng Tang <feng.tang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
 Jinchao Wang <wangjinchao600@gmail.com>, Kees Cook <kees@kernel.org>,
 Rio <rioo.tsukatsukii@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Pnina Feder <pnina.feder@mobileye.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Douglas Anderson <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>,
 Tejun Heo <tj@kernel.org>, Zhenguo Yao <yaozhenguo1@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/4=5D_sys=5Finfo=3A_add_he?=
 =?US-ASCII?Q?lper_for_callers_that_handle_all=5Fbt?=
In-Reply-To: <ajrpPMo3Qc_SgFkG@ashevche-desk.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net> <ajrob9r6cVtxqv72@ashevche-desk.local> <ajrpPMo3Qc_SgFkG@ashevche-desk.local>
Message-ID: <39C3E79F-CB10-4711-95B5-024D6750BDF6@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On June 23, 2026 9:14:52 PM GMT+01:00, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>On Tue, Jun 23, 2026 at 11:11:34PM +0300, Andy Shevchenko wrote:
>> On Tue, Jun 23, 2026 at 03:34:58PM +0000, Bradley Morgan wrote:
>> > Some callers handle SYS_INFO_ALL_BT themselves before calling
>sys_info().
>> > Add a helper that strips that bit without turning an all_bt only mask
>into
>> > a kernel_sys_info fallback.
>> 
>> You also want a getter with check
>> 
>> bool sysinfo_is_all_bt_enabled(...,  *si_mask)
>> 
>> where *si_mask is the result of READ_ONCE() that you keep as
>implementation
>> detail inside this helper.
>
>Ah, sorry, I have thought that the mask is part of sysinfo implementation.
>Disregard my above comment, it can't be done without also supplying the
>pointer
>to the original one, which makes no sense.

Ah, yeah, I was gonna say that.

No worries, will disregard! :)

>

Thanks!
