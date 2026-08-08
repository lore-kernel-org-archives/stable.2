Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118ED3FCB0C
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786192567; cv=none; b=mwTVaslpkehbcyHTf8MpWMO9yZQb/Kr3FpjJwJcL27Z4jwg/62LnqbQd7Y1OvhAXJs/a6F1dbQsyIu8Js0PYoO/DvhygVCC8yc7shrP4A+jNA68945lYXLZrKEzHw3Zcgl+qBh5phrZ2Ku/gcY5fCNIKgpYx8Tcj9uT/8RTdyr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786192567; c=relaxed/simple;
	bh=vSaaDCCuVmF2ar8FmCnssqQGcR+EygdT9BnSZy6oW+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EHDNDUs7Ic5O39diNc66zqQXrG7MqSFditpO0O/AgNVijbA1i239dgZFz+8Xyl4eMGD3/hOUzB2J9GuHb8q1lQ2CQF5rRImRcvmO6X2TBQBW6IdBvjEju1Up9Ks3B8V6JbFGNbKSVOCCk8DkSzfb/LqtViyrRnMeXiGUzxo1Rqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6BOgeVQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6BOgeVQ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so2409865e9.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786192554; x=1786797354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jRYshfP9Ina/Q+U65sHRZbbE3Lz3C2G7D9AgZHh97hk=;
        b=d6BOgeVQHqq5vDUaz8W8W3JVB3mneBS9XlBT/pg1zWwvQn0ViyZTq1ibGsqM/A7fLb
         3QniAm0u9LGZQZwZWYECgcoxjL++7J/IMuB68zatYG7X63wNXrL6QxMKHhvog4riGYqf
         ck9EMa6L+zsp+h4/qwEwyS6PYNebZ0qBreP+1iqFx8UR2n04M4PEeYDeQCAoqfv2MrSw
         +SOZGcO6y72MCd7+gT9Cin1/clT4spShrZ6RJpqluov9jDgljKbc4J9Jnulf6yjMMmLL
         O4eR5xqVyvPQCt/8nG0jsBRmHfzuGdbsLZt6MCSiPsOclexKbgbb1D76gi/hFaGvmqE9
         9M+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786192554; x=1786797354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jRYshfP9Ina/Q+U65sHRZbbE3Lz3C2G7D9AgZHh97hk=;
        b=cfmdH40p6WJ/ez4vOkOl9Fo5U8ZU85yzjyNEjsfUC32EcxTbknIHoB5CF4nqsDhOXu
         B5wQN6XbFRbPe+KsG0uztSppdgeSBGQK6751HFyRKAUbU+ZgTWfWTatLPAbx5VYqshpm
         29G/IcPUlqT4NABUcmiNydCxlTX69l3LWA+Ikyg0Wn+j0EihvNlcXy1VOYcgnPhhNqOG
         EGv71h7t8eLy0QdCGr6eRPAuPyfw2/9yPqoGP+nFiY2Mov0omvGfIyAcI2/5SKoDzKlS
         1tbd2bCjmHhNcaVoVMafe4dE59tDGVpAjtnUaMxihj1En19NaCihAmiL+MC6DC6ESSFw
         DMHg==
X-Forwarded-Encrypted: i=1; AHgh+RqwI/6m3gsyFnFSwf+STSdUyJbxtnVkUe/IlRxKU6fRWHq4BPAeTqMJ8R9JQcJp6xeQSgmVzio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM0uXoMcj4P2Xq8MX6PZBtMrc9+4VJ65SB2VWO3DC3xYigSdbK
	GiyuPBmAJ1VHMC2f2dnWtv27YGkKrsSIT4jOWFgvj5RGrrwUgMllfXc2
X-Gm-Gg: AR+sD10nG+JgDwV3l9A1jfJA7LjIiZKqVeieYLciqWJhEOI0XUb0Mf4kGZx7jXKEJd8
	bH/p4Ar++2R+wdGaeBaiEdPF2yZ6pVGd/lvfb8cbypBUi+6Q7FBA2gsaTvyoNMDIpoh6EgmJAPR
	/nlC5zLMyBaUMwDzhlcCob/Zbktuh9q5zV4nhiUrGB6hsRw+3Z1iiwChh0bmyt9KtIC7+4396RP
	he089kwEKJk+Ux+hDnZ3Y06zx11/P/jIPru311m3sP7Z+P4mOdCqHzO2CZ6WNY4gRy6OiJuaQtI
	BkoBVSvYtuPQ7CFNsy4KiG5+rSbsxsQ20jtX0uON00Xzzg9fHqEIheeXUR2jJpuy4POhEScfNBT
	HhqkvW6yWG8TDFe+WscnviaT27ouS/3crNhrA26Ic4FZWd2W3sFrpn3eCbQ0d4TceHOLKWTAEKy
	0QJ5RcwvkraE8z1QJ5HrmKD+a6N8gBHh5SG9EQ8L0tU6qK1zXYX2yZTDzH3hG9kwEyL5UcH8b/J
	3LxP9eMte1N/lNBTPgSbwWsD2ck9v4U92DynYNCqQkwTC6JjXrufhLxeMT7bljnC/QKhAq+8qSu
	5Cj4Ubc88vikc2d6Koyd
X-Received: by 2002:a05:600c:3ba6:b0:499:48be:3189 with SMTP id 5b1f17b1804b1-4994e6c065fmr360149945e9.0.1786192553857;
        Sat, 08 Aug 2026 05:35:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-004-134.77.7.pool.telefonica.de. [77.7.4.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542858b2sm257587555e9.14.2026.08.08.05.35.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Aug 2026 05:35:52 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] netfs: Fix uninitialized return value in netfs_unbuffered_write()
Date: Sat,  8 Aug 2026 14:34:31 +0200
Message-Id: <20260808123431.73554-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If preparation of the first subrequest fails,
netfs_unbuffered_write() exits its loop before ret is initialized. The
empty-iterator check can do the same.

For synchronous writes, netfs_unbuffered_write_iter_locked() may then
return an unrelated error instead of wreq->error. This is reachable
through CIFS if cifs_prepare_write() fails to reopen the file or obtain
credits.

Initialize ret to 0 so the caller returns wreq->error if no data was
written, or the number of bytes already written otherwise.

Found with Clang's -Wconditional-uninitialized.

Fixes: a0b4c7a49137e ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 fs/netfs/direct_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index c16fbad286a17..b04019097ab8d 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -95,7 +95,7 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 {
 	struct netfs_io_subrequest *subreq = NULL;
 	struct netfs_io_stream *stream = &wreq->io_streams[0];
-	int ret;
+	int ret = 0;
 
 	_enter("%llx", wreq->len);
 
-- 
2.53.0

