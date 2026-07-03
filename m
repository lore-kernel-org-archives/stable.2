Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3043E0C5F;
	Fri,  3 Jul 2026 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088244; cv=none; b=JfPjEoCmXzDUfVC+rHKkz7juC6WGSbhSFgS5AEo0mK6E7/mI2rlSDkAAKnUOAkfHJm+HdZLJeMdX9Qfgi3mkuFhXNSUw17Qy+8BsTHRE/iilFsXxwnXGloPI8LYGP7A3tawVKyQv7388rgGp//X3VeXRGJaF5akNWZTNXMEXTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088244; c=relaxed/simple;
	bh=RyoUpzyXE/7znmuPerg2ja01YbdFuIXsPb1n9JsGwE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eguqcNMOfsQ0qTx5xSyR475SbYfz1jdTcc1OadtUuMNezMilkKZgBABmiiLmcqqMj1hrCmfTZ7ZqFTGtHaNqVU1OpFi++pTNiPgX2E3YQOn23RW1HRbGogFQuf/ZubpiMTLr+nBBJDqo6wKTyz0J7rO4/QcjbBG2+jZzbBGBPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=vi+e17oX; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="vi+e17oX"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 4412614C2DE;
	Fri,  3 Jul 2026 16:17:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1783088237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h0/G1RbQfTBkk4DxEYT0JUXdIjg59u9DH5wVt7CJFkc=;
	b=vi+e17oXEyM0Wq0B0T3TNhe2ReIP5YxlFV29e+FvwJbeniYoVSVyug2eSxq684gkryTsnj
	HOLunvTP/CHHnOyFKiaseNsLBerLXNS4zrFj/gTGtkxLpCSNLuT+55QYxK7HtPHuIZjOsc
	oybt/5YIVJvkBnkLEVwkGCPYd7+iqkRJ/fWbPcqEt4UGJlUWFj6C8HEuMivIPLncisbLON
	Ssg+JFLWNZcK/4lmaamMVGZERo1giNSUWWBh6KXtCOjAEisnJQAG7arLhE/4K56rJLJmcu
	B5NCBz0EQIOM6IT5VMoE3uw4NOPHm3LXX+ffCLifTImO0iu9fSC4BjWal2gE6w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ac786db3;
	Fri, 3 Jul 2026 14:17:13 +0000 (UTC)
Date: Fri, 3 Jul 2026 23:16:58 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: v9fs@lists.linux.dev, Latchesar Ionkov <lucho@ionkov.net>,
	Eric Sandeen <sandeen@redhat.com>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] 9p: fix privport option setting wrong RDMA field
Message-ID: <akfEWuCw8rp_RhzT@codewreck.org>
References: <20260703102254.114446-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703102254.114446-1-sgarzare@redhat.com>

Stefano Garzarella wrote on Fri, Jul 03, 2026 at 12:22:54PM +0200:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> While reviewing a patch adding vsock transport to 9p, I noticed that
> since commit 1f3e4142c0eb ("9p: convert to the new mount API"), the
> Opt_privport case incorrectly sets rdma_opts->port instead of
> rdma_opts->privport, so mounting with the privport option overwrites
> the RDMA port number instead of enabling privileged port usage.
> 
> Fixes: 1f3e4142c0eb ("9p: convert to the new mount API")
> Cc: stable@vger.kernel.org
> Cc: sandeen@redhat.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks, this is obviously correct so picking it up.

-- 
Dominique Martinet | Asmadeus
