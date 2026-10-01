Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23EB33F59A
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898266; cv=pass; b=QuG0rB1bPOolEwxSkjjzUjtK5GbCGD0tdjSwRp+9DLVvqBJNGgG9uidueqf8HJ8N7eAcaFNhIe1BGA6vKiISsOxz2GZJnbf4YIM/1gMpLLgV+RlGgX5xakGn0sS+oj5J7/SJBWF41HGTvZdSQ0SebX478BpVO0A06YtK3k+fJjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898266; c=relaxed/simple;
	bh=o2g104Wfo69c4modhI8ohmf9z/HmP117IrUmXcvK64w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqpqIrTatzLhJCa3/ObmpL8gjJ92KX+heeYc63+NonsjSzS3oWef+aL/TQ1DSrRFVutRzWSkXlJ17aX6Jp3AllM23z//Bty5KmYpyHTuMSRDrK18142gsVyGM5njH1OTUEAXtyXTBJd3xO4Hwn1C9t3An7DuFFhGhYlw+HO9TKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7k8lgpj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kRvG/Q44; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7k8lgpj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kRvG/Q44"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790898259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7C0wO41olnFgIkFyxcI/7Fxg3q/LgyAQWGzA9515Wqo=;
	b=L7k8lgpjPfQ4U08ZDxxh1RWHn7gZa2cwZlFUnOGiB8tRhXiu8tSKmPiW5rUBFewv2cmARf
	xx65QXSgWPv+20Dni95J0YSP+aImdsNuYt756crNOJ1j/2dNbNSbT4ktSevk3yBTWLaptG
	N7eXnZDX+Ux0j04b6KF/kwRvcFSpP9c=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-92McFd2UNp6WXdgH24mfNw-1; Thu, 01 Oct 2026 19:44:14 -0400
X-MC-Unique: 92McFd2UNp6WXdgH24mfNw-1
X-Mimecast-MFC-AGG-ID: 92McFd2UNp6WXdgH24mfNw_1790898251
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3a64e917254so43683761fa.2
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 16:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790898250; cv=none;
        d=google.com; s=arc-20260327;
        b=TV4biY/4ngrBU891yi8tZ40rMh33zcRxrTanvq3FoA0+Th3+9ffra2Au8Csq6JcWjs
         934fgHCLsqLLV5WGv97i5rO6xNsYzsR7FvNPsCLy1JB5KrGsHWxxycVtfarkn/DNRquz
         OlGda0BqDxls7tkZc/11KpoNlMaX2G/sSovPzXZm5xkD2PVVgA2MY0MzBMMA6yvwGvAg
         rVUMu7ATOhJt8DpGNs1MnJccVmqkcEkPKeouAndJmvQ2UHnoJfA2ZHvyKK9I087KjU3o
         02lOIVqO3NhTtilGjl5aIIJOPsQ6+np2WA71DemUFTivkCHFf9nLb/Q6G4fNffoNpd4a
         V1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7C0wO41olnFgIkFyxcI/7Fxg3q/LgyAQWGzA9515Wqo=;
        fh=GWoZ4ot0uMlctsB9UpD/+voJbp8++aW4hnT4vv7TIkQ=;
        b=Qy8sFLmHJ/n9+rSlNYfnBnadlgescoqRACTPLapw/kI76f3n6Y/Ll0IYMGCpshaw44
         BZKiuhU5BSQYHVbvmmDLwAELbv2el86N78xbHeWxkNLmL5ZQeSQEnd+aNdQntZYunZSK
         z6Sf46YGO/JSv8qw1xW9lkI4zdK7BQNHaqjKXdz7ry/azXvgAiGRAEBkdl0GJW9+8YP+
         VacMng+d+UhFF6h3UqN7B5rC6nR/q8DD70xs33kKSrHkiKotza/ENEHss5WSB6rhPMEp
         JVPRxCjsrSA3BZK40PMxXNZapNLATnWTXMD8RyCAQoMYNSgCGpjIbbANgKEo6EjFOBZD
         A/Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790898250; x=1791503050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7C0wO41olnFgIkFyxcI/7Fxg3q/LgyAQWGzA9515Wqo=;
        b=kRvG/Q44Mcxy9Q+bEiiQ29xWdD02nPuXEPkTe1VbqWDq+FbljtgK8wpV3kuPLiSjiy
         lMhckjmcd7yYtKHchWqPltgqx0Brmo8yOHZk+aQ5xNm2Aj77WqgJEpCQEkGv1Yzvb0Nd
         18Z0C+cC+TKyWYm2aEigciayDYGUq0VJyct5QyvxOiQnXUhR5xM8zIaLyrc21AoMTC7u
         Q0yFeDIqm1YHOyVKBu01gJBZX8aNVSOjmuhqEjrewKFkKxriBPpFRp1tc7qJMppaup36
         foEab+I+BY86GVZwDzFle2361vfism9JvIn9yTD4FBa17b/h8HBlEejuVWRNQ5tTujXs
         48ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790898250; x=1791503050;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7C0wO41olnFgIkFyxcI/7Fxg3q/LgyAQWGzA9515Wqo=;
        b=eiUJFcxYti+YZxdcmg5qfrXQq3ayzlB1VlZdDBYPT+WhlSV11Ylo7dXOWRmUKoCli5
         hlnrRfSRycFlUpqVn4VSrda8651Ddi5NpULtVN1coa+2xotIonkWkxjLLejXzYw+A6uH
         69uoEDvTMIkUIkyF7p/EtAVFv94brp0D7RyFp+szpu5rPntRcuGSbznKuMFpDgNoNs5N
         FLfzS924lLPQ9+BdJYPcjoQIFwZCDSf00gbjbAs/tLoYFRQvJzl/9MZxGS5zHxI/PI1y
         ZEMX+CEtta/M6CV8D6iyeEAoU392rRkMYF9w8YdbcCgbH5g8tPP3BD1wpAc0RZKBmdhN
         4teQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/fLtvCAGkIXAJEefecFmjz5nMcwWzdRXFupaxi87LZ+vQbGDkkYxiZ9akc5B9/YN21n5w2Zo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLsWs+0rykj2Ruj9tWNmQA1KQxbbVJq10rmig0AF2m6S7SEx4x
	A4vknoYG5aCFgv6bKVAFuOqAEeAGTDM12DdBMr76ci4ZTC+uhkl4Y60G9grrpprzHNQZpTEVEvO
	qX7NmlqWySQqNeSWTCWhnDrwZd88REv6t3Wo3B5jHC9jEN23WY5AVtUPg6q/aOxHN87H1KnlD4m
	OeBiZYAw1DZeV3cdEKyVDB1iOMT61ZjU1X
X-Gm-Gg: AYBFou0NTeo0PmIe/tCtyf4TBcweZkeFKCsrpuA4SVsjP7CrrM/H3kGWL13e5eX6FD7
	bEL65OEjaVxQhHAICr32JQx4jBYt7xA5d4XxSbGvnG4FXmzgnTDH0e+mwu8xz3plwgGnQs7/NIK
	ZVsSg9C1b7RY8ezfWPLSRLbrXxxhHDFnaHSTfxV0iLXOLM7ylCjDnBiUrV
X-Received: by 2002:a2e:bc29:0:b0:3a5:d070:9fef with SMTP id 38308e7fff4ca-3a887787567mr1692541fa.10.1790898250535;
        Thu, 01 Oct 2026 16:44:10 -0700 (PDT)
X-Received: by 2002:a2e:bc29:0:b0:3a5:d070:9fef with SMTP id
 38308e7fff4ca-3a887787567mr1692511fa.10.1790898250148; Thu, 01 Oct 2026
 16:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911065357.3511466-1-ljp1205831794@gmail.com>
In-Reply-To: <20260911065357.3511466-1-ljp1205831794@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 1 Oct 2026 19:43:59 -0400
X-Gm-Features: AclHuK8B2IlGXv-cagMI52YwLUQveVZTRqqkPPRuJDKafJ4tVysX2bs9w7uZ4e4
Message-ID: <CAK-6q+iB2jjvKN+p5WmMap3znWPUhXXT0dRsCFK5BcAXBJRRuA@mail.gmail.com>
Subject: Re: [PATCH] dlm: fix RCOM_LOOKUP length underflow
To: Aohan Mei <ljp1205831794@gmail.com>
Cc: gfs2@lists.linux.dev, teigland@redhat.com, linux-kernel@vger.kernel.org, 
	Aohan Mei <henrymei@tencent.com>, TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 11, 2026 at 2:54=E2=80=AFAM Aohan Mei <ljp1205831794@gmail.com>=
 wrote:
>
> From: Aohan Mei <henrymei@tencent.com>
>
> receive_rcom_lookup() derives the resource name length from the
> peer-supplied 16-bit h_length header field:
>
>     int len =3D le16_to_cpu(rc_in->rc_header.h_length) -
>               sizeof(struct dlm_rcom);
>
> The 3.1 receive path only bounds h_length to the range
> [sizeof(struct dlm_header), DLM_MAX_SOCKET_BUFSIZE] in
> dlm_validate_incoming_buffer(), and the RCOM case in
> dlm_midcomms_receive_buffer_3_1() performs no further length check
> despite its "length already checked" comment.  A peer can therefore
> send an RCOM_LOOKUP message whose h_length is smaller than
> sizeof(struct dlm_rcom) (48).  The subtraction is evaluated in size_t
> arithmetic and wraps, and the result is assigned to an int as a
> negative value.
>
> Both consumers of that length only guard the upper bound
> (len > DLM_RESNAME_MAXLEN), which a negative len passes as a signed
> comparison:
>
> - with rc_id =3D=3D 0xffffffff, len reaches dlm_dump_rsb_name() ->
>   dlm_search_rsb_tree(), where memcpy() converts it to a huge size_t
>   and overflows the on-stack 64-byte key buffer;

This case is already covered in dlm/next. [0]

> - otherwise len reaches dlm_master_lookup() -> _dlm_master_lookup(),
>   where jhash() converts it to a huge u32 and reads out of bounds.
>

This case is partially covered but lacks a check for negative values.
Can you send a patch to change it to unsigned int? [1]

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git/=
tree/fs/dlm/lock.c?h=3Dnext#n632
[1] https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git/=
tree/fs/dlm/lock.c?h=3Dnext#n1273

