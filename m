Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC53AAF71
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347956; cv=none; b=nHn4zuUs4J+LXNI2Nxx5WlgYFvc5d0fWYRG09UKl4fTIziCM4dRionjZDVG/LS44jqa6+iKNNUuw49r5AHH6W2F9Ti1ool2zqq6BvaEd9XEPvMnDoSsg8Dcru822vWCq1OxuAvi4RJNutMnQDu3ayhTpeCa/2X1/LyHTrFdiJBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347956; c=relaxed/simple;
	bh=ah8zjFjlzTWr6ZQVnCorSlLLv+jNOByigCDcrp/qcpg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=OSSIke6bV1Dk9UufxXYNQYyn/pdan96uCJ/BdR0wEEOx2iB2hGfLHxsBe7BKDPtdEyrZDMehZrryvJam/Meu6qFYWq1vCA8D0P4Jo32s78yHC+YF1UVdSDfI68IHgO/iIidGbq3PTLOIbRRcfoqk8dV53CXrdyzU3z7c6TJJdl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=g+h4/oAf; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="g+h4/oAf"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so1005410a12.2
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1785347947; x=1785952747; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OnfSRs85UOzLbXxwaNLm78cWfOYp+hY65Q4qTphn+PQ=;
        b=g+h4/oAf9GT8Iagk+scf6WEZcmAkqRd7X9nlDuqw/beShzB6gr++LmZ8t8P3HCJ6WS
         VnhCZXT6AU0FDi59gYK9hTbOnJJ52Fs8krqEnBDbQXnTFANDDAWcPrx/ceGry6ORx+Mm
         cRbYVF+UiAnZyAbbB+YxNgDquDgke6m6IhQPmGP+RHHHDQUa5oi/ydK/sRDWEuhF0pXl
         4eBrzUb9hoQsbqdZamvRD7/rtoRhJdPbUt/9H2ddvZcwhuUlh5xBgrtxq31I4fWE4wo7
         sCuGdxKm7LX3VLR9VGP2lnMvM/2Qqo33MBJ45P4amCmSemNg71TaL2mq8BA8oxrFWX2S
         giIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785347947; x=1785952747;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OnfSRs85UOzLbXxwaNLm78cWfOYp+hY65Q4qTphn+PQ=;
        b=rrNpn0Vw5ChfkIHS71TMGfVU6LvizP8ARpU3Wpiq10cLAiBR03h5MvaAHzhG45SCAG
         Lx6VKFZtnYsPlkGNCWOW4pvxulE4sXlIdVV7OLxIQDUNcrCZlflK88IdvAR3Gq28zJKh
         Ial7o6Bn5OIG2oLtIntLnR0JNCy+VQe/5RVh+5JpnhM2+GHUfkmZrNqfhBLA1lk6wNhz
         oSTwdSDNxLvqjXflLXOuOyq1qdN52hFwSu7GOHJP3ogT0KvqPyt2dkymGvK6v9iRsu14
         vOYIdCQqPsHSQ7pWzA0DW0IPZr4CMzerEOflVkzFlI8Y3eL8Z4GRxd6Tx5MM+iyK0Ycl
         461g==
X-Gm-Message-State: AOJu0YxwqbMHqkHT1Bg8099eiCQTI6ygb8N1R54hNkb8Iz4pPzjWriUC
	TxVpbsYwiTzc89svmVrV/TkFU6nwrXtyA9u/wI3EB0bJ7OxmSqdO7ITnyPxwzoMGdoQ=
X-Gm-Gg: AR+sD11M7C4Y0252uiaMTwnSXSmwPUsR5MUO4c22CWqag8x4bgExcdfKN9rKMUmJFP0
	dy/0VLdXrsOlhemCCXuENW1ab5pbOHQKGHv+vZ30XxE2G9JDDTuylQYaQFBlGocUemsGxWPvWcj
	BZcVwGjlPjf7LX/mJFhA0DNxPl9V6EYDPRy6ScN13qVIBSJb1jWrMH0vlbCrzGsOkIcxfsLVHGv
	vAQHiqD70MpL5j5c+O/t0VDTUTUqyz0XbPJt/kMyPdIrj2AonNWK7yBDXsvrI1P2dZNI38iuZxA
	aujqtAfi7P3PMd29MVzw3gLY0qD3ZxOXfqqGr9XqJqWvmIDvWj9rvVamNw0qHFBPy9NdnrLfpIk
	Ena7QQOo2ey93viY9hhyc5w0/ODlDUBDuGtp/5mHpHvntNc8tKUqzjL5gmRiEuApvqTpNcxME64
	l1cIt6+//fM1Ez75X5aXjTUeGd7y/jFRyX3Tx1BIazoJexhboMt8vmOw==
X-Received: by 2002:a05:6a20:cf90:b0:3c3:cc3e:a9 with SMTP id adf61e73a8af0-3c8aaf29579mr9369930637.4.1785347947488;
        Wed, 29 Jul 2026 10:59:07 -0700 (PDT)
Received: from 92650adf53de ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d37368sm22224927eec.22.2026.07.29.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEueTogKGJ1aWxkKSBpbXBs?=
 =?utf-8?b?aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhremFsbG9jX29iauKAmTsg?=
 =?utf-8?b?ZGlkIHlvdSBtZWFuIOKAmGt6YWwuLi4=?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 29 Jul 2026 17:59:06 -0000
Message-ID: <178534794644.3623.4260630481614627439@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
 implicit declaration of function ‘kzalloc_obj’; did you mean ‘kzalloc_node’? [-Wimplicit-function-declaration] in drivers/firmware/stratix10-svc.o (drivers/firmware/stratix10-svc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/firmware/stratix10-svc.c:1068:16: error: implicit declaration of function ‘kzalloc_obj’; did you mean ‘kzalloc_node’? [-Wimplicit-function-declaration]
 1068 |         pmem = kzalloc_obj(*pmem);
      |                ^~~~~~~~~~~
      |                kzalloc_node
/tmp/kci/linux/drivers/firmware/stratix10-svc.c:1068:14: error: assignment to ‘struct stratix10_svc_data_mem *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
 1068 |         pmem = kzalloc_obj(*pmem);
      |              ^

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:191156f96b70d98f8fb3dd6ee6aa681ebd3dbe40
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  fabe22c975a2fb71a936f5d1961fd4b0583dc498

# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a6a32b9798ea6c1ef87ae01

## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
- compiler: gcc-15
- config: https://files.kernelci.org/kbuild-gcc-15-arm64-nfsboot-6a6a32b0798ea6c1ef87adf0/.config
- dashboard: https://d.kernelci.org/build/maestro:6a6a32b0798ea6c1ef87adf0

#kernelci issue maestro:191156f96b70d98f8fb3dd6ee6aa681ebd3dbe40

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
