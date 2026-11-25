Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618765;
	b=ULEz9Iz2gR9tpwLhvM0i9aC7NuLe6w2aR7h1L4GJKAVmeCnx+a3zHI3Ck2daj1t9RPxR
	 eDjkmxDatTstqXmwS09a8gzk23VssRBERJYU7VnOIMsgZpFMBLxly0/5vdIv9RQh2ewRU
	 6zhwaL5PSaU/GmWptXlXQgNhUgyBmiPGxhWLthZXaxsxE2/8i5cMkWdsJiyxAiydbLwzO
	 g7I+v/U7+Enxc95ZYA8exPUbTcOUAIdTF3WQ9QHVok4n/DDto7+PgZI8GxM2gC4C0XFH5
	 gxOuCNeSJeWNs2qyK4A87+IdZ0PDlFGrH7hSQlGrN2YvYEHlhO2n6VL6F8a5TUdTkRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=/0yh464ng8srGrg/lUEZN7EHFsSWdLFFB4DglyIaZPw=;
	b=gktwDPuJ31sziCM3tKq8rEySM9BBBwk/1HSb69YPoYAqEdVgtpbSpOFz42tRgjzN4TuQ
	 cgrgSJ5FDl8zmW0O4g7pQAM/GGluBoQaRNYlOKETshv66jc4eNuekKlk6s0eqxn7t0KRD
	 HFAGQnVuvczKOaB0OKorEtESySk0XaklKOJDMpwK+1PWj3rmST7eXa2qkzEtHz9s3Fvqg
	 tuap72sYqqjgymLgLHKhlkTMC6bSgIAlEBUjA4eKgt3Ejz+HVWSQAi350UVz2HuXHM4An
	 X5ONlRsHBH/Jlr9/4mPHzzZGg+EihQPvMWoQ18Hvlpc+2SuEDWXl76H6qdBZ1avCJ5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=N3B9dFuS;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1BC606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E1BC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=N3B9dFuS
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso7779425c88.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618764; x=1796223564; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/0yh464ng8srGrg/lUEZN7EHFsSWdLFFB4DglyIaZPw=;
        b=N3B9dFuS2m2P6ysntOZ+HQA5VVv0rPUlfb2lAAv3kRqDWK8qzzS54S4CrVqREHM7PI
         TYzBAW0UeQ+hzvLiwQj7bUfyqmvzmNgvZzfr/sgbtiJG631zHDT5Rpl9G5Zw//W0PSAp
         SDNiMKtzEYONkx92mCkAEcKbVibqZ6G9MKwcibRggmWbTouEmVG/g8DB9DRFrvDGN1Ev
         VeoA2VyWdqwhV0L3UPtyGfYsLkQBQ7t4MY0Zjb5T+PR9RXVc+pKJrjd3vhsTvT1WPv4G
         f3ocSB3ZfMa6M+fs67+FSpBB2fFT4xuOr3lKhkn0xgf/azQgv9HcnQkB/ixFsUdPEXww
         wjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618764; x=1796223564;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/0yh464ng8srGrg/lUEZN7EHFsSWdLFFB4DglyIaZPw=;
        b=a0ToaA0y2h58gZ+X5Oqy9fZaDjISVgsZSpYcaE/BXDRvxkrxRoLKa4LP5Dy6zJpFVC
         QO/O9aw68X1gbE4FPME2k2TqxbX9iG00HjTXrW+sVmC9coNi+ATzAVzGkgSv+prc/0+B
         qn7S+cVQUBy4L/e04dSTxWGBn3xQIjlPw355l1ZYk2i7sSjVUyE+6nuKSAJNEmU6Tc+I
         CJhZtoXMVnnpVe/uCdFJSkvpVCPN1SVH7zZ8DgeXwRK4Xn3thm5xhnl6aJm8rOT1wnGg
         d4xdxMFQ/7/z6xgdD5GdHXSP8SD8xFeWpCSmZbZPdkwusrZmM/PS2bgJmlPGQjs3HHc6
         px5A==
X-Gm-Message-State: APuU4Z/pKKGasRIbV5krVHYFxUsHVT8Y71JUyqPlglRoxUunzyUcBIwe
	zE/dMEshwranKaKqOgKKkbJeewcLl7tKE9yd+0qN9VzESRn3tpJlT6p2dNpSr8mZXL8zxdUcDJY
	+T0k+
X-Gm-Gg: AZFdTZdIbu57GOfaQKRIRsbYoxl/WhLlpaWOBA7abF+hgMr9VuK+nNgWl/KjZm9Gy5D
	2fYvPtn30PKaiKFe73isvy46jUpG0EGp2B+8kC2zzUedxY6Pj3HSyG/0SuGFmUfmaCqkZsxFJfV
	KZwH9CazpFNA/3RtM5wFaQ0gpylfQSjLSIFRLgbf+cfrrgcEowrpQVKs2bmWQNEPeo0xjWHEZ+y
	bywp0VVSYMp4SA6cuJ4heZfByLuAbDzqaWloti2vuGWo/UHHh5BOp1+cTRmtXyYUVTUxvLyrE75
	te7Bs6I+HLpg3JpxA3iI2pZf3sV1CRB9Uv6UwJT9yRXNwAYR4nVJ5jtLunDu4H1Ic9Xa2yDRSbJ
	ksJl0efY7fSD47ibr62tHRSobrs84yHhm94O6BPflZeMV/KboHPSiNkZ2yTdma+K5raz8GlKPPk
	qF3tLxjxB5hVV93vAySwysT1Ljx7tfP55doxEodquUKV5WrSE3mmugjO2I+/20qe7zpoEJed4QJ
	uZrWiF5ckuOlh9Etta7JC4KdlEgmOZwvEYFON3+eeracc/55XIix52C3eUhXyRwwpG/m0Dutfmg
	UJQkCVH0u2Xyi0Y3/BsRrw==
X-Received: by 2002:a05:7022:ea8a:b0:149:49c:233 with SMTP id a92af1059eb24-1b5568bd774mr16217818c88.27.1795618764060;
        Wed, 25 Nov 2026 06:59:24 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55682d301sm43722223c88.10.2026.11.25.06.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:23 -0800 (PST)
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
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E15=2Ey=3A_=28build=29implicit?=
 =?utf-8?q?_declaration_of_function_=E2=80=98init=5Fflush=5Ffput=E2=80=99_?=
 =?utf-8?q?=5B-Wimplicit-func=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:23 -0000
Message-ID: <179561876319.101431.2553020983322933006@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.15.y:

---
implicit declaration of function ‘init_flush_fput’ [-Wimplicit-function-declaration] in init/do_mounts_rd.o (init/do_mounts_rd.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
init/do_mounts_rd.c:277:9: error: implicit declaration of function ‘init_flush_fput’ [-Wimplicit-function-declaration]
  277 |         init_flush_fput();
      |         ^~~~~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:2ec7f95b047127b9345e8aa6c45946115752003e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  dff336abbc2b3923b31da85cfe6cd094c4bc0d48

# Builds where the incident occurred:

## 32r2el_defconfig on (mips):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-mips-32r2el_defconfig-6b06f110286e1965ecb392ab/.config
- dashboard: https://d.kernelci.org/build/maestro:6b06f110286e1965ecb392ab

## defconfig on (loongarch):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f10b286e1965ecb392a8

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f121286e1965ecb393a4

## defconfig+netdev+nfs-root-boot+ltp+crypto+ima on (arm64):
- compiler: gcc-15
- config: https://files.kernelci.org/kbuild-gcc-15-arm64-nfsboot-ltp-6b06f0e5286e1965ecb3926d/.config
- dashboard: https://d.kernelci.org/build/maestro:6b06f0e5286e1965ecb3926d

## imx_v6_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06ef36286e1965ecb35fb2

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f001286e1965ecb3640e

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f0a9286e1965ecb39135

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f0b5286e1965ecb3914b

## multi_v7_defconfig+netdev+nfs-root-boot+ltp+crypto+ima on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f0ad286e1965ecb3913c

## ppc64le_defconfig on (powerpc):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f04c286e1965ecb36556

#kernelci issue maestro:2ec7f95b047127b9345e8aa6c45946115752003e

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
