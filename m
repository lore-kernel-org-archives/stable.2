Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F90390613
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959755; cv=none; b=RVI2NgXSoXeQ/mqA3FSrVssXZT3InPYR00xWpcX9W5dKS+euQNyQxCMTUUKFZjTeRbZfvctA6rmHnWVqlR/63awuh2JWnUwDJPXng5tmV/yCW/nnomyLurnZ2A7z1nOG+wGcZjVTpJWcUk9c5LcsGA4PgFmxtlgyH+E1oc70hx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959755; c=relaxed/simple;
	bh=CpMaQebAzYeI70xeEljb9o15ZAoc1ekDK+GkpHHfD+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I5ZDabIZab9A/IJP5z7jdeQ58BYlul9eo2lE81fA7z9l00YF4DavgjcOIScfxnIbHcfq3xC1n5r4qBUFW6S7nFg2mKSmjRZMEmsobKnjJ2k1yD8ycl3/PcB5rZCztkd6LM8VCDnX6+YHGBrfVkn7JTmicd/fCG3Z2qpsOrXCgBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Ry3jVK/+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Ry3jVK/+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc891373e0so13057295ad.2
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 16:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1787959753; x=1788564553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yr2zBj7nYXXRW9RKYDy2oJYD0P54gbEL/sVS3zkkhtg=;
        b=Ry3jVK/+XGQ/JmErroCRrGFzQDhAgMeDdHj4uMbMieHiJonOHr2gH67w5/wOSBYZzW
         PL2Tso7BMwbh01tY2HHzJSiKDeqb0ydkOkTmXzrY/4Enk+TK/26vu8fy0o/j1PkiMwVa
         VJ66cD1UoQlWmRlDZe2lyubgfuVaearLadal2vF6FwWtZNlGzOjvw5PqqCXQV/vHCZoT
         FiLroWdTSDc5BKoKS7493feu+pQpnDUAYFrOqoLMQRcyvGXmcfG4CsJT+16j9RuRNPSR
         Y6d/7fVtkJBTN6A+oGBVBFbiP/tvz13rM8b6JtBHahx9PqLeWMFqOwsFHGoD7TU3eEQ8
         G2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787959753; x=1788564553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yr2zBj7nYXXRW9RKYDy2oJYD0P54gbEL/sVS3zkkhtg=;
        b=LYQQoRC3eEij/QCbmgGzLO3ZlXz8CbKwSjvNIB59/5WvoikKdwluiITANBDMSqa23e
         1CpdrLAIuuChACd0gabrPddPXLvlgrYifi4IMWQtt8taIgxssYvmPYlrK4QMK2Iwjm0v
         t9ESZmOP/Ews/oE4djvOdC4JAsFmNcgBFCQubcElULBgjLtZz//2fEXgYNwbL4xzOE4n
         AK1mzdrxhaz4xGJ79OBjIsv7Au+LjMchUwLR19ka40wXJ6b7v86Iv1znI/5hvP2wI58p
         DBqRXnYkKNyUTDw82y+iZT24zBGpNi9evncZaAXGA3SxeLpt0t7CyGuqaJW+miYCIGWm
         Ltag==
X-Gm-Message-State: AFuF++knWAA4W9TwGsOx4cgjTL7ZKlzAIZQv2ot+9p7+pHsBBAlmceY9
	5DP2vlCZC8t4RqAVKerqB3qw8QN2aMnIiYwATgRqyk0CKK/r+xF5DVF9k+o+YYEkyoHYpQBZq92
	QIEH4
X-Gm-Gg: AYBFou0gfPzbplhvgXr0YZeSe0orKYE9b9xiGKgsHDvYiutBh4s0rnPl4pgizPpdHn2
	mxxEo2r9DHt5dV7v/L7F2PXQ90EgN7xbDn1VFhhPPK9E62c8hq7DpyfaCjw9bQZqc9pWsjAW+cT
	y4nRQERZ/rvNdM1aGkn5pltvZsRbWkjflmPLs9swne4JjtbMSIFUTvThtHtexePv7mEZShAZ+7E
	H79uwtI1L8TxemwUIpeKu+YgxFbw8uIAiwTEd66+adsrBMVFkRH95LOxvoQ3LOAbZ8xY+/kfZ3C
	/9tTywWevDp/ZpHTFeQ+QYEENGTe7QrBkIkM1cZqKYPyxWhKGD86wqoOj1s+56Klq7Eupa5Dqfu
	l7WKlBNxrp5uZe5Q8BP5niitUxMppf1YHiKqAQcvTEoy9X+GEfZ4vqeVmyfceZsQ7aoOl7ZBzxX
	FKb73CzywmjKiQfuyTaHDB6uxquQQJURpdmaVKD3LWolQ0zwKBucyADzz7kkoaDh1DGS6qyxxl2
	G5CDIKPFqKl1peiwTWK4hqvgjcz/imxEmqH49G+TqI0w1wmP6/2PfW9Hg8SZw==
X-Received: by 2002:a17:903:1a27:b0:2d8:d4d3:3fbb with SMTP id d9443c01a7336-2d8d4d34074mr49394955ad.15.1787959753207;
        Fri, 28 Aug 2026 16:29:13 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:4969:94c8:87bc:d69d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f784845sm10453543eec.2.2026.08.28.16.29.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Aug 2026 16:29:12 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Please consider these upstream CVE fixes for 6.1.y
Date: Fri, 28 Aug 2026 19:29:04 -0400
Message-ID: <20260828232904.91398-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg and Sasha,

The fixes below are in mainline but still missing from 6.1.y. The Linux CNA
records list v6.1.185 as affected by each CVE.

I cherry-picked this exact set, without changes, onto v6.1.185. The x86_64
allmodconfig kernel and modules built with CONFIG_WERROR=y. It emitted four
pre-existing objtool warnings in Xen and interrupt-mitigation code. None of
these commits touches those paths. I also got warning-free targeted builds
for arm64 KVM and Exynos4 media, PowerPC ibmvnic, and the RISC-V
compatibility-register path using their related config options. I did not
runtime-test these fixes.

Could you please queue these commits for 6.1.y?

  ce282d8de71f07f0056ea319541141152c65f552 (CVE-2023-54141)
    wifi: ath11k: Add missing hw_ops->get_ring_selector() for IPQ5018
  ea293f823a8805735d9e00124df81a8f448ed1ae (CVE-2023-54263)
    drm/nouveau/kms/nv50-: init hpd_irq_lock for PIOR DP
  c13fda93aca118b8e5cd202e339046728ee7dddb (CVE-2024-46754)
    bpf: Remove tst_run from lwt_seg6local_prog_ops.
  b5799dd77054c1ec49b0088b006c9908e256843b (CVE-2024-58094)
    jfs: add check read-only before truncation in jfs_truncate_nolock()
  0176e69743ecc02961f2ae1ea42439cd2bf9ed58 (CVE-2024-58095)
    jfs: add check read-only before txBeginAnon() call
  d93a6caab5d7d9b5ce034d75b1e1e993338e3852 (CVE-2025-22104)
    ibmvnic: Use kernel helpers for hex dumps
  a4685408ff6c3e2af366ad9a7274f45ff3f394ee (CVE-2025-38203)
    jfs: Fix null-ptr-deref in jfs_ioc_trim
  1f3d9724e16d62c7d42c67d6613b8512f2887c22 (CVE-2025-38206)
    exfat: fix double free in delayed_free
  bd9f6ce7d512fa21249415c16af801a4ed5d97b6 (CVE-2025-38237)
    media: platform: exynos4-is: Add hardware sync wait to fimc_is_hw_change_mode()
  97766512a9951b9fd6fc97f1b93211642bb0b220 (CVE-2025-39833)
    mISDN: hfcpci: Fix warning when deleting uninitialized timer
  7fcbe5b2c6a4b5407bf2241fdb71e0a390f6ab9a (CVE-2025-39925)
    can: j1939: implement NETDEV_UNREGISTER notification handler
  3d3466878afd8d43ec0ca2facfbc7f03e40d0f79 (CVE-2025-40064)
    smc: Fix use-after-free in __pnet_find_base_ndev().
  0aa1b76fe1429629215a7c79820e4b96233ac4a3 (CVE-2025-40102)
    KVM: arm64: Prevent access to vCPU events before init
  935d783e5de9b64587f3adb25641dd8385e64ddb (CVE-2025-40139)
    smc: Use __sk_dst_get() and dst_dev_rcu() in in smc_clc_prfx_set().
  235f81045c008169cc4e1955b4a64e118eebe61b (CVE-2025-40168)
    smc: Use __sk_dst_get() and dst_dev_rcu() in smc_clc_prfx_match().
  dbd3fd05cddfdeec1e49b0a66269881c09eebd17 (CVE-2026-45963)
    ASoC: nau8821: Cancel delayed work on component remove
  a0c584fc18056709c8e047a82a6045d6c209f4ce (CVE-2026-53089)
    bpf: Fix use-after-free in offloaded map/prog info fill
  6ebcbb53fc9bc30843054ed99fd60b8e542628f4 (CVE-2026-64082)
    riscv: Fix register corruption from uninitialized cregs on error

I used Codex to compare the histories and run the builds. I checked the
final list against vulns.git and the branch history.

Assisted-by: Codex:GPT-5.6

Thanks,
Artem Dinaburg
Trail of Bits
