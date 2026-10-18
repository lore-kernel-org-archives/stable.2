Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE154DD3BD;
	Sun, 18 Oct 2026 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341017; cv=none; b=hl4uBMZcFy4aF2PRD/gaCVUijnAxqg2VMdV0lMOF+UYh6SffFYAEso/zKk88fg0Roji9g4XkF4U6O1Kzj8xQXQUpjTOPAZZUywyGIap31/FC1W5zW3VswzCpsSvWw8jZKy/CIwd1fCZzd4dY+nCuyKMMJXM5FbaFnBja3Ppx4XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341017; c=relaxed/simple;
	bh=avD/CWQIkE7shmeuvzlnx0Jg1sXLZU3JF/mYJntx+Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZykh83Bmt6SeCnWDkQ/tjNHuYSHv0o/e1nJ5gF2yNy807q/d4ZGPIBbMgUGXhHBezhp2X3NlkelnqP+b6Gj/707Ko5Loa6t5GfLka3G3ffQwf8CGoscGFOVvafPHBIrZEVEWjJV2rusaftWG2o884yJA4ki5RdF1T2WvHhZrZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0B9CchL1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0B9CchL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7181C1F000C4;
	Sun, 18 Oct 2026 16:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792341014;
	bh=avD/CWQIkE7shmeuvzlnx0Jg1sXLZU3JF/mYJntx+Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0B9CchL1zFO79IHiSQH3j+GUhAvfOsuTMeBB6im/j7853wAKQaXoZ3Nsfy/51Ydh8
	 FWteoVLoceYsO+9r2hcefSOEuNlrko5sXRxUdtS8hEYdwymzbQA6iyHWYIuAvpODzP
	 Qt6x9UYKIfi8VCyn+bJDN0xN+FUx/OAzxkeEDEOQ=
Date: Sun, 18 Oct 2026 18:18:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Gary Guo <gary@garyguo.net>,
	Boqun Feng <boqun@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 6.18.y 0/6] Backport spin_lock_irq_disable() to 6.18.y
Message-ID: <2026101838-proofing-detection-9663@gregkh>
References: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>

On Thu, Oct 15, 2026 at 08:16:26AM +0000, Alice Ryhl wrote:
> This series backports the new spin_lock_irq_disable() API, as well as
> the new SpinLockIrq API for Rust to 6.18.y. This means that any upstream
> code using these APIs can be backported cleanly to 6.18.y without
> needing adjustment to work using the old APIs.

As Sasha says, this doesn't seem to fit the stable kernel rules, sorry.
If a bugfix is needed that requires this api, then we can add this, but
until then, it's not necessary at all.

thanks,

greg k-h
