Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80F3F58F0
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142353; cv=none; b=tcjxGnjbhXTDcfRfJSOqyHvgdZpmsmqpEqbGNym7YHnDQ1GGrSBk6MtpOdw0mxGLKjiHtF9vdUrz98IaXsQlV4+pUAXOdZ1ml9y2T5VE5lyPq8hkq8J8WUjiV6+RSlxYK4gCOapm8rPxrxvd2KkIhzNYb6ArOiKAjClmAf4wXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142353; c=relaxed/simple;
	bh=gDywAPvXOeb4NeQS5bze0SbXVJNZZyOw9voVbJejeGY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=FRhPKv1Phb+RI5AxdVM3Hc89yEiNtUJXlagsPblJcxq5p4sqNO4oCTOBLQS3mwSF/zIy0zzVSH/MXs5iEecItbrLy5Nlkl9c3cHAMAec2Ngzcs4WokkiA0k5JNYl6LhZuEpWGNSgJimHORK67B0bmmQ4EGSTvT7KOU9NFauoj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=VIIug+oA; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="VIIug+oA"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4d64bcea5so207164a12.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789142351; x=1789747151; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gnJ2glJVNld3y1jYi149ojgovJ+14U7q4xwrPhgWTDE=;
        b=VIIug+oABFIRSLwVL6tTZbeLlg74fga/iSxiFcodV5VZ/iFJG6i6R8DmQhUigfr+pe
         WdFMsIETvrDYxhQfDW/U24oVb2oqJho1wTjLxjW+y+LShO103q+tJvujuolsXIquDJBz
         bt10F69X1atJkyKXTp6xJ5R3UaaCvWlfGatXjNi9UKrLbLIgyEc+wD9J4Mk8F1JKE+xN
         ov72PuzwOiTQAHSjHHDkhplHwC1M00Uc8m/0Dqv3AtE1VrIoVlJ1IjEpty27muINirvU
         f3D+Ey2Vu9QDEC2QdjHvI6SxtZcm9qmXn/Ql208CWM21pxI8V558l8Z7OvpYWM5BE7z4
         9srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142351; x=1789747151;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gnJ2glJVNld3y1jYi149ojgovJ+14U7q4xwrPhgWTDE=;
        b=KS2TUadSH5ee8dCERfxpov7Zbi15YVjjl/p3cbji1KPN+IIw9JiEXj1dPd5w8Y5O6d
         RmbWPCKkGyWz1WFngO5Fxdq8PVFhiJui67p2gz4jMsqvMvDcnGTbMUmmI48O3GII+UAD
         SQC7KNtM/X8/+LGo6hloJsaVyMeC3IzC07K5gM/27BKDvtFMpoGld6x1CrumBLsha/Xf
         +VbAvbA/UvrEalNDwmRLFZgw0SK2lWIMDomousjlEoet0WOrgAotAB7tlLy5geYIkuUO
         +vs3XZ5/zTUn9aZxc86Sxgu/V5TieWVZ9TDe5SyudpX2SMO32OK88SoNgKPdNMgtdrxL
         HxKg==
X-Gm-Message-State: AFuF++nMEuT2k117zCPrUPP5gra2Y6rD1wxDY41aIA0unknBNaXwZr44
	QeI2eUNKE0nCg82HYfiROGoGHjRgqGxZAuRsve+sue9c2pbrDjJUCGfa8UKffsJg9yZiYP01qS2
	yazOk
X-Gm-Gg: AYBFou0KiUlgpLFmnDfdNa5cNGlE61P8YzPAXQKQvrCkzArhTAeBXtSSzxOCrCgIMVc
	hX/+WE2ELHL6j9zCWsjtULPQvV7SKrXIpCnUyRKRqr2aNswfyga1DOyPYNOOMDvEu6cIEcbmuxF
	1/5WncqSKkMzRACegdxRlYIKWkte9byP/E9gh+VynqN6/3qUd3QPvbiFHfhFFqXR7Ib6lC1CSfD
	3DH3SYHSfH14nn8Q7fMn1gQ26LRDdvLZnggTLFqC/foE0Il5h9iJ0TH+GjWgZ6z9fvej2PFZTz3
	7no31dbXeG61iptjItnQQLJAspJ8IsA31VzZ0fQOF7AZG0Co4DFJ8Iet2Si7OhAv7i06kMCqeOE
	hfNPrvY83uRk/IpD4VkjRZ/ZHp7ojmwJoaPu63kOHftMOMFO3vwi8jtfec2k7g8Q1qiA3oXJr9a
	MuE+GiTOxB/1GCN4Jv0IvvIdISFxSCPnwxmJYWl/uKQakO659cATPIxnFZFmqelEYbDLTyTzzB+
	Uw=
X-Received: by 2002:a17:90a:da8f:b0:398:d6e8:f84e with SMTP id 98e67ed59e1d1-39d9bd6976amr7243274a91.9.1789142350934;
        Fri, 11 Sep 2026 08:59:10 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4fb3ddasm6504943eec.30.2026.09.11.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:59:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjE4Lnk6IChidWlsZCnigJhy?=
 =?utf-8?b?Y+KAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRp?=
 =?utf-8?b?ZCB5b3UgbWVhbiDigJhyceKAmT8gaW4uLi4=?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 15:59:10 -0000
Message-ID: <178914234982.4405.5831914380874156765@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
‘rc’ undeclared (first use in this function); did you mean ‘rq’? in arch/s390/kernel/module.o (arch/s390/kernel/module.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/s390/kernel/module.c:534:25: error: ‘rc’ undeclared (first use in this function); did you mean ‘rq’?
  534 |                         rc = stack_protector_apply(aseg, aseg + s->sh_size);
      |                         ^~
      |                         rq
/tmp/kci/linux/arch/s390/kernel/module.c:534:25: note: each undeclared identifier is reported only once for each function it appears in

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:76410a3fb97665a2b13e8d9a7f171f9c989cb156
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  ee209bfcc3ce037908356ac4632c57a7e422a024

# Builds where the incident occurred:

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40e1620239ade9022b781

#kernelci issue maestro:76410a3fb97665a2b13e8d9a7f171f9c989cb156

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
