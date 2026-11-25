Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625947;
	b=PWH0I8pRtvCc0fDF/YtE/IRB+ptSU2nuz7h4PEUR0xf8uKVaL3jbjEBjQh15N1MDmllT
	 u8DaMxeAfyWp6OvUbgU9kDNqpA4/gce3CRo0H4UK+Bs+/Whg0SkTLCoqRTVQan1Tg3MFK
	 +m9TelqRHpNYIz3scWuHeuUs/lslAePEV+rRhI5Z+GUMYysdMcM9CAU4Sq/j356RB4t2i
	 6JjOf7z1oU01OCsxjdCh3yg2yl6OI5hTUDXUOQAea38SCW1XmI2ZG51C+DLq7D+PzaZH0
	 0+hLIJFCwqE4RL4gpUzS5HUMmI/6TqdgMyZo3AGDJQZKl0nPITU93toZh/F5kk8NqNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=WrRbKjYSYZg56TNAvnFFEh1M2ZtHn8O0RyBgsiFA75I=;
	b=R4zT8UHgQdrdGZgnLjgCCrSpEvou3YK39QzuIEtEXqTt2ESLH0BjuDlBaFoipmo02wS5
	 5SpALXgovVvvX4V0RrJmR2SKegmbgrHSz9ZE477J7GsR0YohPbnKAGwbSbP7va2+mI1y+
	 bMZiARvYb/r1Gy8QGrXU41IuvDJLSfyvpRe033clq+NECk8OB3qYGOaYECCDvwBfinzIV
	 BwDKuQattSChjQtwTALWOPU06vVOGWV7HkIPfd51mXp9z+zpANV2og8udvhdRcyAAFDtR
	 lTeJNGO00UTfsMPCr0HkIjtCxGdFVfoZa64LANuuT4Or1Da23xMNFKg/y1YZJQIHQnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=OaF9At84;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183C606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8183C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=OaF9At84
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b546061d58so13661438c88.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795625945; x=1796230745; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WrRbKjYSYZg56TNAvnFFEh1M2ZtHn8O0RyBgsiFA75I=;
        b=OaF9At84zyXwLzMUG+joEPXAftWD0RtTxST2RwLx7ZaexRT2laHvkLVhXgLRaBGWRD
         EGtIIgldOQKo0PH0Ls/8KJgxrO1YHogVMP7yCOzYvfkElqj+wVwUUKrcn9zpO7aVQdzM
         XOZ6HHhrzpQdHmDedQAH5D+cMWKrMKkW61+lnswhuMxLUpdvqwPkNz8FO8Bn9dLBb2Ko
         cQfMpbtwQaiFswrQl0vlbKPq1yFLwD1S5gZH21bnV0cZ0ImAh4dg9jkVB9oHCV3+iRLa
         ILKOSQg6jLoFKA3b4t7O6x26ybX2sBgSj277C1oKr+S0X7kajGsda2orUrc9i2T3TMOY
         MxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625945; x=1796230745;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WrRbKjYSYZg56TNAvnFFEh1M2ZtHn8O0RyBgsiFA75I=;
        b=yWVf/PvVaUQy92qg7XAfXZRyMmcvq+5mLGYVL03mXkjrRytMnYyK3nOufIsYkHFPai
         POup+CCDtDRCuEtEG2Bqhl5GvWl/z4r442B7TWCJ1GSHbEHP+a/ZbILaD38GYq5Lvxyg
         48AIU31abW9pBbLLeaTO/P16lEiOjkUGjO573Q31lFEUtIP4FzH5N++cu2AFhAcHr9ib
         Sft5jXDNbTb074iewoZMe5FGBQFJ9f04ceuM2LI7xsy6jiWneik957eM1DS6RGZ6iGso
         jbwqGeF6EJFr2IBpdm4N2Ua9JI+uR5+DzqoKSkZDO2Do4unbC98BhW+bsv/ykpKvrzeF
         sFUg==
X-Gm-Message-State: APuU4Z+ByoAz6ESef13GnpQNHCs8dsKti8d+ql8rJc8kP2x8D7rGjy+i
	3yEOm34j6RP9DuSUceG1PseTqIp9lgQUwpM5ISLwecs3hiMc2yrEhblpSFh8BiQSjsY=
X-Gm-Gg: AZFdTZfze2uHN/rk5t773s9BfbroagLFOqmvD0WH7YHYd2t7YiOh0ZHuYcRg9+IDzUG
	A9Y92/j1O8yzcMZUyKugnNoVwwm2/JlJ66PjTuxOw5s2cDIJPWRToy3t8dG7i8sY0caUUXwwiyl
	3pwpjpuZavPAf9IyAWFANURaqzcIW01JI6hQIU7w4qYNgImaTWeBL5N+GtNAoyMIlZiNRjyH/K5
	6Ou0HAdyyJ/iuhTFOIPvSugZyxDevOKYhVem3aDFLjcUvoRiL1RIUxvq+Wh5uEF74AybY5Dmkxo
	IZ7V8LQBQV1tKL8rGoZnOIMco5lMBlOLnKQwrL4EpfELTyfvxCY59RFympXOpus6iBQWWUgwmn5
	LNh9Emu/XdlIgMZSE5SvQlJFLxSuE+CNQHX6GaYR6D14rvTW2FlGkaKE6ijVewpYjHrvhyBAEaX
	Vw+s7DOn245ghjQU213x7zYqP8yQdZsKhB2OM9enBAHGI7iudlgPdA52h4GBUIoLxGSoGYed/cT
	7x7/5IQarofMZfRLHGtKubB2lq5NvoR9zbdJMvPkkL3PkwcF8/JBkxeQsm75eO8nzz3b7+xEbex
	Vyy0pZSar1LC/n45jTYZLQKapZU+7ctFJXf+fMQSjPY=
X-Received: by 2002:a05:7300:f68e:b0:369:f291:49da with SMTP id 5a478bee46e88-38571814b1dmr19058239eec.40.1795625945355;
        Wed, 25 Nov 2026 08:59:05 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567ea2cc5sm51676757eec.29.2026.11.25.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:59:04 -0800 (PST)
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
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)call to undeclared
 function
 'dwmac_is_xmac'; ISO C99 and later do n...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 16:59:04 -0000
Message-ID: <179562594381.105915.18403136017178757571@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.12.y:

---
call to undeclared function 'dwmac_is_xmac'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.o (drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1772:7: error: call to undeclared function 'dwmac_is_xmac'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1772 |         if (!dwmac_is_xmac(priv->plat->core_type))
      |              ^
/tmp/kci/linux/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:1772:33: error: no member named 'core_type' in 'struct plat_stmmacenet_data'
 1772 |         if (!dwmac_is_xmac(priv->plat->core_type))
      |                            ~~~~~~~~~~  ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:e7b818e0cfbc81d019b2c178ef220468dfb9fab1
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  87d55cd4c947e78a8b4c2a1d654ba54951a29faa

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f156286e1965ecb3958a

## x86_64_defconfig+allmodconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f169286e1965ecb39779

#kernelci issue maestro:e7b818e0cfbc81d019b2c178ef220468dfb9fab1

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
