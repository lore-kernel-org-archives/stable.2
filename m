Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6AB3E9588
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781785149; cv=none; b=kzjehqXRGXvihvHLcVjc70ghWJ+FCClys3/rKCUt2cQTySheShY08U4ILxM3Iv+tTO6wMZi7/onXDHvY/ORF2yh60M+EHAwcx9lfUp0qKnGgdA71lLkj52Gr2OAqqXhNhfXUz3u2MzM62q/1KisQAOwCg0jPEQC/+d9VzQ4Xue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781785149; c=relaxed/simple;
	bh=1h85HEiwu5SrvP6LXSFmCX8HYJCZmpF9jCx93UjL+R4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQGKMxmQyqkc+YOe/Kgc3ImcDuRFzzL4KSbgYZfCm76Q0OgF9q1Xig/ZvYXjGN/Lb34QPfzfaub2HkCw+eqBCbEGFVAj5OkIeLBi5C12ACtPgV64ilTJ8GPjqA1g06pLCJWzyzo7YMdSOJwMdyhnvUy7HQiZ9oYB9Wyb6tZBNmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8Mri2I0; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8Mri2I0"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa6792e7b8so989845e87.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781785145; x=1782389945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UqmSWHmzTjiXv/ea7OlEQSmT2M86q0mo+1Enkd+tLH4=;
        b=Z8Mri2I03uhCf8ZQU9bkmM3N7GPUTMl+4ZjPcsDsqcCmbkD7GJ5iQfCLQ0uxyOGklx
         nBDEYg0NEV/V6LOs2lO21+S1RQr2Pv799svKwZvOPke+3yjE0pATWAW6w2u8sLQ8V2yt
         Av/YJO7vXd30SByDTBmEtEoT8g9bEd7TmHgzBrVDLZwujwPBGYsbfDnmoLUxOqy1YPAV
         xxOoIkDZy/H/unUv97wFzSRKOpaG8Yyt3yB03HJZivotuBiZlKYJYFxW891/VudVxd2P
         O+SJCTAg6nVu7bUcGagB99IEzkNC18TDp0kUP6vTiPSVC+tGa8s9+VVzdRuf51KklwHv
         qDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781785145; x=1782389945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqmSWHmzTjiXv/ea7OlEQSmT2M86q0mo+1Enkd+tLH4=;
        b=b1jjYD0OUwK7c4SXzc6GTL7a5smRFxoxTtSnUbMP9jqBNOYGNpcm8fcM0vDV7DHEzl
         5Zf0QVhEEti04BdTH2XzI/hbBq/58EB2hm6c396QV4DmNPst+g1AqShF7lJUjJl4J+jP
         PrJSpBSHJ+dHOiwq+2xpHlm4B4BXsmetTgbHq5+D8CX4kGiu8RXF65Lbh4LgwcynViEw
         HPVH8ReQljUWtrn5W9aOotrg1zpjEOR/zk4j4Z2kSl++Frnq7fqR5nO2bseCFK8IRqpj
         42JAZWTbU7V63yIHQPM9E+wydQg3L7ZKLRfgcTq2SIZx5HU3XMvBbpBm2H32tcwNf8GG
         6FhA==
X-Gm-Message-State: AOJu0YzraduQDmyRzoBuCa12d2bZkhB6gtx34PnhzalvIgXgXiunSRcy
	7w5xCUSuJ3ZPj2AIVmIluAxLXIacNupaWegBjT7ovJA4PWRYASge4AlEY2D9n4jCtr0=
X-Gm-Gg: AfdE7ckMvc5KMaseFX0whvA+Nj/MbTyE43uuUZnwSkAF0n6SCUo9P7xb0L6e9IK5Tdl
	pOYMHJDn1e74fBpdEyp7uQqj4Q872t9YgfGK4qp9iDNRo3tEJyv3ek+A6FI/rLGyk0mKMGqdaal
	Xrmm9faxnWsiOwLrY8ZxLiH77zWK3W3bqFxcu57dobmgjirVif/pzsSUmqNnpdTH95gZU9EbcGZ
	atkLixsJ6IIAb+JVWmD8N+GeiEdBXYl1p0ckpcioZSHpBnu8ch2VSsO5RMYsSU2l8+qsManNMrD
	no0wC3Uy8Aure3pTcMB5KWa50OzqLPIJb04iZ8zHJgKvPoF63vyS05phXlXPmcvxANrho0kERU0
	G4Aw25B07e6nROqoOUjGS+o6oVdKfZVP7CACvbXYLbcFcKNqjl3Sk/sfyVIVZI/WUQ7vGZGKLH8
	vGLIiOVsZVn2c4wMnxq3Qp3qi5AAo7hg==
X-Received: by 2002:a05:6512:3509:b0:5ad:3035:fa47 with SMTP id 2adb3069b0e04-5ad4dadd259mr879893e87.53.1781785144944;
        Thu, 18 Jun 2026 05:19:04 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad4eb57734sm657424e87.34.2026.06.18.05.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:19:04 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Eric Van Hensbergen <ericvh@gmail.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	v9fs-developer@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	lvc-project@linuxtesting.org,
	Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH 5.10] net: 9p: fix refcount leak in p9_read_work() error handling
Date: Thu, 18 Jun 2026 15:19:21 +0000
Message-ID: <20260618151940.76321-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hangyu Hua <hbh25y@gmail.com>

commit 4ac7573e1f9333073fa8d303acc941c9b7ab7f61 upstream.

p9_req_put need to be called when m->rreq->rc.sdata is NULL to avoid
temporary refcount leak.

Link: https://lkml.kernel.org/r/20220712104438.30800-1-hbh25y@gmail.com
Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
[Dominique: commit wording adjustments, p9_req_put argument fixes for rebase]
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
[Alexander: this branch doesn't contain 8b11ff098af4 ("9p: Add client parameter
 to p9_req_put()"), therefore the parameter is removed from the added line]
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2022-50114
 net/9p/trans_fd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 40d458c438df..bd6a54e6f427 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -346,6 +346,7 @@ static void p9_read_work(struct work_struct *work)
 			p9_debug(P9_DEBUG_ERROR,
 				 "No recv fcall for tag %d (req %p), disconnecting!\n",
 				 m->rc.tag, m->rreq);
+			p9_req_put(m->rreq);
 			m->rreq = NULL;
 			err = -EIO;
 			goto error;
-- 
2.47.3
