Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793436405;
	b=MaK1AoK0Mv+52yLICjL5sIrZsEIdCDEZzaespkh1+rHBPrfX8rbcNqLpO1Qh8mWeUCaB
	 zsuGtJxi3hg58tFpu2n3eNZttV+UjPZ6ZUKku36O0KMpV+fk+2uHEtKGe5lMNQosKi3dp
	 4jA1HJ3WqiK/pIPjpb5/DV6MZsuJF5EZ1cKtFIPOISsRkRYAcer5D2x3HUTbwwfbXpw4E
	 +Gf0TzsrwyrOHQFf6Iu02KmTuQ6kdJgH0ouu8bOFD5OpDsabuFIVhscql5sIXW2dkbrJQ
	 AkCOgmQvptXnS4hXjAhFsbMstGrcWKIbFujiTZwir1N9K86eAFfN1vn3sw4e0+DCQ0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793436405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 Content-Type:MIME-Version:Content-Transfer-Encoding;
	bh=ADFJourLj++R5GH+t9pIXonKOLiFA6JXJ+zYJJ9JLn8=;
	b=jikxzk002LuDW6pk9fho1uzEl8NzMlB6ml3GYz+LEavRHs6zSmcGtYXYOZ2uPd0PwPdF
	 VGwGI4NkrefMXVvloyAvaL4f7yb8y5Sdtb4fQZdnC5swy3JHE64mykjp6CgTIyfm6cZjA
	 B8iWfLExchfudoR8Gjmmn5UXLVMvmqNFEE6Age0HhldKV2Qf83q19kxnpE/8A7EYCJHD+
	 Tus+qIQUotLPhflj3/R3lt1XQPuRB5YS9tMniTTV2mW/ZSY1UORjb+cqSOs/Q7PNGuuoI
	 XzVy10GrHzgivjmPXlcwS5bQSLj/mbO7awEpQBNAoGgoBpDpasuQ19mvKvjweMDsISg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oOJ62FCQ;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0311606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 08:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0311606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oOJ62FCQ
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2e934c6c1c8so5758145ad.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 01:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793436404; x=1794041204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ADFJourLj++R5GH+t9pIXonKOLiFA6JXJ+zYJJ9JLn8=;
        b=oOJ62FCQ2LNaqHJK4k6l2uTtYPCA2hD0PEmRn3vdYi+Bo2hnnqDBvJw4z6fEVaOauK
         EUnyNf8Cc2OIuzJOqX70/vOLgHR6YunD40orkxbhK7UNFIMMjL6h+qhKSenSxjKqldbI
         LQh+FAS8m2gaUtaaYfn3CTpCXSry1bo0LnmuaNogaBgT7D4KIMbKNcZQZf3L95j/YHIl
         7/3iIR+Ee9ZymPwZRPT9pjrVxYlwcq1ZoM/HlutTVoKVFun2S7ezykfiFEXUk7qaDZgZ
         2IIz8Ti/yhWyDCwq35CpW5fedNk54hkQujwwnyQKQ8iHS/4n7vxlsn9coOlxk5F+xWFI
         FDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793436404; x=1794041204;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ADFJourLj++R5GH+t9pIXonKOLiFA6JXJ+zYJJ9JLn8=;
        b=1ujUg1aTWanShWFTaYFX6vbvBolUZpfXpGfL3jENpQjenDe3ODGLBeJ9ec7YP6Pr58
         yWKElNA/NvmuUT+tn1Tt4XJzVBcI7oMiHY3iC4DzWwbKC9kh5UaoTzMLZ9jMqOGHdr98
         09J6WdPxng5+kPhseYh2sOonqgx8QzqSxbd1Ef5Xu+92ysZ1ChH6T1vElCbPFbSPdKEG
         o/7r0bvLIRLIapour7nqQfYUo/UWh5we45zKsB928pgra49SXLJfsPx8uq13xk3vNDhq
         Ji0TxjJV07Omw+EN0HJPg7fmLsSNQHfK38Za04ZQYT5V9uktGqLrJ+T3DWLHUtn1k57K
         mSTg==
X-Forwarded-Encrypted: i=1; AKwUvBy/cU0HyUjset0b6qiz268HuMhf2ChNg/8M9hHF6BZ1nQqATHKwFeoPHZMlGrrciS5V2plKijI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRiC9pYcvPUkVrHH2p4B5OlD8PMmitT3AIuj4xsESk8jRDo6cA
	FBrMrQv93P4DUrSCy2J//0uX6fEh42XrxtCHMx8SR05vgZGSUYmm09o=
X-Gm-Gg: AYBFou3DPOShxYTN0+hIVuYGtmMneFWzxB37F30upnorqsAqovlKKUn4MOFS3LjLLLt
	iVBSGOZ8DJoldPPZ3loq9OIWeCCBQHCBQzJob1CtrZFnBa5apELFfxeF+Xcu5WRHrJi0fgKLbX7
	VFj2Ne95PEunkBR4h5fKxasHas//wiQSM3mnzM2+jVOF9Pi31uyC5HkgAtSrdyFhkDdb6TW0A1G
	H9Gq75i5BZcaUhndd5JhAN4eV5c3qgJTdzyaIi/phYHz/aLBQRgWVM9g+XqCeXgzciVSkZIoqmb
	3K2zUnPlV7aC+RqxWBqG0Ev1ornWI0hVrVBatmqRX+Fbg8H0ElB721o8mXsOAK2qp+0b1EX5GMz
	OVsC8HGYXl7UPZ1ntd+XU6RodeaVFcLLwss6+3D0sWRKeSdVRGAqOxK2eQucDIImJdOitpiwRV+
	9cltukM9bjcLp55nTX50ZN/5NKqvddukcnohR3l7wa69H+eEqlNUMBemSxXLCUF94CqlZ3bBdsS
	M5aOvyzroQvFJVDUeSQGO+hpGjrf1Ae3O3HVk83sLwEI4DUxvuD43JUItph4D+4dNqrx9CdPK03
	hS8Hter5ytoUxv5jbrPVBiXCJO+Rk/cidDXglozwiFjA6F8=
X-Received: by 2002:a17:902:da4d:b0:2ea:4c42:573c with SMTP id d9443c01a7336-2eb364823cemr42643475ad.51.1793436404146;
        Sat, 31 Oct 2026 01:46:44 -0700 (PDT)
Received: from WIN-2DEDQG69EF6.localdomain ([2a06:a005:87f:ffff::102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3927ff6bsm14261305ad.52.2026.10.31.01.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 01:46:42 -0700 (PDT)
From: chenhan <chenhan0017.work@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: rust-for-linux@vger.kernel.org,
	boqun@kernel.org,
	fujita.tomonori@gmail.com,
	frederic@kernel.org,
	lyude@redhat.com,
	tglx@kernel.org,
	anna-maria@linutronix.de,
	jstultz@google.com,
	sboyd@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	miguel.ojeda.sandonis@gmail.com,
	tomo@flapping.org,
	georgeandrout13@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/3] rust: time: make Delta division and remainder fail
 consistently
Date: Sat, 31 Oct 2026 16:46:28 +0800
Message-Id: <20261031084628.13273-1-chenhan0017.work@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87bj8goc6x.fsf@t14s.mail-host-address-is-not-set>
References: <20261023130413.178487-1-chenhan0017.work@gmail.com> =?utf-8?q??=
 =?utf-8?q?=3Com4kxbW6RonEr7EJOnn5nizbkBZi1B662AdSPv=5FiWS7XNJXuPCDAsOeWG0SM?=
 =?utf-8?q?SeK7XqoTrwOPzwMC1jS2nKknXQ=3D=3D=40protonmail=2Einternalid=3E?=
 <20261023130413.178487-3-chenhan0017.work@gmail.com>
 <87bj8goc6x.fsf@t14s.mail-host-address-is-not-set>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andreas,=0D
=0D
Thanks for asking. I should have distinguished the non-zero-divisor=0D
requirement from the MIN/-1 check in those comments.=0D
=0D
> Why change the safety comment here? If the function is always safe to=0D
> call, the exclusion is not relevant. Was the old comment wrong?=0D
=0D
The old "regardless of the input values" statement is too broad. In the=0D
generic 32-bit implementation, div64_s64() goes through div64_u64() and=0D
div_u64_rem() to do_div(). The latter contains C division and remainder=0D
operations which require a non-zero divisor. The kernel's=0D
-fno-strict-overflow does not define division by zero. An architecture's=0D
divide-by-zero handling therefore does not establish that the C call is=0D
safe for every input across implementations.=0D
=0D
The zero-divisor check above the call supplies that precondition. I have=0D
updated the local comments for the next revision to cite that check=0D
explicitly, without grouping it with MIN/-1. For the division call:=0D
=0D
    // SAFETY: `rhs.value` is non-zero due to the check above.=0D
=0D
The MIN/-1 check preserves Rust's panic semantics; the generic=0D
32-bit helpers use unsigned magnitude division and wrapping sign=0D
arithmetic, so I should not present its rejection as a necessary safety=0D
precondition of those implementations.=0D
=0D
> Again, was the old safety comment wrong?=0D
=0D
The old pointer explanation was correct: the local rem supplies valid=0D
storage for the output. I expanded it to make the validity, alignment=0D
and writability of &mut rem explicit. The signed remainder helper also=0D
reaches the division path above, so the comment should explain both=0D
the non-zero divisor, established by the check, and the valid output=0D
pointer. The updated comments keep these separate from the MIN/-1=0D
behavior check; both runtime checks are unchanged.=0D
=0D
I have made the corresponding comment changes in the math helpers in=0D
patch 3 as well, so the explanation remains consistent after extraction.=0D
=0D
> Once kunit supports the `#[should_panic]` attribute, we can assert the=0D
> behavior on all platforms.=0D
=0D
Agreed; that would let us keep these panic cases as in-tree regression=0D
tests when the support is available.=0D
=0D
Best regards,=0D
chenhan=0D
