Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794560995;
	b=rdCnApv9YpH43JVUvb4/twoBSa2gk+68gBRq/fXaja/DNNUvpdPzEY/qHVFlVT/+7Vp0
	 qYusExc8n6DkCM1DgWcy+rAiCe9C9CNBBwz6W1qyrzG966ibBcCVTHnsm8QfGKS1IY23D
	 LEaTBNgVAmO5kOaeQB0TkBA4j2JhxVGL2lTpeP3AbGFOB+gWjgj3U0itJWfkSoGKeic0Y
	 rEkD5pyc4n4GdFKFwWxlGHJrwD45pActk3zBgAqoHWpWmGp6SZCJPD2qjTe2fUC/GlB+p
	 eZvNGM8Pkk1R+FnKxLZRbQR7AiOpTACVocg8XnKfDrSPzAdl/UDHIw9oRARKlaLxHmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=guR2kn0I9WVyI0WwVW8m8P4IC07cc5z6OUtXdezJXW0=;
	b=GoVpNj0KjonIbLzNrobATxebr25FGJghwYJHwAQUnTJ7xS8IFEu1oceREp7o59f2GKBu
	 5x1cXw/blPbDAv6etdPfHVHpVYTKDCAMvptTXKjL5jzi470LhvFdkGWky+vJ9RYGaU+wt
	 wcYO2B50WpWuq73DjJSTDxRratmg2ng//H1xiSA6UEI7i1t1aeFrIJsSE0pwlFqitSslJ
	 Qk2AzRqRQrLET88q7IK4e6MpoRmark14nMYJO4n7qaktfmPHu+V4lZaNvntTELdBJYHNG
	 Ps1YeRw/hd+OlSuyvtHlzgMYN/aJkdFv1M+Ar88btRakxL+sOBKc2Ooxo7ebXOI/MBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flashbots.net;
	spf=pass smtp.mailfrom=flashbots.net;
	dkim=pass header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=cVF2s76c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E0E606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1E0E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flashbots.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flashbots.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=cVF2s76c
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-451a49abd8aso1196042fac.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:09:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794560993; cv=none;
        d=google.com; s=arc-20260327;
        b=D2QqOIQEqYDv1VL/GBws9JjB7r5B85g/CWxtzEyvjCPcrFTdFE7Gvc4Q4dq5Bq23FK
         dFrE9jRNZWfgbW96WZ5msVX6veqkts3UFCRm5XpoerSPRH7lXuTQAD+WaaqZzUKqliOD
         sTvCcPs75GHg3eSfa0nxpszb8ii/7cpVhFGPakA22Kiwxdb51hZJngw9x2YNvK+3Zqf2
         GzVnaxNe1jU6zRn5Xvd0FNDqlafwb7a+q8dtGu4fkrictLD24Rqq4SatLfSwTiumT4jx
         V/ep61g4OaEsPaNisfZuIqzkZKEbV1zG3GwLpD/kWXAzUSoBjp+xY4MrB0o3NI3Qb3n9
         0wFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=guR2kn0I9WVyI0WwVW8m8P4IC07cc5z6OUtXdezJXW0=;
        fh=cdNWyR6HTkSGHYuHvzPvhccMN4ihejxV54IAtL81XbM=;
        b=InAHMrmPkAMW5RzrU8u5+6+LIbwPKGjFEXoG1hAASmoJqg4Mq02iAJlggRVN/gCOFn
         a5KUt+51TWntKRhN+M/vB8GXI/OGJhcya+p0HEexksQf9zj0P941E5DxsMV03guzEse/
         IeHxis6/cuWK2MLir6VjsPZ6VzRTMNb8uxbrAFOdIzYinqW1vX5S0kFEOJQhNPTqbDdb
         PVE1kIuxxrnlCLP4D5rEtJXW8hDqsCe2F98G+sj6ktJKpOg10Oquj8msrlgx2cXon+dF
         GCuS356g5cPcfJ2XMzJS2cFbxHrv+qbsiSSrc3deZZ6JDIsEzQGSL+poFttuDFvDFiaf
         c7KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flashbots.net; s=google; t=1794560993; x=1795165793; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=guR2kn0I9WVyI0WwVW8m8P4IC07cc5z6OUtXdezJXW0=;
        b=cVF2s76crrUEBSBW36t5JDEzTv4J7cNTCDmf+lJz7rwwx6KqLEpuy73WkOOYTKprwL
         yqKWkmIv4Kl7sLZFr8Yds98KHN4fZwFGhK8sFRSJ1S455RdEsUYCuGVMDkqFDjVaEsvS
         wCO5BrPQr4RwKdUm2+HSF1rsKJHm2mMV3CWFpmU9gtMpsTS1Z5PCRx8kvfvxZENN3/3X
         +sWEFmk6kdzZeQSm2hzNJet/YI4aB3FL93uHee3qfThMFp+f1vfx4xOwk9BeR28Jm7Bx
         2fHT5JxtJthzpRgDW0upHqz8gcyDOba1Y9X2fySWkzASsU9nZirNvgZ8E0ZOIEU37DQc
         u8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794560993; x=1795165793;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=guR2kn0I9WVyI0WwVW8m8P4IC07cc5z6OUtXdezJXW0=;
        b=S0ZKD2nvr0kGAGGKxbgtKUVzRGoqNRVc09vbO8zJbWIQv161VMtvFlZwf5rLAMmNon
         ezU9jZjm2EirNlYxRRz+ld/ylr1qR828ORptCeQXkRcaIUqCabiA1bt6fB3uZoTQaL/2
         LKI9blFQGM6nQ6X3k9r7SG7JMcE1rvMkcFgeBYLZX68Gd1A41Ei9tSfPdruY7wfWMFwJ
         gZd/piJYWQ0SAgQdUpTJnfKRj/LtB8K+0a2AILfG2CrFnt88mVVknpKp2eSA9CkSAxdM
         yrZog//hCIrSiRnwBjbW98TXOEK5W3sWvLnf5nIJB5OOv0T0L6HSg3rcDavj43waFTNZ
         O9Bw==
X-Forwarded-Encrypted: i=1; AL+hErHjVFkxXMjFTkw7q/6veITBo2I0grfQGDY3eMVngSNVnP/QUqVwcXnhIdXV2NgfZKTFAhSr1oQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kSEpnnMfpT6KH2l9Tt7pSFDs+mSPFZg2ts5dlpwzJ663P9bOA
	r3F1jsAvu66oX9M6cyAxH0N8MLSJB+1xA/k3FjLMozA/s9MtbLZDEvEsxZZx5pQAzyK2HvKzc5F
	5LLv3cUYAfGCQvqg2PjAiU5PI9PSTcJtCmdCnAY34gw==
X-Gm-Gg: AYBFou27hBcsKkL7QfGBOQrl63Yo4v+FTpMIm7eibshJATIAOUWWsmPlTcG7v0XnLME
	oTnkAFUkiy3pAgNRL4Y72jVEGXV37kq1/Qoi7i+SeLBN4SMq59qwVTqqDkBWQOBFJzAkyanEQ3e
	oxwl96HNn2tJA9BgvzLsnQIMao+bdaP6JjKdBApOMYrcQKDAJLxoCCB3PmUYOn//+hK2tTQzEUh
	FZ1vywbmlenSIAZZMODjbqB225zLBACyAebf3bQ+D6FVLbqmPtGdvROCEzbcox1kFx4cZeNuFH9
	jhxpk3rZkRLZJUEv2JLqWKbWjEMRx+y9NbLfur3852tKJ5i3jjqfOp6S0UmoZP7xExNahpYWREp
	Ik+iYhP3WHGOreaktbjOj5k/8v2Xi5OxYglweDXL+PKZzJARZEfe1+xQno5l6irkNquME6vrRQO
	RCC1CbBp0WPt/M9z/I9JjS2AOdiiOEw9UsTGVPnK9BPQfMLv8t/CwcB8Cz+SrTVxHaU7KoJYvUT
	g==
X-Received: by 2002:a05:6870:e135:b0:43b:b245:30ac with SMTP id
 586e51a60fabf-4afdf492b47mr2095487fac.16.1794560993407; Fri, 13 Nov 2026
 01:09:53 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
 <3b582cdcfe37f1d01ee71611ab2611f845261089.camel@intel.com> <CAKV3HMM9BKpmgWeFqRqamAsqqiofj+TG4DrOEHmbUyE0FjA7+w@mail.gmail.com>
In-Reply-To: <CAKV3HMM9BKpmgWeFqRqamAsqqiofj+TG4DrOEHmbUyE0FjA7+w@mail.gmail.com>
From: Moe Mahhouk <moe@flashbots.net>
Date: Fri, 13 Nov 2026 09:09:41 +0000
X-Gm-Features: AclHuK8gjoF7QTD6gz3W2dlc8aBwAvH7LfNyoPplzwlNGb-GET7hpsX60d1d4kI
Message-ID: <CAKV3HMOnY9LXvtFjnNKzfhVwxf7v-ZqDrRfceyLeVLP82x=bnQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5B=F0=9F=9A=A8ext=5D_Re=3A_=5BPATCH_v3_0=2F2=5D_virt=3A_tdx=2Dguest=3A_Fi?=
	=?UTF-8?Q?x_and_speed_up_the_wait_for_a_Quote?=
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"djbw@kernel.org" <djbw@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Miao, Jun" <jun.miao@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

This is a gentle reminder; it has been 10 days since my last reply
without feedback. Do you have any thoughts on it?
Kind regards
