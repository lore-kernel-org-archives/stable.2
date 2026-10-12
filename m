Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01690367B6E;
	Mon, 12 Oct 2026 03:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791776095; cv=none; b=DFKleMT026Cmp7ZtA17M1nWPtvMwkGMN7r6ta3zMScW82EKWMHUdRHQYEsg417Ochv3IZFuB75jK9cGx0Q1ZSwBdKXt+4muoavpOgurMucumM+IBc/V+FIEjAAbyDhUHJgSYgQ9t3RVNBsPpHYel+RFWa9i5RgngOd/6lBizdw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791776095; c=relaxed/simple;
	bh=niR6lxxPfj7rUlV6aFum9mpPv9YPbw1ezycBYAmU8MY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=V22gJq8gKVK6u2CJNTywg8PMplY7GFFUYxdCqjxGxw8/24Xoo+H3T0zuEPaLcLwPdSw/sZSMGDUnARVNHMxVkzQ5KoQO55k6lBoDe2Q8oOfMtEBlP45y2DoIoPqjpmfBUduTIaD9uqmmn2ejxkxuPsV1UXnkeDhrEq8XUtRRbg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLo5OulB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLo5OulB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC521F0089B;
	Mon, 12 Oct 2026 03:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791776094;
	bh=9j/8LRg3nbIXkmteXtvyJePgEJ8EH3SPQezus5FZ7FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lLo5OulBIQeymnR7QQjd+VQBj59jtIixM6lvUh0BsNAHc53rUJwGfLdRGNP2lBvpT
	 ZsHcl7Xy1rz40oKmCFQBwOydbEQEA0iGnZnx+t1V7Wl+cAU9gfkFFEnYee/5ddVaKT
	 g0M0BJlFG/S05kmY7miUxNTswkqGwpb4W++kaKKFp4HAZ2/kzyFGYhf5v+wF//SR5m
	 zscSJzJBa8grNMy8nzG73jMax9Zki1+72Mpr+kxoxm/BPIVHPs3DYeXIPESB/SVT18
	 Etdbc1J7igdb/sQlUk6WyZ2Hcvyasp4HBudNusUpscYitUVd+wLBB1+BMOnvUujrVE
	 RztC0KLfxw86w==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashal@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Ben Hutchings <benh@debian.org>,
 Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] bootconfig: give the footer size static_assert a message
Date: Mon, 12 Oct 2026 12:34:49 +0900
X-Mailer: UndineD 0.1
In-Reply-To: <20261011223358.2327625-13-sashal@kernel.org>
References: 20261011223358.2327625-13-sashal@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261012033451.EEC521F0089B@smtp.kernel.org>

On Sun, 11 Oct 2026 18:33:41 -0400, Sasha Levin <sashal@kernel.org> wrote:
> static_assert() without a message is a C23 feature, so clang warns:
>
>   main.c:498:56: warning: '_Static_assert' with no message is a C23 extension [-Wc23-extensions]
>
> Add a message.
>
> Fixes: 6ed5e20466c79 ("bootconfig: Fix unaligned access when building footer")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Looks good to me. Let me pick it.

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
