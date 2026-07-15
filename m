Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B02AF1D
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074373; cv=none; b=nQzLg5dzW/sAQl0LnCzNXvQODn402UaTPtjqm1SctrO+KNZpgQnZk6O/b5eFjZpPLAZGnT5xiGGlAvMrMMTx4XIII8ou9oOE6yqgLiuIzdJ2RKHLIACRj7IWHh1p9eTjs/ndaUk1iYSy0u5EStTmlRAEUTyuu9gq/upEh6djNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074373; c=relaxed/simple;
	bh=X70KQHQzPPZauwAhMqugpAebI1rSkCGjqMFW4ek7AXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8AFjnfyPfGYuuxVwjp0igeAvoHnp9CxT/3EY08U1hleI8CAVxnYZ1IRcizEObzgh1ew4qpeRO+pMoSDKlLYYCW8mglYWOjYnNYa0liyBdcaWnz0e9saHC2AdCWvIUBIiGPlNLbzi9eu0Hn4DLnmKmIer2o9UGwAV15dPsOds/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJmoVYJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJmoVYJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7B21F00A3D;
	Wed, 15 Jul 2026 00:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074372;
	bh=zLS7wYIgYVljk6zgdvYRBml+YlMgxs3Dn5pw2gPoIAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NJmoVYJPEOZ8RiAEKhhXFpC/ROMxAMc4w/WPzsnzzqfsMot/BVK97QBT1lBpRDCCp
	 sgP7pVKkhu9W45RIRbDR68mQ9mHUYYg7KKWVL0hBKwT/uQGVb4Epuc/KUAvdbnXZ90
	 Euzp1il3+heaO3Q6gPj1CBRpXTMpVJLajO/RfkvnZXKCpTlZqn3yBDZReUEGOZZiAK
	 jHh9nl09mMWFEkuONl4gi42xSWAmz1DRKETDynmLvzZsoE6yK2qIyTjukxvDGS45n+
	 kZ90PATk1eu+3s6B7b75Tu42oN9YUEEOUn+TvnSzSpTXVdwvBDuc6uEKXjRpitj519
	 HG3u7218/nx/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.18.y 1/2] rust_binder: introduce TransactionInfo
Date: Tue, 14 Jul 2026 20:12:37 -0400
Message-ID: <20260714200600.stable0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714064554.2090610-1-aliceryhl@google.com>
References: <20260714064554.2090610-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Rust Binder exposes information about transactions that are sent in
> various ways: printing to the kernel log, tracepoints, files in
> binderfs, and the upcoming netlink support.

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha
