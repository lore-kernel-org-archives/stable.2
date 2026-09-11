Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F4A2EEE85
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138757; cv=none; b=XPnG7CmsIqHCggBmhwpgirjpcHhQA5KXY+HmY1YTmXYN843fbP49mvjcrv2Za5aGWxVseNzn3b5vOAccsUTZcs1WLjXzxSQ4seMcy/ltfh2xjSSnYhKEv4tDvFxGLCF4I28kvbzXdDQbugzrYze3l+WY2j1sRpbbQfj0AjtIhzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138757; c=relaxed/simple;
	bh=lFCGPV/JxQTu+IeqBObm8eNJwm0qcSm50e7jjVlNFl0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=oBYW28UNbIZCqM796+w605XzX8jikaotzuzchLG+vKSwLQO/5gHwu067tQ8YgFaBcFDgpLG6SY7/FfKlnsnPAwfYmvIK1VSzXghDfG9/x+26qCM69+TJ7Or2mDwnAIbIS3FVsW+NhsMiHdchYtWqBktv4/QooWghD0A4/TSg02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=blLpYvIS; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="blLpYvIS"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4b62d118aso1118638a12.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138751; x=1789743551; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YYFZrCbe71BwiYk22zfBRPfKaKhc8HKnYiTG0uIh7Jc=;
        b=blLpYvISVXkjnKfQrF/Xkdgn6TOgNy3QQFRqEb2dz/VC3l60pPw8F7oQ7YhHs+VhKY
         ns7XELW66JpzUkqWnMk6bQfbQtWwXPQGJTInptSRGU9tRQ8Y2Y8BuhJUnrRmNnRzImRs
         clm4vfGQ6G13OErJj0Dxs0D102EtXw6h9nMuohwbPYHb+IVryGxJIitQ/8wDefGL4RjI
         9xAFzMdXFc0newh0MKUcWd6PHiUmaVf+Fyz/G+3gNjFwnSj8MZ/H1OIkQ9kecaYMxAej
         1mWxeaRxs1pL5tjJGtDjo1OrwlZRSgWfbjhC5Pj2kuCFzz2q0wTq+Zuk5Z4aecaLCBdb
         Z3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138751; x=1789743551;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YYFZrCbe71BwiYk22zfBRPfKaKhc8HKnYiTG0uIh7Jc=;
        b=ZdoU6LZLQfSWyWd2YAwrvFWRxslCwD2js6jQ2vXiZsvbaZ/SfA7NgyopmisPVuS3z+
         MuEfTozdir8OC0LpU9iEd7C5/7ah9/0GxBWbc9owmXPn+ApeouEQHYVkTksBymnZYoo+
         N0tuFWTczK1Qr+au+07OLsvB5BiZZ4OAQRnI/TBByAhdqMdVN3UhebDyjAbRouG4ckYh
         03gBgcTVxN8IXWw/URdtNACnw4OtJ4LPL0GTeNMtnoAqAqzPDSgXmfGHeXw25RdgvV8i
         yeN59IptNGvKHuMYtOfBND8KYch5QkDPYvq3nhnBTqhHEr/v5akTmSziOiEmZI2/75nF
         USBg==
X-Gm-Message-State: AFuF++lHqfKrebJ41SbF6LXekctBNcfJzuXX45oJYXmai3wWSAZl3hkP
	GVyktZ+2U6zV4rylMzqNw8hmY9pz3kdVCAvzlfGHo56KuVI+jLYSMOdneM4Hc1kD6tDMxxdO17e
	esvGo
X-Gm-Gg: AYBFou2JT0o0N0lTFi7EDeP6ENpesluvJgdHRfpqVHpcjpCvJNk3UrBbG58H3Vsqg5j
	FRnobLORN/lOR5/Cp3SR3RJsY+7wkho6jENvgeSTNC0Cbmv8czVKsBp+f8M4S7ldbaT5HIL3Q3B
	xS6qGgQiYK1kc9PjWdsTdrahdE/MnodCtclwcHIeS3cU8yboEGpMGjQ8smiCt+nygAQBacqB9Mt
	dpc9NjnzxfVBOW/CAP5pV/OseUyRA6hSxVgfzS3j8DWXnCESSbcTe7wN7Zl1WlMIwfI47jNmaBb
	r9UFKx3Lzw9UmztUOIiplzDqWztLxvFNoTDjYHMnkmJ2RgY1/wLihWq9ugj9pN+cFV1mXV5rn7W
	OYhrUytMlVriNnBlY4w7HnPZj4ltxZSFysRLGQcxBp52j1/NZJjxJxYGRP1bkWRMQ5gntSZlMe4
	aUSaO2Y0RWmfxE7Ul7QhrI+JlhApfJIlVdQf3t/25ZS2UTMRBnwkUk9pXE0wPPDTc=
X-Received: by 2002:a05:6300:648f:b0:3d2:2afa:d7d with SMTP id adf61e73a8af0-3daed342ef1mr8975215637.18.1789138751492;
        Fri, 11 Sep 2026 07:59:11 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f82c69sm7760984eec.27.2026.09.11.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)Error in vmlinux
 (x86_64-linux-gnu-ld) [logspec:kbuild,kbuild.compi...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:11 -0000
Message-ID: <178913875079.4387.187425206151969537@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
Error in vmlinux (x86_64-linux-gnu-ld) [logspec:kbuild,kbuild.compiler]
---

Log excerpt:
=====================================================

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:2e0b641ba99dbd9e9b1fc0c43c36dc2990465f58
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c33bbcf64a1d0e2170b7cdee977e2c00e258a70f

# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40ccb20239ade9022a9c7

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40c9920239ade9022a6e9

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40c9e20239ade9022a6f5

#kernelci issue maestro:2e0b641ba99dbd9e9b1fc0c43c36dc2990465f58

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
