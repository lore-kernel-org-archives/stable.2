Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39092340411
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112758; cv=pass; b=fRSIEr+IvEZ5mk1JefSxGKpsjXQxNbr7o/ZANURpADUc0YIzMLX87xyDwb9vt7M/tzG3ALaiQ8OGvY/37YqinAgOua+uhqw8RAO6Jq4ge6IPRS17f//QCXkPB+XmToDNe9RoHoquOoDr7Pc6CkYEgo+FNUNolZdmXkFGq89bIXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112758; c=relaxed/simple;
	bh=pv27nD72m+0lU+Zg8Sfz05ZN+Nn05pr71ShMvkiRWec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niSvW0ftxJeBQiUpjcn+q+IygrDA56E+t6fS3b+bIW2lnBvYLoLnUBrVr2NO9Xwz6VpsMotpI+/Z9TCjvny2FnlyVye1JdJFLlClqKFmkDcUqJW/Y7zTvz8+82R+32Eqziy7dx2XJxGygcmFD+H733r7eFT2NSKn4XxOUQrFsOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP7Dn7GQ; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP7Dn7GQ"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6606d5900dbso2756354d50.2
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 10:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781112756; cv=none;
        d=google.com; s=arc-20240605;
        b=h2PnaP5QIfkvmxn1p01UmebZ31nu4pDofUhi+imJnqH2wbPsVYImUj02iXuSlehPGo
         LhGP3810cisAySHCylAo++xlLF90OV9tjlgc9/IXkQ2zl+3ZhrnEpMsVy8aftNfGjMLQ
         gifzpWelXO26ILMzSltjq/2RD9sxl3FhI7rp1UXe72WwxUL+5QDtZKfPm3u0gTbXYRmx
         WO4jGy2Eb53xJmPMDGc75O4cNVg52RqEYyABGyKVUf6nRHH1aHSvU5/qSXb2ttQp2w9Q
         6iujqPwPnWw3owFkoMn5DNYCQdGqIkWF+mwe6mYzLvL4zvvDBeSCauw6YWosPvFGxOe+
         c2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TwPccAVt1qmj9UT4eXbvYpUbw68SGsfYYMuRUSdO1Mw=;
        fh=JQKIzIx3CuGvxnVpqT8nvOZT+vrAAdq/0DauXgCf28k=;
        b=dQMPCOpFHkHHgP5pyLh/0j3ODWMWutH45wshGbF8jfwtJtyIt9BTQHtUnSZQo4XI3Z
         qsmRDoa4iUbC6t+q1UCATzCJZBVrQrFiya++yFLwujZjpZVVYsaTMyYjcCbBGc05fDMC
         0Jtw4pE66YclWBG5Woyo26P5rSqEAQbzQuVf+Kt9p0O1VNRYWIsl70snGVeViCsAypdV
         DeM7CwbG5Xa+vgjrTK+pZxvESXHrzxDuInlaW7aMYEovglwM/GjkDq09CF1FEYkdeshO
         h0Dg+vhlGy5BnwqvgtwLLGvEQHN+6fonj6E2efoI667kjDBWVKf/A6zAnuXwHVNbcCBr
         FqJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781112756; x=1781717556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwPccAVt1qmj9UT4eXbvYpUbw68SGsfYYMuRUSdO1Mw=;
        b=KP7Dn7GQBNvb471v+u4CUHwOVL5SvkytqQzQ7g6dm7yTO6JGqxI95SdH5pS2+P8HW/
         kE/Pu26RsRA5Gudt+TtWrBANl/gqH7E5hhy2tiFS/vOLkCdww4mMtOchzTSiq/zd7YaQ
         rTe/PebNxpzavdzds/3A2j4caXPCgRzexSiia1vGnmv0EsfOERiGEvfAQBVknXfVF82t
         zWE0OS9LOJBpAIeXu3QEczdsfvBQ1oIBXHc0QLKHxUm1mTMW/KYMZkCudsPegrtGwPUL
         FGk8I1q0j3+F3GPT5oEfpdLS5f4YObwvXCBxTJxeMN7XzNyOXUiLZp8cVQXczDGMA89z
         +a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781112756; x=1781717556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TwPccAVt1qmj9UT4eXbvYpUbw68SGsfYYMuRUSdO1Mw=;
        b=RuM3m3GvQxIHd9IiN/Zs2fn2W6w+uomQ1JhShH+0yRHtYiG/AOaJFyB4A12dzhp4jI
         0jkKhnRMSbrNFQT40e7DnZJIt8BxUj+xLQbn+rg6uS0sVRk2+KVMFTUgKXJZRu56qYGG
         zDv0Eknuebb57k+oF3FQJEk0eB2tXpqib8QoTfKJZT7l42f/DeImVbokkLE6fRelq/uI
         7s5PHsHvNtHeaVCvsrkxXM4V8bnVncbkgddSMTk6Gnit5d71sWaEF/CY8BwxjrcgH0oK
         qLubUD4PjDoi/K6ufLDFFYDbQJhETSnxlxUx5MwrkGwQdiz+/FOQS9bXb6wj7TItn1Z/
         3RnA==
X-Forwarded-Encrypted: i=1; AFNElJ/XN5sqB931NeX296xsQxxqZyObECX2yBQvv8RKDJug7ory/SIb2btWxqlZrgw68sc9ZYkCUmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSNS542noFL79jqeNWf53jt9MYKo6HT6GsDSuhuI9hQab1xLFv
	EB4sGv9bR47nAPDMSGuCCAs62HHzaqrGue21ta9z27gYlNkpuzjUAiOYpLhMmWsA0SJ2XD43Sq2
	qTfRmdV7XEVF3AMQ9fuNmZQAtMfMsJM8=
X-Gm-Gg: Acq92OEHsejBYvCfcXhVTXJ5K+UcmRBFsVSnJJnm9CJ0JHw4UeM/99M4gLdNcYDaqPl
	LgptSVefya2ONjMAQ4Ldcngn0W/yRJ32w74U4xjQl3clbuITqCtW1kGL4c8QaJnWwSbc0RLTyGk
	w6s4ApxJ7KRfD2DwQcrSvdcwpUMEDMd/UmEyeJCDRXGwcFw3T7p/ZffU7GyUoULB2ntKWMChk4l
	V7oIZ8AUtag4m1sVX0tkhRpvLLcy5+T/9k2/5gMdfCGY3BmXBXXUsMazgBCboYVURbrCox9jPKR
	6CtKi3TaGHoz0kpJ/vowx/tKgfCSlyf6+cc9loiJJh1B8+g=
X-Received: by 2002:a05:690e:d45:b0:652:ddea:1679 with SMTP id
 956f58d0204a3-6626582c171mr122992d50.16.1781112756029; Wed, 10 Jun 2026
 10:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610114120.3748526-1-michael.bommarito@gmail.com> <CABPRKS_HbtV5vWx5nHT9rwJV4TGmOPj670yUuLK-Hd-r6TBF1g@mail.gmail.com>
In-Reply-To: <CABPRKS_HbtV5vWx5nHT9rwJV4TGmOPj670yUuLK-Hd-r6TBF1g@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 10 Jun 2026 13:32:24 -0400
X-Gm-Features: AVVi8CcXqdpLUnD172xmFbgGPxwwTP7xSfHNWUNfDHYPtVKWYaJD2heVrYF3UV4
Message-ID: <CAJJ9bXxMvSfzttjiRATN1vkVP9-RyyH-P6O4yMwVJGcpZVOCFg@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: bound RPL ACC payload size to the response structure
To: Justin Tee <justintee8345@gmail.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Paul Ely <paul.ely@broadcom.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 1:29=E2=80=AFPM Justin Tee <justintee8345@gmail.com=
> wrote:
> Thanks for bringing this to attention.  The RPL ELS command has been
> obsoleted from Fibre Channel specifications since FC-LS-2, and there
> are current plans to remove RPL ELS handling routines from the lpfc
> driver entirely.  Therefore, the issue this patch is trying to address
> will no longer exist by the next lpfc version update.

Glad to hear!

Will you be sending the refactor through stable@ to backport too?  I'm
not sure how this works if there might be reasons to backport but
obviously next+ are safe

Thanks,
Mike
