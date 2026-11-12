Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486394;
	b=S3NntiH3lhUF+8Ba6osSOFhOceC3vWgmZyl9t00KEzj4P1FMGaqmhvJoeD4jz9bSEQvY
	 y1nxumH10s71WOWVswu07jM+3FHsJS4bPqvbERUQk/SUMuwBSVNczVO2Ts2HpuMwChv+1
	 v33tzmBSKthSDSmrQiRujUM1/OXiMSgs2yeYCVIEYKMI27+KvaYvFGPhYbAaTf1WKo4Us
	 a34mLVH7GCelEf9PMwYhTUvtSN/kyYpN4+Ob8nikTn8sfiaJu8wU+R60mN73nJvko7qWy
	 4r2scbHb2zdy5uL5Fpx83P/uajOXtGuGIqIQxeHnwIrulkJjT979MxCqAmf2RPq7Vzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486394;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=krZdcDK/6+4gv9g3X2oR9ZC9C5jgnEYJhqJH5tUR9KM=;
	b=Ev5eMuDz1eyhYVDyRO8nshsI+Z+zxWJhw5zXMOztDcdBAqkXd1rWSNO+XV8TOgH8QkHN
	 KUPsfr9SdJ9z7BeZa4RhxwqXPUgKu2DUtUhG90X1LW8hEBOsZH5tjrYLNhrlYCpTpK+ow
	 FbSzlEfSd1HsTRx3CCf6pWWmEpbXicXwKsz+Jr7VyfY8pTX5ccM26kCIo1AiLhlGxUj05
	 GXqYXWSieIiiBj6Yla/ZxsZr7m1ZpeXMmCevoLsVetCp/D9Sm4pQUgwghnvWlnVvxBU5x
	 u5uNjk5JMDNZm+NsSPzvNZTU/MPEdOiUUJFMHrD/7EVhFtC5P+17QM7amY2ZfFs3FTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I2e1o17m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B39606A323;
	Thu, 12 Nov 2026 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I2e1o17m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003DF1F00A05;
	Thu, 12 Nov 2026 12:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794486394;
	bh=krZdcDK/6+4gv9g3X2oR9ZC9C5jgnEYJhqJH5tUR9KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I2e1o17mTkU+NXNbJK3/Xfq8q+0VIojnIuaYUsjATLRe7qR9Lu4nrnamYyZgnjrE9
	 By7n0NTGebDr8d1XXmZRq18UxWBrIvcIEmRTgXxZ0eRmHhQ38qJq+KRa5dlHGr0gGC
	 oADOmSYC3I8/O9EPE5oGlyX27mF63jjfmYr8RYqs=
Date: Thu, 12 Nov 2026 07:26:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Wiseman <chriswiseman@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Carlos Llamas <cmllamas@google.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rust_binder: account for deferred work size in
 Thread::read()
Message-ID: <2026111212-unearned-strike-a7a3@gregkh>
References: <>
 <18e70d7cbc2831c0.3137322e32332e3235332e313736.1920de.0000sendgmr@google.com>
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
In-Reply-To: <18e70d7cbc2831c0.3137322e32332e3235332e313736.1920de.0000sendgmr@google.com>

On Wed, Nov 11, 2026 at 05:23:24PM +0000, Chris Wiseman wrote:
> When a looper thread replies with TF_DEFER_COMPLETE, its 4-byte
> BR_TRANSACTION_COMPLETE work item is queued via push_work_deferred() in
> inner.work_list without setting inner.process_work_list. On the next
> blocking BINDER_WRITE_READ ioctl, inner.should_use_process_work_queue()
> returns true and Thread::read() checks only whether the remaining output
> buffer can fit a single transaction (4-byte command code plus
> size_of::<uapi::binder_transaction_data_secctx>()).
> 
> If userspace provides a read buffer with 76 bytes remaining after the
> initial 4-byte BR_NOOP placeholder (read_size = 80), Thread::read()
> calls Self::get_work(), sleeps in Process.ready_threads, and receives an
> incoming synchronous transaction queued behind the deferred
> BR_TRANSACTION_COMPLETE in inner.work_list. Iteration 1 of the loop
> writes the 4-byte BR_TRANSACTION_COMPLETE, reducing writer.len() to 72
> bytes, and iteration 2 exits the loop without delivering the incoming
> transaction, leaving it stranded in the thread-local work_list.
> 
> Add a size(&self) -> usize method to DeliverToRead returning the maximum
> number of bytes that do_work() may write to the user read buffer, and
> add InnerThread::pop_deferred_work() and Thread::pop_deferred_work() to
> drain deferred items from inner.work_list before entering the main work
> loop in Thread::read() when the remaining buffer is at least 76 bytes
> but cannot fit both the queued deferred items and an incoming
> transaction. If any deferred item writes bytes to the buffer, skip the
> main work loop and return the drained deferred items immediately without
> mutating inner.process_work_list or waiting for new work.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Fixes: 8eb05e8e47f1 ("rust_binder: add TF_DEFER_COMPLETE flag for avoiding userspace roundtrip")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Wiseman <chriswiseman@google.com>
> ---

These patches are not "threaded", what went wrong?

thanks,

greg k-h
