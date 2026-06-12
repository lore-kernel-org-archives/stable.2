Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F12338A717
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275287; cv=none; b=iHg9fC0IHBl8k8vODiWxpZnHrDajjUgGi0Zq3BfRQx9Q8ZQgt63Cv7bJHSqP9eGKmXQBOlevaPQtf8V8FPe/tTQJRK/UzfTqCLXGOBWFamUFP5X+MHHNCuHV4Is+FXXnWMchF1r/V4eBSU5O7wBqm0uUik0vJN/oR9woabigKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275287; c=relaxed/simple;
	bh=AoBOW+oTCOf+WMN4/DkdcpMDFGVVNzKZ1dh9fKAp8WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdLQdriqeNLEjJ84t9G5gpk0drvo3gr4zxlZj0wdlUEnCILaMl5e0EZNSLAPlJ0Dzl6bdQvv16ccgrLofEj4ZEqNB3mwWsNcjyy7rgmXTktERZDySdNz+TXESPsqEUyRvmkxGAOL1Rv31fqFSYoQwNpmkNn5aETSw+cHZDKCcVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5Ljb8TZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5Ljb8TZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1061F000E9;
	Fri, 12 Jun 2026 14:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275285;
	bh=KYmYMtgoeuTX03hBjbs6UFHWoM1NHaXjAItRsKqypDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E5Ljb8TZ3ANxHjsskgPqprcB4Je6pQRgYgK16UmbjgQ+V918c33QSeWOsnWyDQuF0
	 gIz9YZkGO9RqQtXarz6MB2vCLhTXrOP6A0/+pRrkt5RQbGhOysLveeiccnGsX0A9Kz
	 Aic0KX1jglsPjMNoPKuupoRC5Vl7bvgCNylfPq9bTaUtMjAddKO/B3FD4kh43jIcwr
	 6EJzf4Ry2s+2WEhaZbyScfHHus4MT1OK9Ri5PwYZa568VhT8C6/pVN0TG1HiNqa2UL
	 HEi98DT1NqLhhG0Pxui3PXXaPMeEEjZFNQp2bStlCzBnAg5cZJ5JrILVCkdmhyBMWF
	 7XlJmOKTsCwJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH 6.12.y] reiserfs: reject direct items that span block buffers
Date: Fri, 12 Jun 2026 10:41:18 -0400
Message-ID: <20260612-stable-reply-reiserfs-direct-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611223944.74106-1-kylebot@openai.com>
References: <20260611223944.74106-1-kylebot@openai.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 03:39:44PM -0700, Kyle Zeng wrote:
> Track the remaining mapped-buffer bytes in the read and writeback paths,
> and reject direct-to-indirect conversion when a direct item or accumulated
> tail would cross the target block.

Thanks for the fix. I can't queue this for stable: reiserfs was removed from
mainline in 6.13, so there's no upstream commit (and can't be), and there's no
maintainer Reviewed-by/Acked-by (the subsystem is obsolete).  I won't take a
stable-only change for a removed subsystem without upstream presence or a
maintainer ack.

If you can get subsystem review/ack, I'll reconsider. Note exploitation here
also requires mounting a crafted image.

--
Thanks,
Sasha
