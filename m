Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F2E3009CB;
	Wed, 24 Jun 2026 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782269438; cv=none; b=bUFKsLfodmeE7DcWbK8S/p3hrXhctFnRkj0n9P3LcD+28pKhCuSwcS0Q4Hccz1Rlge0CH/u2Fo9n6p5Vsoz1QZH2zdseLdLmHrcp8Pq5VPXin5y91IdGgw3r7Lfe0pU9TRF/Shv9bZCJTnPot1EFRlbOqW+VTMiO2AraFv7uR2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782269438; c=relaxed/simple;
	bh=ndvzgTea6WlyY9d8jQn5HMz62wWCa35xyt9nMxGJdLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+hyVc6hbskZyPHsbJF6+lgGJOFOTwuAcke8c8jwfIZHHBlU5xv17H9Fk4Oqkl0y9sSkY4cLsw8IphAiVCYyqunf56TRxkXu77yNj1dmmV1T2Vt7AgPfpEihNyWNPHcKaCrjlJp1RT8kspX1dV5RhYqv4SwB7z36hoIKztt/39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m2saXI8U; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m2saXI8U"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782269431; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=QK2Sa3tUM9FmdHMKVzdbtY23gSTQnspEbezYtpW8lPQ=;
	b=m2saXI8UOWaLWZm6j/GOSBC6dAK2oGMUIHhe6dGSf/2M8DsS8zzOJJQbBelR9N5P9FJoHgYEuGgRouqjnD/GCxyu8eFo0288JnM7hLVG2Ovly3q5EElp3ZaAE2Wd0uY4WumJXCU3l0YrQ7aYHZ3ISmXWOoiIegsgni7kITpdBlo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X5W1YNy_1782269429;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X5W1YNy_1782269429 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Jun 2026 10:50:29 +0800
Date: Wed, 24 Jun 2026 10:50:27 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>, Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>, Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] panic: avoid duplicate all CPU backtraces from
 sys_info
Message-ID: <ajtF8xCGBNH3wzzo@U-2FWC9VHC-2323.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
 <2199a8b4da8700b9f27e61486293e9c26ab107ef.1782228656.git.include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2199a8b4da8700b9f27e61486293e9c26ab107ef.1782228656.git.include@grrlz.net>

On Tue, Jun 23, 2026 at 03:35:01PM +0000, Bradley Morgan wrote:
> panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
> other CPUs. Do not ask sys_info() to handle that bit again later in the
> panic path.
> 
> Use sys_info_without_all_bt() so panic_print=all_bt does not request more
> output after the CPUs are stopped.

Good catch! Thanks!

Later in panic_other_cpus_shutdown(), it sends IPIs to stop other CPUs, and
this patch does avoid dumping local call trace again!

For the whole serie, feel free to add:

Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>

Thanks,
Feng

> 
> Fixes: b76e89e50fc3 ("panic: generalize panic_print's function to show sys info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
> Changes since v1:
> - New patch using the same helper for panic.
> 
>  kernel/panic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index d030f88ad4ef..2cf229c7c0cf 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -683,7 +683,7 @@ void vpanic(const char *fmt, va_list args)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>  
> -	sys_info(panic_print);
> +	sys_info_without_all_bt(panic_print);
>  
>  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
>  
> -- 
> 2.53.0
