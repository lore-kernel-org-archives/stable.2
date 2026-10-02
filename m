Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0333D4DAF8C;
	Fri,  2 Oct 2026 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955233; cv=none; b=mvXXNDTMT1pU5+6OF7tfIehgymTavgh2H49AmMq5GmdWtwUCyyEAjQhqH8DssON0gACuKnAS/rRUOK8kLBDiyU4HDcuNZgDqkzNqD/14YaAPgRuYEHY31SDVXKvTwiEQHPUTLPhJ6SZ6fwmPV/r4Wy36Go0iz2oN9B8KQTUKqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955233; c=relaxed/simple;
	bh=n2LN/j089HOizN1MoojMoOcOlZAfWpfpx4ZfjpRHkag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IjH6j5xhiqwmtkvveZiw79lSKyfhT+oWxx1qqpK6HHVubmB8VTJuvpqJDUKQD8nJltb32q/pBw9H0YydVD5Y1uDOiB13Etp8PQ+psPoKaUKYUAnYjl3/Ot8UakblaKR1KP/SzgRBgBFbZPQsJTHLrvVrJ9xWQQRuyIXBia3b98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RLHWwYCd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZPcV2yqH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RLHWwYCd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZPcV2yqH"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790955229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2LN/j089HOizN1MoojMoOcOlZAfWpfpx4ZfjpRHkag=;
	b=RLHWwYCd1ch/QbmMtJXvir2OlrLSP6muF8LGca3vEhcBYYU2BTxuWjaEidhBMs9IaWckgi
	1vV0kvMLTR+BUwahc6h/ViE8Eo9QcRyA92ZgtE65NzpnxW+W5as6Q9z7eVgTw1NEX9XsU7
	TzEpjtdji0VHdWVog3I9Dc87y/1DlYjRVi4sSGwoetnnuSsKjrMSSBbHwZ/jmK/ZWYofGM
	9Cwb+H3HsoSeFQigPG3dV+AoSKN+qcykrvf4W/mhHmt0syegG2/8j9BnW19k7ZaBczwnOj
	3mpcE9Hb0HTJJDD6Cemk1SW2wGxTrAMoB7aE5X1Pc/ztMT6bypTYCv6bsmNQyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790955229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2LN/j089HOizN1MoojMoOcOlZAfWpfpx4ZfjpRHkag=;
	b=ZPcV2yqHfz9hmZkQpxkfNhq1OpMWRzsaegF4RUQlPqUbxKDu+ZLL+MDcxeR2f+mDgBTbi1
	gfiMxtainsChDNAw==
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, John
 Ogness <john.ogness@linutronix.de>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] rv/rtapp/wakeup: Use "rv_this" the rv_monitor variable
In-Reply-To: <e91ee6fcd36a6ae4616fbd61121b2354594099f9.camel@redhat.com>
References: <20261001044218.3508990-1-namcao@linutronix.de>
 <e6f78faca93f92981130621d712ac05374d83b05.camel@redhat.com>
 <e91ee6fcd36a6ae4616fbd61121b2354594099f9.camel@redhat.com>
Date: Fri, 02 Oct 2026 17:33:48 +0200
Message-ID: <874if415ib.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> d9e4c61a12dd was introduced in the same pull request but after introducing the
> wakeup monitor.
> So for me that's the commit that is "broken" (should have accounted for wakeup):
>
> Fixes: d9e4c61a12dd ("rv: Use generic rv_this for the rv_monitor variable in
> LTL")

Sorry, I was lost in the sick land, and now see you already opened the PR.

But yes, I agree that the commit applied later should be in Fixes:.

Nam
