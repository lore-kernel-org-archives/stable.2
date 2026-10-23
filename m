Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792723042;
	b=c4HsNe6srelPjd+g0Zxt9UwPA6XBamUyR8YesaD/nI6i9eir6MN3SY+GedO/I+r20g7q
	 Yx5FNjEwhb6K4qRRKZnLe+FRnfzdy6st5LNi0UlxvNjs7WdhxHFCknVSnOo7q0XTnAzAi
	 uLYrV9Ev/yaGU0OGIzgpY1x+NCVui5EOsn5NbXRmZT9CwfUFsuI4C0/6JSVXyljMuWzmK
	 +B8KojBz7L59CYJ0m8vg1FL6ZeH7A7kQp6QxOg5R05JUdzAfESIGsfz52eUIjfPQ85I5h
	 A7C8rQ0nJMvsVRqeRDK/VmjN/ofpujTxSY2QQ+SZAf6jxHvVJvFdfehXk5PHd7qUHVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792723042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WXD1UXa/1j2wgsFUv0w36GnGU79I5JqF8Ggu7ibN9oo=;
	b=L6xoNIbBXR+/WDjUXTkACYeDLOCeUZ0B0h89fJdpZnR51C3uASsTzWeZQN4jEMhzsDXW
	 bKG6WgoQ58DVJ0uEKDaJbQiinhlAL1QowWraRw5NiLipvOmMKFQ31rbpQfGLonCj7yjUi
	 fMwPQRIlcFzILth9+P8edm88+mFWAxXDFRjqawWK4eev4wDwTEPCpDxGZrXzrpXJKLvkE
	 RFLcYPWPuFXh4N2E/I6mLBv0U0jlTXJBip8x2ycPcUval4D8vIFQJM3COAtJlgW22WDja
	 76JPN8LcstexYVWk7z5GYFwePgiwXhDHQ+FnPf+jY0fpqUugX4QvxBSnqTDlj6IidMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H4+CJh4U;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F6F606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 02:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6F6F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H4+CJh4U
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a01cac8733so287189b3a.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792723041; x=1793327841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WXD1UXa/1j2wgsFUv0w36GnGU79I5JqF8Ggu7ibN9oo=;
        b=H4+CJh4U/XQB1x17laGpiGn3y8Ag9afkIWxee4g/X2XMGCfrdKdT/k/gt/eXaxDIL6
         i0AIVO2H8yi0JT3FIz/rsEAOfW54qBSHsCz8Wee3VVBke67Myew2Nnj/WlnFlqboC/Tt
         xLywkMVz25Oe15lVOLS60TBP0hbWN483AozsjKkGSBlViCqjYPD4iUp3cOc/sRpylXDm
         8FWezW2khsT6RMSccathtrgnQeVykvydGXh0xt64Loa+9gD+jxaDLbfCM9H2SJTo9yq3
         Ic9pGGndhaKN3t3YU01nMNpRGse8hdcXuvQXExab8gYYvSHF0xIb4D2rXudkIpigU1H5
         NfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792723041; x=1793327841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WXD1UXa/1j2wgsFUv0w36GnGU79I5JqF8Ggu7ibN9oo=;
        b=GvxigRFfOwEgjSQ3nH9O7jpl6bRWI2X6WH2GDRxLcKfV/e11cSn6oMaW+qn5so2528
         dtS2KX77HlyddD2g5A/kDhftge38lg1Xo+G096KsPha4dz7x19EAJ0AOByrA/5GpN038
         OGXG+Rf4s8wajRKq9nLKXfIn8uP14V/ElwKwQ4aexUqLf1pK2MlNxYnbE9ysAQv8rb73
         uuanhweskbyUeqge0P6LiUJDhAx8JvGA25b2i00Xb+CpDU6Kborw381czBZKBI40X5aq
         1fYpJucyGk68O7+yZmLGJKH/9ZmjBsmJ8L50zuIHTQ6/5iRHuPZdASS66IpVA0XPh3UL
         aDcw==
X-Forwarded-Encrypted: i=1; AKwUvBxp8WDQGDhbvUZvA8B5vTtzCepYrtdzZ5Cy0Z2zJqhyoAaWc74ZbUtghs+4MMfZ7WtObbE6fnI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsTevxHMcJ70bs7Gz32q6ZGFR+S5Wn1OMIhsdMIfTDSu/oQMtc
	yo8dhK9IQ+rutq4qLhgxHUCXOAifDzUjsOGAx5Y9UPnZJlwb3FOQ9jIs
X-Gm-Gg: AYBFou37ClqK4+y9V3vicOG83pQL0HJpEuAkr+G8sWCUfl+Cvwbb1V72KfwdEREkvmb
	BXPB4l4rNxhi7d0DOmlAwBU06SQnIbUUjcrPO7bt21CsmYLv8QrpewhJxF1gTn+BMLNrtEDUjFj
	k+7ygoROuOLJCqcusNVIeJ7GL08nA0uaL+oTTMb8aos0W0MHJbhbKqnAsIMq9X3ABNceM4kwyUj
	gY8BfDqTx/PDwtzSZtkklC9/1A9A44atYGQuaxd7EcVpiOlDha0vquGjJD7nMt3MdIsTiyNprFz
	odEAfDtLTadps6AZhkg2jhmbtJBnPn/Rey/h5tRX+fdOr34WJXcqiVBIIMd6PWKBLJMJCaoMMMA
	7c05GdN3pTObzEGiICKlSpKZ3eJGIMzKWWEh7C+LZCd36dpWwqPAoYRxHpi5mM2MsjLK0xG4AvT
	LdQiVYIWJUzJzSTdmH9+iacuCbjYEAlVqNp8cGTZDvQYflMx5lVfWQbqspew9FUWVBE+LvYTns3
	YUJ/t6JEeOyQaD6QPJuJSAJUqKn/iBRBpDSx0Y/fzATyJIziTM=
X-Received: by 2002:a05:6a00:2d22:b0:8a2:b10c:faef with SMTP id d2e1a72fcca58-8a2c66b5aa5mr763722b3a.48.1792723041105;
        Thu, 22 Oct 2026 19:37:21 -0700 (PDT)
Received: from linux ([103.155.143.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a2c92f2a01sm189340b3a.46.2026.10.22.19.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 19:37:20 -0700 (PDT)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
X-Google-Original-From: Hongyu Jin <hongyu.jin@unisoc.com>
To: linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: hongyu.jin.cn@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RESEND PATCH] writeback: don't requeue inode already on b_dirty
Date: Fri, 23 Oct 2026 10:37:07 +0800
Message-ID: <20261023023707.263101-1-hongyu.jin@unisoc.com>
X-Mailer: git-send-email 2.53.0
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

Since commit 846a3351ddfe ("writeback: Avoid skipping inode writeback"),
writeback_single_inode() calls redirty_tail_locked() for any inode left
dirty. When that inode is already on b_dirty and older than the newest
inode there, redirty_tail_locked() moves it to the head and stamps
dirtied_when with jiffies.

Append to an f2fs file so the i_size update puts it on DIRTY_META, and
dirty a newer inode before each checkpoint. Every 17s the checkpoint
syncs that file and redirty_tail_locked() stamps a new dirtied_when.
17s is shorter than the default 30s dirty_expire_interval, so kupdate
never expires it. Dirty pages pile up until writeback or fsync().

An inode that was I_DIRTY on entry is already on b_dirty, so only
redirty it if it was not. The b_dirty_time case fixed by commit
846a3351ddfe ("writeback: Avoid skipping inode writeback") enters without
I_DIRTY and is still handled.

Fixes: 846a3351ddfe ("writeback: Avoid skipping inode writeback")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 fs/fs-writeback.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 58a6403780aa..fb33a63710ec 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1898,6 +1898,7 @@ static int writeback_single_inode(struct inode *inode,
 				  struct writeback_control *wbc)
 {
 	struct bdi_writeback *wb;
+	bool was_dirty;
 	int ret = 0;
 
 	spin_lock(&inode->i_lock);
@@ -1932,6 +1933,7 @@ static int writeback_single_inode(struct inode *inode,
 		    !(inode_state_read(inode) & I_METADATA_WRITEBACK))
 			goto out;
 	}
+	was_dirty = inode_state_read(inode) & I_DIRTY;
 	inode_state_set(inode, I_SYNC);
 	wbc_attach_and_unlock_inode(wbc, inode);
 
@@ -1954,7 +1956,7 @@ static int writeback_single_inode(struct inode *inode,
 		if (!(inode_state_read(inode) & I_DIRTY_ALL))
 			inode_cgwb_move_to_attached(inode, wb);
 		else if (!(inode_state_read(inode) & I_SYNC_QUEUED)) {
-			if ((inode_state_read(inode) & I_DIRTY))
+			if ((inode_state_read(inode) & I_DIRTY) && !was_dirty)
 				redirty_tail_locked(inode, wb);
 			else if (inode_state_read(inode) & I_DIRTY_TIME) {
 				inode->dirtied_when = jiffies;
-- 
2.53.0

