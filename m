Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C901327BFC
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842034; cv=none; b=K0kVtkJoB9967hi6bAE+rDTtTcnBfzZPNDgVtQcqJ9M+ftfrb3UmECuLL9DAYAcsoly/PjcSOEqrTUklJspL5Dp+VDtaIr1GUhwGocXCZAQx5jV0he3ca4loj7VQk/H5QLVdnMiamBgBDMy9cMhEmR743h0HH6B6i+06sdTvJDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842034; c=relaxed/simple;
	bh=zyvuN1/e8I+TUgUXpXNH4mlpo1mVKPyY5BapPwrGXpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnueDez5duBFaAb+MIQgpGtczAiUspuzZAn3KcFKOFx/5P10RDNZHjQBs2rjiR8scE6FF12Hge7jcNE9crep3zqn71xIesVAUuBNZcSo9J73rQ0/APjl/1TkxVJu1mK424PjRnDiyqHv+0ufIQIrt4dBiXEp/agrKGMUr4Df+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxZe2P+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxZe2P+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525741F00A3A;
	Fri, 19 Jun 2026 04:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842032;
	bh=zyvuN1/e8I+TUgUXpXNH4mlpo1mVKPyY5BapPwrGXpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QxZe2P+Pxi8jlwvqtJSgncgPVV2RWoHEZoLgc8E5fXcHXoM5MdgJnE2RGhlpJIg2d
	 3VCq5uyppRskZLB/ckISqsgSeAA51WahFXbtbRhQ0t2mEVIff29Vd9OzHtdj2xkrnG
	 2G04HcAosWgkuJAGjj8iy/euUhaUL2bPK/Ymz/2F0ka+GxlJrmhjjss6Hw9c0/+DAH
	 8ttLpkb+VJvwZCdzRJtBF5jA+2anImzXQAkIgGGxDZzLmLYlH+HXoYmTymLhHr18+4
	 O0qDvaLUFaVDAIMHosRG/vkyJhsEa8yvpBfrR414r3L8uPDhB3s48ZBLF0xMTGmk4t
	 rMc6ZcIChi+lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	brauner@kernel.org,
	mszeredi@redhat.com,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH 5.10.y-6.12.y] fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios
Date: Fri, 19 Jun 2026 00:06:57 -0400
Message-ID: <20260618-reply-item011-fuse@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616190023.956982-1-jannh@google.com>
References: <20260616190023.956982-1-jannh@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This is a backport of 4e3d1b2c48ca ("fuse: limit FUSE_NOTIFY_RETRIEVE
> to uptodate folios") for 5.10.y through 6.12.y.

Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

--
Thanks,
Sasha
