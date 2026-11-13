Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589147;
	b=5D5AorvHr3I3FboZIX1Bx10gvLTpQ35rSlr+GvyCO3v7+xPYD2ijgpIJFNbYDpAAj4FN
	 3Mle5Wsm/E5vy7pDq1ROaNq0L8XCSO6zqcZo9SRJa0JuzljyIT50J0bl2fDxHThBvpjvW
	 xSn1SOzFaW0kErnaoPRk193z00J4smB5r/topfjtt6cHX6RZ+peOATRv/e3ngspmnKDB9
	 PIEb7AvwTws+oYLjV0TRsZ6Cq/70scvpb8axWKvFsJpvBWu8SpPF/F8hUBQL4wAWw2HR9
	 UHKgywRl1QC6fIbKBHCoAyz5LZe8PQCtAQlWz8DLoP0GEP0tXJ4HSTjD3Z3z3NP7uiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=R+BzKiMLRPxV94V0qFjTOPyGhfJbaKW28pMhjhO9B2s=;
	b=qjSQ+tjQmV4gm3+yIgk2bRIF7BWpgYEGYJHEew0AM3s2RESE7JiwvatMZT9gA6/BxWUo
	 nyyNS1kPuSm238vwJ24V7jqJOZJXM+eQSHEzyvO7HoSsK1EGQXF6CCK1YbKBpzbbM3/xz
	 gPgVHOdHLVf6psCDa8KUxuxMaFyv9Eil5HTI4I1yhqg4FMuwLBXZ9PLrCzsOISF+wLbl6
	 nQVhGFv+DID3gxE4XoE6LJ7mE4xwPCzOrLwsZEGjKIkHG6s3jf3Dg16mL4GvdZrEdufdL
	 xm+C98ldkaKm8a1ZdM9j+kdWDzLKDb2fO/Y7T67NIPYD5kELcsDWOroEJWmLTAbaBOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=RV9vhORE;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A89D606A33D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A89D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=RV9vhORE
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15dd124bbe7so2920777c88.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794589147; x=1795193947; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R+BzKiMLRPxV94V0qFjTOPyGhfJbaKW28pMhjhO9B2s=;
        b=RV9vhOREryTkMlI9yBy81exMEbyOTftiMiWU84hvAq28tQiPAoYj64Ijy82JMnf9sZ
         LAklLUSEOMEmGRsiE+6pAqBaPqEckHbfS4LPvXx+PR07kGD4Isb0W6Ecra58JEoxs4b0
         fngqzYMvKWRclWX2hp852p98Di5sA2yqy0mp8hhmMQecs9J8Mi9WvoPafbk91kh21Gne
         TEaX88yaIvMPH5viczbp/RheZrULlXboydODQ+kzt3XH8lKc/WCQ8+Cnj1hk6r7MFQVY
         2q+hy01tuNlDaXyHx1q+mNd4fZe3BwmheY6518u5m1qgJBD++qjpeWnFet/rD+GK/SbP
         eVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589147; x=1795193947;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R+BzKiMLRPxV94V0qFjTOPyGhfJbaKW28pMhjhO9B2s=;
        b=Orkf9ERyt2ZyX0GUulJJ8PIVelhyuugYPKwOBUNrwJC11IsFJ5+OB9CAjQAVLYlFzl
         0jFxiXlprWOI4mvO44NBVHuagoRyuXKths5JYsobfAPEc6LBihzMtv9L8gSnLleEfutB
         R9QryHuB1du6hbXpnt0lg8xK7VljsLI4tVqvXFkQRFUgBNbTsJ58G+GZ5BwnLo2e/Y9d
         B3DjLTIgzQLUSTuNJUoH3gxWqya4imJ5In8Ce0sPHYeX1oobRPdn2dWgISmHv+9eTc/r
         y+r7t8qFFXj3eNtug9SWQ9xSFXjsBidOgOHycV1pI149e0ovLQM9RscVtWAAjf76+Ts/
         OLrA==
X-Gm-Message-State: APuU4Z9/QxKyXsVRnfdQ/EWVcG7XsiEI//0dBk01Zv9uNvr5DY45kApO
	bDGJB1faEV2O/GmjVWOPLMIPXs4Es6CB2jTjX848B1gMNN1DGV0zzfW+xBxFZoxqVZEXkQFa2Ar
	scdPs
X-Gm-Gg: AYBFou3W/+Ifjn+aXPqC/PUFk9PfucC0CyQzJUaLfxk1TLzcxKCYRiC1Ls1Rro8lVy0
	XKPpmykB4g2EHmILoWZUiqTDgRpSj/MjQGqJSv7KePxO6A95LGjtpHoth6WUBKyJyuRrhUzZzXJ
	nRSfthPKpAFl21IMXKcP1SNTChU2K49OxizLYZNGO/uIh4ktuFSppkUrlSmJp0mgbMLJ6ijAilX
	R76kwEyAUA40fb/eLV6KhZbZpvGzGOWhdJcIh8yn09bpQlwwrEgIB8Am8RkHweQ12hTuWrSfYp1
	EsoXFt9yf+H8fi8eNg9tDJ5iERGseZwRRoBnI0pgNXT2o5UrfYVsLwmcAZLRiwle8kKZjveF4fn
	IQoGcFuGTGtlO92V4SCGZX3h70nagoJ0zQKFre8/NGTwhBPhTrM8ujzB6aUkoBoHS784Vbj/FzY
	F9xEvBegBTVgKPJSy+iRT0FKydqYckFTeA2rAs0ddoOsAF3+qsq59YFevmwTTnsxHeMNehqMg0F
	mPsD9Ref/Jzuf+ZqjxXubqvCfGhIH6SCieETjTdIxVQ6zIFnbCzC1stdPTZ0n39P1hT5uLEDabu
	jRL9ep+S+tKUh0lYqSVAPHwud6PUG5cowFPx91MVdI0=
X-Received: by 2002:a05:701b:4301:b0:1ac:f84d:403b with SMTP id a92af1059eb24-1b50314c1famr2243797c88.8.1794589146688;
        Fri, 13 Nov 2026 08:59:06 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e195sm9982883c88.8.2026.11.13.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:59:06 -0800 (PST)
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
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjYueTogKGJ1aWxkKWltcGxp?=
 =?utf-8?b?Y2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHRpY2tfc2NoZWRfZmxhZ190?=
 =?utf-8?b?ZXN04oCZOyBkaWQgeW91IG1lLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 13 Nov 2026 16:59:05 -0000
Message-ID: <179458914535.43517.3593340704707065646@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.6.y:

---
implicit declaration of function ‘tick_sched_flag_test’; did you mean ‘tick_sched_handle’? [-Wimplicit-function-declaration] in kernel/time/tick-sched.o (kernel/time/tick-sched.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/kernel/time/tick-sched.c:336:34: error: implicit declaration of function ‘tick_sched_flag_test’; did you mean ‘tick_sched_handle’? [-Wimplicit-function-declaration]
  336 |                 if (WARN_ON_ONCE(tick_sched_flag_test(ts, TS_FLAG_INIDLE)))
      |                                  ^~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/asm-generic/bug.h:111:32: note: in definition of macro ‘WARN_ON_ONCE’
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
/tmp/kci/linux/kernel/time/tick-sched.c:336:59: error: ‘TS_FLAG_INIDLE’ undeclared (first use in this function)
  336 |                 if (WARN_ON_ONCE(tick_sched_flag_test(ts, TS_FLAG_INIDLE)))
      |                                                           ^~~~~~~~~~~~~~
/tmp/kci/linux/include/asm-generic/bug.h:111:32: note: in definition of macro ‘WARN_ON_ONCE’
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~
/tmp/kci/linux/kernel/time/tick-sched.c:336:59: note: each undeclared identifier is reported only once for each function it appears in
  336 |                 if (WARN_ON_ONCE(tick_sched_flag_test(ts, TS_FLAG_INIDLE)))
      |                                                           ^~~~~~~~~~~~~~
/tmp/kci/linux/include/asm-generic/bug.h:111:32: note: in definition of macro ‘WARN_ON_ONCE’
  111 |         int __ret_warn_on = !!(condition);                      \
      |                                ^~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:4c5ba53b1c152b95b5aa0d03af2a01409dfa9e01
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  12763ffa5ca52faea5c147f467790a4662343422

# Builds where the incident occurred:

## ppc64le_defconfig on (powerpc):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6af73b395b429d354e4de99f

#kernelci issue maestro:4c5ba53b1c152b95b5aa0d03af2a01409dfa9e01

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
