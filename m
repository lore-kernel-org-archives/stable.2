Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91530D3F5;
	Thu,  9 Jul 2026 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594986; cv=none; b=p8RaQmcIP4XToJtTWs37qgSdjipkVb5AsrIMnc/hoPcK+VujTFtl+IYzvs7m/ZFQ8YCoMZiejNyTmhyZa9y+JUhseSZHR4ERspZl61ga8jo20HdKGeiICZ9LJ6EqZT7kEGtaqrMd9sVKQ2whPREjgSNZC+LrfmoyaOZOZ3kC7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594986; c=relaxed/simple;
	bh=p55wg9o2CIM/9ojWi6KJSVpsTMNGzPVi/M1qeOLBFGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvEbAnPE+2tSFDCd697cJOqLHE2lTB3GOuIn9t6Bz9OqoFLQpGY/t6RvZZbCsJiE0voGcy0+I+ou7qLESu+/ADDP40MVWWuHNG3gXpAZ0nnJSNGwQTLBCQdlbipptz7Re83ZZfK9MtHzYFpVeqO25LXfOmmQXuVg7SCW5e8DRQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KN5aK406; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KN5aK406"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1191F000E9;
	Thu,  9 Jul 2026 11:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783594985;
	bh=yt9JYWmgyoQ4Q7SsCJBiZQw7CmIhiVTIeVdDSiwq+AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KN5aK406K1TFcXoT/iipFVrhpWB3ez07LGjMPtsOfhL6CI4JQ1B6VmI0OHVSITsy0
	 puoCKrRtgL6okpCtwefUTnAcgeN+FogJqzoxQ5mOg1wFeTe0qeraM0estemHyb8lOY
	 hYNcXgAE5X7uqwqoXktCsqBsBIeKS+T9G3WBC1+g=
Date: Thu, 9 Jul 2026 13:03:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Hao-Qun Huang <alvinhuang0603@gmail.com>,
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>,
	Nadzeya Hutsko <nadzya.info@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Martyn Welch <martyn@welchs.me.uk>
Subject: Re: [PATCH 1/2] staging: vme_user: fix location monitor leak in fake
 bridge
Message-ID: <2026070945-tropics-shredder-bad7@gregkh>
References: <20260704065817.403111-1-alvinhuang0603@gmail.com>
 <ak986K54RhRDMpfn@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak986K54RhRDMpfn@stanley.mountain>

On Thu, Jul 09, 2026 at 01:50:16PM +0300, Dan Carpenter wrote:
> Hi Greg, I'm back from travel.  Should we just delete staging/vme_user/?
> I don't know really if it's used but there are some pretty severe
> security issues with this code.

There are probably lots of issues with this code, but from what I
recall, the systems that use this do not have "untrusted" userspace
processes on it, so it shouldn't be an issue.  If that's not the case,
then yes, it should be deleted, but really, no one cares about security
issues with code that adds TAINT_CRAP to the system when loaded :)

Martyn, any thoughts?

thanks,

greg k-h
