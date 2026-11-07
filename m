Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794070377;
	b=G0s9UbMgUIv3W2sjux6xiEa37Hgs1WZpiF4U34sBqQHXEY8sOGLhx3uXS1XbBdV+WIli
	 gFMb9KExiO3gZteS245lYu6kDHiD7vRXcEGUxB1jRqBBNwO4O2Btt8+N5NpfBhxvzaRN+
	 9XHV711H3d7S/usmvivRgGZ0EDfkyaA0bCjQhxDB6k7E42E98ZVznBJDKaysCUUmgrL89
	 fyoXke6Nt98qMlYoSOMsB2AMKp81iLyQp8HiPtGZj3vTLzFkW+dOYrQJA1zmL51FoVEr/
	 5UJK5Esxi+QOOlcSBZX3a4vxwwTBpZyGRO1fCee6TaTXFtgVRZOJe2+CThi1U3R5uIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cPWF++YSBdHbkvl7nrr/KFPVgdn7Cxr+5lc/XMN2idE=;
	b=sH9JXk95CCpK0y4/RF9vOzYe8+CJhhzjXm6R+9Z7jTGsdiauQKWjWVkTewwmwxuI7S6T
	 +0/TdoXLf4h2T84DNtGpLlYBQYxCaH/fFGDaoi+0ApJCxjkM9X7kufELJpvYKe+qQJgu1
	 vuKFE+qfyn3thGMrMvsm5UC11xIloLpnGrVFKnPtXCR3VnFjm/I8V0xbcTW7wUQxkE4yU
	 42OxrbJSKjV1eoovzs7NSF1UmSMq70vDdq/cKH1HL1B+yNNvbqyogpQ+3Zfo1sQzDuU/X
	 zRO4f2TYGmfeoDWzUHF7/OkthmHqlxxOHPt4bsktG1Z9/Lfr/u0upJbyj7tKyxHQBxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BPFQp9tV;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6365E606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6365E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BPFQp9tV
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4d427836e9so175385566b.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794070376; x=1794675176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cPWF++YSBdHbkvl7nrr/KFPVgdn7Cxr+5lc/XMN2idE=;
        b=BPFQp9tVatt9VZ2zoXqToEMmnO6yRi01IO7NvRug4oqSzFEVfRUAG9iucJEX71sN9A
         DtVtim/pBUXO0dangQ7pLm420S99RJ2pY+i3JwbA+aNmMfi8dQD7nYzSYr2HaYkXw36O
         RMbfmEGfTthcI1n5BUjNH/QjxedwFIViHsw8fcjJme1HqZOysAxXhfJ7SJ0fsCNhzKiZ
         aPAGaGAtpQtlza9dLYDmTAR3EcepvQIJympjGggki+xUypV07LkNYR+evVB1iZNQlk9a
         nRRIx9esqnoqwlDzbYu0F1E+OdqdA1beytm7L3bblo/cs0/zTsN9Kiecq0u1iIGFWv4K
         GXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794070376; x=1794675176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPWF++YSBdHbkvl7nrr/KFPVgdn7Cxr+5lc/XMN2idE=;
        b=ZbpXK6VsBresFV2rzU7yBvq6L3cPPGAd2pa7zlu3msvcU7+S92aV2yxM6xf3JvIAnr
         HJU0nnWHLoiqgCPpNzTrqOWlWK7Uvk1vrfa/HGUlUna2wpnpDF6Yz1GsVpQiiJZhSFPL
         gS64o4UjJGCoSpYNVdoYMWTN+wb+oTNE7Dd9cGuwrJo7k3WNatMhUm5rEYV0xgTgbNY2
         vohpHTtyIC8uP+qRUrlqakdiha91GzN3/K1JTTouclwmrBXu0lBO1L6YNV5oaCgztu0f
         jemTm70mm38mP/CjnaJb0Hd1S66CxWeWmqPDRnEdqbrNvwKSnB4v19D1lCwXIuTHHmfm
         fENA==
X-Forwarded-Encrypted: i=1; AKwUvBysFbOQkcN1Zh6me1laoWf2kKjpz3lbL6zbvpofCPcn6pfNtq7TDQeaYARy0Pvl+X2U2r78XzM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sDxh3oscKggsSXVmAjGmx3dQe2gokmZyvffY5OA+cf25M7sNT
	0K+8FT+MTN0zW22cfJn+V0G29xQDXGtAQh05DhWGED6pUntDDeMTm7Lm839QMIQx
X-Gm-Gg: AYBFou0vDJHBarKh0nELvo9LtOwpMyAPPe+OsIjCkEpbmqPbcEtNu+GBS2vgAuNozTw
	gGEuFh8E+KXa3UyemGz8J79HG2brgv/qt8Pi1BNAhHA6nxr2AazBr8cvfB8zx9wko66RPfjTl1w
	2LdjlP8fn52blA9JMVrw5ysGxVv9ZTTT9q/qnKn/fJTn/6NMadg9TCReKdC6+9x4FyxMWE4pEgB
	MnWmzY50QtXZ9Zps6N3n2M1Z70TX8rWeK9kN79VJQ2AbLJi9UzEfh1druKvcB8WdnmmUGJJHlEv
	X3+b0DIXQLhs1wTOP3Ucyj26qJ3neVQzdxecUZvivabtuETE19zW/5+PTRWJxzO9+e6w1qX9ZHI
	UUh32ORlIK1W4QjFjidI52N2g6PwvnsiXMpP3g2X8NAet526CL9X2va7uBUZmzrrgeEFFgU++ls
	vOIGoi1yjgx9vjkrGiUqfX7NC48oEY5wCog2SUET/COx/2jSGRGi/I0Bgr1W5PkHOFxtkXDgfoi
	VB2WMp3VNfdwGEgaSWkqRwjq59SnwxCYBjcOM24PvOOZxtoHeitqoEHjteCQKMubmeGzziX3cFF
	SAdOeixKbbyzJW8xPkvruik4DT5CfJaatFDBAjUjBigY09VCkZxEM6/bv0zx43zPl2EZ2O711Ua
	j3UIElDC7w34=
X-Received: by 2002:a17:907:7282:b0:c40:eb1a:4c8b with SMTP id a640c23a62f3a-c4d35485055mr439589266b.29.1794070375728;
        Sat, 07 Nov 2026 08:52:55 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356eae34sm160787966b.85.2026.11.07.08.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:52:55 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Giuseppe Scrivano <giuseppe@scrivano.org>,
	linux-unionfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ovl: fix leak of lowerdata redirect on ovl_get_inode() failure
Date: Sat,  7 Nov 2026 17:52:53 +0100
Message-ID: <20261107165254.3989119-1-amir73il@gmail.com>
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

ovl_lookup_layers() moves d->redirect into oip.lowerdata_redirect and
clears d->redirect before calling ovl_get_inode().  When ovl_get_inode()
fails, it does not free oip.lowerdata_redirect, and ovl_lookup() frees
the already cleared d->redirect, so the lowerdata redirect string is
leaked.

Clear d->redirect only after ovl_get_inode() has succeeded, like
d->upperredirect, so that ovl_lookup() frees it on failure.

Fixes: 2b21da920866 ("ovl: prepare to store lowerdata redirect for lazy lowerdata lookup")
Closes: https://sashiko.dev/#/bug/linux-dabbd363-9c71-4915-af72-e2b5e75fa58e
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/namei.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index a27479a100275..e25858c8dbcd7 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1366,15 +1366,16 @@ static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data
 		};
 
 		/* Store lowerdata redirect for lazy lookup */
-		if (ctx->ctr > 1 && !d->is_dir && !ctx->stack[ctx->ctr - 1].dentry) {
+		if (ctx->ctr > 1 && !d->is_dir && !ctx->stack[ctx->ctr - 1].dentry)
 			oip.lowerdata_redirect = d->redirect;
-			d->redirect = NULL;
-		}
 
 		inode = ovl_get_inode(dentry->d_sb, &oip);
 		if (IS_ERR(inode))
 			return PTR_ERR(inode);
 
+		if (oip.lowerdata_redirect)
+			d->redirect = NULL;
+
 		ctx->inode = inode;
 		if (ctx->upperdentry && !uppermetacopy)
 			ovl_set_flag(OVL_UPPERDATA, ctx->inode);
-- 
2.56.0

