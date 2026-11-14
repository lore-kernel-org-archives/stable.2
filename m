Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794656986;
	b=juPWVfTr/zLFuI+SQoE5jJyXVy1sOVrB0ZZfjRW4WEfUID8J8s4HJjzPGHBufMpTX5yn
	 d4B5NGHQyUEAzz9mDK4cSzNhnpJ/E15PIycqpVqWhZPTnzA+tf8FsEFyVZqQvWvVy6z1g
	 yC9mf19Z1W3FQSmpEtzWPI6Sv4jBKsT9E4ethAcd08MHL0qmNNcMqXR3pT5ZFNZohhZKE
	 MDk/v1RSG192DSi9q2aZrnxYGhsNUP3Svn4W4l6Xm6KkzS1uePGWCywWR+VJ2PxPzS7sS
	 LmOuAgglU2imbWgM2pb713mzTUaTLOXofxxETxYcxt8ly/ZwieUoN5yoqF9shLaBf0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794656986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SBkUY1cm8FOuS3mONVtBT6+r4R8usLgyPQkAfTyHpLA=;
	b=JyTXNHmqJf+dBAhCrhX+2hDir8B/YBdDTi/mYEl3AvbEaStzKH4U5uVo58tdSHNjA7wa
	 KorINvDWFx7k9IVmoNUbtGztcOlkxyy7InXpRXp9n4Ydjyy/rmCFZFOfMIGZZgdDmWG4C
	 eL6TXBRaB3vJfYTespfdUUuzI9LYlqdqmeod4WxyfH8lipoBrWwh7W5dCPrzMcRlNBLvi
	 Axc/K03zcfUc5OjejOZ9asMbhR3lptj7aCxS2awlljnbJ3iRnm6VFsZXMX3jLlbzJH7zS
	 SiawgBJQwvnGGk25s0SNfDfriNKR6wYfw+OxeKb5U6zYG0w9VSb3VoQhL5Q7UeykKKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=FIw3qrkg;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F303B606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F303B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=FIw3qrkg
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so27775565e9.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 03:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1794656984; x=1795261784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SBkUY1cm8FOuS3mONVtBT6+r4R8usLgyPQkAfTyHpLA=;
        b=FIw3qrkg9ux8aDhj3wVhldGBe0oC3O8T88z58kmruFvtu8y/JyWeYfZAuBdrirwOTa
         BMUpPg/d3evscMt70nBav/KGTQCiI1x/DbAlt2bB8wXoW6ldtJQbSQcfQ1wd+6aVKSYF
         HS0pzgm1L7apqlW+esJ1yRZAEgKaTeP4Yh4EKBlqoYCophxz0tnUML62lSPSQlUMsOPH
         1UhmU/6uLthLe+WlRwjPVZw1MgrotpGvMD8MKVMEFAiu2bN8nXMdmHfGgl/hP2lOAl8c
         rNm5fTm36WH8Qi5ArHZ8LvlZpmbIIQjTBh+VDoUAT8UhfFkh/WQGIFnHjc+kUfGsUFo6
         /KqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794656984; x=1795261784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBkUY1cm8FOuS3mONVtBT6+r4R8usLgyPQkAfTyHpLA=;
        b=vapz7yVveKJT9d3dkh6YR4nLz4U3GbS4jRurYRwJTTD6C2T32RFPwre0scwBIQv90s
         RVKlfqtHPxloyc6EkOy997Jfvb7A8yrkoDLJzmZFTNFUVisj1r10HhCabCuyl4LmKXmp
         PAflYerLzpydDxM0TwcsQYzefaX55isnBuetbsDIrYnybdZkS/wUkee3hRKOQMowBl62
         2zmh7VN7TyzOYbPqrtw/slqvVGNkAKvfBnf8L/BBP5+O5TPXF4OLV5pSDcvzDgHMIWiw
         RHfiV1lRU9W0Y9kluX27RfeI1UzkX8OwVuW5CxPRbGJDa2faZJK3bnEBgyHRBn57TyYl
         XUeg==
X-Gm-Message-State: APuU4Z+niEaIssdyWHIC5laImUxwuSxQVxdLj5orcp25g55rbpGOFhE2
	nu6klqiyWm7K26QB+0lvTgFXGMhVGsJALmwMzwGjJ3izJZBms8OkVKYkUnCyj+aSEX34xUklI5k
	8FL0pNqMZ6A==
X-Gm-Gg: AYBFou06hwJOhOaEnmZ17CsPOwfWIp8jR7RPAXyuwHlGjsIpkGzYRfvIF5JnIBpmdUg
	lf5wCaajo2B7r4bfH55PgIqQ9U0IdqhJL4Apv4Fe5XBl5lfuVhCQ7QnrqvHno1/rA9L0z4QHCW6
	KdYnKYBkIjPDV6NP6u4COGlWpDuBy8kOgfuNe26+79yvw2KHcbf984hUddPZVlQvK1ClPgPc2XA
	VvtBiV300Iln1G5taGkpfVaFO1WUIn/0Qx1/ctp5mOEHg/Trx+ZDsyoGUlEPflhGzYg2KZwHcpR
	Zgm1x+6+Q5UC/x9AAJ4hATJ5/F9Uojn978whF3nUsAeMixfh+1fGoZFlu9AZFCqQRoaZMs5Gl8J
	1LyJYXAf/GHDmwYG9mrlnejzoU0eLKKFntYrdHSQiTqCzJvO6x14ET3yKyw9WzASiHHOp/K38Ve
	JorOWvA5oa4haY+DF3RhxT93UeZa1UYi1TPxtL7Rd/Grgrff7onq5UsVR3I/6ayFKlFa2MBYUoF
	kZUdNyxIGNQZOQ9sULDiUsS8Ehc0eTI0oAPQf6bg3hJlROscyi8C952ERfynf8jOxNd5ArOTOLX
	VHALN6+uDGbh3gqLVcCk8BDzQ29pmkwPMJSOfY/kSGmOg5FCGu9fZLHBRdFdJzpvkMSZ9lTQ1y/
	iqhcv
X-Received: by 2002:a05:600c:3d92:b0:4ba:e7:ef3d with SMTP id 5b1f17b1804b1-4bb559f7044mr107872145e9.1.1794656984431;
        Sat, 14 Nov 2026 03:49:44 -0800 (PST)
Received: from localhost.localdomain (static.16.56.4.46.clients.your-server.de. [46.4.56.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5671059bsm79079895e9.1.2026.11.14.03.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:49:44 -0800 (PST)
From: Jaskaran Singh <jsingh@cloudlinux.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	linkinjeon@kernel.org,
	sfrench@samba.org,
	stfrench@microsoft.com,
	senozhatsky@chromium.org,
	tom@talpey.com,
	mmakassikis@freebox.fr,
	linux-cifs@vger.kernel.org,
	jsingh@cloudlinux.com
Subject: [PATCH 6.1.y] ksmbd: fix NULL pointer dereference in opinfo_put()
Date: Sat, 14 Nov 2026 11:49:43 +0000
Message-Id: <20261114114943.5122-1-jsingh@cloudlinux.com>
X-Mailer: git-send-email 2.39.5
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

Commit e1b21e606661 ("smb: server: fix use-after-free in smb2_open()")
is the 6.1.y backport of upstream commit 1e689a561738 ("smb: server: fix
use-after-free in smb2_open()"). It calls opinfo_put(opinfo)
unconditionally at the end of smb2_open(). Upstream
opinfo_put() returns early on a NULL opinfo since commit ee426bfb9d09
("ksmbd: add refcnt to ksmbd_conn struct"), which is not in 6.1.y, so
here it dereferences NULL whenever the open got no oplock info.

smb_grant_oplock() allocates none for a directory opened without a v2
lease, which is how clients open the share root, so the first
"smbclient -c ls" or cifs mount against ksmbd oopses:

  BUG: kernel NULL pointer dereference, address: 000000000000003c
  RIP: 0010:opinfo_put+0x5/0x30 [ksmbd]
  Call Trace:
   smb2_open+0xbf9/0x1f80 [ksmbd]
   handle_ksmbd_work+0x164/0x430 [ksmbd]
   process_one_work+0x1c7/0x380
   worker_thread+0x4d/0x380

Return early from opinfo_put() on a NULL opinfo, as upstream does.

The problem does not exist upstream; this fix is for 6.1.y only.

Fixes: e1b21e606661 ("smb: server: fix use-after-free in smb2_open()")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Jaskaran Singh <jsingh@cloudlinux.com>
---
 fs/smb/server/oplock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 932e31a20216..f4ed5bbbeb6e 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -196,6 +196,9 @@ static void opinfo_conn_put(struct oplock_info *opinfo)
 
 void opinfo_put(struct oplock_info *opinfo)
 {
+	if (!opinfo)
+		return;
+
 	if (!atomic_dec_and_test(&opinfo->refcount))
 		return;
 
-- 
2.43.7

