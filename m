Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E01378822;
	Mon, 28 Sep 2026 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619491; cv=none; b=Gzzl/Pfn3DHtFHB7xOITXj0x9fGq8csUFfy+xw6dxOS9S5fGdmIFpBbfO8vBZfOnpo0G1K5RHc0vyc7VVw+T2QUrwjcd2s//FjJH/pjAbLEgxCqQ1fWN9cnZIiD2ZjQXeeUQACI5wyobnC1UVd9ZAAjG56MUB3YxaX5ApTAFmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619491; c=relaxed/simple;
	bh=X/Cc78gAQahQyXm3IPkvdrRrtpsk1g7IHxtR357Cg/0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=fttVjLkmvCf7ob1B09nkeUhAAZYrhGZV9BOZC6Q6TDnxzB85fzGMq7jJi8knkYkbpt9J46kA4RK283pI8AXmLJTdHAihS20Po2VSA1vGJubtfsar6MeegVD5lopK4jLvXZTbXmkfEryBEbc74jwEGN2fzN2uI4jjpmr+N7Zt7+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3iKWuTB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3iKWuTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797211F000FF;
	Mon, 28 Sep 2026 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790619489;
	bh=oQMT0tgMlck/BnOo41rrb4EM1bVWDftPddjn+lNZEec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h3iKWuTBZG2unj674vSrhxZVEH+hee50hehyNjbuXw6/DwbbyibnvEIJ0PTXWphnU
	 VvyUTY8FTPsKDVblq65XzeUHMDy6hKFcDQK4eYNogc79owIiyUfvvV2qKkZ36Qj5j5
	 4XoWeaL+1fqxU8HHa0o3MgPv5QqZ7vv4dWTqfeh/ksc7Jd/+m9g0ELZzn+pYVIIer8
	 gk/zgXQzu58s2fBuRC76aPW8hSfqCtGgmc7ItHwNtng9LojLCuY+hDibSH3oEd8XEe
	 TFnSccDYbNtTpPf8YAKH7xtgblDEJE35yWAx4LfKRghkrLMyhN3VLhBBfZz1gmkMqH
	 f9SprEudHGbyg==
Date: Mon, 28 Sep 2026 08:18:08 -1000
Message-ID: <fb7e9f1936f7b77418d05d4f2a263213@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] workqueue: Fix NULL current_pwq deref in chained work
 check
In-Reply-To: <20260928-wq_chain_fix-v1-1-e2f1f117d1f7@oss.qualcomm.com>
References: <20260928-wq_chain_fix-v1-1-e2f1f117d1f7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Applied to wq/for-7.3-fixes with the Fixes tag updated to the commit that
added the unguarded deref:

  Fixes: 8d03ecfe4718 ("workqueue: reimplement is_chained_work() using current_wq_worker()")

Thanks.

--
tejun
