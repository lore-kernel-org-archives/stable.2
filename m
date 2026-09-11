Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8206A3939D7
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142351; cv=none; b=Fi84g8bPISK8ughiAuxUCg9FO6svyrkulRdixjIujugcIpSTnt7Dl115v0a/A4QQiX9Jy0ljt65GcAUcPiSmq9hpoUSl/FUd/CYdwI/woHjFypcoNHCh2jX3pAx3SnC6lVoYzpSGTtQU06WSRPXQvcOIRWGZ3f/lMd3TY45peC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142351; c=relaxed/simple;
	bh=VsViUpj95i9Davf7srK3+FY54hIKcSdLZMmOuVpQX20=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=P6YmmtbPq86hvbzwIX9Yg61qZ1j7OfXD02rOP9zSN3gYUKyw4EQU8MecabB+d4zR8CciovX5vJHTtVCk8EUaHZBK2aiviuJ33Hd1TudoFn3JTxe6/6/UHqQgohhItIt3+Pgx26YrFK6ethkHok3MjUSyI0eJ4odm77Kxpnj2tGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=NBedmbRi; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="NBedmbRi"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398b3c37877so1038571a91.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789142350; x=1789747150; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mu7ZgvWWAV62ZbQUgKI342yczY4xeJVX/snC9gP0ccY=;
        b=NBedmbRiB3+GzUsxnPHPzBbXG0lXX/bfpk8UiJTdCBuPB2Vj2Kz7uHvFaRGmLNM7G/
         q5Xet9QSVtxgCInPKX8NFisrVAKtv49f79ooSn6Yqb0hou9gMY/sIoiVw4xcUnIjFSCv
         DLWMXe9A1Yxdt5cZZcfv1+sIpnQAsPcyTvvuHZhv4rL2I3XOva6/b0G/7yOcCBAwkImk
         w6HalEewUYk40em57gtRct6XEQacRpgoYejGzj+TfO0cjvyL/eo0J3NQ7XTvpHJ/BofG
         cx30FeD08ENhQVVAgh5Nk9G5WVXlQwY853llVct8P9EupZWs6wF5I3LN/XAX3vc1WsQJ
         ChwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142350; x=1789747150;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mu7ZgvWWAV62ZbQUgKI342yczY4xeJVX/snC9gP0ccY=;
        b=XDflAp2RH+Jyhb6MNKNWoQap2d5vXFkmhBOTmkF9HnfRW8J3uOxE+Ek92T7u2fBMy0
         /fN5vZn5xmKVvNVwCzEEyEJKbk67CdzuY+j4uxqiEit4kkWwrquw6mGiQA3Ocs3tDVu6
         iOhniTdwhPUIcQ3y+M1KCJCBR3dw2Bru5CQaGzAmH9dvIkpHdo0VgbQm9rNpGQ+v3yUM
         KzZDlBvD5g/9Mk6v+QVeEG9X6E0Njc6q5MbtdXyqy91VVwwE1DJUu+dqjAHeCQB9rGU0
         k8/MSU/cWF2ZKXFhFjY3u19MFh1UxhB4qaUkkToNUoZ2vDQUDF5HMH2evkwzG34KuCoF
         8qiA==
X-Gm-Message-State: AFuF++mFaJVFpWRGrqy7OwCJftQ6cmNNKG45iJVh6RUugkJj8XTSZr6Q
	V/oHBENlhlwjuR4W1T+Xjf6ACD0pDTiBmsF9RBApsH4lCZGHqAZHhokcgD76mJ3CnXA=
X-Gm-Gg: AYBFou25KWv+w5pt2Pa/3BGo80GtRy7It5MrOr6u9w5mQXXb4v6MNt+CUozcdXGy8o7
	Z9t74Gf5E7SClTPvb9lvpMKP9IEEVj62277NIBnA6Qb9UAthZLQ0+I3EuHUiAf8xiS6tiXFBoQ0
	3fTjX6pc4xcIgxJadGCAcbebkqUQKVTswUHgZJTD7/siFDsVJ8Wu05Eb9Vtrt31q29+Cwhj7BQ8
	vp8HD1Qky366isjOpQP5aHpswbUxmQxcYWZRtBT7KkrbYBCC39sn0Evf0Rq6g/8fgb6yeuCXYaQ
	97s3ZASmC4GEOl1ndpZ4TMXq0px0tgeqg61XISXBhPdQM5H99CWTKFAOuoPZa1V9/NUTGuOqyZh
	VWbBaet0D3D542jXZYnflemCeMpMQ+zW6JDfR3seKyxrwV0bXYM/PF4YupVwq2mQ7SOEgjRo6AB
	KY+htKqF8uLuucNAO4EJSUHyBgpOoSn7IIYEzh7lL3doOBWX1zAqQ430m/f24CbluEE0ytIqj7G
	Q==
X-Received: by 2002:a17:90b:3842:b0:395:4de4:92c7 with SMTP id 98e67ed59e1d1-39d9bbd878dmr7953421a91.3.1789142349657;
        Fri, 11 Sep 2026 08:59:09 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365a59b18sm7446311c88.2.2026.09.11.08.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:59:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E12=2Ey=3A_=28build=29implicit?=
 =?utf-8?q?_declaration_of_function_=E2=80=98bpf=5Fatomic=5Fload=5Freg?=
 =?utf-8?q?=E2=80=99_=5B-Wimplicit-=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 15:59:09 -0000
Message-ID: <178914234865.4405.11502343926415375232@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
implicit declaration of function ‘bpf_atomic_load_reg’ [-Wimplicit-function-declaration] in arch/s390/net/bpf_jit_comp.o (arch/s390/net/bpf_jit_comp.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/s390/net/bpf_jit_comp.c:801:20: error: implicit declaration of function ‘bpf_atomic_load_reg’ [-Wimplicit-function-declaration]
  801 |         load_reg = bpf_atomic_load_reg(insn);
      |                    ^~~~~~~~~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:4474a725e9b432d5119a16b8baeda90556645aa7
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  f97429de1ef3e1b6f7986abbcb45bb115b876977

# Builds where the incident occurred:

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40d5020239ade9022b123

#kernelci issue maestro:4474a725e9b432d5119a16b8baeda90556645aa7

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
