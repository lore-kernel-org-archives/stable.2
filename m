Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893060;
	b=idO+PT8PgUuu5xy4wDxJIlBgCEL4Q1wO+cZt1r1d+lq+9Evw2pd0XGOZMOy5Eb+K6nN7
	 S7wermlNu3C0nN4/h6wQBhNcv/BkvECA+I5aeICa8/q/dz1pBsUtXgVT4ElG9Uw3JaefU
	 1Dpiq792cF0f6qtA5cRZ83HNoqPEFsmgprHlRn0vuvifKwATSA35tcrZHE5F+5tSkwlE9
	 qhTv5ysHNxE/0fTQ4lSuF7S0g369a7xlcABRT45hiwbKeM+7N1foMoX7imcRUFSlfJrK4
	 08XjxG3pb6U/qGEb3+cq8xoKTn4IHbSvt6Wm+jxpDSP2QSRha3oInf5A9l++ixUlChA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893060;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=BFU1+E9mcNhWQlXfE/O5YpbQsBrKf3zNJRBD64s14aA=;
	b=cVO6O68HvBn0x+iJIhA9AlKHZsDK1gCjj1oczskUrih7aab2GLpQGQ1Io3VzJCffnJCD
	 4/Rz/16n0r+AwYK97BcYML2FFM2X4QeTryFOuSi6+8QS7zhMYuVtdNHuLB27DaOY1WEWu
	 juf4Oh98N9oRhycN6YB8JzfVxKJdMDoRbgs53WuyldT4BUEyRCjZ4QHJFAGj2zzbAfbNG
	 KqxVM/UUVeBzIlnDHzRG0ojKaTi0b3/ad6szXb9daBjTyDfwRTArJH+LrB5DdR4zhNuTc
	 /jo+ekbnyDuqJD3s/rDRwcGPqvRH8c4fSQdp5A77xTRw2bBl1WcYwEz6gezx8WpU7iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=dkY2KMYZ;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E1C606A328;
	Thu,  5 Nov 2026 15:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25E1C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=dkY2KMYZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BFU1+E9mcNhWQlXfE/O5YpbQsBrKf3zNJRBD64s14aA=; b=dkY2KMYZBK3Uybj8OTII/JQrQK
	SbS4k55YVkFvOY2qqXA2n1IDCLHioGpn6djci+mVulAfSoVBNHxBkVCaABDwYOP3LvLjWEEyT5AwP
	gnXo5GWb4ESORE8+7B0thK6KF9ntyUiOBLQCX8cKVWmvxnHJjChfh1xZcz/FDiZIMuuZtPSNz7Dsh
	SYwaYw78/re4N+0FyYt2HLQF5tBOZVL7HH3VsLmwL0zK+2aypec/A5FIGyAdin2SWciIIwcS951Lz
	JehVzPvSzbLu7bN/PcZgRZzuGofxDVIyA4Tc6Lxl8NUxQylXcSUgHVa7+n8nTak0cfNBUgRb2JfYn
	23ABZTLg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOzWr-008bES-0Q;
	Thu, 05 Nov 2026 15:37:29 +0000
Date: Thu, 5 Nov 2026 07:37:24 -0800
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kernel@vger.kernel.org, printk@lists.linux.dev, gustavold@gmail.com, 
	samuelcrossley@gmail.com, ryan.roberts@arm.com, brads@mainlining.org, x86@kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: nbcon: Flush unsafe consoles from printk()
 in panic
Message-ID: <auyh6TzbqTj0Xkvx@gmail.com>
References: <20261102-panic_unsafe_flush-v1-0-12d1e22fd6d8@debian.org>
 <20261102-panic_unsafe_flush-v1-1-12d1e22fd6d8@debian.org>
 <87v76bz6rq.fsf@jogness.linutronix.de>
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
In-Reply-To: <87v76bz6rq.fsf@jogness.linutronix.de>
X-Debian-User: leitao

On Thu, Nov 05, 2026 at 03:40:33PM +0106, John Ogness wrote:
> I am happy to code up a full implementation if you think this has merit
> or you want to see the patch to decide.

Yes, please go ahead. I was only trying to move quickly and close the
netconsole lack of messages gap we have right now, but if you can take
this over, you are much better placed than I am in this area.

Thanks,
--breno
