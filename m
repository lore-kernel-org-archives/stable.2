Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622347;
	b=2dBN4++BCY22cYRipuITl2OCmkc5UJp7MEdVqYdCL754GOhajQ1tvwKN2kso+Ph7FcBz
	 z8Hhdpv4WjWI8ziE5LF2SD0CeIDcClJaDNuDOuqcu/EulKKBPy00Q0letc27b/Mpef7Zh
	 145YVlC/1xfGsPhus0KRlIPRY5eNV2xRMdEjNge9QLTVaGJaZw9bSd/cs1hyN7k52RmJo
	 NLGsl2oOCsAUu8mrPD3B7gDHjJjwWVZX4whGl3qgu5Jgfcj58VRGVkpOJOk7LJs/g/Jm9
	 8PAuIiW3DnR3wS1soSEfoa+d0+EJ+z2yCre7EyxipF+UuqMY0Au8dd+aFwzsDSGx2zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=90FJxPubVvE6pEkEOVszoN3+jM2H67FaSP7SkaiPbSM=;
	b=zQR1PjxFwaP5h4FmhEX6PoslHLYE+PZ4KJZrwOnQqusY+86y+u2FlRksc3ETquNiHv4H
	 q1U6YPatQynF2L1pUwM9ScfPoJvODgJKvUsksWTvuIsEyfBXwTMMIv3Qkz7nbfTC0qBMU
	 EvKURIx+Sv8ds1pU4wXqMTi7GGPOctzo/FrhxPA8GWBtQ33/FSRhONfdAjX7JOaxp8k7E
	 ds+yRaH6PB6DQ6YSh94KCaCZNMREYaG7yJKBl+sDd5Gj95wY6sd7gauq16C+z+X7oCITU
	 zV7Eh7Mr0ZYZBvvKNCQJVx5MHDd2S60vP8Seg/dd22qKtNJNzLpq1G/2rBO01OqVX/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=bjZWdD55;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C6606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D9C6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=bjZWdD55
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3866a784546so7998887eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795622346; x=1796227146; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=90FJxPubVvE6pEkEOVszoN3+jM2H67FaSP7SkaiPbSM=;
        b=bjZWdD55nxfEXItGfguHRnqpdceTE5z4qj5g7DnBuDU1dgYkroeDuhmKth5P2w+Wjr
         XpzDJ2Fdt67eG/o1H5S5CNT2oAIPI8HbF3Nkt5SOddIr3Q6ArxyPjf3AdS3rgfZqGbkO
         QxTqK/gJi9fxHg5q4M7mAd4Vm2Ce49SwoZGjFm1QRbqMU4yyT8k7862nIL3EKo8MbCHy
         wMxKOcdAfS8a5G9tzox9LLbLZXX2CV3vvt6Eld/0JczsqZJlXDnHQiH0xbbOkhB8/Uos
         wFXwhL9nWLqMhZbR6kk5R3oauHDkJZCuUt4oMxvUNV4TFwSLYLMqILhOvTwCe3+hfw4Y
         fKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795622346; x=1796227146;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=90FJxPubVvE6pEkEOVszoN3+jM2H67FaSP7SkaiPbSM=;
        b=ocKKjek0YZSP2Uq7MvaUrwyjPgamUk8XwMu4yHJN/A0sxEy8YCoRWFHQ1v4YBd0jIv
         bVttCjqaFA1tPyAJQHKQCij12Y7XOZEmxx5RRbsYY9qXmvvZ3uYDOjLZt11KyMQHKlsY
         PWwLqD14t/l0tMC/VTluKazyk7yAxuzoMiQZ1HCfS5rFpuvoWNKP7UMdaHeTugaFRp3E
         5bpALVav0J32r2GUMnYjVWsU6CW5r6KRf+w7xVJAAEENESFfenVeos0z4kXeBtjyDs2w
         AcZ6kFvQXqLg90mlFVnuQPzxK2PqMmp6g7klCA7jNIeYyD6TzZexO8KaqkmWAQaOySth
         SfSg==
X-Gm-Message-State: APuU4Z/RDj5S5rI2JUwUfgKri5rGLSiHXtGwRGoEbOo/9aV6ZMSuS+4P
	3v7QOeyIV9YTs1ulmV2n3epOh5VKGa5qx5r6Y0LloiUjUeanKCzHDAk2XBm8XtDvSpFSKiDvmq4
	7wt5B
X-Gm-Gg: AZFdTZeQmlhJjhPGKL0cQoOS+Bc+LaM4J29yuG3WpMNbCpUYKdnd7IeEvRQcX761lFf
	FY6nXO+53/sRuIwOb8CF19zYaMOgBVPoWKOSJd/ZHZju95Uu0quvtLgqpK2RkcuKGXKaVyu7p80
	KOPk5wGyKAfQngPK+t9w7HObOASH40Tfc+dTDyQWBzRRvA+04CTD/QpkoN5NTBP2BempXvxlanY
	povlMQNvokNAR6oJ7Y5B503IHc9lL/mVo+kMYC3YjIfQ94xJ4yHPTvtznuZeGfZy40sIabWiSBr
	SuILHtW4GeFRfSevnjDyLvDmmziEuHV1KDUY4z2ONlaK8po75zS0mdAhkBqH/K/q1hAaFGlwmub
	616KHF2+k6bckmlHz6Vu3CxWJ70phSiRXLy7JDZsUy5IP1TRKxpAhCeeOTVtiBjirSGYgvIsiSi
	qVf5iZQTVuGqCDkq98Q3uMcA5pkC3+qt6rYf4dhP/CQ0F6858edmpiYM//I6H00rdvY0KYJE/n3
	A0GjTd92ABfShUGy36g2iYTf9l/HfiJQ/qWX6gQiPHv4y8fXL1ThTnH40eXAHS+7Mo0xD4dXE18
	4In2DbNmb+gVoCoUR3c1wSA=
X-Received: by 2002:a05:7300:88:b0:386:959c:11ac with SMTP id 5a478bee46e88-386959c141bmr17355402eec.6.1795622346077;
        Wed, 25 Nov 2026 07:59:06 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm98185157eec.3.2026.11.25.07.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:59:05 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)variable has incomplete
 type
 'struct cb_notify_lock_args' in fs/nfs...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 15:59:05 -0000
Message-ID: <179562234474.103722.3752272018582029987@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.12.y:

---
variable has incomplete type 'struct cb_notify_lock_args' in fs/nfs/nfs4proc.o (fs/nfs/nfs4proc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/fs/nfs/nfs4proc.c:7281:30: error: variable has incomplete type 'struct cb_notify_lock_args'
 7281 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^
/tmp/kci/linux/fs/nfs/nfs4proc.c:7281:10: note: forward declaration of 'struct cb_notify_lock_args'
 7281 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                        ^
/tmp/kci/linux/fs/nfs/nfs4proc.c:7285:19: error: no member named 'cl_lock_waitq' in 'struct nfs_client'
 7285 |                 __wake_up(&clp->cl_lock_waitq, TASK_NORMAL, 0, &cbnl);
      |                            ~~~  ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:809ecc7a2e0fdab158b07b242361184eaaa08765
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  87d55cd4c947e78a8b4c2a1d654ba54951a29faa

# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06fb99286e1965ecb437fc

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06fba3286e1965ecb43827

#kernelci issue maestro:809ecc7a2e0fdab158b07b242361184eaaa08765

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
