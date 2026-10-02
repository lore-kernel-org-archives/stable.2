Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAFA49B214
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969869; cv=pass; b=YwW6AeZEjgH/bljLGICNtQ99LhnG1SOYrYYHSfYO/4lLMCBlnGYWm2iPQUUzJCiQ+FZtdFPnR0PxG07Hs/PH+CrKtArSIS/csjuP8dxv5810H9WLjnUWkoCV0UQlHe3U5mvKrFOQn+UZ0WLG/SUB2ZiPHh0PnMUhBX2/j5Bozxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969869; c=relaxed/simple;
	bh=qASCd19Uk0Cd5DzyLi96eLYxoeQ6utlpuc1cdLLr1X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTbVMVvfgtANKjcvhAihr0WvUUrNuXX4nU7vn4v/BB10GkrDbEPlPay5H5+mwiYCgRC9rZHlPsBTIJ09LHjRGtTxImCgbWilAp0/Pi5KT8b5e4KVv2Kq3yLq2L9Xi0lUC3blurSrcErRU4qq0I4UxX9S7rZdCeBeYlP09DLrGOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baseten.com; spf=pass smtp.mailfrom=baseten.co; dkim=pass (2048-bit key) header.d=baseten.com header.i=@baseten.com header.b=jlI00ZmQ; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baseten.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baseten.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baseten.com header.i=@baseten.com header.b="jlI00ZmQ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b0ef9c76eso289606f8f.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790969859; cv=none;
        d=google.com; s=arc-20260327;
        b=dDynt5wY3RGlJmQDXZfi0iUepIlB/HmqPdgi9YQrpkU6Si3FJaoE3MX0FAhJHonPv8
         zlIznltLrXFTDQHeYBiPPSFRtXBiSWsqaOrkNtpGXPli7Cal9078amlGfpqG94fDV9ib
         dlTT4vyNuMBQ1DMySqQOdphBTd1YFZfUXkAcyZV7TwRJYym3alsZB+26rTYmuuLpmrrq
         ouz/gRQJs4u9zxylMZ/m7BoFW+lzzxmCgKgIl/CRN4uAI6IN5aEV4vq56U+YCd4VBzr2
         EaFtDPpAb4kydiCKLm0l/n//8zqHbwZxL2Ec0DJ+QxcMacHPqm9n43AfIl/ODdH3kJ/7
         G7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qASCd19Uk0Cd5DzyLi96eLYxoeQ6utlpuc1cdLLr1X4=;
        fh=4QJws8UnyelrpgiAVgVXzL45mViMYWpGsJn+3rVzZcE=;
        b=G1wBrk3vVEI9g/pjxualoPqyHIg+77yBhjuF9fA1qDEaQdgeGSEsLjp/XfYEycY7Jy
         1QrPMapLBLpsb7rAWIKVLNWRQBareRS2gUUpzFQpCU2j5WIMKIAQTkcJBIW9zISsGuQ7
         5lWli8Pv1SDmA8h4hYBAxxYTRwyBUYSiwKk++8dHvm/M+kJKq9pDnQQV2pkYPrPtIQLC
         uug2+DkLI2CzQE2/EWSoctA1up6HRYl1JDMoydok3YW0SeYgEwzQdnq2hIl8XQOmspIQ
         Cbuj9Zs94Gsg+QfDZe0mxU8Po0Am2OsYmkAWiO+A2dVtOOAuWJvOmw7UEVLEGltX4GVO
         W1Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baseten.com; s=google; t=1790969859; x=1791574659; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qASCd19Uk0Cd5DzyLi96eLYxoeQ6utlpuc1cdLLr1X4=;
        b=jlI00ZmQg55T6y+ACtZmrlP+llnR5/kCAXji4EcbcdVcpUlXJ1UVYWZYQ6anw5HyO7
         dKFdBiXZecRnj6w0ph1UR49TQaHIlWiVJrdYkACv4IUC1Pj4KgxLoIMSBv+listg2VIr
         2Om1s0yGgTOPoFQaMiTE45ClG4ZPPPr2saI0k4VTzqr65XqDjOdXw8OmtWsQjUzGknJP
         Qmm3gBlrNPvNZeOLhJqL0iMN7VakCQ1/zKZT95Cmrv1MHEJ/mAoCWzzMUw5FZajrWCtQ
         wahhvtswnsMznL0owu/CnGE4XGOBXBLqMbp3GyzXQDouyEqv/DVK8wZoCppuVJr/qCES
         RhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790969859; x=1791574659;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qASCd19Uk0Cd5DzyLi96eLYxoeQ6utlpuc1cdLLr1X4=;
        b=wU+VXrd8ASSYxPu7Jo4EkPaXuhD0T4uEDc0DFoxc5Dqos03D5E/J3ymlbiEAjiryej
         2ObAUnig+hg4SYSJn48DbBOQ51pNUKfMgEmwr85Ov0LfJWX/RafNLBK/YEy+bH5A8tju
         jglDemShRImyx6cKwzJNvI3fZ9yE7czGytALv3uuUI4DkR+PMJMvXnLMXnAX0hG12npE
         r5LQdb4Zyuyjfs/bCjwbKKx3Zf42P0eHrB1KeDNe5bYW8XDqHqoJGdfRSzq9tNCfB5Y8
         pOolahHH3Ih3CYW8H4q/0eLexnitUEYbnNYwRHKb4VT4qX7cfzE4phjnr9Kwhz2mM1nb
         Mbcw==
X-Gm-Message-State: AFq9FYLRIt0QF/DEL9iCVt9DtI7LR7LZfCHItUU9R7I/ZqsajN/yGE3N
	0GvPthwUu3x3r+SjvrEO7kNg8hrpWypZEoKFFeF8afZnyeU9SfCYjm458+vdtaXdwMQalgdsfs7
	yuAsMJkS+D20hv42Mx6J/vjqdSywcQHkCRct6naGs/Q==
X-Gm-Gg: AYBFou1lrtPpvT8PHzpbDQKT7gK1oPXoMBr6OalKZ1efkm5U2auSZcZyg6U7UkCtzup
	qtFEt6VtpW0VFM0v6jaq4rOb6wsS5vw5qrMBaUPZLEOXS2bpAhdbeyMngC8fEFSVGGbAQWiEGJz
	1quJuQKyU0oox4/XYKV9QMohZB2vWoyXkI0MiyTjpH7uXrre6yGbq3p2F48s8k6oodK8VDaGAsM
	EU0zENN5Vd0eNUjmv4OrTRePAGHYHMvCiwCdtO6oBLzIKM/SP9PAye9QEX82bl110Hd47QCDqR/
	5RFRHBaIKvocBhXswhdwR+TqKH7fggzr4+LqoPZ2gQrvGazj6CFMzw==
X-Received: by 2002:a5d:6f01:0:b0:487:40d:af29 with SMTP id
 ffacd0b85a97d-48c47ff2919mr624242f8f.36.1790969859562; Fri, 02 Oct 2026
 12:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3JwHPX_fJpg_Az3Et4-xrTdkcdtT20xw7Bhjz1FZSLW_xODQ@mail.gmail.com>
 <A90F7E87-80B5-47AA-BD31-0F0CA5A17862@nvidia.com> <CAL3JwHN34En=iiEB+Zyxo3=_xfODTY_k_kddb2njN+AJwSCnnw@mail.gmail.com>
 <7C66B0B0-1F43-41D9-9B4F-89956045D81C@nvidia.com>
In-Reply-To: <7C66B0B0-1F43-41D9-9B4F-89956045D81C@nvidia.com>
From: Deepak Nagaraj <deepak.nagaraj@baseten.com>
Date: Fri, 2 Oct 2026 12:37:26 -0700
X-Gm-Features: AclHuK_GkdjuPcp3228bwDkHlZ-6WYFslDFCrRcqb4DniaKrlLQTr_Rjx72HVfk
Message-ID: <CAL3JwHOy-0Cw_Z4G5BUv1BRhfWRpOA9RMffcQ0+WxGFuS=fHsg@mail.gmail.com>
Subject: Re: 6.12.110: kswapd NULL deref in list_lru_add, possibly related to
 xas_split_alloc backport
To: Zi Yan <ziy@nvidia.com>
Cc: stable@vger.kernel.org, mfleming@cloudflare.com, 
	Kaz Kato <kazuyoshi.kato@baseten.co>, Stephen Day <stephen.day@baseten.co>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Yan,

On Fri, Oct 2, 2026 at 12:10 PM Zi Yan <ziy@nvidia.com> wrote:
> Have you tried to run the updated kernel to see if the crash goes away?

No. I only compiled those two files and have not booted a patched
kernel. I also do not have a smaller reproducer than the kswapd panic
on that Amazon 6.12.110 kernel. Happy to try any suggestion you have.

> Rather than picking your patch below, I think we will need to backport
> commit aca1f2d5de17e ("mm/huge_memory: initialise workingset state before
> folio split"), although the backported version might need to change
> mapping_set_update() like what you did below.

Sounds good.

Thanks,
Deepak
