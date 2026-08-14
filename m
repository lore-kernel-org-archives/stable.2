Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2683478E45
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786720453; cv=none; b=Yd/IQ+doFeVJMjsx88xI8OKLK1rceVgXgednhEI161JoNK5x43zkkaRvHy0PmxWy81M1NwCPkz3Q31rWUYIK5NxgipiYLR9DFaahjeUMXFGIjhJ/krrLoy0u/Ls5b6rYJnE/KPThmIdEk69UZcX/iX1QRlytklkTMEgp2m0o1Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786720453; c=relaxed/simple;
	bh=kmE7rvL6rE2nTVpZ7i0QDNXuT7Q9+9BkFYard4CiRO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I0qP+crGfUv3SyTiV9URPlQTtUEh4PPxzlsZ8xyOfm77+TMqEHNYAvHFyWUlQQBIUy6+xNuewbx5gjACOCITI2C9rDHHswkEG0qVC9Y0oTjWZY1fQB0K2E0WeNjOHaSGnc/yiTGOHJ80rweGihyoVyobdPp1EWQLe40PbAyoXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+LiAZM6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+LiAZM6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf27856f9cso11253585ad.2
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 08:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786720451; x=1787325251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwrpjQ4RLs0fxaL+2HIhI7tahvYcqYH+F4/hh3arkZI=;
        b=s+LiAZM6QYiz3kZzmDF8t60Y9uQ4lUIOwA8RKr5m8Qeq1S4n9fef5jzIsEuezIOowN
         rGSGTdZ9+iTI1oZamP+7vOz0axR9roBilxp6Ij/HE2Dsy42F+He3a8+28KzB1CY9QDqr
         zkGl1D8v43LPvB1cY7IQoslyUvCmCZeCsVduxd6koWW7uLQXErs1KLfkTR4JAcx2IJpV
         VZivPk5nB/jbOudadff1hk62kmvH5MMZrsgRG7OXZXzp/Sl/j2PkFNtokie8zgwx+EBX
         hL4Lj9YVrJSxM8LeKSuxSnnbirho+MLDF3CiNiyB7M/q59dlCu0NIXQ71AF9VfDhzgt2
         YQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786720451; x=1787325251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QwrpjQ4RLs0fxaL+2HIhI7tahvYcqYH+F4/hh3arkZI=;
        b=ZVMt9JtqQC1/kVn9kICYMNnFAyuyNOkcew4JAjEzbj3bh2Xzc46movmM4Q9wzxVIwY
         KtwWLGrdTZJhNqt2uCcW2GaBM1kFwg+IVKnQ3VmaY1sF/rWeiv2l7BVJe++WBX1al0MV
         FsA7aN2FWsoPWaNEt34It7g4umdYDmAeApI7hBINefhAVk0cISJ2ezZPtzyS7ZmmWngd
         tYEQ2BqIHjrNAeyOf51tjx6m+tbyxSgNVEZx3MWZOXMl3GoakIiK9fX3g++E7NbzxmkY
         30nLpz/qnetU5+PfUUj0QHP7y8ZoaUHrtGUFoLOBB92q8qsg89LEBk5F/sBTRIQ2NKM2
         +ubQ==
X-Forwarded-Encrypted: i=1; AHgh+RriTEizRuveeMInsdv0zMjp//TCwemuk42E46hbvU/Rs8AH10mw/sVn/B8XaB6s7KRa2GCa6Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkPrSzIeReCU3BfNK9DXxIqLHLNfpWhmloCgFcWlvkeVIX32mC
	Q0u4HjIKIs36RaxkfwNkmgq7C/2+nQgxEudtnMNq9nA8cBu9cKL8gPbG
X-Gm-Gg: AR+sD13rbuW81HuABZYOIVM6Bpvki6dRIzEqaKog6Im0ilnxTk9Z9PPR0PH5G4wgREM
	7MVYy2Qs7SlbEdeqkLOxkYt8+/Sr0SqhM3BXachtjQ3Blgs1qzIUdTuSxTd+Q/1W7WxsGoRVSLy
	qxCvUIoOmS0EXBY6viTDgQvsYL1uSa21oisN36hWRyz3GmioZv2SmcpYc3izuJVdsm0vFPTiLUi
	sduT7fpWYp3JKSQcdIcwvZW7RDTgG9cXlYrfGt6Uee8fDlA0LFLX7dpf81xRmyBYGyZoGVjLufx
	z7HrzjVjWe0Mm6j1LXDYV48w+DISHagoljCItFYAbW/ORKm7gzAIMfka5aNruSCYyxpg6Ht2O3t
	w74L8A+cHO22ACx+TBq00X7joQ+wwJSR37sHc79hG+TT/ENug0hCv0/jPu+WNINRmxQ9V3Jfhxi
	Q1IyjaFJ5elx1swkNMhe3ePeYf3z+SSNgkjzTxceY2XX4s5D/gB2awyTQULdnjeqXSQAGOEA==
X-Received: by 2002:a17:903:292:b0:2d5:276e:3e21 with SMTP id d9443c01a7336-2d5276e49b0mr56410185ad.23.1786720451133;
        Fri, 14 Aug 2026 08:14:11 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aec22f98sm11006395ad.84.2026.08.14.08.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:14:10 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Fri, 14 Aug 2026 23:13:41 +0800
Subject: [PATCH 3/3] powerpc/spufs: fix backwards coredump skip from
 undersized notes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-spufs-groupa-v1-3-f38f7549ce20@gmail.com>
References: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
In-Reply-To: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@ozlabs.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786720431; l=3216;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=kmE7rvL6rE2nTVpZ7i0QDNXuT7Q9+9BkFYard4CiRO8=;
 b=ejsdnLFdgUK5znL13j1wUljuO6RMq2kZ8mUgFDOuS4cbOhUkMQm9bGTRz0kLkctS2m8wT13GK
 C1dMqOTe7oWD4oTXdnZrT50XHPTdlb9D01JY8wF4kfvqdKaqvp5IOyE
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

spufs_arch_write_note() positions the next coredump note with

	dump_skip_to(cprm, roundup(cprm->pos - ret + sz, 4));

where sz is the note's declared spufs_coredump_read[].size and ret is the
number of bytes the dump callback actually emitted. It also stores sz in
en.n_descsz and reserves roundup(sz, 4) bytes in spufs_ctx_note_size().

Three entries declare sizeof(u32) but their dump callbacks emit a u64:

  - "signal1"/"signal2" emit sizeof(ctx->csa.spu_chnldata_RW[n]), and
    spu_chnldata_RW is u64;
  - "ibox_info" emits sizeof(ctx->csa.priv2.puint_mb_R), and puint_mb_R
    is u64.

The mismatch only bites when the dump emits data: each callback returns 0
unless a signal/mailbox entry is pending. When one is present ret (8)
exceeds sz (4), so roundup(cprm->pos - ret + sz, 4) lands *before*
cprm->pos and dump_skip_to() computes a size_t to_skip that underflows to
nearly SIZE_MAX. The following dump_emit() then fails, truncating the core
dump on a regular file (or, on a pipe, zero-filling up to RLIMIT_CORE
before aborting). n_descsz is likewise understated, and
spufs_ctx_note_size() under-reserves the note by four bytes.

Declare these three notes as sizeof(u64) to match what the callbacks emit.
For signal1/signal2 this is also what the runtime read returns; ibox_info's
puint_mb_R is a genuine u64 field, so its 8-byte dump is in-bounds (its file
exposes only the low u32). "mbox_info" (pu_mb_R, u32) and "wbox_info" (emits
at most its declared 4 * sizeof(u32) and pads forward) are already
consistent and left unchanged.

Fixes: 5456ffdee666 ("powerpc/spufs: simplify spufs core dumping")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 arch/powerpc/platforms/cell/spufs/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 8c7515140efb..7d8c733ccac0 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -2588,14 +2588,14 @@ const struct spufs_coredump_reader spufs_coredump_read[] = {
 	{ "decr", NULL, spufs_decr_get, 19 },
 	{ "decr_status", NULL, spufs_decr_status_get, 19 },
 	{ "mem", spufs_mem_dump, NULL, LS_SIZE, },
-	{ "signal1", spufs_signal1_dump, NULL, sizeof(u32) },
+	{ "signal1", spufs_signal1_dump, NULL, sizeof(u64) },
 	{ "signal1_type", NULL, spufs_signal1_type_get, 19 },
-	{ "signal2", spufs_signal2_dump, NULL, sizeof(u32) },
+	{ "signal2", spufs_signal2_dump, NULL, sizeof(u64) },
 	{ "signal2_type", NULL, spufs_signal2_type_get, 19 },
 	{ "event_mask", NULL, spufs_event_mask_get, 19 },
 	{ "event_status", NULL, spufs_event_status_get, 19 },
 	{ "mbox_info", spufs_mbox_info_dump, NULL, sizeof(u32) },
-	{ "ibox_info", spufs_ibox_info_dump, NULL, sizeof(u32) },
+	{ "ibox_info", spufs_ibox_info_dump, NULL, sizeof(u64) },
 	{ "wbox_info", spufs_wbox_info_dump, NULL, 4 * sizeof(u32)},
 	{ "dma_info", spufs_dma_info_dump, NULL, sizeof(struct spu_dma_info)},
 	{ "proxydma_info", spufs_proxydma_info_dump,

-- 
2.34.1

