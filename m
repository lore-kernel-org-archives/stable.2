Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794032339;
	b=vlYWfs3lA0yt2qvijod9ZLEbyNIKRGnvTw6PdOVJgau83Mbg3rbD+0X+uFC7rjmpgUpg
	 A/KHFGWw9fHTPCDWI+zVlEfZ+CZ1InjD9uXXSEgPY/UA8e3Q2WOMGWl3s8kP7WD+gm7o5
	 Be/DsYwuxPQzw+v9MtgqxTMdgFNdixk62GLHKNG4gSI/NVH5BLd3VaVxmJ+zLtkOJeRur
	 g8CrhLuvfKRXpHpu1EloNv3qFyroKjXmhCQWlODEy/0e35JRcQ01P3Gz9ZU69WXNWBx5O
	 IwhORtcDgIWUZcT1v75HXUSWJc9VK39tUHBarF2JYrlhI/JUze8ps2iL53b6flnSUmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794032339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PBM2nSAybAfiialNHVzu3HSG2mME3T0XPb7p1fQfDMc=;
	b=mdDhAAseYIT1FEi2LOpaF859li+ZAhSWVC/vaz0Hd7iwiaHf0qlTSxg8e+2TZAxb68wm
	 ocvnvy16pS5m60CNXBR11g6IwpQLKca/g/TDcAEryy9AiSU4+FXpJac/DSa8Z2YAEMYko
	 AkAdj2QPFmAvY4qHeaEeNlMAMdsbd8kWeIIAZuZFuiHzckfuN9+haIzTGbq4qZFAwZDrL
	 5IkxNW/H210GlZQggISoxmfmtAVE/M66h0rj1QCiT9p4TmjNiW+YE77KwekEn8TCiUKId
	 c387HR5NjWTfDzKewP7e0b//4nN4lN+0YpLyhmbvwHea5JXXkXPsiYhegPRwbZWFpfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hg67EsON;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB50606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 06:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEB50606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hg67EsON
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso534131a12.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 22:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794032338; x=1794637138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PBM2nSAybAfiialNHVzu3HSG2mME3T0XPb7p1fQfDMc=;
        b=Hg67EsONuRLOXbwkZ4ELqj8Fds30RDcfcrsWI0n6Q+Ndw1mnKP9oTIcOniy7N+k32z
         KsAqvARhONawp6Ni62ppk08abRwkBipsnXIhJXgZZXJQpWlWfjSSppZc77dta1uwv5/1
         h+GPVDh0SVyFWKHWLbUKEr/uVJUuxeJj5V5zgGqqd0fuJ/k8JXxRRGXdKf0zrXypKer8
         lA7za2yi0SEgfJ7XAfUezP7o8qkzg69gft2Y4JCGOm/tnDWBBzp5PDC/6/vNW4kGDwho
         +hVWY0chO/eXjmmoGY2beJgYu/mkREOuQTxbrV1z5OtKLjNqPBopptc7liY+zB2U93J5
         PlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794032338; x=1794637138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PBM2nSAybAfiialNHVzu3HSG2mME3T0XPb7p1fQfDMc=;
        b=pbR5wzmBM7v6lTAgg5CZ6QiyWOs5RXjyzPKb8887zSp5njDBrwSn7P2OyGdQWh+dHd
         a/Eq+xgQ1LCsyN5PXaJwe/PtbztJ9rwiLt8/KqdYJxB09PO98HqUykRU8N8LOwy7Q/5i
         f/VI3JVprJvTD7A+Mzxt4ZjbyzK1OwlEyVauyxMrCfhYmVbmrEIj7NGBDtLMRoXj+YaU
         +cFq5lNOVTU6zfHQaaOK5RD+GWvqqCItrLgAOXbNT2xrck89hTJcB67XVOKcuwk2XddQ
         nm28O2taqrv1aElj5mn9iIk5GpMbCWszRVe3vP6i/YIwR20Qg2LFQdgA5ebNQRLkTLW7
         eH3w==
X-Forwarded-Encrypted: i=1; AL+hErHubpuaL3lquYJYiKYeK/3kcKiFs8tcjnB0W0nO76/7ZXh+0uu1oby8f5rMQp78dqFYXDxPLS4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9j3OTrfQrJYoJp0ipB2sJCj51AFDqXsfrtAbkqlSF4v+wZPfy
	nCeRIF2BiH38w51tGRnZpN5aJ70lgdyWZPWUeVdQ5ERl2s8A8gddEPDm
X-Gm-Gg: AYBFou1QtwlU95tj0f6G4BTEp6KlAYJbe+orCJIn0wfGK9byuQoPSH2lz/F/5S3OskG
	c/FgEAVkqZuVImFuFQ+AfXjRtrVkphLtjLD3PPZO48FPKlPdNKL+n/4q9cH2XzV7pfDMMWubOXl
	q+sL8Cb6ejFQympL2J7nsAKR0rOuX+RYmYkE9Zk/v2ScIT7cIE5XY8Kb4PIgekT5Yn0gLA9t3H6
	2nxrvfFWRLuRfeljLjjmkOkyDPcTw87O5gT5HFT1xlx49FsINV+YIx+GZ0Wb8b3lOgGHl5n6Wgm
	/WYw+pnSW1+Bf22cXaCsSIP+tYdOkXk5j5I1ncTqo5+EPUukzoiQJqJjjUANRaLJ8yLsXj5TYqH
	hKai+la3guSj8Lq15fvH2AtRUvU2ACNEB+Y6ckbVdH0WSVLLuo2lggc/DzKcuqlSaBzeiYkb8Ea
	RLG/hjn3nNbhGzrJt419B5dU1bZM8f1Yk4Y2oOiJ6GmbpJx0e7/43g5zfeQx90CKGnZvEOWnv5F
	QQGiQlOpl0YIagvRIh6krylvv16qu5f9U1N4gtLCHelaVak5ICWv1zrN/tu/I48ND236+0XVV+6
	E39+b3gSAbVTmyv9ik4MRrYucDpYpjcnVXZZfj/+4gROyH8S64NxVHJ2vlVCBRlhnV+ltwGTqtS
	AduquHociclfT21wW1i6P9KQEJ/Y=
X-Received: by 2002:a17:90b:5107:b0:3b0:9f53:e8a8 with SMTP id 98e67ed59e1d1-3b0db712d66mr4613324a91.52.1794032338089;
        Fri, 06 Nov 2026 22:18:58 -0800 (PST)
Received: from codespaces-2362ac.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net ([23.97.62.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101c28791sm1340220a91.3.2026.11.06.22.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:18:57 -0800 (PST)
From: Seongjae Jeong <jsjlee1020@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: yi.sun@unisoc.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Seongjae Jeong <jsjlee1020@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] f2fs: skip further SIT updates for already invalidated blocks
Date: Sat,  7 Nov 2026 06:18:30 +0000
Message-ID: <20261107061830.30764-1-jsjlee1020@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When update_sit_entry_for_release() encounters a block whose bit is
already cleared in cur_valid_map, it reports the inconsistency and
corrects se->valid_blocks and del. However, it still proceeds with
the discard bitmap and checkpoint accounting updates.

This can clear the discard bit unnecessarily and incorrectly decrement
the segment and section ckpt_valid_blocks counters when the block is
not marked in ckpt_valid_map.

Continue to the next block after correcting se->valid_blocks and del,
so that an already invalidated block does not trigger further discard
bitmap or checkpoint counter updates.

Cc: stable@vger.kernel.org
Fixes: 81ffbd224e5f ("f2fs: update_sit_entry_for_release() supports consecutive blocks.")
Fixes: a66cdd985532 ("f2fs: introduce discard_map for f2fs_trim_fs")
Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
---
V1 -> V2:
- Add Cc: stable@vger.kernel.org.
- Add a Fixes tag for the discard bitmap handling.

Fixes tags:
- 81ffbd224e5f introduced the segment checkpoint accounting regression
  by replacing the del-based adjustment with a fixed decrement.
- a66cdd985532 introduced the discard bitmap update that still runs
  when the block is already invalid.

 fs/f2fs/segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 51858f64e43e..fc2f0fd8e318 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2560,7 +2560,10 @@ static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_ent
 			f2fs_bug_on(sbi, 1);
 			se->valid_blocks++;
 			del += 1;
-		} else if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+			continue;
+		}
+
+		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
 			/*
 			 * If checkpoints are off, we must not reuse data that
 			 * was used in the previous checkpoint. If it was used
-- 
2.53.0

