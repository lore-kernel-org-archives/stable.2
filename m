Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB003D333B;
	Wed,  7 Oct 2026 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407061; cv=none; b=IE6dMf+0zseuBHK35CVRPb9PbML5n6XLR+m46dhO27jiMihD0BEnfQCTKXBFHAPdzTKLBfiyovpTfJ0aVHfEhC9dA0bsAEZXNmjP+pSBfIhmFV+LRfCMGG6BUD3tf4UK3QJjK8xqK5XmVIretpiOUhTVcOUBZTngb8cyetQs4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407061; c=relaxed/simple;
	bh=WN3kWCZ4pPD4vYEdhWpj9crhtGMpB8oFs650KnNKKtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O99Nk7ai4672+AK225CxgJtjuSDgTkLI8YTCM2LBKEUNKuMmLdnpii8oYMDRZpDBOjfdD2jarrkGkk0RYp/PBa6vBAM/ojHdugDjU1Zi9OJSYrb27TUbv66/z5/z2O0odH46Z0WGdrMt6Tb0ZK2kivJhf+VWsjPGrHflJ6HNRgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDle+Pte; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDle+Pte"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079B51F00893;
	Wed,  7 Oct 2026 21:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407060;
	bh=VJUfz+J8MaSuGMu0bwSkKjWvDqsmolvql1d2z66Gam8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HDle+PteKpnO8hb4b2eRB6fRXZXtt/UFFzrgCyTfc6gUxJGIy+6jILDhs+khBo2cb
	 wwnsCIGQ5PNVJgBa3AlpwhgQ7pxOP+r1/tCoArNQntWG2OR0iQKfy67saKi5iIK3FY
	 YF6z2oooDPLTURLDqO9uXJD5U0gBvcI1TYtWx5IJ5w5t1fpnoXzOc/RdOewATJMPJt
	 Wc73JhQhYilWXc8CD1p51yZ/B7YbODsCP6XjQzLwJKc5boE82QIHnOqHQsdDffVZgV
	 nD1Ea2zNKrk7gg1mmwTGdYgNtSAFLhTaeAXO8+MUOmeMd1YNx2dWolfVse2USzax8T
	 yT3I2kEiv/esA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 6.1] fsverity: add dependency on 64K or smaller pages
Date: Wed,  7 Oct 2026 17:03:37 -0400
Message-ID: <2026-10-07-1-daily-reply-0020-fsverity-64k-pages-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006215124.55296-1-ebiggers@kernel.org>
References: <20261006215124.55296-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> For now, just disable support for FS_VERITY in these odd configurations
> to ensure it isn't used in cases where it would have incorrect behavior.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
