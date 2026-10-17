Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C69F36D51B
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 01:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202168; cv=none; b=XrM053ZpXLmsyDCt7PL0oFX/LHN6ISiWGweLRp8zGKf+AqxjdbhFOTpB8voHmUw51TDBcGn1+2huO8ncLrIfH5WzYWsmTa/ryWmyP6RCrrdVovcU+qBqTXXFd66yKR6gfrvPQuC8JTkq+vlwXZOgYtG0+fPcpLOzHEbcMa3JmY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202168; c=relaxed/simple;
	bh=Fe8zxGQq/7dCid2W89W5GWhcTNqPOSQenj/BB/O4q7E=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YghOGK5dg/Rged8i6fnwPT9nfAY4ZfXGBAOOxHQ4qRenCYH/raa7rZeQqLCWmVZbs2ZVv/heES+NUMViFxPCDlIHvsguzzckdYqE+h3QdUH28t36lgMoUPTsT+seu5u8SqgjNeFyRcM/e9wdJt314hP0d82t1JJ7rUV5kuFND2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njj0NpxP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njj0NpxP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e49fbf92aaso2360085ad.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 18:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792202166; x=1792806966; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:date:subject:cc:to:from:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fe8zxGQq/7dCid2W89W5GWhcTNqPOSQenj/BB/O4q7E=;
        b=njj0NpxP7PMMY9QiiCHu2ZMK5ZNDmcqLnqXiLZCzhA26eiXXHdA0CikuUD+zuPTfNw
         phtEfb42sCyThPfhrO6X5q6PkzLVvJjplFoZcMaGNqv8hPNvY/AJs7ZvwOLxNKh/IBsh
         gAzjDTJVHVj/FWyo6gbPWWDf48MecKc9682oSwdSyReHfgXgVbzhHMa1kcoV97p2lKZV
         FeKdHc+Mv1hp9GOWMLtc17PvFkpTKVdPXnmg5tSM/f/wfm/VQw5ZwV2WlfzXpMC0R+re
         TDpPD2mOEzyg81PHtX9pDJ5IcMFC7XM3gWYYsC5w8m8MWjpsNv/yXxbZ18+4oywd5MGG
         10dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792202166; x=1792806966;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:date:subject:cc:to:from:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fe8zxGQq/7dCid2W89W5GWhcTNqPOSQenj/BB/O4q7E=;
        b=DDFrqQV7BnooCkeqHRoRzH41iaZV6+Ur8G5Xl73ns1DpC6YDfbBV9i89svS7KC18iH
         Ld95BiQo3OrHo1qyKLHIYpKI6Nq6P/u8zu1PHnvROf2rQp+DMPgPSMqp0Js5czmRp6wt
         YaGPq/diH9mCi8M23QCYvGviEAaAALlHELvlu2NU/6rj1nMhCsSLpFGgcQ/YPPipJcm3
         RaeHmWX5vwFlV5b8JX4wfarO9XAfFQSTSP0zCZWbB0cQ4HwlFhykM0A9X6QRPnaoctq1
         vp0KJ2JEA9aqNcZXuF85xZU12air17KGJDOpp5CI1q18bV0/l7tPscg1oyxoFQRsCWtr
         6LjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJI1qyMb1VXMaWv5sMdmcDbwFJP4qsUJaTXj1wjTVwzYkhsZ6TP8Id5lgyTygLKouia9GnuaE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHPFqh0qqBxHUEftF0sdm5j6mB9ZwN+8yl2velcUEtqAnyLVsA
	jSzlgE7f7IgT5NmQbmQ5j4xpJMl5jJtdpPRXtjoLX7+2ObKV4fdsRO6r
X-Gm-Gg: AYBFou2GCYhqXiZP1I+nNu1KsjCM20pwREoh1KAZXPvWEzPphINZdT2bantgaN2n1z5
	RGt3yLPFcC4SuU/xJ1EBRfV7GHD9nYCQNN6gYPHSc6NhjqBUcfoNPJ9Sawpu8dIZLfP3XzEIVRO
	N1+2jsBKBge7AdJYPkO36VbCQ0QWBcKVZGP9x4YJcndi9GCha4UruF7/mtR61dIUpBoLm3Gg2yE
	BbkkBqDS2zHqxlnpRYEAMMMc/fDnXvnCc9VpEAAnEufDmH6shSWanHoP+kE66iX3ARuh9mY6snV
	NHwMHhhGLzED1ivsZxVkRX+T3at3c4kot9SzqdK3CCOtj4LROLV4AYU/JkTnyUZGi+SfETB4Z8o
	QGGKRdtgC4Y4JiScqsv9VKdt43Oe2N+Xl8KM5o3bTOYDOByHbw0B0hyW6MrzuXvgPXHvQh0z2Ef
	WseOrBbjMn2llJo+0rozDzizs5HkLRtnKrdKcdRAAtDGrVgR8uORUbMQFsPNv7ly8T0N/ztYuKN
	Yjub/JFinJZ4IusRt/pmQ==
X-Received: by 2002:a17:90a:c110:b0:3ab:f38:2b43 with SMTP id 98e67ed59e1d1-3aceeeabd7dmr1165560a91.34.1792202165738;
        Fri, 16 Oct 2026 18:56:05 -0700 (PDT)
Received: from DESKTOP-UCPRL76.localdomain ([113.200.174.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94794dd9sm11245327a91.12.2026.10.16.18.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:56:05 -0700 (PDT)
Message-ID: <6ad2d5b5.969afe5a.ee04c.f286@mx.google.com>
From: Zheng Shuhao <viennaoffh@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+e7f24354da9f7915bc54@syzkaller.appspotmail.com
Subject: Re: [PATCH] xfs: fix slab-use-after-free in xrep_newbt_free()
Date: Sat, 17 Oct 2026 09:56:00 +0800
In-Reply-To: <20261016152359.GA107986@frogsfrogsfrogs>
References: <20261016085536.591-1-viennaoffh@gmail.com>
 <20261016152359.GA107986@frogsfrogsfrogs>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Darrick,

Thanks. Re: "What if some other thread initiates the shutdown?"

That is what I tested. The paused autoreap dfps are freed by the failed
xrep_defer_finish() in the repair thread, no matter which thread sets the
shutdown. xfs_defer_finish_noroll()'s out_shutdown path forces the
shutdown before xfs_defer_cancel_list(), which frees every
xfs_defer_pending on the scrub transaction, including the paused autoreap
EFIs. resv->autoreap.dfp is dangling by the time junkit runs.

If the shutdown is already set before repair starts, the dfps may still be
alive, but unpausing them is a no-op: deferred work cannot progress on a
dead log, and scrub teardown cancels the transaction and frees the dfps.
Any EFI that reached the log is replayed at mount, which is exactly the
intended autoreap behavior for a repair that never committed its new
btree.

The guard cannot miss the dangling case, because the cancel that frees the
dfps happens after the shutdown is forced.

Testing: helper threads issue XFS_IOC_GOINGDOWN (LOGFLUSH and NOLOGFLUSH)
after the xfs_defer_item_pause trace event -- 1 to 8 threads, 0-100 ms
delays -- while the main thread force-rebuilds a bmap btree. Unpatched:
KASAN UAF every time in xrep_newbt_free() -> xfs_defer_item_unpause().
Patched: no splats, scrub returns -EIO; after remount the log replays,
free block count is unchanged, data reads back intact, xfs_repair -n is
clean. Healthy forced rebuilds still do the normal pause/unpause.

Thanks,
Zheng Shuhao
