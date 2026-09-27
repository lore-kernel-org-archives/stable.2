Received: from mail-dy2-f40.google.com (mail-dy2-f40.google.com [74.125.229.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1BC286D5D
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790490815; cv=none; b=fsDRvL3y/i4ZQBKNWJ0BAonMxPK996gAMqZiSBkFHsbTlj8tFB09Ud7A62dE80WZ/ebkVNN59Jv7z+9j9opE9c9lZSPiNdpJ51aL0VGfhBInBtyD+74P2/No7+awKrI8LoIChuXZo8xHUQwy2QZw1giWx3XeSHC8+TcbgUWC9H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790490815; c=relaxed/simple;
	bh=yKYsbQaSNbfxpL9AXn+Dk6w0376LevsziE0CM3vXnRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=slv6n+xA9Y0oWLBY55wpT2cuWBS6rxLMROjaYTXqn+4Yu6wFvUA+ZvbGc5FUEwYqlqcndfmjU8uhsGzo1WIoTzuTXTbFsfdZ1smBCKck0KgDaFCXryemlRC/NVw4Cl3ytEJ1IXBOvyp6Ri6UDFtIYsUKJKet72gR01Q2WyosLy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqE3RrHY; arc=none smtp.client-ip=74.125.229.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqE3RrHY"
Received: by mail-dy2-f40.google.com with SMTP id 5a478bee46e88-34346932d93so572803eec.3
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 23:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790490813; x=1791095613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x5E4VrjMKmWAeZuEbOPf8+lhLbvIn9eYFgM5VNzNGZ4=;
        b=RqE3RrHY0nfrON53eX4dfaviV1sAWkM2AgoLGS3jUiIQVapqUCBnPeHDgAz/augpbj
         z3KakUavc2Bt7BYKFP5idn/Wo/hdl1MFzSpu7Tm2vVqvElB+TpjbFkGVzwLTkYe3h7ug
         B+NAaiBrfC/3irNEYIALjWVzoWjLFg/P7NoWo4585j+4fyPMzhbah5Ld1SbMTILDGmwG
         CmBXAisDO42G9LbnxTY+CkZCrz4Qgq5cIkGbnoUNNI1amnMtGvXrEq8dfEUg/TskmEr8
         kc7N9RyNfIXbdnDR9+JyYnAAHNAeumWZtL9J4aPO+PgH1r+FVA/NqQaSxqe+y413joUX
         rS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790490813; x=1791095613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x5E4VrjMKmWAeZuEbOPf8+lhLbvIn9eYFgM5VNzNGZ4=;
        b=CaZIFB0Gm6rvUuQQZm+w5I6Tx9yGOnzNWPNWUtc9u/4BVBl0l6tPWMbjUC9Jv3qWRG
         Ay5GU0yyJ7Du4TWJQ/BldbbmuKV45EjlK+4TjtxHeQHzT/AECKBWDsTuv1p+D0YkZ3tD
         m9bpaWg1pHG4mKNQzxwAjd2uPtllJLwxcl1NSNfU23sixLlW3LkBaxyiSSoXn9fONupi
         860E325njARE/KF+b8/dtvh2xZ39jP1grJbNIV7skSpZDN8Qn0hAurKdUcseGc5DwscW
         /uIMYEiMCwYekpuHIb191Pqq5Z/UWe5tnwD7vcS/2GUOZ0azC1xlvDZmKiEY6ro2kmIy
         mMiQ==
X-Gm-Message-State: AFq9FYJIK4Nuy7SPxgN7UgGgLbptIJ7uPSZ1LNfBh+08MqoUoeUXd8sa
	19Fooykje76ED8NevHWsfdfF0SLeoEVphPpwAh85WVpbo4DubE4567QP8Zhqp5Z++kbKvg==
X-Gm-Gg: AYBFou0ZbYQQY38TZcAfwvR9e4Ib11td6r18EOklJB4hBNWBKPfuMFhONNP5nXUitOT
	jAtDtPN08SgUk/lwNuFC82ftggC2XUiISjceNZ2VNI0W637XuHqet7Km9wdMAKX5Zbi3jsqcM7l
	Tlf4HWdL8Vl+o2w+670Co3mPIOSWKQdh/MItTTwOTvXFc+ptdPsdIpcOPaqTDTA8U/OrG+jUizu
	x2c4jzAL/sv68hOAVGf5ZvB0ady03fNzL1nX0Fzz0rD1bIWB6LvnnuMI7/dpzyfHmnyr42G9RK/
	bfQ3cjLYcWxSaNqYG+HFN3+2P3KjYy6fZN/aVhWlo/9xovLvr/zItf6Wsia5R+sA787Ocef/P43
	KkDVf/WZpCLZ8iBajGCImgUSOBuQByXJIYoJaiKr7O1fVO/LxYuZ/+GUHVB3LeM613unf83N/sV
	tHJ7fh6iAbjnEmGVOaVqWkCuMRLuL6htRlociDURka07V9kWHw2ptWcAk1th+Q0gDVAw==
X-Received: by 2002:a05:7300:cc1b:b0:327:e68e:3230 with SMTP id 5a478bee46e88-342702c203bmr6885721eec.10.1790490811988;
        Sat, 26 Sep 2026 23:33:31 -0700 (PDT)
Received: from localhost ([8.219.88.255])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm15335289eec.10.2026.09.26.23.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 23:33:31 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: zhangdairui@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] ksmbd: fix OOB read in ksmbd_validate_name_reconnect()
Date: Sun, 27 Sep 2026 14:33:27 +0800
Message-ID: <20260927063327.1731027-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ksmbd_validate_name_reconnect() indexes
ab_pathname[share->path_sz + 1] without checking that the path is
longer than share->path_sz + 1 (d_path() fills the buffer from the
end). A durable fp is not bound to its original share, so a client
can preserve a file from a short-path share and reconnect it on a
long-path share, making strcmp() read past the PATH_MAX buffer -
with a long enough share path this oopses the kernel, and on a
mapped page it also gives a byte-equality oracle on adjacent heap
(the reconnect succeeds exactly when the out-of-bounds string
equals the requested name). A same-share variant with the durable
fp at the share root reads 1 byte past the buffer
(strlen(ab_pathname) == share->path_sz).

Check the prefix before indexing: the path must be longer than
share->path_sz and the next character must be '/'. The comparison
for the valid case is unchanged.

Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
Reported-by: Dairui Zhang <zhangdairui@gmail.com>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
---
 fs/smb/server/vfs_cache.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 293dab9..52e83cf 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -1714,9 +1714,13 @@ int ksmbd_validate_name_reconnect(struct ksmbd_share_config *share,
 		return -EACCES;
 	}
 
-	if (name && strcmp(&ab_pathname[share->path_sz + 1], name)) {
-		ksmbd_debug(SMB, "invalid name reconnect %s\n", name);
-		ret = -EINVAL;
+	if (name) {
+		if (strlen(ab_pathname) <= share->path_sz ||
+		    ab_pathname[share->path_sz] != '/' ||
+		    strcmp(&ab_pathname[share->path_sz + 1], name)) {
+			ksmbd_debug(SMB, "invalid name reconnect %s\n", name);
+			ret = -EINVAL;
+		}
 	}
 
 	kfree(pathname);
-- 
2.53.0

