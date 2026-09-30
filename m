Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88742457E5D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752977; cv=none; b=jLdwLrZ/CNzrkq+jQ2rGNOpKIUeWTpYTYsa2eqxSUi6oE+upsrBx5DpgUTcy9V43vUOkl/P/nHONd6PBXM+R8FWGQBPFgKCgMnGcWhf1sDRBjrqUQaJrWz0oBf7z+hiRkJk3/Z1FJBMNpKKMY2EuQNREEYAOYbNzAToOs+LrhLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752977; c=relaxed/simple;
	bh=W1/LVnypA/Fa1aCBl0ZqrQ5A0oO0YsvOH2E8+KStOoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvjoo5q8DKwf821QcOxqZ0QUcUweE7K2+7bEikHMKJmrUXcfXm03hAHB/km/uKxnQbh+/8BizyTSp00d8IwpnBZBpHnfDmEL0JOU4wIQx71TqFHizdbcgzAMrPK4jNC5FYYPhnvxgy/zHVTeZG8doSifbWZfw6+TBPDqaEYVPmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKooYsxu; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKooYsxu"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7cadbe09dso535289a12.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752976; x=1791357776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W1/LVnypA/Fa1aCBl0ZqrQ5A0oO0YsvOH2E8+KStOoc=;
        b=OKooYsxuxS7mVDS1ykhNyBazFIJl7y547ngTCQA2R52NjYlEFoQajPS6A1oM1C0u/C
         YK2WM+qjAZt75vUYmXc+g0TRpInUL3B8n4EQ/1DEMx0FHhVKSWn4LOviAounEE6g29Z3
         fV0/xAPpHQP6flJp6fCOcRGqfwZ3pjdu2z3Y0+oxFH8/m7lfxK20O15dHYzZRsqCkjdS
         mcInj2+aQTdcP2xRSr8H9frycNRepsDr258+juLkxJYODGnJ5DCJoQPCI+yEB1ojYU8f
         PK5i0KjdxGesex4fCdHxsgTFe2s8/wDYjkyTVQ7+xrfHcgpVdQVda35RKv0lV2GvyK2O
         i6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752976; x=1791357776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W1/LVnypA/Fa1aCBl0ZqrQ5A0oO0YsvOH2E8+KStOoc=;
        b=It2WPCqguFESt5ruP3r6gvTt2N02QX5VDcQL/W9QWgxwIDmlRS7P36DYqzfpIWccIc
         z26srLmwZlhCazRiAOa11ZBQb1zPk+8H2jC3feDverltWephow15AJAPC/sr4MK5I3Gn
         8g719tt8puOYVDmEePeeTeu1MYX0NJrJxhkxcndA2vk8o7pu8Ourhs1g3dZ6xv+mRQfW
         dpwooZj6ZOdY/rDMghfTJV99pZbBK6R1bCtuh0oaDinQULW9prgTikkFaMxmL8NkSXQO
         Tv/++DmkBrgAcn78EYHrfbW9wCbr4UER9cdyn/5RE/RQYu4+ugVNvwn1U3vz6NFFT4Kc
         YRwA==
X-Forwarded-Encrypted: i=1; AKwUvBwqIAyOA7NjXWuk4GIYwsqYgKpvFvMHI5nQkJSuXetSIU5h5dtDIcm4NPTA5qsIUdvCM84yG7g=@vger.kernel.org
X-Gm-Message-State: AFuF++k73b13e+6ntNyzj0F6q068C6zVcVIgQcPV8aPnGGQyE+a7e8ht
	4NV08tbasZZ8SIcb7VpKNtAyYulzqFFQwz0G/R+lDwRQKY9kpzwDffIE
X-Gm-Gg: AYBFou2dCP7/ZUIFX7ZvwfieWSlWlI8b99AZVXraDUQ73uIG+5MK1SHqyATD/Sysy/X
	44+sjTtGDz93ulw6mZkr0aaa7/Q6xp/HCX8Zubf1+SsMyRLOa7PLR/HWUA6HZa4kP60T7eVyQOi
	SOGVyZFJIxFqOBYFFHn7/N2LHu+WEKJSVdqd3sWIiDIDl165d+S+UoDTqA/sLfsl3c7UPk2CLl+
	e4begPrab6YZJCGXo7uz15HAC8FssRRZAwJnZQH6E9VQ3hWnjicJzqdzLUoN0AyEavqu41kVmkZ
	ETUzxH1wBQlSUNqhcebE+5sbbw9DAmUjU0qoP6gSSUK6S21v7bhpT8mIStf/LDjis5MJzv/AXDb
	hpn5FTOp8x2WCqnAuZ5m8IyiFExDXZo5pqMr2l009YfnAW4XSw/g0TAhINW39vJsKV2Ae4UXx4v
	sFQGhXmNLODqB2K8ZT0ftd3si7MNxb52frvzyb+LcRKg8LDZjfjnnQyomk8ssYv2QMSE3iAKCIv
	UpAS5KBeCkxbmlOIRKiMSI9Tk2yMXfEhl+hCgQaClAX/lIvJsrwSLkk4cGMLjHsD4q+ilF6q6QE
	yHk09VFvQRev96woOuvbP6sjPlhd6sNS9fcblnxPFlH09RhhPKK6l1P2MeE=
X-Received: by 2002:a05:6a20:5681:b0:3de:79fe:142 with SMTP id adf61e73a8af0-3de9e6ef0f2mr581578637.49.1790752975531;
        Wed, 30 Sep 2026 00:22:55 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88725881fa6sm342045b3a.27.2026.09.30.00.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:22:55 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/6] qnx6: release bh on error path in qnx6_block_map()
Date: Wed, 30 Sep 2026 15:22:52 +0800
Message-ID: <20260930072252.1167730-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930031604.70544-3-benquike@gmail.com>
References: <20260930031604.70544-1-benquike@gmail.com> <20260930031604.70544-3-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested as described in my reply to the cover letter.

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
