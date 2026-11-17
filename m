Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923537;
	b=2dhCwkSutuKhZO8Frewg/oF0oVfusxxdD4ZAO0VKR/ZDSGQpRZyssYzy9BSnLT9ToW3M
	 UyKVz9RX5wT7jWZEfaxuJ2ymVwL0se5R9yDekAQCaDnFCKBvq8mOalozp47ARX0DHhFFt
	 noGQd4TkvzYOfmUuCiPsDhx4QSL2R7nuNkXUwGaHjiCmsAJBAl0bsCWKZ3lqbYpoUKPeB
	 0P2rnpynqoZ2QJyFv1Jfn1mKBohwNERqsWO7KenVxuBNFgmbJ4Bo+kiFmbOcC7XMlzShD
	 NT5vfIHN5X9d3dL3hFCAPBIUOCzvsIiqH8BcyUl+VJ2LBV6zRk23y1j0mV9UxC4j3bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qEwXXgzCb9umMJN15TTOelMx6FvsKuxkJvNzraJF4vw=;
	b=VLjY3k0j9EtWqYYwj3htdzhciYkma9P+bSFSHVIx1N0OieenAz+T5+qb0pTOtoz0zo2+
	 bMwWSfmspt3QAvUSARGDs4XRIwy5cco3V0qaH76WkAv9vvZE7uA/wDWWckA7CUx98tPEY
	 L6l3z9nU8fHp6LsIE8tQNe1TfP65jCGuKLnZdVfmbLOvKG0FzrMUYRPH9z56aiCfcgvv4
	 LDUsUG2EEIqRUa0kXaAK31beb9Q3xT+FlvDPvHrduKPf7RRk4IZCa2KRKCI+ReOr0D6wD
	 ZOrVlmK+UBFg9y7RtECgZwJ1i6WyUn3N8uXb4nXvnOPC26Ghnh1FNouWUwBgk7e0RDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7Urt3aV;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A4E606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 13:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27A4E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7Urt3aV
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ed11653a91so26009035ad.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 05:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794923536; x=1795528336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qEwXXgzCb9umMJN15TTOelMx6FvsKuxkJvNzraJF4vw=;
        b=F7Urt3aVliZhyCp3tG/lsK08lCuZYAIvCyon27UzKBJ4vX2TDyEbDkrjD6R2bbeqwf
         4mVnMlK23NJQmANKWMGu9UDqvHN6ZfPKk7Zb1zoR88x8rGA7grG9meGGkdnEkWLvfG5/
         cb4TzFxZBroymBY0paTX6tNotqPiSSuNKJKqHVqAB0EF2Are/IBYCSUZPwTTvRHyfZl6
         2+QnfBN4Lwg5jAs+I8oq+qaXqMOZd8Sw7M3o6bXKKdt6LiKaloeIscGRxHVNtriipsQq
         mqLJ5b8/XyCqieOo4nGQnSPtbvtGd84W73cqTqwgs+DfoOx5Y63myZJj5j7YsGMBaF2o
         pfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794923536; x=1795528336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qEwXXgzCb9umMJN15TTOelMx6FvsKuxkJvNzraJF4vw=;
        b=cDYKJFiflvFglhMKvdUcDFu24d2hv/d6V3zXENy4UByfkgfcQKxKlYA1sxIJwW1f1y
         ytfe+U8z09ByiHzlkhFthbPFoktrD1dKjYc2l8OFsPsgP/+OGNXOUeA0/NSdcY8n82l5
         +CfDTU40OKc/FRQVifBdk+eJ9K0ye80lZkO+GIMtZzkSfDIEVl0Oe7Xj8oFH7Iu74o6J
         dxIN6jRkzHv0MA3i/sOqxBEV8VzwDG8WddHIJ8XDT7AyLT9TXUuqq/Xs6E7Vux18+US1
         ihYJ2Bx5Y+ccLD9KJtBiEafyvZG3UbANS5RWe2vja1guPL0MbHn3B36/TcnuwAi4qrL5
         KzAA==
X-Forwarded-Encrypted: i=1; AL+hErEk39PhJvkkpJhndacSklbRyny331/si3Rf5im72GSLhm4nHxqUfYuZPEPqYXka8flMjJsZPr0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cWHiGkq2fFNvCMLUSYO/0nZBL2pwJZTDPNFw8zYJ72XP73bMz
	MNilQvy9hXxNMLSKUeVUK7QEcCn00zExQRWS2GA5V/r5FdHWrV82NhTF
X-Gm-Gg: AZFdTZe5cJ2ASbU6JhxtdEuHJct/m+8Q7FxuvAW+d2C2MqvZmhlPgSITf9bFEQX09Fb
	c3hXzCVV2LlZEfNjdCxIpkW0v5od8cfqyynLz0PdEK2gQRjQExmj+4FFafxdcM276fg/6ZPbLft
	l9WXM4jBcpjXR64lJXAPkTNgtrFbqN6VuHkXb22XEtI1mmfIrEfy+gCtsqIyrF+MCROskCgITaZ
	afM95xDhreGgEUESzGyQvp7/V51MpmbR1ESulYPRvmPBu27KeLRvZBb5/hZv8zw5bBtSXjoYT5h
	8otqr4mgL0W8rHdrYbMtEzO/pBPI642B9DbzvsiSxDSZyHbpwl7oKgDoGewEqXIuSGP9LgzMhau
	8gVG0JDI/r+tmPMVV0L0Eo7Elc6dSQInD0xA8JZ3qdUbMI3QPAbEI1JU9fUaIa9QjGT91DRwGbi
	31ieqprmmiGjtnNwupxphknJnnpbDbId1wGTqUWTSXE9KsDeEAVXC0hcF0qnsvmuBO08eWCTAgZ
	qmclNYSsz2Q62GeDCq1pLiqvMz2q1EWMe/EukpVIl2Oqs38mRmynITYq0zjNaw1RM2aOqhS+g2e
	Igve9FpHh2Y+zszU7OC5Fi0dFruA7hp1Yjx/LoGmV35ZyDqNPw==
X-Received: by 2002:a17:903:1846:b0:2d9:599e:df95 with SMTP id d9443c01a7336-2ee0d6600acmr138465855ad.3.1794923536549;
        Tue, 17 Nov 2026 05:52:16 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a586c1sm15937035ad.43.2026.11.17.05.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:52:16 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Matt Bobrowski <matt@bobrowski.net>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] fanotify: copy full qstr length for copied event names
Date: Tue, 17 Nov 2026 22:51:37 +0900
Message-ID: <20261117135146.3174252-4-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117135146.3174252-1-graypanda.inzag@gmail.com>
References: <20261117135146.3174252-1-graypanda.inzag@gmail.com>
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

fanotify_alloc_name_event() reserves name->len + 1 bytes for each
copied name in a kvmalloc() event.  fanotify_info_copy_name() and
fanotify_info_copy_name2() use strscpy(), which stops at an embedded NUL
and leaves the remaining name bytes uninitialized.  With the original
length stored in info->name_len or info->name2_len,
copy_fid_info_to_user() copies name_len + 1 bytes to userspace, leaking
uninitialized kernel heap memory.

Use memcpy() for the full qstr length and write the terminator
separately, consistent with __d_alloc() and d_path().

Fixes: 929943b38daf ("fanotify: add support for FAN_REPORT_NAME")
Cc: stable@vger.kernel.org
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
Changes in v2:
- Use memcpy() for both copied names, as suggested by Amir Goldstein.
- Write each terminator explicitly without reading past the source qstr.

FUSE fanotify mark setup on a zero-fsid mount returned -ENODEV; the
normal-name FAN_REPORT_DFID_NAME and FAN_RENAME paths were tested on tmpfs.

 fs/notify/fanotify/fanotify.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index c25cf5c1fc70..2d6b5c2c6f25 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -221,18 +221,26 @@ static inline void fanotify_info_set_file_fh(struct fanotify_info *info,
 static inline void fanotify_info_copy_name(struct fanotify_info *info,
 					   const struct qstr *name)
 {
+	char *dst;
+
 	if (WARN_ON_ONCE(info->name2_len > 0))
 		return;
 
 	info->name_len = name->len;
-	strscpy(fanotify_info_name(info), name->name, name->len + 1);
+	dst = fanotify_info_name(info);
+	memcpy(dst, name->name, name->len);
+	dst[name->len] = '\0';
 }
 
 static inline void fanotify_info_copy_name2(struct fanotify_info *info,
 					    const struct qstr *name)
 {
+	char *dst;
+
 	info->name2_len = name->len;
-	strscpy(fanotify_info_name2(info), name->name, name->len + 1);
+	dst = fanotify_info_name2(info);
+	memcpy(dst, name->name, name->len);
+	dst[name->len] = '\0';
 }
 
 /*
