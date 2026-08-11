Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F733DA5C1
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474563; cv=none; b=owavVDM3jJs39cKOqBQ0HZll1T7vi/C4VLMNPlenjrQoO5OWdEV8+ien2Q+dELWrJvNv1AVes7gdmubE5EfRssiA4zD7JNmRWrBrF/LbNWNpx6tjuTHL6uoflRFsc976TwGJFf7CKYUNrXomKBKdnhFegyyaMTsCSgkIyCDoUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474563; c=relaxed/simple;
	bh=sN4DojGYXyc2ISy01B8VMsTS+DBe33huuTzBqwfJOZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ds8JxRR/HTd9bN1QipTatrOA449Jmf1JykGHNbpChaw6s8ZGvhftLlC8liuARCskesCzm1wXt72sYKSC+8zxMhOqRWz163L8IEJP+iDPCDJGgzyk1iVOCF4p6IcgDZyDmc5kLG7PKebzgmfHVIvTjWj4R8I8Lf/Sz/Z6KX8i6g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McFWY7If; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McFWY7If"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E69B1F000E9;
	Tue, 11 Aug 2026 18:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474561;
	bh=wueWwzmaotkPAQBYsfzmGKWIPE8LM9xVrYI6rIXV1gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=McFWY7IfV2Rpgm16QjBZQtGlOTrUPqltsvIk+Q3lLVV60o1DI4hH+CHN6rXgMdncq
	 dkuPXz691Q6qc0vhwFnP4NoDKL9FERhH1aVY4BH5/mme1D6tv8n5dCZBjmBG6hwUoR
	 S+uYepk44we//7iR8T6s+qKOVduj98jc+GhZJuPkn9tPXe/5ncINOx89tpBKrnpYNI
	 8foF0peW4whAHNctXcbGBPeinuLry7uOyr0l1fljeAu8gcbL3pu2LJ2jKXRZl3d3t2
	 8FxW4/Kir4+LHG8rHCAxjlbi/O+d/H4ky2VbuVEk5/5Xmdn50pG6UIAWy2i9bifDih
	 AXw42j/J6WyZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 6.12.y] s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey()
Date: Tue, 11 Aug 2026 14:55:46 -0400
Message-ID: <20260811184500.stable-0001-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810143719.653754-1-dengler@linux.ibm.com>
References: <20260810143719.653754-1-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Extend the _ip_cprb_helper() function with another parameter 'scrub'
> used to steer scrubbing of this buffer. So now the caller has the
> opportunity to decide if scrubbing is needed or not.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
