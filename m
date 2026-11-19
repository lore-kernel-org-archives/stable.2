Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094761;
	b=d3WTgQcBbAD8mIXs+JrL46y0ipx0sc1BUVWvjZ1WZ8iwYgzqt34xLkKEwTUNZF4TtjdE
	 paDEOV3ZD05wHCbADW3Ged0B1VchZj+dq09/GNcvuXp7T08TyCO+xcDmatMeu53Qzi+Ou
	 2E8T4FbrZGw5riHtQGOc60fbhuZKsqhOLcYLpCb+1cQc5BmLKY/2pTv8z16QrxGfd26OX
	 9DGBiDAhxTldfGxK2IBsCQefg/3BkwzmNsioweg/hjr+QWYW3na/g4YceZIOHIsOBW0bU
	 /UHhrZYewjqSnxhtcUwSquA7KLivaF45SgdzZuRV+0rps5nWzPaRpxllssZcEaYWvMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=QBF+AGHQifO+3u233pASAlE3TnXlBjN6SI3Ox9FZ8jo=;
	b=OiV5cWmWI1bQ4ubGRx67+Gbd+vlhzUkEopoCVl0dG1Dm6ThUHQ1EvoA9wlFJ+CDUxjqf
	 Swd2dfoLnUlowxeh+McfHOb7qxmwwuW/CA/6vcvX2OSz+lCEhGSFjeuDDsLqEWKoaCHZy
	 1QztqBGo2tRKtQdV5hb6kSt2ly9dXd1K2DXPQgJuj+eZ+3quW9TKr/x/4fq/85Oa62sua
	 FuPgvdejjloPdTIT418Hq2Lal+EMQYlPx7xLbsDwYojIoH71fRTxnlR5Wi4xH4oMxE2xh
	 h6lnQp9xqV5uSeqAAEkg3YjgSALjaTFsKVVXH2hxJv5XbaJUsqX8rCdig7rxzbw9KcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b="CMpf/mcD";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26269606A32C
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26269606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=CMpf/mcD
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so16685335e9.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795094759; x=1795699559; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QBF+AGHQifO+3u233pASAlE3TnXlBjN6SI3Ox9FZ8jo=;
        b=CMpf/mcDol2iNCF7ieDIBSzJRUBwBl7pxEIhCoMj46efN/9vCLMwQGT6idU1xQjC5j
         id2LnUPtChw3cLMk24+X2RpRQ8MnsVUWRCwl1ZRTvOaZLKmzXGvjvZ1j/hK/WsH+C3qK
         zYtjecOQu5I4NVCIrdYRd16mjFPTdZubM7NJ1l0pN/fvkc7MnKcF9xry+ar4N0iN0hBj
         E26wRl+vohMTiqP0qlLG1raJu5sngQZpwzXietRhY2svlCUMwDaesE+C9kfeYrhQJu8Z
         0DAX4RaAWZjpAfykTDFFb9xZGw+p3CalJdmfW67Qjbsl44RRV+yo40SMNWnr0EDg53ju
         UzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795094759; x=1795699559;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QBF+AGHQifO+3u233pASAlE3TnXlBjN6SI3Ox9FZ8jo=;
        b=XpP0HfqYABhx5QLBhA5HsSa2/p6kLk6likMi8qnnSIcSy8HCIFC5ICFNDZ3gYksco3
         8cWwkNEfm+eX2vOI9Z1KFVoYgHD5B6a6X/6LrzatBsUyhy/hd5MJZZ4XadNXzZ5sFyKj
         y3q1L4qhoA0dU84xp41pF3HEaKTy2GQXyI9/1NzdrGzMs68lsrzTkRFuKf0JgYLnptif
         yaKRIEO+QtUSVpemGRbm4Iy2LVaUqT9OBuJJYOArjnewieEjwpRSK3JpSSX0gAGq4n36
         krBAk1/zox8lCA2lC5Frcbe/x4pljYMEhToEfrikZ7PVF8g2gMrxlKQiII6tTDeiz/S6
         enCA==
X-Forwarded-Encrypted: i=1; AL+hErH5hJqQRHyUduOaydy7USMxeIiWA1+4dnrYh94nvLhvYtjcS9tKH/cXJ978tbo7jL3Co6+lbuk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+a9r42gLrEu/F0f9uffuydK4THbLWd4/OLZRuNB5/EpFqU6FwE
	B8ee27iYSc/rokjG/mMcFd0xh8qC/3IUzV0m2SW5WMZ/ou5gAaH2bnN9RkqQ2DUjhqY=
X-Gm-Gg: AYBFou0w54PtZo9h7DhQZbKhntI2Hdl7rsxzG7Hl5JHsuqDRRFPd/khUv3g+YI+Jush
	m+h3McdP9MFFyDlKKUGWPl430RKhxz78hbmNi2sfYMMATNxV3F92zf9tjFwg+MsWVZtUKFlmnZS
	X4SrT4v1vI1Yv+89vVq+kdGjPuSYyZy80qE6nXO6HdyT0bNgfv6SmQfWVBJ8l5Byc/7x6xWOoJ5
	pziHBjtt2cMU23pZwO+hahEntgBeoiiq0G6GnjgUOdFnMRjnXrttbqYCE+AL810rC73OTreJQzz
	tGj/+CpeNzL2YfsAHCNpkWoLZj1PUcJYIGFNmgLgpR+MSRHKcckqxASdqRoXgP2LdAJyzYpamWx
	MSWlk94lUpP7eMRzqpo7Splt9hJeqUbzUDYlwLZhUfD+erWt32HLMDVsvEgZVYqoFbgBzC0/8TB
	vYJPpHP0lyTVYr3eCVnfsUwdiXka7cc8OtD/Kh11WiqoIUy4Enw9+gqjOUQvBgMwoQRqNmSv/W2
	Nz/zb5Hl7qaay1IEXBjtEh1binsZEfXIENH7mAWx41PtKmXmXz1ECjczWAkjA6RuoactrZEVoxy
	hhtuU8QMmvWeXE+H8Yo=
X-Received: by 2002:a05:600c:4f4e:b0:4bb:7033:c92f with SMTP id 5b1f17b1804b1-4bb7da0f671mr139545245e9.11.1795094759145;
        Thu, 19 Nov 2026 05:25:59 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84cc09b1sm33094945e9.0.2026.11.19.05.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:25:57 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Subject: [PATCH v2 0/4] KVM: arm64: nv: Fix AT emulation for nested
 virtualization
Date: Thu, 19 Nov 2026 16:25:33 +0300
Message-Id: <20261119-nv-tcr2-v2-0-3deb1a6cdba8@pereq.eu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWMQQqDMBBFryKz7oBJUbBXKV0k40Sni7TMWCmId
 29Scfke/78NjFXY4NZsoLyKySsX8JcGaA55YpSxMPjW9865AfOKC6nHbojuOqaOKfVQ1m/lJN9
 /6f442D7xybTUe13EYIxRQ6a5qjNUNez7D617AWCKAAAA
X-Change-ID: 20261119-nv-tcr2-59b13df5ecf6
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jintack Lim <jintack.lim@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 Dan Carpenter <dan@pereq.eu>, Karthik Bhargavan <karthik@pereq.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0

This fixes two issues in handling AT emulation for nested virt.
* VMs were potentially using the TCR2 bits which weren't intended for
  them.
* It turned out that guests could write to the TCR2 bits even when
  those were supposed to be hidden.  That is patches 2 and 3.
* The VMID wasn't handled correctly.  Roll over could happen before
  or during the AT execution leading to invalid results.

Changes in v2:
1) Sashiko pointed out that we need to restore the original TCR2
   bits at the end of the AT command.
2) Clean up based on Marc's feed back.
3) Trap the writes to the TCR2 registers (normal and nested)

Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
Dan Carpenter (4):
      KVM: arm64: nv: Fix AT emulation for TCR2_EL1
      KVM: arm64: Trap TCR2_EL1 writes when S1PIE or S1POE is hidden
      KVM: arm64: nv: Clear hidden TCR2 bits for nested guests
      KVM: arm64: nv: Update the shadow MMU's VMID for AT emulation

 arch/arm64/kvm/at.c                        | 54 +++++++++++++++++++++++++++---
 arch/arm64/kvm/config.c                    |  5 +++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 10 +++++-
 arch/arm64/kvm/sys_regs.c                  | 33 ++++++++++++++++--
 4 files changed, 95 insertions(+), 7 deletions(-)
---
base-commit: 5a7235e9adff42aa043ac9473dbeb0354dca0967
change-id: 20261119-nv-tcr2-59b13df5ecf6

Best regards,
--  
Dan Carpenter <dan@pereq.eu>

