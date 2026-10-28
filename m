Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213949;
	b=1xkZFGdJPIcAiMkJSEbh5Y0zmlG9I3CKU37J212tlwNH6uku1wppfJtt2VLzZnJxiHdI
	 iGqweLCVq+WZTGPXloSZ51vp9GpdPnqrp7YheXF5XswjJrnhCs49IUksBNkeS6yYVL6+h
	 3vuTc6CNogKSfkIkTODNZ3LwLfezAJpHw3a/HiNgJ+nqCelnLOrDN9oBnYO4at/fcxG4f
	 t7W7OWiCKi5/uKPssydmWECKGwDrJmYiBVsEJ7o1m5vy9TOKizFVeQrEzIT9qySsbBI1u
	 8d4tltWCASF2rkygYhvrEP+VstEkti70gXCc7bnehqLsUKlKZ2euqCajtdc7IGd1AAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213949;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=ZhQiI6ISi82nrkkkvTbUiuz2A4v8vR4aUaNLgAhsw/M=;
	b=hce/Ab5HIjgNfay8QONvAY90iZEKusgIzrotpFVbdQundGpT2CS+skondKu1GYoLjziY
	 rkZi5xBCBqAlEbCMAa/SmeNE/6avNCS0aXkH3ZGwGe72xXLeSr+oAiG0DkX2CUzq6qX5u
	 Md6nfDkTIywVfZ2UaDGtjVNUSLDgox88ciPVCjyHYfcFChglc+JJq3bQgdBWo4v7+HJIk
	 zKfhukiKQajJW5SZUjVF+PQ63xAa6jEAB9pkmrUgRh7IoXf6AAAfLT31ahDZSRKtk2v7T
	 KUOkwl6He+GemhX6/KadmZEDUlkcqa4cInpM2bUKdwAsGfnkSY+FeF2s1x1Ewn43BJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=BCVDr1bN;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BECB606A323
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BECB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=BCVDr1bN
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-170135e43c7so248380c88.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793213948; x=1793818748; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZhQiI6ISi82nrkkkvTbUiuz2A4v8vR4aUaNLgAhsw/M=;
        b=BCVDr1bNxO31diAHHK3mNbWrE9Z6EGXQYHU/lqvw6SVqFvMvTMEnaFxwY7GOztMjvb
         lwrdYYSVOBiuz0oR+EcUS+1EwHXr0UtPeO+V1SK1H7kAuIozFPaZRRLZCfCvUBZbBO2S
         eBFfU5v36AnaTMUxJ6xzLqv1m6H0CP0VTsFEx/rmfTPe05Cg16e0913uwNfoA8HM2wzc
         4jWB1fagUP1P9ETsOmboGHuQpj8gt8j2+dowsFx6bECWlEu2ZEaWA4QQtuvFvQt+6bjB
         Yaq6BFRenZI4pm/T5cgLANpajkwVXZgMiI22BPVePSuFEeVicpJ2/5penh5QjU/X2QA9
         g8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793213948; x=1793818748;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZhQiI6ISi82nrkkkvTbUiuz2A4v8vR4aUaNLgAhsw/M=;
        b=Kclz0yJnAFNvpDBeIlfRimETxM9lONDIbjPQOQyr4CcjX7Qfzp2j9O7/oe5b/RiAts
         W2XKZgNttz32vTBBD+f7zZL8cYQblpOMZjvocPnxxImosRaFX/Za+zqfrhX8jjyei0ZA
         HGhgb2jCXMb3Sufmin+XUWZlLDsuQbOOgF9L0mx39dBXalDccfjERcV77wg2tLJ5FGRA
         Ebt9kTP5GnLelXGD7EtdOp8qqCi5u7e4XItVkUUGNmf9+YJ1PMQPr/x8omue8WBvP0BY
         aHc0TGjMBrAQLCa0xJQBTrv6xcgj7cY+lRtJSiV1OdapKF8Fkg4QLTbC/0pp8lTue1qk
         vaeQ==
X-Gm-Message-State: AFq9FYJVmu2HgsxT9bfLov7uz2hlEQeTElw9mgptMql1rlg8+POaLp8C
	OpBufwr7+whtQkmpwu8wPQKRT7EYwSAwXJIdndty1HJfwA7Hedah+jFyJOLw9Y5d/YPncxKUtWR
	naDzL
X-Gm-Gg: AYBFou35cWEJxBqTqbiMbxOXdqtLR+BBtcYVzW6PlW1dtcMZ5hwLqvCQoHey2t0w9NO
	pWQqKPBn8XO9DJi3TnzNTAayVrg4Kr9l+/Ub/QsqP1WgTcm72bzGQlHslClzi9d3j2XicI0NOup
	Vk0JtHwWqDSxICzCt1cXV8p5oyukNDi2SqnAp4FqZNhfSbqjy/AymGdIbzfBUQPudm5YBioMUCy
	HGS/fV7VBIyzUnSOJIDUB2vVbzUuLO+dx741n6XORS9T1SnJEN0VogA4WyJJwlGwOdftfi1MYKv
	cK6qjBUWwYuwXsDcEVqXjr8s1/ng2L1rgqSLYq78UZkGyMtCOORjvbA32ovA86cc0yNdSoo/gWh
	Nl36c8nZvk/kINMOvG4beb3pAukLa3ssEJJy+ZDPzcc190+Dv/O+OMrgr2rac6aIXBQJXe8iHAj
	m7NPGgf+e9ZaXPiMEorgqPfRituR6mDbzL8eTfrdlSxqV6I0MVYc+SkEkSgdbl9JgV/7TY2D68d
	lMGL8yZ5/X1/AvHfhl5wyt7oT4BL31wyeX6EurAFt+re/TY5r9hhq99QLAVmAIj4kq1s1wNsQEn
	Wpo5R3EmGjR+kGMa0VUbww==
X-Received: by 2002:a05:7022:289:b0:18d:96e8:b913 with SMTP id a92af1059eb24-1a6cffd2ca3mr3612410c88.47.1793213947858;
        Wed, 28 Oct 2026 11:59:07 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a76056a001sm10800251c88.22.2026.10.28.11.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:59:07 -0700 (PDT)
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
Subject: [REGRESSION] stable-rc/linux-6.1.y:
 (build)/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit decl...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 18:59:07 -0000
Message-ID: <179321394684.45576.5719804702713084928@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration] in init/do_mounts_rd.o (init/do_mounts_rd.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
                 from /tmp/kci/linux/init/do_mounts_rd.c:12:
/tmp/kci/linux/include/linux/highmem.h: In function ‘memcpy_from_folio’:
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^~~~~~~~~~~~~~~~~~
      |                     folio_test_hugetlb
In file included from /tmp/kci/linux/include/linux/bvec.h:10,
                 from /tmp/kci/linux/include/linux/blk_types.h:10,
                 from /tmp/kci/linux/include/linux/writeback.h:13,
                 from /tmp/kci/linux/include/linux/memcontrol.h:22,
                 from /tmp/kci/linux/include/linux/swap.h:9,
                 from /tmp/kci/linux/include/linux/suspend.h:5,
                 from /tmp/kci/linux/init/do_mounts.c:7:
/tmp/kci/linux/include/linux/highmem.h: In function ‘memcpy_from_folio’:
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^~~~~~~~~~~~~~~~~~
      |                     folio_test_hugetlb

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:5f55b9dc3276827314b6c565f6596ed143f04cff
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  cf976d6a55753dce91f48c978098f1ebfafc42ed

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae235a75c0836a8c2f178fd

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae2359d5c0836a8c2f178ec

#kernelci issue maestro:5f55b9dc3276827314b6c565f6596ed143f04cff

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
