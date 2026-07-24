Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD89413793
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930536; cv=none; b=c1eMPY6QRapzZpwod6lJq088LsPuYAM+STRpb+p6UEs5IRnyFn4PZ4YkJGe1uNkNmltZQMIucXhsJ//1KP/MAkwWvq7n83Xv5UQvF1sPinvASad+0xE4gbcY4Auv90XYm/cgBBuOXh98fCGKpNKEHZQTXG2OM0g6QAHWmyKmAzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930536; c=relaxed/simple;
	bh=JOTMTHvNXNnDMv8cbytpWkBwOfL6IylIUcituYRfXKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rp57JCloAA8oBK5E/Gzk7GL9vGT4ywL7ShzKU0JlWbE5FBw//2L6CGd260+W/pTqjyam5rowh5nawVdDzcNJxUzctC7ZePLHBBxWlKrABJyQ/Keqz+GRJTvgeiaDe06O0d1OH0GHSaP64TB1FtyLlv8Gz46ckUgE0TU7WjRepks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd7CVZgy; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd7CVZgy"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c0cea8883so9448941cf.1
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 15:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784930534; x=1785535334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1VNwYcQpb9WDj6KVSyLpNd/oPBMCMFNw+HEtq66+P0=;
        b=Gd7CVZgyCqObZMuSxTfhDA93XhEUZi+I0GAWp7DQCT++bxrPkJsSFhSzU2UYmFoAYP
         o8uM33LxEemyXTm2fjLDUvvBtg8mFB966x7y3+FW/xxhuU8fqUHh1krozohDx97u96RW
         kTlE35fx33BM6bbTSAZlU92ae/UmH9nB/9G5BAiwk/knXPSu5TATrAwP6pT6NoPggK4l
         D3zTq1t5Jd8n6UbRqNKlDH1qzeqL7eAOCJthE5pxIK4vLnt0sZD9um4dFgPiQtiBpPaM
         ms3+1F8u3gD/UH6nXVXUAfAcfWsMpMkthVMLMP4pD9awk2pQe/waB7l6H62ftkSBSbXW
         nKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784930534; x=1785535334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P1VNwYcQpb9WDj6KVSyLpNd/oPBMCMFNw+HEtq66+P0=;
        b=ALf4YaWXIrG5vdkmgpC7uxstnwRnk6feTA3q8K+iV2/+glqZw1LEVr9nL5baKvavR+
         QrO+P+v+SElyxxfKaD5bvM0yabSHfDeVRnvxLf+1qihKaW+Fa+iO5CZnSM/prroSUYrv
         PCOc56Q8YELHd3jiVyrIx7QK2K9PSTGqRqzf9nHbm0RH08fDxnQdNRqI5SJyJZj8gZMl
         oAQ+nUCNUBJgOjGXJXUNDfzFbrn2hsvWmSpYfxxKgoxqF6H0kl6vsrA0xGTFV8sywkfW
         kSUsqWCLrit56vdFoVA+QaNauX5WB0SyzMx6vBctXKYV4A7kpd4pKeknvUaV9jRZZ3Rx
         iaag==
X-Forwarded-Encrypted: i=1; AHgh+RpsrEzs60ZIsjlsAPSlS2i+H+YPHALOwcQjGDPvDxwu6M/BTO0XZXf4eESDuoQWOm8CuWvBua0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDNw6AuhK+pRk+r2rtkbOCfaUih57eCEyNyBpzKIcXR3mt0Otb
	ZKeTQlrcdNF0+B/Xv2C/Ur5FgNGP6VZydeAfLoHgx2NWVzFwvPEMUP2Y
X-Gm-Gg: AR+sD10goszsVEgE+KRnl6aSgOdWyBzF+0XjDV56vtWF0NPTj8FtpmBtzeN+9T0RYQw
	hPmxsP3lSm6t3iBmaS0v+gh/zlCscOk+SkEpUolEMAfESEbS2M3oQJAe53uWyAKg+D8BYbYEH26
	Df4U8mQ4vg/XRshN0TH0oisz7LVGLVPEOH8xD5zVEhabBuQyibw9ZSzGsLZ6i9BnGnYkRsvsoXV
	vGMERuyc16yEwRjbgNz1IGkyqUBOIpI3FzYDRGrB8Nj/WJpcGutIqejrgCdw55hhYUdQn4eN3ai
	sTfNCxODqvN131/DvrRmujhiIhORyFdexAP9YAXSAmAywT2UWYQrDLGoFYjEnrlINc5oqE1k2i1
	Dm+fk4xr67cdc2kYXATNCa7Aie5XeEouPU5UkU1DGYvP7PRNnmWBSxMg78zbdW5m5zVyN+voZW/
	2Ti5KSJlkL2u3f2cc=
X-Received: by 2002:a05:622a:2614:b0:51b:feb2:3827 with SMTP id d75a77b69052e-5295f32b6a5mr29099041cf.32.1784930534076;
        Fri, 24 Jul 2026 15:02:14 -0700 (PDT)
Received: from FredPC.lan ([2600:382:311b:26:c204:8bd0:9563:8b5f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a27f68f3sm8668631cf.9.2026.07.24.15.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 15:02:13 -0700 (PDT)
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
Subject: [PATCH v3 2/2] smb: client: clear ce->tgthint in free_tgts()
Date: Fri, 24 Jul 2026 15:01:46 -0700
Message-ID: <20260724220146.1859170-3-fredric.cover.lkernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724220146.1859170-1-fredric.cover.lkernel@gmail.com>
References: <20260724023539.1596955-1-fredric.cover.lkernel@gmail.com>
 <20260724220146.1859170-1-fredric.cover.lkernel@gmail.com>
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

