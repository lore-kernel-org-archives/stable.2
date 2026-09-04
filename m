Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED482E414
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490418; cv=none; b=fpjGndfS4WekLKIxsclQluHnXgfF63gnjfD7wPj3ulU6mzhQbfd9cdRVmHbKm6cKzvXtxzjXFhiTN44qeEN0d702cjWkRsc7Uo94ucGpYSFMRxQW025HbrYSPciTA3awqQASdM7qAVN7kO8Q7ufwv6N5+HJTnLBorjG0ZzrCUWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490418; c=relaxed/simple;
	bh=F11FjCTEddkpxQThFikVLspH0sV2dn8gPEa37ADEl1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Df5YhuZM00rWmTfgdnp0i/elWsq0JMQw8fqUQi0WFJdAEy8l6yym7IF+uqVrgmWYRRErfWEKqWyRr266VgclE6CTtWFGuwvp9OZIvW01Bvh4Q0DEsdGwjjZnrQQ3wxvw6QwWxdgykR+hdBNbIhwz8GrFQ1K8VpzE5/bZ5fvSt1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRaKiGEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRaKiGEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34661F00A3E;
	Fri,  4 Sep 2026 02:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490415;
	bh=09IwVRN2tqa9ydr1ZzxXVpsF2vcPXaMxFwC928XysIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FRaKiGEJE2zifNMOLqtOM08wSZAHe1ACRQss61MW6wqhtsra3hTsN+kTbnKubZPXe
	 DEMpWxrLsBZUbCNttjYm87KLnAF4tjy6AxMHq9XNeiTP+0co5tKdRsC+VSH+Ui9K0e
	 A8QfgNE1br4vchJZWJp6H8jiQlKng/yaSGUIU+S8mMiean+gpea4VdU4rTeC0YNuFd
	 5F4ERTNSV8neLSbe6RP0b/crEjn4TwXP69GrktYzxyfm9FljFItmZJAYfFLZHZwyvh
	 LUlEEZxE5pPDRL/6otklRKlGXYMIXjfp5XiC5c3OT2Y9Xpa71kUajOzIqeFnGc009m
	 sjiT2CDgTcYNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: Re: [PATCH 6.6.y] x86/tdx: Fix zero-extension for 32-bit port I/O
Date: Thu,  3 Sep 2026 22:53:06 -0400
Message-ID: <20260903-daily-reply-0016-re-tdx-32bit-port-io-zext-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903162052.584017-1-kas@kernel.org>
References: <20260903162052.584017-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Use insn_assign_reg() to write the result back into RAX with proper
> partial-register-write semantics: 1- and 2-byte forms leave the upper
> bits untouched, the 4-byte form zero-extends to the full register.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
