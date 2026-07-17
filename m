Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32C31E824;
	Fri, 17 Jul 2026 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301617; cv=none; b=pyyTJ80SdyccT10vatlLQgjqH8KvOGNywm4lgKBWp9Pv96jl91CbJ9tWK+EvSCTh/9A11brS7zSLeSTiGQyXdAmpIsrCUyht7UITRq0Jds8xqYOqnYfKMJRKGgxk5NQl4Pw0u6lYT+cp4RNEqcVZcQz2LQ8x4UXrpzC/RSsb9UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301617; c=relaxed/simple;
	bh=G02qIAfHdDFOlGDiH7kdovI3tW2EfkAEOazn9kaUgEA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=s2tBwpeOFzTrhVdRzc64y/SqrrPQ5PtMdY9eOTRhq38stvRUWzH8cBkVpggC+6btZp3xPHTa4vyEyJf23bLic8kGnqiTgfPWjEYztIMJckWXuCCGeqZhcqnXBIaUsc4RQS/kSchWDYF1BLa/m45Lg1HTUGBWIw4T5FfBQUJIb2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=jDTpIKlR; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="jDTpIKlR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784301612;
	bh=MOp2EkOUsrWNtb6E2rdNddxwfUVhSJSf3GwhJlPD8ho=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=jDTpIKlRe8zDBZtnfME7Bj8ZzuZNddorCWeb/Zk+wr+vlmViHng1CEbfEKJq+U8fJ
	 Ehs6k0Tu9XuIJNI7eqJQtAT9MFIULKzPfGvvTeyT1hhu8uEnXptD3dC7bqU047EPdH
	 rrBtVY2lOtrfUbPySD1yA97Ao5k5Nje3qlyzrZA4=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4h1trX0sxGzGpQW;
	Fri, 17 Jul 2026 15:20:12 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4h1trW5nD1zGpL6;
	Fri, 17 Jul 2026 15:20:11 +0000 (UTC)
Date: Fri, 17 Jul 2026 16:20:11 +0100
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>
CC: akpm@linux-foundation.org, feng.tang@linux.alibaba.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] panic: flatten nmi_panic control flow
In-Reply-To: <alpHZ7ZbeyWAGoIw@pathway.suse.cz>
References: <20260714173103.11585-1-include@grrlz.net> <20260714173103.11585-3-include@grrlz.net> <alpHZ7ZbeyWAGoIw@pathway.suse.cz>
Message-ID: <CC5CEFF6-7581-491F-B2FA-4D1AE4B477C2@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On July 17, 2026 4:16:55 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
wrote:
>On Tue 2026-07-14 17:31:01, Bradley Morgan wrote:
>> panic() is __noreturn, so the else after panic_try_start() is dead.
>> Drop it so the force_cpu path can be added cleanly on top.
>> 
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>
>LGTM:
>
>Reviewed-by: Petr Mladek <pmladek@suse.com>
>
>Best Regards,
>Petr
>

Thanks,

Thanks!
