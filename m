Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B890C63CB;
	Mon, 10 Aug 2026 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786334388; cv=none; b=sGtgd6Cv2YgUdswHKb5+BE4Zorb3XRIqfQzenPGSW8dcrE25QQDZknmvBZi8EN7wg0PIQQ8E1dtLHLVeAIwYroHPU9eX93QKvcFDZukAHyyUTMR6bZf67/Phmow4dvxEZw8uzJmQaoGn3FMN8BS6qEe2AWr9nVtWPFtpJ4WqLr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786334388; c=relaxed/simple;
	bh=+mVjunRDRpHhauHY+zDYmgJ9X+bFrrKdQUezNyrL248=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFPlzQm6hUSDtnpv1+QmqNjBE8AmtXXVbRThXPfpyNbS/Vupt96eDNMHKCWSOVC6OvLPCfSmLJHVpFVIKF+Ps98gO4t8iDgStEhdoxmofiBNCSIb+T1PM5BZWqRFNvtJu2ymjlqzUF5qo7XPrcAVT4Ryea7FiFPlnbhQrQ72LaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=nQYKZwKQ; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="nQYKZwKQ"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 27A9A14C2D6;
	Mon, 10 Aug 2026 05:51:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1786333865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XyRRpvZmA3yxFgZuA+v2zPenQbWH4BzjnWX2nuo+80o=;
	b=nQYKZwKQJL9Ql60S82r81Utq1U6R6MdMqd7yVZiFtsk6Q9u9Nuaf41xGKlcpm/idh4HiVN
	gPEEM63PgiMAWnBjqpjHPynwh8peogUFw6og3QLfZ0a5m3jzbzv2nbdQtjLNql/8ys7XAy
	xQlirQg+Wj/6KBZWBkLiz0MUAX13qaDARZrQSnx/Dh1QveicBdHoRFU7pvo3vCAKLuSXgE
	Zf3yylCnFtwPSeIEX3DUSGe120Qljrb61cC4WWsecfpLCFnSeTW2e2hoTmzMuT2j/5v/74
	ny9BXEDFcBkHap6gKAWI4Hue5UhmVgsPBfkPoqEwOS5RX6y8831H0mwBbxr25g==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id de4b7b7c;
	Mon, 10 Aug 2026 03:51:01 +0000 (UTC)
Date: Mon, 10 Aug 2026 12:50:46 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: Linux 6.12.99
Message-ID: <anlKlnYz1on6qET_@codewreck.org>
References: <2026072931-buddhist-lethargy-769b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026072931-buddhist-lethargy-769b@gregkh>

Greg Kroah-Hartman wrote on Wed, Jul 29, 2026 at 06:17:30PM +0200:
> Lorenzo Stoakes (1):
>       mm: refactor mm_access() to not return NULL

FWIW if anyone else cares and looks for this, this backport was required
due to a NULL deref in 6.12.98 (and likely .97 as well if commit
4bfe8c481846 ("proc: protect ptrace_may_access() with exec_update_lock
(part 1)") is indeed the culprit, I didn't check):
https://lore.kernel.org/all/2026072933-widow-grouped-f9e4@gregkh/T/#u


Greg & Sasha,
this is purely selfish and I'm grateful for all the work you two do
backporting patches, but (for next times) it'd be great if the backport
commit could also point at why it is backported after all this time
(for example add a comment or even just the above link between the
original sign-off and your's) -- it doesn't have to be much, but it took
me a while to find (I was curious because this was an urgent release
without -rc, with a single 2 year old patch branded as refactor not
fixing anything obvious...)

Ultimately it doesn't change the fact that "all users must upgrade" as
said in the announce, but I need to judge the urgency of the upgrade, so
having a rationale is extremely useful.
If backported commits fix something obvious then there's nothing to add,
but in this case I believe I'm not the only one who'd puzzle over it (if
someone is actually looking...)

Thanks!
-- 
Dominique Martinet
