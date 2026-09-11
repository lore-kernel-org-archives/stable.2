Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5924D26ED40;
	Fri, 11 Sep 2026 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125701; cv=none; b=LFrlFlK+lFFoVCb7NK6ivfAqTY4mgeSHtKJZB8FW3cttGHHAkkCLJjKDqzCRTNa/bviW91y4IRIj6SZXkbCCYLTir+nwKClx7WtIBUUW5dVzGx8icOggdF7Eidef8y6rlIgtmaoZr5P5IG8SKuv7pvPlPJRvCu2sff/vRZHSEgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125701; c=relaxed/simple;
	bh=tHLFDvOdR7llIk43S+tqW6tBjSm/ddh/2wRVgJ8Nm7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XO7Ky+Hglp9mkwykNpCipmmo0OLzOs/1gwqHeh+9HmJWpvJOPEHHCBbdGIOFu/pGKmHcmDaC11c5BDhHlxtHuL8IY+5zL6RggOxa4fkSLTXjLj2xjrnOeDKMURo+4+cSB0by7Md5CTy47Iyiq4y07mM7bIUOjJMzZsAlMsTvdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLixis3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLixis3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455151F00899;
	Fri, 11 Sep 2026 11:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125695;
	bh=hse2fI6Uf0v+J3PvcMVWaqRkxJdcI5kiIkoyllGemmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eLixis3+Mog+ieywAKIuRZZgx+7KXKJSbAXzWTtnOjfFMJeLpjc3XnB9SgpWoJxMz
	 EC9QLT8MGwbFuQsZlyZgbLfLynmUWQNaJ/TRZHzPITqk5+eeaZeDHgh7iyL7KYh4OF
	 MxoOwm6JrEmgnxc+THN1qhbD41qMlqeZZxji/6uFgNJk29BeRIa+hLgWMuWcDmmm4a
	 FQNgB73lvBEFBtJJ6JAKOHyRXI9tBfbB++YavDn2AvfjY+ZHNhcwa5tGlcjKUY6X6v
	 jVJBhWihZjO88tAB0vmbVa1tBYv6xWlFoq/6JWkt/9gzgrXbwXR7XH/2cRrlRSNplc
	 HdV+An3LjShpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] mm/damon/sysfs: read ops_id only once in damon_sysfs_apply_inputs()
Date: Fri, 11 Sep 2026 07:20:55 -0400
Message-ID: <daily-reply-0036-re-damon-sysfs-ops-id-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910004154.115973-1-sj@kernel.org>
References: <20260910004154.115973-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> damon_sysfs_apply_inputs() reads ops_id twice.  It could race with
> ops_id_store().  As a result, the min_region_sz could wrongly be set
> up.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
