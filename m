Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633632;
	b=ntqvsi63M7B4Vbl1SFmYA19K57hdQCPZpuLkR9+h5j9+cq8RBqazNeORPJBDF5pppqET
	 ITI3e7G1pXuDHcaWxW2/pqEmuBaBPoZbjuWP1WZD/kErnr6LFbPmXRox1ld3rJmKx/99R
	 I/bmdlkIoX45E3IvndrQ6Eyz8HppH4M8bgVuoefavLryCjlJBjxOUz/+8nFMjr7KGVo4y
	 tCGyGiWzfXqnFKOjhSFMvziZkZxzy/VBxQLib9jeMMu52Mn6SU2z7JFoBR1ZCn9Ij0VlV
	 KOg89ABtPo4MaDuFcQX9JITQGzgt8pOEDvvLoPBUIWudqdH6mcTWk+tkPX+hXP5kDRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633632;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HwKdkxKDmBiLdjawZABkcl1fPHCuoNe0u2BcAB2lutw=;
	b=1EWcvswlR1EFBbxB3VXL3rKhRcIUXLHAgZ9Tnih5iu1paITOQDA5jxEzQ7sZkdzk6HsZ
	 Ub+vyil1GYFO3X6AvK2V9jOLMbgP68jVZejZeMuKrZ9E7UL5zbwt2Il2Sm1hB0m/gbOVe
	 QYoFQqco8pl71qZcJqqxt8Mu9uQScEVZVW7L5Ov2tPdrqYrPj+Ho5ZtMoJZpM5nGNvIvS
	 WMIqkvAI/Qx7KqZip4z6OIyXOjXvW3bHGZFm36vLU/pTJS9JhFv4P1Hf9BfcdxjLpyPDF
	 LpSQwEfrBWHtE3aX81oGxrVamaToGcBrTAhKKk+H7C+Az9eJ7njrtBVZtUDxKHt41Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHIPSzdx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF86C60DAF7A
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHIPSzdx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225391F00A1D;
	Mon,  2 Nov 2026 15:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633631;
	bh=HwKdkxKDmBiLdjawZABkcl1fPHCuoNe0u2BcAB2lutw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lHIPSzdx51l2RfrGLLOssHqcWOM9Ia1pmRp9tafwdZYlJWkr75kzJYhkxJMvMPN8E
	 wo0WkfvS23wEecCo21i7ga7fnMRuvqznY5WFOJdr+c9PH34rkMVYLqFDtd50a5yUG6
	 pJEueNF6D+tKoBxdN/Qg1gMLnvTj8w2oFNDfXg6Hxqr/Qso2hta+gc+JbKdv/ypdED
	 KIUPdzJwwaUn9S3IQrXRdzerTyzq42QjxMK08sQKDQaGFhQrFLF2Oa9TgFfTtfZfNU
	 9t4ZwUpdaOHw6z3kZWpAj1ITWcKtjFAx6InkjLhMXLYQ4UCLrkVcpWDdHY7nq857Fl
	 ztcUk+iI+AWgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 5.10.y 0/9] Few CVE backports to 5.10.y
Date: Mon,  2 Nov 2026 10:33:36 -0500
Message-ID: <2026-11-02-1-daily-reply-0010-few-cve-backports-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102102104.1558500-1-harshit.m.mogalapalli@oracle.com>
References: <20261102102104.1558500-1-harshit.m.mogalapalli@oracle.com>
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

> We have backported some upstream fixes to stable kernel 5.15.y.

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha
