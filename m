Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C047D927;
	Thu, 27 Aug 2026 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850871; cv=pass; b=PyAs+T0B2Eg/gz7kHkarTcqEZ7zdGN+78lcMvadeUlC+grrjf54lkWwpb3P5ZtT5g9efDrz3UwAXYdp+vkTRARlbOJUtQON3sB6sHiqyB/cvJhFMaMcab1Zs775nTZw/UgWCM9UdQZStI/bPb4LexpvLxMA0OUHFO2ufk01oxP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850871; c=relaxed/simple;
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ub5y1Wk1QO+78A7aqv0cUkZ0ZmSnCKcDAfTXxpoc8QyNnt84yUVccDsP6XsrZ1RFz1Y9f+l4ux1HnnYT8jWEMhf0PLwzof2WK65zYL1NDgWE/PZCL+pbtUvncyWcARc0LOGhJJkYqHf86WEK4wBZIxm940DixTwNKf59jKp04DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=cb1sVHTS; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="cb1sVHTS"
ARC-Seal: i=1; a=rsa-sha256; t=1787850846; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b/8Whq6/4P5qr3j1EwcbE6xPGkiPezEkJkcpEc0cuCud/Ed2HJyosv3hh1XefFPhGK4019Erd+ivwA9TNNzoucc6wwR0A8iAktzMg3jPvGOXzruY7eW6Dgg+KKL5NzsQqEtgtPnEiS4wDrGNiq8nDhf6C5hTrAFyJK27wa6Sk+4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787850846; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=; 
	b=F0YtGtpVzYLvLgzBGsQ946VZh0dI9eXMs2gJ912aqkcR8cgbkp0RKFHTUADg6vHFgGCjfRbcD/YZP/677AiJ0NPYQjsRy9tGL3kl4m+qNJsPEPBUM5icNUU2suG+Wpd8yoW9dQzXxqLb6A5vX247yLbiRkBQA7+EgaetQsa+iHE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787850846;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
	b=cb1sVHTSU5dHtp5uCJRmgLRX0ega1Lpb+3AqBJyx+EaqDvTTyUPGouICU4beUzJL
	Xw1U3TPhjRsvR6TDthBmNGN9sdUtboZNeKjL0yUmaYf6SZwW2UjZjbErxoSnlSIjsc5
	2VwjsacSX4OWIUNXn84W+Yv/VMhsTaC7NgUWWDzY=
Received: by mx.zohomail.com with SMTPS id 1787850843478662.1340767419031;
	Thu, 27 Aug 2026 10:14:03 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 2/6] rust: workqueue: restrict delayed work to global
 wqs
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260807165252.3849875-3-dakr@kernel.org>
Date: Thu, 27 Aug 2026 14:13:43 -0300
Cc: tj@kernel.org,
 jiangshanlai@gmail.com,
 aliceryhl@google.com,
 ojeda@kernel.org,
 boqun@kernel.org,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 tmgross@umich.edu,
 tamird@kernel.org,
 acourbot@nvidia.com,
 work@onurozkan.dev,
 jhubbard@nvidia.com,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0B20DBC4-9EFC-4F4F-87D4-276605C1D8DF@collabora.com>
References: <20260807165252.3849875-1-dakr@kernel.org>
 <20260807165252.3849875-3-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
