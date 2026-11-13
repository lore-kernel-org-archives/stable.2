Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599681;
	b=n0X4rso+odq4QXsoqMLppmgQGFV2nEC9Trhn/deziduvhjqS7vUhuvGPpi5ETM8OUgug
	 777/IEagek0RxDjqdQLOWV/cvGlFNVOxKllBcvEAqNcGN39/Nr1OG0etIAgOFuprMYUU3
	 2Sv1k+6BnMtayDbsQJPhyo587fyh+6CSwtbP/uMHMwGNYx40ZsSSDq1qtk949rJ4RQH1e
	 SV6ZuWsPg9sTV2kHmqAf4IOpmovnBiYc4ALC/HdGrwKrdFsZrlQWnVX6E6zD7u89gNKBA
	 Hr20QHqFUMfSks0gb3HDGfdzDyvBY1TEhWgWzYOIvH8GoNNy3LKeuWA2cYvBKr5ZcjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IM+AY411aupxDfXW3rYEXZkT1F3AQsoQqb9ny080FQ8=;
	b=SP9VuzDBBKkrqvEiAEYpkcGV6O1RaPImMojQCNrUmPZ1uqwfKVuskquw9YTETPcINkZg
	 lXTNqefz/4UtcXsnhWH+EbiMgXsgKYhFxnDw8OwNx3xvcwDz48w45PEm/PiA7Fqgm7Q30
	 4oQMmgJwWLHV3vzMgKM1tXgeP3TLDKyWYye3ynYG9RkFOcOjoBYDq44KLA49uVryDsxuD
	 oPy9krkXSUBYQteiuITRh6P94jkbAYm5Kij9lPT9JkNq/Ro6avuLTAjG5rONph2Z6zOyN
	 rFhK5EqqTUbVTcWq5z5ewqVcNoFpZ4kP7m/j/RohRful19YTBMjiGgihQNeeRos2hGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XS0Qc4pX;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE9606AE83
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76DE9606AE83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XS0Qc4pX
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91eed03da8bso35629726d6.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794599679; x=1795204479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IM+AY411aupxDfXW3rYEXZkT1F3AQsoQqb9ny080FQ8=;
        b=XS0Qc4pXETEIni8QMf6HeXP17xxPhjKQUkseH5it2DVmR5OSAc2pn0kDO2YdLAeeJ1
         Ws3Cc/V90uxFlwFUEafczugVEA7LsihseDXdYEmD+slDtG9Taul25UfVDN2UZ5DXcTQ8
         axLndUXZG8yma6eU0Q/4gPiO6/RW0ekgSMXH4T0t6CBb3h8Sb1MpsWleyrPTTYe5FSRD
         57RBPSluU9wHzeG6mc6cJ+jvtwVxt/ZbU887OKtH3vzjfhxZHFXuOEygJuDzwwd4AEak
         XLRMWu5Dy0ieSBRKl+oIU41B733Xc9OcqtmkVzblE2OPlPJ2yQ19OvoM46x6e/PYC4Ic
         EciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599679; x=1795204479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IM+AY411aupxDfXW3rYEXZkT1F3AQsoQqb9ny080FQ8=;
        b=rkPW/kRHJezAKTMwmSB0oZEP4wruN+1oi8ajzSthOlNs8wCgVDiQmIx7FhQaT3PjlD
         bwBHMZPk4e/ROduMprh8gC9dCX26zLH3NZSipHn94YDCpDLp8P2BCZsiAZBycrzyfE80
         1Rv7tutE5ZG52XqC0rbf0jAsbIvtQ4kmKdk0/M/OS01H62r7+n6sjiM9/tKFy9Tuxv0y
         zPIpdHEaP3eYCVOQ6t9MG3kjQN46JvuXOXimFrD+MMwft7D6A++NAJkC1xmGnl7cjsNk
         cm0J1Vigu42WZsAPPlJISeUkyGQd/Us1VlTDNhnSzwBH93xWg14xzpFn0Z2HvqyGsXZm
         bnTw==
X-Forwarded-Encrypted: i=1; AL+hErEXdjS7OLK5TiScS/athrxKjV2L6za/ffw8+63DGLCtDjN2GTYZferu0W/Nvg0GWtsBkXiIlqk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MpDa9ylX+bRQPsXHdGXWrvQYA6z7ZB18pMGq8WpY5mKF0QMpA
	tyv7dCtUjb1XLWkTmtNmId4YxLFa0SUMSWmgg8xQT4Dr38CBkRMgBrElnrWYQFlBeTk=
X-Gm-Gg: AYBFou15uXBE/qW67MK8hR09Hhi7KAHyqzModC1H2YHC4oMInSo8twBuuqEgxWx5kpv
	7ep0mKkv9Qt17aRvuk8gr21Ds3Gv/9fZqXIPFxt578SzRnCwGooZFOQPAq1S/AcQMgHwH0C/G5r
	4MwLiBZIJTBAqD+4rul/tekbvDoaUe6FIXH1QK07VWu6f5TEUvqG6siJFCPtrXxSiywIvPtYosU
	A6J8AV0lJam97GLS1IrIzs78P+vJReb6euXkDBBn1nJhLuAADLVMyQ/NZXndrAqwzpEuMug2jYy
	g4QhoEKK/9U+Vn9owL4v+NOiYurfUisOiCxrBc9fvj1WAB2VgiNmmHruA7CLguJSIrIuWJc4FT2
	Dtk4mcG9hh7BIQhv6LABgnE28dWELicopWzbFuiX1eOuOrHZvLGjb2nLjAePZZm5m8oIa60hjRQ
	88UNYSLmdIgltdcuGVclXzHYqjYiNGqQoJGFm84nH+hVQHdSA9dAa5phZYILc6ApXaOaPaziCgk
	a31ddW61UjLe9vlntDBjNbTysssdGq+5YZVHwLBt/Qls2zi2ntrIJnPrBDL02K+DdYJYR/KIyVp
	/4obv2RV/OrNvKJHgWqNoL9UJR4KJRimH5mZ+upM63O9RTn39jmWQL2wQNKGEOANGzybDFjL7Cl
	L5I64OzwuOSsZJSE=
X-Received: by 2002:a05:620a:414c:b0:947:84e7:f617 with SMTP id af79cd13be357-9494bbcc0f7mr614745985a.64.1794599679506;
        Fri, 13 Nov 2026 11:54:39 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c870ad4sm252867985a.26.2026.11.13.11.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:54:39 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	lyude@redhat.com,
	dakr@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	balbirs@nvidia.com,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau/dmem: free migration arrays on early fault returns
Date: Fri, 13 Nov 2026 14:54:36 -0500
Message-ID: <20261113195436.2659094-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
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

nouveau_dmem_migrate_to_ram() leaks its source and destination PFN
arrays when migrate_vma_setup() fails or collects no migratable pages.

The arrays used to be local variables, but THP support changed them to
kcalloc() allocations without updating these returns.

Route both exits through the existing array cleanup. Preserve
VM_FAULT_SIGBUS for a setup error and zero for an empty migration.

Fixes: c32287471077 ("gpu/drm/nouveau: enable THP support for GPU memory migration")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index e74d7bb975a8..4cfc7b16d445 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -233,10 +233,12 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 	 * than just one page on CPU fault. When such fault happens it is very
 	 * likely that more surrounding page will CPU fault too.
 	 */
-	if (migrate_vma_setup(&args) < 0)
-		return VM_FAULT_SIGBUS;
+	if (migrate_vma_setup(&args) < 0) {
+		ret = VM_FAULT_SIGBUS;
+		goto err;
+	}
 	if (!args.cpages)
-		return 0;
+		goto err;
 
 	if (order)
 		dpage = folio_page(vma_alloc_folio(GFP_HIGHUSER | __GFP_ZERO,
-- 
2.56.0

