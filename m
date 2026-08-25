Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D607C3BE15D
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684569; cv=pass; b=Nd4nvRqdKuzN2WK2GNb0zq8PrsITb7lmPOS30CI6Qecd+UvojCawVkbXTupCma2O2IMQK9m0J0OV8bGrtJxzTE3g9AvTgesV/3G+fRUx7CcrFLcXkmcSCyIP/7iPyO9CG0j9F/JwrOkMPKR1Z7Sg4c5Jwg+pWQdd0GyAsjnN9mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684569; c=relaxed/simple;
	bh=Nh4etyOe8P0PSJodoj8gcrhLaZOm6/Ai3hmoiHe6Evw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6QuVkMm98Yxfrzhg0kam6yDf47z8eTOoOq0U7HNBtu6sLek9sdp0ux93/ckf5HJ9ak7ZmCfcxDMJUAcKjYVOL/+hxGyIN6O1Qopnzfqu6T/hQiIL072VP1o1B5rggQmdbIGt1jnSg9yPQlyLvhrmQUQNx8VorgAiouRwnnPeEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjTHm9Y2; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjTHm9Y2"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69a1c7ce59dso19424a12.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787684566; cv=none;
        d=google.com; s=arc-20260327;
        b=cxd2Mg0+bRoHzd8PvV6ShD3hZ3XvaYaOilXPFoskMK50SQz3Zqh1zByqSIb5P83nXz
         Kt5ny3IcWBVEpqcP/X8lese8QEvfUk7PnuwHTsSbIRyNvUcH2NSvD6roBR9e5nnkH0OU
         bLO5N+tppOdBL8hm7zi3gxLtwkcWfWiYJGXftiBVQn8OqO++iYYyiOphf4rfTMjj94yy
         9j6BpCQr23m55pWlcEEQcPKPtawsyJf+GbBxJgsFrcrUrc9ol45C5PvyLD3KDcHWyLqF
         8bv8R54XC7ZA+6e96mMefShiF80VjfKzMSOYDJvilSPqc/ezeI8MPRjA1UJ6WyBVCJHv
         sE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7JjHTv2VjOYdPiXcUvz2oRLc1r7uX0OdGo8rQlWKSDw=;
        fh=yrC4bre/MgxRs+o3Ig23Nf/dfMZXkdpTGiUPGwFtJ8E=;
        b=fw/Wn2DNCXF8I/vpGTV0Xpr26jj35LRxjbzujCd6k1kyKoc9fDm44Z+BTblWSmZLrw
         asWdC+zjbwim3p+jKvVt3j3lpNsx+ofqFkI/XTnRzsRqjFaXz+yjqfEMGhbVbvhC8t2z
         SSDeIX9ZTGms0wCGKzImRBhZ02CBeCDBlDq6SBLoaSvgpdmCBBKZRnDU9riC54KELhsH
         ck1aYDkGKVUjCYXoxIeIf2qM/5sg1THTJwHbomWnQpf9VVqpV5ANAQsBOJ00518INiZM
         fuMhg1qclHx+q3sw8wP9dHchyDAmQNJWWB2u0sKBw+/02my2p8/GsMiIiwoX77K/r5J3
         bVCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684566; x=1788289366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7JjHTv2VjOYdPiXcUvz2oRLc1r7uX0OdGo8rQlWKSDw=;
        b=WjTHm9Y2lffSSNqQTRbrY6EfYGoR2Mpr5eg9E32DQSCFfXfR4MZ052x6ojbmPTIsYd
         rTvvr5LrHAHdgC4LYHtDzKGvfTuUnPg9rcdVZEeoKwcn7NZNpPlWvMo0PCynkNhy9PWq
         g4gGjkXznMd0Sw3131VSEoxeyHlkE5J+AtniETli1tGTol0BoEBOe4p5OsEbY9yDFhA4
         hrtkg/mqLzh0F9r8v5fD+FZxouUrALtb7FOXqnGs+N3g9iWvoxncZDh3oNUBSVuf3BVe
         dIXMxM6xk9TC2N3ENLf0u73hOjMfHrZV5f/XFkEOmyZcKpbPRv4m2ezkDgawnpS8fRme
         ALzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684566; x=1788289366;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7JjHTv2VjOYdPiXcUvz2oRLc1r7uX0OdGo8rQlWKSDw=;
        b=cIkAW7tQQiT2mhaieMHELmAmO4t/XnfaSislW5eCwVzobzxqEUfddNdoTSAT9zKzkP
         c14GnvYtbx44H07R36mQ+UGOJokGKoKQO8Zi8qORwv2iOK69y7tHtkl0v+npL8AHMEYf
         yGcn6ljnsBCQG7Nm1Yv3obKLg3oHODR+H0xU7upuIoGmRNRxeaalrMvuEQv+WU1EX4Np
         M0K5qkZr0Cale1th/Z1x7vFaVe02vZA4vW75j3gzbEc/i7GanoLHZXmPa/3n/uYVVZtM
         1LYZVs8B9tO8XiZlkmLcpkebNJvyTOEvxwzedERHseOrRHoJAjbw14nEBzhTk9bnOtqp
         PZeg==
X-Forwarded-Encrypted: i=1; AHgh+RrtBw/IOxetx7DNmrjQQWJyWlL5KBRcZVoSslRxpmrs/4vPaBd5QrLfvVwtSqPgY/WzMff7s9g=@vger.kernel.org
X-Gm-Message-State: AFuF++mCMNdJ8lse2giKLbhPPdziP4JxV9RXne+b/LitqIz+melVV7G1
	K/nSjNUNBktw8dUU19L5ZrewBRGLkwIAuRpB7DlD0FZafJ3gw9U8D5HADpp08RHQ3LN36q5YdA/
	H996Mtq3V3qBRawMHGAj85MuqL5P4Ml8=
X-Gm-Gg: AR+sD13stvKTBblzo2PZrjtGcX8lFpMnnBiszE6Qxaw8ogcAtOTpiHwEqmSdOYRYkr7
	NAlAsYyP1QkSUdb942wk3tXKop36/3n23NIoQDMGL4S6LEzLTJHi4FQzp0K61eYG6+89Ky3JAIr
	smpMEKLmWgWkDTlmRKAX+9X3aBbRYV6nTPiCSq3RD9Uz1R2hjTlNd+otADTr2r8C9FTVyNhbk+O
	aIRzQUNZ97C6J6ZfwDQsU/3VFa0flfeq80NM99Flt6s89PsBkkjD71czE4ANxSuLN07F+A4pWhk
	jTh8xQr5lFNDrpQtShz3ns4ncopE6T9a9O2GTQAjj6V3p15hyFV8rdKi9zixqi+SQHAiFQDjDWQ
	=
X-Received: by 2002:a05:6402:5d5:b0:6a0:d5f8:9ebd with SMTP id
 4fb4d7f45d1cf-6a5df5f7fa7mr701445a12.2.1787684565689; Tue, 25 Aug 2026
 12:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824122929.210431-1-nicoyip.dev@gmail.com> <GV1P189MB198892ACCF53DC750EBBE0BAC6AF2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB198892ACCF53DC750EBBE0BAC6AF2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Wed, 26 Aug 2026 03:02:31 +0800
X-Gm-Features: AcwNN1Wzt_JiO8Qr8xp3XJGCZiaALV2WlVL4bnaNw27hfgpu41gA7GbZJinw0K4
Message-ID: <CAAo+4rXdQVUWUCpi6=k2--hhFMw5+ghjrwE5NqXfsW0Dt_o9pA@mail.gmail.com>
Subject: Re: [PATCH net v2] tipc: protect node reset trace dump with node lock
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 7:08=E2=80=AFPM Tung Quang Nguyen
<tung.quang.nguyen@est.tech> wrote:
>
> > +       tipc_node_write_lock(n);
> >        trace_tipc_node_reset_links(n, true, " ");
> > +       tipc_node_write_unlock(n);
> Please use tipc_node_write_unlock_fast(n) as I mentioned before.
>

Sorry for the negligence, the v3 is just sent to address it.

Best,
Chengfeng
