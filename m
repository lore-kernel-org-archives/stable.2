Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80C390223
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045450; cv=pass; b=tyTK73+22hyB4ltlvnwk56C2uh/4uCvhG3ByZ4XaJZDHXs3OMdx14QCK9Z5hJtuv/rz8Efxj4rrmDWwW1ZCKERWlfmE+sZUM0sZpLXubq5DmMF9HbiOT/tgpwdc0+fVF3y9Koe010NcSivWYLDiwfHx7Hcam3LH0ID6S+cjcZ2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045450; c=relaxed/simple;
	bh=9seE7DdQbFb9HiabltP2bn/Px47uFUhhhOnC7opdhaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmwZKCk3+AH5PjMAW31KXwB18DcZgIA8wO3qa0IgaEU/9/kXz2+fMaheMAz9oMxdIfnBMT/qC4VURtEB25TekGsJz7OoEgaEGuI2J5W5ds+5zZ8UcRfakaDpaISg6Y2gvG1gzFlimijcgU3iZjWAmFLLWARAKXEG3iT7raEzT0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQwaIh6g; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQwaIh6g"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aae3147so2644294d50.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790045447; cv=none;
        d=google.com; s=arc-20260327;
        b=ANPQ+ojc1v7axhmBxfXi2u4KMbYsuUkQR00tP7khFIbW2X2dhcOA90BLE6tFlzQshF
         58qM0A6EjwMxbqfU1/EliJCrQUpdp/twg+aAQtIm2dkMPtxMHdEunrEPuQEkJ7GaPSu5
         +N1OKdToGG0r85jVRTiYA2OdCLRo7QnZThsvITtYWjSiZVbKPQbtOuWWCQVATFCfPBbU
         B4R44L+/6Ce59m7hp0C7Tys4QpBsGjUaEky9s+eTpSfyVP/TNKJMmXz/qo6XZov7DjxW
         GTwFw7X/Fh4Hm1zO3cAbeC6QmcEs+mMVgGBJ+NRJGd5+IYZmo9Vc2GR5Ss988DJFfWyo
         Gt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PuG/mOTULDlFBdQPJWs+1DVH0LGf45HnPczNNq/pztc=;
        fh=kBdl8I2RJSJLCSqYtMc7+kBIWWNt5j4hMuWUVSN7hI8=;
        b=NM7v/uG3cmgWJbSZLa8HkB1opT9qVBtF3lYWueG4Ql1QlUbBxowYowSVLxoBxDM/FN
         j3Wq6OAKeEHgGxP8neoiEdxjd22slRGrApfAp3Ct3UATwlM1TkYRqcnkJIOHPimDWv6G
         /UOEzvt1Y1eqEHQpAsppQKComhH4pAKPB1xz5ABbUenvvPbP02MNPrs8HkdKAu+cNo4i
         IeD1LI5nvanMTsSWTIAgZVOjxOY4wcqhNGOwPZY0rb/JVSe2YZs+fu9iJutZlTJ0RGqR
         T4DeB5N1Vo50cbO/mxgnwA7URSGvg9y/Ql/0D7iFOmsaZofXQ3YnXNzTXXNHmYkxcHqI
         0+sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790045447; x=1790650247; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PuG/mOTULDlFBdQPJWs+1DVH0LGf45HnPczNNq/pztc=;
        b=hQwaIh6gJZv0U3Pc0WcTl3biDBwWXnovJwhS420V1vgGJRxdzkeZ1EuDk04OQkh3O3
         EW55N0B9NP5fiB2rZ37fQoRGRKVPE5ppPLIVgwy38P5VKM9c9X51S5SmvfFq1ep7HZic
         B/3BIWVepPEhGsEvOUWuyW/C5Cp79VW8kuVuAu0b/KfixQgr8fiIxB6/wzEA9TYZMYP5
         J/jZiChLpM26ek5Fv3CsH4E7ZYUSbH1v2pEu69nKhSSpu9+B3BDDLt9qm8Z2IwkAsmY8
         rHIs0f471PPnmPxwwaUhNJdsZkZU9ZAMpXIS/sXmn/cBndjlcEEec1NigufxTDyIJPWe
         CwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045447; x=1790650247;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PuG/mOTULDlFBdQPJWs+1DVH0LGf45HnPczNNq/pztc=;
        b=UoRS0nk6kZ3y0iMlkwnFCqvRbXPDlUOICFjMUz3tKtNDFDRB278uM4PzCg/Lyvbj1Q
         W2FyTS2QDibErY2Qy4NcbAk7bNq62ytKvXUJR3wCwggKvrjZeoZQLeqJz+OCS5hTrdZi
         NKlpXFyqZxPUdO0O5f3e5cdWg8E4kkjcQsEdWCSyf0Yn/WLC1UgTLGHjDFHJozZhF3n+
         2brovWLZppHPy61Y7PZGXR7fuegkpBA+c9r1bHDVRk7vFPsr1PCPbmSKeRlPFHgMUozg
         w4Z7ITo1Gp3HlgdyLmN/M0escShremrfEumvzzCRZ4d7QGTpXikrTBKP1eXBjipjvnW4
         wp0w==
X-Forwarded-Encrypted: i=1; AKwUvBxOXeTscoAr8aI4t7HJg3gtHKG1kQ2SGlCKTac7h7Ufh+/aR8ivyIXCtmB4XsQWIVvV/hMSjZ4=@vger.kernel.org
X-Gm-Message-State: AFuF++ms8n6fnXDXsq+eslrUKb0L7AuIe4U1Osw3npr/F6TAEqdoFhod
	OchgyG6wcqzjNghPfZFmI00fEDmEsza0CTpjsBw/0Xz20AC60z6M/zZrImnwY6Xrt8i6lM6Zlt7
	Oe+Q0HZsG1xmPb6URITY3+Dw9UECah6o=
X-Gm-Gg: AYBFou3pkOKtfrFqvAcprW/WwGzYZbDQ5WkooPFSezCRQaPGVY725tM8owOnoxn67MF
	ovuewC3rwmvRxKBpwbcsqO2o3sHOl+4/25YTsbtbQm4OkceZtdY1L4D/dulv/ijOpHaysOmDBQn
	l4i1DRK+jaX3R0DoXI/46erbdIDneeBStZrlRTi9F24NlucbJSiO+cGT3+HsSRgGl7g3H5qGuMR
	lH1bwgbuENHa30sqNxolU9nh8EDnFP+dBaHMzU5a7sv/f1UO44VeStwYOJS8XY96lMJjaB/1JWx
	OTsUUcJ0mMin/3P3PGZTugcXRj1v3K4arhpOAirlqOqORJeF48E55K8EfA==
X-Received: by 2002:a05:690e:4385:b0:671:c5e:6d5 with SMTP id
 956f58d0204a3-6717fcb6779mr2611942d50.4.1790045447318; Mon, 21 Sep 2026
 19:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918181326.3633765-1-lgs201920130244@gmail.com> <arFJiC1JGB0KpoLn@quoll>
In-Reply-To: <arFJiC1JGB0KpoLn@quoll>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 10:50:33 +0800
X-Gm-Features: AcwNN1W51HQHgqXq96H1vY74mor976BD85GOPWHnSJHN_BwJ54ajJuhACadQQO0
Message-ID: <CANUHTR9JgmyoCp3hcTbBn-NnUzjKFW_LaRHcrsY9qZbGvxAcNg@mail.gmail.com>
Subject: Re: [PATCH] scsi: efct: clear MWI on remove
To: krzk@kernel.org
Cc: target-devel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	Ram Vegesna <ram.vegesna@broadcom.com>, Kees Cook <kees@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Daniel Wagner <dwagner@suse.de>, 
	James Smart <jsmart2021@gmail.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Hannes Reinecke <hare@suse.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for your feedback.

On Mon, 21 Sept 2026 at 23:13, <krzk@kernel.org> wrote:
>
>
> On Sat, 19 Sep 2026 02:13:26 +0800, Guangshuo Li wrote:
> > efct_pci_probe() enables PCI Memory-Write-Invalidate with pci_set_mwi().
> > The probe failure path clears this state with pci_clear_mwi(), but the
> > normal remove path does not perform the corresponding cleanup.
> >
> > pci_disable_device() only disables PCI bus mastering and does not clear
> > the PCI_COMMAND_INVALIDATE bit. As a result, the MWI configuration can
> > remain enabled after the driver is removed.
> >
> > Call pci_clear_mwi() in efct_pci_remove(), matching the probe error
> > path.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 4df84e8466242 ("scsi: elx: efct: Driver initialization routines")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/scsi/elx/efct/efct_driver.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
>
> You sent multiple independent patches, to multiple independent
> subsystems. The amount of these patches clearly suggest this was
> AI generated and most likely not tested.
>
> More importantly, you sent all this work without properly organizing
> relevant patches into patchsets. This makes reviewing difficult
> and might cause multiple reviewers to address the same issue.
> Replying to the entire set is impossible and requires handling each
> patch independently, instead of applying or discarding the set.
> Maintainers also won't see the bigger picture of your work. Quite
> worrying.
>
> This is on the verge of hostile patch: bomb us with so many
> contributions, we won't be able to handle them in efficient manner,
> like responding ONCE to ask you to slow down.  Considering all this
> is untested and LLM generated, I have even more doubts whether this
> should be considered for review.
>
> Please read kernel documentation BEFORE posting more work. It will
> explain you how to identify subsystems, how to organize your work per
> subsystem, how to document usage of LLM and how what you should not
> do if this was posted in a good faith.
>
> Best regards,
> Krzysztof
>
>
>

I would like to clarify that these patches were manually reviewed and
audited by us; they were not simply generated and submitted by an LLM.
However, I understand why the recent submission pattern may have given
that impression. We sent too many patches in a short period of time,
and we also failed to respond to some discussions in a timely manner,
which made the situation look worse.

Many of the recent patches, especially the v2 revisions, are
corrections and improvements based on previous review feedback rather
than completely new untested changes. That said, we recognize that the
way we submitted them increased the burden on maintainers and
reviewers.

We apologize for the pressure this caused to the community. We will be
more careful about organizing patches by subsystem, preparing proper
patchsets, and following the kernel contribution guidelines before
sending future work.

Thank you again for pointing this out.

Best regards,
Guangshuo
