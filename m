Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD642A82
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780768635; cv=none; b=CqEqmGFprgxhdwELaE6tWptZos6ac0g7h2mfb+XuIyvpjJlgi2zlCJ4gqiAvvLZ4yt0saND558L5TOJUT9Xfmq4+ipsw/HGUdUxLO+JMoy4qb2mTpdyiortpgny9FgyTefphoc9VBVtxqZa3gEupSFfgkS0ZnmuzsQecGtyAenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780768635; c=relaxed/simple;
	bh=KSZGHumIxF19ChxQvl5ED5jRjJ8wnG3VPODwq1yEaVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwYsWFWVZh+ZeT0CHZdo6Z/jKhXs8lbwdjFKStM9aDJnIWFsq0fa8QJSpixPNKVhhJalC6A34jEEx0KK7i5/7CVV9mXcJLPf3ewEdnYEpfXz5ZjZEiNMPSJEH9K3jDH3T7uoUmZvPx8xdYATg9EBgVdat0pjXv45aYlCOg0UT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5UAulrX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5UAulrX"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso21588565ad.0
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 10:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780768634; x=1781373434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ME+xNkoeE4ctIAxfAzYaPkyPD55bBWMm21iy3jKU/r4=;
        b=b5UAulrXVEOwA3+rtDQqlOoevzKCZmlnj0Kmby1MY0dXcH5WrLYjX6iu4HDPwbmcMG
         5l+YGRWZ5Lwvo0lszagNM576sSkiUv9qJvAudbCMzITJ27/6OGS5n7N7aBnubupv0Mdr
         SP8NcW7sgKGR2RzJENRmFOeeqFz0LuA33d89uC1GKryNCTnmi1/eqPHAXHTQDMdkKmpA
         ASlkHL+lSDAdW1EIzC/RUj2uxBlzMGHFA1PcyL8o9kphsalNAoCrTsWJ+6gehlAfooYY
         0ZLyfOwuq2NxcMPfSy4gtbGAnYACvQthhQHgADyWyt7X05AL/XrbFmT6XpkuSONKmnpw
         O1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780768634; x=1781373434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ME+xNkoeE4ctIAxfAzYaPkyPD55bBWMm21iy3jKU/r4=;
        b=BLD5MXdeJ5Pqh+mbACzQy2mfqzLyZAPqQGwHt9fQrH29dtOxJ2hMFlemNHcwRgfzkm
         RxpsVByIPl5roBAomWEKcXWk2OtgohaY3PzwU9lOOvXuS3Rkgy9zz2Ah/eNlZsv79572
         +rRSUPNoI/UMaoLQRSwq0uOnuV07v3/e+V2cJBdJvPsuuNdNFgrNICEtcf0mNRb07gvD
         p7K2xNGfdZILL62oZzAqttpDYT+JSLfNj1hpCzNZHL0c0KmA6B4ZJZVLybN+ZxihCGQw
         sgpKKq2WBXNXNB7e4gSYCpEJvDapAA699cICu5Q/eof4/voBoOynJg1j39F1K3OfkWlb
         o2Dg==
X-Forwarded-Encrypted: i=1; AFNElJ87El1KR9jSpp91tPTvlH1Fr5+AbNuum4NUS4dS+dClROnVg2jSDo5HG9/rv4MEsZi+ZwUgmww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUjpLbNqzzmbphIylXgoMlrV28rJm4doyjRKfJXFEdC8okWdeh
	jR9QzPXj5YAddSqwTzcxnmaWRUmXSkksMIpKj9BpEUmIzqPHWQHFYdLH
X-Gm-Gg: Acq92OENEAN6iEzXx2/y5FX1YsYMDZ47uiO0rjWxoexTK6JhbUZ5wXs0JgauIIhTC3v
	bJNAlcchKcEKSFJ6yQ9LGMPCDWACx4tFdTL9fdQv/ifkz5RxF3Z6u0LwEeOGo5kWito2PWP2acI
	tZunON9lMrv1O37r+0FBngckYAKypcCWmuVcK7TpZpOo9pr0Erx+O5bKFN6UkxJUI86P2+5dsql
	/1JhiHzG7jyfUQw7dEcuMzWouz96aUtKMWo7W0FZdNemvhla+5zxCK4YZ3g9IkwIylcb8EkalNW
	CdGBkctTvW61vLfwjt68J82EFcVfloghY2XgsTStfoQ8SFd8bnOx+hji5o80mQR1NB2xXbeZVoS
	u7BHavK0yj7X5WRdq8z5zmBOJ9IDTSR1kP16juHBzCb4Wl60A9JRF9lZbUFZplhwX3saThWoitl
	B2ACquhZTFtvGu7GHnMG1/f7hgb+e/9gjqYx9bL8HsWXHHD63HrykU2LX3TZEz3FNRR3k=
X-Received: by 2002:a17:902:e545:b0:2bf:1486:e6bc with SMTP id d9443c01a7336-2c1e80ee016mr102752615ad.29.1780768633594;
        Sat, 06 Jun 2026 10:57:13 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d69csm129196425ad.2.2026.06.06.10.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 10:57:13 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: tabba@google.com,
	maz@kernel.org,
	oupton@kernel.org,
	joey.gouly@arm.com,
	seiden@linux.ibm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	stable@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH v3 0/2] KVM: arm64: Sanitise host vCPU fields copied in flush_hyp_vcpu()
Date: Sun,  7 Jun 2026 02:56:09 +0900
Message-ID: <20260606175614.83273-1-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

flush_hyp_vcpu() copies the host vCPU context and vGIC state into the
hyp's private vCPU on every run. This series sanitises two fields that
it currently copies verbatim (host -> EL2): __hyp_running_vcpu is
cleared in the guest context, and used_lrs is bounded by the number of
implemented list registers.

Changes in v3:
- 2/2: replicate kvm_vgic_global_state.nr_lr into hyp_gicv3_nr_lr
  once at init (guarded by gicv3_cpuif), instead of reading
  ICH_VTR_EL2 on every entry behind a gicv3_cpuif gate. (Marc)
- v2: https://lore.kernel.org/all/20260604151210.1304051-1-imv4bel@gmail.com/

Changes in v2:
- split into two patches, one per field, per review.
- v1: https://lore.kernel.org/all/aiFe-CXo-XVTFz1g@v4bel/

Hyunwoo Kim (2):
  KVM: arm64: Clear __hyp_running_vcpu when flushing the pKVM hyp vCPU
  KVM: arm64: Bound used_lrs when flushing the pKVM hyp vCPU

 arch/arm64/include/asm/kvm_hyp.h   |  1 +
 arch/arm64/kvm/arm.c               |  2 ++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 12 ++++++++++++
 3 files changed, 15 insertions(+)

-- 
2.43.0

