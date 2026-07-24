Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C38D37C908
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929628; cv=none; b=SGW9VD+/Srmw0K9EvCRDdSUKnjtDcVJfE+I3xcogojkdQWNk9WRlvMa6RpiA1YPlhYOcCYlJGb8nnD5F12uuNpjoYpNltXURtN2hILmT2GtHMNtSTToP1QZWnBypnY17BDn0gatVNRgKSRV3zJy1wg4gFeovTRlJKjBP87aV4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929628; c=relaxed/simple;
	bh=JOTMTHvNXNnDMv8cbytpWkBwOfL6IylIUcituYRfXKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oq2TYTmvecpaYiNC8VwmoA9btUotK/wVyGZ6GQNsVUCsfBfjLABsylbmnkPDbjWmbpR5wIsWTq5zzWaPvb/eYyds3OZCDcBVco7zOi6nOkQ5J1pwcpkImEvrRGbUkcRmKSrLfn5SBwrhvbnuQzX8wMu/s0Y/9DyBuhxXcf8ria4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhG50KbA; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhG50KbA"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2cce930cso8495381cf.0
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 14:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784929624; x=1785534424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1VNwYcQpb9WDj6KVSyLpNd/oPBMCMFNw+HEtq66+P0=;
        b=FhG50KbAES9Xcz+clA+Gb9RhVhvutwyqW+sG20+rANtAZHRZ21l37d4BPqx4BYMd9p
         77RGJ112PgEFIhUV9jqB3JtfTBgNH4QAXGkTIAcY0312ualNEcPsI1KxYD6QNX9i+0D+
         moLDoCB8Gu4r6qHDGX7d/7HAkuubeHSjD+VwnZI6ihr3ebjcZu2+05LVZ9e4kSGxDKRH
         MwK1JkcYU0hTDx0pWWR0B6JVTKzFmM3g/uLrr1+O0WNaN0na0zju/p1c1gaaVppgCBii
         zt7+/lBBKxkzyljSFeHFlFiathPwxVdFtAE/MIsMa8XP5bKYj9ufHHM8LkdwcW28NBBy
         O9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784929624; x=1785534424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P1VNwYcQpb9WDj6KVSyLpNd/oPBMCMFNw+HEtq66+P0=;
        b=BQlANECMQagvRVKwYOrI2eAghvosOd7Qyrag8bX2pmv6bjnJ+zfALPzYeigdwCdZ9U
         yjdSNiR1+TUx5Km9xGeEL9FORl/lHchRgROp6gh7pzPQ1RDlephDBPwnppRxss432IVR
         0rpbGwQPl6st/V5YkI4o/cUKI9fcYvNX+oN4T0go3awWnTCQ4HqmWpggQCePI+dpA7M9
         hT9QVXysdV8DjhVkS0tT8KPKmjmWGmeuKxS1Og2zwUr+eDluDOvSzdVlpUKXiKrJALLs
         MPkuzPtE7SIQRtuBsHUMmdA2q8Tw0KfFU5avQ0aFUNf9s03t0WCOsP4NAPoMJQbLbYif
         Ht8w==
X-Forwarded-Encrypted: i=1; AHgh+RosHbDV6WoGwBXpI3DH3HwpmLY3/VEzg+4FEAnZi7Xgp5Fl3Txy51os/+awacmnpv3ylbr4hD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz3Stq/Qd9KKd3vD3FSX+lf4NN+tOXOk06FnYaOQ/KcN4UwoWq
	idcRHAzPD6qzW8TbxopETeU0TMQqMPESX/ngXhjltYYzvU9yT2nyY+VC
X-Gm-Gg: AR+sD11LYkpbHylJrxLcqDXsI3Rff2W2L9vO3mhlM13LOo667RTtLO3bj37YwnGVVwt
	6T1Orcev0vQrTiOVi7emDPDxDkpS2pQNj3eFstolI2MyKQLCm2QFb5SB+s5qj5VQKzh09AFKU3Z
	3VEHakNRxinw36PN4dNfxLupurYpxYooMFrzk1PJWUCfFAVu6bR5JoA5TJyGjTI+3hzZRKXXTzM
	w2pjTEx3THfc9XeLHSd3RL08iVJJU8Uua0JQW7mx1i1qmPfryJOmVLt+Dk2fWA0hpxXBdIFR8Ie
	KaJt+Kwzi6wsBNAz+Gjd0WpXbE/oP6lyfxFbrPQdKiGWouy2J8r/HaOmx7qE4XGv+xPVlwjmeIF
	Eqx8gh18HxrQCf0Ui5zQQpbmVB5M3RWV6oevglLkw58DYEeelrlYQsAS89aCODRE/N+OTmSp7Qq
	7heQ20JSQ7jKMwSJ9GTKxAOaI2lQ==
X-Received: by 2002:ac8:5e51:0:b0:51c:1568:3a53 with SMTP id d75a77b69052e-529a8337825mr1442741cf.16.1784929624076;
        Fri, 24 Jul 2026 14:47:04 -0700 (PDT)
Received: from FredPC.lan ([2600:382:311b:26:c204:8bd0:9563:8b5f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a29cf785sm7916771cf.21.2026.07.24.14.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:47:03 -0700 (PDT)
From: Fredric Cover <fredric.cover.lkernel@gmail.com>
To: sfrench@samba.org
Cc: pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fredric Cover <fredric.cover.lkernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] smb: client: clear ce->tgthint in free_tgts()
Date: Fri, 24 Jul 2026 14:44:35 -0700
Message-ID: <20260724214435.1850384-3-fredric.cover.lkernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724214435.1850384-1-fredric.cover.lkernel@gmail.com>
References: <20260724023539.1596955-1-fredric.cover.lkernel@gmail.com>
 <20260724214435.1850384-1-fredric.cover.lkernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When free_tgts() frees all structures in ce->tlist, ce->tgthint
is left pointing to one of the freed cache_dfs_tgt structures.

If ce->tgthint is not reset before it is used later, it results
in a use-after-free.

Set ce->tgthint to NULL in free_tgts() after the elements are
freed to reflect that no elements remain.

Fixes: 54be1f6c1c37 ("cifs: Add DFS cache routines")
Cc: stable@vger.kernel.org # depends on: smb: client: harden DFS cache against invalid target hints
Signed-off-by: Fredric Cover <fredric.cover.lkernel@gmail.com>
---
 fs/smb/client/dfs_cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/dfs_cache.c b/fs/smb/client/dfs_cache.c
index c9ace4326a35..86dba25b7a5a 100644
--- a/fs/smb/client/dfs_cache.c
+++ b/fs/smb/client/dfs_cache.c
@@ -122,6 +122,8 @@ static inline void free_tgts(struct cache_entry *ce)
 		kfree(t->name);
 		kfree(t);
 	}
+
+	WRITE_ONCE(ce->tgthint, NULL);
 }
 
 static inline void flush_cache_ent(struct cache_entry *ce)
-- 
2.53.0

