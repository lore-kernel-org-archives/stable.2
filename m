Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067147;
	b=QRj7VK/fi5DWYuPwluxVTgsdrelzLLMrLhiNXLZFBQsbVHVI+AeTYGnWUmszEcDNWUbn
	 qgZLPO78TepNWOY1wSbFDC6hi7MeTSXUhqr+2zascr2+M1r1/TlflsFMxUawQ3Gzp91ez
	 1x1S0kihFsMvUpbo4X+0vrUohuQAreLgyuZWTj4/VqNaaugRddQS688bKWNd3cUmNatih
	 5dOgFZEAXdfIPE55WZLvn66meIsfz8v+28y7h1W/5N9Hw3KtCq652bjz68kFz380WEYEx
	 i0ByZFuasmzYXaamMjTVIjd8fEKVTqlzv+qErHxnoXixVRmP6AJJKYQ5QoLm5yP8UUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=SzKZWsKUzLhCXn4JykxdBpbp4W6tytdetWyIlTUvz1I=;
	b=iHVnHv0Ztmzx8k940lrgfjUMOfnyXNzCWay5nBX0pCsY9uy9uPxhewjYXokTmnnrAEwO
	 FnRTp0njbfZMBQsOs2fOYGB5MFQ2cpBilLMCHgmYaMuJaL0Jmwjk/uLtJTin+v67OlrG8
	 J/3yFFOLg03chuvCPg9RIXG6haA781C37IsQUluG+Em+mv3CeWBW02hwmE+k8C/sSHOjX
	 37S0LUSxTlZwNMiTtNgyBDVubGuU20aFpBeVFfI560exidRcXgu7g4agrLrJl1frW0FwQ
	 7O8Ja1ScjG6SZKTZzxgjz5HvK6VwyEiuZ+VFUjCQXixrJCxBT2khAx19dYhUaX2Rh/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=OuGSKLXl;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70A1606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C70A1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=OuGSKLXl
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b244fb7fffso2345306c88.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 07:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794067146; x=1794671946; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SzKZWsKUzLhCXn4JykxdBpbp4W6tytdetWyIlTUvz1I=;
        b=OuGSKLXlS5u6r3pPt8AnjiA6gbWV+qJdflKhkAkENBRfc68TvvlBHfMcuw1F4Ntevf
         HdzWXUqiAPWUdCrWOdNlprLLhgxDmAzenL8riP302Clxqq9T0Zhj9qXKV7V6KwpK3P1/
         PuwQSDsItvzPKP/AYAnrk9kVrLY0mM74K8n75x1cpEN0WInwFnqJ48eRujFgi+zoT5uH
         J5JF2zRXqsA/nklpT52MDxJ2M/H0QFPntiYI+RfxRhaShAREBiKLvVBzfrOzwpSRr316
         rot70FIX4hD6EtL5rXbl0ich+PciUr2/IvSATqdqALD29Y2cPVzouXDOVx5oztTW9Qtk
         W8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067146; x=1794671946;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzKZWsKUzLhCXn4JykxdBpbp4W6tytdetWyIlTUvz1I=;
        b=uiJEZJNVo9LWAw9sI77OekWnWlDjXeh65A56LVYu9HSm0V7G5II8pSM7qZPq+JgQrA
         7WU0/GYvhqDdiQVjVfvz2MRoIuHKcWJg6Z3UK6VV8Utuu0BSZrNXJ4LLN3B7KSISL/v8
         EvaUaV2+o/XHaJD9a0SR4NgV60zhS9sBOpwPAKfIXMsrDRTY09UKnH+k21oYQ8+gNiDf
         CGvVxMz9mcFCnpQhOkJB3y5FCogzfpK5aOgbVflp6cSl+OPoIK7RcKyseRmHKI7HaaDd
         tvAe5HtKXiOb+6MIh1ej/4JA2k87y4fBqR8KRDzRRDKlE/wMA5HrIY4zGcbcJNLspArj
         6FSg==
X-Gm-Message-State: APuU4Z+nB0UPzAN/9EqX68KdsGgfgnJfsEVI0QAl8oDkUZS56Box3C8d
	q/5vIVsNtpNH4TGBy9HOiL2MsTnhNLuRVPhVYAyZUfY2wOtLRKlRo2yexnzMZlqpwqfB9rKLEQg
	57bTC
X-Gm-Gg: AYBFou0PX1sFFupb0I0vOZ7uhKZ5bOUkhjB/bTraRzJOt5k7jGyvXoaz4pjQxfz7Ql8
	O/VFKw65YLxurRSgfJ5c8OWg/4M3v7QleTJXt2dNtZi41EvSZLjAgZrrRVveG6ySIZJdHVHvnl+
	LO3lCVn6ie1bmETS9e8spiopUTuZC8uOqoJzhFvzZG8yM8/pjR5QXmB4Ex1dgm5REk87JETLPbY
	/ZcAa6pcKsHl5dDQhDETlpb7EytbdYr4RIiJahgGy/p+2hUM5lSWfzo5dHTH3mBPSz0w5rmzwrk
	fOEs44QuD9HTQ8YdLmS0gFR/3e199FOGQ3WkrlOqKE+sPO4iLvLhy0jG7pGFGgENtgoC/RZOn/m
	sAbEWTPib5U1T7PMA9Hjk7q1gvTizBTPhYt2oiLXuFuAiwPS+EY6Ex+6y+t/z+5TwUXGVE5vjYn
	ICyVfx2kBpMEn7PD7eF+td/9WBhMZbwkFZztYQLHPKSCOiMVBmncFlfO7mdB6SczOgtBpelGpKk
	jkiL5mjL4WKEXel4Z1ShZ8qxOxliKvTC7HgqOoELOq+jitwU7WRfVkcYmutgn7Fxq1Js6fto8B4
	AMijwM/MgPelyXyRaAFNOg==
X-Received: by 2002:a05:7022:ea8c:b0:168:3243:c91a with SMTP id a92af1059eb24-1b25d33859bmr8356882c88.13.1794067145667;
        Sat, 07 Nov 2026 07:59:05 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8c4f28dsm16280572eec.9.2026.11.07.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:59:04 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build)call to undeclared
 function
 'cfi_get_func_hash'; ISO C99 and later ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 07 Nov 2026 15:59:04 -0000
Message-ID: <179406714410.479450.10067991365549305730@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
call to undeclared function 'cfi_get_func_hash'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in arch/arm/mach-imx/pm-imx6.o (arch/arm/mach-imx/pm-imx6.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm/mach-imx/pm-imx6.c:588:3: error: call to undeclared function 'cfi_get_func_hash'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  588 |                 cfi_get_func_hash((void *)((uintptr_t)&imx6_suspend & ~1UL));
      |                 ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:8f40f922c05fb9fc1b17ab61be632e246387e068
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  07f920ac6ca0ecfc2aa02a15d7f2040bd35c9e89

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef3a015b429d354e115061

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef39fd5b429d354e11505e

#kernelci issue maestro:8f40f922c05fb9fc1b17ab61be632e246387e068

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
