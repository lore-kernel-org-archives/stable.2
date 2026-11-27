Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769498;
	b=hW/T3A6gJM/aCjHJkGdTPfeRcG57h6hxtSkCjcYhT2Lfwm+bG+VsXW1WAgBoLwQAAWUa
	 VLLf3GSQFHnq91/CsaS4SYh90I9RLn9jbu10ddYUxRJENuKRZy2oVIfoSwl0X+9jNBxtK
	 b10hUNahKLeNkxZ/tw/zyJ+KvuUtPDx/Podhit89kMuFxTQelFxSxTaRICDM/FmXAI2B9
	 oZ6lNhLnOdJK+Ni52fBZoF3Dd+cTBe3JIqBnvIKX7T6TnJlBY4Q8a6V0NxluOjvK3injq
	 Bp4HojrDVTq0BfbE3CPscxETaAJCLwQmBUL2BJzeA670FlolnpDU0boe36rthL+9Tcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ROnGks4KYpRui41sSEQf6LMRfROe8Og9QvbvYoT1JlE=;
	b=XOe2VHmZtLfblVPP3hM5IWe/poVTcsuszP6lS9yA/Q+T+Z9MpZ+/hHdWFOk5bIVB53yr
	 OiMKAfhPWsUE5zvkit1jmsRuza1q/cTBNo6o1q+UCZLDR7mLUi8uSB8qXfs4QL3IyngkZ
	 IP2GczXNQOfQDYseyufDPhztqiE7NI1OVAHwWaiDT3EB7lEjhUGslkDq3PNtvJOdiI+Vc
	 MgJ5sE6RCq1qu175VwYxC4Z8Jt96Wf00ENdMliNM9BL1vtzXuFe7MbmmlGynt9XWroqcr
	 SXKqlC9Q5NblRiTjUWH/rAH6/cgj1/fIPXyJnXyXean9kj/+gGnovg7DyUFhbi68Kyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jycF48jN;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277F3606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 277F3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jycF48jN
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso7039762f8f.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 00:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769496; x=1796374296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ROnGks4KYpRui41sSEQf6LMRfROe8Og9QvbvYoT1JlE=;
        b=jycF48jNPsUQ9iQ4obcMgC4D8lLeeiJlBONFTHKNm+rSfBrnk3kngtKHacobMiedZj
         G4vkv+ubR0FS+aaIOC9RmkxVGA7BTztW80RI32AEtjUckdj7P19myLljSxbK9nELbQpc
         NKTZ1U+muo+j2ahqLG6P4PThjMoGJv8fcYOgRmdTA/OUYQYCTwLFdENaPf6fWRvO/N91
         UzBjIqdlCmkWuwuubiYJY0yJIihNztfAqAf89Zzh7cg+aYSyabCN/l6qkz5hkOVkwRKW
         Ba0a41rYsNvf2AwVnVddv0PHN2ejbJVmWhzkL58m/VsWpx5QTaMHqUUrN5WvHTP1NI+x
         t2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769496; x=1796374296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ROnGks4KYpRui41sSEQf6LMRfROe8Og9QvbvYoT1JlE=;
        b=cXEuut8fGxKNq0hX6Qfp/h0cKGRmWuyBZFlUN2EpZJj/8CGLjJO0GGRcKKVtC5HbIL
         houvcdlSTap2XUd46jtFKAkwRaZxdC0gLKFp669taUL7N3p2UDJwEP0cOSmJCw7GQ/DO
         cpnizm6HnT4WOD5tZ2rx99NskFmJm7T1U8kqEIdgv3DmuqMlqw5EW5REXgJf+2QrNlb2
         2RMwzs5ph3N8td1kl5KI+EBiqujMiEz6+Wgp310LgbVHEF7b3R5eeJ+7eOYSjpa+UUBc
         GP4WKZey6CMfmtiJSeWp71Y6cNCrTGCS2FdRJgtu8SfBNa+K3gJ2nsmk91zd9W518zHD
         mRmg==
X-Forwarded-Encrypted: i=1; AL+hErEP7LkBvzc28RnrbxU/Xv/dTGBNwadT1uZdLf0hyUm1txUib1adl2xMuG9d9GAN4E2tO7CdcPo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/g62TNWItR+Fej/WQ6BypnlR2BAPWduSUulkyXNP7rUT/fSeyq
	2eGJIznrqD9/HpVNeXXoSGyAFXCRk8DzHD1uLkp/eoHqKIp9GOtdB50su53WizxP
X-Gm-Gg: AZFdTZcNz7gWxxB1QebS5taUkTrGuEAscY8m3CxIl38xr81ovmyt+20B8A0KKSjgzqI
	VXuUUwf5Mu0KaqcoemWswBe5i3WBskRlPXgf6jI15ZJxmkYwRh00PMNCcsqG9KUnmSdZadZGoG8
	2fYsczg8L9brTt2U9265aGtdq82+U5QN5o+q2OTInxxQZI5c7ZQpgHd5lHiMGA7IgN2Xc7xHnOK
	4z5NrPFgSjyMDkA4RSzdIGs/D/KWT6hAElZ0Te5mSffed388vEQwrQSsYZXKCQzePED754vaNAN
	amj8kaJL1BgVR/f/XDDGKdEWDSKX/gjBMR6Bz8SzkZAw7eYteWJhCWgQxtgrbdXhxP9ozCf8SMQ
	Z9wupiScW3BxjBpe+jgpjvsEfezhLNVrxzhOnbihjjAsxYNdJOW6eD7CWrkucI8aD9HG0vLVDZO
	ag5w3fqXYZXcpj9B3WpFq4q72g7vrYo0Ojmv4xYtnBOn9n/n21YET82R46TtzSLK36ssSrzNqvy
	TuIGk6iP0LJcdIDHYbIvEgF3Z0nKEczC7iS+765X0mnhN2rNlP0sGLoeSFD3S/oM1Q21roJcJ4I
	BcyvoKrC0aZ31JmGWy7exCPSOhLezLvyp5mfcRVKGYBgJQEY4DusgGHwbxH66VVh54V7TEGaAOd
	a5MiE9wLAD9c=
X-Received: by 2002:a5d:4b49:0:b0:4a4:c39a:1d4d with SMTP id ffacd0b85a97d-4abb4d70005mr34452186f8f.52.1795769496428;
        Fri, 27 Nov 2026 00:51:36 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb41f4sm44244528f8f.7.2026.11.27.00.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:51:35 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.12] xfs: only assert new size for datafork during truncate extents
Date: Fri, 27 Nov 2026 09:51:35 +0100
Message-ID: <20261127085135.2341177-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.1
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

From: Long Li <leo.lilong@huawei.com>

commit e942498385bf80f4d6d075b47174035545eb6a2e upstream.

The assertion functions properly because we currently only truncate the
attr to a zero size. Any other new size of the attr is not preempted.
Make this assertion is specific to the datafork, preparing for
subsequent patches to truncate the attribute to a non-zero size.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Long Li <leo.lilong@huawei.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: b854e1c4eff3 ("xfs: close crash window in attr dabtree inactivation")
[amir: without this patch, the backport of b854e1c4eff3 trips
 this assertion from xfs_attr_inactive() in fstests generic/013, generic/070,
 generic/103, generic/117, generic/417 and xfs/181 with CONFIG_XFS_WARN=y]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/xfs/xfs_inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 3b487341348a..5abdcf1f46c9 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1025,7 +1025,8 @@ xfs_itruncate_extents_flags(
 	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	if (atomic_read(&VFS_I(ip)->i_count))
 		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
-	ASSERT(new_size <= XFS_ISIZE(ip));
+	if (whichfork == XFS_DATA_FORK)
+		ASSERT(new_size <= XFS_ISIZE(ip));
 	ASSERT(tp->t_flags & XFS_TRANS_PERM_LOG_RES);
 	ASSERT(ip->i_itemp != NULL);
 	ASSERT(ip->i_itemp->ili_lock_flags == 0);
-- 
2.47.1

