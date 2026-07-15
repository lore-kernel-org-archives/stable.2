Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DD5392831;
	Wed, 15 Jul 2026 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131264; cv=none; b=m2EX4l1LnFdo2Q3FU//f7vsmvsfd3FcH4kllGAU2w3JByqFa5PdHlFjQ1h7xBVA/kHl85XMDr0Ndto8WIJUZCUuHRUM3u+gLoeUy0A9DrR/3FBN36YujabD5LlAYawuRtXXmaj8kuO3ogJiufdLzDsaWdof1JxJOt7qTFmKvTpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131264; c=relaxed/simple;
	bh=HL7nEZMAAgNcFtaLjWcaPJUNshIHasOvdflE1dWR3p8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Klek8d6p0xOrYNrO5Bm3EnMzBkHzwnwrcSlA31osllXXqprmO7rbgpk/fGGG4Apjb6bLOam1rWgjmDe1uDfubWd8OcMpM3/ApmxFY9jVat6MbzRxS26SOTCITZwkyOLj3E1e5kgfOl4tnLwC3y6B1oYz6DmlqzAsrbbiN0aboSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdjXiX8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdjXiX8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731011F000E9;
	Wed, 15 Jul 2026 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784131262;
	bh=FqiL/TPz9Zg7B3uOQuWSBDQK8s+wqi1hgVKaOFrfCyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WdjXiX8ZUR9fbMyqUPf0EmeiJCY0OolHPBzLeXdRu330DwIg/dF+aItKukNIQOq85
	 PnqcM7zAERCY6Fd+peleXqu3p63m6g5jpzQCQpWcs2jp6pVej2Xy4DReD9gspiDKJ3
	 Ub8O6t16L5JZVvysLKBYZ9BvBQP6XomBzNSESKYtqGtqJP6wa6OC35Vfo6X2imoau9
	 LrmEdgkNGVQMjQ0+7wSWeEjYYxvaVL8Md4hd4VFGcA40SELiUuToDrAo2qgjDso8kH
	 WNs+DcgUaLmyzoYqYhMItCywX9DxCt//7Zbcr3dpqo4LNho3L9QFHkm+kNHjGIId6q
	 aMpQieX3QxYLw==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] fortify: Disable -Wstringop-overread in tests
Date: Wed, 15 Jul 2026 09:00:53 -0700
Message-Id: <178413125012.626806.1119650870376955370.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623-fix-test_fortify-for-clang-stringop-overread-v1-1-15ee8342a953@kernel.org>
References: <20260623-fix-test_fortify-for-clang-stringop-overread-v1-1-15ee8342a953@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 23 Jun 2026 13:23:46 -0700, Nathan Chancellor wrote:
> clang recently added support for -Wstringop-overread [1], which is on by
> default like -Wfortify-source. This breaks the usage of -Werror in the
> fortify tests, resulting in the following false positive warnings in the
> kernel build:
> 
>   warning: unsafe memcmp() usage lacked '__read_overflow2' warning in lib/test_fortify/read_overflow2-memcmp.c
>   warning: unsafe memcmp() usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-memcmp.c
>   warning: unsafe memchr() usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-memchr.c
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] fortify: Disable -Wstringop-overread in tests
      https://git.kernel.org/kees/c/c1f3e770eec2

Take care,

-- 
Kees Cook

