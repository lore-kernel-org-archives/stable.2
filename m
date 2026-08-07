Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F63A0E93
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786131856; cv=pass; b=WWxCEx+LeUp89NwBLk3AgX+nZAZIRDRYuI2C3iABAZwSTcjS8j8nRHM/adIURtySK7V+RZJHfd9sNrCe5SCxRipq7LbvhX+DcSBBqsmHZF8hm2qot7NObiJU8fou6xhAyX1WWdM/tz4voeiWXLjWrcGTT27t5623gaDAntk0/Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786131856; c=relaxed/simple;
	bh=4xiLHxYkPGdiFvA0nrbU2tlQdfq82xczLJnzo0zXkwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQn//qkC2pUs3u25Q6hvJYb+dT07FyR3jxp0VZhZ6IO6As7ei5+yZhpIti3n1EkRtFlTGln8UBNZUCj/SxaBeifb3s2HVTkbcY8Umu2Uk2Sm+KE4HHfzXc+Y+IKgdiza0V2Ym2yAVCXSK7BQNOZf/iXkzDD2NtOCNDLGQEhARIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q80mHEg0; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q80mHEg0"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e04df8c46so4079758b3a.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 12:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786131854; cv=none;
        d=google.com; s=arc-20260327;
        b=MuXzJUNT49kimQKWb6H+PCABYzI3pJtDmQD/PDTntoVd6KaaFhySCTJL+8fr6/9N9D
         ezCaNYYRlbkJUjEEuP7jvI0lhqHk/D+bKscLoTtquHPwAghl3fm4xhRIxGOQmFGAvXXR
         QpYmtl/2q6Qm/eO/we+eUdzuRsnV6Q6noXwuLxsoaSwUFkfEps/TtI164r9ke+GVac4o
         /EH9A1ZgjPx9XfYOiGJrpBxOzzoyffFt02EjxDUInXdDnyf6iSpOD6R0qH0MK0MwxIUg
         TImFnMxNppmdrr78gIGf9cufcgXRxpsj+mDo+gwKAUCcjPI8lEQdoU4aya0PhWJn1dT5
         jwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e/wtoPuRy5LBbReY+YT0mukVCMIY6FSDljjCufXHkOM=;
        fh=60Bt06NsSwkVb+SBPWIPLQV8EaI9tJ5Mk0A0FOfoxoY=;
        b=fwqGqil8K56C/xyLl42JY0NaenzaNH6P0f7jqriVh20ZfWvWERg+HgkcJ/0wu+k1o6
         k/pfgcc535l9KeJmxfNFf7KhyqzuvdfbsYFEDQWBm/EU7TBD++ddHyafUUq5bAhNkk2E
         9Z7NIOP+UhQqPvJzROuwy1YV/GwOEY/BjgkMJqUKDhoeGfPE2vzp5ZOx4xM+5T6GEfnI
         lfTz/XptgBfNmyOPFY0HPEbCGb+97EWk9/pBAsr8ydQur/tiM1iIIUGKXYRTMxWRbVJU
         4oQcPWaOZyHe5G+m2VV1Rb9EHGqoNIkBA/T9Y9RuDeQ2HYmYyx7MdQ1uH5J69oIhx6qX
         4sPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786131854; x=1786736654; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e/wtoPuRy5LBbReY+YT0mukVCMIY6FSDljjCufXHkOM=;
        b=Q80mHEg04QYmylKFoxCyDQK8pKqgOUTJGyr3fWCzTnohYdHTX28YRVl3Sx/ExN9eUM
         mZigsHsz/wm6vY6ko2X699jYd32rjwZOskPXMGb1EIg33N0DW+jJ5XQYVMwg11cS8zHE
         zZiTli8YJS0e4frkpoAcfFU9IArBK6LkV7L0UjOABb6wNLyVY6xYLw1qR5NHzPpMvkMM
         BRXs1FU7sJjijXBvIUBd+46PLEWNlrfySSbmR358Ssh+utSZLeAehRO5ys9AX5V6Nbq5
         nFVu/tyw0BPDKpeFuEhWiH9NMw8aCiT86rFhNYcpv2f7L1hSt7oK5J4tr+TEcNWMMbqF
         ZRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786131854; x=1786736654;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e/wtoPuRy5LBbReY+YT0mukVCMIY6FSDljjCufXHkOM=;
        b=AIVSiMbWWG6vOZQDmKMq9d2WMtXYL7tBszTH9Dz83RCREF1Qism89iv/ZWPP196yxh
         orq6yW8lyB4vKWDxOPcpruZ9lMoVqOXk+aMSrRYKhU1pq/ABLJ4XyGMhA9Gz2xJnWIRH
         PTkuuZIWqV+mbvjn6IixpVl3M7N/m3yQ/P7IA7fjvmnXVET0e06XsbvSMxD6X9vX3H/X
         U2Aliw5hB/3tR0tiGE6MIhTjcsrg2FoK+tTXID/reuu0nBQAFpOmR8UPp3gASUJmlNut
         /pFWzHZQN5GGfIecy8zekoxwJNFWg5G9QprXMX0bPaknu99JHGsEFMhanCpkLyRrGOXD
         8ZCA==
X-Forwarded-Encrypted: i=1; AHgh+RqUEcU3waI3IRoMhYXel9/lVTIXZT8KHS9lnZm8fzRqQnYZmbzWem7dLKR0gx7atv8/DqDW5CY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3FWLUiRBJ0JUwX7Li5JX8zlvYlhOSLl1oa/VjQ2+c1GNKWngS
	GrJjg2NERGoHIRCF1KeDjOFzYnsM56XPk7orX24s3jaFS70GXtDyDGgmKcQAScA4C60nd3yzeTK
	SUhywL79eMPE5+jnqMWtcRKDM8R0rGo4=
X-Gm-Gg: AR+sD13Cg/jRzJ1qLIi+USewb7AwRaxHvNNIBG9198or/oC4+PiHnv+DA4T4bT+NDzh
	yAOSwn9I0l2NbGSZ2Y9AsYIT3n32dfwBw1wIO+1sOC1zqReeeOAJfLdd9DyLCrAzVMgK9KdYj+r
	caJJRDG36u7/w3FJMPqE1ARc8HFKDUL20yUmOmr4Lt76ijExznjVDSTcm+lrX6gwcq5a15feE4D
	7IC5nrVJrq7unInCTK2aePy2D30TdYk5qzhkxqE7A1vWp9nXk7KQljwgXJL0v44t1VHpRvsG4Ov
	JbdC7iQPCg7nE+Pn4z3fssEDuatphBKnuEZFxXxPZ34kztJt5cSJ9mx0jiQyXqC+apLCLHIUep7
	W3P1/Xvql26Ri7ySo0M8TtQE51kVaTgUODy/WdWZ7KXU=
X-Received: by 2002:a05:6a00:2187:b0:843:49f0:f5a0 with SMTP id
 d2e1a72fcca58-84f5e0c4b15mr6824968b3a.32.1786131854606; Fri, 07 Aug 2026
 12:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806171614.945331-1-yangyx22@mails.tsinghua.edu.cn>
In-Reply-To: <20260806171614.945331-1-yangyx22@mails.tsinghua.edu.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 7 Aug 2026 15:44:03 -0400
X-Gm-Features: AUfX_mzVEiReFNJVEm_qbf2Gmz63c3XMP8OIwZQiLtSF0RDjxwSqyp76pzJhYwg
Message-ID: <CADvbK_ekVxEzb=-sbphAtmzYYXqfggWX2h3CK24s84MmQvahJg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix use-after-free of cached ASCONF chunk
To: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, 
	Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, 
	yyxroy22@gmail.com
Content-Type: text/plain; charset="UTF-8"

> > diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> > index 5b0ae616e1ff9..737f8ea9d482f 100644
> > --- a/net/sctp/associola.c
> > +++ b/net/sctp/associola.c
> > @@ -1713,6 +1713,8 @@ void sctp_asconf_queue_teardown(struct sctp_association *asoc)
> >          sctp_assoc_free_asconf_queue(asoc);
> >
> >          /* Free any cached ASCONF chunk. */
> > -        if (asoc->addip_last_asconf)
> > +        if (asoc->addip_last_asconf) {
> >                  sctp_chunk_free(asoc->addip_last_asconf);
> > +                asoc->addip_last_asconf = NULL;
> This is a pre-existing issue, but does setting this pointer to NULL here
> create a NULL pointer dereference in the T4 RTO timer handler?
> During a peer restart initiated by an unexpected COOKIE ECHO,
> sctp_sf_do_dupcook_a() queues a command to purge the ASCONF queue, which
> calls this function. It also queues a command to stop the T4 RTO timer
> using del_timer().
> Because del_timer() is not synchronous, if the T4 RTO timer is already
> executing on another CPU, it will block on bh_lock_sock(). Once the
> restart processing completes and the socket lock is released, the delayed
> timer resumes and can unconditionally dereference the now-NULL pointer:
> net/sctp/sm_statefuns.c:sctp_sf_t4_timer_expire() {
>         struct sctp_chunk *chunk = asoc->addip_last_asconf;
>         struct sctp_transport *transport = chunk->transport;
>         ...
> }
> Previously this race caused a use-after-free, but with this change, it seems
> it will result in a guaranteed kernel panic. Are there any synchronization
> mechanisms preventing the timer from running and dereferencing this pointer
> after the queue is purged?

Hi, Yuxiang,

Please address the issue reported by both Sashikos in this patch by adding
a NULL check in sctp_sf_t4_timer_expire(), like:

@@ -6105,7 +6105,12 @@ enum sctp_disposition sctp_sf_t4_timer_expire(
                                        struct sctp_cmd_seq *commands)
 {
        struct sctp_chunk *chunk = asoc->addip_last_asconf;
-       struct sctp_transport *transport = chunk->transport;
+       struct sctp_transport *transport;
+
+       if (!chunk)
+               return SCTP_DISPOSITION_CONSUME;
+
+       transport = chunk->transport;

        SCTP_INC_STATS(net, SCTP_MIB_T4_RTO_EXPIREDS);

Otherwise, this change would turn the existing issue into a NULL pointer
dereference.

Thanks.
