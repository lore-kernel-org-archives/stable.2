Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898362;
	b=zfhEzvsn9xP7EU0ULOIYd7u3vntvit19DaRStHpWLW2hXOyh3TcSBGWlQ1M/lARjvWRi
	 GkLYmvqAPNj17mgrbuY2hRTH5Gvp8yos//Uu7IsRbDTZynae0Lo0jPzBfOrXCGIZ5g2CU
	 yBvGK5yWhelm+HX2cchCe5XHf4mWPkk+3+m1PQ6/YcQjrm59VFRV7VoaTtYPniX4ypSWR
	 Wx5pipgJHKOm/WQsmjgtSI0/RcqK2TtDw89Q/Rx/HNAuk79LxVN3cRgu1qGo2z0xVdSzo
	 jpGtCO3YX8UwhAcGFg+wTmeSQrQGB8GcR/645JI2Uy8lClW3sII2MVA/isl9ryyladw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898362;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Twe0aY/U+MN8w6HE4ke2gDnsaF4xrWPDEDpdG58nDvo=;
	b=QlhaGS8lbe5UWyb9cJ/4MdMM5STAG8YBdObGSfGSrc5KRFQl7YotBozJafUxB4Rfzmyt
	 0cmByoTUqRO1Ei2qSd0TvoDg1O78M4YFFxL9DMVI96SXNDp9X0s6JrQtmNXe+aSrZL/+2
	 aN9fDOFK7cuB0YSotuIIXEQepzjyuLFDn6XpZH5Swsf3jjLBBCj4BbPSzTb8jKXpFDYm0
	 jtwI0j0f1i9JlnSu2aaokQ5EvzAHY9Vz9M1Jq61pJ24j42+j5lNaVo8UQtGqZrSI/gsRE
	 4n3lVf4A6tconPTLY//fs3QimYcbQ4iHauUK16oY60KfGi6/BQm95oLnYcH0bqnWRiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V3Om/m15";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116DC606A329;
	Thu,  5 Nov 2026 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3Om/m15
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D5C1F00919;
	Thu,  5 Nov 2026 17:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898361;
	bh=Twe0aY/U+MN8w6HE4ke2gDnsaF4xrWPDEDpdG58nDvo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=V3Om/m15Ah4w37HaovgR+UwmzPaXeHgGA9lIYeTbnfhTKd881ix0xwpoqeBAh5ZnH
	 iJXQwOsmyrzVj0DguGUcYJvd9BiPDFsUMwmlLyYyvQfYI9JBV6WGJUluOLrsw1AcyS
	 kofez4od2RXq1lNOq47xAEUBFq5uAtW99pJlWp5IRSBgIfTWYWY+wtaS31xkClzU76
	 i4ajizg3kWW3jyjaNUna6XdWwIxwwo/uW5b/qlKMI5UhKCNIMbln4PqEZk+nKZbl7T
	 6QYxUOsR9XbeaiE39Lz9YjWdtckWoVb45CDWflKhZRNA8ikVJRqZ8eXwkF7Qn4tDF8
	 ql4YfouhBgyNA==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Mani Tofigh <mt4022@columbia.edu>
Cc: Jan Kara <jack@suse.cz>, David Rientjes <rientjes@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, stable@vger.kernel.org
In-Reply-To: <20261103-epoll-killed-waiter-v1-1-36e08c16b8a2@columbia.edu>
References: <20261103-epoll-killed-waiter-v1-1-36e08c16b8a2@columbia.edu>
Subject: Re: [PATCH] eventpoll: wake the next waiter when a woken waiter is
 killed
Message-Id: <20261105-lethargisch-reich-kaufhalle-3057c2cbe082@brauner>
Date: Thu, 05 Nov 2026 18:05:57 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-ce4c1

On Tue, 03 Nov 2026 13:19:01 -0500, Mani Tofigh wrote:
> Processes sharing an epoll instance can sleep forever while an event is
> ready.  An event wakes only one waiter, which then wakes the next one in
> ep_done_scan() if events are still ready.  Since commit c257a340ede0
> ("fs, epoll: short circuit fetching events if thread has been killed"),
> ep_send_events() returns before the scan when the waiter has a fatal
> signal.  If the woken waiter is killed before it runs, nobody wakes the
> next one:
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] eventpoll: wake the next waiter when a woken waiter is killed
      https://git.kernel.org/vfs/vfs/c/06fd21622a31

