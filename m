Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E993C3BFE
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983788; cv=none; b=EIrumRgb1ARWQhxxie7qmpueFc0M1UtliKsZt1/+0hJyaPZoW9xucxpMcYqv6rBzhFHMZXcdDABQsrPqwUcEolrNgZllK1pYAQqb96Bk0Eo1fpCqnhmeuyAzbjGKfqBKSpgauqyWg6eOYDYTgu7OdPkbecEUI9s6WgFEWztOllY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983788; c=relaxed/simple;
	bh=q9hoYC77TAOBI7UPGkqjKa//giTHqLClViyb2A4XOpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MLMd5SBZrUPdzkJk1c6JMtCguzJu6zt9TNDlkltfMeHTFeTqJmsxDh/07D+7ynGc68q1MrbMqTar7OO6Xk2o6lVPsrW1Vhqrb5eg8YgEyWgnlXkTLEyIoOppY1B3i2nUsgN3g57oV2wtQfukphGElObdPuIlEsS097gtRGOVnY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5jPrgb6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5jPrgb6"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49ff90b4b5fso1725995e9.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 16:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790983784; x=1791588584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nxHrVIR24GDD4S7L2ZgpY+muMq5UDZWEAxE61ARdg78=;
        b=Y5jPrgb6rsl5pKRpoyjjCb05KEg9Dy1wOneoOrfX+R9D670m1/zwQYBzEJU8vqNovn
         Gy8pX4HnsE4ez55G2+b/gZPt27CQZlcNlf8gJoupavwqQ36VlB+wv4AtItFM2cwL6+dZ
         fNT6Cpt/eK/SpdURX+DdUPuAf/sAt2C+mW1sydQyIcL/uQi5EjS1Of6oLe/6jd8h/krY
         beYVDBP0hqLfw1WU0L3xk6B91LB1sbjRHuNqqzDaibC1Y9Cja9ajdQ8qrt3oRccz4EvG
         C5Ij/peMiuzn6+ClJhvxZiZ3m6Of3E79qVj0T9PSNPbQ6xcsuYW/NODhykzfBmcRteD+
         MhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790983784; x=1791588584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nxHrVIR24GDD4S7L2ZgpY+muMq5UDZWEAxE61ARdg78=;
        b=Vg8Vah7TbxMj10fgGCZLpAHmkFQotrZPUk9VQU1tGAUrQzJ1/23AEjoj09GsWG7Gra
         5xXie7tLQ/RT0JZOl9GczGF7paJ+7WGeGTOzU0IcdwCmWZt/HYyVYFE/ftrVTrOLfeAb
         f6Ppe64b2PX08j1fufz8TdA7kURvm8BCtTOu5VEdd18nkZhGCehGKcX9YhFSF91p3uab
         3O11tPooT7uVe/05WfxESsbC5sk2AMZY9d0x7ehPo9V/k/xnYeQEz3gxmPzQRRjH0pW5
         zq1AYrqCDFoVbWeJFbQQjNyl34uL1/OMxXgUELPqmg6PI5i4swaxCT/ZCwtmoKTk2fJW
         zQXg==
X-Forwarded-Encrypted: i=1; AKwUvBxdXPGNOEchlZQ5EIAOcP2V/me/orvAkRfjqV1Tytm+b+90O2inAbfOMp8D8Oi/W50TxOIldkQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nC76aLPuomQOc/feFwA09SsEXgJPcj99z0G5xlPLhxRZGFeD8D
	ZqxZCGhSU5/+f4J2nXNQVqamIeFkTED1wASLV8VSiZiKS/XWzZ2UrorI
X-Gm-Gg: AYBFou02K0zCpjLyAJCV1CzhpNCMEsS8IJ+1kCDwdJI13WiIVMDRzclZcv3nrmgBa/F
	Cg3ZwGkmFoxxo7bQ648WV5pXLZy1tY7Icq0Tzvt+6OHSixhSfRfotr6jypZuHf5KXmu2Rs3JzDj
	nVbNCQ+RxbFSTLYbU4nTsGk++JDvS3ohLRspQTWPK6xD6c02zDst99htIDKdniH3hGXvAGAplKg
	nyLCDd9aV9T6wbNKIvmZ+kXJTuLKFsPYjxXiGCki4zYS1pVv0m0tQpV/DOP7iGLhYhvYs0ZRLFY
	/j/c8UqlZNlNqXvxgdQGjwt4J5ViARnkXhmcrrU1VKOVFgW4xmjMRHs7u30LtP+0FVm6TLIkIjv
	gz+AOb4cfG1xez1c7CIxzA8N5bCAR5CuRMr1ehy+kZA8HQai+Xeiub5KibMOe/Cg7FsJyqWUcis
	MkbKkFr4uunW6oYtBDL8BpqzkXlXVAohVNXJaHKLwrua/2LaOw3MU2HENC6zKxrYvwXRBd7h0Xk
	j5S3anEcKTdItOgtYdjjuBZ9NsBz7gunQ+VwGfALXGjsWqFuJHY765Ryl/B0U5AUGv2Gh8F7Bwu
	ZE3k6wp5NeG9lZX3+mHV6OaHb3b8WyaZliUi/jp8utuD0kGRqs+FsbTl+QbsTsyK0nM2FO2miar
	gtNJKMTPqAHTJ
X-Received: by 2002:a05:600c:3110:b0:4a0:b6:4619 with SMTP id 5b1f17b1804b1-4a168069b91mr14580305e9.0.1790983783964;
        Fri, 02 Oct 2026 16:29:43 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-af35-1901-81da-eee8-c2d0-ee3b.310.pool.telefonica.de. [2a02:3100:af35:1901:81da:eee8:c2d0:ee3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380fac3csm8688932f8f.21.2026.10.02.16.29.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 16:29:43 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: use u8 for SMB2 oplock level values
Date: Sat,  3 Oct 2026 01:29:38 +0200
Message-Id: <20261002232938.40011-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SMB2 oplock level is an unsigned 8-bit wire value, but
smb20_oplock_break_ack() stores it in a plain char. On architectures where
plain char is signed, the value 0xff becomes -1 and cannot compare equal to
SMB2_OPLOCK_LEVEL_LEASE (0xff). The acknowledgment is consequently rejected
with STATUS_INVALID_OPLOCK_PROTOCOL instead of the intended
STATUS_INVALID_PARAMETER.

Use u8 for the request and response oplock-level variables. This preserves
all wire values in their original representation.

Fixes: 80a56d4a826c ("ksmbd: align SMB2 oplock break ack handling")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 fs/smb/server/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 6b8809f..6074bdd 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -11444,7 +11444,7 @@ static void smb20_oplock_break_ack(struct ksmbd_work *work)
 	__le32 status = STATUS_SUCCESS;
 	int ret;
 	u64 volatile_id, persistent_id;
-	char req_oplevel = 0, rsp_oplevel = 0;
+	u8 req_oplevel = 0, rsp_oplevel = 0;
 
 	WORK_BUFFERS(work, req, rsp);
 
-- 
2.53.0

