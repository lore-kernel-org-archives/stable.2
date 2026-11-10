Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322728;
	b=RmS3z1RdsyEj35peIAX872awEhgcsEetpSN9XEbY3E7Ksv96XwGnMpOE4XXDvwL9MG8b
	 rN1YVVfLJm/B7dEH50g+rxvuJdWzcJdn/NN/8X1ge6croQNMMxzrtz8+iV4/eDv+uj+HG
	 M0sqwE+wMWfFD1jnSlVD5mjS/F8+Zu+lDGPuwPI+Xa76PT/TX8sIHpyhVhueZBGLiQo5z
	 luDDYBn0UO9ArSUxgSX74dpAFDGadFgBQc6loDlZpgB/1mgibK3owevN4yTj1n0lK/BYC
	 L/ObowgJr6nRJsZSVN7gxuW+EhlDIFTtuR0c45J/bEMHnjpYWBuCX5ZJrJvoOiV0ftQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322728;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=bJyBkipq/8VnHVmxuZdWoeSnkdnAYGFqTisHEUQIoBA=;
	b=Kxlt7dFRF8ELOyfNDvqWCVJQAXCw1mwgF1PnOt35r/Ffhp2uVJ69DMdtkDd1BYFX/qMQ
	 MoS9OY2YYxVXfH8Gaoxjw0HK4AMH9SBNBqf43/QQkHoZ4RPK7HXgQkRCj/owjVP4wClhs
	 PrwZ045GpzkVApdewFTQWU4IN5SAQg8m4XeXV7w/Ap5lfL6nOzgGSjIYUwItaGWAnXCEV
	 for2/u1ikJkByGMcfyi3CfJUVKDbGGAyA3lz8Vwi+gLL//5rjepMCfG+VPcv4hnBMPqsu
	 4TyIC/lbAQ6lN8bGPKIqECRfAkeUPAbBvlNb4QupE49ldQ0Gb+W7QLUqiAuAvZmRc/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6jI6pro;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A01606A333;
	Tue, 10 Nov 2026 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6jI6pro
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7FC1F0089F;
	Tue, 10 Nov 2026 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322727;
	bh=bJyBkipq/8VnHVmxuZdWoeSnkdnAYGFqTisHEUQIoBA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=A6jI6procODsK7CeA6/g4xeAEWNpqcON0ofARkE55EJ2hB1JdvmLmKKoFakGh63q0
	 Wk5DMd+w91TKjwQYD9uXZuDPqt5Jhep0B/CMAOySR3NlwmaY1Og3ygrdvKUV8xYGHw
	 qLZ7fmPtWFMw2CmChiunRs7uE5dw+qscmLBQpyYUrtk3/BpmbKujthYqm+kiW61sAT
	 ITbmLeOVUPO2H+7xzIw1mtjqb6dizzdUaaClCg/ZeYLvwLIbGSTmPhOZIlTu+6SpIR
	 D1h+Ew4jEeOiIxevjnUPig5D8kAQ+0HZvSo2slFq8aGREYPKwhHBJPnjaUWd8bRphm
	 KLVV3AgHsnYyQ==
From: Christian Brauner <brauner@kernel.org>
To: jaharkes@cs.cmu.edu, Hungyu Lin <dennylin0707@gmail.com>
Cc: coda@cs.cmu.edu, codalist@coda.cs.cmu.edu, viro@zeniv.linux.org.uk, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261105051406.52442-1-dennylin0707@gmail.com>
References: <20261105051406.52442-1-dennylin0707@gmail.com>
Subject: Re: [PATCH v2] coda: honor the append state of each write
Message-Id: <20261110-finte-gebiss-human-e05dd6b47c78@brauner>
Date: Tue, 10 Nov 2026 15:58:44 +0100
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
X-Mailer: b4 0.17-dev-ce4c1

On Thu, 05 Nov 2026 05:14:06 +0000, Hungyu Lin wrote:
> coda_open() adds O_APPEND to the container file's f_flags after it has
> been opened, without updating its cached f_iocb_flags. An O_APPEND write
> can therefore overwrite existing data instead of appending. For example,
> writing "Z" to a file containing "abc" produces "Zbc" rather than "abcZ".
> 
> Pass RWF_APPEND or RWF_NOAPPEND to vfs_iter_write() according to the
> incoming IOCB_APPEND state. This also honors changes made with F_SETFL
> and per-write append overrides instead of relying on the container's
> open-time flags.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] coda: honor the append state of each write
      https://git.kernel.org/vfs/vfs/c/644cf7b4af68

