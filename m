Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0888305674
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430460; cv=none; b=R7u7CLYp+6MJoX7Xwrf0D+DzwlBkxmYlszckE3ceehoN1V72obnKoLUut0uh6jCZB4Ih/OF9kxuEzTknN7KqmbBJJPnu/d+1OeFODfk14bBpC8d15xNbGRvav8DbfO1Yiq8pSqNYC9k0pkDlosacsFX/EoPnpcAtk6FJv5T8Iao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430460; c=relaxed/simple;
	bh=tQFF9BLw7VOfvbaawIs6NuKTflkxcILkdgKzZb6bEAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuPOKod73TZKJNU3w4PXenQ+mwV/V10nJE7CTsf5kn9hTlIVsDB0r7rnmwYTDYSbCoFouhI+VpLifATvBz64VP+tSgqm68O3bXwCQAlD7daX9K3CF5HKDgnI+dwNn5vNdSaAU39K5NkNY4gYGvYuz3GtHUQZBPzRJJAX8AQ4APo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjGb0v41; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjGb0v41"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-3396cec93b6so2092519eec.3
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790430458; x=1791035258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJYMhqDKm5GhyNvxQ9MB4u6a1fm3m9so/DIypwQkZ0k=;
        b=kjGb0v410zY+XKDVSfYy+MwANYt4CaWLllOe2X0dvUlwzdRwltVXC7RAmgR1iFSrPW
         j8ojs/ixW+CbCy7THPvOi0zaM6So38nUWj4I5+YbKWDzVs6EkLOYdQpGbizR1/IGeeLZ
         OVBqSVpaI7VpZmTBsRM/oH3+wTzphdotVHekd5xuzyQZZ5mx5m0KfIhDXPTaNL6p9CFt
         ZINw7g/yxbUVhRUx0Nikz+A332Tg4B/dQ/zMru/XGFFXipnQaKS7/AXWNyw79lVHf+XD
         MekjaTPmrSRuz/z8/pr8h2ek3VTiOhWNayf8Kfj5nG0bd2joaIJJL1equE/qmt9WFwlt
         1cfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790430458; x=1791035258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aJYMhqDKm5GhyNvxQ9MB4u6a1fm3m9so/DIypwQkZ0k=;
        b=RNNCFvwf5uAjGC5DGU83t9jIGlikrgX65CaoswTTof1U7M5lBaprXwJgBvk/pm+EZK
         KlWo/6g7LChxs1iRpM6rjurp4CL+AAHgF4VdgzPwasi82a00bRjJSxoO0J193V9DykiS
         kQQ2DMCA+LT/1Ctx5LJkEE/tsrQXmwQRFBPya0jVO0niLXbdQvfs1GqP7fCXbf5FZyPL
         zXXFYUQCXDtw331aEB1s0cMK+gL90UXzK145S96uU/z1lWRgqCazmegwlxshbkpFvrhA
         OBN7QojUzWcYXe8wzpX5CL8PBfSNX/l1WP/Ilr056a/y5OJ4piIc641f+VOQKpHFqKEw
         nXmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGYqYfdQhejXkooqzK1ibVHjHgDGT7HeUhaoG0BG6mp1JXTqEe8GfSDa/PONA0Yne87Ecef80=@vger.kernel.org
X-Gm-Message-State: AFuF++lwcj2fWfVMOVmvfN9kII8Wj6Elle5TGQ1wx9HPIDtzfuxnV5LB
	hpuNzPmIAlYMv1PwioNQFGVdwtXHW9ziczMzq0pYwWImF9pIyGKoTLaa
X-Gm-Gg: AYBFou3jnd0FTmQfEWK27HXZp52L2vvj2hpZFIdVY9BcCX4t5O63AHaatoMpqhjk3JA
	TasnuDJIIwvV3dUovtEYXAAF5H7HUHid4jYcaGCYNTigqx7iN8gY02MJ0XA0NGUXB80zIlnXpaM
	b/Ja9801MHLo4LgUbSSaCkGMhL5Z7DSqbqf6rHPA1dbv0+TaIIOB4J2dd/6DPfHZVpnka3lELFX
	736RC0JfiPY4PKYDkM9v/qCGLH9IemB2iUCEyamiSeZCD/HFruZZlHsCnbBB5Cy/GMdpHrlexFv
	DALO6x1vZBgeaIcVLizErNoQGhB70gcLFE85K7Cx6Nx2SgrcHxtxJBZVgl+2E45odhLt59JASez
	SaWBTHZck282CzDSPYnBy4OqTulvhcfBISAKE7R3YSD7sCt3Tj8W/LZnJXogtRHMyfVjjW/LqDo
	hnMZNBwJB7ML4DVCayzcWfrFPO1u2k4O6CMnIIDzR04icYzmUYS04+4q7+4Vt6d6c=
X-Received: by 2002:a05:7023:a5c:10b0:144:f9e5:c355 with SMTP id a92af1059eb24-146d058dcb5mr3102537c88.41.1790430457523;
        Sat, 26 Sep 2026 06:47:37 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm14942565eec.17.2026.09.26.06.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 06:47:37 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2 0/2] debugfs: fix UAF and double-free in debugfs_str read/write
Date: Sat, 26 Sep 2026 10:47:26 -0300
Message-ID: <20260926134726.1063068-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026092647-ebony-unlatch-d3d0@gregkh>
References: <2026092647-ebony-unlatch-d3d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Sep 26, 2026 at 08:53:06AM +0200, Greg Kroah-Hartman wrote:
> Did you forget an Assisted-by: tag here?

Yes, apologies.  Both patches now carry:

  Assisted-by: sashiko.dev <sashiko-bot@kernel.org>

> And how was this found and tested?

sashiko.dev flagged that the write path uses rcu_assign_pointer() /
synchronize_rcu() / kfree() but the read path dereferences the same
pointer without rcu_read_lock().  I then manually reviewed the write
path and found the second issue: no mutual exclusion between concurrent
writers, leading to a double-free of `old`.

Tested on QEMU/KVM with CONFIG_KASAN=y.  The double-free in the write
path reproduces immediately (~3900 KASAN reports in a single run with 8
concurrent writers):

  BUG: KASAN: double-free in debugfs_write_file_str+0x194/0x200

Full splat is included in patch 2/2.

The read-path UAF has a narrower race window (just a couple of
instructions between pointer load and strlen()) and did not trigger in
KASAN testing, but it is structurally obvious: the write path calls
synchronize_rcu() + kfree(old) and the read path does not hold
rcu_read_lock().

> And what kernel was tested, debugfs strings were changed a bunch in 7.1,
> what bug report are you working off of here?

Verified against torvalds/linux master at v7.3-rc4 (commit
6812ce4e4379, 2026-09-26).  Both bugs are present in the current code
at debugfs_read_file_str() and debugfs_write_file_str() in
fs/debugfs/file.c.

This is not from a bug report.  It was found by sashiko.dev reviewing
an adjacent patch and I verified it independently.

> and shouldn't this be multiple patches as you are doing two different
> things?

Agreed.  Split into two patches below.

Aldo Ariel Panzardo (2):
  debugfs: fix use-after-free in debugfs_read_file_str()
  debugfs: serialize concurrent writers in debugfs_write_file_str()

 fs/debugfs/file.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

--
2.43.0
