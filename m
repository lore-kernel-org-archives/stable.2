Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377993;
	b=1QDsCZla8w+4j5hDuf62zdjgq4EClpz7fobB7sxYxZoENa8tioSydUO6pS+257IIPfxz
	 0KwiTAEsTaG8/SDgi8z2/DRXUS0ushN/Zt3z3yKV4omy+x4oljgpuw8QYV0MxSmKEx+II
	 iwbiOWrHej5Q+mbfxCjexMFbzpRedvcO2E3xpewCVNMJkCWUudIB70FLHR3R5Iq6TcpUY
	 CJ3StKG/YNuLTHV4FqiFfY3LLudKORMOxGofHlbgeBLybfhvXAFBdC3Wza+I59gmu7Xne
	 k+iXNiZHZD56GCAQD9ReTHGxjjvnSWPUz/LQPjbfYpkfsRX/BmTOqtnNM3NncHcu3yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377993;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=lbTuAzuPKByX5dC0q3vuXiQlAi3AAATOhhibWeU5cGc=;
	b=Pr/Cx6iO/nIbNJe62odvZuDsGZxp5DQF5nVnjCOlTybBxxdH+WBWRSZRdbLIi6S9+CK0
	 kglkrHFod3n1T/dNjFA13OpO65hysD3+9la0LE9pW96TR9PuET7sippLSlENeCMptqmlP
	 ptSc8y7cz6giSRpfk9yJ6tWmxjghBdsC1S94rk2bKX2+Z9kus3R0k5LRv0lqCi4gwez7M
	 2gz6VzwS5vPY8vASTYJLqkNEjc0wGSELANtYWE3FGc14TJxaabSKbt2S3IzUndMdWUKsp
	 UBniRhBO+DO0DImeCvvGoFt0o368k0aP5pKC/38rm7+mkPumGL5qovONKthha/1skkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m+qI10S/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB3F606A320;
	Wed, 11 Nov 2026 06:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+qI10S/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1AF1F00A05;
	Wed, 11 Nov 2026 06:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377993;
	bh=lbTuAzuPKByX5dC0q3vuXiQlAi3AAATOhhibWeU5cGc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=m+qI10S/4af8hO8ERcdUo86cHJO+aAGufuIbj3GtRZ5oZb363CpJx41beMeiYJwZd
	 qyO60G2PW1YYDKC8RUTMLF67y9nTjGpfESiM0DhiTTVn3nCpb9mt25LNl2ImO5mJ3j
	 jJVmCl2Ubohq2xbaJgo3E2JitJfR0ngy1176DPuGFs4Exkd8F2N6z+3k77aAZKeZXh
	 KS9YO1BwGxe20TEFkZ2xCp7zji07TK9XQ5puK8oRnQfTmIBcjqIcwMoRa1lr0MTCr2
	 ieK747rlbuXrLbSojzLzVvuMa34kFbZQw8XK6fvQ6kAHM/niCYX7SoG/2uU5OEpES7
	 lgOgphURVt97A==
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kbuild@vger.kernel.org, 
 Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
 Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: Yabin Cui <yabinc@google.com>, Han Wang <nesthanwang@google.com>, 
 Nilanjana Basu <nilanjana.basu87@gmail.com>, 
 Snehasish Kumar <snehasishk@google.com>, stable@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>, 
 Bill Wendling <morbo@google.com>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Boqun Feng <boqun@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Justin Stitt <justinstitt@google.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Tamir Duberstein <tamird@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
In-Reply-To: <20261106113800.v2.1.I0b27923381ef34cc99cdf8b65fea2e1bafce6370@changeid>
References: <20261106113800.v2.1.I0b27923381ef34cc99cdf8b65fea2e1bafce6370@changeid>
Subject: Re: [PATCH v2] kbuild: AutoFDO: Disable Profi
 (-fno-sample-profile-use-profi)
Message-Id: <179437796877.3770401.4019375927592079703.b4-ty@b4>
Date: Wed, 11 Nov 2026 00:19:28 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=754; i=nathan@kernel.org;
 h=from:subject:message-id; bh=8AeJkqx5Jw0PBwVRgQcq+5k3vNCrVemeTf4e0yDe/Jw=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFlfOP7//eRg7XDwzYwTgSku8h/8/xbluR/ps/r+SMs76
 QqfvK5ZRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjIH2+G32zu7d/S8pnMsmbV
 9lnrJ4XPZJPJ1X2ZcZZn94OqdP97Bxn+l+w7JtC/iNva992mDG3BptLctovq6tuW256+vDzYsPg
 lCwA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

On Fri, 06 Nov 2026 11:38:01 -0800, Douglas Anderson wrote:
> kbuild: AutoFDO: Disable Profi (-fno-sample-profile-use-profi)

Applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git kbuild-fixes-unstable

Thanks!

[1/1] kbuild: AutoFDO: Disable Profi (-fno-sample-profile-use-profi)
      https://git.kernel.org/kbuild/c/3df238d7a9f5a

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped or
reverted. Patches applied to an "unstable" branch are accepted pending
wider testing in -next and any post-commit review; they will generally
be moved to the main branch in a week if no issues are found.

Best regards,
-- 
Cheers,
Nathan


