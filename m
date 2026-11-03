Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730623;
	b=yS9tfj1AzqcVUh9a3KGPkxhRsO50No2P6RQsLb4/ZzQZEx360A4gorTA5d9Q43w7TT7U
	 6nR7sEJpIjH4/0nG9p/gzpySu9VCow3ww171+TGU4FE3+zKfX1wx4UIj4M3lkXREANx6q
	 wNeXhNZro6Bdht3/Ql8v9eRFXcT/TJnjA/+LTc/PCqGoXMHPo7R4BXVWrxfh+2nAoLzpq
	 Au1d0veaGsyie8wFbFE5YBQVBQXrqcY7gGODg75uSrvAlTysPRtI5az4Wdveij4Tmi2tg
	 JXd7GozylcjFPjgA+jam0vVJkXsrxSMs9AOkuZTLsA5DeAiJqMvS3MtXb/IWKejpiMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730623;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=o/fdt424hIU68uAYJONXv1npbcycyDxRVgKexRLZ6GQ=;
	b=GCvyBYoanW0ILMz9lbIP+CP1E4mFBz81FYw7e093A2kfLeJNGFs0blrnJEJhq7yt50u4
	 nKgaKvM3P7tlDKrm0uDBRyKwJTYRnFBTJR/LcNexAkL8JSv47m+rA0cEiOqM0Kb0wGP3L
	 CFfuiQwEoDGIxDR1+pYsSx4th3UJL2dpJvefGtl/3fCFBdf9gRGXFq7YySbgxe4JAu7Pt
	 IbfoiKA4BlzRtaSaBuvscymioA2xK4ENNlQI2RxrryHBeRwuFRRJqE7V6upPdK9CDMrMn
	 1n+cq+12uE6uTCMcO+BEizo8TBSxseEhdo4OmhRaBm8tHPEIBwdCmnuJDW8kDjPnmpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kz4K6JZL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016CB606A328;
	Tue,  3 Nov 2026 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kz4K6JZL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43BB1F000C1;
	Tue,  3 Nov 2026 18:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793730622;
	bh=o/fdt424hIU68uAYJONXv1npbcycyDxRVgKexRLZ6GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kz4K6JZLVW9TKnN76d6D3OuUrgzUrK9/fEb1e0p3TxSKIHbz9YDtGtsOu4Ksf/ZpK
	 kD9MIMNtYaY78h8abOFdpaEUU0XC9wQdOyjbmJutHgEb/Cza2BNZeUzCVbvAG1jSPB
	 I5wQlgz3ORyE2naRjKjRA34AgZhiIFksIHnmvxbho49MKRY1F82rzjl7YuNhxLte71
	 MIxtjfCMlYruQm+S8tJB6aMPvuWiiZE3vZ4n7B0/c4UBlqcFcfiJAMl8tEdWFZ98Wf
	 0oFJC2ltiQ7mPt5M+4d57iM9NA4ZC43W3kP92E0Cyo8yF5Y5AedKjVl3n0qAxdRPP0
	 ODC4LrgGrXN7g==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] liveupdate: check for duplicate session before growing block set
Date: Tue,  3 Nov 2026 20:30:15 +0200
Message-ID: <179373060810.1731986.15227244276856998447.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103153928.716753-1-christian.aurichzm@gmail.com>
References: <20261103153928.716753-1-christian.aurichzm@gmail.com>
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
Content-Transfer-Encoding: 8bit

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Tue, 03 Nov 2026 12:39:28 -0300, Christian Aurich Zanettini Martins wrote:
> luo_session_insert() grows the outgoing block set before checking for a
> duplicate session name. On -EEXIST the new block stays in the set.
> 
> If the session count is an exact multiple of the per-block capacity (51
> with 4K pages), that block stays empty. It is serialized with count 0,
> which kho_block_set_restore() rejects in the next kernel:
> 
> [...]

Applied to next branch of liveupdate/linux.git tree, thanks!

[1/1] liveupdate: check for duplicate session before growing block set
      commit: 7d4282ec2d3bfd5e7959bbd2663936a29c45f609

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: next

--
Sincerely yours,
Mike.

