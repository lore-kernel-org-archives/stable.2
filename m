Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D78344D9D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794748; cv=none; b=OfIhxr+yftLcNPY+0aOx5J/VdGaKzRmsgXb3x/8VZvhDdlYC+mFK2+5NouyXl1Jawuhxv7X8ZvBCJRv7iqPFN53ZrbpKnACJ/kYJrQ5DZJwyXBzmu72nS0xYXSZ4Nxlq2emujVpCPsCyyojQ3o1z1V9EH83i351MzI5Ovu2DP9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794748; c=relaxed/simple;
	bh=S+FYJEOnJCGKbha42d1OJvDXk/1+PTqlSZEAMcMNlpM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=sdOLe1olZF1da08UEH8hGG9yTb+kN7MiaDQ0OcXFjgBAd/sStQ47WTRKGWAWzjpWpt+Kx+cnOdJWs3zCmYZBBGLIEpHnSfmSll9M58z6wuzOxtLTAV47wpYKPIofZH3q0aUGIJXws2kH9uMYFzYjtIdiQ//IBCsWyqjm05Zfggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=d2v6QyTs; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="d2v6QyTs"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-145ab8fd39cso5187357c88.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1790794746; x=1791399546; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Lxch4hn5ZzVN8LPp7u6YAs2+5Th37m3fSE47GbI0a6k=;
        b=d2v6QyTssNmGSSs/vvtaRLIXefCq/vUHFiXEKCowFNc4TqDTyKCALtBnE2Z3u3RicA
         6niEg0Yxzzr0m1WAo6tYSeyBjvbalSSvh5uC0dKIIFXNh8Fixou2ho2Ujf63FjHQkBgs
         UFNR6+Z+wYHMGukoMy50iCDpsZgn7iFeFpSc4fl8VuFj7cB+MqzcQ0/IGVYtrwyver3A
         so910CybZOy2HjS+zYFWPl2TKJ/NDhRdFlDQmITMZm1Nb5HwNPxye0nLgQkUHgGSDdsq
         3U1feKsG42b1d3QnE093Mu/BJdqF3m9wPUuviuU+nldcDi2TMSiQEB6cteCAhjs83mm1
         /AYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790794746; x=1791399546;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lxch4hn5ZzVN8LPp7u6YAs2+5Th37m3fSE47GbI0a6k=;
        b=dmrl0DkQzTM2dJFfb/ChHtxyBUC3Xp1ZpvhRztjtiokqSe+TQ+5K63Gs+957KEh90D
         cjsMF09Px3gTlp20GH8QPdFIXUehzjdQFHePqJ4YZ5qROnG0Ir3g5VNSniu4vI/I4gi7
         zjPxpDsxEtkUp/On1Puisx0Pk5BnP4YenGCoUjkeCCCW/Sv7NMeEePI0pM9sfQKMpt1l
         LhS+pOBTMcdW/BC6f+hmmGRfDW/PvJFT5+XcFHWVSe7HTqbTaaddWIIyBNJb4WkqsS5m
         KGBrBsgu8Qerhufdb4soF5dbbK5oljJrk3zfpDrT67pZia7wJ8isb9uzF6zqMkn/+rIy
         hIew==
X-Gm-Message-State: AFq9FYLRjoNXbyIQWZWTpLovUfxzHHDyK5Wr7GW2zejQRb/wfVIvOgG6
	E/xTIC9neMhQMFZdk8klGruaOsZ3EFkM+YzHqXATXI17nd5/DNym0lsdadNNNxoyKO9aLDGPhA+
	DlaDo
X-Gm-Gg: AYBFou1JXuwxIo7fWbhinPJol9ErFkGCA4XmeIdIa9p6hr8y9DMoLDCZ0WCCcfEfYum
	N53qhwFW/bIB+rz1sHpRyx+UW/zO9bksAu8hApq75L/jsy4+WVkE2u2T4KHbFqkhw2r6R2c5OAc
	h+oPCwoJHz/g3pVDbKhsyWObQGWaQPXY1ph9gvXYEJdRDmi1JlWuVESlh7OGiGuVCIWhQpfxO2v
	ioDRtJbg7Bh1RIGnUYWG7WB1RdKE9z/XAka0ziiyKsryN7YbBtehMPOBPnxbkw6wVcq1KiN4Mfg
	5lqGAFSshVJ5URQMPxBVBH6VR65v/ay5LKXxoIjLKN6EsbOdwzOSKZ6xAMCT/NQsVGKPfyqMZxb
	yjj7L9YwbTaoVLKe5qxXITAz0FDVwgk66it/He6z+CkCwqtx7dCrzyt2XaUDzSREQvlHy3d5bS2
	ok3cvRPO8i6s9DhvCb+vvicYjtKWcCl0EOmfeg/2GfYotISd4R6AaVCUg8PmAjDHdmHBF2AGhJ3
	w==
X-Received: by 2002:a05:701b:454b:10b0:144:eb46:c40 with SMTP id a92af1059eb24-14d35955efcmr2234955c88.9.1790794745527;
        Wed, 30 Sep 2026 11:59:05 -0700 (PDT)
Received: from 5a6d9a2c18a2 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14df40e53dcsm227468c88.12.2026.09.30.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)variable 'rxd' is
 uninitialized
 when used here [-Werror,-Wuninitial...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 30 Sep 2026 18:59:04 -0000
Message-ID: <179079474381.110160.8218134092165393078@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
variable 'rxd' is uninitialized when used here [-Werror,-Wuninitialized] in drivers/net/macsec.o (drivers/net/macsec.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/net/macsec.c:4543:27: error: variable 'rxd' is uninitialized when used here [-Werror,-Wuninitialized]
 4543 |                 list_for_each_entry(m, &rxd->secys, secys) {
      |                                         ^~~
/tmp/kci/linux/drivers/net/macsec.c:4530:30: note: initialize the variable 'rxd' to silence this warning
 4530 |                 struct macsec_rxh_data *rxd;
      |                                            ^
      |                                             = NULL
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:719d5119a7ef6d0017519b250e841348ca75deaa
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  f4ffa8dc360bce834e6ea7b0148eab0118f4a42e

# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6abd3fc65ec73975aa0a8451

#kernelci issue maestro:719d5119a7ef6d0017519b250e841348ca75deaa

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
