Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971011;
	b=jop9PTjJtOvSK5x9/TBGinaUAsITtuN+R42jziJ5oBkN07ZzeJ0qdzD7b8BjNdkjFPx1
	 kKi8Vv7PpY91E6Dca7RCxYnyHxdlWQbcYMweeHa5aBxRgF9tkzUFItDD/E8V+BBUaVpK9
	 eb1KLXT2crNJv+ZcMNtVuGRg+O2hpnhCxFRjzxkZ7kCanwn26+JPSeNLWtaRDGm5zmwF9
	 9rivdp4As3xx+uZ9M/dS6rFOV2rST6pB7k38oazZthq107JYK5XUdi7DfBBPDoG/mBAGz
	 Kcl5JyK7fMARErtdY1Sn/T9EApK70eg9Oi0HRVFqrglgB7si52YgtC3KCTYN+SrJ4cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IgHIB6FOcL0bCiYPaegMhdluu/k3cOQL1TguKu3CfbA=;
	b=dH4ejUbrHNUev0ZRrfGBUeDn6VaU4ejrR+DP7X0m9kk5JdG8v8Qd3HabcCY9Vv1Nbzes
	 zhj2BH/5E0AxN9CYzMrxT2fY7q7n7s4gBnDDWAHm5Px1GidbKyp+6BJzY9lMIeku3Ti6E
	 iYwOh1nhDK0j+ywc54dbQ50IZCfVrwYkeRduaMLv2iGAlh58Lon9V4xc78X26PcIHLbiD
	 DMlweBL4UxFMfROV50Nh6MdDEFDLCP5PdbwatkgPJLtRgcMkCHBdVaP4d+NuJ8tOOk8yW
	 EMJElnnS3g9aabbIDKsOTOVPTNjmYx9LVfANEGqOfakZfEiTlsYBp5yeLojPe34sCvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RsKPsTZX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA1606A31A;
	Sun, 25 Oct 2026 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RsKPsTZX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452381F031E3;
	Sun, 25 Oct 2026 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971011;
	bh=IgHIB6FOcL0bCiYPaegMhdluu/k3cOQL1TguKu3CfbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RsKPsTZXjG3XXKmYD9MfedxVJxvR1k+Bngrc8JlS7vFSfL05vAecigviHGlboP0fh
	 bWrvygLpdpuSlX1T4yW5JHZGUSn0nQm+uM+nxqdvo/AiyTLhOGoSpm+e/wI4VCUuOy
	 4J5+Plg/tB9Dr4QM8orhdzhNlkNS7FJ4BVrfPY2o1lslo7xZgWlpw+c5V9NQGD5DX2
	 JzjDJVqks/pk10gpOSQRNW3APUEx9JqBnkVPRKNEsx+uLTGI7iiYghuLaOL6OWHdTr
	 3x9uaxDSLSwfIzAVjLyfkCnjMWMBepRrweTG5+/4ccYJZNwaQM2FNiHIWNym7IWLuM
	 BjVrNu3BTHMLQ==
From: Sasha Levin <sashal@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH 7.3.y] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Sun, 25 Oct 2026 19:29:57 -0400
Message-ID: <2026-10-25-1-daily-reply-0011-damon-zero-target-value-decline@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025171526.157414-1-sj@kernel.org>
References: <20261025171526.157414-1-sj@kernel.org>
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

> Notes for stable kernel porting.  The upstream commit doesn't have
> Fixes: and therefore not ported to stable kernels.  It turned out it
> fixes commit 8b549a4fd3c5 ("mm/damon/sysfs-schemes: commit damos quota
> goals user input to DAMOS") which was merged into v6.8.  The user impact
> is a race condition that can result in divide-by-zero.  Hence backport.

The older trees don't need this one. The callers in 7.2, 6.18 and 6.12
already reject a zero target_value (7.2 also has 06befa61c427
("mm/damon/lru_sort: error out for >10000 active_mem_bp") and a16fd3ad9d89
("samples/damon/mtier: error out for zero quota goal target values")), the
commit has no Fixes: or Cc: stable, and it is patch 1/3 of a series whose
patches 2 and 3 remove those caller-side checks.

-- 
Thanks,
Sasha
