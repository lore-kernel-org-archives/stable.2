Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293931E5B68;
	Thu, 27 Aug 2026 05:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807884; cv=none; b=KQv9NdqLTs3n4MJgdm8C1w+2OkFv9mZim1qHhikKGyWLrzXrHcc1qDcYOvPptsaOoLl8qtb7/REbhMpSC2R7pICnOrlP1aAIIImv/LBTCD4grGyALMJjCMht+BoZ6krM4vtk+YZiDZJt3qKixH6gazr5Ij8Xbx0KayS+rJzbJQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807884; c=relaxed/simple;
	bh=D2ILEefoFHUAaMRBuakJWffyX26V3kd9ycpzptplo38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9a1q9jyJD12wHYKc34JvZCiQLutRlekxyONafYUkAI36RfKmxlPb+OMcKIlWtDxY5ogTJkzFm+E+jHlRj8KlqF+80cujY8BiD/K2ez1fAmOMA8xIAONKLtUYyByofPXHTDQapukpJ3kcr2+xq4r/uUYhOMGHPNCv8+EejqVQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2Iof0n0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2Iof0n0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05131F000E9;
	Thu, 27 Aug 2026 05:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787807882;
	bh=Zc9xND4H8+KOtrl890ErAdWI2z1emjSUjwo5U1kJ8Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n2Iof0n0AgCWMnjcRxFyzo1IZKPpseTcETcFPVL3ZpEt0SRJHn5PVAvI+Q/lFM4Bd
	 K2oa2xFqKQ3WjoPhxa/1icOeYnEQyS0euOfpcapEPsf4PGtlbxB9iPRo28BU+rDNOJ
	 zv5eSKOmO6qgPes5lJl7Gvb0hdRuGw/Z3bEXYSlin3bdhtb0htmJliY7uwQ8rrB0tx
	 c0YlHNi7BCSH7U+Djz//ureDNBiCSQCEaBbCcF0s4KeNqSgQfgmCcJrkcQJLBH8nDx
	 sAIGLi+OgXSy7Ox49QWh08IruEJ6KuPHaZEohcXP8U+jRRZ2t0CCCsznabxNhNt5y5
	 gwhyMZm9tB0Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	Taegu Ha <hataegu0826@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH 7.1.y] bpf: reject overlarge global subprog argument sizes
Date: Thu, 27 Aug 2026 01:17:51 -0400
Message-ID: <20260827050834.10001.stable-daily@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825142432.2347543-1-hataegu0826@gmail.com>
References: <20260825142432.2347543-1-hataegu0826@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit de36adca634634c205a9eb8b56a28175ab7abf5f ]
>
> Global subprogram argument checking derives generic pointer sizes from BTF
> and passes the resolved size to check_mem_reg() as a u32. The access-size
> validation path then uses a signed int, and stack pointers negate the value
> before calling check_helper_mem_access().

Queued for 7.1, thanks.

-- 
Thanks,
Sasha
