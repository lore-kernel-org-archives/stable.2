Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851952;
	b=F37KTi9pc8Zvq+NsH3WTSy7SuRSZ7hEkb686D4IG5pJfrL1SgwMeflFnjHiapFh7ZbOy
	 Mrnc7iMspn5+++nxn70JjjRp+GRvGI/lBPDK5Gnj9atu0g0Fbn9vVRPEh4JtE2J2ljdke
	 jY7CvTyr8/IpVngxwcOi1l7zW6ygmwAKKVNd9l3mSZbRBKZtGFjc99LDtL0LFouUFu10f
	 YLfyLELtpx2i12Wn4O30eC1MwtkDzpIB0AeWU2HewBGlX4auZcvnCNpDYt+N18vTIErWk
	 aVAnMfz7LdUN/NShHwYqV549LG3XpzyUfNjZ3tUPkZ+d8kQv0VMirdP6n4yUJYngv/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=TAY4sbNnhIU778nSVaysFqrtAOEhQaxmBz+YrQEtWeQ=;
	b=QdmGDj8Ofpt01dEvQBRVoQqAJva+pSiSS55uMikH3f4EFW3PCcE5CVwJv/FbnyzN50k+
	 g8n9hhLQwp9tRVXK7QLnQVfyU4kklccG/ncAbnrVjF0wrcU8wtaPOD23yiozISKGLbJW/
	 VxL1lZ6ItwALzl7k35p2HIFbZ6jnWbhPz6NCAqaAdDs7uJJQaRDEhuHJq8qQMRYEfABl7
	 If8MXRzHJ82hVB8v6saP7aD/Dxe0u5cVaC3QmrvGhSZnH1p+a4q2lsyOOPDCqKDBZDuMs
	 0a18er72G0VD2PutDxuyb5SYe4JWjyR58Re6+IreC3smJ3C8jU70aJnN9DqxXYL/MJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=g5Qjeo5f;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC27606A884
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEC27606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=g5Qjeo5f
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3791619605cso7093914eec.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794851949; x=1795456749; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TAY4sbNnhIU778nSVaysFqrtAOEhQaxmBz+YrQEtWeQ=;
        b=g5Qjeo5fsK/FGKGbdPXi56m8o4qf2JNk/lxzROC/k7wUSd8GwpUyVpmNhf5GspJxm3
         /mdm6PYWTtfaP0WOy1Mqh9xi10Gn8wqcyTcz0ZvL0ANhUc1+rpkgLlgUbCPLBozTDYa8
         NBLeq+4WXppLWWjBWm6aMmTRJObfHgzYW8xfxErLS4sRXB45cJjxxfodX4VAyzWJd6Jr
         wbNeHK3/+h3Lm5PFUNSy3QEBXDBrkVvxv0iSgVUCcceAdKXqFk+TqLGtGy2vAQySvYXn
         g+tpIGNz4mnIdcToizw1HI+1UpoUHjLJFRykLH0hunkP/giS8sYO1+L3s2jBXEdb8Obl
         1i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794851949; x=1795456749;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TAY4sbNnhIU778nSVaysFqrtAOEhQaxmBz+YrQEtWeQ=;
        b=mlA/cmGdNgpDv1hhEag1CLwp+k5QVZJSe0TbwKUMrlQo6d/yzGHCThwDSFoKjmEIQB
         YiV4+75pGNeH+8G/+lax4Y7lNMIJdCAMhgyDlAA8oZSs/8qlGwjXKJlD7DhoSRUe4wpq
         i/CIwGuZQq0P1RRPt3s8PdFLydSyDZZtBzKQW9zICcVuvIJDJDbfFpd9sa1kSs6Ys4PP
         9hcICDINsT5L36CDDhytjLEP3CEsOdJBPIMiDbqublZ9apKtLymdb+rMBGiGfya8+eX/
         /o3z69StoQ7hjOCQgpL2Q/uu/g+kMNbkpDsTigFr182nFg5w9YLXlZj1OwOMbqK0g5qg
         W3fA==
X-Gm-Message-State: APuU4Z9qlhPzLVOgWfI7AnNU26MLzOmllJOI/o7tVYJ6yHDPuMq/82B3
	yNYQ93JV5QmYSUhveR95EvNErYSvaY8DMH3tZPyXulXjpkO0VlFCnqXr3Z5L7TV/Wtc=
X-Gm-Gg: AZFdTZc7d/r5tVXmCRP0lXe5DKQGuU+25v747R10cn3vfTpddl7WI1t0lsWyvoXGdPK
	VgSnGxuLjwn9kpitI1WDGj3GqiVlBGDSmSvSOgPhROk+JwlapzJIVf+4dymOmXQ2o+DJGiRBgXI
	EfTDVY6quHaRW92T3UHBHi+j9O5jsh5Ah8aKCgopUhJq8Bw1Ri70y2ELpq+KZzmA1mDLuVUy9Ou
	TpH4NvQ+AVypIfzWJAhSaADc51MShJqDBGElLxYTXfp5+9tCtHzCwaPHV+ydvo2Ln2DTogQ8kUV
	+Dzt/nFnTCebROIYWmMi4tZmDyP0Vnb5Z25Xp8M9S3uzCNelclvC0p9P68JubUPubn56kSzKuHZ
	AdxGW4VnoU5hDXPkoagdXv24ggIfD8ra220hMPqNOXi8cHGVA8Xdva7g1o7+nN2R8AgMIChjwrW
	eoyL/OH+6Z76FbLtv9YL4cnZV82O1o+ncSTyWFgUYC+lWnzHpUEqvGYdit7BCUzMnFj6gjbkSAZ
	0NH+9LP0CDbOcggp13k3moN+Min7U1MisSMTJZ+bFUFOijnnicMIJYF1N56yrqGxYWutco+PFV9
	9HwLuqlufEeVN5/mdKXjlA==
X-Received: by 2002:a05:693c:4097:b0:36f:d53:cf2f with SMTP id 5a478bee46e88-379635648f7mr11187253eec.1.1794851948925;
        Mon, 16 Nov 2026 09:59:08 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378c2fesm36656181eec.1.2026.11.16.09.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:59:08 -0800 (PST)
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
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC03LjMueTogKGJ1aWxkKS4vaW5j?=
 =?utf-8?b?bHVkZS9saW51eC9tbWFwX2xvY2suaDo2MDQ6MjU6IGVycm9yOiDigJhzdHJ1Y3Qg?=
 =?utf-8?b?bW1fc3RydWN04oCZIGhhcyBuLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 16 Nov 2026 17:59:08 -0000
Message-ID: <179485194809.205922.17534059694033554248@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-7.3.y:

---
./include/linux/mmap_lock.h:604:25: error: ‘struct mm_struct’ has no member named ‘mm_lock_seq’ in arch/x86/kernel/asm-offsets.s (arch/x86/kernel/asm-offsets.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
                 from arch/x86/kernel/asm-offsets.c:9:
./include/linux/mmap_lock.h: In function ‘vma_end_write_all’:
./include/linux/mmap_lock.h:604:25: error: ‘struct mm_struct’ has no member named ‘mm_lock_seq’
  604 |         if (unlikely(!mm->mm_lock_seq.sequence))
      |                         ^~
./include/linux/compiler.h:77:45: note: in definition of macro ‘unlikely’
   77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:8e6fb297e5c1395c8702891ea738fa7187a388c2
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  2a640ccd9d0b0927413e9778fa8970767b7d97d5

# Builds where the incident occurred:

## allnoconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-allnoconfig-6afb3c9b99c74e1a996191ac/.config
- dashboard: https://d.kernelci.org/build/maestro:6afb3c9b99c74e1a996191ac

## i386_defconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-6afb3c9399c74e1a996191a2/.config
- dashboard: https://d.kernelci.org/build/maestro:6afb3c9399c74e1a996191a2

## i386_defconfig+kselftest on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-kselftest-6afb3ca499c74e1a996191b2/.config
- dashboard: https://d.kernelci.org/build/maestro:6afb3ca499c74e1a996191b2

#kernelci issue maestro:8e6fb297e5c1395c8702891ea738fa7187a388c2

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
