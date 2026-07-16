Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D39C38F24F
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224747; cv=none; b=WeqBi0W/Tf3wHyayjSYfSWl0EoOC4pNMKgMUUFlhwmjUQpUI8SBNHeQD1KtW+sq1g9QNxTvHyrPAAdM+zT+yPQZ1SOqXMKvTtwOQmz/CdjtWYucOb28oFF9HsfnCcz7JJYRY7Z/mPuRgcwidpwhASYjPZMo4Ad8baCl0vku1h6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224747; c=relaxed/simple;
	bh=lxBDqb3YX1fc3GNIeAozUvaGAwtli0boWBoZhELoSCI=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=STSAnE2+SMCuAAw3DNFhF+BMFSmihY0a1ZtgSI9vIlL+4fDtZFgH2ih7fSPZno7+uBOWOhXYDZnaHJGenEKD/NbVWB+7ganiDj9gXF8eG4HBvgS5NQ8UFCfN63sRIfZvKVfjhKZ68VU44jFjBDGPmXQcmxdjxm3kLjTcLtyZw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=I+FCgBHq; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="I+FCgBHq"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c88a4d79ba5so4649081a12.2
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1784224745; x=1784829545; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r/91fheDqxpRnO2zqOJxwdIVXQMQcLNexHzjVPLp5yY=;
        b=I+FCgBHqCyhcKQC6pE+kf3ayNbUiK2nwGOgeOs/mA4DYArPVGXbUA/ToOs3uV3lC9l
         7DzFuaLyJrxGWND+xpBJS9T9rNaaOeArQUsdeAMasrIVtEel5JPqf/N5ASyQ051eQkWK
         D3xGaIP+hEjl/p22wjdfaf3B5VsBqMYiXRluxZs0FSlb8DMUi2ZqR6+XvZtykStRat7Z
         KriUlqhzsemNZeBg1L0/+6vdlLVLNBKeLKAh+vU2D5evraHKr9C4W9RQGThAuU362X0x
         kwxAtoruEzlH/upYmA2oYqHYIZkZStAqghMXZ7kj5nY8+DUqaGYrCBJV/f6wH71h85Nr
         LeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784224745; x=1784829545;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r/91fheDqxpRnO2zqOJxwdIVXQMQcLNexHzjVPLp5yY=;
        b=rNDBHh/MDO6C0/YggD4IqiC/+WYv7J1u1MktDvRdLGOXsN1qDMRC71mgPPAbGDUFMV
         J9HQykeK/uR4k7dDqoXuDJnthBenN7jtMlsWBEMmgZXHNTFUouP5TWENafYZVtO6JbKy
         3jX7JzBvrp3ODvfAInfzAbmpcrwJKRaE1z7IkDKkIcWPeg9QFbhCMxq8RhOrO+FU6DBV
         EJlNPM0T9mgCY9xQbSIIJBFfIntp2vcQsaUpHR6ZZuWXRANPlttVmzzpPYbZ0pvly09R
         DHgMg73DfpP+6PU8n51k9U5zUN/24A0Xp78KNxyOAdbFrWhXmv+ySGwbrD+ng0deT61s
         8KIg==
X-Gm-Message-State: AOJu0YzWbMnQLI+urj0EJs01Lw1Rv+VJA8zk3jHTdQ+6evaKxIuxKI49
	CoCnBGZnhFoEkGhbW063L+igIZufbiVbDtbWZ42tvHAOY6JLYLmpPnY3wjiPfqP+5znvx3qh72H
	cQBlJ
X-Gm-Gg: AfdE7cnve24Itiu5uB8dE27HDo1yecpHxl0Zq85rH05MRZG1AygVBG2qsWQXxdFV/Oj
	3mqzR8ecWcJitb7jlOtBo+grCflCA2Ycnw423RMRUEUPTgTitF5bWtVJj09c409OKYBqGxd7+YS
	F8j5prHwDLamKXt8EQElaFrN4EPr7jDkZZ029EeAy0PbiClo8b/xTSlI0ECLWcHDhN3lpL5j0s3
	tiS4DCGGxxZcYsT7fxXh/PEElvZfeJFuNO2GCe3cNRI/R6TqqtsZ/3rT/JRSJgzlWUj5gU7jxMO
	RNSmidKoUcEIu5k83wROEbii+8rWw3mxMl4FBdjOHE0otju7DBi8LdfFuFF58m0rhiYQF/cxOJE
	D8ESRKw2P367yB9z9hY+8HKa6Ia0XJ7Js3zuppNRs7d9rc89bvecj7gS/qnHuFqLh4rf1r9Q=
X-Received: by 2002:a05:6a20:918e:b0:3c3:8aa8:6caf with SMTP id adf61e73a8af0-3c38aa87406mr4683077637.27.1784224745193;
        Thu, 16 Jul 2026 10:59:05 -0700 (PDT)
Received: from 963b246bc1b3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cdc4accf4sm4361376c88.10.2026.07.16.10.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build) in kernel/time/jiffies.o
 (scripts/Makefile.build:229) [logspec:kbu...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 16 Jul 2026 17:59:04 -0000
Message-ID: <178422474345.11595.3718390216125966001@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
 in kernel/time/jiffies.o (scripts/Makefile.build:229) [logspec:kbuild,kbuild.compiler]
---

Log excerpt:
=====================================================
kernel/time/jiffies.o: failed

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>
Link: https://lore.kernel.org/all/178422474345.11595.3718390216125966001@kernelci.org/

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:8cce47d63ae789c9fca42a4fee2b12cc4155616c
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  5a3bcd4be3fefa46acd7edc3fcbcbf8be76afb7c

# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-6a58e9b53427a5b0fbe33543/.config
- dashboard: https://d.kernelci.org/build/maestro:6a58e9b53427a5b0fbe33543

#regzbot introduced: 12a857d79c6db1f88718d1801bb4984942afdcb8..5a3bcd4be3fefa46acd7edc3fcbcbf8be76afb7c
#regzbot link: https://d.kernelci.org/i/maestro:8cce47d63ae789c9fca42a4fee2b12cc4155616c

#kernelci issue maestro:8cce47d63ae789c9fca42a4fee2b12cc4155616c

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
