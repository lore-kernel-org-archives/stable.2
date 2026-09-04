Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBDA42255C
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505152; cv=none; b=uq/DoGwhpbIFYBKLQ1MyOWTjDq4s06gD7/5xEYsA1VkqXCDUjNjFq1oqENlusaC4GcUxJ9zEIoEG6SjEN5m7FUPNu5vsuf/3k6VK99QTmEKHcw/cJOc7sIwGxeY8V9BuwsW9x1bGBCEwZCm4Lvyo/mEKgFeR3DAv+f3cpviLz1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505152; c=relaxed/simple;
	bh=T4/wmOOPctQA5bEUNNeLQrLznXLBSFP0br/KjiLrO/M=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=GoLJIBZyNB7ekGKh15U24Vt4LF/Bl9AKw6ox69rpRP6DlY9MTzxFAg5zFbfZI0/xC4wOu9rWF9O+ht6Noq3kbO+cZcTgBwnBvx2AV6QmaNBEVJ2cefzofBngXuCJKlCoXvZi1J7pvTZ+rdHWXLJwupaF5dVAEAjMBvBtO+aLBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=AEi2rB+O; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="AEi2rB+O"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1cc97b84bso604110a12.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788505148; x=1789109948; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aXdlDu3NS+2wmlGCQOpGQKNPTEKlWXD4GHQk5JYOazM=;
        b=AEi2rB+OIOtOMehE+o8gNG0Sy8XJLjt0tY7UTgjdw9iDMxaXPVzmiGqRpN9aUXWmcu
         VBpXm+sb4nlzZmPcbHz3s2+D/EyYElW6d+425PCa3RdhJcmXNGma3FwwaVD073RNL1B9
         OKWbIyj3ipC0zZkLv37DNRmTcOtTV4HMWGpGAXiDc7+0I8xihrswQRnuLeFjhygSH3rd
         uZ+pIT2uHkczIyKIQZIWlbnFFil//XdGxOf3go0F8PtSzb0sdbutHNiDnn3zaI5OhEG0
         hFuYoeOqwQqjB2heuf92/gnF2ezevEDoZ1sgbnzO+vsczoH8jJXYmNmtV1gIHVzpBIKK
         ukJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788505148; x=1789109948;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aXdlDu3NS+2wmlGCQOpGQKNPTEKlWXD4GHQk5JYOazM=;
        b=FNnSy6MRAp7uhF9PvPk3Luoq//oEwcFBDU382dEw2pjruwKNQhgLQi//tPU8Vc5xGS
         9AqrBLUmSHy6NQ397TBIF66o2OyJ7hNikiDvmP8GIrqagfdJH3v7nIckPQYUaCyWlqEk
         Ldpy6zaAEdaSBW9B92EWbCKYbCxIBPWo9Jh14um9qXZOk/p5/7r5Lm9NwAYZgCtRKGy+
         sp9Qh1rR1S+7GMU4vs+tUt9ezCrwP7KhmSaLxntz7D+vpK+1ZVafI9jHE3O4A6TDr9dG
         WuRx2dNcpjm6PEdluIFmQoU86AEyH04x/Bm4fB2zH9UfVZ0W981OOAcWn5lF/GHN3MZV
         nPKQ==
X-Gm-Message-State: AFuF++l1Na9rfJK3uBBRo+8qDFRi9eYAxp7lsOwdd7JkIQZPZqySXgqh
	F3lcey9WaC2QBD+/HrZNuzquPsWFITNDmfsxdwaA4lQ/a2u1waNFr/j4wd7nrz3ewxk=
X-Gm-Gg: AYBFou2pF3/lwHGrsxqq/xIh96OIAS7ziQjjCP5uWc7r5dmUXp6KV6EGBWx+ONCJ2mX
	/BNT/x4CVaYdzBLs+VWxd9wmLvV5/lpQZYEjg0KAZ7YqtqG2pmzzysO4qjEnoOXyna5NgOW5auZ
	f9YKrt1S1tACTtUAU9SAc4LkbM71H0VgNEbQTFvKLcEl6LnJWQcb7EBtoIVLPK4Re9MPrH3la3F
	1S7AU3MV7O4h2mZ8/951OekgMkJ+23FkBHRQdir8oZLqM0Wjv5oywomDLX+n9DjbA26J5wvNrFb
	qx14q+PsKeZgrObwW9LAF9ASpw7CFhnJxsbbthMCB8XMe4AcSF3v25l0l0pP6dlxgwOr7EewUO4
	i/QJ4X50+Tn2iPQI4cPmUaX/tNhF8vcWgwbpJZmBcpw/sg2YpMbh82lZ83wR3saXcylsan2RuIf
	HIlzxJFUnmUrFKg72uMRnoZcxzqhAzw0j/7G4utYXI1cCTt9tjoYLL
X-Received: by 2002:a05:6a20:a127:b0:3c0:b943:f984 with SMTP id adf61e73a8af0-3da39d18786mr5499256637.3.1788505148263;
        Thu, 03 Sep 2026 23:59:08 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885d29esm4769524eec.2.2026.09.03.23.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:59:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build)implicit declaration of
 function
 'huge_ptep_get' [-Werror=implicit-...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 04 Sep 2026 06:59:07 -0000
Message-ID: <178850514681.887.598949890453548491@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
implicit declaration of function 'huge_ptep_get' [-Werror=implicit-function-declaration] in mm/page_vma_mapped.o (mm/page_vma_mapped.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
mm/page_vma_mapped.c:110:25: error: implicit declaration of function 'huge_ptep_get' [-Werror=implicit-function-declaration]
  110 |                 ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
      |                         ^~~~~~~~~~~~~
mm/page_vma_mapped.c:110:25: error: incompatible types when assigning to type 'pte_t' from type 'int'
cc1: some warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:b5a05b306f5f7f53772fd8c0b9f34fd76dc8b810
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  96ff57c9007ff0391c80864ebe06496d592e3b02

# Builds where the incident occurred:

## haps_hs_smp_defconfig on (arc):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arc-haps_hs_smp_defconfig-6a9a5fffe41d7f97d6fd7829/.config
- dashboard: https://d.kernelci.org/build/maestro:6a9a5fffe41d7f97d6fd7829

#kernelci issue maestro:b5a05b306f5f7f53772fd8c0b9f34fd76dc8b810

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
