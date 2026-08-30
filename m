Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5533F104C
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788061832; cv=pass; b=bLEW8WjdweyG6ztCm23DxBKveFCHirqPIaGUEedNLTUPBmuU8mHCeCu5CvwsLb6cyKijHLWHLUhUqi52C3nmghHAOMZiPyC3FgAC3cD9KbKp9oGa4fIGXNJqNjCkifnLdmRzBwmlwFzMsO78todCMgm1IWSSR0NrUF5Jwutiec0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788061832; c=relaxed/simple;
	bh=f97Ay/p2YyNFEdxu3VndgqAsEBu4RqcXl6xNlESrPTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIt9vCS+SvjhXlgVnFoKyo2HFs9ncLVISjfRKWZi1DtpZNYU/cUsia9ylqkK9JX+QZa3WxGbikWhdMQSWrmX8JoF8Jj9GEm9eF2qAp8VC/gk+JuKYAnUg4TLpQ9EXOcWvFwkqRykS8YXJwN0ZqU52nrdHR6aihV0IABn8CpPllQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=CYzZwEQA; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="CYzZwEQA"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-484392e3d33so22417f8f.2
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 20:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788061829; cv=none;
        d=google.com; s=arc-20260327;
        b=LUHIoEb3lxyCyEM1SqjVdOlZGoabEtSmdpaGN35vu3BlMnnmb41QNKtbwQphqeja+0
         UU+/xlyFQ/ygj6LRo13mm0KSld3d9r8qN2Zfc0v07SZgwBnqlPx7avNup09kvF8n9/QR
         ZBkW094dqD6kxvn+fSGLpf2G5sGX0bUFJOSX6WReOpQQHHFEtSkj+wujKYKpFnvmfRNa
         r5Talm17EUIgOtmM1FslHYWNrwIRN2890Kf/mJk40Z+0hQshuiTz2q0dRprwUdpXXKDY
         Z15NQn82zBCB79yfjd/9ziQl3b9SPqVJftO/4+7O/r7w5JnhNYjnFnQ9FZ3to2dxrDR3
         vh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f97Ay/p2YyNFEdxu3VndgqAsEBu4RqcXl6xNlESrPTo=;
        fh=HrherYvb8JFFtrAkrN23+y91n6WQMH58ylcLPA5fAYQ=;
        b=W0By9KLHPFgTGvldHMB/D69S0BCm2vo4ZHQwEA69TsvZScc2u46mDjXFPHK1pLCTN9
         UZxf+7uQh7lsP+dnHBOpXUihrlCAZfQbauAxxkxfBs9diuC0WZeCMw07HwvOM4Woz49g
         NLwyogvscU5mWLqm6sk4yd2++D5Csv7Ko45fVuAvkqqNfjjUi5Qv0hXH0glQJZCbtnL0
         c9G6EGxU/1uidfRuOzp72up9cMDgPHdQ/MIjJOuDDs5Wc7Hz9jdnaUcL4mNPn2TIprQ4
         amIu4snofjqhrRUY0gJRP74pFwtfJDBcVta5l9HT7RUD+N5FsJYBv5YGng/qDdNKtlYf
         XQdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1788061829; x=1788666629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f97Ay/p2YyNFEdxu3VndgqAsEBu4RqcXl6xNlESrPTo=;
        b=CYzZwEQAhri8a97UbOPt0WdKf486Y8203STpF86eXlTfXZmxfROCFImG3cEV+mhICc
         jg1gamxUFtIfZBaPzAFPDmgydX1KcVi4G3u5KwqOSmoEtF0SI28y0y8ovxtirx5ghg9y
         nAgqSCGnH+ZX6lDNZAV7SDSTnHwwn6/cQGJQ8tbKVoAgdtGsL2H5koFA01jnk04K2768
         ++l+yzgA7W5QD3GTPJWGTBmnTgUlp6xThaz/W28H2JnBo8X7DMQodVvHlLEt6aryvW6Z
         pbNqCkOoIgLPzX9tUCh+iIDQedVBqsl6STCTRpJJhihzOQ6CQxUCJdRpomBo9AjtjLU4
         XG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788061829; x=1788666629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f97Ay/p2YyNFEdxu3VndgqAsEBu4RqcXl6xNlESrPTo=;
        b=ZPIW0R3gwpMU0J1zrgRwZ33V112j6Eh8tOWIshSaIPEBgl/8YKB/6M4vmMvotp8RcF
         7R7ktUQ1puH1B4g0P8cIPKoLu2no/UOuIXLIkT55WEQCKgyFfjbtYxc11SneR55iD4L7
         zpNoVh9hACvb21GUBw8itBtPRoV/GgiKq99NL3iY8e1k8G+BNtND0b2+AU40R8uD7u3Q
         2/sZH2c3OkKKNJxS1IkOFiCVKRX3O39dzXnwYw7VXr8z3kGjfKJP69ohrmQus42feEtu
         vpZ+Ts9rg4xuaITRQo5HaXEbnZws6Aa3AyIKIIW0V8G7kNNGuwJ7EuPuJjkWwZJOXlo+
         p3Vw==
X-Gm-Message-State: AFuF++mZtYDbLyKdR6ihzetg2muit0zXGvYGmQ4253aR9K1eoUorY93h
	AKso+yloFX60gsGrqu3zLvs6PUi2d2IjEhuoASekh6wVWTfkzKUtWMPP72MA1QvcKL4UKvCY8Oo
	wfMlJW9MMNes7p5QbuQPzMy2ClZ8a3I6e9fD2kPBl6XrqoIATn1sJ
X-Gm-Gg: AYBFou1C7RcXLbOzadb5ZRbBpY2aA/Z5G2j7pBp//EoBzCICf09TWl/73yxKtsZiT3X
	ByEl8bOvW9+c9OtSllD9yjvi04cfMW7vus4reR/hrf2ogudi/vij2nVxz460rkrUVVbPkcgF00n
	V3zh0OHz3dFDuQeNDvuay97u1VbuZtgK4LbYEP/oWMcJua631VeksOTUiIintAwNH1i+m5PSuSA
	ZU64O0mWX/UhUVHrIdJKKnClhQhjqhUck/9vXoCZBcFffCaX0A5JC6w/9RvPIVI9OpvYm6fYcg7
	YmwWUo/kYP/W3ZmBNeCmMhbkqtU7rtGgFc4LXqQUGg3di8/2+StfJI/07C7YhN6tT3C/jvlTo0l
	WtFefqOiru4JFBBxJQQ8J3XX4LBaoLDdTMQ==
X-Received: by 2002:a05:6000:3106:b0:47f:8d71:210a with SMTP id
 ffacd0b85a97d-482f79cf4d0mr23760565f8f.15.1788061829059; Sat, 29 Aug 2026
 20:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828232904.91398-1-artem@trailofbits.com> <20260829-stable-daily-0003-cve-fixes-6-1@kernel.org>
In-Reply-To: <20260829-stable-daily-0003-cve-fixes-6-1@kernel.org>
From: Artem Dinaburg <artem@trailofbits.com>
Date: Sat, 29 Aug 2026 23:49:52 -0400
X-Gm-Features: AcwNN1VjCPAdcW43O3vcw58k9-IY4xNgQlgNaI0KZYWRt_PndTeiGfc9KcObUsU
Message-ID: <CAP3zxaDkc3nz2tGDfScvAXKj_O_0PsVksJJ6u366aJ-VJ7SxYg@mail.gmail.com>
Subject: Re: Please consider these upstream CVE fixes for 6.1.y
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you so much for the quick queue. I have drafted emails for
effectively-free CVE pickups in other stable kernels and will send
once I validate they build post-patch.

Thanks,
Artem

On Sat, Aug 29, 2026 at 11:01=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> On Fri, Aug 28, 2026 at 07:29:04PM -0400, Artem Dinaburg wrote:
> > Could you please queue these commits for 6.1.y?
>
> Queued for 6.1, thanks. 17 of the 18 were also missing from 6.18, 6.12 an=
d/or
> 6.6, so they went to those trees too rather than leaving the newer trees =
behind
> the older one, plus the applicable subset on 5.15 and 5.10.
>
> --
> Thanks,
> Sasha
