Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006759;
	b=I/mJK73adEwn4Yo45+Waict1p80aoBEyw5B36K4lFKWkbA/P2N9HLEg2hIjnnDvLcmkl
	 0Pd8+MA0KngT2YmGwi/2fvH9mftrax1CkPZ5jjPxx1CmcgJeUMi/gEU1AXurLf0yxAgiy
	 uZaR1XkNir6aug0q4mx6f013yluNzYU/bj9myAey/hL1cEJCi93ilCmw9YfnyH6Yq1vwo
	 vzVhS+g6CzXlp/AUKCpl/7j8nq3iTELKKCcLOSPu4VWin6up/x51jEhvVXOnIncCrF4rF
	 lwXMOBFkCty2TcpcyBYDKyYbQRkTxT/9xxhvwaV0l7FsZHQt0IwwPO0SyOZyoL+Abqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=k6DiRl8j86AfEYiBGOWnX/ztPxjXBRpsNFjMPY1P8Os=;
	b=qUZQeP2+XNTIVj+58fFGnuBAAlFLKXn4h2oT5+9RcC2jjFRZJlu/62WVnsIEe+Hp9l8S
	 H/cc6Tlpf/8W9WmYCjeteKzNyN17BNJixAm8Azoa+hH6BYXOs+DAm/m7Plt1aC/jOAHf8
	 aTXYucXXz/6EQQRQuu/P9qiWuTo8Benoil97HimKEnvX0Vqy9vAj7i8Mvi6Gqn4ZlJbPu
	 g48cWx3MSb47QwvB1xm7e3gmlI0b6GFsyYG+l5Uo7U9zM4jTXaN9EQwAEE8jjPobR6rly
	 WYcC32mAZ1BIqL9iNtTnw9pQXAAbj2ybq/K+3SvcI4ZnRU97G33OCZnkCWscvxaYpdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Kxv2xb4o;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F204606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F204606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Kxv2xb4o
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a3c08d6928so1365844c88.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795006758; x=1795611558; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k6DiRl8j86AfEYiBGOWnX/ztPxjXBRpsNFjMPY1P8Os=;
        b=Kxv2xb4oSa4pIAYdZqZryAyvmoFVSgupEi9cNoLNNOfXQLaFJWuBGDerlP78x531yK
         6Z2HWvLgOd3QHUwr439DgF9UHoTBE3XCH64nfic1GhtlQbfN7hyn0NmU+kva9UcGmZkY
         lr2f+jbCYYRszONbhxeLqoeKRYTYTuX80p/KLcpVTY4SPZZ2kTwfjIjFV9N+N2tgFDa4
         PJmQvOBiEuId1yR4KuyDsh5PGUcMF3y4+LArCHWd35WZSUy+cX/HJUIGpipy9ToeU2cJ
         Rt7fwQHtWdBwdztCFViKeYwqxcSLsbQAUC16yduJkakMq8XKPiRLTlhkdAzskUwb0yqA
         fwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006758; x=1795611558;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k6DiRl8j86AfEYiBGOWnX/ztPxjXBRpsNFjMPY1P8Os=;
        b=mN4B13N3wPNukYnnCB/cJf/aNfo53wjkGNmItQNFLssihTn8k+fZsfU7DPsMP5errR
         fap0FT9C9uOEmDEGhM6eK2g2XO73IpPjxO8CYDcv/i8IGtvFuYCep+kIvLJdCmlKVI3m
         FO+m5eFznz4sbaR0NyEMqEbag3N6yGX1OulYQuq6BDBqZGp8TCqLYaLIn3WURxpLD8Er
         rle1K+imW2XMEvwqGdSox/k1EaFMxNngu6HGt9VQgNglP1r3m794qJSEMfXKyLgdHBOa
         6VbuNR9tcu+oFHCegk6iDaiVS06PL4X/rX3XOyvxb7rvXx/kweg9cI8NJg1Jce1LYeF/
         U4QQ==
X-Gm-Message-State: APuU4Z82KD2mmtTAp5qOu8gvbzFfxh8rMsjRUHUS+qCyrZUQTPr/rdaa
	o3+tRnOjbQqblNWNOsXG7qrATLGuQ5CF5hJ92XXR4gqL2kJnx7/emLhOq1YmY1UFD4mzyhrvJYo
	KnvwX
X-Gm-Gg: AYBFou2tjc8+0kX7c81zfpnMixgeh4D5XflpfivZ9IVuoKEZWFLASLEl60uxg/GFZHB
	+WkmQfrMNtd+Vekk7BPCN3SwmijmkXfUgib4MRtE9B2MCYFch+W7IhMh+GhB/GLSbJHquV145zX
	Z3KALERR0j0MpmeIz9rbyG0FuNc6OVixT1XgQVPQaCecI831H7vzbQZeDQ6kAsmCxMU15LJ+X12
	JKT93lSjAD/l3MvZEyjcwmvKYP/2ypmahhF5t28JV8vxkf0NIEUjdRuYBMg5oVMsAapQI2HWIYQ
	hwWniTYb5qd/iJ34FZVkRatn7TQtZbajLoxHNueCTcoIw7C9v7hrDbGCjYOJ80/lFXy7duNd3YZ
	cveWEtMgIxQa/Q38/4xUz/d1XX0YppAHcEZswAoQ8jAp8uS1TreoRouNXuQCIUS1Y9GtNbvQPFY
	sWuVxrmDx9q0htZjMYh3K9yPrNAxcgS+a1Xg/bUYmEWfDr3mW+Y2TOkWuu2LRGjkHe163UQeESt
	LbRfQXWAH8JWcspomaNKuFunNR+I6mngBjOVoCmpQ6oLCUsQk7pIxMYVrf6OO4iR3/oYTFfrC0+
	OycK6efQLG/S+zplo/JsbA==
X-Received: by 2002:a05:7022:e803:b0:154:fa0b:6df1 with SMTP id a92af1059eb24-1b543d0c869mr2716146c88.37.1795006758161;
        Wed, 18 Nov 2026 04:59:18 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447dc596sm6291383c88.10.2026.11.18.04.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:59:17 -0800 (PST)
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
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjE1Lnk6IChidWlsZClpbXBs?=
 =?utf-8?b?aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhfX3B1ZF90cmFuc19odWdl?=
 =?utf-8?b?X2xvY2vigJk7IGRpZCB5b3UgbS4uLg==?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 12:59:17 -0000
Message-ID: <179500675722.301701.5344310578781109256@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.15.y:

---
implicit declaration of function ‘__pud_trans_huge_lock’; did you mean ‘pud_trans_huge_lock’? [-Wimplicit-function-declaration] in mm/mremap.o (mm/mremap.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/mm/mremap.c:363:19: error: implicit declaration of function ‘__pud_trans_huge_lock’; did you mean ‘pud_trans_huge_lock’? [-Wimplicit-function-declaration]
  363 |         old_ptl = __pud_trans_huge_lock(old_pud, vma);
      |                   ^~~~~~~~~~~~~~~~~~~~~
      |                   pud_trans_huge_lock
/tmp/kci/linux/mm/mremap.c:363:17: error: assignment to ‘spinlock_t *’ {aka ‘struct spinlock *’} from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  363 |         old_ptl = __pud_trans_huge_lock(old_pud, vma);
      |                 ^

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:0132ff83b31b184fe5bdfd5510b8174a0b4a2a25
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  4bb8d342a2c791584ece3d8430e5c03eecf3b3bb

# Builds where the incident occurred:

## allnoconfig+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd9e3f99c74e1a997dc58c

## tinyconfig+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd9e4899c74e1a997dc5c4

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd910699c74e1a997d3797

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd910a99c74e1a997d379a

#kernelci issue maestro:0132ff83b31b184fe5bdfd5510b8174a0b4a2a25

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
