Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527FC426419
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407054; cv=none; b=lSuCJRKa+e5sp68RRtH5qeWyC0CC/jnchz23flZ+69f4RVTbB1RGPeL8DQEjbJYzt4oWy8psq1Cr43TKRZ6XOFCvxQLRO0Jd+w3pNSN4xW+BVJxRJGx+ooT+sTVVkZIdEub8pFosws9STpMBv29GCDcE+6EGxhVpcQywDV4F/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407054; c=relaxed/simple;
	bh=AU8Qt8F4ZJ9wsvwhVmxepsmyT1DX4OJyr+qJQnyY/pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKMa0EmqtABL8f6dCvYQX8WIN4dts/F0U/9RN24SwHp8xkNJHJg+T9DjaazDdGCoVwVP9313mkNHshugaT88MuoR0NdZopNqwR/onsRzlcLm3k3mimJ+mJD8MqyLwmEAij7i4lKzypvSLIIbv144cfH6qBP4Exhh/NeUDbOqwG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb5mXPu/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb5mXPu/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9FB1F00898;
	Wed,  7 Oct 2026 21:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407053;
	bh=EyfbuHBFXs/hCJiF9TGxFlYL9Dbv4AMS2fNd8vG+u1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rb5mXPu/WEmkcLxPfofmxZYo9ZJGfM1OXDf9dzGXf3nijc5lnPkjFHkQH1ukHtOI3
	 dFUJGxFLfwYksII/qa67KGPcOQ/UZc+mPNeEedlkokmci6WXD7VbYWtWKrZ12ENXkt
	 T4fhqU/TW23DEKVsDpcW2XbRsGBmoAos9IiabidIPJe0I71/AK5gK3WgZ+R/wyXXek
	 xsxT8OQiuUPmBdpQQGdfAisOYeY85BhC+5lQCWb5AbaHlFe1E5AHf8rCfFMe9py0vH
	 IFyJW6j7yq02Sg314i9CONrhfzUUlmboh0FT4XFLj9z14A5AHenJxFoy2tz7FzQKjx
	 kLBGsUSkFiYbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH 6.1.y] KVM: arm64: Don't use the VMA to size stage-2 block mappings for VM_PFNMAP
Date: Wed,  7 Oct 2026 17:03:33 -0400
Message-ID: <2026-10-07-1-daily-reply-0016-kvm-arm64-pfnmap-block-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006132719.3043573-1-smostafa@google.com>
References: <20261006132719.3043573-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> get_vma_page_shift() derives the stage-2 block size for VM_PFNMAP VMAs
> from the VMA layout alone, which does not necessarily match what
> stage-1 maps for that VMA.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
