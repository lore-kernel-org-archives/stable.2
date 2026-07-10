Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC30E225A38
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717412; cv=none; b=JlebUsMHkYSN8jXlSOC4AYAeELyUGyNK9K91+klwSqsb13hVw7Yz0WUX/Oz/3TvV092R0P11Za1O7U7MwScng1+p8ctc7wh3bGI1i0IElnftUw38fHNq1nAANldIgDF7XTJoBPpUSbF3DsYVQoawRP70zl5gc8VjaVSt/EK+LVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717412; c=relaxed/simple;
	bh=sggs9wvKI7ULzqEa2iKavhPXj80VKGnlmc68dHvqO34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCucKW+pv8xcFKwef/1h1OagXdfFOht2gLcbkJdY+n5wJMSJUoO2dMebnkxDIv7f4o5yIJ/D3+xaHBQMlWeryD/GoIV7jixgSF+iJbLcAJ9z0PUiyQp9Y7oezf9lue6PpzRYuasK1VErIND1BeEPtLLgJo7JOX/8PJPArtpCBMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcpcIIrl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcpcIIrl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144C21F00A3A;
	Fri, 10 Jul 2026 21:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717411;
	bh=91JQGQYSF7IV/F0KL045Nxmn+soVJeyYVB1PHP4iyvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CcpcIIrldGYXMOYfdvCiMzf3VcJQHj49/qgooXZfEHyMsstHdP0ZaK+nYL/L4t1LP
	 Kc5q4OkZFboJ80Ft3KnsoHHocCt/PKJHboRKDx7bwlsd6BiVjPksoNo+qSdfcG//08
	 yNN3BSpfKXaQFnnOb/JOhBFTXbc5lT2GdX5OvaPRDcV0zbTa8teeZmP+0NvlKciWsv
	 FscLOYgbQJlcFEU2I8/dqjEIm3fKiazAduRAcdSfVfjjqNUK/MlAb2x8YpIv/2GZnw
	 P8LC4u6BfZ6cthzTMVA74SVLwIyR+KTcSguuTAENx1O8/BdgTnKEZgIF3YF4qPWPbR
	 eAfHifgACsGHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.18.y] rust: kasan: KASAN+RUST requires clang
Date: Fri, 10 Jul 2026 17:03:04 -0400
Message-ID: <20260710163023.agent5-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709175943.129241-1-ojeda@kernel.org>
References: <2026070939-ranged-unmapped-3ab9@gregkh> <20260709175943.129241-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 09, 2026 at 07:59:43PM +0200, Miguel Ojeda wrote:
> Kernel KASAN involves passing various llvm/gcc specific arguments to
> the C and Rust compiler. Since these arguments differ between llvm and
> gcc, it's not safe to mix an llvm-based rustc with a gcc build when
> kasan is enabled.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
