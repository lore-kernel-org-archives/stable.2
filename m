Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216F4E8DEA;
	Fri, 16 Oct 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166373; cv=none; b=mz9xQgpUitkYaIz8FrjdwQtQdpwnw6pHS3DQPNZHHN/FOU+iBfnIhtusbpf/GpgMM8y85kZrk3Ninx6x1pnH52cq2bxo8CSE2n1FgVEHiMFNp4ztzzbxiYpyJcWZXMFxp/wCKnroToIlRDYj7UkhB+qLFc/cyNsx2JT2JMp7M6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166373; c=relaxed/simple;
	bh=JQEGSK2pYulUe0kONq6d8vGuxxNXQiSUp8AW0VhvBwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzXO6+OcuIlwg2wZ/FGo0b6LEOq3KdCn80WrFryrGXTB2Ih09t2G3VA0Rft839OXrQKgrvhPYNFtdOxd7cDr2Yt/5W8azRCoPiDqmGLq7zOqFCzTfTo9VAmsAO7rvv7fHfNOR2huts9sswJz3g48FIZJQ3cgf1xSTA1Uz2d7q4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VJLJnc6q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VJLJnc6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D725F1F000C5;
	Fri, 16 Oct 2026 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792166371;
	bh=hVr/cmNBpbqy04sQVQPU+yZ2uzWGVNq85a5VPK5nE3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VJLJnc6qV6FQ8ss924dqxGE6qulRJ2N3xEkI00mjc/X/LN/lnf31Mlv8R/7i80GiG
	 jiJ91OA00r8UD/iy0ST3ja6wUMlmYyO1grhsgWXanyYDkp84gYywRzHwXjxEXqKEEr
	 2kyAvXpMKcEN602G73HtrTcDCLcyKsom52hKt8Gw=
Date: Fri, 16 Oct 2026 17:59:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: workflows@vger.kernel.org, ksummit@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Leon Romanovsky <leon@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	"Michael S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dan Carpenter <error27@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/7] docs: stable-kernel-rules: drop rules the stable
 trees do not apply
Message-ID: <2026101626-greedily-finance-f01b@gregkh>
References: <20261016152828.3765695-1-sashal@kernel.org>
 <20261016152828.3765695-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016152828.3765695-4-sashal@kernel.org>

On Fri, Oct 16, 2026 at 11:28:23AM -0400, Sasha Levin wrote:
> The stable trees do not apply the 100 line limit or the exclusion of
> theoretical issues, and they require a fix to be correct and tested
> rather than obviously correct. Drop those rules.
> 
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/process/stable-kernel-rules.rst | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
