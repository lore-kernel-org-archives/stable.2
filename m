Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E43C1D6B
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791698404; cv=none; b=H1uphF/GKK7PLAzz+6tf0LgCdtWrdVULPOz9tx8tTvR1PW+twzZ6R0LiUQLD4jiZWdfQUec7/lRrGCSlVp7PWNNirZZ0yeG6BbCVG9wYV5D5eXG80jdJSE0MxYqnbmF/tY2F2CHZaubqWcPeBLQAWpZpKHt/DdbUF0Q/5xHK2JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791698404; c=relaxed/simple;
	bh=XIuNEXf2+WIoLde2cK4bKU6HlAzdv5yqHSbad4ISGMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFqwFGx0Ou3JHbW4Qx27eOSpMqCncpdUjSSEcALAA2YroKZYt+Q2WRXO1/ZcPH+wVv0n8Q6hssWcnorAexaXeP4PBtw7eV+4SFfWqAqZBEBAJHfOGvuNWWo0lVZQrMnHrrguN3WFRedfxysDuqINYRwyka47sEIrII7G19RJKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuxYxm6X; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuxYxm6X"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab3f899c8aso222168a91.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 23:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791698403; x=1792303203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=siZczXavzG4cpFqab0LU9thPiqjozk6z14MIL0cwYp0=;
        b=AuxYxm6XBkc27Cj1VQmPaPLqhD7hpK/Ol4x9a1xQBzy/xSd7KgLcsQzCf2sGV9RV4H
         pykZHTvEIfEsf9pmkUyK+0/HVLqFETdpdh/rzGODWLX3WHBX589zAb2p04O3wkPiCYe7
         Ox6nARwuldYWDhkeygbp32hUWMWBkkPT5wZgplmLe9UuW3g13uPQqH0pzqjIe7D5o4cl
         MYjw0I7WmYRojr+KN8q7XehLXy5YSuMR49CmS+CD/yLKoXqbz90YwpwQCvp07EmaL6gg
         bKo6JtaJgpqWYauEAUCTNDptkYIFtsgYrExb9uGi+iRP/aVW7vNyAyKBqyjbm8N1hO++
         BRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791698403; x=1792303203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=siZczXavzG4cpFqab0LU9thPiqjozk6z14MIL0cwYp0=;
        b=ahhOy5LkHyQXRRTTganlFvox52q/I/vg2sw+gvIcRY7+C6ApHGYlBpfLUji1XBpJPY
         1vFhtQNyG/9e5w3Lhn6Kl3Z5+xo/S9MKybBuZhKXkkP8covLy+TYNnZu7FWdFCdGKcC8
         JI8L5gP+vmO5KtEmdlV2vQofiFAoQQUk4dBt5mvf/g4wAyhU6uCEezbS1+YPrFXUYinT
         pBuM0eltP8eSVAuzWqG/c0K+LP9/S7wOmvjWEg14z/sI4l6B+absuAJDc8Vh28PUQs3/
         nxT82RXy+/lRZrIGHke8JBAUlw6CJ43xrmy2AYgDBRtr5/hIblZFBhtkBc7MghPjsrep
         gZ5g==
X-Forwarded-Encrypted: i=1; AKwUvBz9iaNRfOsKyZxhtrw5P2O9tl7rBCTERzl6hXrEs9qL90EkwtYggAkf2vnlD6FSQKd162jqk+I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXzQIR/K9kWqZpcSuu2tAz2ywxx3K2wFISmmIMLbhBTPDV4+PX
	b41UDsh4St1zaCYtmb5VqpNJNvJkS8t81gjZN7YZ1+u/qlUuKK0mLudy
X-Gm-Gg: AYBFou1gfbBpAM/BH8Zacyu+nqWjoM/Ug2L2VqQNv6byE9M9rZPgjdp51hXyRViVnic
	iVmgtvwBpff7sCxhK2os/CHv7beGvij+BDDIWsRoGwE/3/iY6vfK9FCug5Sa2kDxtwZ80bK3pnJ
	yru8LalSu2/K3sZW08M62V/+bUgYqe64ito9rM4tPnFjlJ0HKePD/9AS5t7naE3YUkPW7LLKbaU
	GFNylNZpXYa3YWQWBVP4WlYAvMZu/zYOhoaUGJF43yy75iVPcTTPV3KEEl+57yNB4+0ucksGOof
	Ra1MJ0FkOOfpCju4aBA5U6w2PJzJbXgIYUvkdVm0n4gPPIa1ZOSpQZR0h93xYwI60p52EhIMYQV
	jyftF5WMruoRxBauMid1r65nZOlTgqDRWnKyAU8v1Vz5z4vG2q6+iODBgf7F7knfrlFahGolVUT
	pNB+AwYVJ3CMc4nb74eCUCMwa2uSz8+rIldtJdAo0lV9yFfPmSQN7+DD2WXmMpJM3UsStO1vw38
	Q==
X-Received: by 2002:a17:903:2f92:b0:2df:8ab7:fe3a with SMTP id d9443c01a7336-2e842abf30fmr88364935ad.4.1791698402534;
        Sat, 10 Oct 2026 23:00:02 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b5fd2sm29784615ad.50.2026.10.10.23.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:00:02 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: linkinjeon@kernel.org
Cc: senozhatsky@chromium.org,
	tom@talpey.com,
	chenxiaosong@chenxiaosong.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH] ksmbd: match the full EA name in single-entry queries
Date: Sun, 11 Oct 2026 14:59:55 +0900
Message-ID: <20261011055955.1487087-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An SMB2 QUERY_INFO request can name a specific extended attribute with
FILE_GET_EA_INFORMATION. smb2_get_ea() compares only EaNameLength bytes
of each xattr name, so a request for "Foo" also matches "Foobar". If
both EAs exist and listxattr() returns "Foobar" first, ksmbd returns
"Foobar" and its value instead of "Foo". It also returns "Foobar" when
"Foo" does not exist.

Check the xattr name length after removing the user. prefix before
comparing the name bytes. This keeps enumeration without a requested
name unchanged.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/smb/server/smb2pdu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 12a43efdb53f..a49cc3a0c9de 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6738,8 +6738,9 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 			continue;
 
 		if (req->InputBufferLength &&
-		    strncmp(&name[XATTR_USER_PREFIX_LEN], ea_req->name,
-			    ea_req->EaNameLength))
+		    (name_len - XATTR_USER_PREFIX_LEN != ea_req->EaNameLength ||
+		     strncmp(&name[XATTR_USER_PREFIX_LEN], ea_req->name,
+			     ea_req->EaNameLength)))
 			continue;
 
 		if (smb2_is_private_ea(&name[XATTR_USER_PREFIX_LEN],
-- 
2.43.0

