Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB054908A9
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993839; cv=none; b=IAsF+ov31hyo5ZdCD3epKoI7aeI6aSEMNZtI2pamnDpzkM7rAPkmpxUwGR+6SO5gWo6J7/X7elv6+HAYm7yfM3MF4SbmicqZtPgWjs6sbcmXtLcbsUvpmcU54lwo9/106zC4vicyxWZxaM2cUGnj8UrQAf7GciGKo1/3q+KaeCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993839; c=relaxed/simple;
	bh=jA+5PzlUxhteNcknjruOvebXQgLw8ZHk9CBt49dM8Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLXg5A1s+/gt67yi7n/FxCEV9y6TTU7Z07iyNGVFNoK3a3IRTLKStb6hB9R9cJrWIiXhM8f3COndP8wwzzNWk5HigYZdHYHcIJBM3Vv2ud20k3/fHx7sGcJPpiCU7Pc5L61FNiKU7E+9f/sXSLTnFnIxpeUwY8TaR1READrWuc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Mm3u0sp0; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Mm3u0sp0"
X-KPN-MessageId: b11cde50-883e-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b11cde50-883e-11f1-b2a8-005056abbe64;
	Sat, 25 Jul 2026 17:37:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=Kzrm4el2kJ2zOPrLkCzsRanxnWrcZ1Z8oao0kpE8c24=;
	b=Mm3u0sp0ICBTVGxRZdQnqFy09UC5qtFAC2Ca+p1rI/TOZGu8Hw0mk3t47xIb1zA+HGclPt7/ZtNTX
	 nvfpztScDHyunoA90fdGUEMaGbdlviDFQTVEq7SVCc94rvLzAJz392eww9g/tDWfarM8hCzsGzYcIh
	 z6lsyl//uT0DXM20fefpweFTTo0CWTwoqIreriH3gMZPck3SNBIhP+Yl3bKLKmzKxr1ZkiCH7jPbvv
	 UJhDkF+RVHu4pGXdkxEzHMHF4aPgbHXNAsbQVDxJphwW7lsFyZWQq4jNIJxPNA5sX53fuhk6a0kA8b
	 md1g2Lx2kuphafSIDUZhFvKfnOvzirw==
X-KPN-MID: 33|AQDj9gEmkudzdLpa44XQjDKvy+eKWzFMBCJoRQdzzVUguD9I5RY4fdBhZYLixuU
 9+pieLSto7Ys0EqD7woxXV+4UoU4yNIYZqoLSo890TMI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|CYCKKQMDdoRjpRO+ERFKxTy+1TovFz6t48NFminXX/rUyEufmxvmRTb8RSj2/9k
 TjOnchlGRcLNGl7uWQRfssg==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id b0c0eed2-883e-11f1-a998-005056abf0db;
	Sat, 25 Jul 2026 17:37:06 +0200 (CEST)
Date: Sat, 25 Jul 2026 17:37:04 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 03/24] binfmt_misc: reject a flag character as the
 field delimiter
Message-ID: <amTXwUK2FXu2sHI2@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-3-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-3-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:04AM +0200, Christian Brauner wrote:
> The registration string starts with a user chosen delimiter that
> separates the individual fields. So that the field parsers terminate
> even on a truncated string create_entry() pads the buffer with that
> same delimiter:
> 
> 	memset(buf + count, del, 8);
> 
> Most fields are scanned for the delimiter with strchr()/scanarg() and
> happily stop on the padding. The flags field is different: instead of
> scanning for the delimiter check_special_flags() consumes the flag
> characters 'P', 'O', 'C' and 'F' and stops at the first byte that is
> none of them, relying on the trailing delimiter to end the scan.
> 
> If the delimiter is itself a flag character the padding no longer acts
> as a terminator. The scan swallows all eight padding bytes and keeps
> reading past the end of the allocation until it hits a byte that is
> not a flag character. For example registering
> 
> 	PaPEPPxPPiP
> 
> with 'P' as the delimiter (name "a", type extension, magic "x",
> interpreter "i", empty flags) leaves the flag scan running off the end
> of the buffer. The registration is rejected in the end because the
> parser does not stop exactly at buf + count, but only after the out of
> bounds read has already happened. With an unlucky allocation layout the
> scan can walk into an unmapped page; under KASAN it is reported as a
> slab out of bounds read. binfmt_misc mounts are available to
> unprivileged users in a user namespace so the read is reachable without
> privileges.
> 
> Reject a delimiter that is one of the flag characters up front. Such a
> registration was always rejected anyway, only after the out of bounds
> read, so no valid registration string changes meaning.


Looks good, I see no user visible changes.

Can't we support a less arcane and impenetrable format, like JSON
or YAML?

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>

> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 24142859658c..b7664d90eb8f 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -385,6 +385,10 @@ static Node *create_entry(const char __user *buffer, size_t count)
>  
>  	pr_debug("register: delim: %#x {%c}\n", del, del);
>  
> +	/* A flag-char delimiter runs the flag scan off the buffer. */
> +	if (del == 'P' || del == 'O' || del == 'C' || del == 'F')
> +		goto einval;
> +
>  	/* Pad the buffer with the delim to simplify parsing below. */
>  	memset(buf + count, del, 8);
>  
> 
> -- 
> 2.53.0
> 

I am resending these reviews since I had an issue with my email client
and they were not properly attached to the correct thread.
