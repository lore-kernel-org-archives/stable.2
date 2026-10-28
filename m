Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179967;
	b=DebGr4ISz5Pr1w2CNYnuK2QLMr4sR+Tee8cXTpe1gmcnij30yVWp0BnsujH16Wf4c8jy
	 5Cji1o4NnCyL2L/cIDfqtdHN5Zrgbl3TtPvglqmU77qaWAEGYQyoZRvw+OXpo6aP5eb/w
	 in1DiroI8m4lgHLGxQQ3dOPet14AdmuXhMWz4CsAIXRFg5cYP2/ZtUlJLJaq3NHTc2eD3
	 11RtSJnIYaFzlO3xCETTo5shRzCzbh5b0VDe/LdmcdHeAxVoBE+ALW6nBeORVOUzEtcFY
	 ewL0XBZoFL7tpHJH45HAwOg2wJx4JpnGILWkoupGjr+C15T+FJkGZvfud/RTm/x5o5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=StDbYCLf8QBugxMgigmlPKTKpnDxInqQmLIcu1D2CBg=;
	b=o/t0cFoTrWvxt6FYAKyhAsLe8Njw4jz9VkuKbhlaP89SDVqUuusDO2LdSnjDGxHeqMkz
	 ZIj8SwZb/PK/S0lPl6OYfO9nr6dYWVer7NbAXk8Tu+HDaM8oAHSVO5OwaORUB26FyHOmc
	 5u8Nj7lL1uIVzQt7pRjDf9swatM7ZgaLvd8JEjHRY4oZvEsYvkrjUcNcGbxuudBDIbpEv
	 PKVjUjQTvdQGQxMb8IJxiQ19I2NsaidPXGBS2j6zV1K3T4lMnKwccx9GR9hGPdfGpNkCo
	 Di+iRLcML/wEQHnxnKp6kRdLw+X/+7nfX+2YDcqBN8OuuOYZxO+cd7VFBOsehMP88EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jNMmzGPg;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77935606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77935606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jNMmzGPg
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso362049a12.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793179966; x=1793784766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=StDbYCLf8QBugxMgigmlPKTKpnDxInqQmLIcu1D2CBg=;
        b=jNMmzGPgjH4o9HBjKn3hoj12sxQLQmLlEeNXkCtGs0eg8QOS5Lrrk7EFqg16A33qQ0
         i6Fx1eoey5dSOzUkjYl1kpGMtgtKXXP5mZP5NJAD3cdFGDpxm/L4mkhm9c3YEgevXC96
         FTtFIwyKFeiM9MHqerHEtG+Ph8KKWiY42FTqdyCmh1HQKcG1lBFMUOISoWoZ8JIQx2ey
         ZokQXMY7ixyQUH2LXig2mB2DLW0LSFPePQ+ApqSeTUmXN8Ym8UJmcnnzGn23PlvtZKe2
         /CcCAyF1+NisUcpchb4Wzui4PQxMv7WSnGKRDp2W/OctEJmMl+GmwdQ1e0lPjE2F18bn
         rV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793179966; x=1793784766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=StDbYCLf8QBugxMgigmlPKTKpnDxInqQmLIcu1D2CBg=;
        b=yFmi1S2VyxUlt8TrPIkIqQPi0soWGffB8KIxvOAA093414G5FqJqtwkxkbBhGOIXXd
         A/zA17GnmR9F35YzfUrFzHfcZQlRHB7BCVkA24Qa9StdNjMqacsL30OL8uWNpVkaWlVu
         DnSGmLRq+6oolNHGGNJeRB1LTu2AZET5uC04RXqQaEYVhO/TQI3jdf1nKflDkME12oSY
         kx1T6xoRXq3KiA/BWxTOaN6NlRAOk5r1Lu5dyIHTwsA65dQfro8uFvYQ3KgCkN8P6lWw
         aSF/soIZpQqSOjD5PgpbAiRlAPIupP3Ah3+oFDl/zodJFs4GuuEwl9+flGZ95+MhI4JN
         5oJg==
X-Forwarded-Encrypted: i=1; AKwUvBytHhVEidguQ/wpG59miCNMZXQ7WzFx7yTnaQZtc1JQQhGoXPT2UVx/niEM8O2irmmr/H8Xpus=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVJ4bdRoxK6UfKrRhgPvxHLa8lYJYSB1M7y8z0DEQeSzKeyuh/
	3Nle4x0w2xruKgF3zQYOKbRIxiFRvoQWlhbC+Dk3u5Cj4BgfYFf3ESvh
X-Gm-Gg: AYBFou0PcbFa7mXsJuSmNKH+cFv7PJS/UF9GNH//yLbIaRtQpwSbiHBeDLFp2HZf5kO
	TPkk1g+TUwauLC/AukVRwpbuVxQA0YRrXSKNxOP+7wytSzlkX161o3/BO6FeNVkBokL4BNxiLOg
	Ukgh0QhDQNnBSj22T7EeogA+h80ec4/xZFLxRhVJhFohrCsVzO+oXjvagZwVWRAqdW7odQleey0
	BAY+OSUxCBfb2pTHRvl2nZe3jDru+LKKmxHtosWSnXl0+Ab28Xm63YPFZ/+lLgJI+RHoZvVrpU1
	TJPCMgXScjI12pD/gD38pYi+EItPXrdPw3sttQwloN7LD6CssFtPGojBhvsze5VG5BtRaiHLwzx
	4y9imHsxcBK4U8iNtu4D/nDnObizQRWF0YgrIyDnz+VzzQFE5/xAvO1dxzSL4QDza7RK3FblVoa
	MNWsQr2KFECm9u8TN218gvHUXq+T8m/Dj227zwZsN0rqCVurITQjctjSL26xlNxPlhBFw3G7G0R
	x8PEjJcVRHvs0aP0hskA1WJuxOL18ItBV6j25nGGDnYIp9X7Wib5XdL8PfzA0rDuLSqbisTG561
	8sb6zHHg4Jh6PMmL+o6Gg1NSASHWsNyiHTlfadYEyDXVJwWjjhnwQQ7VlDFly3Q9
X-Received: by 2002:a17:90b:57e3:b0:3ab:413:49bc with SMTP id 98e67ed59e1d1-3ae58123796mr1167823a91.37.1793179965718;
        Wed, 28 Oct 2026 02:32:45 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a9a5e73sm2211080a91.10.2026.10.28.02.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:32:44 -0700 (PDT)
From: Jianping Liu <frankljpliu@gmail.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	netfs@lists.linux.dev,
	frankjpliu@tencent.com
Cc: linux-kernel@vger.kernel.org,
	stable@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] cachefiles: return -EEXIST for a repeated secctx command
Date: Wed, 28 Oct 2026 17:32:38 +0800
Message-ID: <20261028093238.1382712-1-frankljpliu@gmail.com>
X-Mailer: git-send-email 2.43.7
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

From: Jianping Liu <frankjpliu@tencent.com>

cachefiles_daemon_secctx() returns -EINVAL when a security context has
already been set. The same errno is used for an empty argument, so
userspace cannot tell the two failures apart.

Return -EEXIST instead, as cachefiles_daemon_dir() and
cachefiles_daemon_tag() do when their setting has already been given.

Fixes: 8667d434b2a9 ("cachefiles: Register a miscdev and parse commands over it")
Cc: stable@vger.kernel.org
Signed-off-by: Jianping Liu <frankjpliu@tencent.com>
---
 fs/cachefiles/daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 1a66e0af2837..ef2ec7afd7cf 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -513,7 +513,7 @@ static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 
 	if (cache->have_secid) {
 		pr_err("Second security context specified\n");
-		return -EINVAL;
+		return -EEXIST;
 	}
 
 	err = security_secctx_to_secid(args, strlen(args), &cache->secid);
-- 
2.43.7

