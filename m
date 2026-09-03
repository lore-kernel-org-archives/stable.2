Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C28414A13;
	Thu,  3 Sep 2026 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431022; cv=none; b=puGZ6s58Vh2zadyTTAaR5rY7SzcSIrtv758q4RE6xoYQPks2ttxeClIX3okwOlrfMmdMF5FFYaHZc/DxdJAlqaxKBd4QILWtNXs2ndsMkSJMSKU0b+grcnFr2pLyj3mWBqyYlcHIV2jvTmInmOzjw2iWsrR67rRd5wGQYALOCxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431022; c=relaxed/simple;
	bh=pOvwX0qf0dixUg8fxpXeNuR9xhXBBTmGT0r4qdvk3NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBBAulj7mSILjAMeyadYJHRHcUBeLf+sgut0YIy1yTUgBdSO9Fo0+UuFvILqkJ+9NgwV++hE5oC9gzUmd1puELVpS9MFJA61vFE2JAs3zdDk3QTaa/erf7siMaZrsLaUvNL0HI99qlkR0zF1IPexRln209qDILUkjOznZbyRVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY8NvTdy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY8NvTdy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE28F1F000E9;
	Thu,  3 Sep 2026 10:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788431019;
	bh=prH0TP8P1xjXbUz/kdt7De1+m5TEsgw0uF1w67Lu2f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SY8NvTdyaJKT02aOzIki4S56bqJtkB53v/e8CznZlEKr3zz4TtUnDxsOHufv+OOcr
	 ByotDX83f+R3KGKI8cEifLkrjrQtTflneOqAjTdfSyvXsgR6u5x1pjFeKI9z8Gdpfj
	 1gque4fttqUqnskyc2ULEHljcDHxkiPx9DvIJvttcXARUwfO/S7lxtrWC4lAmtULn9
	 dsGuV4S53yQIyf+ZEe+i9pWrTqR3tJicxgfmOiiS9bppDEvqKI2SCTZYL4dY3wWJwb
	 v+ofk+NMsSRuWsqP7sKxvCiUyW6F2FOQ0XvQJ22fpW1gSC++0JnIBMOVmNrCepivUr
	 M0YJxp1ZE0qEQ==
Date: Thu, 3 Sep 2026 11:23:36 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mailbox: pcc: Synchronize channel IRQ before unmapping
 shared memory
Message-ID: <20260903-just-crane-of-gallantry-adb81a@sudeepholla>
References: <20260828161033.3783599-1-christian.loehle@arm.com>
 <20260903-impetuous-exceptional-python-db8aba@sudeepholla>
 <20260903-subtle-cornflower-guppy-b64a03@sudeepholla>
 <3c369451-be95-4c64-9e52-b456f4aa8c42@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c369451-be95-4c64-9e52-b456f4aa8c42@arm.com>

On Thu, Sep 03, 2026 at 10:51:28AM +0100, Christian Loehle wrote:
> On 9/3/26 10:10, Sudeep Holla wrote:
> > On Thu, Sep 03, 2026 at 10:03:38AM +0100, Sudeep Holla wrote:
> >> On Fri, Aug 28, 2026 at 05:10:33PM +0100, Christian Loehle wrote:
> >>> pcc_mbox_free_channel() unmaps the PCC shared-memory region before
> >>> mbox_free_channel() invokes the controller shutdown callback. For
> >>> interrupt-capable extended subspaces, an in-flight handler may
> >>> consequently access the mapping after it has been invalidated.
> >>>
> >>> Release the mailbox channel first so its IRQ is disabled and synchronized
> >>> before unmapping the shared-memory region. Serialize PCC channel
> >>> acquisition and release across this sequence: once mbox_free_channel()
> >>> makes the channel available, another client must not replace the
> >>> shared-memory mapping until the old one has been unmapped.
> >>>
> >>
> >> Breno Leitao has already posted the fix for the unmapping before freeing
> >> the channel. You just need the mutex guards.
> >>
> > 
> > Failed to add the reference to it [1] earlier.
> > 
> 
> Thanks, I didn't see that.
> I guess I'll wait until Breno's patch hits linux-next
> or linus' tree and rebase?
> 

No just post it with a dependency mention. Both can go together IMO.

-- 
Regards,
Sudeep
