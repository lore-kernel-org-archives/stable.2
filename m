Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996971F099C
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783952462; cv=none; b=nh1/TpZpt01Eey8WAHx7/yY865qmRlTLHIqb+KUczxXq6xJGtO7m2l50TguO3MYG7YpIu2AtQmabs104l/nswbCmcceUfHalw7ukjET7m4CzxNg21V7lxi9jUqr73JuKO+htEPAi4P4qt5TiVWfY86ndHp9N9r/u+9i4VaQfqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783952462; c=relaxed/simple;
	bh=LeLc1llhf0PMlCspoCbrUoXy6+AV0me2TrJmjljyT2s=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=RSOMXu9kJGcF3oj8pQj0FLEkVdGyCdGR4UfKhPSi9TeXab8tRf/F7r0CgQK0ZeYiFh/pUY4Ahh2A4WZhSeWGI6iYAKuyVIexyhy0uplJUgFwNstMRPoby4+PfjA4khSbuupLQY5/fryuC/P2dpn9qRHILnvskJIcveUkikF+fak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=aC+I2FN3; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="aC+I2FN3"
X-KPN-MessageId: 1068b33d-7ec6-11f1-8f54-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1068b33d-7ec6-11f1-8f54-005056992ed3;
	Mon, 13 Jul 2026 16:20:56 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 10678412-7ec6-11f1-9b0c-00505699693e;
	Mon, 13 Jul 2026 16:20:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=bIFnZ3KGdR4CKnyx75LCp3jZBE63H4isY2YjwT3K40E=;
	b=aC+I2FN3BHeYqiSmNdjSu7P7ZTGylyF2zlsyTaHpcMrxnOQ8LdZLdCbpQohJj4NsK1gm8DaEPRtu8
	 07RoAADHF+zSHEcJtcJzpxL4aFElCeOupaxGBTxZz5hRdI+cNZLh4W0h5rvMIDtMHrr6xgvhlgWert
	 bo3pVXzOM27gWjS21C6r7evTzSQ/o0Rfim9dLBpk72rRJSCRarNKcV21tR1aX+JpO17MIzRxfAbWZg
	 4OiHFSbWthl6YDnYV55dS3CuegD3Rn73pxp5hX+ETn+LTFlVPXIrsmol+i9MgRd8PENcVmfCVDzGq1
	 kgAF1lOfJZ1pKdDwFQ1qwceg0026EPw==
X-KPN-MID: 33|fFDYJmCM2JyhhASvSGhTgTleZxTLrdjH0y1cLbO3y2QpbaysJjOai6CaO0r+exD
 Jruq5D7vLJ0pnZps+8hGyHiHXCGQ51BOu3uWprkjpgkY=
X-CMASSUN: 33|0RkxCv4tFRlwJdj8l/MBDyA6+HZKOlkOXM/yBWmui5g1GI2jOCjlC9qw9O4V11R
 YcMTgRjUi0ENp2aD4oW/c9w==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 1059c206-7ec6-11f1-8edb-00505699eff2;
	Mon, 13 Jul 2026 16:20:56 +0200 (CEST)
Date: Mon, 13 Jul 2026 16:20:56 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com,
	stable@vger.kernel.org
Message-ID: <479591519.862301.1783952456807@kpc.webmail.kpnmail.nl>
Subject: Re: [PATCH v3 03/24] binfmt_misc: reject a flag character as the
 field delimiter
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

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

A general comment on the code that does not affect this change: the
nesting is awful, it would be great if we could reduce that by moving
some stuff in separate functions like check_special_flags().

Also, can't we support a less arcane and impenetrable format, like JSON
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
