Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D363F423E98;
	Mon, 14 Sep 2026 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379752; cv=none; b=Jv/rExvd8s2rf8RqGwFUpf3O94pX3GP9kKmBGhxx9l05YemW4Om4DAU4HN5myw8uiv8plTDtp+zIv9B381i112KTVR7N2xIDCeEZl0JvZD3wue790aK+jKoCYPRCJowFmnhqwZ4H/4z58DnjMuwtEgwdLdVbKVE5gk4sCul/Xo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379752; c=relaxed/simple;
	bh=3r2BJQUB8HgCZs0YZR2845oTtv/OoYyHC6kZRVQZriQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+C/mRWa58yYo215rHa8Q5c1YO1nvVjB3CeCFsi/vxT60dTfABtxxpBaIx7YUD32YBG2zytacq+6v1w4Fyw8Yw7WDUyV9wO6q/VaZfIfA4u03ZxNbBDUTsybVvAvPpJZG7/UED8qLorB173CWHWxlsL09adC+BqEtIFwFxAz7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=c8OpmHaw; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="c8OpmHaw"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 466A514C2D6;
	Mon, 14 Sep 2026 11:55:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789379748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nfIiwjwRD+eNd3rgNnbfGDvuQL880sn0b831IITwi2Q=;
	b=c8OpmHawWwfT6tlsKiLSQ4hPaKUSce+H6M5WS2QufVyHTGM46Db3/O3VFcmghZTcCTxy8r
	bi3PPeDMgLzjKPgQUX7Ykz0hJgqyLx0EQ5GKhxDMMPZdjyTogwDfpqnBANvzoCje280DMK
	pP9A6+eCvEjJNkHlFO/t4ZUAfRoWAL8YNig9Yh85pIC4qnzB7DRoVJ97MFgzltAUmER242
	u6XkGPw9+Qvplj2d1VneKUL80yJWWjnyui6n2R16MuLX2OVlD3pmYBIrn/SgL6nZ4ZWHhM
	iqRchGyTDf5WgFD5Dc+HEjXaZkInzQzzI9JFLbDChzLf+X7AekroUQouSe4lZg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c58fa861;
	Mon, 14 Sep 2026 09:55:43 +0000 (UTC)
Date: Mon, 14 Sep 2026 18:55:28 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, v9fs@lists.linux.dev,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] 9p/trans_virtio: bound RERROR copy by mapped pages
Message-ID: <aqfEkHhMUHz2s6y6@codewreck.org>
References: <20260607140603.24342-1-zhaoyz24@mails.tsinghua.edu.cn>
 <23241140.EfDdHjke4D@weasel>
 <aqczkXDT-thZshJr@codewreck.org>
 <25205411.ouqheUzb2q@weasel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25205411.ouqheUzb2q@weasel>

Christian Schoenebeck wrote on Mon, Sep 14, 2026 at 06:01:04AM +0200:
> And `len` field is just shared DMA memory written by server. The len value is 
> not questioned anywhere in the call stack, it is taken as-is.
> 
> This is for "split" ring type which QEMU's 9p virtio device is always using 
> (as QEMU's virtio device is not advertising "packed" ring type). Linux 9p 
> client is agnostic about the two, but it does not matter either way, because 
> even with "packed" ring type the call stack would be slightly different, the 
> len field would be 32-bit instead of 16-bit, but its value was still not 
> questioned anywhere.

Thank you for the legwork!

> > If we can't trust req->rc.size I believe the p9pdu processing will also
> > read past the end of buffer so there are much bigger "problems"
> > 
> > With that said, I agree with your assessment that qemu is mostly
> > trusted, and don't want to spend too much effort on this (unless
> > something like me losing my job happens and I suddently find a lot of
> > free time :P), so if you (or someone) can confirm rc.size isn't trusted
> > then let's drop this here.
> 
> Surprisingly though, it is not as bad as one might think first.
> [...]
> Or:
> You could simply pass the bad card on to the virtio subsystem maintainers, and 
> tell them to clamp used-ring element's `len` field against the guest provided 
> descriptor length, then req->rc.size would be trusted - no validation to be 
> done on 9p side. But even then I can imagine that this would be implemented by 
> virtio maintainers as an opt-in solution for drivers like "please clamp this 
> for me" to avoid breaking certain legacy devices.

Given how surprised I found this I could imagine other virtio users to
incorrectly assume the same, so I think it's worth bringing up even if
it doesn't end up implemented (we could actually probably cap this on
the 9p side if we wanted to anyway)

I think truncating rc.size is worth the effort even if most of the paths
are correct, and more appropriate than this current patch, so let's drop
this patch - thank you nevertheless Yizhou Zhao for starting the
discussion.
I'm out of steam though so will take some time to send the
virtualization list a mail.. :)


> > FWIW I said "mostly trusted" because lately we've had things like black
> > box hypervisors (I don't remember the exact name) where guest VMs memory
> > is encrypted and can't be accessed even by the host: sure the server
> > could still *crash* a guest, but it shouldn't be able to get arbitrary
> > write/read primitives, so if someone wants to spend effort fixing such
> > bugs I think it's welcome and I'll be happy to take patches.
> 
> "Confidential Guest Support" is the term. Wouldn't change the picture here 
> though, as this is about a host triggered DoS. Host could still kill the guest 
> at any time.

Hm, yeah, I was confused and considered this as a oob write but it's the
"reading a page that doesn't exist" that fails, so it's not likely to be
too bad even if it does happen.

> The negative dentries patches come to my mind which you might have forgotten; 
> I think v7 is the latest one on these:
> 
> https://lore.kernel.org/all/cover.1779355927.git.repk@triplefau.lt/

I'm not sure why I didn't reply to that thread back then, but it's been
picked up in 7.2 :)

Cheers,
-- 
Dominique Martinet | Asmadeus
