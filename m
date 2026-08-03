Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FFF355803;
	Mon,  3 Aug 2026 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777480; cv=none; b=S/flLMe8hzQxWCffuSSo8I+255JkMYFyNfKek5xUu4zyKpWJPYQmsuCl4fF2mkZOZBWfvb304y8lZhqY73Z1jphbyGuQYdQ919SqH8wxsIx25tLTYoiyNyQ8sivVGD2Bl19m0cVn2R1RwV+ZB6ADVPUGkR4lLKmMBXZFqe6xDgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777480; c=relaxed/simple;
	bh=oajd7XRs086k28ngQNZmh82IVdN/n7nM8IKwyjEDIKA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hjQ5yeuUjE6bC5glmdhm+JOwuCF0p/Y6iJYa8bSu3hSsbi9gMR7D+UIdlHGfJF2csdNsVyRqvL4xB+K8xMKcGxuXIbcYQ8H5srH3n21lTXCB733balViYzJdgNLV+Wpca78W/P/dLlkCikC+yaodMeJXhUIY8foLs8RqQsa/0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpKhIUDW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpKhIUDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5871F000E9;
	Mon,  3 Aug 2026 17:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785777479;
	bh=AKno4CHJaS/GGo/J25nreEA0ne39GstKkklCGp9l05Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=hpKhIUDWo7uRZaspghE7C9brwr45Bz4VE695Han+0MGN3WCMXocVx1TcegC7CN175
	 Mn4wSbrJXlQNEx2Q0uRqkFE8FFCjPy6w8H6ch6oGzPZRDfV0mp5UPAxBTyVDfzuRN9
	 NXoKzOybDVWNmE8GTSGVcvTOAd/i3KnIZildYN7xXT+fj1+9xx6iW3oT1lzIAVhMP7
	 igJTE3JofbJgvk5gb7bfCQeH//bjmIzJhenN9PLuqY9uli9pFtAqRiX1sQ2+xppIX8
	 xKU2BkHS92Nf4Iz9bVDLU6IgePzDSxM7WdUMY1M9e3DlEOpfw/SgXJBsvRpX1kPXGT
	 sok/6X3BgsFew==
Date: Mon, 3 Aug 2026 19:17:56 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>
cc: michael.zaidman@gmail.com, bentiss@kernel.org, linux-i2c@vger.kernel.org, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: ft260: fix stack-use-after-return write in I2C read
 race
In-Reply-To: <20260610142952.3335586-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
Message-ID: <5n1o2q8q-2rp8-qs61-1069-q38r38o76nsp@xreary.bet>
References: <20260610142952.3335586-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Jun 2026, Raman Varabets wrote:

> ft260_i2c_read() points dev->read_buf at a caller-supplied buffer
> (often an on-stack variable), arms a completion and waits up to five
> seconds for the device to return the data. The HID input callback
> ft260_raw_event() runs in the input/IRQ path, independent of the
> dev->lock mutex held by the read path, and copies the device-supplied
> payload into dev->read_buf after a plain NULL check.
> 
> These two paths share read_buf, read_idx and read_len with no
> serialization. If the device delays its response until the read
> times out, ft260_i2c_read() resets the controller, clears read_buf
> and returns, unwinding the stack frame the buffer lived in. A
> response that arrives at that moment lets ft260_raw_event() pass the
> NULL check and then memcpy() the device-controlled payload into the
> now-freed stack location, a bounded but attacker-influenced
> stack-use-after-return write triggerable by malicious or
> malfunctioning hardware.
> 
> Add a dedicated spinlock that serializes every access to read_buf,
> read_idx and read_len. ft260_raw_event() now holds it across the
> NULL check, the memcpy and the index update, while the read path
> takes it when arming and when clearing the buffer, so the teardown
> can no longer slip between the check and the copy.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

