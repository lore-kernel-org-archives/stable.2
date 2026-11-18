Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003149;
	b=DxiIB89ow8UwJHthHBpZfB95in2rpnBqGtR+wX4ZY5hnAJPEcgnGjcIaQRRunUVdofQ5
	 qvn4XCX+TIETo3kfACtUkGY3pZVe4wvn9NxIbalGcQTTXgrzIqzettCYI/TJylTvd3Z39
	 dcjAYctZlfr7r1I08h4aYDQ1t4o5d4rJp86WHx2Sxi9KceePAbDokYkg0uxS+JnCw02zX
	 Wciczt0lTAM+AS85TwjMTOFhuoGgYa6/umMuTf0cpstbwz/ie1tlceqsDiHUkm5Rt77Ps
	 ZDzCL+ZrmT07V2iA1DO1AZxd/uDyx/poGcb5G/eOOcFk1GMQIe7DYVHt6/etL0ss5oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=Z09cmGJnGdGJq9sPzsTxaI25PprvJD+kEsu9VOIKoVc=;
	b=49xCh+eLMX50pp2qq+co93z1eD4a7hBM8rpLvX1iLnuv+mMjsME0rTSzKngP2Uht61XS
	 idmRG61LyA0kZECa2UBVOv67w794baK8fNxwgHvtih5XAQjqN78PWwJ49yc0KmoE067wE
	 mxEFG2wV8cjGN2nN3cWAx/yTwCb2B3y9jfX6twLx1cIIZatC7Wj089oWJ4FVRzD14qVS3
	 9eRIU0rHSkF2FbMPTtXmQYuz/1klOYlTd7yM9VPalyaRZ7/SRePcPgKHgbavBu8+0TNe2
	 ienXlh/O8OS4A6D/QaIjVYTXoaR9JKi0v/p0nl5UFu48VFNKvXoFEmATu13giHE76lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=VB1l3kWq;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B4606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 999B4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=VB1l3kWq
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-372bdb942dbso1128127eec.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795003147; x=1795607947; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z09cmGJnGdGJq9sPzsTxaI25PprvJD+kEsu9VOIKoVc=;
        b=VB1l3kWqATC2Bne3TsCKKJXyTEIHwrbjdVfVHoOVnQHP5+rq7cjP8i2mMM87G6ijhj
         HdhUzc92iNBgVoNPkODRCSt6QOmOJe0DVD3ozRdNF3mWdcWtK4HagdEsQ/GpMsX07R5w
         pX3vVO40t2Hc28v2Kvobfa59cPr8S713kIPs2MrPHNhhcMYvKwSrOTZ8Mwx8juFr96Zu
         0t5sEu928W265K7OVqLi4dBDki8RjlDPrKyyfyxKnt9XWcb4eY3EfR4RS6rc9cGxUY0o
         beFlwGZK7ZbMZNpi2WiMm0At5KtDjM/XezwF6IUWDWoqHF2Pbare21IRWRnbai16EqMe
         6CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795003147; x=1795607947;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z09cmGJnGdGJq9sPzsTxaI25PprvJD+kEsu9VOIKoVc=;
        b=uXO9UhqoVCykce9TejZlPGDGBi/SVvSNu35E7/j2dmU/7H6HraF0hslNw4g7MQNdHw
         nBScoXceu2A1HVZ1F1vkQpHpOsk4wUshkyvaIvwy6N4ckQszpnDlQ577k2TE/qVltkFs
         nHX7H/ULQl22midmec5w9HC3vOeINhZ0a0RI1wt98ltDSYTU+fNEo3JjB5f2cAB9NGsr
         2BSXO5L8SRBZhXFeH5quH0UO7+rDOrctR+s0k9QDMA2z0XyKn9wtT44G1tZ8Oki+5GHu
         JWU3d2cj6VmLiN62/RcsFKL0ZWR3wJSv0kFTAfdkPXlYYDLNCkSMEAt0frr7nQGxIbJw
         9jVw==
X-Gm-Message-State: APuU4Z8256AzSfa8TDuxlB1ha3vMm8dq7iwegXcc0OB8iy7S2IAIbBPi
	9YjCFdhoWamnrhkmwyLXzWLyCqAOrE+fYMCMieeBxP48amYRGRcfrelgvtrJbmGCW7JPNCpkeEL
	ndXYl
X-Gm-Gg: AZFdTZcesE9MkI/L/T6DPIyj/zmA6TDx94Ncn5vh4QSQZcyS3w8QT0ZUOPczs2pXTHu
	gW/36N4kSIia82kPsn7F93C63DsWR+TxABkfmw/Ne6L3ipqSVdRVL684uDTfGJFmIc2kfEI8wky
	G+4h859iGFP07uyHVqDk875eIAHLtPG8RS7oqEvdUmLblfUxGo3CNxhwe8Un9f60CvMEaGXqLUR
	NJ2RnNStJ6pT3ge9XzIBvuLUmkR8BjyM655SgMCl0EIzIzid+uFQ8ixukwKqSyiINDS105c4M9/
	o3QGEJDjCMKClJ/61QlD4SLMh/DlDnMHrhlF4T0rww08Yw/AUswLWSMFeb6+5CqXHqUWBoVhYwu
	aAbi84ARUToZ8GgIuUpY1r/7OaFp4ZkIps4Gol60YVjQOqwOOvfvsgHtv+12WZjKK+xn0VIaZ5L
	2wygwOWlHDFEfSOLhG6XIMzX+9qmUYWhiO3nDVulKUcM0rhKHEBU9252tGXPtUgQ9J8xTEzUC0e
	HK9DqnMldV31a/kbFMt/tGciTKyiHIwTM6I8GO2j/LS8+QrWYfUicGR8F1kEJydbCzP85Wa7HFi
	Cjj/WB6m1B1WWyxcrTy1GFCuUVoX3ElCoBsl/Q0NCzQ=
X-Received: by 2002:a05:7300:4307:b0:376:c352:2fcb with SMTP id 5a478bee46e88-38281020584mr2992746eec.9.1795003147004;
        Wed, 18 Nov 2026 03:59:07 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a45260a8sm12935625eec.3.2026.11.18.03.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:59:06 -0800 (PST)
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
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E10=2Ey=3A_=28build=29too_few_?=
 =?utf-8?q?arguments_to_function_=E2=80=98pm=5Fruntime=5Fget=5Fif=5Factive?=
 =?utf-8?q?=E2=80=99=3B_expected_=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 11:59:06 -0000
Message-ID: <179500314572.299494.17615552470845616329@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.10.y:

---
too few arguments to function ‘pm_runtime_get_if_active’; expected 2, have 1 in drivers/dma/ste_dma40.o (drivers/dma/ste_dma40.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/dma/ste_dma40.c:1695:15: error: too few arguments to function ‘pm_runtime_get_if_active’; expected 2, have 1
 1695 |         ret = pm_runtime_get_if_active(base->dev);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from /tmp/kci/linux/drivers/dma/ste_dma40.c:19:
/tmp/kci/linux/include/linux/pm_runtime.h:42:12: note: declared here
   42 | extern int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);
      |            ^~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/dma/ste_dma40.c: In function ‘d40_hw_detect_init’:
/tmp/kci/linux/drivers/dma/ste_dma40.c:3306:32: warning: returning ‘int’ from a function with return type ‘struct d40_base *’ makes pointer from integer without a cast [-Wint-conversion]
 3306 |                         return -EINVAL;
      |                                ^

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:8a66502c050fd7a385b92f0be904f57ce6ff6149
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  61c312b5c114d6e6f4e6a3c6685f001cfcff5e4a

# Builds where the incident occurred:

## multi_v7_defconfig+netdev+nfs-root-boot+ltp+crypto+ima on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd8fdd99c74e1a997d354c

#kernelci issue maestro:8a66502c050fd7a385b92f0be904f57ce6ff6149

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
