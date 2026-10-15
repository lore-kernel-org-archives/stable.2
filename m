Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708A28B7C8
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030919; cv=pass; b=U6nb/o9XBARZtPKZoD95WpFvpkCiLkILkBGN+z9xWE+o/ue6PG4pH3GSxxC9C0plc/Q427/3MUyRC7/ytrhdWu2AJdvayA0EBBOfpblJfLOCSAIPAICN/ksTUixrOzdQfeeTNSGEIdxrSgILp4GK5guwEk2Bz0NzImwD8au02ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030919; c=relaxed/simple;
	bh=qSdlRYB2TMcSNTloyYzjoolB7q5XaBTJAM1Srcl+1E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjueEub/2X19x+nU3u8lx3u45kV9wkKLzc5a4sqNzmi3W1jL8IxOA0TnqNrbovozmq/pK7lJvBfbwutWVBXfZU3FeI3f1k2+X0EgTwbUQ9xIHnmPDOOrKXnxvvGBSCsSeQSJW5UMnQVfAVEXknlrs4OmFzgk1yNs6eNS4sgD1XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVzB85ZV; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVzB85ZV"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b0d63f60bcso2606947b3.3
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792030917; cv=none;
        d=google.com; s=arc-20260327;
        b=WqTvVQAOfgQ19dcl11X0qsx0oIBqpjwYP7gBTDTEBP/53lCDYHU6kO0BG0NOryHCeL
         mdOE06QwH3XIDoEFa1ibLPT0Ui9Pam3B82mmxT0JZdDVa5akSP+q5gTqY2hPRMxOGp2g
         NVif0WyFt1CZ5fLdqWVywhaGeZV2w+mKFsdXS8j7bsfV6igNUD/Bc9DTCBOVnRie74jZ
         8jIO/04YsyPrX+E5r39crMNNwPS/irJG/75gKWfPkqMlqci0MxPCdpOIiFY6TPZIkWcs
         FOCCLkZcvVR8fJsid+ZuKYRRDyiw9o3Y4PgO4xVLuqnA9ibyZb9U/9a8/ZIIUEdtzf20
         GPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2wLqmXSLedm8Oeu0GWuAPrw8pJzuZEEe27FUMLIhsGY=;
        fh=iIOttyVtxy8GNvBfFU9Q1v2Z6wQ2KOJ/d2aQTD45JAQ=;
        b=h5IFwYUUcT+teBA47GFJuKVOeEgmDqHQmgpU4zmutHzSXmyf+QVB+eqQ3sDyLuucTk
         sJUfMx05Q28A2IqL/JY3RSbZZFy1261CDNODzQ3QiaQi+VgDYx9x3HZKglRjOJc2Vlpu
         mpenopzttw2dfTMG+aA7wHLWnerpvPCHBhsGCL0+jXecRDBj26ZWWiIfNiz5q2H+EGB3
         3ZA9t6tzpupBYVBLYsSDoW0ypX9TfYQ2OfaeabLYIyT51beW/jtYNqZds8qUhMTwu1Y/
         rNxBPgrUzWMnrZs0utRGOvVmOFWRw9/fZ5Me1vEf0R6cBwXAWFct7jYSCf1rHslDtVdo
         CzOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792030917; x=1792635717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2wLqmXSLedm8Oeu0GWuAPrw8pJzuZEEe27FUMLIhsGY=;
        b=gVzB85ZVxinQ8n61b0pnJZKLnPcki+ipVAaDQxpSay9K+ZiHEkYmqOHIZ3M6ntmPCo
         IC2R4jEOoUfZGXc3sQKJzd17YHLavEvbEQEWEm3SrDUsTytN1W+6kBaKvRVljnphx5/n
         3QDuCQlVoTAz3k7e2WTl6yZjmyyOszSwUYfwlJyt2lWawbZhHcZGZfQ5uzOteb+RJHPv
         KCyDLHMfd+oqfTV7n6Wqg46YxpBO0muoy5RRuNvbuPH3MEEGwPrVpKTgQsJk+2SdYwk3
         aObSHruuJA1prnaxjOXfYo4ENnbD3UsOYwfqx987LquYhokp+MzvljjqWaoAqjSPtD+3
         +CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792030917; x=1792635717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2wLqmXSLedm8Oeu0GWuAPrw8pJzuZEEe27FUMLIhsGY=;
        b=aO20VnKXljKu6khzHFJasBZReNsI0LGuHS8WchCZxiBiFKcGIlr+3/eUA4Mh8CYMXK
         ALwBxEMYlplzY0OHlTbpddKApKcvell872+3Rd5H/S482h6kSINzJodEA8n7O4JYG8pH
         J2ldlJaPJLE4emiHdwSlw1rVGSAiSLAiXm3t2BVW9zTcy7P95D/Yq4k48LWS6AcAnpCs
         XaG9eL353lz8KkHCagWA1X6e84dVz8IGIUyGcllNSE++2MgyNcGFGL1rM2GTKIIc385P
         t59ZuHQ6GE+hh8QylMVSNdSqr7BcwGr8PVDG9upMXUt6vMhTNBOVqWJ8NutyWVi5U548
         RCfA==
X-Forwarded-Encrypted: i=1; AKwUvBy/RDL6nAPnLkPXUOiYmm4994Jzwbmh0i1bp4QLZKwKuJahm/RRGoh+iJDQSWAnYKvk3Wcr0sg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEjfjYPtCoWt7VJYnEnSJ8zYwrPCaM7eIlLmh/Dc/C+B9MnK6L
	8V18QSBsmiKeyrivcUD+O/Py2tMmYpzzLhTJDBrV3BqrWCbMoQwXhbOiZoRt155MLFli/iM44J4
	IoVJuQGPsDmNg1Afb70q/FqKRhfWt6C8=
X-Gm-Gg: AYBFou0tmR7oWpANnp3yRTrP0IC/3tzqieMSXGDtsKJ/i4KFG6GDzraKoTZRMt8ugH9
	yPNa5N9eckljjJYjeiSrqrkfTcYG9gN1TLvCJmMWXUtp504XLvMdOf/SecqLAuTz6uN9RxewzlS
	DANqyuLjV1nL/g3XmgyxyjDJz84Hdjgr/sQwOfSmjd/dLeSiPlaBfjTI/wEUl+eugBfUp6iaRI9
	ssMi2DE2puXsPNAfmA1M39we5nMS4bQEL+CRrBzAeWDnbwy+1c3wLwFknh+veJphNb8VzCIqekS
	zSvB+2+yq1Gt9iWaRSJTqJTfnHSaJm+umRGKeX0Fst/JMpvXXGORppRHBw==
X-Received: by 2002:a05:690c:c1e:b0:8ac:46ff:d376 with SMTP id
 00721157ae682-8b07edeaf0cmr65106327b3.28.1792030916867; Wed, 14 Oct 2026
 19:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-ocfs2-objects-candidate-0055-v4-c1574edc9949e3a22edf@gmail.com>
 <5f71eb6a-f773-4c66-a1a9-c0ab9d385f39@linux.alibaba.com>
In-Reply-To: <5f71eb6a-f773-4c66-a1a9-c0ab9d385f39@linux.alibaba.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Thu, 15 Oct 2026 10:21:46 +0800
X-Gm-Features: AclHuK9l6NrqoT1uvaDLmDHqBj1VRiL6l9Sh-FVjwKZaGZu6IWt0fcjmAjjBDpI
Message-ID: <CAFRLqsXoshOAsTfYogY_PiGOnd70=s08AwXz9UXp7mT8UgxqDg@mail.gmail.com>
Subject: Re: [PATCH] ocfs2: dlmfs: Hold l_lock through the unlock wakeup
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, heming.zhao@suse.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Joseph Qi <joseph.qi@linux.alibaba.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8815=
=E6=97=A5=E5=91=A8=E5=9B=9B 09:09=E5=86=99=E9=81=93=EF=BC=9A
>
>
> cbe0e331fdbd only swaps ocfs2_cluster_connect() ->
> ocfs2_cluster_connect_agnostic() inside user_dlm_register(), but never
> touchs user_unlock_ast(). It seems it has existed since user_unlock_ast()
> was introduced in 8df08c89c668.
>
> The code change looks good. So after the above comments addressed, feel
> free to add:
>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> > Assisted-by: LLM
> >
> > ---
> > diff --git a/fs/ocfs2/dlmfs/userdlm.c b/fs/ocfs2/dlmfs/userdlm.c
> > index 617c92e7b925..60653db7b411 100644
> > --- a/fs/ocfs2/dlmfs/userdlm.c
> > +++ b/fs/ocfs2/dlmfs/userdlm.c
> > @@ -253,9 +253,9 @@ static void user_unlock_ast(struct ocfs2_dlm_lksb *=
lksb, int status)
> >
> >       lockres->l_flags &=3D ~USER_LOCK_BUSY;
> >  out_noclear:
> > -     spin_unlock(&lockres->l_lock);
> > -
> > +     /* Complete the wakeup before a BUSY waiter can free lockres. */
> >       wake_up(&lockres->l_event);
> > +     spin_unlock(&lockres->l_lock);
> >  }
> >
> >  /*
>

Hi Joseph,

Thank you for the review. I will fix that.

Best regards,
Cen Zhang
