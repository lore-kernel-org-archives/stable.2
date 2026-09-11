Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511CE489FC1
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142354; cv=none; b=F8kggnGw5jVzuxwK+rTxj0QQRjCGmfrO6DQglIxnLx68LF4iGPN6pW0uYBIfVIhsbC1UIDEo4vwG4sc62OSTkV6joHysbeTT3/MdYdOcxZygHwO/mmUkOqkTFBob4VZ3D2npAp5MoHNeAU/VWs1PPIcBD6tYTIe3kVI/ZFkfjxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142354; c=relaxed/simple;
	bh=2BPzO3eKmAShQpdTMInD/nhiBAcNu4NO4hfbXOewcA0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Kk27j3yx6Zw/OsFx4HdwvwBKUHU4A469mHRPmVgt4ZvisViphH44L2xqoyfsOJNcadguBSpMI+C0kPzNkcoc5yTVlEnVXJPxYQ22bPtvQq7QS9Fpjx/lzN1g/jfeP7Nmk8enG7BLQajR6paTJhaaPCSMxwKH94BY0sGmRyb6tfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=VBkz4nRG; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="VBkz4nRG"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so1144160a91.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789142352; x=1789747152; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J2+a5Is2u0V0xZRMwGquNKWsXK3yUeGnqhPrApXDujo=;
        b=VBkz4nRGrUHVdMdBGLDW25Bu++UCqKdUI5KplgGXYwFHgMxD7A5SYVSdKnkyTTT8yk
         h9D5lvFGoLqlvovAkfcFfqKvegvxtjwPU5Nff1vkPHIP9Vrnfes7gxsgecW0OsMty9m9
         MByk6J+CiiXUWqgdveWQIl5NoG9PwlCoEA3DW1o2l5VcNjUxlM6VQ2g8k2A1zzfXZC9a
         h6YOP03rWV74FjRXcqpxKPRCm8MLAVbKPWQuX25HFUVepSBnOKqb227/lLCljNaCEt4O
         QEOSdEVrou+7EgFcAqu8zn+59QMopIK5Xrywa7sEEwp8YjMfZa/ehPBkdjeIFv0GRm68
         xRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142352; x=1789747152;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J2+a5Is2u0V0xZRMwGquNKWsXK3yUeGnqhPrApXDujo=;
        b=jdqvgvGhe+g8zOgofEb2E0tmhmgpWphE+tqq1ia6vZD3Mz6NWjy3O7lO4o3i5vMGks
         sMUav4iDuWODGZdPTncI4beq7qHmi2TEJZYZ/nOA0zp7rfUAxJrcP5XRZIQjKe/CyApO
         awT2cpqvTq2qAf2IZzBLi18OGSkeOWMw8OYhDSX3zazX8B1lieg5BUhntQdmK723Hp1+
         +DDHIRwWSm7uzRdZfLL6jQyj9gRbqDiHEruuWxiYHXynoPnAcYwPR60lOXSHmOUHxZef
         2DVSqxOecorjLX5Nsa5+gZlO37K801z6V8nSZvZnsXrUdxqXokEaJHcCuowEDDqecvLa
         YJdA==
X-Gm-Message-State: AFuF++koAMUpEEGW+cgA1s5zkCgzLTrlOPfFwCYxM6BEe+F+vC31k8/H
	4W8D7e/UXJHtZETsj2tWJKyD7BP9PbnrJY08uqexbfvtRLr77izzHh3hsMIoQ7WrNayzfREwIHN
	lcU8B
X-Gm-Gg: AYBFou1rRLCAoaFh0IiFGfY3x0etiDiOE/Zjtef6KfWkui3H7NDaoOXFezodFt4zXyU
	e5GVHnuHTQiPk3LSeID7mtePeSWWGW4MhSCDx/MDGGenNNo3wkfDOu9eQSDF+OVrMRul/ozVLpk
	o5C+ENwVYAPtzxJ9Ex6ZLDWCTIyKsIbb9dPpSIInoAL2VTOqfFejExlS7J7DS9sjXYqdV2pJZ+P
	7z9UTT2/m5hEUI4vKG+exMpbsFuAdFRv/KfMLMSu6QwWfCr3zDXZdJXpIH0M8dICAz+h3iqCP14
	X2OYdv4Lkirfoslho0AnK1kQYT/JeiQIzCimrEI9KJdf/9WK3NkAryaAao2SqmFS3SqpWIowwYI
	naeMoXNUNMYit9mD0SL8Xp94q/3rgQ0w4tGZZ174C0QOhX2Y+Tdm5JT94CGks7CINI9hyb4jap7
	ojCDAG3O8QVutu0VzW6nU3lU4m2U80kmK1bmzjbAbZIloDr49g3HIWNK5d2GMl2BQ=
X-Received: by 2002:a17:90b:2ec4:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-39d9c0b705fmr8484864a91.16.1789142352280;
        Fri, 11 Sep 2026 08:59:12 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f7390csm7546053eec.26.2026.09.11.08.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:59:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)use of undeclared
 identifier
 'knav_qdev' in drivers/soc/ti/knav_qms...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 15:59:11 -0000
Message-ID: <178914235111.4405.18224797289647362064@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
use of undeclared identifier 'knav_qdev' in drivers/soc/ti/knav_qmss_queue.o (drivers/soc/ti/knav_qmss_queue.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/soc/ti/knav_qmss_queue.c:1872:2: error: use of undeclared identifier 'knav_qdev'
 1872 |         knav_qdev->debugfs_file =
      |         ^~~~~~~~~
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:2da8f4fa5c96cb29e6efa744452d0bef95cff1a4
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  5c8ffa565d893e8b4673b365aebbb2e759d50942

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40a1e20239ade9022937d

#kernelci issue maestro:2da8f4fa5c96cb29e6efa744452d0bef95cff1a4

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
