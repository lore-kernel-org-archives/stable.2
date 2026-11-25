Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618766;
	b=vn+W6FCyMqrI7PxEO6UodPFocDsaDV1oafZjHsoHc/UXplkbWiWFEc8iRgkYsOrO1jtt
	 We99FQMwtDVyF88fWsZpa/oqiNNwSiWV0qE4oTQqLdpl6DhfXeYCKgrb+48rc0o3ihF7Q
	 VEoqKSe7+K0rJefbZ+/xsA8ktOhJNQXF2sZA44c3FAwh/9Du8UwMj2Mec6RkRdRTYjnkz
	 4gM5jFAtY8sNNwqHq3sI7MR4xPFCrawjDqQvRzTmGk18bv8qmT4UsgK6vJ5Cx/7ob72qG
	 1GQzV/GnJoWi9jEvpN27rWKxtX8+jImBKCXYljrV2Nc6SNq8BorSvtZop6K1CoJHAiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=aRJ706injhx0Jn9dXwTQml/VY5kYGXNGV8m5r1Tumc4=;
	b=yG+RQoxlSpZtsQysCr5DchiJyNKsm5aOilZbHhy1lSDqy6aYVgiZ5LQ7gWd7ErYeN4j5
	 5geF4d6h6oN/yId/nxQW0hvaAkAHNhsvuZLi0tUiZ+0qdwupnTzCqA4xHT1uPjHTGCOHy
	 xnWizDQ5hVYvP7rG2TL8UAsY1rBr9k1/1pbktaCFPHUP5dONNPeDQHxJ1AG1+z4tCumaN
	 6g6CjRGw6ci7fjjVDFfL+7Zj72izs2Gg6DXi7kZ093pzjtNQvHchMyRiSO4yMlMdGtXAs
	 D+airE9PwXmnWETso1xXt+xmxattE/xCCxLYUtSezAnXOD/5EQACcRDE6K/XqXxUK1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=AWbAXi3h;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404D606A330
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4404D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=AWbAXi3h
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38692f62b22so6773456eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618765; x=1796223565; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aRJ706injhx0Jn9dXwTQml/VY5kYGXNGV8m5r1Tumc4=;
        b=AWbAXi3hc3p3uvJKczWmE6wePrFqlU7cJVusKW+0uH2QLMsyn8QG/mdSXsO/5R2QP3
         lzMn6nQJ3Dzyc+WTsYGC+GEzyIbnE4K5P/5FVqkunLHzI5VGVhUNylpL/ghmJwqcw1Ag
         kMcz01Cul+/8IFdC7mRuLPd9X0gn2DY5OEF97iiYHgmybjSpSl+Czjkml5lhH8rWsUhe
         Fc2cYrYpOs2iySpRjeJLqJskOIbyrWAqMjRjITeiFQBUWxQLtH4KdLCMHTFgoDIiQE3H
         dFberTfSlF0CJZgXtODwvBZVUqY7liLS+zhiJkPp9PKIHt6nuxrYcEylsw4aMhH4/heJ
         30vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618765; x=1796223565;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRJ706injhx0Jn9dXwTQml/VY5kYGXNGV8m5r1Tumc4=;
        b=elMMB+jtWlt+iNDUOYVrrlECfSqSzWfrgqy6jefi+av0m5W0dlCzmBzESl0k5sPU9o
         uxG3KwC/8yDkeq6FSfQ5chZ0ieSKv4n+HYzwezEyPYYt0KHgG4jMdG52aO7GuHbJ0gNm
         EicNjHkaMm+an0SB5akevQEUwM0DkI0mZ0O0bljk+0woe71QiC754gtAGZkWRpw+eMof
         ulaBvs1kYGw42KM0ROnMz5eAyq4qHP4Wf9ajgJFSr/T9SrZEiFqZ8Sbzt7u5cS9paXvR
         RMdYBZ28ZQWI/n0OLwfwa3Y1bbto5KpwHCAveUFdyUo96g1s/WWC4jU3OT7r1dBw3hvw
         wLDw==
X-Gm-Message-State: APuU4Z+maUy7qiX+6FOF3QNbB0o9GxszdDoYg+leOWai85IbTv+WrKMp
	QDOO7WHGc0TLB+A21rNtrt8JTL82bsIX+Mh4vXTZMT5ALEcCzsmnq+eXRW+LOo3HYr9SSv1Pjpz
	CI4vZ
X-Gm-Gg: AZFdTZe7GxgVGQo1vWQahHKcubCWnI/1fMxJ1u6SxneIO14cMpeaxsj9TTea7a18i/H
	PMXNtR9XHW8J/qFOuzOppJLvydUkphb+EPmQyvIEQ0p0x5/abkX1Ede/c8UJvwGtN26pcuR2YqN
	i5XGPMPGxKj6cnylhqo2hTmiFrlvodGHpfNFHQXbRxh2OLrz/pahN3Vurrv4tcNF2iV0kcA/00c
	ArTEc90s7WrTQxsdxm7C+P+Dq4qrKnAW7j3s0Pjz5+QNsnvYe7lCpNHwwGqoRgSbTrZXuFA47TT
	BkEpx9M69vpNkjo4tA7UeozGf5Y3+nGLH7FdVGl5RkI3VH+slRPwFZuPXF58CeLJZJXdVNsL/wh
	aqtWe9emoh6O8neUcn+CNmzN0kOdZwGnplcjVz7jyqJcTwTNQj2rSqlp37tVuuNIQGz85XgDNP+
	rDB5PwlHH7TEUHDNmtuStmm0WRMOphPmq/0E9xhCqCAfO2oUGfCOBW8yBqjLYPaRJv3hLR+ZOTo
	Tkqpt8kcTmM8JJ0j2hMrMredMF69nC9Kywoye29FKOCpcTkX9NcVdfJdn/TzjFegNw2mDwZEIHS
	7eeZp41YUeIRQ/vS0Yb7rw==
X-Received: by 2002:a05:7300:c8cc:b0:386:6116:c389 with SMTP id 5a478bee46e88-3866116c625mr15083264eec.15.1795618765106;
        Wed, 25 Nov 2026 06:59:25 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm56718860eec.6.2026.11.25.06.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:24 -0800 (PST)
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
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E15=2Ey=3A_=28build=29variable?=
 =?utf-8?q?_=E2=80=98cbnl=E2=80=99_has_initializer_but_incomplete_type_in_fs?=
 =?utf-8?q?/nfs/nfs4p=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:24 -0000
Message-ID: <179561876429.101431.6272745812113444473@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.15.y:

---
variable ‘cbnl’ has initializer but incomplete type in fs/nfs/nfs4proc.o (fs/nfs/nfs4proc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
fs/nfs/nfs4proc.c:7058:24: error: variable ‘cbnl’ has initializer but incomplete type
 7058 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                        ^~~~~~~~~~~~~~~~~~~
fs/nfs/nfs4proc.c:7058:54: error: ‘struct cb_notify_lock_args’ has no member named ‘cbnl_valid’
 7058 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                                      ^~~~~~~~~~
fs/nfs/nfs4proc.c:7058:67: warning: excess elements in struct initializer
 7058 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                                                   ^~~~~
fs/nfs/nfs4proc.c:7058:67: note: (near initialization for ‘cbnl’)
fs/nfs/nfs4proc.c:7058:44: error: storage size of ‘cbnl’ isn’t known
 7058 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^~~~
fs/nfs/nfs4proc.c:7062:33: error: ‘struct nfs_client’ has no member named ‘cl_lock_waitq’; did you mean ‘cl_rpcwaitq’?
 7062 |                 __wake_up(&clp->cl_lock_waitq, TASK_NORMAL, 0, &cbnl);
      |                                 ^~~~~~~~~~~~~
      |                                 cl_rpcwaitq
fs/nfs/nfs4proc.c:7058:44: warning: unused variable ‘cbnl’ [-Wunused-variable]
 7058 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^~~~
  CC      drivers/char/agp/backend.o
  CC      drivers/acpi/acpica/nsinit.o
  CC      drivers/tty/vt/vt.o

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:044a1bfa5349651d841a609fb3ee80373667f8ce
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  dff336abbc2b3923b31da85cfe6cd094c4bc0d48

# Builds where the incident occurred:

## i386_defconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-6b06ef73286e1965ecb36028/.config
- dashboard: https://d.kernelci.org/build/maestro:6b06ef73286e1965ecb36028

## i386_defconfig+kselftest on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-kselftest-6b06ef84286e1965ecb3606c/.config
- dashboard: https://d.kernelci.org/build/maestro:6b06ef84286e1965ecb3606c

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06efac286e1965ecb3630a

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06efa4286e1965ecb36303

#kernelci issue maestro:044a1bfa5349651d841a609fb3ee80373667f8ce

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
