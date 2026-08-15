Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF924DFF9;
	Sat, 15 Aug 2026 00:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786755240; cv=none; b=IVsSSBEuAk5D4WzHpHuV3v5tRc+s6OlXAkRxOupBijAcWACIA1BY2vUWPaZVIyfohE2Xf8A00nkk7rbsiOlqJP6/UvBIYrm9ivPCIfeddYFLyWmE5mEXsXfJq1DEjXVTVPMIjkPzRHzcqtpPLNJ+lqB841Y7PXInOVmko2Rn+0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786755240; c=relaxed/simple;
	bh=OdU/nDkUfm9IAXxZDo/E7ekjsBdXp7N2zS93y0hhLKs=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=S4iLkGTDVy+muKl7Jo7z64UMKFCj13IJ586FakSavcE3/PalA9dyWLJE5ka+FOZzh4X1y7+fD7wQGllq6Q+5MMrZqtBLoSbDTsRlRWGeR2CLnc3r7Pvs8dbzfenLmBmmtd7kzvzgoeTL+w640clPVsc00ySiw03QdwP4vPlaSE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=kV6cVoze; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="kV6cVoze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786755230;
	bh=Spq06ZOlKB391aPMRPgTTo2/CifK1Sxav1azc6w1EFs=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=kV6cVozekoBdxqY/PEDDgZ82NCi12IFmc4f1k1hB7g1JQ9Qvf7GXvEjgMJAbPGU92
	 rUaYvIoQD7qBb5I3o7M7h4qSptUvqnOzwwM2g8g0JdpAunFu/0YzU7IEnezO1ZAz5T
	 Zvg5ge20g7mC2UB4YEuQa+u2d4R0O73J7bPF5jts=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hMLFV68Xtz6vJh;
	Sat, 15 Aug 2026 00:53:50 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hMLFV2Wwpz4y6W;
	Sat, 15 Aug 2026 00:53:50 +0000 (UTC)
Date: Sat, 15 Aug 2026 01:53:50 +0100
From: Bradley Morgan <include@grrlz.net>
To: tristmd@gmail.com
CC: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 penguin-kernel@I-love.SAKURA.ne.jp, rusty@rustcorp.com.au,
 stable@vger.kernel.org, tristan@talencesecurity.com
Subject: Re: [PATCH v3] profiling: don't free prof_cpu_mask on init failure
In-Reply-To: <20260814222019.3054116-1-tristmd@gmail.com>
Message-ID: <6667EA38-1012-4D8B-A15D-F310184DBC07@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Ummmm, not sure you should replace it with that long of a comment,

What you did was meant to cleanup useless crap. Let's not add more 
useless crap by adding 7 new lines. When it could be explained shorter
IMHO, Here's a example, I mean, its not the best, but it works:

/* No need to free prof_cpu_mask()
 * anymore, the error path is rare
 * and the leak is harmless IMHO 
 */


feel free to bikeshed. As per usual.


Also, here's some stable "rules" I tell most people

- Please please please add why this is bad in the commit description (you did that! Yay)

- A splat, please. It helps the stable folks not think that this is another "bug" (Do this if possible)


If I had to say "Bradley, just review this patch for what it does for f*ck
sake", I'd say this patch is useful (sorry for my french!)

So.. here is the tag to add for V4,

Reviewed-by: Bradley Morgan <include@grrlz.net>


Thanks!
