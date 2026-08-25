Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC63002A9
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787656634; cv=none; b=h48wJbtvwajXqLh8Zu1nhoYt4QqwuZPib/URSr2yN/m3+AwAUzcGrGUEgUBWEdJD8QHXQgdRPmHNEb0fj32lL3dHxj8T935b2UVYQl51Z0eaCokKC7mAMRq0DiLDq8S9Xfa+OvmR7ixF2YDpwxEapnKR+qMtEYUAQ0Cjj4eR6QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787656634; c=relaxed/simple;
	bh=kxBHH/7zQK5QclO/1bo26SwTGCsyATxV1xKpen0MYUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEWtfYWHR2+NWhB1kQ2t06K43P8vULnfKP1ob0MI16BlHqtPWlEMJteFh01E8dpnOoUvMS2v251vV5E9NPHq1B2y7MtfLHstjk5xYuSlvE/BaGbcZLe2Rzf8cKLDIiD4cGr4P4DOHjN2NIuxBV3tHAi8+HjllYblRnJSN4y1LBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hvk+fzju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hvk+fzju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5597F1F000E9;
	Tue, 25 Aug 2026 11:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787656633;
	bh=vIQbDGzZXetYiHUjyLKcmao9RA+kj94sqsFpD+iPHfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hvk+fzjunT8ZP0yRf7UW4Ohef8Qo8XjxZUYSXQA2/v15vtBn49ydAMN09CeVmUX+w
	 yy5uunbRpOkmjNu9Z7EcAbD1pYGW6RkYO7n2rFKhiDiTTxIu1wGnq1BICQkfOzYlM7
	 A1p3jbbMgTxyaAriJznOvpA/mz1iwPw4ZKNjWT5M=
Date: Tue, 25 Aug 2026 13:17:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
Cc: stable <stable@vger.kernel.org>
Subject: Re: backport/fix for CVE-2026-43198 missing 6.12.x ?
Message-ID: <2026082536-embroider-happily-a30c@gregkh>
References: <01e4f29ebe9590b2c5a91697b0fa4e23861bba77.camel@nokia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e4f29ebe9590b2c5a91697b0fa4e23861bba77.camel@nokia.com>

On Tue, Aug 25, 2026 at 11:05:39AM +0000, Joakim Tjernlund (Nokia) wrote:
> Looking in latest 6.12.x kernel I cannot find any evidence of a fix for CVE-2026-43198.
> Is it missing or is 6.12.x unaffected ?

It is "missing" because no one has provided a working backport for
6.12.y or older kernels.  If you wish to see it in those trees, please
provide a working one and we will be glad to queue it up.

thanks,

gre gk-h
