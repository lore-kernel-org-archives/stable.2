Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA972576E
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142348; cv=none; b=hFoT36YHkSSk2V/+V8gm1NLFwd5mpzmai5xZOJl0fvbZPpkkRss/ay2dC+O2qzCfWr0Ji8uAOswh054upFkl7H/f70Bu8MRWtue15emTgCqZjrzWY3OKSgW72/LofLWR+I6Ti8/OxpXIpU6cejDHHZrOJEjRzN800AmsDfGYHZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142348; c=relaxed/simple;
	bh=UgFgCsqbzy+psgluyZJY/A4O5WClznqMVZDVB5Ki1HM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=mKRNE1V7VCZlZ82sR27tj03uGQfpPMuybe7kJeLuxVGoGfWdQFkM2IhizEateTMKX9dGoVVlA0Kle/gSuVbQyviRaUkv1KKnSAubGuuZOeMjKHk7wKzpTgf1cY4eEJ6a718Ql06brPszWVRVxtA+oa7ToEGm9SuMn1mkFL7C4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Za4Uxecx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Za4Uxecx"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-39b24d114d4so1314148a91.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789142346; x=1789747146; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cly7JRbRdUNHwgK9yHIRLwXmB2I8t1WsWNGpXhg03Ww=;
        b=Za4UxecxQjyeTW9vPwJg7k7NsdEVhAU03hRqaHia7okeRMESQDVuJjf7atwRjuRjyA
         cEneD5WGYoS30L4xoFI+BL/l5eHLshsqdoSODwoJOwdU8pVHq/0ShjDSYX+A5EoRhSAj
         +jxVnVcR+vG9amyvy+g2ekALO9Ulk/8L464fimOc26ChRegxQh73VOiM4Wkv339yPzZo
         TsMyY42pLfr6wcJcVhY+u+jcF5DMP0oQfF5A0DXNeKIOX31BL6nB2Hqv5NEmhk3xeCTn
         mjMxlWGHSGdK2IuzhXuT3AkIdvfy+glrFnUdoTRo07H0JB2iuv7xZom5hPvxvML17vuW
         mxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142346; x=1789747146;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cly7JRbRdUNHwgK9yHIRLwXmB2I8t1WsWNGpXhg03Ww=;
        b=rBlMeNOccNJDPXC32BXZu8JlvRbtKHNjKjh79dqhejB/cRPtT2oko72azOBZX81oRk
         REwdT9iQQOKErzvY4WSGfCq3EBE88TyPo+f5w9JuyDNCmxDOPdoCIsUYgeYVivhauxeW
         pdkW5SFClJ3oNOjNdo3iVc0R8+nhssCSaaWAY+xxRcjiMpjRCFL/KeGdNLBK2zlw1IZx
         46fyQTdaTBvebE+Av7XQmFIT8wWwJ6gBN7ELNf2cQ/t67XrqF252PrVvk67N7XGBqolK
         EkoHoctUEn6kd1qe4XSNOrlURHipRebvc3fUDkYmwkZ7SGZ32hoKK84l2fJjI7rAX7L4
         3O1g==
X-Gm-Message-State: AFuF++mM7vl1HlerKWAJW8sIH3w1A/nQmYRFVwx7yA7+ptQPLEEG59ZN
	6iBOHWMEC66MuSuoJz4PuC05LNHWH+e3oLxcsftspUM/K+oRe+ro81xA4nAzIh+cLfzQ0OPTqEF
	F73S7
X-Gm-Gg: AYBFou1hHA8jMQmkkWBxGEf1Ym+sxL/9B3BISa77RNNEJZhitsQYe86M5BFXv3jHGWc
	4fD/C5Cgj1rHcUMnD82ysF+PxpPOW+X2/F40fij4SmIg5TDGlceoiTEKZHxVFxfBks8i11I07em
	90wjgtEsAH5zjrrkqFKNfmgFBjasE5TUcpCzm99IcYnbNTKhRzYB7wEd6P+vAIpDl9jIWRVb8lW
	y7I0oJ8pcC8zqafUm+p5uN7u8bNG+x2/moaUf2tPADiJ/ClS8KA8ipPwygPhNbXY8ykyL/Y3lNh
	yOdgiTz7dG86DjGfwxV1Fm0SQrYkqpLCy2I8SrfT1aILrCoMx8KHwR1wIy0SC2cyyYAoEtrtuvC
	3J25Vv+iea57JEXiMsaBa3yVRNaOKtL1TYbLRCWbdje61en9jsun7IPUVTaZc7BnDzGWLORYsql
	h3RijOKrS1FAyaWYh3f7acKe3ONK9N5RjbkW1Q8TR73ENS5NFvt+VBQrWOZGjMvSs=
X-Received: by 2002:a17:90b:3d4e:b0:39b:2c00:c3f5 with SMTP id 98e67ed59e1d1-39d9c345f58mr8447155a91.18.1789142346167;
        Fri, 11 Sep 2026 08:59:06 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm8148229eec.24.2026.09.11.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E12=2Ey=3A_=28build=29variable?=
 =?utf-8?q?_=E2=80=98pipe=5Fidx=E2=80=99_set_but_not_used_=5B-Werror=3Dunuse?=
 =?utf-8?q?d-but-set-variab=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 15:59:05 -0000
Message-ID: <178914234503.4405.14443226098533617760@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
variable ‘pipe_idx’ set but not used [-Werror=unused-but-set-variable=] in drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_mall_phantom.o (drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_mall_phantom.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_mall_phantom.c:657:25: error: variable ‘pipe_idx’ set but not used [-Werror=unused-but-set-variable=]
  657 |         unsigned int i, pipe_idx;
      |                         ^~~~~~~~
cc1: all warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:2c3d651f6e0519c2d9f2df77f7fba3a0addbfabd
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  f97429de1ef3e1b6f7986abbcb45bb115b876977

# Builds where the incident occurred:

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40d5920239ade9022b185

#kernelci issue maestro:2c3d651f6e0519c2d9f2df77f7fba3a0addbfabd

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
