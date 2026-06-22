Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341B436606B;
	Mon, 22 Jun 2026 22:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782168662; cv=none; b=seC9QbbepBx3DTSNmmPrJJHOTyeWZ4tA/N2M8jbWqI5pCa4NwXk/udSmlQJopvhQLoCuMz6ym3GnuWQYH13VJdXq4ir3l7+TIi1EWcAGDaST5WVkqbnkPIM1H/H+nJOrC+s6426MhhSIwhjwXHvOTUBbZVnqC7Vc5cTm9OIdiIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782168662; c=relaxed/simple;
	bh=rnT96qVqQg7ABIMSKNyGXskW+j2yYZzvm0HmE4v8Gow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cq6rNbrdahhWN/VxougMt9yVtHoPiq3iGCCkrQAB8j21f33/rYo3W+54btZMTCFhNLKK5wLDotQhDkGObW4f+XpRxGOSy0uKwD9ZPs1fFbkDlt/2IFjrXLFhRRyUcci92+09nJBF7t5B1oKUBSyJI+cJJbDLodftd+fZZwhsuyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 65MMoasU052557;
	Tue, 23 Jun 2026 07:50:36 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 65MMoZsx052553
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 23 Jun 2026 07:50:36 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a9388816-e934-45d0-bfc5-8a40418d4adf@I-love.SAKURA.ne.jp>
Date: Tue, 23 Jun 2026 07:50:36 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] profiling: don't free prof_cpu_mask on init failure
To: Tristan Madani <tristmd@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
References: <20260622000022.3375262-1-tristmd@gmail.com>
 <fb12bd4b-58e0-4d78-a725-7e2d44b6350c@I-love.SAKURA.ne.jp>
 <178215292501.1603617.6905680542049189509@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <178215292501.1603617.6905680542049189509@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp

On 2026/06/23 3:28, Tristan Madani wrote:
> I went with the minimal fix you suggested since 7c51f7bbf057 touches
> two files and adds serialization, which felt heavier for a stable
> backport.

OK.

> 
> Would a v3 with the corrected Fixes tag and a note explaining the
> choice over 7c51f7bbf057 work, or would you prefer to just Cc stable
> on your commit?

Just as you like. I am not the person who makes decisions on for-stable-only
patches.

