Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344391;
	b=DUnBrWZO2b1jSHOVckN0DEHzaG1yqOZCdje7589KWYXDaHJxuT7wvvQeYyzedjGG26Qg
	 NMwkNNgUMWcy6mtv6m3daru5VVXikkGPmm9t321segz6suhlQaE0ieLH/3+6n3W5tPA/7
	 eDMPTIcV9Sp+K2lxPCzcSyZJSuv+OX+ANATPIF4wCu9I0ZvodIj+8Eb/QfuSw2YKNfhiv
	 vzsh7N7+y4xU+7EdenshN9aa9fpR8rpsJKQC78rGtbifiECojyMVWyH9xu4pAZwCIYTZL
	 9bJdzCH+vo6Oso3I2+/pRm6VCmmEykBnQVwGAdsAC2Xi0r23v3FfVikLFeBrxbD4RmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344391;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sPe0KMuUuzYyn67O2cSOWxL0WKtscoq/xkISNoy3Mkg=;
	b=30mMBc/+xApvbB3TqY7nZMB6+kk56STN7K46u1IOX3DV7+VYdaokwkpomIZjKsTzDbQ1
	 rcyjgEJB555sQDLV/z6du4KgJ4CCowei8+qAXVhWa7VObEmnxxECRbljQ1/muw8+s5+op
	 JtbuyA9xMc8MZl4s0/4uLRYKfhb726G+DExi+nkI8EJuYYVqQ8s+TuFUAGF62JtvxljvL
	 nKWXGs4ttVKX2MZ+uI1QMEZi5nV3/HX3NMyqAbTfQmuwrnOadJHEpti+3UQobb2n4WF/x
	 +7jOzR7xMGXpbag3RseDEIwyhcJQk80nEj6h+nP5iITWUZcoLZHhQrQyAeSJSkFrQAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e66vaHeB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781F60A2606;
	Tue, 10 Nov 2026 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e66vaHeB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B473B1F008A1;
	Tue, 10 Nov 2026 20:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344390;
	bh=sPe0KMuUuzYyn67O2cSOWxL0WKtscoq/xkISNoy3Mkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e66vaHeBdoHLEw2whqTbgNTU3URBSv1d3CyOJT8eTiAiSoAD8bh5Kq6WEC4/5KrFI
	 ti4ry/cyQWdbFhJxmyaRNwRaY1b80DJ6k33jUtTOxRhFxrTO5wBbdFdt/GBs0LtRU3
	 2d4MDNExGA2931CR9hFHTt3hggf2fQjUdKck2l+gvtIknX3nKIYqB3RcWPqQkEFF4f
	 aaNSR675yR4m6yLzk2gl9O6vVigGbtopPO+I6SL/4SK23ZVe9Y5x/MPobn5lnfNzqX
	 uAhZr2uGIuq/sWzR9JKf5eZtLHGV8YBrHc9PiM/w7LfnEpV43r+vpsE47efUQyXCZ5
	 pyUlC6VGQIPLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Fernand Sieber <sieberf@amazon.com>,
	SeongJae Park <sjpark@amazon.de>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.12.y v2] mm/damon/core: move static variable last_nr_regions to damon_ctx
Date: Tue, 10 Nov 2026 15:59:13 -0500
Message-ID: <2026-11-10-1-daily-reply-0017-damon-last-nr-regions@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110150218.145605-1-sj@kernel.org>
References: <20261110150218.145605-1-sj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> mm/damon/core: move static variable last_nr_regions to damon_ctx

Queued for 6.18, 6.12, 6.6, 6.1 and 5.15, thanks.

-- 
Thanks,
Sasha
