Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4313AA2D
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507330; cv=none; b=s3YDIDrPJAgqNPH4+D+dR9/XpqzN2EbwpGz4Xx2f1c0EZdAY70hOdu8toBazsIBIpSJndjR9uVeCLgpOmdPErAMXdc6pmh01gXdOG7I4omEC/oA3y+gCccGjbvzDjJEYolAs5IhKCOZSkS6qWMADcYTJ2WiHqWPLDnEPNCM0waY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507330; c=relaxed/simple;
	bh=iQF7hJNJk+tciyr9gn3y0cpmKsX0IRNeaeqs117CoSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBQ8RdRlKf2o7qjNCVN7jEfcP6HF6uCmxF/XDQ8lwA464yhvWVoEPcM9i3s+7nNP7Z3rAtjAKbqaNB3pokIfCILQ3vl0jdfYMxfCNq2oxogdRAoLfsMJZ+dm+4zZtCx/W56tL0u+nusgLzkGD+ttVxcqqMIzxAtGhdlxzkZbzDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdMCbXvb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdMCbXvb"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8422f148dfcso1671337b3a.3
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 00:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781507328; x=1782112128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yT8jWg5NzpuSwRWNDYbiJQTjHbBgkK+4u7KVBRK2HB4=;
        b=sdMCbXvbqv8MWCL8UcGix9EEAyGk2jhOhUpTViugGo1YZRtHN7+SMbSrswiE2Rlhfw
         +3K/gcua/pk+VSCgzEiQiYl5M+MwtMGPmiciP2CB02IiKlB+Wh6MXLtTiPwUx9ojIoHq
         UQ2nngTWnBfr/FWgVHRSPgy5PM4xYls3NwXAWR8PRua4ONBLptG5QbDXHgDPwNismxNu
         Lmi30Q6yDzKfzc9P5a4iPAQgTaFZCBrGfCKcPJag5Gb8NmOmr7Tn589SxR2ZBg1+vPCS
         MjfItbudz2MGi2kSrKKN6V4o7exn7OoZv3JQs4EVIF4hbYJOhp3DpGjY8ASYroj5BTnF
         O7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781507328; x=1782112128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT8jWg5NzpuSwRWNDYbiJQTjHbBgkK+4u7KVBRK2HB4=;
        b=d6MvWvc0U4N/iwlKlhTqMVu+xx6gXoVAyYRhRUUzdFc9bf0ebRCoNTV9Uv1D2Patce
         OjJ9f5FgUfoAOux5epHx+yZmah63zxk0edsykRekMDpOC5HRMNP4kBmpb6i0yN3KwMLw
         3MOTLkX88o0/r5Fnd1stVfp8jwqdNuiaObBPztt6RuCHBt2kfFzxqfouFnfomEBnfuy2
         YOc/t0qra4QQzRA7qWiCtTYGLmNmpdy5B3u/2rRmz47cZDo4IBAHLr6cjd8z7DhAyctE
         zb6OTzWmXqI0YmMqpRg+gp9hlKXxLPvA2Au4awo6/8qCAT32Lhs82q7kgKV3y3eRHmCH
         nWig==
X-Forwarded-Encrypted: i=1; AFNElJ96SoXWpEp6tTomx6StW9+tW+lVZfr7ggEvuxPQJkmT0zOamW088nspPNFIea2JGMuFE0w2OeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpV6/efVwVrHYbjIfv/huvIvrz1GBkpaXuc7JZ1EQ34/LKwwuc
	WJZ9GQkAVQa18sOYUbDwSwHyAevT8fbBCHk/utvI7UDMpP9mKVt+0eemLHg3ig==
X-Gm-Gg: Acq92OH6CAWEuNZ0j7pFifLAi6JrG1M0KNXaiswej5SSJmhNPAvkYVx52d7jlWCBOYU
	+/Bnw5yslP7NeWPJhkAN6B5PMNsUzawtLsCb4IlG5Dojb7JQys/VBseuj0Gk65DDTrTGOa9Z2Sj
	Q/WO5+vpN28rtqT3za8XYhWtmR4qFXJHyasncZlovPyvwdh+zgMeiO8ghKqAEYplhIgD8QpObf/
	mcx10HxOvaPPlhphZ6HYVpf1CRdkIvweQigLVjIE0UMJyztl7qxanULQsZArWVhgDhkYaHZ7wiM
	3dSF9NZwyOV661vO8slGS+CpAyjfHI8VfoLtwymUOURBDDtH0v0WZ+v+h5sYcF/E3aFsx0OXdPy
	P2HTmqRcjQg/rH720b4Ll7gnAxNSZSmsayO/JnI/Sw/3apc6RtPEnY7WUgiUtGqT1ICs0+qR4qF
	JspZbZW8dOGoW7ZOFKXVKcyT1uzwo4FXEsAuzVRf9NNx1U9YQdYQ==
X-Received: by 2002:a05:6a00:2e13:b0:835:3949:3c22 with SMTP id d2e1a72fcca58-8434cf17aabmr13460571b3a.27.1781507328143;
        Mon, 15 Jun 2026 00:08:48 -0700 (PDT)
Received: from localhost.localdomain ([59.27.24.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b009e67sm10661316b3a.42.2026.06.15.00.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:08:47 -0700 (PDT)
From: James Kim <james010kim@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: mporter@kernel.crashing.org,
	alex.bou9@gmail.com,
	dan.carpenter@linaro.org,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	James Kim <james010kim@gmail.com>
Subject: [PATCH v2] rapidio: mport_cdev: fix use-after-free in dma_req_free()
Date: Mon, 15 Jun 2026 16:05:30 +0900
Message-ID: <20260615070530.371640-1-james010kim@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_req_free() drops the mapping reference under buf_mutex and then
dereferences req->map again to unlock the mutex.

If kref_put() drops the last reference, mport_release_mapping() frees
the mapping, and the subsequent mutex_unlock() dereferences a freed
object. This is a use-after-free.

Fix this by caching map and md before kref_put() and using the cached
md for mutex unlocking.

Fixes: 4b0986a36 ("rapidio: add mport character device support")
Cc: stable@vger.kernel.org
Signed-off-by: James Kim <james010kim@gmail.com>
---
Changes since v1:
- Rebased on v7.1.
- Add Dan Carpenter to Cc for lifetime and use-after-free review.
- No functional changes.

 drivers/rapidio/devices/rio_mport_cdev.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 009b3b595bbf..9b94c9b2fad0 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -564,9 +564,14 @@ static void dma_req_free(struct kref *ref)
 	}
 
 	if (req->map) {
-		mutex_lock(&req->map->md->buf_mutex);
-		kref_put(&req->map->ref, mport_release_mapping);
-		mutex_unlock(&req->map->md->buf_mutex);
+		struct rio_mport_mapping *map = req->map;
+		struct mport_dev *md = map->md;
+
+		mutex_lock(&md->buf_mutex);
+		kref_put(&map->ref, mport_release_mapping);
+		mutex_unlock(&md->buf_mutex);
+
+		req->map = NULL;
 	}
 
 	kref_put(&priv->dma_ref, mport_release_dma);
-- 
2.43.0

