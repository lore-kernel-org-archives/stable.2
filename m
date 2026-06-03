Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC73B4439;
	Wed,  3 Jun 2026 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499675; cv=none; b=MrM+DNyvGrlS4DOfLElG197Q2Im7HKvx0nwS9sk6ai2914vpGwCOotOBOuBIHlG3AxWhESTaGWX8Xcl5EYcrpXODmsBoNVVt8lF+jrEsOIBgdJbWpRrqn9+YUlAdAWvrn/PbFAn0mviEqDfmdS00V0At2Gk2KFBQ+W44uSfDaBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499675; c=relaxed/simple;
	bh=ABUHQQBtP8a2eT0meSyoQC1tKOfWe0IBUxX77BCvL38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ginm2tG/5D9PhJXoh25PAADuvNhEfaSQKnrEas8m9nQoTl1yTP9/dsGdc/yZmHGMg87qumMCbVfiglKklNefgpRe1ob8W9kqHN3JPHLdWyIWdkaYsYbcH1TBwBOIjU8WwAt+pzMBA7g6bHxQBLy4Vg7I89ge8HjiV3P6uJfMpi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPZ3ToqB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPZ3ToqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1831F00899;
	Wed,  3 Jun 2026 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499674;
	bh=EWOwp7Yrnu95fd6AMzKTYBWJxuxNBPzz8DT7EZJjsFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SPZ3ToqBaLNlmwrcHRInhHtj25Q9O1kVnHhi5JZJJG2nmJ0avEwFZeVOcyrCWkD8B
	 fMfvGOQxsvxc9kLnyDYeQ0ajGnu0p1wkMpEAVUhW9NX+x2LssTEDmC/kPgV65mm2la
	 PFYhRYs2cmRH4CCtfCgg8DQuJLtIqZSkG0Tmybs6MaJZsFvUytguWnm7H0eqSmY237
	 4vEn/wuZ0RLRTHRju/F19WclKJaCeLUmUElkJ5YjWxdBtF+17w2vqRsklxsevUUcld
	 nEe+iSYjQEt0cO+2JWy/MOHcPIU44pz8anJGMvZzXcUmTtBHz+SFbIsfeZDYjokinE
	 F7UKKwcj9qTBQ==
From: Sasha Levin <sashal@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	criu@lists.linux.dev,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Andrei Vagin <avagin@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] Revert "x86/fpu: Refine and simplify the magic number check during signal return"
Date: Wed,  3 Jun 2026 11:13:59 -0400
Message-ID: <20260603111500.item003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526205047.3339490-2-avagin@google.com>
References: <20260526205047.3339490-2-avagin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 7.0.y and 6.18.y, thanks.

-- 
Thanks,
Sasha
