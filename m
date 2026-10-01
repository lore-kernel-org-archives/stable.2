Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D744EB866
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876747; cv=pass; b=LQZ7Fd+BH89yc37S7hc41E/vmIxq+f9hI+uJ1HlQuqq7Q2csONcHRkjSbfq+2LeRbTQfFafpPxAQ1UfvPj7O6dh5P4AaQ16M7UER+QncsFm6R8aKRxiRo+a+Zj8N59u29a2Lz8cKczpQ9X09tWpfnpQViTr9axB+58+HUxbOCdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876747; c=relaxed/simple;
	bh=DVS+yU4MeXSTJA0MnoG2/WnDRMIiZcABsJSeQLqj3C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bs7XQGicY0wGpq9zM3l4aflwxCRQY5FcH69857yQaYaoxG6MP+tIGsJXMp64Lil08UNhNjSiweeQtrIBQ8kg0H0JH2SbEw4AIKh0DWewSacE+DDQDur6Ptg2gky6rlFCrbXzM5ItdcSUwY7i/k16PJWTWSfyAQN+dRt8eIe7XYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXfqQQXu; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXfqQQXu"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd025d07so5838846c88.2
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 10:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790876737; cv=none;
        d=google.com; s=arc-20260327;
        b=LBEZUkdLCjCZ64DEiRxRwSh5aDPV6XZ3JfYTtvRi2FS3xdt7SsD5XYS4UNTZ0oYEX7
         KtiTB+aMwATUtYgbq/r1cOoQZSPvtWvpjejthkcN1y+IzLP2fiLpZESceuQMdszKYeZs
         6Qf98qzMVjFsPxrVkHvJylKgk1WnaTmgMnn6V3lXBIvgE8HI4/jG+yhryOdEtTLn2H+p
         NeYVDrri7zCMZx4FbOb8ARyfB41wcYX8d9MCwgsUfl0yNysdXlc822z/aYZbBaHZlTIy
         z8xMj6iTkB3Q3+5fD6mk8Ezz84FWcxrtEVfsopbC/U9bL7M3OOt+mU4xtfMWZfD9k5vg
         mWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kd+gDsb79tDRiS43i4aFe0o9+muNoh8xdfZbWxrNkr4=;
        fh=7mVCyzGDAXH/xwbcAbaR3JzmJUtP7jwWL2GtkJ1KEsQ=;
        b=s1ImBcsc1KJ2um2/ur/m0Gx+TPXJvq1VmnwITUMuvxgJAM0kfqVJhJL5d2qSp0p4oa
         njsYe2QWMklUOU1UBxU2VnB3wlqdv2tnVrEpiBlp9T95suOgK0zqWH2tbAmMKLyArXvT
         JQTT6Srcy1oZRjGAT3Lkml5S3QGeZbYNLrsiO7bkSORJtZ4qNPNvoXEEYbSqt0nk0CdZ
         COA+TynXbtMvYSCtnK+GYnPilWUElQJZ6SNl8j1SSKqGcZE2pU5PSJvfwcDoTaXmmkJN
         Udaw7aHHDCWeQGg5theOdsrCDW+oi1dFvuUfGPcEzStl3yZrVot7knDUSliruZuu3YRN
         Iyqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790876737; x=1791481537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kd+gDsb79tDRiS43i4aFe0o9+muNoh8xdfZbWxrNkr4=;
        b=CXfqQQXubnpxgTH6zg6wVuh1/JFqqzU/09wtg7nHBjucGOvSnsW0obUHgU8Ka6r+O6
         YM7ate41qmImXWLsp12wECInySar2PF46Rwp5l7EebSEEdrvLe/KYCGCJLn0JIqB0+gv
         sMn2KStt3690fA1ZWbhnuhjDl5dMPK9dDLzJscjsSc2pvOzJ9rrV2qeun8/4uGABd6Ze
         4vr/rYVgRN4E9A/Uto3ADqdUYTAiLyeooO572Na21rsyXY6pf5vzIcl6Ouxqo3zp0jmY
         uXr7Vmq9gHH7//7hKsV1uLKMmRlm+XhXPtDCHTXHYGzbHGb2FOn8Xyk6OdfkMmOlP4Eo
         Z4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790876737; x=1791481537;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kd+gDsb79tDRiS43i4aFe0o9+muNoh8xdfZbWxrNkr4=;
        b=gc7Nlp844d+uvlR1zYSSA5SObTxybB5VmgJ76GzYgEnvMKu5MhUTmaGslPgItmzhN+
         4mnvePoamoRv2HsUikMmiDmxFBgGBzlPz0G8N2H/GGUlgsarZEo8ZxrS6huT2rY54rx6
         MrlC0pPJUFU9xe5jpPsiZmThnoaJ3DWinv5WK5mvmU8M4YuRNByCsSi8eXRpU+HRnm/S
         ZbIXlTEZX8fCy1GQOrUESNonTL48KM19LlGSHuvB4kbGNhTqYiIssrbGpq0LXTWI/Zau
         AKxJh0uCft+I9co4vs3OmGQKBN/ML7SPdDd3mg1CDqvBULFGWZINutYhKRA2jFpmxEuI
         CArA==
X-Forwarded-Encrypted: i=1; AKwUvBzXaavG7haMQKz2dyHEIT0+fKE/1r/6N35XequBvPKA7T2iiPtaWYIdwyWt8yx+yAYV41KMGbA=@vger.kernel.org
X-Gm-Message-State: AFuF++nQ7gYFOlUAfDr5asBAtI4/EdxFFcIMV0USXh/PTeo2W0x56Jub
	iDP9/iiEyOwds2F0224jvgJGk/UNoVjY0k40Y245Xxhug7vYR3+yl/B4qAQ15dDMy2uw7f20rEd
	Cr6P0mx+KzxiXkzClohHLKklhxAy/qOhuuBiFKgei
X-Gm-Gg: AYBFou35TuwH46DmWuFY0ALg8xM9xDUDnvcyig3Ip0q/tszR1l8i8YONXpkFKETSHrS
	tq+UtFeiv4kag9EorixWwpuCcO00HfZBNrSrsbMYhBOAWGM34CnCeE3q2nvVp5fGrIXJ0EfyATV
	AjrrJnYlsVRoe9DZoI56+aaiyEucFY2/VPyOGAFfRJtNbO3VDrJhb5W8BlEHLrXK4agsLrmmR96
	h6QWeKsWHoMy8+vnogAqB9stVUPLCgTn2rRj1ROWIGgrUJeqc6aDH3xnYbyXAt6XCZAxMV/bxDn
	sAp3MqQlEK6GDSpDZARFVlDOzzW9T6g0kXzP2BSQpyyd0g5dbnODSPlGYwbkh4vzbPxtvP7fFh4
	UH3BXQUhoFapBoERm/+k0TcpTzvD23yS0fojJoOqf6aCRn5QNjXsE4FzvY4mao4wG1VN3/Fvddg
	WhQo5OkL8IE2QeTC/TmIiAnzlv
X-Received: by 2002:a05:7022:fe09:b0:144:eb46:be0 with SMTP id
 a92af1059eb24-14d31c6d959mr7036975c88.13.1790876735713; Thu, 01 Oct 2026
 10:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001143040.28467-1-parri.andrea@gmail.com>
In-Reply-To: <20261001143040.28467-1-parri.andrea@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 1 Oct 2026 10:45:22 -0700
X-Gm-Features: AclHuK_PRj6kNhTkNAge75mh0uRy0R-jClYZQl-fhXQ_Zc5OUMVS0wPKh2mqOHc
Message-ID: <CAAVpQUCPBAoofDeDMdQii=5P6FyRnKOdN932fTuocHtb4H+m1g@mail.gmail.com>
Subject: Re: [PATCH net v2] rtnetlink: wait for RCU readers in rtnl_link_unregister()
To: Andrea Parri <parri.andrea@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 7:30=E2=80=AFAM Andrea Parri <parri.andrea@gmail.com=
> wrote:
>
> rtnl_link_ops_get() finds ops on link_ops under rcu_read_lock() and only
> then takes ops->srcu. rtnl_link_unregister() unlinks ops, then calls
> synchronize_srcu() and cleanup_srcu_struct() without first waiting for
> RCU readers. A reader that found ops before list_del_rcu() and has not ye=
t
> taken ops->srcu is not waited for.
>
> Such a reader then locks a cleaned-up srcu_struct and keeps using ops
> after the module that owns it is gone. rtnl_newlink() and
> rtnl_dump_ifinfo() both look up ops without RTNL, the latter for any
> user that dumps links filtered by kind.
>
> With delays added between the lookup and srcu_read_lock() in
> rtnl_link_ops_get(), and before rtnl_link_ops_put() in
> rtnl_dump_ifinfo(), running "ip link show type dummy" alongside
> "rmmod dummy" on a KASAN kernel gives:
>
>   BUG: KASAN: vmalloc-out-of-bounds in __srcu_read_unlock+0x57/0x70
>   Read of size 8 at addr ffffffffc02ff318 by task ip/147
>   Call Trace:
>    __srcu_read_unlock+0x57/0x70
>    rtnl_dump_ifinfo.cold+0x30/0x3b
>    rtnl_dumpit+0x7a/0x1b0
>    netlink_dump+0x486/0x11b0
>    __netlink_dump_start+0x661/0x910
>    rtnetlink_rcv_msg+0x611/0x9e0
>    netlink_rcv_skb+0x126/0x380
>    netlink_unicast+0x605/0x830
>    netlink_sendmsg+0x6d0/0xbb0
>    __sys_sendto+0x335/0x3a0
>
> Call synchronize_rcu() before synchronize_srcu(), as
> rtnl_af_unregister() already does. This should be enough because
> rtnl_link_ops_get() is the only RCU walker of link_ops, and it takes
> ops->srcu before rcu_read_unlock(), so every reader that found ops is
> covered by synchronize_srcu() once the RCU grace period ends. The extra
> grace period only costs time at module unload.
>
> Readers and the writer were serialized by RTNL until link_ops got its
> own mutex, which is why the missing RCU wait did not matter before.
>
> Fixes: 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.")
> Cc: stable@vger.kernel.org
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks
