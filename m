Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390853EB80E;
	Tue, 18 Aug 2026 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078520; cv=none; b=uPzoaAXzRYU6Hdr63rmtPmpsB2XVWppl/crue4/dv+VM70YetNeeGkKOyLc5iQKBLEfw1VgeIs+yWVa/LH7tncn/ZCa93MNqa4moYQ1+ZALZXV/rG64EkOISesi6FuEmFXB8YXvVmHjHkRjVo5WvDH1wPcDB7+SUWHcnVo7/krc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078520; c=relaxed/simple;
	bh=yA05NPrOlVy/KdGhalyTwROc7Sz9Dy+S97bucaC4smg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A4DGuLUcidlaectLJ5E4n+CfnH2inP9h0zkjJ6foU1VArC+e4Mg50ar7XqiagJWI6RtmCAfjXPObHEBBOVIktxz5NZDJgYsHBdqzfG7LKLo5HNDDjweD3geh+LA6P6JPk/MEceOsahFuOSFiqkoMpn6hwKWHQR8Ru+6Tbhffkr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FY8HLHSy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FY8HLHSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3721F000E9;
	Tue, 18 Aug 2026 18:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787078518;
	bh=YhLx6OPhQmr8wNXVzT03aIWR4DHuIuajzgQi3bYJh28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FY8HLHSyS80dIxUWZT3SKU0T0qp2R7UKjY4NMRJFIZvgNDcsogTG6IYEonE4i8/5o
	 EDeA4bZU6tIds/6NIwxTaClh64M7XU+aZZnI+2hyYP8O91C0HLHlmt1WjDrw0GGb8Q
	 1R3Qw9kxVFDAHDAAVG2BGE8w9tAvVFwQejSFI2jI=
Date: Tue, 18 Aug 2026 11:41:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Petr Mladek <pmladek@suse.com>, Jinchao Wang <wangjinchao600@gmail.com>,
 Feng Tang <feng.tang@linux.alibaba.com>, Rio <rioo.tsukatsukii@gmail.com>,
 Pnina Feder <pnina.feder@mobileye.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v6 0/6] panic: fix panic_force_cpu= redirect races and
 NMI bypass
Message-Id: <20260818114158.cc20b0cfcbe730a30597b466@linux-foundation.org>
In-Reply-To: <20260818163806.17460-1-include@grrlz.net>
References: <20260818163806.17460-1-include@grrlz.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 16:38:00 +0000 Bradley Morgan <include@grrlz.net> wrote:

> The panic_force_cpu= parameter redirects a panic to a specific CPU so
> the crash kernel runs there. The redirect code in panic_try_force_cpu()
> had two races and an NMI bypass, all found by Sashiko. This series
> closes them and kills one more hack that the rework turned up.

Thanks.  Sashiko had more to say:
	https://sashiko.dev/#/patchset/20260818163806.17460-1-include@grrlz.net

In the first one it suggests va_copy(), but perhaps this would be
better addressed with va_end/va_start.
