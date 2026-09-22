Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D52E2663
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043197; cv=pass; b=H+suiDLBF1VcldZSjp/iSNVvyhHFmSYrQJu3oJlM8/Wz4wIXA80NiaY6Bm9hG5KZtn+F2rkLgLTrzIPyx5R/A/tkFNONtJTuIs4x0U+mnJXqxVQnNBTtLGu1qj1FYQP+9VHykBUm3b16smhNakUqeekQNcOEfIsOEKypN2/0Hn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043197; c=relaxed/simple;
	bh=vl44nk+GAHuCfD2I3sOCz7xvvreFR6dp4SQQQMUUpag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0cPsHtuI8prD1ifaH3a4Gpl2bjk8tAKgzz8rqZBfaH4+qy023ysQjKfvRoEbfkx5phH0gzcApr13Y6pLNBZ4yO0PXMQ9uCXiuP4XZP/YXyP2KBNaSY5IgmtE6FV2KYbOyUxLe+b84JcVty7m9gDmZlkcmA3MTdy7HX4qrbYkhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gefxirmo; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gefxirmo"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab22370so2719832d50.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790043194; cv=none;
        d=google.com; s=arc-20260327;
        b=hCXmQIT2f5cBTVTsZ/L7OEGZo5R4A6/3K2be6hv3tFoySQHxmjbuywL0L9JyloDobG
         Y72KJM4kRop45deuOm1amg3YIrCDsZHjDlBKa6Oc3YIGxK7pDeLIDM4skQiggyW8E8U8
         WMB8CpYCUo6+efwm+fy2NNyoT8opK4VnZwC4IXGlnVHWjv/6ZxwyB36cKqLnlOqGtqZZ
         DM1Du3OMeOEKo6mjIm3B1IUDM9uf53nTPqZ4dMtoWMR1gBlD7t2WZc/NCoclXRDQ3tvi
         azrAhnVFZdUwqsri9VndNepRKXt7+5Y8okYgTSBzhi8XHr2JkDTZAEiccd3S1mc4HKmq
         XaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ULHj23OU+X4saT6RzcQcJjlqgQV+yT9LbYfIN+JAXJU=;
        fh=kKVBY+uR/R6L7/alUlPFLcvM4h0XYjedZ3KFTeUaDKE=;
        b=ovuDh5ZhERJp/cJxDdc4GUb5NHbB3vCXvvOO7AO5NAm3/iXa0plGF83O1keAUVUnvR
         PRhFTQhihPGFTduBmb7zw/dWVt/iXOHf59dJilRv2VzdfyVUywQGLf9sjRE3y9w8R80l
         JbEEAiOeICpo1I4n2sETvJZt1mc8zS3q2I41HaEG0EEwuYe4QuNtoX9uDUT7YjSXjUXR
         bj6WepC845wmkPXXqjFDQ32xvT0IPy2O39qeyGBxvU2lLhk+ZwdGA3L3K66F2xmZYuvH
         Gc99i4R9bb0ZVfPYqXIC98FV3JCc1apAmimQo3a0+j+lOAzZlzE0JJbyDBo3pHGpAURS
         6Nfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790043194; x=1790647994; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ULHj23OU+X4saT6RzcQcJjlqgQV+yT9LbYfIN+JAXJU=;
        b=GefxirmoIahOb17JKEMzsKUtboJaX1sxPgU25KUMJ2I8Q949GZwm1O5rUNbaKhcMmR
         G7ejMkrNgl4Llqtzi5AwEDkmCaw4spn/jYZO42Io6y3B3EUng8uFehBHjLpyZRnG6Gt+
         mcXBKSNRle0nqZq8ZqQynriovAw4Xc/9K0P2vrRJVLOwSEYMBNIEOKzHTWNNAbAGY6DO
         lZjmmuYxXggvoQ8RDhIrpMGstI/gC8gWoZ37yZe0U8skK3OQXhyJjdmV9uXFo89lQAs3
         Lb6Lhe7vX9Q0yhFmEhjAEOMGcbVq8abuK9DLTF3ognFuKVso/4U8Vg11A+0wAcI9IUuC
         lnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790043194; x=1790647994;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ULHj23OU+X4saT6RzcQcJjlqgQV+yT9LbYfIN+JAXJU=;
        b=STYUOmr8kttW4H4FaTYlhV8S8Voj8TTcpeLAR08sKdEkcT+dvXiWxXPpZl7cbqk26w
         KbLby/dfkoBj+rMXFxXQLXOgDO/OJaPKl9r1k1/PCWq4R69Vkjrj5J1ZfS0z8Nhe6Ba+
         0t9l4xcmqz8EF1BDoyzO/48HbQ586vWgACn3fvgIMoX9FPGMaL30tDeVXTECIXfw3nYJ
         2yv1wstlSYABcyFnanoBLrXsfABpzUDawcLksGww2surp83pwJalic86N9ip4Oba9euT
         uNfoGm3IpyKfefNCUKjEJQyd4ep0YQIY6J/L4R59ukBd/WJyJRVhPp8e9dIzDVnu60Dv
         QKJA==
X-Forwarded-Encrypted: i=1; AKwUvBxwxfQyGr+WkOsLUhzZ0IDX7GEOcck375lEvTyEuGU+h5NzVOtcziBec/iPqWQE1roxE943Kjo=@vger.kernel.org
X-Gm-Message-State: AFuF++lTY909MJvqVlckg2BIHuEuvCe4R0/SZwyJKTzC9RnYE5tKIHq3
	91Fpjzj9e11qSWd9ctG2KUFTWe2RMnHjKPSrg06kvw3ifIfskM00Wmt4hVJk2IdWKhxbZgaw0EE
	JGQhGOXDYL37xlvmjPhz3oYsKP/Bmutw=
X-Gm-Gg: AYBFou2f/wmkBsa15LQEpTmcmjAVq55JtU+Br53qzEL+8Ml2B7pouXb2ZQB0JnUdnJ8
	LaBpB35gvLoh9ItPHIwJgYYlBymzxAzsxtgzdLQr7C4hMmj1VV5VLJgECwP2Sbj9TAC/4/zo8Mw
	lisNOsVDXqIvLbFrJAPWwNqzyG/NeWFukxxnBuEyyjBDqifOyIbVjwK2dj8wsFA0zFkp7WHVNV7
	umnJ1QH4l1H03zEu8ZvtT6JhdQz5aUhA/Vd9iERLZMxTYsruwRaybv/aC/PgHauT5EE3fhlsVO9
	nRqr9dhtjDHgvoiKFkKMSY91rHM4fq1ZJojpIPy1wymDitt/kYI+45fxSQ==
X-Received: by 2002:a05:690e:c41:b0:672:b897:9b8d with SMTP id
 956f58d0204a3-672b897b1a7mr1578174d50.79.1790043194211; Mon, 21 Sep 2026
 19:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919173405.3718408-1-lgs201920130244@gmail.com>
 <arFKHueZaSQAOSbc@quoll> <b9bc4c58-c34c-43b0-85bc-45aa0d251f41@kernel.org>
In-Reply-To: <b9bc4c58-c34c-43b0-85bc-45aa0d251f41@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 10:13:01 +0800
X-Gm-Features: AcwNN1XQAS3TF7su8S9S3A9jUbbyHP4JvqT1HivMJFxHlgzVj13Y81vp1_lJchI
Message-ID: <CANUHTR-eWUywrh_Gj=xdg3q+FipYt3WyBfLEw+QYddn_3Bo+iw@mail.gmail.com>
Subject: Re: [PATCH] scsi: libfc: fix directory server rport memory leak
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	Joe Eykholt <jeykholt@cisco.com>, Robert Love <robert.w.love@intel.com>, 
	James Bottomley <James.Bottomley@suse.de>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for your feedback.

On Mon, 21 Sept 2026 at 23:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 21/09/2026 17:15, krzk@kernel.org wrote:
> >
> > On Sun, 20 Sep 2026 01:34:05 +0800, Guangshuo Li wrote:
> >> fc_rport_recv_plogi_req() creates an rport before allocating the frame
> >> used for the PLOGI LS_ACC response.
> >>
> >> fc_rport_create() does not add FC_FID_DIR_SERV rports to the discovery
> >> rport list. If fc_frame_alloc() fails while handling a PLOGI from the
> >> directory server, the function returns without starting the rport state
> >> machine or dropping the initial rport reference.
> >>
> >> Since the directory server rport is not present in the discovery list,
> >> there is no later teardown path that can find the object and release
> >> that reference. The allocated fc_rport_priv is therefore leaked.
> >>
> >> Record when the failed frame allocation leaves an unlisted directory
> >> server rport behind and drop its initial reference after releasing the
> >> rport mutex. Keep the existing lifetime unchanged for ordinary rports,
> >> which remain owned by the discovery list.
> >>
> >> The issue was identified by a static analysis tool I developed and
> >> confirmed by manual review.
> >>
> >> Fixes: 3ac6f98f4113 ("[SCSI] libfc: correctly handle incoming PLOGI request.")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> >> ---
> >>  drivers/scsi/libfc/fc_rport.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >
> >
> > You sent multiple independent patches, to multiple independent
> > subsystems. The amount of these patches clearly suggest this was
> > AI generated and most likely not tested.
> >
> > More importantly, you sent all this work without properly organizing
> > relevant patches into patchsets. This makes reviewing difficult
> > and might cause multiple reviewers to address the same issue.
> > Replying to the entire set is impossible and requires handling each
> > patch independently, instead of applying or discarding the set.
> > Maintainers also won't see the bigger picture of your work. Quite
> > worrying.
> >
> > This is on the verge of hostile patch: bomb us with so many
> > contributions, we won't be able to handle them in efficient manner,
> > like responding ONCE to ask you to slow down.  Considering all this
> > is untested and LLM generated, I have even more doubts whether this
> > should be considered for review.
> >
> > Please read kernel documentation BEFORE posting more work. It will
> > explain you how to identify subsystems, how to organize your work per
> > subsystem, how to document usage of LLM and how what you should not
> > do if this was posted in a good faith.
> >
>
> Apologies for spamming here. Fighting fire with fire :). No, just mutt
> mistake on my side.
>
> Best regards,
> Krzysztof

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
