Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603113;
	b=gnBzJVNGt+nAuOApoFQkMWcYBeBwzJXSSLWnSMubMkif905PFlBwyTo1olzmwMTHWeOc
	 on1RV6/GHt0OwUnVWcUYuolbh/hkMeQ5cZky/RJXHPecwK1Ozq+ydcJkh2YWMyJivKign
	 1hXltn0D/0GZKuCRZo4TMX9jFiXCzYNvkSounw/GpFEMHZ5TYDoU9azEEaIuO/RWlniKx
	 4L4eiB//HaYs6rGTs3jJtjvFzLxBZ13h4Q9BDoLdo9LEv4EpJUJWQQxmw8dmgziEmM/kt
	 HUvzdQZtIY3Ablu/nfp6qib3fIxPHmLnLmgAeGxKgSHf+3il1KbwtGzfqVZ6Pvq+TrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QxzgRFCSRCWipNXz6HQpmDljDRMnyFeDckVppufFRK0=;
	b=nOhXJ9dwKyq0XdCELWPcpRgtkDJSr9yPYue9EhawMro8giz7Sxx/4xt6ER4vA9ft17WH
	 3kmhtnDEGVJDEfS6d0KnbNxvl1nmWTi/opsWsIZIah5zprtQpDWDL8FBoFfSgVfb+6eaS
	 Iupgfc2Ay8C1wGho2+H7D8TUhkAZoMiC/zZVFmkX2C5Eh8qX2Ly6lavFtt/W4OJfypU74
	 2ietqlERoipnZvLVPuiuBHQR/k7sis1ySCHZxPEZSrDLViOZIsRjBAOZXTD3gAX6lNpyh
	 VkE3mGPCioGt/mHY+iMOR1mxUpXnEsX6XjlayXv6a+8/IzLgKjBkZfQOhWqgzA0Hk0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=dk4x0M0n;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3187606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 17:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3187606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=dk4x0M0n
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36661f953e4so1847595eec.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792603111; x=1793207911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QxzgRFCSRCWipNXz6HQpmDljDRMnyFeDckVppufFRK0=;
        b=dk4x0M0n6a1gnLUPee3r+NjT8j1Nkq7UEYWVEznEutAfLIFhh8tCVa4wAUzBKXD+Br
         421GLuQ2OflI6KKItnsqDrvVxYgLi7mCr1KPzkw3vDJ1yG3tFQEF7xhxViNPGPrUX2yJ
         4T/5VbaSAG/80T/ka8ti3/Z+CvkQKkNJ9a2IcVKZrVxJ3Dms6SN8JarqiKhFulLBCVe0
         hMdaqSgQ4nNLDJ9NyuQuw+5kngTGseQC3bptIfru7+XkFQFzkwA2DbBi+ryWP5uLbBWs
         sGCIj4QzJn9NrWr/jlyaf9D08/hZPd4aydNfmsYzXJ5Y4C+Rcq7F7sDr0WtFlqzb4Dc9
         LgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792603111; x=1793207911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QxzgRFCSRCWipNXz6HQpmDljDRMnyFeDckVppufFRK0=;
        b=wKBs8o9fOOMdO7K/L/ZNbR4D1bbE+bqqwKTIunOpcuyf7Zx73bT+MqYBxQYYNppU4q
         uR7wOsnFMOGj+7q8P69yeDhsCbehjudyhs1Eh+KWFx9NHra/4sHDPl5cT9lyXeFLG691
         M7bLnkQu5FhyXlgqvIXMEF829DwJA6GH2M1378OpnY3cCU8XrO5k3hyA/aMaYP+JBRcy
         5Ivq0NbSIB43d2iO8zpRnYoP21qUAs79/30skjuZQqMXXDm6usfHpSmrSO7qG60EVmTZ
         nG+uajhxdJWFh1qDzq56l+SjIlP7RRb0eTioG7gAQC5MMoE+AbivPrGyVAFAGMOiw99a
         dKRQ==
X-Gm-Message-State: AFq9FYKm4oOPGWpLN75kQRqOBuskcWIRFstBlImkLA3Oo6SF6LFqy3U8
	SdhpEkwIB+WT6ikp4lHlRea3oHrCWT+Nc5CCJELYMYadS7WlWVah06P5T3skVQakkVH6G1yiUzt
	aCoFsgwmjoA==
X-Gm-Gg: AYBFou0DW5YJo+AjbaPJhPX+0LgOcxhfUnXwgWhW390RuyLZiYkzu3mCJTeXrNYjAC7
	iecnGCZiMFdkf+abZ484S/JOjbXMRCpEMoNrqHic16KZsljQFZjbKn1pVwP2HwO9u4Lfy04N8ZR
	34mtHsed7bg8v7f+Xi3WMVe3PAR8R1ROv8GWN/nxwNuPUBLD4HjWQLd5uKiv79u1QZzk28D5fI5
	SaBMkFTnU5xli9qGXckrcV5tvjFJ9klK1tbwhIUgltcPk77bH0vOG8rrD0dvrERBctbgJEmVIPx
	khwAxdvt06Qa4MFoLz6f0SDmEpY3u/8YHrDah2gipu40veVWPaixt3jKDsijQIHsFuUWEB2R+ZN
	SndK2nKv7cdGHCuIsuaVuCB8CsI5TwZcD9oqGMi39D8b3drqRR5cDPR4cvdBDhRPo+py85LpXU+
	de1yUujUcCWP6xTarVbunY1/PJdQe82leP0Qfq3ZixOkkCdEvfVSr6mSes4vkt/7wMHPlJg0JvW
	4xl8P/q0w7ESOYUelQz4k+EPV146dOKFuao6k80yGk0njpm7uu4Qso0UPHZB0srrtNTvuAZ031E
	XbBEu7UglaWHG7TPmLMkJNM4Zg/OovU3aDFhkqgRdE5mmaHiCZcC
X-Received: by 2002:a05:701b:2051:20b0:18a:d0b5:fa42 with SMTP id a92af1059eb24-190a604f7f6mr3396857c88.19.1792603111196;
        Wed, 21 Oct 2026 10:18:31 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d059:e601:becb:a5ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bf5d0a1sm7529738c88.14.2026.10.21.10.18.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 10:18:30 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: ameryhung@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	pulehui@huawei.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH 6.6.y] bpf, cgroup: Fix storage null-ptr-deref after replacing prog
Date: Wed, 21 Oct 2026 13:18:27 -0400
Message-ID: <20261021171827.380-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
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

From: Pu Lehui <pulehui@huawei.com>

[ Upstream commit 3f562c537e9ecf4bc5e206cfffc2cc047f1b7e94 ]

Syzkaller reported a storage null-ptr-deref issue after replacing prog.
This occurs in the following scenario:
1. prog A, an empty prog, is attached to a cgrp.
2. prog B uses BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE and calls the
   bpf_get_local_storage helper.
3. link_update is called to replace prog A with prog B.

The reason is that __cgroup_bpf_replace fails to alloc and assign the
required cgrp storage for the incoming replacement prog. Consequently,
the new prog inherits an uninit storage, leading to null-ptr-deref panic
when kick the new prog.

Fix this by rejecting a link update if new_prog's cgroup storage is
incompatible with link->prog.

Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Link: https://lore.kernel.org/bpf/20260728132336.2857800-1-pulehui@huaweicloud.com [0]
Link: https://lore.kernel.org/bpf/f87b53c0-8f00-45a6-82db-8242fa9b143f@huaweicloud.com [1]
Link: https://lore.kernel.org/bpf/20260807104403.1013064-1-pulehui@huaweicloud.com
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-90250 to 6.6.y.

The code changes are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 kernel/bpf/cgroup.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index fa6f818c8eabb7e3db0de27cc6d58821e91189ae..a810bc0192de8e74aedfb2351f54c118eb8be584 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -856,6 +856,20 @@ static void replace_effective_prog(struct cgroup *cgrp,
 	}
 }
 
+static bool cgroup_bpf_storages_compatible(struct bpf_prog *old_prog,
+					   struct bpf_prog *new_prog)
+{
+	enum bpf_cgroup_storage_type stype;
+
+	for_each_cgroup_storage_type(stype) {
+		if (old_prog->aux->cgroup_storage[stype] !=
+		    new_prog->aux->cgroup_storage[stype])
+			return false;
+	}
+
+	return true;
+}
+
 /**
  * __cgroup_bpf_replace() - Replace link's program and propagate the change
  *                          to descendants
@@ -894,6 +908,9 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	if (!found)
 		return -ENOENT;
 
+	if (!cgroup_bpf_storages_compatible(link->link.prog, new_prog))
+		return -EINVAL;
+
 	old_prog = xchg(&link->link.prog, new_prog);
 	replace_effective_prog(cgrp, atype, pl);
 	bpf_prog_put(old_prog);
