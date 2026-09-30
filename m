Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299C93A5E7A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805656; cv=none; b=U0ri8OIKrOZpwMTSvd2R15DrcI/Zpv8kmfEUAvW6Yup5rv4Jj7B5418Gf06k4nYochmGh9HTZaJuzeHZ4lnNEZv66aGZgVUAQOao4lddtpiJtpFWJmR5/uA2/vQGv9+GSkWAbRxDLzNvTNYEL6WdleZXHwqya2E1+M0iXYnGPN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805656; c=relaxed/simple;
	bh=ajVLTPYPMxooezsmIGyNkv1OpESRlX7H7stGt6jgjlo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=bg6cbp55rw6Rjxx4zEDINPoCfMql/6yQwFG5P7yPYAfzlpOWAtBH8RxhYb44QX4mPl04QEgadiQlTpxMpNUpVnHwvXhKqJgBOMv8NG8185Qn10JbdpbH6XCryJHuhE/guHyUv2eHsegHsRHkeCRshEsgro7yXyKzHz7hMeIlDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=gP+93SUs; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="gP+93SUs"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34d2d25127aso587033eec.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1790805654; x=1791410454; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WwAG8qRjpy5gU0l3GqUietypVK7nuoTL8C+SRuk0OOE=;
        b=gP+93SUsw/rkQ1nkM0oQr0kGt0u9gZcK6THaCk6CqnaJiANzg1JAtDX0l6Porqd7JA
         uab/uFh+n2tC5t4kxUf79pSjWR5cZkNPelZjl4h6E8D1X7pNS2reh+5w/H3QBjd1tbXg
         7Ih1ZEHP7gJDpu8l6fCLHuqfwCzb7bG/SP6iLS4hG1kKMoxqiM0tKi0bJmjZ47zGMh+8
         tGYcq+8h1hXFvBv9IFGYnQAl8ek2YQPmq6z4TeajBuLuNjMrxIKGaF5/kfbsk4h+A7c9
         8pN7d64sZs8/0E96sygOOCEJPvPYXm7av/2o+Cb9x/jG1N/xKLZ/Ltwuf9x43BX9A50P
         5KHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790805654; x=1791410454;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WwAG8qRjpy5gU0l3GqUietypVK7nuoTL8C+SRuk0OOE=;
        b=eDwdJN3kc/iN4PBMlRWfldV+rsaVlqxkI19RSvjZyJGpj89fmkQ5Z41yareu7J7itz
         A+JleTTy/ylxZzLogGHqiTESLxZXOxkQ5xrfjemkl4gKw7W4yUXt+t7UKEcERsr+Q36z
         eX/dCTiZfxgyyP8kz7fY7AlC4xVAspwGigsTPB+Juv9xeDPD+PyOz+qVUkVyB5LlkU7z
         QmJbTPVsnhEWrxKPS7+E2nojt+UQCPo7BKFAGWOCewYsW6Ey9kAzWqOsE4nZLYY60A9j
         gIWsUqS/ZMmSXFKuXbCmHFBNJknfPwEGm3Lwc/6ebNpMW3xzZ6K0Ne0/td/5FRWOGvOD
         QS+Q==
X-Gm-Message-State: AFq9FYJ5BT8mjFjtRXW9qFZfibh3NN8UMnhX6rz4KRJ4wosmW81ZiQ2Z
	WJUzLFdUHcLizTr5bRfBBoYzxaHWgEq0oI/9Lt3p/2lcEqk+NAjGHdIIzd1tL7HcK73CYMLJFdF
	xW5FJ
X-Gm-Gg: AYBFou1WAY1sdbHj3DCc7hF1hn7U0X8W107dh5tXLGecYwGrc7K6Mf4BF6YajX7IwLa
	8iz/bUAHTzjuhvq81bGDBn1DwMCF5iuRuHVQ/eK5AwGFVbTc7onX2XNpoysjftaHP0o3qtaGItL
	7t/cahudSFWQuuP72VFd5b28kMaGupHpHZHFatL61YJ63qAySelLaCXako8iUm3xHGfhZk8rNwx
	cet287+WE5N4DfgWqt7lscsEDyKY1qS0tAyrAxIkbY09yed3hPAFDVFyNqT89bRr8gQlt39gV+u
	0fHSHTOrcnWwP47IIm3XclrN/uZESR037UIKe5qsiI9dj+GBDP9azddf6qiX4lS2f0fqxusmPYs
	A+/YW2UTEsiAHjDpNOrAQT5XvT6IeBhSC22hRlM3cx5dV7uR9ZXBenCO3a14O0a6bEHtZLDw6vg
	471B0s6sKnuP3EvYLdThrlPN/2EUvY9iIeu90rPLpGFRoX4mtJfBUoaCb4BKzfrZg+Wfo+KW/kt
	g==
X-Received: by 2002:a05:7301:9a81:b0:33b:c24c:d31c with SMTP id 5a478bee46e88-34cdc0cd8dfmr2710851eec.7.1790805652393;
        Wed, 30 Sep 2026 15:00:52 -0700 (PDT)
Received: from 5a6d9a2c18a2 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db4d1d560sm1493013eec.29.2026.09.30.15.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 15:00:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)cleanup argument not a
 function in
 arch/s390/kvm/interrupt.o (arch/...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 30 Sep 2026 22:00:51 -0000
Message-ID: <179080562511.116660.6014762431387053958@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
cleanup argument not a function in arch/s390/kvm/interrupt.o (arch/s390/kvm/interrupt.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/s390/kvm/interrupt.c:2930:16: error: cleanup argument not a function
 2930 |         struct kvm_s390_irq *buf __free(kvfree) = NULL;
      |                ^~~~~~~~~~~~
In file included from /tmp/kci/linux/include/linux/preempt.h:11,
                 from /tmp/kci/linux/include/linux/percpu.h:6,
                 from /tmp/kci/linux/include/linux/context_tracking_state.h:5,
                 from /tmp/kci/linux/include/linux/hardirq.h:5,
                 from /tmp/kci/linux/include/linux/interrupt.h:11,
                 from /tmp/kci/linux/arch/s390/kvm/interrupt.c:13:
/tmp/kci/linux/include/linux/cleanup.h:112:9: error: ‘for’ loop initial declarations are only allowed in C99 or C11 mode
  112 |         for (CLASS(_name, scope)(args),                                 \
      |         ^~~
/tmp/kci/linux/arch/s390/kvm/interrupt.c:2942:9: note: in expansion of macro ‘scoped_guard’
 2942 |         scoped_guard(spinlock, &li->lock) {
      |         ^~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:112:9: note: use option ‘-std=c99’, ‘-std=gnu99’, ‘-std=c11’ or ‘-std=gnu11’ to compile your code
  112 |         for (CLASS(_name, scope)(args),                                 \
      |         ^~~
/tmp/kci/linux/arch/s390/kvm/interrupt.c:2942:9: note: in expansion of macro ‘scoped_guard’
 2942 |         scoped_guard(spinlock, &li->lock) {
      |         ^~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:198d88d6c2a9310ead35770f1e32000ccb7cfd2f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  bcfba26b751025aedcc05637fb90c7e513a483ab

# Builds where the incident occurred:

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6abd3cfd5ec73975aa0a64be

#kernelci issue maestro:198d88d6c2a9310ead35770f1e32000ccb7cfd2f

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
