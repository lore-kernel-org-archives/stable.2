Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E195374E60
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977205; cv=none; b=QXbaLTW1/wWemJP3Xp8kP8PAxSEzZNDrhsLvjqRDDiWftGXhDCV0Aq7WEt5Qmcn1gxUhrETfFuO/7nhL3ZhrQuoJzeLRRIEg7vQmy7eohV9/7KrLV1s/FWYrHOdXj/ATNPOqpKNB68a4vv0RAbmc/blFEKNRt9kZxYiBXB1v76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977205; c=relaxed/simple;
	bh=r4gZUtyvZzMOhoB5vuxMcQI4v3r6AHya2cvGyGm4VCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JeTm4FFkHyRodXGElxcTvwhEvxFyeCqKX0cU1oMmZI/8JAlIU8Q8LMbj+shJ3k/lF5fPEhsZoLRjoCmwQCs1YboxeNSrtuM3jEW9XWbPWwcaErMT4HiLJ/5m6++ziRIFIAHlthIACcQ8O5Sw1un3YsaVFxxUGnt4RUSyWdq26dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=KKJ34y2b; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="KKJ34y2b"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc891373e0so65605395ad.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 11:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1788977203; x=1789582003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uZ5O85glUaXg9j3f8hCF0He+cOFGseFZ3HgdLBGxWfc=;
        b=KKJ34y2be3G38Z6MZu2w/6J1h4cw7nU7BSXcZt/fZAFZMnfSl2kuzJNUUBaXCvDrUu
         k/rHg0wrFNvXE54zoTnS8x9vFlMB+bSOgYIGAIfM0NGfZfLreL2kzxHQUejXTjQiSEgg
         YoQccv5hyKPwY6NeFpPl9xg92m8RafG3KnNUHWPV9ZEQMeqkTj6AUFP58SGOGJrn7Npp
         lSlhVK6wpMfoqI/h4r0LpQ9MLQaDjRNi87bLtsqyXxPqe4pIQlx+ralrK+NmrsoL/VfR
         wlLhT2TQy6Gq5hMybaVoIxGfG3L4QnGStMYFRZSRBWX44kzswPHcjTOn5zr9exHtKZNL
         4tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788977203; x=1789582003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uZ5O85glUaXg9j3f8hCF0He+cOFGseFZ3HgdLBGxWfc=;
        b=jWp36jEirIKqd9dyzdCI4JS6lo4TzO7DkIAd2Ipzi16P/z9WmMkd2Ii/kO1UOH1qHo
         BCwq0wsv+meb9YEUK+IAjSp1Xz7kqN+PrKfBeRj6t/jRBN7NNt/Xb5Qv7hVouPyIH6F7
         AOXBrqCC7LJO+vckmcO1d3oFCev018vtxkPvl9UbOKADDcDxlb7yjkseaY2/MblqQU1h
         6JKBBP2nxz6KXP67cRVXHbpXTJAUGrJuhVt+20OTzMkK4ym70OEygaudcGo9u76gmmXU
         szT2adaoPID4B4cfuV/lH78+WaIpn2bt5KaYh+1QLACEkqfpzGykGpGJncbd8v1kOmOe
         nw6w==
X-Gm-Message-State: AFuF++m9ZL+x5ce93F2s2G2A5rC2yN/o4mZFgQccx6bv65VWuE/LRngv
	q4svEdfF+E7S4KvrnMfZlRK5Q+ejhkxnLNDrzc8W4JugQkW8mpK4FJcNU191RzeD+wLdxzTz5kZ
	e8qdp
X-Gm-Gg: AYBFou0cHtIG5lUTmIO2umof+MeKUlYIoOLkzVebMiSXjyO/qXoUH2zQ+xRoA2zrOXs
	3oPluforHlhB7U4L9UclnJc1JxdVrSJIKuiCuljYBfgNIQGGTaAfoPckgwIk1e5zy6m6xwH1+y8
	0n33/T8uLjc2w+zBTLt5y5bCagwrUBDGG5wlsOfH8J+Oo3Bmb037d3lK3GukbHkBbSRgDmjkeBq
	XEfkCbiUWvzPbXSbKxEjcVeurlGVkar6IwQkiufz3M/5TWcKRzjuzew83oPeGOE95ejeiVKwN1m
	96g+XCNAOr0Sa7OsV4QJD4pgZCGr/CljKFGf3FSuaLUSy0JVUCXBVYD7XQergHsZ8OT1KQ24SyQ
	DLDTIxA+PhGj8EbeSxnYQInTUb6ED211QmLR6n2zOfduJZkyXs1aXiaps6k/Ji4KeeMoEjFhNpE
	41afjyoC2vsflDpb4B6Rt2Y/1TP+Q39BIhUQkXCFIhMTq5Xhc6b7z9kOtoUIKrgEtqASaCdvqf2
	7RRLPWYXy4T4SL22U0JpXk9yEjVkAPShEl8OOj+cXHGj08clfV3m5BeFTwTW2PW7IfrU/bQ
X-Received: by 2002:a17:90b:2b4e:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-39b261d0d8emr56422446a91.15.1788977202852;
        Wed, 09 Sep 2026 11:06:42 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:a0f5:1d34:ede9:366d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm45633977eec.19.2026.09.09.11.06.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 11:06:41 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Please consider these upstream CVE fixes for 6.1.y, 6.6.y, and 6.12.y
Date: Wed,  9 Sep 2026 14:06:34 -0400
Message-ID: <20260909180637.41361-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg and Sasha,

Thanks again for taking care of the earlier batches. I realized I had left out
fixes that entered mainline after an older stable branch was cut and never
reached that branch, so I went back over those intervals.

The 28 commits below are still missing from one or more affected 6.x trees.
The Linux CNA affected ranges include every target listed here. All affected
newer supported 6.x trees either already have the commit or are included in its
Targets line. These are only direct pickups; I left out anything that needs an
adapted backport.

I applied each target's set on top of its current stable queue. All 36
applications were clean. With every touched subsystem enabled, I built the
resulting kernels and modules under x86_64 allmodconfig with CONFIG_WERROR.
The 6.6 and 6.12 builds were clean. The 6.1 allmodconfig build completed with
no errors and the same four pre-existing objtool warnings as before; a second
pass with Xen and CPU mitigations disabled was clean too. I did not run
runtime tests.

For cc31744a2945, 6.1.y previously took and reverted the older d794734c9bbf
change with the same subject. The commit below is the later fix now listed by
the CNA for CVE-2024-50017; this exact commit has not been in the 6.1.y queue.

Could you please queue these commits for the trees shown?

  1d38a9ee81570c4bd61f557832dead4d6f816760 (CVE-2023-52676)
    Targets: 6.1.y
    bpf: Guard stack limits against 32bit overflow
  fd819ad3ecf6f3c232a06b27423ce9ed8c20da89 (CVE-2024-35887)
    Targets: 6.1.y
    ax25: fix use-after-free bugs caused by ax25_ds_del_timer
  cc31744a294584a36bf764a0ffa3255a8e69f036 (CVE-2024-50017)
    Targets: 6.1.y
    x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
  98b1e3b27734139c76295754b6c317aa4df6d32e (CVE-2025-21651)
    Targets: 6.6.y
    net: hns3: don't auto enable misc vector
  9741e72b2286de8b38de9db685588ac421a95c87 (CVE-2025-21649)
    Targets: 6.1.y, 6.6.y
    net: hns3: fix kernel crash when 1588 is sent on HIP08 devices
  16c6c35c03ea73054a1f6d3302a4ce4a331b427d (CVE-2024-58097)
    Targets: 6.1.y
    wifi: ath11k: fix RCU stall while reaping monitor destination ring
  68410c5bd381a81bcc92b808e7dc4e6b9ed25d11 (CVE-2025-23129)
    Targets: 6.1.y, 6.6.y
    wifi: ath11k: Clear affinity hint before calling
      ath11k_pcic_free_irq() in error path
  6130825f34d41718c98a9b1504a79a23e379701e (CVE-2025-22124)
    Targets: 6.6.y
    md/md-bitmap: fix wrong bitmap_limit for clustermd when write sb
  3db4404435397a345431b45f57876a3df133f3b4 (CVE-2025-40325)
    Targets: 6.1.y, 6.6.y
    md/raid10: wait barrier before returning discard request with REQ_NOWAIT
  0032c99e83b9ce6d5995d65900aa4b6ffb501cce (CVE-2025-22103)
    Targets: 6.1.y
    net: fix NULL pointer dereference in l3mdev_l3_rcv
  c7d82913d5f9e97860772ee4051eaa66b56a6273 (CVE-2025-22101)
    Targets: 6.6.y
    net: libwx: fix Tx L4 checksum
  beff0bc9d69bc8e733f9bca28e2d3df5b3e10e42 (CVE-2025-22039)
    Targets: 6.6.y
    ksmbd: fix overflow in dacloffset bounds check
  1df0d4c616138784e033ad337961b6e1a6bcd999 (CVE-2025-37802)
    Targets: 6.6.y
    ksmbd: fix WARNING "do not call blocking ops when !TASK_RUNNING"
  fbb429ddff5c8e479edcc7dde5a542c9295944e6 (CVE-2025-37833)
    Targets: 6.1.y, 6.6.y
    net/niu: Niu requires MSIX ENTRY_DATA fields touch before entry reads
  101841c38346f4ca41dc1802c867da990ffb32eb (CVE-2025-38660)
    Targets: 6.6.y
    [ceph] parse_longname(): strrchr() expects NUL-terminated string
  e09299225d5ba3916c91ef70565f7d2187e4cca0 (CVE-2025-38591)
    Targets: 6.6.y
    bpf: Reject narrower access to pointer ctx fields
  efe24898485c5c831e629d9c6fb9350c35cb576f (CVE-2025-71302)
    Targets: 6.12.y
    drm/panthor: fix for dma-fence safe access rules
  235a1eb8d2dcc49a6cf0a5ee1aa85544a5d0054b (CVE-2026-23137)
    Targets: 6.12.y
    of: unittest: Fix memory leak in unittest_data_add()
  270564513489d98b721a1e4a10017978d5213bff (CVE-2026-43288)
    Targets: 6.1.y
    ext4: move ext4_percpu_param_init() before ext4_mb_init()
  779c60a5190c42689534172f4b49e927c9959e4e (CVE-2026-45897)
    Targets: 6.1.y, 6.6.y
    netfilter: nft_counter: serialize reset with spinlock
  2aa8a4fa8d5b7d0e1ebcec100e1a4d80a1f4b21a (CVE-2026-23448)
    Targets: 6.1.y
    net: usb: cdc_ncm: add ndpoffset to NDP16 nframes bounds check
  77914255155e68a20aa41175edeecf8121dac391 (CVE-2026-23447)
    Targets: 6.1.y
    net: usb: cdc_ncm: add ndpoffset to NDP32 nframes bounds check
  fa6e24963342de4370e3a3c9af41e38277b74cf3 (CVE-2026-31420)
    Targets: 6.1.y, 6.6.y
    bridge: mrp: reject zero test interval to avoid OOM panic
  426c355742f02cf743b347d9d7dbdc1bfbfa31ef (CVE-2026-43088)
    Targets: 6.1.y
    net: af_key: zero aligned sockaddr tail in PF_KEY exports
  10f86a2a5c91fc4c4d001960f1c21abe52545ef6 (CVE-2026-53078)
    Targets: 6.1.y, 6.6.y
    bpf: Fix same-register dst/src OOB read and pointer leak in sock_ops
  1baff47b81f94f9231c91236aa511420d0e266b9 (CVE-2026-53010)
    Targets: 6.6.y, 6.12.y
    ksmbd: fix use-after-free in smb2_open during durable reconnect
  0c22d9511cbde746622f8e4c11aaa63fe76d45f9 (CVE-2026-52961)
    Targets: 6.6.y
    ceph: fix BUG_ON in __ceph_build_xattrs_blob() due to stale blob size
  cc57232cae23c0df91b4a59d0f519141ce9b5b02 (CVE-2026-52944)
    Targets: 6.12.y
    ksmbd: fix FSCTL permission bypass by adding a permission check for
      FSCTL_SET_SPARSE

Assisted-by: Codex:GPT-5.6

Thanks,
Artem Dinaburg
Trail of Bits
