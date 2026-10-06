Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9977749D5A3
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322590; cv=none; b=aD0Tuupz8jT9UcB3nw3txuOJtO1OA9NeYcnmiXh6ItNRGpIJr7ptYWqqLBFtLufGJatEgMdLd3A4hPwOvvwoVC/+8f4iCSUYBCpeqN6LeDKD/ohONK70Tjph1fS8AJCHXhLWt8z4YRpR/QyuwcP6V6lyInu9JJVU9FcRaN23azw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322590; c=relaxed/simple;
	bh=N5TgGKx5m31O/mPLv+3CBYOW8sNj2IWJVum70H3ZFBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBKpw3SVcEBj2M/jewjs75xwahpzCm8Hm0d8KJNfnP+toLQwI8WBi9dBI3mHibpwpjVwqe4mjM6XWmczb0Vc16n5MGwBvsYSpbGR7xqeRmkoCjs1w/nCE9Rav6zx8gk03lpK6Vz0FNddfHmRd7dDB199PdjXCjupjTirfzT/obU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lT9n2STA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lT9n2STA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B016F1F0089C;
	Tue,  6 Oct 2026 21:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322589;
	bh=LDBhAUhPbYAtpsIsnb4FK5rAk3mUFJa9SCOXScvfWaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lT9n2STAdyYFo6gzvAZXdZdCOwJA6qs5B/6SMD/cmB2QH3o1eLyxVya8uhj86szxi
	 l3HgHjYNZ3S07+WXVGQcyqjk+0sIR1yc4PZJwSMw+1eil1qJvVMUSRE80Vz5up+Qxh
	 j4LVu32qsS7H5lVi8FFtSP2Jd/MiTZynhEQKHC1HNdegoQaMcfTjFUCrQZr0MXXHfr
	 O4g0cAnl1RlC3LpwEUJHou7htpG1gpc3esE14u+Q7bO6Icm+EVgfg023vG+Qx/zWqN
	 l0yQAApHV9hAv9Jl0ZSjyyHSy2teNkVBXhCeu7DBkvziu65nuPFXqBDBehJC2HmSFG
	 xbCiHuikHSCEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	mehmet.fide@screeningeagle.com,
	Mehmet Fide <mehmet.fide@gmail.com>
Subject: Re: Please apply 68fe2faf5c69 ("mtd: rawnand: vf610_nfc: fix false bitflips on reads of erased pages") to the stable trees
Date: Tue,  6 Oct 2026 17:35:44 -0400
Message-ID: <2026-10-06-1-daily-reply-0012-vf610-nfc-erased-pages@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005153956.238827-1-mehmet.fide@gmail.com>
References: <20261005153956.238827-1-mehmet.fide@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> please consider
>
>   68fe2faf5c69 ("mtd: rawnand: vf610_nfc: fix false bitflips on reads of erased pages")

Queued for 7.2, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
