Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF1535AC16
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785445804; cv=none; b=DWntYvxR48PVCNLXm71oAOI2BpR37C8PXmlRVSAo/gHEgUshShKubX2XRVeRajvDjSJ5sTeZJR2ve0bTdZr9yY8sNgSLoOOsTapYbzoUowd1Q8GBjCduFqdaiCzFgZWa37Z0sn+5t2BHuoQgn9QVaaoceGCMidUsqLl+d1DGeH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785445804; c=relaxed/simple;
	bh=h4gAl5X4nGE0SU+Gh3X/MeeFPIcUPYTfpNfqjtezBaA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=bddihRD0TF3E9TxUpAV+aBAB6aEnre70Gl/7z7a3r5VkDlwpdzwpJ55Srbek3aL9cx2vjjWhRvStYgo1GW180mowBRvLzRhb7HDqTdcQPiZoFAoU8iBVoHedV8cXh9sbhrFgzf6v6s3Mg+pcJBPNY2/bGe/U+OU/n+IXhbA2cew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fczzRw2g; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fczzRw2g"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c08df8513so1457611cf.3
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785445802; x=1786050602; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lMLsf+LQaJK9TyVbvhOADIYNpgfmalBwRgJCFWQKWPY=;
        b=fczzRw2g8JaX6smDaTZ1xAWIookwAoR0D/4mwj9qfdsvrT7xHZK7cUCTG/iaRkHggR
         P3+FocISR0RAqycHZjKdHWOKhym2LY4kDNpJitfSn1SLsP0xJldbL6dnOQiOH+Ui8UO0
         0s0iikmvOL5UJp8pwQK+3zogN5R8tgZiWKl76qP7zUMCexyqTjscuP09H47el/A5LOPQ
         bLAyklxxIuDg1PEhhjAUarpxLsz/dzQ2nx+5CRrhHNyoAb765r33FrSBLNFCzRh86N+G
         hs6CfIpW2mf0Oi0YshQ5vbz8SdmW0ePcRjHnZpBqKUUGsXip8dYktnA8REVJHQrMq9lN
         Y3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785445802; x=1786050602;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lMLsf+LQaJK9TyVbvhOADIYNpgfmalBwRgJCFWQKWPY=;
        b=Q2EI2ksdm0h+HW3CBuCwr96FDO6U/7bfs+31NGC0HfVCkTIO25DehYjXBiVC81/Ugn
         NKhHhldb/yo78V9SvXgWKhcsNTZ0AmVQbfTXHuxFUBi+KddzFpYMJ1TE0QJ3z6guWpa+
         UjypyTq/Ehi4h9U7r5fvyT634g2gEFVYjyhd8x9yCdCDMCyA3ikK4xpCoINAMJIeDFUU
         lRjeluuuPy/474K2DAzamxIsGeTtAf8dO9+2RMAs3rrO1Y2ptLsPxnoxIIvvy2YdFRJD
         n3iDftvPvaGvjPs+sY3Tmn8x69ImRinhCPOKNIoMWyVGRLVtxYVq3jA97AD9j7nD8KA7
         4Gug==
X-Forwarded-Encrypted: i=1; AHgh+RpgSUX5EzdkOamS8abWnHdfmemeGcPiysGa8SeJVjQATbhKm/Vh2A4gqGq+4ytClz+ZjTeK9NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcG2x1uz3fsZop57JsmF0ESpI9o/82UjnL1Rl9k3yUc9xqPPzY
	2sc0VKGNKq7uRXnj+Lj5cBhxGpvznQXXExy3fPkfRsf9rh+JjF4BS1wD3wUslf4yuw==
X-Gm-Gg: AR+sD11FkW/HNve0ZNXJZoizppjDSJxzVMfSCV5YbBkQlgA4jXVA13mG06YM1b4j5dY
	DSobXCnmgiB+5XLDmE2zrQyQLnG/pI2njFSqwfiKhmQGWgfA0RfIC0YtdUYKrjvQLw1MX8xp881
	yDM1MrJ4mn1Yi/f61zTZKY5oIGuLSbklGuhyJrNbqzb7p1tjCM9XZZxcU/RHECW3P/7WTAcPVQ4
	QRT5fVFymVC/IPfmSNnedsc840JsiM7sJCTjVxI8pBIYV5A8RFCKyDBUcBmHZbBG3XPErOHMNLc
	ov/QIR0drgT73ab2JGV/jDjKvevwFTGRhq62pfBd4uOWCmgykL8irB0FH0k2o2pFIR6STAyQ5Vc
	qwstAnH5+dh9iBHgj8Pdu6VNKEh0zoBDxxIgAzZcPrYt23EtOjLztEYO9PyNTg2Wz7Rdn2Q0N6v
	Cpu/7MewvixVrbl9szVC5QJp9po8qmNSmgeJ13bJhdlhQwlE170x7UsovGjZ5xzNUeSZ8XJKSOP
	7bvTbJZmB0r94cInR1zU8+AtbWzIYG3VkfHrHQOBriL
X-Received: by 2002:ac8:7e81:0:b0:51c:1d18:2fe9 with SMTP id d75a77b69052e-52b3836970emr48411021cf.5.1785445802045;
        Thu, 30 Jul 2026 14:10:02 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9083fdbc35fsm1954776d6.24.2026.07.30.14.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:10:00 -0700 (PDT)
Date: Thu, 30 Jul 2026 17:10:00 -0400
Message-ID: <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260729_1758/pstg-lib:20260730_1437/pstg-pwork:20260729_1758
From: Paul Moore <paul@paul-moore.com>
To: Carlos Llamas <cmllamas@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Christian Brauner (Amutable)" <brauner@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org, Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org, "open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, "open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH] selinux: bpf: check SBLABEL_MNT before isec init
References: <20260730181008.3654413-1-cmllamas@google.com>
In-Reply-To: <20260730181008.3654413-1-cmllamas@google.com>

On Jul 30, 2026 Carlos Llamas <cmllamas@google.com> wrote:
> 
> selinux_inode_init_security() marks the isec as initialized before
> checking if mount labeling is supported (SBLABEL_MNT). This was fine
> until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> xattrs) and yet leave the isec->initialized. This breaks subsequent
> calls to inode_doinit_with_dentry().
> 
> Do the SBLABEL_MNT check before the inode security is initialized.
> 
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8d6945edae7a..09a12eb8652c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2980,6 +2980,10 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  	if (rc)
>  		return rc;
>  
> +	if (!selinux_initialized() ||
> +	    !(sbsec->flags & SBLABEL_MNT))
> +		return -EOPNOTSUPP;

If we're moving this check, we should probably just move it to right
after we assign 'sbsec' at the top of the function.  The calls to
inode_mode_to_security() and selinux_determine_inode_label() aren't
doing anything useful in either the !selinux_initialized() or !SBLABEL_MNT
cases so let's avoid the unnecessary work.

>  	/* Possibly defer initialization to selinux_complete_init. */
>  	if (sbsec->flags & SE_SBINITIALIZED) {
>  		struct inode_security_struct *isec = selinux_inode(inode);
> @@ -2988,10 +2992,6 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  		isec->initialized = LABEL_INITIALIZED;
>  	}
>  
> -	if (!selinux_initialized() ||
> -	    !(sbsec->flags & SBLABEL_MNT))
> -		return -EOPNOTSUPP;
> -
>  	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
>  	if (xattr) {
>  		rc = security_sid_to_context_force(newsid,
> -- 
> 2.55.0.508.g3f0d502094-goog

--
paul-moore.com
