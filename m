Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824514;
	b=QjqRO2LnFpNDv3pEdAqbH+WUC2W+zZPv3QsBpKx3KjlvKgT1TM5AuRD9dMSQA6+LVsfu
	 004E7YtVoINQ4Q3I2y+JzEAPmifPA3eJgKQ28ctRV0r6v81KvposrmxwLN42xjPLnppgr
	 PxGfgN++myruaNmkqbI31kVzz6PzYC74CNbsf5SiTTQkdvrhOhAqjT815o2bpUC1jhMDB
	 ThqebCtCNZHBmzWxdGXFpV4uw6jhitHBTpxWr8SQFo+5SCd2/v56MLFClo0oucknb5pmV
	 e/FJ1ou8740xsUF8xhp8Wg2b+0eLPqf5e9WWSL/Koax4jgRMw5QhH+OzGJHawEUH5Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fs2TY9KUSe9qhQmUoFf2CzU4kU5d/ayf9q/EM0cvmYA=;
	b=5j41ZVzOCsHBpR/JhOvvuv6V9lhrrbc7UXLx8Rutt8B2FKryoIYLr2iQ80xqfeDVwb9j
	 oyl/Q0P66NNMsy1lIrmcvFU3Jt+NMzXWsTBftmxcaDO5BPB36JtOjZzjR5ekgXzPyQg9p
	 7choLA1lOzV9VzmPGiIyKt3XgwUuo3iGuxfQLB7eBa/huMePcyH1j7AT378wMeDSy2qZ8
	 i8byghR3Gv/1ulouWDx9iZTK8SMnGW70Qev7pVQZAU1YO0stJYJSoxpa320BvqMdrKEmN
	 tyaAzqVzajjtz1Lu9a0mNAEVaTfcPy9c6679ezVX19Q+we7atRhVa99HWPMH6+YmNIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G12BKPSA;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38238606A333
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38238606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G12BKPSA
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso19307535e9.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794824512; x=1795429312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fs2TY9KUSe9qhQmUoFf2CzU4kU5d/ayf9q/EM0cvmYA=;
        b=G12BKPSAtE/jQt9P/CAWiwgAvbvawUunvssMMW/QGhaX/xm16bPDTzSCpS80xCYiko
         5B9sN+baxG5tIyg3NoPQEhEdYTvlK/Q7HOktO4sQXruWbgJWBuOn9N+ZN0W5EbwLJIIL
         me67DqtGeXV9bDOTCQX2Ea3uLD9CBaTN17calg5eTS70OCEkOMIjkvPYJzlsUsTHow36
         ErxYRgUm2tRKZSn0xiSruYsC7WCov3Aco2cvK8QHqksbm0EBJblbJtDAXcZXv4PLTqob
         ry7mKXeDSJdQVzhj6Uj+CbOGdGE5QlzV7DI6mJ46TjzmCY6ZlrPimDsVfZNycfEtxyV0
         beWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824512; x=1795429312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fs2TY9KUSe9qhQmUoFf2CzU4kU5d/ayf9q/EM0cvmYA=;
        b=fGdMKR1L8U+gwyd+x9xjx/BMU2HWYRIMkXD9Hc2iKnl/mFC15ZoYZGmyl9UUeTiIxx
         9iBejOadjYOiM5UOApJSdvz6X2gVSigCb1tZfs3FwuDDnOMNXr1p6e3QFPIkSSUhTL0v
         JFbXjcl/NOU4V65Yb8zBJL2WEtXZ1An+89ovmmFe7dvQ4uDE3vNVzSHNrbcAq4XOtp4C
         rCz4c0ckLi0tMImRZ1QrYC/bbjKdFWSvmf9rSKz7PQnaVHbEM+077ySRqEQMxetRsJTM
         MO0YvE3Vw1ZHAmM/Q/UOrPkr7vgFFtGUAoKIHDO3OECEUchgfUM/fn06hZoOeafINHXe
         jy+g==
X-Gm-Message-State: APuU4Z+49xstVBAP/RxAACojswDfbsGNVxOaXtrF5cwgKY1YiHeXMguf
	PFn8WlvotT5mGQ0e+ZRqHfPPDFaSwZJ7V8EFszRnh0lsY0ofnqWEPPiOIl/vkEzGWG4=
X-Gm-Gg: AYBFou3pg/rxBn0hvdkVnokWPPF4k11ovD9mUqUKZ4Cs7H/XXEonyzNltQ9SfJrvXuD
	8RC8nS5lJSp/l8eDWY6yrs4I6Rrlx5g0+ch44je/cDYiAd8GYinkEH2uq400zK42aw5Lm8vvRgx
	CXf6mp0CUeSnb8iARwhOkYZ891cxXSbNdarPl7/i1wlHiYq7Wg8hldKpSd6M6BEj2K57TsmbA3d
	khJ1l3nyPo+eUmKilKxkhB/5iU8XqjrwXW1S9oqrlJjjHHwbu/tNleNX6VtJfwhkiuYxUTqUp6h
	3YlYzzMh6v7B9vMyfeyq65y4iHuXUpc3piupJS8AkgM0CqcOebYRMds+IdwAhNBC3ty/5E2ay5d
	4kpBXWi7qa5zBG9ToUSbfBOBvr9WjIPe5YHErOgFQTlSHEAbHz9OSr487pyzu790Zxo8s1+nkkG
	QAIztVnd90wbl0FzlaI1jI7//cirwcLGyqoicG0cCnbikPHU859tPnTXm9joUYNyHYCEn418lNt
	iQq/7HUve3URoOKA4xwZggvtvEd/UEEwhUc8+zt4SjfvtTXsWKHs6RrTICefnnwtn8jG9luqaDf
	sa7WU/odHeiU8eZapC20xg==
X-Received: by 2002:a05:600c:6096:b0:4bb:5de1:e923 with SMTP id 5b1f17b1804b1-4bb5de1f26dmr155965845e9.4.1794824512214;
        Mon, 16 Nov 2026 02:21:52 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb6caae30csm98804795e9.2.2026.11.16.02.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:21:51 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Su Hui <suhui@nfschina.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.12] fs/stat.c: avoid harmless garbage value problem in vfs_statx_path()
Date: Mon, 16 Nov 2026 17:21:29 +0700
Message-ID: <20261116102130.80651-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Su Hui <suhui@nfschina.com>

commit 0fac3ed473dd2955053be6671cdd747807f5e488 upstream.

Clang static checker(scan-build) warning:
fs/stat.c:287:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  287 |                 stat->result_mask |= STATX_MNT_ID_UNIQUE;
      |                 ~~~~~~~~~~~~~~~~~ ^
fs/stat.c:290:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  290 |                 stat->result_mask |= STATX_MNT_ID;

When vfs_getattr() failed because of security_inode_getattr(), 'stat' is
uninitialized. In this case, there is a harmless garbage problem in
vfs_statx_path(). It's better to return error directly when
vfs_getattr() failed, avoiding garbage value and more clearly.

Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20250119025946.1168957-1-suhui@nfschina.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Fixes: 98d2b4308197 ("add unique mount ID")
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 fs/stat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index 80344764a329..5aa8f296e8ee 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -253,6 +253,8 @@ static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
 			  u32 request_mask)
 {
 	int error = vfs_getattr(path, stat, request_mask, flags);
+	if (error)
+		return error;
 
 	if (request_mask & STATX_MNT_ID_UNIQUE) {
 		stat->mnt_id = real_mount(path->mnt)->mnt_id_unique;
@@ -274,7 +276,7 @@ static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
 	if (S_ISBLK(stat->mode))
 		bdev_statx(path, stat, request_mask);
 
-	return error;
+	return 0;
 }
 
 static int vfs_statx_fd(int fd, int flags, struct kstat *stat,
-- 
2.55.0

