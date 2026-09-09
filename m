Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1C43A257E;
	Wed,  9 Sep 2026 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788934449; cv=none; b=BRa9kdKeBX0Ra+Pf2AHUPGTVxjESJK/BGPLcyjdqiZYeO4qfY8jFaPiwsFThnZFgQYoTlDX7XF1Hp9QB9NVCgu+QmbBJ7yCuKZ+zVnAmum9HFJZp//hxO8i+1G3nrX5LJHIQ/tN4IToWCkec7s//zL8si08GrQSv1lLbe41I5wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788934449; c=relaxed/simple;
	bh=Wahhu7gCCnibQMn/M729SHAGIeAyGgwCdg48WYJrjSM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JOmGih/Jzj1bOxjYJJgyh76HU5arttRZUXXSli16E5U69zY9RKSNmulQqXhXPF/FmdGsa2OrdW2nAEv9UeggC38Tr5h4eG3MY+HVwmNCxi1fou1lX2bAIefCY+h2CIto4sjA2hz3CXD5uhRThwe7FMm2AmEBnygrV+To/BnsQp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1jyrlnR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1jyrlnR"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 61C401F00A3A;
	Wed,  9 Sep 2026 06:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788934447;
	bh=IfCJaxQ5jkSfE7niHc5TDkGLC+xox/FNfSKEsiO34mA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=X1jyrlnRNJ7qeBuQhSJkjrHKVPm8eMRKv83MKYP9a1caaMx/ED/qlZYAyrzf9ZUXK
	 bH5fagy3u/Mpl5B0+o4Brjk6YIWEVAFxwNVazRTL16RRuZ3CHHKpac1Jin8M1VyUsK
	 DvvJvBRqkaL6qgtshZuy2j02QJXyaUyCPVEcC0iEHIUidnmgwMQD37nKBA7n3qVGdN
	 JiMrIOdp1nHtOUPphSvYk54weEKKlSleTLAFqo6AEmA5Hxeu+EfEsxUdfhKEm4IcMn
	 SpsjPimKT3ea/Iml61iZsgxU/SbYjcjZda0cLjLm7smYhectoTIAQa4pGFXdBR2dk8
	 aTyFxxvH2N1dA==
From: Nicolas Schier <nsc@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org
In-Reply-To: <20260831-sorttable-long_size-unused-but-set-global-v1-1-8a96b88697e5@kernel.org>
References: <20260831-sorttable-long_size-unused-but-set-global-v1-1-8a96b88697e5@kernel.org>
Subject: Re: [PATCH] scripts/sorttable: Mark long_size as __maybe_unused
Message-Id: <178893427036.356946.766876199335071623.b4-ty@b4>
Date: Wed, 09 Sep 2026 08:11:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-1f2f7
X-Developer-Signature: v=1; a=openpgp-sha256; l=732; i=nsc@kernel.org;
 s=20250924; h=from:subject:message-id;
 bh=Wahhu7gCCnibQMn/M729SHAGIeAyGgwCdg48WYJrjSM=;
 b=owEBbQKS/ZANAwAKAQdSCnAWJhJpAcsmYgBqoPiFVATJmEA033ik7sZ8/YrMthm6KNT5Sl6mH
 zcw42CRy6KJAjMEAAEKAB0WIQSHQTenhzckp4G+wsYHUgpwFiYSaQUCaqD4hQAKCRAHUgpwFiYS
 aTm0EADkFUFT9cQdd9XFvB+Gr35i1nolRwWkftjTC0IbQxVAXqBg61NDz29ELexvNYRCFuhDefP
 QXbXqI5ZlP0Dp/XwkvblrQTS9wAMa5EWkPOf5HiOK5WMjyXu1WRbHon7xeWHN2VXOvZ2IKAKLT/
 X+CibMMZQonxRaq5zLNj/E5Qbt9ia75fPi/7SKF+ljO92d47Qf9i959CNcRpznvuSXejOcWY1RR
 /dCchfNOzYzjidV+qui7G/LolbhDaUPCp+AFv/zSfqKytwqod5mnd/BkNJmiQID9/pNLgRQ+tFa
 YVUBPWzFtEYIqQQljj/2W5NdvEZqwogE7nO0vazJK50SOO6I7FeeCm5Zl7W2fV7z+UywvRHE1Fs
 ZJKLmZ4OB+iySt5JfweF8okAF9CGnjcp9B5Z8JhXohEpFRS+hk1orGtFN4apThihqavYle5zBV3
 4Uyj3Cek/cgcEZtxQ/jnoP0CFa08pFzpU0fXoJj51JwwI3xh6i+OXOeUrQE9/x/U8PeoQUpFV0z
 HPkYPdIYrWvJ9Yd6Hia76L4C0e0a91x2JaX4alNfddcAlyxCDIUdgM9TCG0dloD4EUX/borMmtv
 knWnY/k7zYUgEGTsN7LG54RwpD7x0frQWOEL3KWkXb8jhgAc5+73nEE7TommlYrzO7qrhdpQZ8x
 CSdcgGZP8RXeX8A==
X-Developer-Key: i=nsc@kernel.org; a=openpgp;
 fpr=18ED52DBE34F860EE9FBC82B7D97093255A0CE7F

On Mon, 31 Aug 2026 18:46:31 -0700, Nathan Chancellor wrote:
> scripts/sorttable: Mark long_size as __maybe_unused

Applied to kbuild/linux.git (kbuild-fixes-unstable), thanks!

[1/1] scripts/sorttable: Mark long_size as __maybe_unused
      https://git.kernel.org/kbuild/c/d9e2ba9f

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped,
reverted or modified (e.g. trailers).

Patches applied to the kbuild-fixes-unstable branch are accepted pending
wider testing in linux-next and any post-commit review; they will
generally be moved to the kbuild-fixes branch within about a week if
no issues are found.

Best regards,
-- 
Nicolas


