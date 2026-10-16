Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C66138C2C3
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160190; cv=none; b=ExwzkDreXVzwQbQ9HYciBaraK+qJ0SgJ7yp9X3juDPHEsYK+dRxUF6du7YImzM5EK68QfqIJxldwk91TW51MX6f184t7FpWsPzS1yF6IdPAU9iUC6C6R2k2V6L2ZK1vk59HzYyvu5Ze9luW6ETGQVa7kwexEPivPP6fh/dBU0oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160190; c=relaxed/simple;
	bh=u+fkloLOEBfCZ7XVJCKiDAjDI+S6TUXHUiE+ew62bSY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FjaFb98QWUdzcqd1sAhV3rEVzWxWxQjXyVbWh+ZEBJFMw0pbfQ8rJC/vTZB/ZHUUAkcQg4wMwgtrby5MtcwF4ICegqMtR7wi+MCSmagg5EVUJUMIlBN1Uxb0UpKwtUo6G8WUtM8+Bdxo1jJN6tsaSav7xiSEEwY3RxYlX4YuB2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGJmYFxD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGJmYFxD"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e86dce4510so33339685ad.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792160182; x=1792764982; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:date:subject:cc:to:from:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jZ+mTiIAxhmwhKCyjV/xAz+dOI1Ti4dVU+974wnLdYQ=;
        b=rGJmYFxDrkf5xsdfC8cDPbrm/FYYMNsH7xVvbsXFHUilUakaHARLRwDtaXnthEkJju
         Kn40s4sQeeYqwo3DY8MUG2h3Gf9Dr8/Nub13Ai5SJtCNHlCd5U99M1qJiMElHjU5EGxz
         fHK89k4E9WPpJyCGtwzVl8C7L36f68pPxIPpFLblGSzjARjM6xWy9XhV6brrRqSGt10s
         mLnEAe8MITUSI/RVPELjwVNXnT6Bdr1wX2Q5DeFCKM9NJTJq0WJ8xRWd0lYni0Ivdmhe
         bei3hBQvKnoS1h1FP2suvct3slav/YvIARdtkDdAFdvzG/sylu/9fowwYK+klsYFdwtZ
         LuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792160182; x=1792764982;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:date:subject:cc:to:from:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jZ+mTiIAxhmwhKCyjV/xAz+dOI1Ti4dVU+974wnLdYQ=;
        b=ZBlzCLUeN11/tG0asoQJDWeScBTYroJdazvVORpO5zIx17CFvR5mm3Q7UJYvJXuJtC
         gLQcedMWTWKPgr1g2/KKAx5JW8Z19D7lIiNRtFgdc0GW63Jhaz1Q+bk8oBgZQ6EXfas0
         hKBMJueaRJIVbnjzuzwUrsPUMucudkqeH/b7bCr5ixiuwKXSCOo7ZC9lc0BCsgr1PYy/
         dPDHChs9EGhugGumHB+g/qMvq2DgQ6iNZeZpQcm3OAdM6jsFh8qQ9gfOzeMpxMi215qM
         AFnvpFQ6WfMdau3pS5pM4h40nBwBaJs37qbCixXqTNt0QjRzo9+E9DiJnnIhw9+Qdp6P
         eWNg==
X-Forwarded-Encrypted: i=1; AKwUvBzMY2HSlS+Hh6QM7YJTfdeIBaPxBgq8TYHseAzMOZSpcmQkIZeQQtMU3EGGu3bzWeCs/Rg3tXU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRJwhB+FQJZ6zFJ90LXlManfokq/7HvmXZFcwDksT3zXzws0Z9
	e/LvSlH4KS9xfitfLf/K1t4q4TZEsJH7p8qKL38Q+ZsZFyBI7lFbIXaM
X-Gm-Gg: AYBFou1g6svyyXOLchWLz64HjWYmMK60o3+l64NS7tm7BTz+XzPWaUwtvkNljOEny6H
	wX3XuAWReYBQp2uxw0+ORy0WspQZVMIqM085eyXgis31lR1drc3GuDQw3Ea66vUZSggp/aYtS4B
	QqiuFrD6QSHWtjJ7mwg+JC6+AQlT9ZlMpAlcEzOf9u5GfygqlKal71BieH6Hg4f8PpzU3kkX66L
	Io3MsHFn9zOkraCfYXih+e21foamEaMkCUZs1w8YNRrPbMxnwO+vcQchTKA1a74qsObPjM60DB/
	4QATKCNuKFIJXfZbvzM+NqqrHtdxJBP8HofSrgdXhxLYayHPXYAsZ6czI+lcdy2pWeoL2fqh8S+
	/sj8+Bppgd/uY03qlKQYQwIUacBx4eWbXqXtLZ7XapKJHbUF+3HKlDuxlid/wOZdcQsofSMCYYy
	y9X07DfmpT1zzSJYghoAnBVCjjIokKbimY0jj3lvGMuu0uzqw/7lExsE1Xis44Mo8KAdLGNurZW
	MWaKSb9DjV9VKq4HJ0VrA==
X-Received: by 2002:a17:903:2f86:b0:2e2:ffcb:87a9 with SMTP id d9443c01a7336-2e9a68d9693mr992475ad.24.1792160182121;
        Fri, 16 Oct 2026 07:16:22 -0700 (PDT)
Received: from DESKTOP-UCPRL76.localdomain ([113.200.174.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87994bsm10854635ad.60.2026.10.16.07.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:16:21 -0700 (PDT)
Message-ID: <6ad231b5.6655ddc8.1e37bf.a74a@mx.google.com>
From: Zheng Shuhao <viennaoffh@gmail.com>
To: "Carlos Maiolino" <cem@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, syzbot+e7f24354da9f7915bc54@syzkaller.appspotmail.com
Subject: Re: [PATCH] xfs: fix slab-use-after-free in xrep_newbt_free()
Date: Fri, 16 Oct 2026 22:16:18 +0800
In-Reply-To: <atIj2DeA3TOMJQ2-@cronus.toxiclabs.cc>
References: <20261016085536.591-1-viennaoffh@gmail.com>
 <atIj2DeA3TOMJQ2-@cronus.toxiclabs.cc>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Carlos,

Thank you for the pointer, and my apologies for the confusion. This is
my first patch submission to the Linux kernel, and I was not aware of the
known-identity requirement for patch authorship and Signed-off-by.
Understood now; I will use my real name for all future submissions:

    Zheng Shuhao <viennaoffh@gmail.com>

(vienna-0FFH was my GitHub handle only.)

For reference, this is the testing I did on the patch before posting:

 * Built the patched tree with KASAN + XFS_DEBUG enabled; checkpatch.pl
   --strict reports 0 errors and 0 warnings.
 * Reproduced the use-after-free deterministically in QEMU on an
   unpatched kernel; the KASAN splat matches the syzbot report exactly
   (xfs_defer_item_unpause <- xrep_newbt_free <- xrep_bmap_build_new_fork,
   and the xfs_defer_pending object is freed by xfs_defer_finish_noroll).
 * With the patch applied, the same trigger produces no KASAN report: the
   scrub ioctl just returns -EIO and the shutdown path unwinds cleanly.
 * Regression runs on the patched kernel: all metadata scrub types,
   invalid scrub inputs (bad flags/generation/agno/type), and forced bmap
   btree rebuilds from 5 up to 1500 extents (covering both extents- and
   btree-format forks), with read-back verification of the files. No
   regressions; normal scrub/repair paths still succeed.

I can share the reproducer and test scripts if that is useful.

Would you prefer that I resend this as v2 with the correct
From:/Signed-off-by: lines, or can you fix up the authorship when
applying? Either way works for me.

Thanks,
Zheng Shuhao
