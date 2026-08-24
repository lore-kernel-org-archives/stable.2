Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC701A0BD0;
	Mon, 24 Aug 2026 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574819; cv=none; b=H2IuO4a+ZJS9vVhy+QLcx3aqG2hYRD2Q6vExgykSMHgg07qNRLmK40PtZJcrr4Xkxe0xJCpXHA8seA7+75B0wRVpqPcxmlW/LC8DxYP/iQwwagLK24AqRWSaAF7QfFODEkM+/fZNQdojM9nu7OdZbDRvO0pQeGd3r3TAxDk7S7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574819; c=relaxed/simple;
	bh=bykOAN9dE/SRBKX3cWnbbOOsCia0DcoMyPjMGmkh2pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrBL9LdxCxIrb51Gn26r1aWQC+1b8Q6TKo88emaqoyqfMHYFnB/4suzeFknDToNDERS3ZCbATY3xjHocbDT0WpJ3zRYixpvZX5De/QBmLtPhXwh0KKguCxvPGPYxyqmh15TYKM8kb7dkyTJiLNW2MR0ZwNg9nP4SzMAekKOk474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LmvZ/atP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LmvZ/atP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78361F00A3A;
	Mon, 24 Aug 2026 12:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787574818;
	bh=bykOAN9dE/SRBKX3cWnbbOOsCia0DcoMyPjMGmkh2pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LmvZ/atPpKsyK7lDDIs0F/KWYJ3hTZr6W94gOkwpP/d2OwbM++rvLSiJdih6XWJMR
	 CMk1bhwuXvM9aYS5pnGLc+Ty8Er5nCa7Axjy2LTljh48VDg6TVmoL0K3RgmVJW3D73
	 pIdCYXFDb5iNLFJhJqHLJasK7EXozjHM9xCxUz9k=
Date: Mon, 24 Aug 2026 14:33:33 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: nirbhayykumarr@proton.me
Cc: "arnd@arndb.de" <arnd@arndb.de>,
	"alexander.usyskin@intel.com" <alexander.usyskin@intel.com>,
	"w@1wt.eu" <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] misc: mei: fix race condition between client teardown
 and read completion
Message-ID: <2026082459-kiln-overwrite-3832@gregkh>
References: <2oKLyY1tm4g6xwyvmh7loQ1t1EBr1rNjMzfiXN-b0q8BbO_4vjW0xcxR_aTEielTWx5ma4f1NCO4Y5LG98PRKseN6WLUbnXR9zGtcQVR9zY=@proton.me>
 <2026082401-spoken-nag-acf7@gregkh>
 <nAKQ1OCohroK1IDDGOCNsI3rhxnpOt-dQp4PRQUgdPCJ13DjUIXHdp_mmdu_juNtAn5AgqR-hkQnMY0vllSuVDRyIGyzk-K-FOgOUmC8h1o=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nAKQ1OCohroK1IDDGOCNsI3rhxnpOt-dQp4PRQUgdPCJ13DjUIXHdp_mmdu_juNtAn5AgqR-hkQnMY0vllSuVDRyIGyzk-K-FOgOUmC8h1o=@proton.me>

On Mon, Aug 24, 2026 at 11:00:15AM +0000, nirbhayykumarr@proton.me wrote:
> Hi Greg,

Hi, but please don't top-post, that's not good email etiquette :)

And please wrap your lines, I have done so manually below so we can read
them...

> To answer your first question directly: Yes, I used an LLM to help
> polish my changelog and commit description, and learn the strict
> kernel mailing list etiquette. This is my very first kernel
> contribution, and I used it to help navigate the patching process.
> However, the core technical work, finding the bug, root causing it,
> writing the C patch, and testing it is entirely my own.

That's great, but as you used a LLM, please document it as such.

> Regarding how this was found: This came out of a broader research
> project centered around systematic fuzzing and interface testing of
> /dev/mei0. As part of testing various subsystem boundaries, I wrote a
> custom multi-threaded C stress utility that rapidly hammers the
> driver, more specifically, one thread streaming asynchronous MKHI
> requests while a second thread concurrently drives rapid
> open/close/reconnect cycles.

Great, fuzzers are nice, you should explain that in the changelog as
well.

thanks,

greg k-h
