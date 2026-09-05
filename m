Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9BB48F85E;
	Sat,  5 Sep 2026 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788624030; cv=none; b=HhDTSdaVICLRvc9HgCSPz7o7yMj9QBAu4uBGaTGF+SoLUXgSNhoHubsbfsNxkGHd5WNqogA/WWQpoe/PfVvLnsQA3dJ5DCsDgiF5/Iad+QOk6P9BBtnqqx8LVdXamqwD383Pq05EP3UfO4nhJBjxb689eIVZ4Z6/AU4R7rzFTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788624030; c=relaxed/simple;
	bh=89VEH1jA+TUS7OG0ti7yWtRT4B/NWJ99XSBJju01X2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8zR+EGoAJPzqvqVkjmQOg9Rtx+qPUmjt0PFSQXeI/+TGXJoFMGsjvbzJhHEBlcgVqi41OYc6RbLLMJehj0Qx659vfpYS4Mbfv9WleI2xh8kTDiD9PREHQmEOMDyXGO+RsdHmH5KaZ4jrUT05DDGFpefF9hT0wVgdrM6Uf3Vfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcBrKjn9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcBrKjn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C321F00A3A;
	Sat,  5 Sep 2026 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788624029;
	bh=89VEH1jA+TUS7OG0ti7yWtRT4B/NWJ99XSBJju01X2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VcBrKjn9Ej/tOL8KDYW5hSi68gWX8RoSZPMmANMQ//eh+k172FZnozySil0GP+i2A
	 CALOl8yBIJAx5L0CJEFN9rfIP/Uq1piPYQU8zo1JwFnVJpfjN2iYBhdN3y37t3CQw5
	 WQCSbpdorZlm/t0m1xS5K3JwNp2yqTrmgMEXMWvM4sMDx2bXWmYo5+0OBbN325dN5C
	 Du88q1NLUJm0vvpdBMtJXltJPeWnIn2R93VlkOepqzJYOF6qcvH+ChhDWVFVEkrRyH
	 jbmMcbC7DHUOsuPxEknLa9C0buzrISd/KJtYe8btMljPhcVzXNv8FzBycAi+t1hWKs
	 3M0OoduEInBmQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Nathan Gao <zcgao@amazon.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] mm/damon/ops-common: use a page-aligned address in damon_ptep_mkold()
Date: Sat,  5 Sep 2026 09:00:21 -0700
Message-ID: <20260905160022.24598-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904002829.116381-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrew, could you please add this to mm-hotfixes-unstable?


Thanks,
SJ

[...]
