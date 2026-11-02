Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625260;
	b=3JtT1XSJTnXHvGVmlJE5AvzBqZfhojiRhjZO6K8ceMGYCJ2AIVxp2bKhI9EHPH05VXON
	 0A4JdbuNxTTYltdXiLiWutG3SL9LwU08VhjNTjP7MJiNmPlmL0Bl1I/soH2bijJNCj71L
	 PepGibFw093L5scSmAqRle7+TrJJ1kTpZSVczZmNpnZ9O1q6uPPUyrF/51oPF2YCqXY2Z
	 cAlQQ4sBgkepg2ABAaGiD/m4IPN3fnVF1fy9kAseefTv49TwWlXN6TQoNguvTo60b5pSw
	 Y0X4CkrOUl7ol3R8zQC3w/FBazVvH754YL0sKz1Gm/MGk+pHJEYayczeyl/gnHldwBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625260;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kTGtskkzFNm/uze28ayZ+fevtF8cgxfFpWUG/kR5BZI=;
	b=jXZGlKRUkuBrnFkkdvh7pD6Y2FNT4kmjb3Mdde12Scj0aV0NJP9kY52njl+9TmuTEhmD
	 hC/C6kdimh74528NiDDpa12b682N6PU5NGVxO3RGQJhgDhohfJAfm+IG4KCV86pG34RBI
	 qSDu4a7parWV/8T4be8spzsqY7JV6/wc8zGqn8CwBSNQ9bOmv0L5kJZWX0c8iniCIblsM
	 JIsNqfnwwxowYsZBf77c4WsWBQIbXfmp+EWppdzXiA3PSMiAlpKkfAblCmLhR0bqaLOVJ
	 tlKJQ09eU4mwN8BjPapv1SKzR9QYFSFTcML5InAdT+4urgCJI+ccNvyKOx27Pf4+qEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=bKVbfavn;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA7B606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 13:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EA7B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=bKVbfavn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=kTGtskkzFNm/uze28ayZ+fevtF8cgxfFpWUG/kR5BZI=; t=1793625258; x=2108985258; 
	b=bKVbfavnv+39mOIhb5BKrr4qgMiDv8Rg3RLhbhryjNmezAclOHyehjc5F7c/1sRJFaiaKNuE/dg
	+4q+Jlq2v3F2hSRsVJsLEhDqprwTBgG/X1stBJt8U3hBszZNgOgPBWW1oajtfcGsOyqm4ybJqlvdF
	ekMx6Q55FgVNIwxUdN+YbVtTq4TO9Q36DLwQ97DsBUsJBNyqI6eqP50dD/eb8f71wwGJ3jgdMsZBf
	1+iDIgiCJE98b0VhQkJWvwzhORJiqzfOga+kSyLfhDKlPGRCpLuWadoCiJkPvGsyVgSR7mAiwWlpU
	AiNnS2xjJ2bkItkYv4x5Kjv8gOH1ZTbSxGmw==;
Received: from [179.105.94.163] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xNrrT-0009Eu-VU; Mon, 02 Nov 2026 14:14:08 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>,
	Iago Toral <itoral@igalia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: Widen cache_clean_lock over the whole L2TCACTL sequence
Date: Mon,  2 Nov 2026 10:13:48 -0300
Message-ID: <179362522211.52532.2556381030815772891.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260707200738.659002-2-mcanal@igalia.com>
References: <20260707200738.659002-2-mcanal@igalia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 07 Jul 2026 17:05:48 -0300, Maíra Canal wrote:
> v3d_clean_caches() and v3d_flush_l2t() both write the single L2TCACTL
> register and poll its status bits. The mutex cache_clean_lock exists to
> serialize them, but v3d_clean_caches() only took the lock around its final
> FLM_CLEAN write.
> 
> These functions run concurrently: v3d_flush_l2t() is issued from the
> BIN/RENDER/CSD invalidate path while v3d_clean_caches() runs from the
> CACHE_CLEAN queue, and each queue's scheduler uses its own ordered
> workqueue, so their run_job callbacks execute in parallel.
> 
> [...]

Applied, thanks!

[1/1] drm/v3d: Widen cache_clean_lock over the whole L2TCACTL sequence
      commit: 994ba6e5c87d6a3d471ea987fe8622168f092334

Best regards,
- Maíra
