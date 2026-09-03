Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F073346774
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 02:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402285; cv=none; b=L+BuHPVo0qavnPt2N9mKFYsvWtF5I6lnIwHM5/CPAqx8m6wx2hbfIVaMeBWSEKKP3RVw2pp3NGpjOOxz+xCJb8eqJ6I68JtAd/QRB06p5X/+fP+YIzUNY2BMIWEg+mVhP08Av6gR2BGx8y1e377z/XKY2fFG39uK6idLoWQtoXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402285; c=relaxed/simple;
	bh=6F03+qm0Bre/VKnLmITkhCR03ciDfFHEPe4T3bI/rIU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=P+Fh4/ucKB29K4paC295LEQ37+qZDTWGvL1ZLQRHeomhel3HLr0ecVJ22cs/ON9riefeKxeproHZi3LWo3c97U9Z5fGQvVrM07hpHSeZhLXfkFF7g3Sy8jXMSMPV5vl8TKw4m6XOL/lnogyMoaEGJkdE2KtEmERUWG8c5Huhi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GnsOWqoL; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GnsOWqoL"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-90d7fa95a58so15921776d6.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 19:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788402280; x=1789007080; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NxbHCn+xq0JEsuYb7obCbCtymJ2U1zlmOJGfFx1MyWs=;
        b=GnsOWqoL9qeO1KO/f8AtRwzAZ8oa1y+YWwzBmgoW/v6lb/vcsxUf3bkAojn9Ob6pxb
         fe/W0XHBNS/IZOIaVxWf8BQ8IYCaKKUuWqLHj3zrMU51AUmJvlHJUgFS59LfC1CwHF8G
         R7gWl/X9ClIDSto4+eF/9Rh3e/aAfdZg922nG7MAgXAfzLwsPoszPwmUBcgmvwKQqkCq
         d5vqCMRQ42jfNP+y04jfEZOTlxLg2oiRHmAWirKo0SCk4SbXi1cQriVcPPsalIhcNAud
         X164Ohe4lAzFj2HS1Vn2B5ydzb4RKp+IMQGOwmuEsSg5kDrAiKg15Ebr0GSoudTpFsIm
         HGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788402280; x=1789007080;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NxbHCn+xq0JEsuYb7obCbCtymJ2U1zlmOJGfFx1MyWs=;
        b=T6ytmm0gUuKjzPmvqIKXCK5G/tbHsQ5Am1pE3STdKRuimTktL7h7YrMDPk7vMe9wpx
         pFeksoaWdNg8fvJ8CdL0xSwbuPO7ILFuz6muFfYhMLk7bYCmvvXEJH032OIZBX21vXLo
         VyvyO+v7FhBpurjsCaRX6AzfjA47ppEU2ryxuHlguf4Wem8ammBbbEfXhcUuEyl5ot2g
         vS20NetmXgTPixF2MdMRSI6dk/5+h7VPhP3V02UPbNakWwc2djwhQNFj9qSEvapqAE5B
         LxFxn9+dIS/KioSNYsPp7pKGLODmjV4Vmk0PmB0q/Kt+LeaeLK1jGKz/A98kwK+flNSK
         q2hw==
X-Forwarded-Encrypted: i=1; AKwUvBzYNZyo+Kf517Lgz4NpQAsTtcvEciiUAk7tZgyEFvKS6k2cb7EirblsvizML/zMPD1S5vJ5A0o=@vger.kernel.org
X-Gm-Message-State: AFuF++lAqHA+7lLPI3jzPWLBhw4Q6z5JmLnSKmC3UQgKzqEgHmVTWfTX
	+toDpimpMrK03mDg1dbmiOubsDUEWNeizx0mo/hZb2HkvP6Opl5Z8KKqnh07sW4Ahw==
X-Gm-Gg: AYBFou0n0SnOKsJL5iL1OTvq5uB6+JnRqHLR3A5C9U25cY2ZcUqLBzO4JrKv17FP/9X
	yJ3PDnyTxVa6v7p6dGq6H0KTvwIYF5OttP184MxrFgUFFS2c6ZIaENo4NG/8G9yO4bLSuF/mnQ4
	dG0HdUFlTNRTjQXfAQlFC0CZwRoU+LP168j7PL1DMPv7pKitECbw0fw9v1PXrOIxZGbuRducUGC
	xbYmjCc2qMLTNyaIfJaFmVl9sRvEXfY6cXdic4YNqiya+sbAmyx1QtbI/xsRncmeWRDb1Z6qAiJ
	bMJ0Hi7jZ56sgb2QPdETVa2NXOULvmqoBzsRc8hqI12x2Gv2shkckZSKfGu8+YMErkhDfFjRile
	DlC3o94ez8qvvECC6g4VrYg+74LrL3K3b32aAzo+24wEeCJQtSMLuAt2526yKdxaTpdLqKJYztE
	sJzaDtNcqAWTDXZfptt1FpU6+FxismjBHjytk5v2LFfLZ9svooVr/rJqjQ3zojpGWB1ZFKCRWl4
	458e2BudgNSi6WmR7BC3zsdPhB3Fau1iQ==
X-Received: by 2002:a05:6214:21e6:b0:908:8f6e:52bd with SMTP id 6a1803df08f44-90ebabbeff6mr111657566d6.23.1788402280160;
        Wed, 02 Sep 2026 19:24:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ef0fbfbsm32797076d6.49.2026.09.02.19.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 19:24:39 -0700 (PDT)
Date: Wed, 02 Sep 2026 22:24:38 -0400
Message-ID: <5be8f666e660371dbc964c2348422a25@paul-moore.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260902_1319/pstg-lib:20260902_1617/pstg-pwork:20260902_1319
From: Paul Moore <paul@paul-moore.com>
To: Tristan Madani <tristmd@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v2] selinux: use socket SID for SCTP ASCONF permission  checks
References: <20260830201157.2084730-1-tristmd@gmail.com>
In-Reply-To: <20260830201157.2084730-1-tristmd@gmail.com>

On Aug 30, 2026 Tristan Madani <tristmd@gmail.com> wrote:
> 
> __selinux_socket_bind() and selinux_socket_connect_helper() call
> sock_has_perm() which uses current_sid() as the AVC subject.  When
> selinux_sctp_bind_connect() is invoked from the ASCONF processing
> path (sctp_process_asconf), current refers to whichever task was
> interrupted, so the permission check evaluates an unrelated subject.
> 
> Fix by extracting the sock_has_perm() call out of
> __selinux_socket_bind() and selinux_socket_connect_helper() into
> their callers.  The process-context wrappers (selinux_socket_bind,
> selinux_socket_connect) call sock_has_perm() directly.
> 
> For selinux_sctp_bind_connect(), determine the caller SID based on
> the optname: SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF
> chunk parameter types only passed from the softirq processing path,
> so use the socket own SID (sksec->sid), consistent with other
> softirq-context hooks such as selinux_socket_sock_rcv_skb() and
> selinux_sctp_assoc_request().  All other optnames originate from
> process-context syscalls and use current_sid().
> 
> Factor out __sock_has_perm() with an explicit subject SID parameter
> so that sock_has_perm() remains unchanged for all other callers.
> 
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Cc: stable@vger.kernel.org
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> Changes in v2:
>   - Do not use sksec->sid unconditionally; determine the caller SID
>     based on the optname so that process-context callers (bind, connect,
>     connectx, sendmsg) still use current_sid()  [Paul Moore, Sashiko]
>   - Factor out __sock_has_perm() with an explicit SID parameter and keep
>     sock_has_perm() as a thin wrapper for all other callers
>   - Move the sock_has_perm() call out of __selinux_socket_bind() and
>     selinux_socket_connect_helper() into their respective callers
>     (selinux_socket_bind, selinux_socket_connect, selinux_sctp_bind_connect)
>  security/selinux/hooks.c | 47 ++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 12 deletions(-)

Hi Tristan, this looks much better thank you for putting together this
revised patch.  Unfortunately, while looking at it I did notice one thing
(below) which I think we need to change ...

> @@ -5731,13 +5737,25 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
>  				     struct sockaddr *address,
>  				     int addrlen)
>  {
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>  	int len, err = 0, walk_size = 0;
>  	void *addr_buf;
>  	struct sockaddr *addr;
> +	u32 caller_sid;
>  
>  	if (!selinux_policycap_extsockclass())
>  		return 0;
>  
> +	/* SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF chunk
> +	 * parameter types passed from sctp_process_asconf() in softirq
> +	 * context where current is not meaningful. Use the socket own
> +	 * SID for permission checks in that case; all other optnames
> +	 * originate from process-context syscalls.
> +	 */
> +	caller_sid = (optname == SCTP_PARAM_SET_PRIMARY ||
> +		      optname == SCTP_PARAM_ADD_IP) ?
> +		     sksec->sid : current_sid();

This should have caught my eye in the previous iteration, I'm sorry about
that, but now that I'm looking at this it occurs to me that the sock's
label isn't the subject in the ASCONF case, it's the label of the remote
node (sksec->peer_sid).  After all, the ASCONF operation doesn't originate
with the local socket, as would be implied by sksec->sid, it comes from the
remote endpoint which is represented by sksec->peer_sid.

>  	/* Process one or more addresses that may be IPv4 or IPv6 */
>  	addr_buf = address;
>  
> @@ -5767,13 +5785,18 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
>  		case SCTP_PRIMARY_ADDR:
>  		case SCTP_SET_PEER_PRIMARY_ADDR:
>  		case SCTP_SOCKOPT_BINDX_ADD:
> -			err = __selinux_socket_bind(sk, addr, len);
> +			err = __sock_has_perm(sk, caller_sid, SOCKET__BIND);
> +			if (!err)
> +				err = __selinux_socket_bind(sk, addr, len);
>  			break;
>  		/* Connect checks */
>  		case SCTP_SOCKOPT_CONNECTX:
>  		case SCTP_PARAM_SET_PRIMARY:
>  		case SCTP_PARAM_ADD_IP:
>  		case SCTP_SENDMSG_CONNECT:
> +			err = __sock_has_perm(sk, caller_sid, SOCKET__CONNECT);
> +			if (err)
> +				return err;
>  			err = selinux_socket_connect_helper(sk, addr, len);
>  			if (err)
>  				return err;
> -- 
> 2.47.3

--
paul-moore.com
