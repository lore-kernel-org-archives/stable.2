Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792852814;
	b=1f44UdxE64SKtCyf9K4950lK+1xQ5KQPr0IxHEP+zOyOEp/iFS5NTW6jJwlQ//QsjWcl
	 6Wg0t/83LWkz5Dbpza34Fnta8q0YHambso8UeSEmTCZe2Ev4+E20fnRGd4O6KGBnl8zJI
	 CL4dCZr80cXRx17I/arHpSs7cdrEXSYpci3S04gt6D4naxFsLTQtVVjZZeY5U51Dj28db
	 aPFkKIuRuuMrtTDGWrFvdSNBgRRUk88plDfTpTJi5w9yp0eyIUPqNziGF9M7DvSwtf1qm
	 HBT38yuyT5Fw5muUobAnAH8OZpkkmTWR3xb7L8HzdApbXaquNqZKFQwqbWaNERFMoAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=521MBfk16OaOkHeWnu+57WsvL6IjDdbIpPxbjAQEqUA=;
	b=Lcot3kkuGpmIdymxC1CsQ3M2wj0mWTGTsUv21J683aZl5PA31wc9p6MBwPhBTqVpMASi
	 DMxUph3HveS03itI7sY04dq8Vfj9FpxswSCZVj3QagGSyOprlvoL9YmsDwULxeBYSZeDV
	 W1GPpKT+NSbSa92wwBi2JgU8g9YkCR3aE5i1w92z9c0o5K0yW/BcLTWQYhf6tLPnPa7Hz
	 itwMebKfz+quWTUPN9RYantRG2ShdLReeP85VQPddBskrVsWOay3iODd4ESrAOHEqq03Z
	 FLiY7Khp3oBGHL/8A609UJknJFCykwtLFPJvuBobvqlRCA7v3K4kgxYIkiPjlajjRfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xgzv37X3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D6606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 14:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05D6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xgzv37X3
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so725422b3a.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 07:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792852813; cv=none;
        d=google.com; s=arc-20260327;
        b=ZOuQgHQOLbPN+CS7kwxgYF9pdCtBDVyCUyvtKLTNZ1IQK8GEB3GmOz3zpp2CXOmSs/
         moDFHGZjMSyMR0QivzCeVbgXtXee46OWw9WAZ7y2VE+v+BApcOc3hj1/qGIPTUDV7A+w
         KZOY+xpal7lvt86YPkXtwh2ZX3+VQXlkEff9e2H26oPaJMhlmXUOgsAf+0OLmUU/cCcI
         AycV0Bq0yzAvm85mJWAbnxOVgrclvE9RNgKTDWq42f8J6CO6/wm8LuYp20PaRwUu+Gz7
         VkxD7RPKD6/josT3tklqN4ys0pOSsiqZNStwpoBzapScBby+KqV68XwSK8N3xHj4LzW9
         /veg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=521MBfk16OaOkHeWnu+57WsvL6IjDdbIpPxbjAQEqUA=;
        fh=bbowFqTiARvdv4IvjutlEH3u6eaCxqDca+JXbiZt9T4=;
        b=NZ8TWPDNTjicwh0N87jREK6ykzfNT6WDnzy21oPhclAQVQnxVDKuo68auBFrHCuo41
         p6sbELFbddc1CyjoNxFFnHkOl9RNSwQEELqjFyGDO/uwYfbAXvKPU5sMtlJgWHwPOtyJ
         qp6/O+pigJqJD6rKogeTR7mI3WPwJlDs4+xAvzvbPdkvQXUTB8RiW+GRwBnxhnfWmpy8
         FtbenfdrjL4cRAtN8fFlpMWh2oul17a2f+r0jWFYWNvJy2SwbuhCn4esoOr1KmPxEG83
         P7XTx+n2dD7w22kaEt4tOWy7tK4YV+7w2VU1uS7AmvzbHyYBTcxw3W69gmrKl6u9KwnC
         ATzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852813; x=1793457613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=521MBfk16OaOkHeWnu+57WsvL6IjDdbIpPxbjAQEqUA=;
        b=xgzv37X3FqHjQKvsUmsU5QH8GxUc7mlpOw67gMqK3Zgtz11opM71SA8FV6cjvpaFBj
         ZzOgH01PY0IJmCwp0gD2Fn1KTExPslSXQAoqgnbwaLuzIAakYfyEYqUyTnvOZ5zNR1Qr
         K+XDi/np9LeBWOScutPJ9YrRXZMWzqGO23XH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852813; x=1793457613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=521MBfk16OaOkHeWnu+57WsvL6IjDdbIpPxbjAQEqUA=;
        b=y9i5NEOhH/wYQT+4wrCBOTeh4UpVEINLVbblyGNUR1tKqlLL6UPNyq6OnI6EPSloLW
         i4WUqyjJ9/gT3lCqh4QdtrEQmG/KVHYB1BgtrbyXp449GLCVY/IYjZ4x96u9UvWaTuoo
         Le9blNf87Rxv6T5ROi4hGq6p26hUjsZKU61cWM3IdPj9V2g7mfVWn87Ykq6FZZ+QXr8g
         CuDTzisLkrKxeeoQVlNskPRiVwhq9ySwC9oJAN/JTnW+1rLEk+7U2BiP/8EiBfeKn6kC
         cEh6wi0XABf5aoTct69IdGn9heu/g7FcBpzD2BQ5JltiAZVNYwkS7AGd3b/HcfAVcD3r
         xyTg==
X-Forwarded-Encrypted: i=1; AKwUvBy/m11eJ6/BwZuzz0mZKDT9A3de7d87OpQxmgNPilrBA5VTZ+wfncd46RPTaaY4SXIogF0VBqQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfe/4d2wrEWQKtr+hVMw/KJLKJan5g1UgE1Z0OvBiL2tey0MJm
	RkyZWwAr4NX05RIVY5eEUXo5q/0Me0taglZ2+BvaM+Ont4e0FLvu2rqKPO+Iy6USP0WxzT2WSU3
	5MMS48IvwoOkqJ/4fvbhsB+GYWiTDg6GMuPFOSkFD
X-Gm-Gg: AYBFou2fmDCtnq/NSIBknZ6nssTWozzPpkw0QcasSn8QVNyAfBflyAr8SqnN8TxDG60
	b5E46FxWcqh05xrewZQyeta7/ca7AIG/OswgMt6N3Os0lH/fIFleCYYltAWkUVUZ8VqpuBTjJJK
	Mw8lh/r9Qao/rgQsghRrNW4ggrpSGycezqipbiTnbGTNsbmBrhZXcy7zwEk4RAQ6dQYCKLvbfBU
	ZVGsaGs/DQG0dVh2Nd6T5UzdKRJJ8j0M91k/a6YN6O5mLMEmNqWMXUcRvllVcvyFhyh66XOZcsv
	0DtU43xAkq8camDtV9k0qOlzqC1ytHKhcmFCSC6Q7ALVOG9rLm8sAdnSqT2PnlMMT0IYFb316tH
	cgcgV+/fQseSV0uQzR50G2RYOUymT0ZaxiTa2uBAWY7hXkxu2K5iYsdoZt1xBqEL/+RWwOn3yF0
	EdPs99YsSmOxRY9FY=
X-Received: by 2002:a05:6a00:3d0c:b0:89e:5133:d98b with SMTP id
 d2e1a72fcca58-8a36689cbb8mr1693557b3a.24.1792852813080; Sat, 24 Oct 2026
 07:40:13 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-Y0BY.v2.r0.20261024060625@mojatatu.com> <179285257342.3327.7748817772985184863@kernel.org>
In-Reply-To: <179285257342.3327.7748817772985184863@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 24 Oct 2026 10:40:02 -0400
X-Gm-Features: AclHuK_IPQcN5_Ds5eUFIjDiEWNIuOK2ju1JXDTN4ajqveh7Xxel1G0VGM3dksM
Message-ID: <CAM0EoM=yCSeB9+Q8gFsB8sjQhddM9qWh8DOfSqqNtp6byubv2w@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] net/sched: sch_teql: fix transmit-path regressions
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	owen kwan <owen@verialabs.com>, linux-rt-devel@lists.linux.dev, stable@vger.kernel.org, 
	sashiko-bot@kernel.org, zdi-disclosures@trendmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patch 1 is a followup of a report by sashiko and  two was an
independent bug reported by Owen that our reproduction system verified
- i believe they found it by using an LLM to look for similar patterns
of some previously fixed bug.

cheers,
jamal

On Sat, Oct 24, 2026 at 10:36=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrot=
e:
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
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
