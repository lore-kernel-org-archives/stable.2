Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A026544CF40
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141230; cv=pass; b=aqdzXiZkUFzCkCPR5NZ6UbBxsEVKUceBAnJsYIFjJBF525gQJYQIujTvDVQ/YrOiynQ2Dolecb1pcmhzJg5MYegQ4tQ4ZxbMIJ+RSSsY3ZOav+ZOHY7GlNkvE6t5CA180HEDeCBdQ0zZynT2Jhdr05afi7EzZsrhNt/mVt9bQ1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141230; c=relaxed/simple;
	bh=OVzfRZdbw7s/lzMKC8M5X9MPCV4GrzsQdddsKbt+Ujo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxHS4FlUpR22+niVzUwXmgTkZ350LXjJNGwUf6n87IztddfyQ4P0E8gMV/Q5FVfRVgm/rMlW8dnYCYHKTjg/SIjss2U6FOKA1cvXHANSQAwuQ8GU9lE2AlV8Wcp5cj46O5yeRKpbTQorjl0CwPI10/SeFxzj1vAWeg/xddPCCe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=RhPXrHLB; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="RhPXrHLB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2dd76b1361dso21059435ad.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792141228; cv=none;
        d=google.com; s=arc-20260327;
        b=R1gHxAwrpBpo+pY1kvo4Jmv1pknVDODw2Ci+nYsj3UB8yMlE0bI/4F3NARzZAgpGNT
         rNSfxLr3EnZp62eTlhSH6xlyLS6D+Dfr8G831E4Zf5J65xLRytR7OcPv+5rgXehZHphP
         pfHhjk6KSWT1IogfmrSvwU7XKxJ2JuLdyeNGzs0Flds91QhAFyktoM385bmRUD7XIh0h
         s2T7bAr5Q+KXJAlw//b4z8eu99cWcPRFLFPH+UzgXg6D1ZeQMSclb/ni+JiEKRfdSu24
         j6frMbBsEPU6kuWqRHKcSU+KSVv8aEwvuuwL/RC3DDPfCCQ99cqlem6i5mZ/LAND6Jux
         XM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K5vZaRJtEgpb/nYXCR3GtSi2IujdlKts4184PdxaRd0=;
        fh=NHMkmVsrv6RmyZzPMlTZm/FFzv7n535KWFf1976YqoU=;
        b=A5xY+5Yb7sSJOS+RXN4bzieyarotLtwxtlssFQy1yXSTbziseU5CAAFORWJDoayDXP
         t+cxbSK/I0VEa5fOUEhZDyh/IL+OlHae9UxASspxKVkHtCMHhg0RFe8rcudWuwWrddLw
         cgjAanp+4T6/tUeNc1EDxT9MZYwCZDmZQSM4OEP7cp8SN66FJxmvQu1JGWo9hRfX66Ng
         QUEb/NrhAaU5RzvzFORnPOa3E+kdN2rFLVf/B6rutQqb5CZoYlErvzKpnT78YrBXspFE
         ZvI4mVO5zVBUCh99A82W72Owz8bkP6/AKbwVAsLHSPATNecxgbtTvh88Fakkz1z5BHu0
         uJDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792141228; x=1792746028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K5vZaRJtEgpb/nYXCR3GtSi2IujdlKts4184PdxaRd0=;
        b=RhPXrHLBCiDBBEYrYBTNlfmD/QQlldceZlMSoGT3/57ifVzThp17AHeWKuBZNcvvFR
         ASYsFIMH1K+DkMf8RfRP+GPtUyx1Gzs04E69j2T1oXUgnexFwEXwIe0FaSyXHH1A/pNU
         udfXZqlt/dwy3t80CKsQ0YaGKES+JMKUEl7aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141228; x=1792746028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K5vZaRJtEgpb/nYXCR3GtSi2IujdlKts4184PdxaRd0=;
        b=xq/aOSKNORS2+6gaJSqXDumad53cLAkIrIBvzkRYYdthAclLV/eFq35pX6e5tCdltY
         DppTtoUUg6sblNDScBgt29y/jTQCE/dq+mNjc9knRn5vJFIZUjy10S5ecXQ1WOoudqU4
         7sgEZAbEXTFgKVnCyWlSiR8EnerQezcRLU07gQAwBHy45M0wx4JrVpWANmRk2z3jdJSU
         b9ZoCbSXSr5vhRpz8AxhL9gg3ICiNb1HpxOV+qa5BK9RvhG9Gc5nSRhtE2o7uaFzMxNj
         U0n0W+pzMJEc+iZ4XVX1hhpNixkymDLTf1TiCx+foSg3CC6Gq9KA8noyUN9SpECYV0Xz
         UjIQ==
X-Forwarded-Encrypted: i=1; AKwUvBztLrqejpVUVDteBr2qy3CubQoQK24sSP+b3tvGe01TRB+hIvRtcV2EWG59NNjbBLGljKxRDBk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7Plc6qE9Bj7sY6R265zr8cnNgICYU89tiRbzNMZahls646ozM
	xIhw08fy09lHW299ySlr/QEG1eLND2zE7HS5IpQLL2Fkr6Ko8eyhYFDws7JXgtFD3sjEo2ANUny
	vPPB68uMQl0ha0dwMjPzn8cuhlW+QZHRVfG+iJqf3
X-Gm-Gg: AYBFou15NFked4yrhvuMiw1HmxPHiKRMeMbWVvmWUIn1h6u2rLDY8gk3CkQLao3CXWe
	j2/tzlLs9RWCKl3AI8OvgZjmx3dWVBdjwwbYbNNzprXhmLchVi52rGz6ifbUUH/Ht0WHkiUhmLY
	M6nPVs3d8D0esPzuN2GAdnDUCHNvLF1jz5K8TjrUbGcDCYid4imHPnInUYNgEBimCI9bV8gdAT4
	oOpKoEyd7/p1AWY4TjygFvYHKZ2q0veXsw/YLQ1vGJkpfPxSu+TxLI1KWSwBntasBhw301/6Kwk
	K0+7ugduXHf1Y+bCmwcFt0S4JfQw6peulR/37mtEXRsU6S8iR8YoYbAbFNE9jRakh0tgm/z4271
	txWtNnn+vmL0ST0JqEFccD/aNSqtS76aEs0xQ35nY7w20
X-Received: by 2002:a17:90b:4ac9:b0:3ac:c005:cf07 with SMTP id
 98e67ed59e1d1-3acc005d046mr2346529a91.42.1792141227770; Fri, 16 Oct 2026
 02:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-Y0BY.v1.r0.20261015184107@mojatatu.com> <179214079109.408196.5152796723435821487@kernel.org>
In-Reply-To: <179214079109.408196.5152796723435821487@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 16 Oct 2026 05:00:16 -0400
X-Gm-Features: AclHuK9CcjmyT6uSXvsASMcDVgH1hUyqtUYOnWylPW-Z9sshIHj2VYWrJCmAPrw
Message-ID: <CAM0EoMnb78SoNwrqgH5308B_+Mh1sBtm+wJ=SFXtMHS-L2zfXg@mail.gmail.com>
Subject: Re: [PATCH net 0/2] net/sched: sch_teql: fix transmit-path regressions
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Patrick McHardy <kaber@trash.net>, owen kwan <owen@verialabs.com>, linux-rt-devel@lists.linux.dev, 
	stable@vger.kernel.org, sashiko-bot@kernel.org, 
	zdi-disclosures@trendmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 4:53=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>

Patch 1 is a followup that addresses an issue discovered by sashiko
and proven by our system.
Patch 2 was sent to the security list - likely from a drive-by AI
submission (i.e found and produced by an LLM). I am not getting
responses from the OP but have veried the legitimacy of the bug and we
have reproduced the issue; and it looks serious enough to push
upstream.

cheers,
jamal

> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
