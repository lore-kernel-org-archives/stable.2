Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0B2620DE
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 00:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952737; cv=none; b=TrNmoFzvzspVYjoM31aDbRHPWdmPPNJGgsFttZ2CfGL0kNlrYHK4DZOYfchdC/uIsQ5x+tGT237rcXYSxqQSZPvDIrCa8h0gVZD5UJq/de46/MDwcDVAM0O8hb2Db0t+3x1fk5s7Hr/uh2aWFvo5y5HVt5TvhGegJx+10hU/I44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952737; c=relaxed/simple;
	bh=Emb67yFPdbJ85cd6kCZ46V/AaC7MiN9Pn4yrc/SwH/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/Iwz8yHzLnPvEaTgcKQksX7kdkhoRPS1xGm9YR4lwPlynIulUKrt5r1YhYMpQ3jF33p5aURUDnpSMhvkQyDQuZlJeMLfmzWf7q8BsqApmTPLqKCK/FmYbKJlZbyGMOBGGb1uQWlT/gHyVWLeQqD1uSWipx6TPELvkHiFLHB5zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hg8zbCOv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hg8zbCOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD801F00A3A;
	Thu,  2 Jul 2026 00:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952732;
	bh=LpCJQlPE5Ak0zE6/hYgX3ekV8KmQRxvp3FBqk+6eoys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hg8zbCOvSiJwasIpSLYdLlrGV01erTu+gpjTn9O0lplXVuzUv1wwuB+bv/sYElrs/
	 64pSMOm6Kqzmvf2rGa48Qt1updcvPfdzfKoZYD4mKFn2/gRv6zXea+Ds9g/3IWOhQc
	 plbWzs5+fK82Q6ThiZrlbjVh7wp/ASt/XFQ0eyhsIuTs1iBizM0A4wmtor7xEy68NS
	 /bCZYHkyV044QTEqBLiASqNjVaJP2ckeSE8kGia5S268SxGP9BSO+DwlpkRY5J7nkC
	 xhn46Ai8k0tcTpaqCbwmnVvPUcCLT+9HVmrav+2ht7qu2SjGtUOYsHI4bxjduxCJst
	 f4crNqeUvY6Fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	Cheng Ming Lin <linchengming884@gmail.com>
Subject: Re: [PATCH 6.6.y] mtd: spi-nor: macronix: Add post_sfdp fixups for Quad Input Page Program
Date: Wed,  1 Jul 2026 20:38:33 -0400
Message-ID: <stable-reply-mtd-macronix-66-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701023619.2730136-1-linchengming884@gmail.com>
References: <20260701023619.2730136-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I can't take this series for 6.6.y: patch 2 adds flash_info entries
with a NULL .name, and 6.6's spi_nor_match_name() has no NULL guard
(only added upstream in ac5bfa968b60), so the legacy probe-by-name
path can oops at boot.

Please send a v2 that either names the new entries or backports
ac5bfa968b60 first.

The 6.12.y series is queued, thanks.

-- 
Thanks,
Sasha
