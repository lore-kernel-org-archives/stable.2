Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97666448B9B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125678; cv=none; b=GSUzOmaUybsAwQfdD/ZL5OnPrd703icAs2IBny2jozTaReeEvqPzb+P2vdX+HxUWlVkFSIU4p6meUXPbzok7jPbbB7EhcOxdUp/9vLrcIh/uFGjNhoiEqbtbg0IAxbW7j78Xz5Wx0W7OfLlN4E94Av+DinNKmVPxJooLLYnOfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125678; c=relaxed/simple;
	bh=r1rZD6QWSXlD48auz3HhkLXhoyxRtDSHIh4yUmcvT58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXDhik7AJs3Jyg1FDjXvj//fY7911t1sWbd4lJHMhjx7krNCpUicUJC5nq6+yEx31LkKYeUdjr8fNn8nemxDYy68h4Gi5QjocbkmdNO8855ulVECgJbbJHkjVCRvWec9XvZpQGeIZSmXz30EHSJSA22Mr2nCF5FHx7iJ4NvdLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiN8k9aR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiN8k9aR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F73F1F0089A;
	Fri, 11 Sep 2026 11:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125672;
	bh=EiRHkAfnVoDe0EYgEK2jBqDSnhfpF+elLmRyBUTZzrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jiN8k9aRprJUHhYb39BNJBwaMpkntAGYJoGIjd7qcP74b7SgXvfPDf2mtijhsJncW
	 0yUXT1jepiQOoXPk1qOLY4ScwN4EpYRSstB187f3whxGvbKrtEzbCdf6p1wkx60xzt
	 LilMcVZ+MQyAZ88WGhvf3WSAda36+4e67+aEjNrYHnb7Eis3U36tKbULw4m32SvmQW
	 IyVTZM6KQ3eJYxxUHWW+WoL4exnoVEmEjLtyLQn8D/tim6Yy4e0Pob1ddu0ZJ4HDlY
	 5x41Ync8HsQ4RBYbbdYXGVZS1lkUaLJnfOfxNVyTJbXORLY5zt3ng77V1m9KYbKeD+
	 2xEb1MxOT4tcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.12.y] batman-adv: dat: atomically update mac addresses
Date: Fri, 11 Sep 2026 07:20:29 -0400
Message-ID: <daily-reply-0010-re-batman-adv-dat-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909185353.977975-1-sven@narfation.org>
References: <20260909185353.977975-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit e6de568d3eda3e3c01c868fabd7a9535d5ee4a73 upstream.
>
> When a MAC address is updated in batadv_dat_entry_add(), it is done
> using a simple copy function.  A parallel reader might only see parts
> of this update.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
