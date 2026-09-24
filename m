Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF1B45FFD2
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244716; cv=none; b=Qs6EczN40f+oOB8Jzd0OuE5mgzMm9SoIaGtM2UfwI6xc/tkqvpx4Tv+pjfTurHP+2UFNVtiUriPFDPM7fnC0Wk0E7Ynl6C4BnVaxUyoyYMHhNWA7lO5G7MsFAqauG2EjP+VSYEZKIfOhFJOITl3RdbTiKNH88u2otz5J2DaKj7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244716; c=relaxed/simple;
	bh=Nc++9B0b2Rw64hQH1uTtHtl01UfhcPbPRHWlll6r3Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBNCRzJV/P0tiSxIGXvbfk/XVAi8GWqMYGqr0cR79avpc3xtzzf730JyC8VVlHozPyHzM+dVPYcMR7wnDTb2j8uMkHaErM2Mnr7N/7ONOL0vmN0RowIIdJy82WbZNahRKkrAedbG8XsC1QG6HxFCRc4Wtuvtk+mTvqVyxcx0G8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evXBZTV7; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evXBZTV7"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so1139923a91.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 03:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790244701; x=1790849501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5bJLApz7a6Sj13/KQXZnv/qEoqKgMiQN8Xc7a1Ahq80=;
        b=evXBZTV7OUxqvWuG2xpT4JlqhvV/BLjIx2yy8zN8G86lKiwODvQiAKwWDClcGKy56Y
         DJn1hCA/t70F2zN/wYtrO17QkyMU1HLizueMxp0eq/g0UMsvle9GNBmnceT+3hruPMAW
         ENfbbKzl4/v9Zlu50C2jt8BXt7QX4qMW1R9wCzD2wTEt0KKzujQiimcYtRZm/uz5+M0w
         SzgpMNN6RxvIN5tA5hRoWVtMFGSkicMJcVPjoFqTWVfqIM8dv/Yaewh8vcPSAd//usOU
         szA7YCUSnpKBZrgGcn5EjeJhaLcaVz9MD0v3+68/PsKzMclGTMLVMbbH3vEpN/ZEh5ud
         12Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244701; x=1790849501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5bJLApz7a6Sj13/KQXZnv/qEoqKgMiQN8Xc7a1Ahq80=;
        b=N2YxMTJaPu96F2VWHv4hqCrWBpm2ISwF5qETrlKd9OU8E0la0Q4uKL0hsaj0qk7xUi
         HcqsYK9Y6iB91dIuNHVKA41EEYorJ6Oh8Ds88D5UD1MUJLWQH2KXHx4FKESFqOJF6Pdc
         pdU21/sp3vdP/HiXgK0f67vCBipsbFKizbs3NOhVQVEkaJIYzs9ybvasdB+Wd4bPK1u7
         90BXZapcOsJQdQg9A/iWWaWb5U5vGm7WbdRwAhx0et+5NZeBJnP09CzxO8sd7ir2w+d7
         IOY+MwSB9rbQ8+nIC01JTUGu7RodmA3oaJG0W88KQ4oeJTYHGZDLtmgqJLOYmS0y6m4x
         myHw==
X-Forwarded-Encrypted: i=1; AKwUvBzewkcJnrk7gkid3TodUe/JH6D1M0d8kyz7Fb4YVYzpZEz0Wv1jr90wIW5t3VsdcsrAc4awLuQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m15ksiwGHwXMNR/odoL3YjDz7OlYsjNwPEyXVBPKM2Fo3FiVvd
	8VvT0bu8X2Kncr6cscobt7BMM9QItdXS01WnELrojsc4KAsSwQIIEaqK
X-Gm-Gg: AYBFou14mlC99flofqu57USluHpNetc5LIHclIN3AUyzp0urvPqrpSe5Ab2+U7HGU5K
	quEHiEL/Q7D3r5CtEkhuZro9Vvp8yjh75i91j/ZObEoq1bp1j6yh77FY4OeKVckIEqe7DHwuJod
	s77vczxVRgUX7NzmnPSAua3IEVQ22a/1QPB2mgjPK61c0D7lOty7ccfn9+27iQAQbhLGbVC11Kw
	f0G1f234p2Kveyye4jNsSyzF+zzZo/FmFyUJQtrFU+t/ZKepaqBoxf1T2pLJulDmfX+oZ2mC54C
	UDKFRg7Gha7xDvvY7yAvgik7BF3bYLG8yqN6+DGXLOJ/6CN9RCqr6EPksqIRrhYlpRvqHAfmW3D
	cF5uEcoWsEhtjimXi+00efbN4yZSG9Aig7lm7K7DOwyNH6xNvsnCXaTh8f6MSDhnmJOR2pwKKAE
	fkPcK2SrldaIDjpd3AXr1gmA2JC/47efpZW88WxMO+pOn/Ui6WOzk7FdF9hDwnWH5GPnk2YjMKv
	kghfNNJvxsVSFzocVTAohojvqZ8VTyVEF6U2GcpUaeyjogF18WTrfC9gqu/Ix53Ks4qpltFdFLw
	ouwFMcpacYRaO4guQn8pizL0ESREL2peRbKtVv3Zxh1RGdl9mUe6Ciwn+W4=
X-Received: by 2002:a17:90b:4b41:b0:39e:4c7f:7307 with SMTP id 98e67ed59e1d1-3a098b8ab32mr1639460a91.30.1790244700743;
        Thu, 24 Sep 2026 03:11:40 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec5dfsm4075446a91.3.2026.09.24.03.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:11:39 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Anders Larsen <al@alarsen.net>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/6] fs/qnx6: fix buffer head leaks, double free, and inode validation
Date: Thu, 24 Sep 2026 18:11:36 +0800
Message-ID: <20260924101136.2380154-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924073920.2782917-1-benquike@gmail.com>
References: <20260924073920.2782917-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hui,

Thanks for picking up my tags so quickly.  I tried to test v3 as well,
but it doesn't apply to mainline (40288c9206c1) or on top of v2, and
its context has code that isn't in fs/qnx6 in mainline or linux-next,
for example qnx6_inode->di_ptr in 1/6 and the out_sbl1/out_sbl2 labels
in 3/6.  My Tested-by and Reviewed-by were for v2 as posted [1], so
please drop them from v3 for now.

Which tree is v3 based on?  If you can point me at it, or rebase onto
mainline, I'm happy to review and test it again and send the tags for
the new version.

One small thing for the respin: the 1/6 commit message says
QNX6_PTR_MAX_LEVELS is 3, but include/linux/qnx6_fs.h defines it as 5.

Thanks,
Matthias

[1] https://lore.kernel.org/all/20260921042511.1473629-1-benquike@gmail.com/
