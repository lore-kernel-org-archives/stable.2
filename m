Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794777014;
	b=JJPoNSfRjdJYubmMfFtkmrrELXsxvXDfzbhin/RibIT+cP4WJyz9hWYL+9Zwrvbi5OnK
	 TjWHkkr+ysojDLwyZSUkvgxXT9VAUFl2/yOvoFNWUi5QYty3DO94xbdvTkms2olGlUz35
	 /STanHkZdvVFlV+UKOzbP6Tf5Dv6EgJy1LHWeGa2ywWpffIVXQmLvSdFSwqd/cJqeICPa
	 rOojGaXY6Xk828EARxDv9fbnKC0MPnVrY//E2UIi5MKXSyMRTfPzxZnisrvzmvAtplAEw
	 wolCqkuePG1Uc4Y44GOtCll0LGeWgTTQ9s/4yeVbVpgWY9/QhX3jXWdyprk+hQqwOkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794777014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oQFSDg5cHBfrZhn/Xqr57kPvYhbLjr1otgLb7m0JLjg=;
	b=z8b2f+AbJwRHhbXMb4VPXjqtk+SL5rUnDdDlc2z36fytjdZzOvWfSRLRgeySAegXbno+
	 Hg0hjQP32apg5RR3Aww9bzvxwzn5iBQPT9c69x7QNOwheReT6AUC0KlrHV1rZGb3I7DYS
	 rLQ0V7EZ2HKOEJxY0NQ2lcpf86Eh02e+aYbeIoQK/RL9TCfHcdfzZeS51DdmaUVKdA/ji
	 52FzjGQApjfi4RV5o9CtLCmOzBoodOtCIHxPvLqoon5N8B8AAlslc/QT6vHH4R6Wd2O17
	 gogm9SwBNZku/8uQvBjfr5QGCU5SaMA1qWXr4+febZVKtlVOp8kuaszjB9rdIZZQinQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uzSCHJmS;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7CD606A333
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 21:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF7CD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uzSCHJmS
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b5e5e64494so1664615b3a.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 13:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794777013; x=1795381813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oQFSDg5cHBfrZhn/Xqr57kPvYhbLjr1otgLb7m0JLjg=;
        b=uzSCHJmSpT6rzm/HyErENUYElGk4p7T1CSvlyZl0mzgDMdAfIgkX0aLaP7TtwxAoax
         svNoHOEL8l/h/2pQyQ3ZlTMD1t3gIPMXJdpwVsG0ma/h9WoOV+2NvsA+/8kn3hjruQ21
         dcI7KWPlQYxkBH/J9CtXpJxzFSVkAZnoB8HYbbu0GH9r8fri9YsGfMcnkb+z1n+PRdr2
         JNaorixqYXZO4BmtjqqA4TTqv1d9DPC2z8Rjnv/eJAfqi0fTQT9TeTv/2UHJ5Mt1qyvv
         49Mv+rm1Y1qM7A4Tz9mbPuS8hdd7E0Qxrxzx/fIOiPX0tOTPMqRv53rYSqVX2qjMCO2a
         22Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794777013; x=1795381813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oQFSDg5cHBfrZhn/Xqr57kPvYhbLjr1otgLb7m0JLjg=;
        b=RJaBO5RHuET4cqn91C8g8w68BYbK0S5mZ6500CEpzZ+rYa3MYbz/kJn8bUMm0kUvts
         Z7pQ3nTi3CeUy3DLA62WG23DEloo6fmI67Ht7AEwBaT49Yksyb7A+qqpUw076wv53qWg
         u5k/vFE3otgd7m/tMCrobQjmzwmdsAQ24YLqTThTEx5nfAdp3C65rcZ2fA9/2kMyfmXD
         8I2SWXzjg5JfUkVY74S2loAiQERpr9/msLQaLZWKE/PY5eaDXjRB53VJI/UCI0ru3bQX
         YD/ppdhv1Onf/Ee1a31Y5gTjqDDOKH2FoipNQ7eCV9ET29KD/eFZ5tD+Y1bmOc5V9ipU
         qZCg==
X-Forwarded-Encrypted: i=1; AL+hErGQjuk/EZKRLmTKYq/MKtqu8Tn3sxaA23N3J/6spUp4QNBon8p9Fa4VRg3qllbmPBsPRVMAGoM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+Q7AR4vvAFFHXDmluEnUvhb+egIDNH2JSz+w2DwbBFM/197Q9
	w2sb+PI326J87YDVUBsFv8WrGgneIrbUkq7EPdYJsUomna9gzb2HY09C
X-Gm-Gg: AYBFou1ImjP2V9/IgpENf9UE98bjNFWVatb4D8IDpevDWOzPedGDBU+p6kYs/r0ZcuH
	++zBZU4PI40QdPt6sHBcbd+WNlth5sJrREIw2SuVsuL9g3SrRanTWLbND0GotOxA3bmcQP3zpvq
	fqfmpH2ZfIZLdkCVhzcWUUwd57J57ru99yu+Y3bwzB2fMhKRXC0XpiTPxmbl2q8fDOVPvNGBC5r
	gHo2n1LUoT1TRlfLwLImW/3wa2JCOfhhIXE9mUUebw0CO2SMy2TOxM2eZqdoedNbKmvxciKAYkn
	ihmN9XpN5tE4LKaH6EB0VbJaQFtO+0pc7mILqnub5KnV65p/2eNcrAUkarzPdPVfyrxenn/NX+C
	VKQhhWDMOWdv9WtsLhNgKDsIzeXpgkMr+Snncz+j8tAfwCAND963KLf1QlXV15zqc4Eh80vgJzg
	e9HysLy5+6u8Xm5M9ZU3jrI/VjwqiyeCddwCxU4nkSQAYkoSO5czEjgn2T3Y+pRmuPrQcpgHVkE
	mspFnBfbkGxiAl9ZmFQus2PWnENBSgQk4uIoGZFjDlQi4VJfv1yezGRVKLKo3olj/tsJVp+Ewn2
	jwpoMspqsPOjbFB0MTjPkl1PnXBf0GBYWWwPp1z7OPcn6RjUqQ==
X-Received: by 2002:a05:6a00:1990:b0:8b5:b3c9:ff71 with SMTP id d2e1a72fcca58-8beb374decemr7993433b3a.7.1794777013037;
        Sun, 15 Nov 2026 13:10:13 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1a6e7f5sm2892615b3a.25.2026.11.15.13.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 13:10:11 -0800 (PST)
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
Subject: [PATCH 2/3] inotify: zero-pad event names after an embedded NUL
Date: Mon, 16 Nov 2026 06:09:49 +0900
Message-ID: <20261115210952.2140036-3-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
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

inotify_handle_inode_event() allocates the variable-length event with
kmalloc() without zeroing the name buffer, sets event->name_len to
name->len, and copies name->name with strscpy().

If a dentry qstr contains an embedded NUL byte (for example, via a
crafted FUSE READDIRPLUS entry aliasing an open directory), strscpy()
stops at the first NUL while event->name_len still covers the trailing
bytes. copy_event_to_user() then copies event->name_len bytes to
userspace, leaking uninitialized slab memory from the tail of the
event allocation.

This mismatch dates back to
commit ce163918cd33 ("inotify_handle_event(): don't bother with strlen()"),
which replaced strlen(file_name->name) with file_name->len, and remained
in commit b8f2688258f8 ("inotify: Use strscpy() for event->name copies").

Switch to strscpy_pad() so any trailing bytes up to event->name_len + 1
are zeroed.

Fixes: ce163918cd33 ("inotify_handle_event(): don't bother with strlen()")
Cc: stable@vger.kernel.org
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
 fs/notify/inotify/inotify_fsnotify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 6e3af6452dcc..78eb1e92a14c 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -121,7 +121,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	event->sync_cookie = cookie;
 	event->name_len = len;
 	if (len)
-		strscpy(event->name, name->name, event->name_len + 1);
+		strscpy_pad(event->name, name->name, event->name_len + 1);
 
 	ret = fsnotify_add_event(group, fsn_event, inotify_merge);
 	if (ret) {
-- 
2.43.0
