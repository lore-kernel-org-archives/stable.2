Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6744E392C20
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487031; cv=none; b=GU+ekXOc1JpulOF3Ghav4MhGFp35GFx3Gcq3UfQ34GFUTmX1Y5URksxb1lWwX6iRFfm5kgap4tT2XGBh9bPNZzdWtIL3hMt3nZeTit7kDoDflM2OYaxg8+0WyyH+Mk+KQjXf0yo9gIvCwfGhSguOu+O04Vj5+GKWfba0F8dFNNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487031; c=relaxed/simple;
	bh=XF77qWOGif5zEk8H1AsZ8wT77rFF8rp8IYnHt2iRwn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAjkzZzK+abP4tQHCDfVu6s/5OW6mg944xDyAetg9abrvhzGE1MLm6aOyX40yJ9rbs5ZGca+mGiLO11GED086mvy4hVtCnjX4+Gti8x/eeiwVPJKhU0Sj8+d5EAamCRyWMC0hLXlk0DAa2RwS6AnT7XvYYZBdwMC7W5H6v77BGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=kDIZSABr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="kDIZSABr"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-868b3248b2cso2716199b3a.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791487030; x=1792091830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bK56KhP12nN+K16lwK99gcseDIqNs+bzdxiXAeZPNow=;
        b=kDIZSABr1Qih2tdYaHPCMt1tdug+IgGjqKOvZ2CG/bjeV5qXeUsWEP+H2UcBNnSOUn
         v7mQFGaIv2mQPPre3hZvZ/fonlxcv4QFSwkL8KBwzB9+WsAS1SThFYvP9GzgdLkgN+/a
         0fUyng06VtvNO1dtIGM9NQQ4ZHdmrVyk2pPa0pkxr0SJAXXycEr4uyBLq5YNogqNhI6B
         uqfEeXIZoJDsZbXwneDeFsY/FqVhLKdi1Gq30BvL3VyX37jYifMnnPuRNr85BRuIA5F/
         pUW0bW67D4W4jAOsDdHQ2emFC+uzyO5yzJiCMX33wsCCIPmiMkP6bBfRx3fD8mlqqw6i
         XxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791487030; x=1792091830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bK56KhP12nN+K16lwK99gcseDIqNs+bzdxiXAeZPNow=;
        b=jI4z8ZI495IMusCkM3iO+9RzOJrxPMVYBqHzDxSBZecXQcETECYpuEzZ8T0xp1PEuu
         8EQDKl9j05JLHhxsdmMdk1/yORLwnM4TdxCaawEJSTZR+77sKj+XD4S5PIRB0CWEzppR
         JEa28tl03+VYHpldBH3hCJk3Un0dUV+pDjdMDv2OPXpunKKd3JKciX0ErbQKg3jdAfcS
         p8nah6cSWb0mKmPfDQnC3BdYnFQi/tqBjfNxn5fyKWIg8123f1eb/OQxJFS7NAjZNvhd
         Us4wl2aLwtd1WIfylpFiAKDCD3NzkZDmelSoMhD3Md2EaDmY4BuPwnBDRI212QbvF2cu
         PeYw==
X-Gm-Message-State: AFuF++nn/itoof7WWgBW6tnihtRNG52+oQtKf6A9sfasKDwueGnRaCMS
	vbadeZxr3SpeQ0W173E1fqu8Kz514KrUfpH2C55qchrlgA8qyoczQFhhDyPkmn7QBioPwdSRZK3
	NR0Lt98JsGw==
X-Gm-Gg: AYBFou1Q6KmHvQ//CL9WjKo9ZolHx8IAPuhDpZK+qBivEB3x3UAmp5J7H96/hfuc1Kw
	g4BZGEZnowhyk1lVhJrUZzxBtQvJ8gLRcDLco0sgsefzZTWrKk/2ZM/rYRTNxHUYdBGQ/Baf01z
	LjDRX99VzEVv7gqmL8NT4h598FBl/6AnDuM9UuPnO1r6eHykUjxDyIyRH8aWZHhxySJBuoby9Uz
	NxVIWeDNRpLLvie2mUsmwVTk2vrohIItuhg7eS3YsNnarSCXfss+Z10h+z+9qnPkMrQO7nArFBW
	hbG7zHhO6/cHaIEYKxrI06C4b0juFArZLYb4HG2XWpQme0sU/D19L6TQMld/rs7FEvbh7MINH5d
	C+NEJL3BQMufdFAZrkQ0DGtdGFYfru/JpkPpuT5eYeH1+YEOk0pV0lm+ju2n2Q9lOsi4QejVjAC
	Vroo8+Z14Ke7c9Ps8bkZDd8Y3/eneQ+oEXC5up6l36WNCi90SGkeUFAkigjAfSk7xVr/n+s1A4R
	pTHIIVnHP0fChY1vMR/KmOoc3xRm+L4B1HJ7Ji3gEhmXQG/FfOZ9TXkYsWt+2T5y2xig38=
X-Received: by 2002:a05:7300:c00d:10b0:341:c6ca:1df3 with SMTP id 5a478bee46e88-3515dd78d9fmr8396610eec.14.1791486513944;
        Thu, 08 Oct 2026 12:08:33 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm80561eec.3.2026.10.08.12.08.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:08:33 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Hongbo Li <lihongbo22@huawei.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <hongbohbli@tencent.com>,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH 6.6.y 0/2] erofs: backport CVE-2025-68251, CVE-2026-53015
Date: Thu,  8 Oct 2026 15:08:26 -0400
Message-ID: <20261008190830.97970-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and maintainers,

I'm working through the smaller CVE backports still missing from 6.6.y.
These 2 upstream changes belong together for CVE-2025-68251,
CVE-2026-53015. They must be applied in this order because the later change
depends on or completes the earlier one.

The complete series is already present in 6.12.y, 6.18.y, and 7.2.y.
Patch 2 also affects 6.1.y and will need a separate backport; this
series contains only the 6.6.y patches.

Could you please consider this series for 6.6.y?

Thanks,
Artem Dinaburg

Series:
  1. erofs: avoid infinite loops due to corrupted subpage compact indexes
  2. erofs: unify lcn as u64 for 32-bit platforms

base: v6.6.157 (79643295eba17affbd16ca97f3ef04c90266b28c) plus stable-queue
revision 958ddf240a33ef26b1771be944f0ea6c3b597472
