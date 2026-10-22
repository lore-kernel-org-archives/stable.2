Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792636209;
	b=MZnALd/0aZMEtNybqAOlqrXcpxGAarNHcye5tWzVUr6SFhSFjYcBBVL0fzeqfJrWEwcp
	 m1+3qupakm4y83vfWrFCrsdDDvTNMU5AZV/N3W/rV+qPdKU9722x2Y2jYW6KCNsNiT68x
	 weJkTX4rJHgo0/5Mj6YM5j89go/WvUITN07zyvB5iTS2bAHGOHXQk5xFq4fGSUDKlby7Q
	 o5H71EycsFUDdr8z1r2BWbiSdEoWgRrl9i4JA4CrI7k+RA61DFhy3qS/wxOuaUM0tMQnZ
	 cf9P0b9+SxmKko2aNTSlpH2SVT5G36f4iUdhzCdxRADUB8gZt+/fZjCUlMDh6wx8vOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792636209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=R49LZ6at4Pz061fSRdXsVwNiwfWK7H3yc4GVuvrpB0Q=;
	b=Q5IXCdrtBwzmy1s1wdbnBGwqBjT8ShuNIVrQ/aXZyig/9TKkuSRUIbxrJ1m4/WH5ipkb
	 KjWXkhFErhfYvxmvSum6W82V6NTMp8uBj9LTf/52ZYkTjfWDb6SRrcvnwYxDoeUZLsNYB
	 haGYvCZQQl24ilYh7hkNDw3+8EfAxPgnFjdHDiFBYptMdggfiPf/KA1YMCP6NjBWagz55
	 R/5oVpKOOmJCVwGNQnVtNsiGyTdSAOLGjm2CSpJVzwIJFxzVr7dHSZyCq592FdBbWigZy
	 fOvgMSWuNXvl4+lbhqdEUbPVfYGlILLrBWlQUp2qofAeYhD7KAZAnnB9ScAkPBJUIGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=b70DvwBP;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9863606A31E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9863606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=b70DvwBP
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35f036b17easo264909eec.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 19:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1792636208; x=1793241008; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R49LZ6at4Pz061fSRdXsVwNiwfWK7H3yc4GVuvrpB0Q=;
        b=b70DvwBP4USNnHFbI4nv3+LJE26Ga+RdYbiouG2O0acHkaHtdZOd8acrVFLHkLtq5m
         gfrgp6T0xhgja3/yPTVMjpT3Z5MxL6ddu24JK4IooDY+RASRR/CNS64sEFDX2HI2f6pY
         GVrxdnDTwfjHQMoj4Y0xJfheJdxdpwK4pdUMIt4CfC5qpCYUawjipJZIdwD/OrLDMOIy
         82zA7m2kzLsjfdahxhF58q9hfAwwFeTGTK6bTl8f3ofyvegmbmYd2oEZsOfJj+OH1ofD
         8ROo9le4hEopmfNiqKRTOgNVcMcw6/LXqZC1eZNFcRpQW0eLooCCy8JA+Eql10WVZfAd
         LZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792636208; x=1793241008;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R49LZ6at4Pz061fSRdXsVwNiwfWK7H3yc4GVuvrpB0Q=;
        b=OTz7CZomfF0wD9M034iTPGBxVuA4RIhmBfMWv8xcfjnHL8osssxiohYztaN86iQQIq
         3LdxzYUsTYl9gjwbJOIGFE5x8Kr1gjTsnIErbyU2VxjyQVyg5NvUWGx06Bn9tNNcqB5G
         BZB40HDCoSkOE3WltLD54JO3AYBNQCxXNC/rNLpCd+aHOAtpFNj3BcPMyFcqZtVivTeK
         aCruewHLYTZt/lS8K0WqhiTWkKGa4ZrLo2P1Z0XfCwQanMsrMZjOAWwMJ9olkG7JSHoG
         PujMObnj8Xy/rxlqSYbgfkeKedNLAVjn1em7xqWgAO6+WN3x4+0J5dVvEGUMjFg7pD5P
         9WXA==
X-Gm-Message-State: AFq9FYIfmJvugHqYBr117ehtaX/yd5SLiLTYEcy4egEmwEIMjf0JXT0x
	FwCvlZZnCotGUxkso7Eog9WdOD8js9YSYrEe/L3QrDg9mDTB5V7m8hQexoiOxlBehps=
X-Gm-Gg: AYBFou3lDn2sIsKQGWHlNGzLnIgQEdq31gTyMhmp9erXH14rGnvdyOizYACi8uqcrug
	yiQLHQ8e/qJTtX2kBoS91LLjdd70albVEbch/dLSgQPTZ+mZaX8+UYhOnkTxELhDXWCCaGu7zAN
	77cg7+O2FcHlzsQS5gH8iFUID1etNNYgEZt1JpoS/YWzwE+aPTPAota6VpQxtIPngBwBFlx62iX
	ZswoRDExjVVd0ejvH60t/ldVa+pyEtC5f+WxyTKXPHdqH3kZqpURlhKeKSIv2Od7VHOqFCZt3d1
	2eSbIea+6sp5Xzxx6j2Ajc/X90YNYXFIxaZOdkiwmCYp5xlaO1aeCzpqucZTmoB0OP8qzumtHuo
	CRxL6mlyWxt9t5DSDVwvyM1I3VQvqYrnaGkpP0ysyuQKbcIMBhCai9dMSZmfQkgD8YTNsN+m6iS
	7yWVLTuHOxIxEtRS3Gql7Jkuvpj6kBB/JFdeZt2OPUvEDk7tbti5OnoZGt56+Ku5rYGBtd+coe/
	NpjACS31lhRc7Fh9glSpAzmSo4A2PRdmXHXy/oFXflcsq/I
X-Received: by 2002:a05:701b:418a:20b0:14d:cb67:afc4 with SMTP id a92af1059eb24-190a941da11mr5342311c88.41.1792636207208;
        Wed, 21 Oct 2026 19:30:07 -0700 (PDT)
Received: from 6e52bff8000c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a180b9esm15471743c88.4.2026.10.21.19.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:30:06 -0700 (PDT)
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
Subject: [STATUS] stable/linux-6.6.y -
 0aebf2870d53a8d97e02a99e2103ea0b38950c1b
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 22 Oct 2026 02:30:06 -0000
Message-ID: <179263620588.276449.8339300134959706753@6e52bff8000c>



Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/0aebf2870d53a8d97e02a99e2103ea0b38950c1b/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: 0aebf2870d53a8d97e02a99e2103ea0b38950c1b
origin: maestro
test start time: 2026-10-21 09:16:28.927000+00:00

Builds:	   33 ✅    1 ❌    0 ⚠️
Boots: 	   66 ✅    0 ❌    0 ⚠️
Tests: 	 8450 ✅  680 ❌ 1649 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: imx6q-udoo
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - kselftest.alsa.alsa_mixer-test_name_0_10
      last run: https://d.kernelci.org/test/maestro:6ad88ba755fda507605a3456
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ad88b5655fda507605a3279
      history:  > ❌  > ❌  > ❌  > ✅  > ✅  
            
Hardware: imx6q-udoo
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - kselftest.alsa.alsa_mixer-test_name_0_22
      last run: https://d.kernelci.org/test/maestro:6ad88ba755fda507605a34aa
      history:  > ❌  > ✅  
            
      - kselftest.alsa.alsa_mixer-test_name_0_9
      last run: https://d.kernelci.org/test/maestro:6ad88ba755fda507605a344f
      history:  > ❌  > ✅  
            
Hardware: stm32mp157a-dhcor-avenger96
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp.shmctl05
      last run: https://d.kernelci.org/test/maestro:6ad8e15755fda507605e50a2
      history:  > ❌  > ✅  
            
Hardware: sun50i-a64-pine64-plus
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_dirty_log_test
      last run: https://d.kernelci.org/test/maestro:6ad8935d55fda507605abc87
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ad8907d55fda507605aa2e8
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
