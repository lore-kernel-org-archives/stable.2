Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618757;
	b=xVFo0wKIkzPs9RL3zfdwS/PBZosd/XhTNEfkW28T1+fV7Kr9PsQsdA071KKcovO8wPqA
	 zB78Q5P8Q+Mw0erl7mNZkrur08Ms1jAhvfxZJHG2nEdHDyHrFrbhpJfAoqZqcwFWcXSqS
	 /x+rATGFrAdywcZmOh6ym60poVVQJHlvFhm0mzJS5f6/GGXtI0Mclu5GMSpQMMa/28j1w
	 n6scIiO8YmA2Q7CPYSNlFOV8ZVNNfbH3cvdR7nGDyH0D+xykUEqK8YMB/BeUdaZjuJKOo
	 dNlXvmpbF7J+e/J9fIkg6dyZc5A8loxme4qOhAuffDIugl8pDIRdz7jkZMrKXXGbaKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=elludENPqNLFoDpEprcFYi1mxmG82HF0/mTJBgaVKSM=;
	b=ACw9N9SLOk7h9U/M0xQHiGI3ox3u4neQLMaJ04QLZJPy3EVeuCMcWZb9sbw0aYOue/yb
	 8hnXeyG0TIrJmgbO2PQm9z1GC3SDW42VIfg4DpmciRbFXTUb9Dk6Z/E+0ktEqeA3zXgAV
	 ykS/VBoeLgGPrs8R1gV5O+zSpBnh7fuPC/K6EdH9qCWB6mnSDKF+lwvRAtuF/KhU/yAes
	 oIYm7zLgN3H3HF6mR1LaZS/rbJDHDmvLjDYNWI4FrxGpQkzRDn5TJRu6ja/TjyuQGYWZ4
	 2jlpAwZJUlQZknG0cH9yUEItHBoaydqk7tIL2pHNc0xI+ZtPLIKz6aahPdZOtHmAUOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Mbd7sID3;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A2606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 398A2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Mbd7sID3
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-386c336eab8so2263124eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618756; x=1796223556; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=elludENPqNLFoDpEprcFYi1mxmG82HF0/mTJBgaVKSM=;
        b=Mbd7sID39HIQriKlAzhCCPFn/GlrQWoSwwGKWS4YyhQCcW9ZsYm8k+XR1yBcFZBT6A
         YruVcRFxrEd1/Dtd4smkikthNLkhQJySKWeDA0cnAOas9Zxg6VSzfqt2CRkFwpfMeGTE
         KO7NlpZjE2hqw2FAAyLM6TBKcdm7GdhL2sL4z+FugcT893+MNVKtJA2gZVcZaM1HWSjB
         l3ywSmnwcl+YHXRDTQE15r8Hg3pMMJVpxeiglVrSZtMPlLRzlvirA5wkqQz1Hya7+iD+
         ah7Uuja+SckK4sH5NhvwXuUdQwkImn5uAbNIwIkPxKPdD2O62qJdjOkf6Teojw6Eqdfx
         SpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618756; x=1796223556;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=elludENPqNLFoDpEprcFYi1mxmG82HF0/mTJBgaVKSM=;
        b=rlTySxAsWxSnRlPu6rnbiww+mcD5mbelDKjXBU0gEsPIfVymhY+/vmW1gYrruHT5Uw
         NUJpr3eCczUn/Mw9LVzXuw2wp8Q93pNGrZWNsriQSS5NLlE9sOT3MeI8V2+84T6GV/DY
         l2/kOA458lffaK6lPAls3N93WEvA1PghSZsSEW4aGtnNIB8mGZxGoL2OEdhW/5ILoeu4
         y7BJqdeiM5+cDW8MkcfN2UEHZfTHO0rS02fNu0uRGmqwsdZPOgcP9+wWTQqSM2f4ETsW
         G4bfHfzGI8aAS5BRjvIJwwsvDRzUr/p5TDMXXu0yhQVuInSceJKqgJo56uPw8NnyLBh5
         zgwA==
X-Gm-Message-State: APuU4Z9YT9JzHs2/9HvSoGybYrtpYc8uhoR2J6Qj0ahXt/RXS9Qt0KfW
	UA4UEBxZkvunKNRzUEZvZ+98g21mnghlPgN++90ey2BcxGxaB03GRDjcyGw/Czoj2bGbWl65zqr
	E17pq
X-Gm-Gg: AZFdTZeMrUzFjTZhWZ4QASbJQYRUywBhQ/6CKuxywGBwo8LtRVb0UDymzsxxDryCqj2
	jqPOb0+j2wuJBh4Qe9I8ksh04+4OjhMhCms0sCeWE19xZWOXDuampTqkNycodgvkC4S9RawjXq2
	gVRVvuyOVpoJ1TUi5GL8cFBYaXB4sPm6DhqC4xyg3VuJEqksrb0pVYo1+MPGoi77oEvrWF1h38k
	Hl3A5TcLG1LhNRQebHa1QeEqHT0DvORgsV1ygvi8Xx2XGvE8UaqGqkCA4l1IYv01HLjCt/l+NsA
	6r+mVsWkRW9n24M7/uXNNUpcVAwBGX+3J372EF3cG2f/y7YzS20bFEntbmQoKggcGZ+u5M2YdE/
	Ci5/mcEdRrwmqIiZI7GxiFlkDUFnkaNqvtlCcas6YCvwuzjAHUo9AhDTgzDsTzeBBs6eth07i0Y
	99y6zcCuavkD0Hb3RREytCiCApV3sg4M0Fqu+ogf+3XpqtOyxt0k0io0E6DsYwnnwqEuYGNPI11
	V9/SpzoNKF/KlAua32CiermEtPwvV/+k5ew7h7/yNb7kA9QXmT818SBiVaXJe4FJE2lumTGlNEw
	OFLP+AN81MtFMEidl/Apsw==
X-Received: by 2002:a05:693c:414b:20b0:386:a10b:f709 with SMTP id 5a478bee46e88-386a10bf99bmr14815789eec.21.1795618756241;
        Wed, 25 Nov 2026 06:59:16 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm62688480eec.24.2026.11.25.06.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:15 -0800 (PST)
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
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E12=2Ey=3A_=28build=29variable?=
 =?utf-8?q?_=E2=80=98cbnl=E2=80=99_has_initializer_but_incomplete_type_in_fs?=
 =?utf-8?q?/nfs/nfs4p=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:15 -0000
Message-ID: <179561875488.101431.9039598492292046594@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.12.y:

---
variable ‘cbnl’ has initializer but incomplete type in fs/nfs/nfs4proc.o (fs/nfs/nfs4proc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/fs/nfs/nfs4proc.c:7281:24: error: variable ‘cbnl’ has initializer but incomplete type
 7281 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                        ^~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/fs/nfs/nfs4proc.c:7281:54: error: ‘struct cb_notify_lock_args’ has no member named ‘cbnl_valid’
 7281 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                                      ^~~~~~~~~~
/tmp/kci/linux/fs/nfs/nfs4proc.c:7281:67: error: excess elements in struct initializer [-Werror]
 7281 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                                                   ^~~~~
/tmp/kci/linux/fs/nfs/nfs4proc.c:7281:67: note: (near initialization for ‘cbnl’)
/tmp/kci/linux/fs/nfs/nfs4proc.c:7281:44: error: storage size of ‘cbnl’ isn’t known
 7281 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^~~~
/tmp/kci/linux/fs/nfs/nfs4proc.c:7285:33: error: ‘struct nfs_client’ has no member named ‘cl_lock_waitq’; did you mean ‘cl_rpcwaitq’?
 7285 |                 __wake_up(&clp->cl_lock_waitq, TASK_NORMAL, 0, &cbnl);
      |                                 ^~~~~~~~~~~~~
      |                                 cl_rpcwaitq
/tmp/kci/linux/fs/nfs/nfs4proc.c:7281:44: error: unused variable ‘cbnl’ [-Werror=unused-variable]
 7281 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^~~~
cc1: all warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:3582bd2856f290dd8308c71449d0f1f0b53e9c2d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  87d55cd4c947e78a8b4c2a1d654ba54951a29faa

# Builds where the incident occurred:

## i386_defconfig+kselftest on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-kselftest-6b06f1de286e1965ecb39af5/.config
- dashboard: https://d.kernelci.org/build/maestro:6b06f1de286e1965ecb39af5

## x86_64_defconfig+aws-ec2+aws-ec2-arch-x86_64 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f207286e1965ecb39c4c

## x86_64_defconfig+aws-ec2+aws-ec2-arch-x86_64 on (x86_64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f20b286e1965ecb39d3e

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f214286e1965ecb39df5

#kernelci issue maestro:3582bd2856f290dd8308c71449d0f1f0b53e9c2d

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
