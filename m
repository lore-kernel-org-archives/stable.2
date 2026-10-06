Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AE921CC5A
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261581; cv=none; b=Hyc+Up4cWuBFmTYzZEBg9k5nTSHHAvuRSJ+oDT+UvIOUi3O4ZqMo04GWek/QUx50246paiOeNODP3Gc55x9Z2zX4s/lG/cgxWjZuAaxecxENoqwEaNrHQR7TeMXVNhT4BTZIEaqB+/p+2fEJgipQlt2u4/EsVTHHU/KkQ4IBKvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261581; c=relaxed/simple;
	bh=5JD7+ZPhDwA00jru4odz0jKm6WnDEO3jxLkH4Krzsik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQZMJhcxBxEE9uGltFYffVfBYszxFs0EvuE4SXebB9wa40UN3hd8uwdexRdEUhwYIIOBLuPvck5tTNXeCgEoFyD1f9dMqfnp7Oxkvyj+wbmJFUEs0C5iR/WTINwR342QXRaHmYM551L/u5i3NDRq3YKlUaoCo4Nr6cexA0COxpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZVqtdpO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZVqtdpO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so1975565e9.2
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 21:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791261578; x=1791866378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DMg3LguqBid646gbp/lD4TVtZRPBVzY1g5dVVWP8Yvw=;
        b=QZVqtdpO62s7Z8VPmCKj0xhXjWmuw0lLl+yHvNFWdkE6aGUeS7Ash46ZsEjvuDfWh9
         EKMa4mvorycXvhM+1RgCV5fP0HJJ6WS0pCCA1uU8B4gsLktwlHlcChCFz9zzU+cb3jSx
         6gyHcV1DNX0wpsX03GNgnqUclc7qh/cXIWWyQ6JHxpHXdeEQx0uIZaFQ64Ci85TFkB19
         x8vOxvl0DFR0asZe44Dof0/KFVn0Iduk+XMVO8J7o1B4p4xvaDVP78WHO32mf+LeJnpm
         MA0VeDllfA+/rkOR+L2Q/1JddN/b04GWOJn1BWOKDaeysK1Fl4s7baTkPsyKJx1qg+i0
         o0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791261578; x=1791866378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DMg3LguqBid646gbp/lD4TVtZRPBVzY1g5dVVWP8Yvw=;
        b=TDz7pyb03C3kX5pZu2Dq52hnYj9ts/tzPBc9qV6PHZuLQ+Z747FGzcMzTj+RkVZB9r
         IhmHXRnFdjONywDDXcjtL7YZM3UbGZK7KQ6+Mo7Xcba7wL4q9YlE6Cv6e3yL81g6XENa
         t2Ri7gky3oHZp6q7iYgja1cqJ0oaW0O04cLDD1gZD2UCCE1NslzbJNJOkTbfoR0IXY+7
         qqFe85edraGHK0N/KXlips6G6S3FFXo14EUvPvHTFdck01aSuqRaOTk3X1PlhvQP5Ddu
         NZZp2dTlzjMjZ8FcfsGkbKB/NK7mQUFlAxGPA6yoVYkincTUSO6oqr+JFxQYdbEMZhH9
         Vmlg==
X-Forwarded-Encrypted: i=1; AKwUvBwe2vvFXcJq7Vq4XyDFFQfIeyLiGzouQowlwPmltz1SeiRnUrWP5LyenQwQ+P7ueF0jl6/T8LU=@vger.kernel.org
X-Gm-Message-State: AFuF++n7HhdJOMzKZzhGbD8YG9pbI6D4X951LbNxIX3sO0rgjzbKIDBN
	QsKRtLZ3ph0OgM1QqSIFGU6hjXALMuHa0cy9mJitEZZ1rCZm0yR6Nwd73SwUHhFA
X-Gm-Gg: AYBFou0pxHLJh90uL3eGS8OaKCCcztdvkhhd30rb8PUbsTJWzHAFYL3SJPBbNfU3iwH
	NHasmoHdqwxGrLhk9tMojSs3rnF2JdNHKQFeoOsSDfRWY3Fn/rgfC8qswgfhMPuEpWbEeXFNuxk
	kQaJepvBcu3BBGIzn2XMP2+wAK2ZuWjQKxKJ65UMTA9mYkS1dG8GQFG1KFfmmMtSSCsBNpxnyqD
	hw6AVKtX+J8xW4B+P5VmOgJ44RxKijUiyyTs7t3xvRfvIYwdFQlHEqLE8WxMJ+Oe4I1yh6INBAo
	H5IzX5OEidL/QemI5RC8Rlpve8dZx1oU+i3LwAIhQUM2b4S6vim1vns9Uo9FGHHIuDIz8JwYdO5
	/x9ng3aDqUTKGyPuCHQwMDh1TTqotSycZWeA2THOOjeL8vvnMN4f80kujlya8SPvVarNpXPLzfE
	Ay7U5SwSFlS6IUbolpiegNYLHVGyJFKgz1NgytaI4GaSeVQ6nqLoZN0hDVCv+Xsg/19jJ20U1kN
	Z80ZFvU1ItgpgRcYMvguWlE81NV6aPbBD+7HJDop2KEZQYNzMuthi9GEsN9oN4P8o18Z2zYgA+W
	Wg8+ohOaFzMWzDAEHdoB/I5aXJWR/cdFLug=
X-Received: by 2002:a05:600c:848d:b0:4a1:71e5:9420 with SMTP id 5b1f17b1804b1-4a17b53c11emr3202545e9.13.1791261577688;
        Mon, 05 Oct 2026 21:39:37 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-040-097.95.117.pool.telefonica.de. [95.117.40.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178db8c6dsm62744995e9.14.2026.10.05.21.39.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 21:39:37 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ntfs: fix two kmap_local bugs on 32-bit kernels
Date: Tue,  6 Oct 2026 06:38:07 +0200
Message-Id: <20261006043810.5393-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two kmap_local bugs in the mount path of fs/ntfs. Both only show on
32-bit kernels with HIGHMEM, where kmap_local_folio() hands out fixmap
slots from a per task stack of 16 entries. multi_v7_defconfig enables
both NTFS_FS and HIGHMEM, so the stock 32-bit ARM configuration is
affected.

Patch 1: check_mft_mirror() unmaps pointers that were advanced past the
end of the page. On 32-bit ARM this clears the wrong fixmap entry and
the mount dies with a BUG a few calls later. syzkaller found it on a
multi_v7_defconfig kernel. A fresh mkntfs volume reproduces it on the
first mount.

Patch 2: ntfs_check_logfile() maps the same page once per loop
iteration and unmaps it once, so a mount leaves three entries on the
stack of the mounting task. After one mount the CPU it ran on can no
longer be taken offline. A process that mounts ntfs volumes five times
hits the BUG_ON() in kmap_local_idx_push(). x86-32 also warns when
mount(2) returns.

The two fixes are independent of each other. Patch 2 was tested on top
of patch 1. Both were tested on 32-bit ARM and x86-32 in QEMU. Details
are below the --- line of each patch.

Karl Mehltretter (2):
  ntfs: fix kunmap_local() of advanced pointers in check_mft_mirror()
  ntfs: fix kmap_local leak in ntfs_check_logfile()

 fs/ntfs/logfile.c | 11 ++++++-----
 fs/ntfs/super.c   | 20 +++++++++++---------
 2 files changed, 17 insertions(+), 14 deletions(-)


base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.53.0

