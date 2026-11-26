Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795654378;
	b=C2VScD03RqBB6P74/9yq5wyKXgsBjaBWSjQfGUEZzud0x5hnvWpwRsT/F4yGrN0W8pEI
	 jcifKBHO6vPvogIzVxjhQg+j6T2KDJz33Kbb88CGXEr4eCPW3IH+Q8eKZkVRQ+UbaE5XX
	 SDC+INbp5GabfLI3tXfX2tiSEwvZu9sFNNorfP/hK2dHSMFe1PGMx8Nfwaja67HdzWOnM
	 pTG7Y6sdh5vdW3YPcYgfm1QNWI6OwGScX7z5tLLxoz0Jet+/I8PIkFVoJelE7Ice8bn2t
	 9yLnh4qXKLNLd5AkyQ9H3YMOrIcbKbIX+SyODVm67eQPk72iW19YuKJwXHv9BlLHVVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654378;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=AsVO6L0VXItBXY4OufcgsE+LrhkDwwft4iRAk/G8ycA=;
	b=M/9b8Y9+d72/jLWNHJB+MOu2WGr6XBSTLkoEMzHuH6VvCrrf2oOeNHsK5ZSsrxc+K3OV
	 /esRRHyvLvuaPWpUUfhO/h4szbW2b/6/dD0Nst1ZTO3e0bzx/N5MJDx1bUB+qSCjmaJoS
	 G/ym4TJlihcI+ToVfOsSNv35d+vUc69tiMK+insNQ97idIhqipxYKbPT8LlfvmOLZ6/9y
	 0+wkMlOwORaAMkZ0r/Gif5SgAGczbEG6+5y7bd5dU2bznP5G7A71VAuYAS80B9DbqK736
	 6LyYscxfTVlk9xwA6ESAnJFWBukmco+1WZv7J1I8KM+HW8oHD6xnh/Y71rGJ3C4evuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IBNWCKWb;
	arc=none smtp.remote-ip=115.124.30.130
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4B606A31E;
	Thu, 26 Nov 2026 00:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECB4B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IBNWCKWb
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795654374; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=AsVO6L0VXItBXY4OufcgsE+LrhkDwwft4iRAk/G8ycA=;
	b=IBNWCKWbk78186Aa4mTOoE0y9lKuauJtMgwpWplBaQbx5ATHP6uf2B6QLuSgre0pvhe8o8gVE6K6ZENp8kycd82VXyK+VfC5d3mDQ8NBSUCQDxmSwZH7a073BMFGt5hVr77pcLU8QuzLtyK5ArJrvPZAodoq4XK8+qrZUiMqcXU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fengwei_yin@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0XFSm-aX_1795654371;
Received: from U-V2QX163P-2032.local(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0XFSm-aX_1795654371 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Nov 2026 08:52:53 +0800
Date: Thu, 26 Nov 2026 08:52:51 +0800
From: YinFengwei <fengwei_yin@linux.alibaba.com>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Liao Chang <liaochang1@huawei.com>,
	Ashok Raj <ashok.raj@oss.qualcomm.com>,
	Doug Anderson <dianders@chromium.org>,
	Pengjie Zhang <zhangpengjie2@huawei.com>,
	Cong Wang <cwang@multikernel.io>, kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: arm_sdei: Do not signal event 0 to a
 masked PE
Message-ID: <aweC4_pzRjo9V0zz@U-V2QX163P-2032.local>
References: <20261124194707.1030653-1-kas@kernel.org>
 <20261124194707.1030653-2-kas@kernel.org>
 <awavUsKX4XLRMbUq@U-V2QX163P-2032.local>
 <awblcOnI8JVhpmPK@shutemov.name>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awblcOnI8JVhpmPK@shutemov.name>

On Wed, Nov 25, 2026 at 02:00:40PM +0000, Kiryl Shutsemau (Meta) wrote:
> On Wed, Nov 25, 2026 at 05:50:10PM +0800, YinFengwei wrote:
> > Hi Kirill,
> > 
> > On Tue, Nov 24, 2026 at 07:47:04PM +0000, Kiryl Shutsemau (Meta) wrote:
> > > The SDEI NMI backtrace signals event 0 to every other CPU, idle ones
> > <snip>
> > > +static void sdei_block_signal(void)
> > > +{
> > > +	struct sdei_pe *pe = this_cpu_ptr(&sdei_pe);
> > > +	unsigned long flags;
> > > +
> > > +	/*
> > > +	 * A panic from an SDEI event or a pseudo-NMI may have left the lock
> > > +	 * held by this CPU. The CPUs that could signal it are stopped by now.
> > > +	 */
> > > +	if (panic_on_this_cpu()) {
> > > +		WRITE_ONCE(pe->unmasked, false);
> > If the panic didn't take the lock, should lock be taken
> > just like "else" path?
> 
> If another CPU holds it at this point, that CPU was stopped in the
> middle of signalling this one, and it will never drop the lock. The
> panic would hang on it.
> 
> If nobody holds it, there is nothing for it to keep out. This runs at
> the end of smp_send_stop(), after the other CPUs have been stopped. A
> sender stopped after it took the lock has either counted its signal,
> which sdei_wait_in_flight() waits for, or never sent one.
Ah. Yes. This is the key point. If it's panic and trying to do
sdei_block_siganl(), it's in smp_send_stop() on panic path. Thanks a
lot for detail explaination.

Reviewed-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>


Regards
Yin Fengwei
