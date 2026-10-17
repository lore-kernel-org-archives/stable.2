Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359A3AAF69;
	Sat, 17 Oct 2026 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255457; cv=none; b=DqdMTno+79CgMZicnrYkj5RDFMw+lByFEoPamBpm2meEJ2OBbKQmqHXIfTdxxa7ew4RdmdfaBRuRrJkNnCFQOuH8pBHEZEua5afaWF5LLIf95DoPkUH5Y+PSIexKCtTWU8vqtLdIPBOzRHhPNbDQNAbDtjY9UkgGH63wzSFyFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255457; c=relaxed/simple;
	bh=UKfbu1T20lQWRoXbYY8lBXY7F/u8wdHGM7XgPm/Ol3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdza5P8bW2QtK4PLoN1VZdtbd8OKXrLeoW4hJA7sQUPrvV1nLRXCzK/+zOnyXTaX5IJwL9eim5a8rddyJ2J1hI5g6VmD+WquaISu8sfG6o0bifBB1bzmjtRF8lXI4J7tZ7SMfZ7yqoOdZXMEiRQQMnFo8M+SW7xlQi6QQzXVOH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UahZwYB/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UahZwYB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BBF1F000C5;
	Sat, 17 Oct 2026 16:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792255456;
	bh=7G2NT+fxfzQbeg8Nb8I82d+DeZrkITmTp7CpnmRJeHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UahZwYB/srfY5H1wEt+QhcwHwIMamSV2QK6PUOvWsyvAWb26Ujy9ZyGZZbRIE7cx9
	 L4sFGTVbTrdEP6DUKl5iIcs+0PqSzivCsyWpbT8QIjlPo4xXhWsO+2ymfBAO3/70ew
	 i2c1sHcxmCq7aOBZwj7cGzkqkTgDWhBNYw3Nj7WkyzPo8eXCdXyfGPDNN02IkY8U1k
	 PscUh0mSTdTv/nu6ZXb0ks5naIMwGvLp9KcfXw2nL/DtBxx3f/EtyvDMygbPCUFr9/
	 4E93+YOyIxPjqYtGQ0RJSlElpcI2D2tEqQGquvN/2pynoT5jKOLzZFx9AuGopuW9Vt
	 qKGJEjMVJzPCA==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	workflows@vger.kernel.org,
	ksummit@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dan Carpenter <error27@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/7] docs: stable-kernel-rules: drop rules the stable trees do not apply
Date: Sat, 17 Oct 2026 09:44:08 -0700
Message-ID: <20261017164408.104457-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016152828.3765695-4-sashal@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Oct 2026 11:28:23 -0400 Sasha Levin <sashal@kernel.org> wrote:

> The stable trees do not apply the 100 line limit or the exclusion of
> theoretical issues, and they require a fix to be correct and tested
> rather than obviously correct. Drop those rules.
> 
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Acked-by: SJ Park <sj@kernel.org>

[...]
> @@ -24,9 +23,6 @@ Rules on what kind of patches are accepted, and which ones are not, into the
>      regression they should only be submitted by a distribution kernel
>      maintainer and include an addendum linking to a bugzilla entry if it
>      exists and additional information on the user-visible impact.
> -  - No "This could be a problem..." type of things like a "theoretical race
> -    condition", unless an explanation of how the bug can be exploited is also
> -    provided.

I initially thought requestion the explanation of how it can be exploited is
still good.  But, that's maybe what need to be requested when the commit is
landed on the mainline.  So this looks good to me.


Thanks,
SJ

[...]
