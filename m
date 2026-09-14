Received: from mail-lr2-f4.google.com (mail-lr2-f4.google.com [74.125.230.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B523D411A
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372602; cv=none; b=Z2twcYCp4Q+Po+Kpodvzpe8QiwExWwSgNKnfInk6MeLjlvgOijk+jeuGap80KPHh+LqvdGCbiAKU9JyG0kOF2S8hgPg2JpVDwyEwl2W14BXGLUjYrr7+R9axqmnYnpnnzZPM/9OKGfOJD/Ku0M9xfhK0LEFymT0e/BLidHPMeag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372602; c=relaxed/simple;
	bh=YA/Zt5Rp3A+cv1udmI30pynM10rZrp/ZOB5JXnp18OI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFmcHDCyP4IC3EyIu2W2X+DJJaaDAYpukaV3vx4DbCE0qABj5JYBfDZ8QIZz1tRbXfGtlG/9IgvEo4rP2vOtKyuJ4PDneHj7uMH14wYvTS9kEDEVc1oS2feSEiuZy2Iubq9+QhePsnF2hDZ53/qGTgJ5NTC51EqXecBYqk1jrrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNLIjZOA; arc=none smtp.client-ip=74.125.230.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNLIjZOA"
Received: by mail-lr2-f4.google.com with SMTP id 38308e7fff4ca-3a49bfe419aso18371991fa.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 00:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789372598; x=1789977398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4SXkJ61xh36bbhjQO3MwznVY3pjw6v2KKNzzDKE9IK4=;
        b=tNLIjZOAhhx7LnwZ8WXXw8zGUA4ITwBbS3XntzmrTulikKKtWFCi+kqbxz4jdNheFI
         8o72cSVGde9gDYASAGIpjf1sI5M3ekiM+OPohDYo7YQOYbBwd+rxmtYetld4XK1nt9lZ
         d50lUH3FuYtWHNyauwYcF2405D0Ukq/3ltGetcjt5bqscDcMnkwkumwhHe+RzSeOgLC6
         CnjqKPL3Byvh3wD24Wqu4KzKhEK7ms6oPGMJ4aBdSQYvLcQ40GucAgkFq5HIvMSqSIuA
         bsvSHaxB+BWe20Wde8EG3veecIDUvcvSLzDKDEHmYYDXDjPQ4KAUNcWzAF8j/Hxt53dy
         /GSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789372598; x=1789977398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4SXkJ61xh36bbhjQO3MwznVY3pjw6v2KKNzzDKE9IK4=;
        b=CZykHT8UZ8O/yJHd2WTDvJZpvB8Wt4RlnXNcY/DXCxMK+zFkjZrBzCABzx4EDfkrXv
         /Xahz2/LjWSDwQyqN2KH4yWAI+vcsUVNQbkwMF2G7p8xKvmjelM0iDHUdOkAREknqPVV
         gIduQVa2h0wcMe6GdkYiOcpyricV95jg4w9qHHFdHmr0CHSt2An9xLpFuYYxkLWeT6fO
         v++tluIqPTvo8liBlOmELOvEDFDFbLlOp0GU6s/tVsR4squct0rHwkc8KRq8h+ZpYywI
         OhCyCSgJxm1CiyQt4UL+MhUNuLi1ZUTEs84bd3VP6amn3S+O8ynQk71U3qCQZZC+VYNR
         t8Dg==
X-Gm-Message-State: AFuF++klCR3SYjprzNwYvtRdnJTEF14qnQHMwrlNfemzEo/CGvPo/SX7
	VK0KJkjxNnjOHKO8/Fv9gYeg1iO4Q4sj7IQRf95zNC/vk2tuvv811qDIap8/Ljgc/Ug=
X-Gm-Gg: AYBFou1/qNFxX205X+oOWTw6wFReTB2ueX76AttM1z3tyQ5fe86jCsccu4YTfBGnCMQ
	oB3X7rJ3CWamiiJ1w/RlpoSG2vO45nolav52zGame9yBU1j4olUnurcQRxq+/6TYVvOC2rqqs/0
	rVsmTZqhHekmYK90PpFzleSWuX0//Um6Ul7+x3DyeKks3AFx8FpGrUdUATsdDTftSmWXHSvc+Ht
	9BFDiMBIvM7+AUoYYWF85oY1IV8x7izHWvfvxyjJfdKGjsEQU8DKKv978u/YscRqYGwlMp6yFs1
	dr9Y/lAcRBN0OMU/i65CjUveQRIcGup5VG+tek5NKDognnLwrR1hWFsZv8i6yXp4I5W/57RcL/o
	qXPJrYkLozBgj9cd7OccYNKdiuzk7s8SOzyeoZ9ItYlza2s3wOhzxBZMnIKT8pY8qYWZvWDDEC5
	5nXQDtQMxv44nd5VZLSozFL83GUJRcsRj7jqtolhf5hw1RlGB4qZdm+8fFTa8o9dhRVfC7diS2k
	f0X+rRtxWr4mO1BDLO80hN8b++0
X-Received: by 2002:a05:6512:1241:b0:5b4:ac27:6bb0 with SMTP id 2adb3069b0e04-5b8ae6b89famr713138e87.25.1789372597734;
        Mon, 14 Sep 2026 00:56:37 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a047113esm2231327e87.55.2026.09.14.00.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:56:37 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	ceph-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH 5.10] libceph: Reject monmaps advertising zero monitors
Date: Mon, 14 Sep 2026 10:56:19 +0300
Message-ID: <20260914075620.11202-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>

commit 40480eee361ed9676b3f844d532ac28b47251634 upstream.

A message of type CEPH_MSG_MON_MAP contains a monmap that is sent from a
monitor to the client. This monmap contains information about the
existing monitors in the cluster. Currently, a monmap indicating that
there are zero monitors in the cluster is treated as valid. However, it
is impossible to have zero monitors in the cluster and still receive a
valid monmap from a monitor. Therefore, such a monmap must be corrupted
and should be treated as invalid. Furthermore, a monmap with a monitor
count of zero can subsequently crash the client when attempting to open
a session with a monitor in __open_session(). This happens because the
"BUG_ON(monc->monmap->num_mon < 1)" assertion in pick_new_mon() is
triggered.

This patch extends a check in ceph_monmap_decode() to also reject
arriving mon_maps with num_mon == 0 rather than only with
num_mon > CEPH_MAX_MON.

[ idryomov: drop "log output for unusual values of num_mon" part ]

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-68155

 net/ceph/mon_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index e1f01aef263e..fac52fe7a587 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -59,7 +59,7 @@ static struct ceph_monmap *ceph_monmap_decode(void *p, void *end)
 
 	num_mon = ceph_decode_32(&p);
 
-	if (num_mon > CEPH_MAX_MON)
+	if (num_mon == 0 || num_mon > CEPH_MAX_MON)
 		goto bad;
 	m = kmalloc(struct_size(m, mon_inst, num_mon), GFP_NOFS);
 	if (m == NULL)
-- 
2.53.0

