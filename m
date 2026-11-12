Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493953;
	b=zy85NMXa9yBfM/XROylWW3HTeSjo8FoYMB37XwX9HFX4Qtiocl2TbyvopBlcbKJQvBq0
	 yC4FZqdfxpIjJE9/2sX0rxRDnb+mHoBPFsaC9e679s+qcY0vfnSLXUsJR6fThAYv0D0g0
	 HrVUbzg2wMyTUAJJ8Geqm8dUiKNzI7pkWTu+JTzgqPP53Tk2yGmaz2T130G6/WPgYuQ2c
	 IFPsGglfONi5dRizzJim23soXs9Ngx8hRAjXRutouYohYXuGpzyOkJozQofjbPT72vsAZ
	 wX6ZzWHmUQU8xQnoeAsD96wDsXCV9qjHosJFfQf2dc3gop0UUBdvKS40A/gwm1Ehoew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493953;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SRsR6NpxjPS64bA39YhcsanfVCLNt8wtt6lU8BZ5cWE=;
	b=D9uHXUwb0ZkF8/L+917PHvzORP4EdSsA5CHcscCUq+KiEkWQ7HRSUDtUEFK/uRmbhTX+
	 UeacwXsO/X2JBwUYUb1zkUTobayEroI8QgLcErSBY1Ce1lyAtNFzQjn37q+M6FKE4Q1z0
	 gxNfmkPYVqkjnP5BK/A9POs/jiV2HbxxZEUvCe6VciAgBFpbl1/0itakNHlyMdcF+WhuC
	 nwiWhkIG8ngMctegIBSgcrqd/lMGwBIVX6zC5SCFAb3aqkdQhKyfz7vwAMMkNWuZGgdb/
	 dncyQYbxhQY9MrhMHbTRXwdaN6istROD90Q2rN57OEzorKBz5J3B3lzySgocAaNBrlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lz9Obzzk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188A606A337;
	Thu, 12 Nov 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lz9Obzzk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10E51F00A05;
	Thu, 12 Nov 2026 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493953;
	bh=SRsR6NpxjPS64bA39YhcsanfVCLNt8wtt6lU8BZ5cWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lz9ObzzkCRqsNKHqjCsSBDtdF7t0b6TL9jurXhMQ/f1cLZvy1IZIBXK7Xo/Kw9K/E
	 soV05z14W5WCpRmBJpmq06BcGKBDI4LrxO3OffRbtoPBs/UiUBJ8K/Q8LELMohEXkT
	 oWgjbWxEzPgKbE6yfCF7AZZW4x/kQS2W2qOoE4ijyhul2X/8Bd7zKk/561owsyZ9Nm
	 XSeEsNez/zA6y6JpC0BMAhKh0plB5xcxYvZ5nfN1H5DT35kmbYI6WBJz/repoDbJiE
	 SgaLBmSuN89KEJT0UlYfbLpJ9rLXBNQhqJt5hSMe8AaOseHutAob63YqgCtpDao8Mq
	 2JHxg/TRmDhyg==
Date: Thu, 12 Nov 2026 09:32:31 -0500
From: Sasha Levin <sashal@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: workflows@vger.kernel.org, ksummit@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	"Michael S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dan Carpenter <error27@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>, SJ Park <sj@kernel.org>,
	Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
Subject: Re: [PATCH v5 0/6] agents: add skills for Fixes tags, stable tags,
 similar bugs, and commit messages
Message-ID: <avXN_5uoMggT8hDP@laps>
References: <20261111225940.1573565-1-tytso@mit.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261111225940.1573565-1-tytso@mit.edu>

On Wed, Nov 11, 2026 at 05:59:32PM -0500, Theodore Ts'o wrote:
>This is an update of Sasha's v4 patchset with the following changes:
>
>   * Rebased to v7.4-rc2
>   * Removed references to Assisted-by: per the discussion at the
>     Maintainers Summit
>   * Addition of a new skill, writing-kunit-tests which I've been
>     using to add full KUnit test coverage for ext4.
>
>I've been using the prompt against Gemini Pro; would appreciate
>comments about how well it works (or doesn't) when used with Claude
>Code.
>
>Sasha, could you consider updating your patch series with this set?
>I'll assume that you will send this to Linus, since the bulk of the
>work is yours.  Thanks!!

Yup, thanks!

My plan is to respin this in a few weeks with any updates and feedback that we
get, and send it as a PR for the next merge window.

-- 
Thanks,
Sasha
