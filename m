Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799548;
	b=zQomGzl0wLYE4IJl2ksmpPfQar4IUFqdghTQgHk4mdrawMNjuNq96XPKRcLKAGSdIqRn
	 aroPSVFwrWbPrmZX7FVyd5v0TmidqYL0n5Q8o7zq6+NsQO7V/sWDka4xEr/wcBEWErgiS
	 SSm6tH74OuGZJvSwtcyZoxYwufHgXYrffrhRKUH8K+7RzYJ4JI1TrTgkRk7xMMOHcnXfw
	 sJPsL1XACSsH2HRAs8F9tDkAxoejydle6CsBRYj24mXawm0UdG7H/2OkdMNEzSa7oMCmd
	 4YWDXJtQPn4C2ZPDDY/eoNRaDuBjtnAdwOXzUzdanuby3tY96vfeF1GBPciB9/LqnmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799548;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=z7sSJMfuWwhvqNeraow/YEhbHEAVWeqjNC+18be8Lgo=;
	b=kGQMNVqIp336FU/usBppBsrVgloSXw1Wzmjs+LIiQ5IejU9Fu+GgBoRGckwePZZ8XKYe
	 V71pWHCjczPFUX3YPOnexQ2AMY9t872MelG9Ka5R7KpiKFnbW4+fWpYgwPdVmhYMFBDGv
	 Um+8dtPHe9opjeiXvmQKZBQ1Y9r0wHZ9eOJ1IrAmMK3xJNBsAy7E/6uwuRSZVs4n1UikK
	 1SXUqGYrxSDthQDhKJHldvh/klkzeq0CTBQxy74xuM11YLbuPy2naQGh4sYdq6ZQLhqr7
	 rATT1jdyjYLyOKaONurNgu3bY9uOu+vdhSHGVNkpzS6pPxBybSH3QdHRoRmk7Eoz2Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=uT2NpfFa;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC2D606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AC2D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=uT2NpfFa
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 2A63E80725;
	Wed,  4 Nov 2026 13:39:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 5054520026;
	Wed,  4 Nov 2026 13:39:04 +0000 (UTC)
Date: Wed, 4 Nov 2026 08:39:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 sashal@kernel.org, DL Linux Open Source Team
 <linux-open-source@crowdstrike.com>
Subject: Re: [STABLE REQUEST] ftrace: deprecate the ftrace_enabled disable
 switch
Message-ID: <20261104083903.0d7cdb06@gandalf.local.home>
In-Reply-To: <CAOu3gNgv91dq8jLShteRWphrSgNWQ1o1dkNxRr577ez7pMuv6g@mail.gmail.com>
References: <CAOu3gNgTSWE84fgdc1iUNKwes7E6u_X6b8pjZKBULEJWB=RAqQ@mail.gmail.com>
	<20260820182015.4272b7a4@fedora>
	<CAOu3gNgv91dq8jLShteRWphrSgNWQ1o1dkNxRr577ez7pMuv6g@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cgz48q5e7w6bzegc5tty7tenyxfudjm1
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5054520026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ywDAmlmCeYxHVsuPJE75iqXMsSnfNtoQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=z7sSJMfuWwhvqNeraow/YEhbHEAVWeqjNC+18be8Lgo=; b=uT2NpfFarHFxZPq+G6xJWB1QXQfCYY+UzBnpL0fKy7jpGZzx33BNgzNV7HwWuVPt2n/mPY6NeXZGqLlyeFlc2OtQjzgDeOrrdRYJCAHuOe6pSjj+O8BYkHZnaMpPJCbRXZsvZz9JDVTYXWlq32kxeZdjRykB3K2oiSTobG5u+Ig=
X-HE-Tag: 1793799544-763974
X-HE-Meta: U2FsdGVkX1/5D2zjhLpH37yBZt94zgOTppAQR80oSL8Y9xEhcCv9jQJZIsMNpRYJACNtH7eHc6h8E9X95F5GFnVlijEYNRhOZjy9FSdIRt52YXV2QCXHQd4A+hQ4F/HjT/D+tQbLxstSg2hRRtXOCcrUHLE/FId+YgWe3nQFhChDediswLj6/kHoRaBrsicBbrUV8cd+4IDN50bhuL9PWEPLDVDzkG8mLIA1CjgUqaE7u9WBYxFBa5imhzeWFMRl6dxpmzPXbVIDgeNw4ev4dLlj0LT7UB6YzxUQPwMwUojuUOsEJbYiroHUYgqkfBMeM3qFj0AR8Y9VWZ2WAQQmHD1PnU/iND0CcSSNMcZIqFKXlbdIuzcUfA==

On Tue, 3 Nov 2026 21:51:42 -0500
Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:

> Hi Steve, coming back to this topic (sorry it took me a while - other
> work related stuff kept me busy). Are you still willing to accept  [1]
>  upstream ? If yes, can you also please clarify why only the first 2
> patches and not the third, selftest patch?

I was thinking for backporting purposes. The selftest patch is fine, but
not something that needs to be backported.

-- Steve
