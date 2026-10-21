Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792621959;
	b=gp9llT/1QT0/gsyBLEFMZKsewzoZEknntVF0a3lqngYHHnYW67osm9STeEPgNu1WIIJ4
	 xSVs5WxlQOYxxEHNmSnl/Qbp2QJFlwUo25cN3LldPxiEvvxG2m6HBss8xa/KwsRuukgcq
	 tcgV3tMz/ssKm5ELhLv0fTj362PBVnfwkqDyozNrWJ0O+OCpAoJto2HtdJtxLF4hlXH1N
	 SBPv6o/0fwZFJ+Yzy70UXDmF1cyS1V/8zTqrWBYAvyemLuM461/DMIGfsfwNqCMheDVUq
	 036UHL9/A2PvUIfLUFoQheNa6h1abGU7j/Ziq1jAGgnI11y4auoLN8affUiirx4QSGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792621959;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4ocOhL5uZh6M2c2ncBzha+9solA9N9a7VVVZB9JEhLk=;
	b=hM72uo7Ev2Xkgin5Bt1nMUySWtZ7oAx9MjvOd3MmBrFDiT1XRPVx0qmw0QRt/lmR6/Oq
	 gx3rhPykCMWy56c8jaHREG/5rwcphmWFxZZLd8JWGBMxpM+pT9Uxk0IPgjQaDsVvJzFjI
	 c+uOl1uGxI4WW73cO5L1frD2UZuwQTFQZz+aKYvY5cVICVkHlCAHIiqxfVFlckXVhJnHY
	 ptkNkRG7C5tnfCMwLm5Tix12+qWH60KOr12PjD8mCAx75MxyTMXvCU7eh7hol6/l3s8cY
	 blmcTXToo3e1HIAYCKeZx2rQ46cEuE5S5T+6rQz4weYjox8Gv7Nk/eJp3ar2qJIcoVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+0vJTPu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5C606A319;
	Wed, 21 Oct 2026 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+0vJTPu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D291F000C1;
	Wed, 21 Oct 2026 22:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792621958;
	bh=4ocOhL5uZh6M2c2ncBzha+9solA9N9a7VVVZB9JEhLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m+0vJTPuiPTOxjW766Mm+LxzSMrj3ERN3MES592krDnOu7EnySb4DpkA4L6hRbRzs
	 a5oznxPLIyNtEtBvJkdKAQeJuBXozAQ4ewC5aBsFoWiuaf/a4OyD6uu7QEpTsYtTdP
	 wZcd9mlWMN3/syeN+B98CKUVv2KYksqc3+gPtR+xl/ITaKD6ThcKsqiJpQTCvc4LL+
	 PqqVZ6Z9Fw8B8RC9zKcF2gcMfoxgE6yJVL3MiC23bkQmWVfrnHQ6IAhkTuoO6GTfpk
	 QrLPognGZW0uh+JrueE9CYaZFsJRmpYYU+cNfXcp66IHkw6aGD8pveOVLPR7RC79Et
	 4p2DHGNgRZwfw==
Date: Wed, 21 Oct 2026 16:32:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: fix use-after-free in
 nvmet_fc_ls_create_connection()
Message-ID: <atk9hM_hGHO8eHSn@kbusch-mbp>
References: <20261017153805.2528275-1-yhlee@isslab.korea.ac.kr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017153805.2528275-1-yhlee@isslab.korea.ac.kr>

On Sun, Oct 18, 2026 at 12:38:05AM +0900, Yehyeong Lee wrote:
> nvmet_fc_ls_create_connection() looks up the association with
> nvmet_fc_find_target_assoc(), which returns it with a reference held, and
> drops that reference as soon as the target queue has been allocated.
> iod->assoc is then dereferenced again by nvmet_fc_makeconnid() while
> building the connection id.

Thanks, applied to nvme-7.4.
