Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8133B2FF9;
	Fri,  4 Sep 2026 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512242; cv=none; b=VWIGYhxaC7H/APHkAeSRgwOau5hV26mMxOlWCjjP+Oz5+pz/03lrZQtrpwRWbup+ux63Oa8jXAIyGh1H3OWvHnR0Ub+gFxvkFeQOF8GxwskpmZfZ+1QnTymywR/+UKjgUgpNO1DYdKuSz/3545BSNl2LOcCWIAGWqqO0MzwSwzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512242; c=relaxed/simple;
	bh=ERD8AXf7TXdChYSQwrK17KfmoT8D4LTgr4jpnf6Z4mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yy9Qh8aWrhdq68saHHqNmMzNXSjgJ9WZNx58fr/JTsMfXWsv5EMjtD/dMrNgYAMZ2TkroXL67fqzaXCxWKah8dY9J8lcffJ5knB6V6MSXIXCinDGOmXLrS62dF//6xMSWcWHEbeuNo3xli9T0X8YKqMjQ8XmzHWgJijHWJvlUY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/2us4wd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/2us4wd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D9D1F00A3D;
	Fri,  4 Sep 2026 08:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788512240;
	bh=wWF99opmQx/qnYkYmHdnP27kszT/uZGrr1lE6vZT9p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m/2us4wdnkpYFO1XWnR8zKf8Q2e92y8D63Qdi/gR9cKDajjhCyPR3OIIn1/rGEyDs
	 xXbr9ao9y5uARg/uh/N8WKN/uC+m5Prc9GfunqkwVZ7dfiFpejuMVUoMXfE9KSM8Zf
	 a9as4npkAHJcgyd6AUP8qNys+kiD3OLgYtlJjvHm1GLlLnGdQ0oDPb8GPhz5CY2lEt
	 tdAd9S/ikYCHFmRZMMXO+t9yaVYlyIv9ZgPzD2wOrquSEiBtNtUm3pIxMG+W9B2aD0
	 tBGbImNH93TDY5VUn8KkGS4oJW8mkzDYGxrEvcZ5DJ/HggRgu+eIf2SxlQuNO2B1ra
	 1D0Jkjzmjcl0Q==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x2Pja-00000006lYm-2QBo;
	Fri, 04 Sep 2026 10:57:18 +0200
Date: Fri, 4 Sep 2026 10:57:18 +0200
From: Johan Hovold <johan@kernel.org>
To: Adriano Cordova <adrianox@gmail.com>
Cc: elder@kernel.org, gregkh@linuxfoundation.org,
	greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+2fd6aefc361af86911d5@syzkaller.appspotmail.com,
	Yang Zi <2959243019@qq.com>
Subject: Re: [PATCH v2] greybus: operation: fix out-of-bounds write in
 message allocation
Message-ID: <apqH7j3tQiXZqiOk@hovoldconsulting.com>
References: <20260902145916.63052-1-adrianox@gmail.com>
 <apqDK5dHYGaJRwx1@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apqDK5dHYGaJRwx1@hovoldconsulting.com>

On Fri, Sep 04, 2026 at 10:36:59AM +0200, Johan Hovold wrote:
> On Wed, Sep 02, 2026 at 10:59:16AM -0400, Adriano Cordova wrote:
> > The incoming message size from the device header (header.size) is
> > trusted without checking that it is at least the size of the message
> > header itself, but a value smaller than sizeof(struct gb_operation_msg_hdr)
> > underflows request_size in gb_operation_create_incoming(), wraps around
> > in gb_operation_message_alloc(), and results in a tiny buffer that is
> > then written past its end in gb_operation_message_init().
> 
> Is it really? I was under the impression the only issue here was the
> potential zero-size-pointer deref.

You're right of course, there's a potential small (7 byte) OOB write
here too.

Johan
