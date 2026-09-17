Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB116525A92
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653553; cv=none; b=Ojj2Za+SskOQI0G3FM3xpSuXd2+y8LfzI5t5FEMr893w9lbHvsBEv/GN1PdDQSRpOJvRaqC965wjEmNVqQX4CnSuSqcx2ocUSb2L7d0XH0WYqsjveh3+5T5cTgPWqGVqD2BYU9cjNemNZVILyAXbYw4uwNRe+Po4NSAq2np8QCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653553; c=relaxed/simple;
	bh=9iuGYGmS04cZ5xfeh/mm/DoYlJ/J3OyGbVh5I3COZS8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=JX3txOOS681NLSArc0oQG0Y53s5ZvC/n+TiWEwv7R2I8Qv8xWKVbDarDTcsZBgzX0Zz9n/BJe4sOT+TihdjpSJZqCRrxIVJxeFO0KnHtM/zIF3jUZZZeOFiAG5uXhdllO4HnDibQ2XWKXV+n6xecYNVpmPlL9c5GdYrQySStbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=cP5XzX+A; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="cP5XzX+A"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so690555a12.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789653551; x=1790258351; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m+wP/0AkNkk7wci11plKt1ck+/ZGvWVyMkazGsdZDZ4=;
        b=cP5XzX+AkMq24fsx7KtpUFq4Gmv2ViH9TSrQZ92gm8IkL9TtHAGNh4ECFfo7euVlva
         fKZRGqca6b5OZxaVNEiLrUgK/r0TdA6GkSF6KOLaHEUq/gr7fkgU/pjlZpeFcKq+RlyI
         GpW2mVh2S/I+F3ZG31arBS5jWdJSH8T6lTGNozLSL9QmLj4A2ZnHRWVYZ4K30Pqqaxpf
         aUynpoUzXXrfL8FldHaDfjubOpFrJN1cp7rN0edfH7hgc/1s5xXes2QW6FnleidOAIv9
         CD9Q8odYLqwkktlERvIZ4tM/b9/SF9HDbCrfv12Is8X6AjxGSKH4Uh8WZ9FGRb3ue+JD
         9nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789653551; x=1790258351;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m+wP/0AkNkk7wci11plKt1ck+/ZGvWVyMkazGsdZDZ4=;
        b=wcfn9WMlPMb3daoBklki5MH3zyKb0xTd2I9BQnZ9J7wpXS+GzYmS1TGTuiP39AJXL+
         sxtRyxX6iHt3uembIRmPmgMj9wA5TgvOoQIMYPE7YzO/h54u14M+dqul76b3sZwbSvq4
         ioSt82S1Uj753F0wWBkAj0gx9WzqOf1Snz951c3gYLsRYDfy8z6FkeW/UDM8s9ohg2ru
         mxmge6y5ywRJzfke9eHan4kV06hsg1DiGbDJnhUUOvUWHD93ngJoL4eQIV1P6FMHpRg4
         GLj8enbQgZET/Gia3k7Rq8sBJqwu5cguLy6l3JEoIlWktj4XiCcRbS+1TSVsI/zAQ9Ou
         4xcQ==
X-Gm-Message-State: AFuF++m+GLDMO653j5zuEtseHEhZrRip+v12+TOnZyP0F6m+Chzv8Bbv
	es1FMfYtSWmUIkJecUkCig3bHQdSFBjmCHyjwMYqhBW6Fyh7CGLAoNVozv9QPiPVwiI=
X-Gm-Gg: AYBFou13RZfXsmmknzQtc/L5fvuonzg18Fj8dS3xZuQwSr9uU1UNRrNoG2TuQ+/77t9
	LBstHPEJ2m+JYvzosQjgBCYwzsd7wsb1TkstlW86J14ddqswsExuBfSIQim+BwHgKlr1CpAR7Zn
	m6AkLnYutEbtn4pFjbL8D9nLPQg8AqD28g8MmZSSq5m6nIPZXk4+GR4Sng6pir2wSXdP/vUgNtR
	vaKeaZkn9lpCAp33Z4RupPaO2UDhe9hTl3+kda94lIuWIhWKMitl4q6QaywiFygqWI3HPbGcaMO
	Ac5I1aX5ZG4ZhfwyXDsSoUosQLWBBSCcjl9hXMcAnt8WKDa9Lh1pjQxIjHgvxXuVvl/fjJVM6Yk
	pp0BpJayts93rWgrXM6+H/G1UQl4ymhRGNIISM9m1uyPiQErGX6+YPcprFHBLH9F0FWH1gq4ySF
	rdaIlyTWZgfubMxQ1jAbh07Yxw3wyYMOXaxpxZ+cYK7JqMBhqU+CZGtvmnknXGTk0=
X-Received: by 2002:a17:90b:1c86:b0:39e:4546:fb13 with SMTP id 98e67ed59e1d1-39e45473a15mr2624880a91.19.1789653550830;
        Thu, 17 Sep 2026 06:59:10 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5af4f0bsm19009599eec.24.2026.09.17.06.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:59:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E1=2Ey=3A_=28build=29implicit_?=
 =?utf-8?q?declaration_of_function_=E2=80=98is=5Fcore=5Fidle=E2=80=99_=5B-Wi?=
 =?utf-8?q?mplicit-functio=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Sep 2026 13:59:10 -0000
Message-ID: <178965354971.144182.14327686019509101367@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
implicit declaration of function ‘is_core_idle’ [-Wimplicit-function-declaration] in kernel/sched/fair.o (kernel/sched/fair.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/kernel/sched/fair.c:9912:53: error: implicit declaration of function ‘is_core_idle’ [-Wimplicit-function-declaration]
 9912 |         env->dst_core_idle = !sched_smt_active() || is_core_idle(env->dst_cpu);
      |                                                     ^~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:ecf7d58a323aa95ec2189faeef981683e06119ae
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  25d942d40190013b993a85e00b5a84db4cb99b31

# Builds where the incident occurred:

## defconfig on (riscv):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aabe9adfc1857a999df0aee

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aabdbcbfc1857a999dea72e

## vexpress_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aabdbe2fc1857a999deae75

#kernelci issue maestro:ecf7d58a323aa95ec2189faeef981683e06119ae

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
