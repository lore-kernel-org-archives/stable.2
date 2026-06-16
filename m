Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1562C3370EA
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622323; cv=none; b=NtfFILo5957ltnNqSdERmi0DDBV27PfDE3R+aCu3sTFa9IwL1sZPQmgJzM8hMcxQ+X+kwp11nvVO+ibv6X8+GsmDUuzlHa4PZY39m3OcvXRG8GjDqPl4xKTqPkR6rH/UikiDgamhkvC6neyiCyY8VeLH9+MQAhAWGoMaI2iYC5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622323; c=relaxed/simple;
	bh=JEOLSZ1AJjN3AaMIcahaAX2ySPe5GUtyp0G050zEmnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0CLm+33Okxnx2JgxwLUOogQzNksJ8RZwqCv3jIUQwCj7ZLV4UQengAy3bMgQJCOFJ5QTnGkVzIWUGYKfyj0s4cz9TGzWijBIMrusNQmduSIGatVIfw8pPpWF/SBgs32Ag8EKYShUyvjyg0ckP50gN4DpuF9SXvvJ30oGTuOejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tila2W1D; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tila2W1D"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-397e391cb2aso41485831fa.2
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 08:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781622320; x=1782227120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jlLTtSeNFufiChT+v/pvFzDbVk/DIrJgt+8tFHA9RhY=;
        b=Tila2W1DvzRJTB55xcM7xlq7CKDppjw4hpXFEaBXHT9uf98i8qdTTNP69YXA1a29jb
         WVPB6+gdx3upwTaS29XSLMNWqChtMk4InK/wxyyo47Bb7Hb7AP/MCajHY/Ubq/+2clmQ
         lBgpdkt0TQiJThQ5yHYuXTSd+4l06tEypP7QEJH7+fU/uiqjGZHUprHNZAALN7PIX/cv
         8MWqIwSOaoWhrXmwWwt+w5pVEEdV7HiJqEFmJyLrxBcUx8EcclVAnk78qu0MXLI9QUmo
         5EYBx1ZTVgwBQptMiUHcXSps2OdpoVgC+VKje/U/bTazT7n43/qUljzf+JtyP2VYMN8V
         Rrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781622320; x=1782227120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlLTtSeNFufiChT+v/pvFzDbVk/DIrJgt+8tFHA9RhY=;
        b=Z6Q+2ZrcghJ9ofOUbBw9d8ZQUHBVL36cuzGRj4Q2OYhq0JNL4RaGqoSsboD+B4B8ug
         ekXD4d5OHgnwLZh1s5Befg6bY/MRxjnihx/mEVFs3JzXS3+78eCF4WREAVd2ggdaiAzO
         9ab2xnzkLUaz3u97JnUEQNuoUdNRxau53+XxtdSlaIAPXt1SHF0XGP7HlJH3cEHmJZhf
         6weOYMp7hPAyJk3jhAYKF9eEFnKD+DsnXUWEh7wlVivTPDgJw14KS+Wm2c1ppSNZL12D
         0shrA+Yc+SNDni1lDNtHmT6nD5dy+EE3NHNpElcFtUUM0p0kyKgDe7cF25eSjLgH2JsI
         S9dA==
X-Gm-Message-State: AOJu0YwsiC9epLcck1ojxI+G+3wnjA+yAs5UPrNRFQ1qVGiirSGDduQt
	UHKvxB4mXclBE07Ntvj9nwfnJktf5YZYTPHi2UxM6OMm2003pXoao4R04IgiFcYrtJw=
X-Gm-Gg: Acq92OGgpjOe4TsYziHvUsvYRecrV3einxPFADXvAc91I9bbqKnZczGA1DQG41mCKIe
	RPIn+tS6UgVsb6H4jptd55s11egy2fOVHqQDAtWOz4avNitU55t1KowRiVHCur+I+3rU/qj6hlv
	lDHlFVqXV9G5z4hTFgKTJjkmaaWtrYic99M8Sjlsztou+5gHXgM7dfRaJjOrL72Wh/OjZNwHiB2
	r0hSfL0qUdrwewjMHp2+35SeVgG4+7pfpuD+KndzQO8pyxdXSgadVSEhTpNpRfNXBobOopGRrFM
	yE4mOrGjEf5Hu5z0Eqm95dFjT8IDbC+qOPx6zN9nmm74tPpcjyamEDgK5NrSAdPjKU6zgzeB9Ts
	V86RN3lHNXi5HLsjL8xHVhez5DryAYZdixd7uTt4hLpMwen3eXH3hZ6BBdsJAyVR3aEVJC4IZ4E
	pL+LcuUUd77bMZ7QGMZr3kJLsTWoTGMxKikAA3lpEDkluY0BqF8vDVJnwV5S8zRIlz4O8=
X-Received: by 2002:a2e:bba5:0:b0:38e:83a6:d37 with SMTP id 38308e7fff4ca-3993ef57664mr24550401fa.13.1781622319750;
        Tue, 16 Jun 2026 08:05:19 -0700 (PDT)
Received: from cherrypc.astra-academy.ru (109-252-17-231.nat.spd-mgts.ru. [109.252.17.231])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3995c191cd8sm7765001fa.20.2026.06.16.08.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:05:19 -0700 (PDT)
From: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Christine Caulfield <ccaulfie@redhat.com>,
	cluster-devel@redhat.com,
	lvc-project@linuxtesting.org,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1/6.6/6.12] dlm: prevent NPD when writing a positive value to event_done
Date: Tue, 16 Jun 2026 18:05:34 +0300
Message-ID: <20260616150535.810849-1-nazarkalashnikov0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

commit 8e2bad543eca5c25cd02cbc63d72557934d45f13 upstream.

do_uevent returns the value written to event_done. In case it is a
positive value, new_lockspace would undo all the work, and lockspace
would not be set. __dlm_new_lockspace, however, would treat that
positive value as a success due to commit 8511a2728ab8 ("dlm: fix use
count with multiple joins").

Down the line, device_create_lockspace would pass that NULL lockspace to
dlm_find_lockspace_local, leading to a NULL pointer dereference.

Treating such positive values as successes prevents the problem. Given
this has been broken for so long, this is unlikely to break userspace
expectations.

Fixes: 8511a2728ab8 ("dlm: fix use count with multiple joins")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
---
Backport fix for CVE-2025-23131
 fs/dlm/lockspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 7b4b6977dcd6..ee11a70def92 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -576,7 +576,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	   lockspace to start running (via sysfs) in dlm_ls_start(). */
 
 	error = do_uevent(ls, 1);
-	if (error)
+	if (error < 0)
 		goto out_recoverd;
 
 	/* wait until recovery is successful or failed */
-- 
2.47.3
