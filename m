Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D7C50AC30;
	Wed, 14 Oct 2026 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792006446; cv=none; b=VNGKEImqPKxzA2/nDzze55hTxcMFgTAF9vWvNRyiRV83yE+bVfk4JDNKqNiaujg7/jw5XVvN+BbKR0GgG29Cu7A7iu1uIIT4thf15ntd93SA8MGAv/95khTkI/MLzPio9fcg7szQAh+tw/t+ympR1lmeyp2Y2pLI/Pe2Oi1N7yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792006446; c=relaxed/simple;
	bh=u365My7EWMWONbHhWdqCgSmE1vZGHoxx2R6BZIqU+QY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbW2t229Zt9TCYRngKoVextTDLe6aFjw1UOF11D406zBpKw8RRjTpgwmC8BnKvjwCmM1gSlifc7ztiXiiEC5I36MZ33FhGGyB4+m5fUHrV7ymWNkjN2YjInm7cBBQF+1ypC9vJMt/isDVz3EkF0KBxuZQ2x/2ppqGKIDsGy+KbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8zAoi/y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8zAoi/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCA81F000C4;
	Wed, 14 Oct 2026 19:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792006444;
	bh=g59w5rM5bJ/sQZ1Bw+p2euI/fU3ucCRFbZJFhkU/bQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b8zAoi/ygh0mL6w3BB9Cp2YR1y6JNKUcdPNcHdpVqCJ2TJ8cE0RE5mh1CfgDcBR5a
	 65cjNf+gNEQtIOrM0mSVK4OFsZtn0OFBvRfdHjvS3rJo0Pawb2okLVJUTLOO3w0PM6
	 GAFYuqIp0um8bX5alNu1ZBDKKgNMvbsLNtutbIvpguJ/MLd4Kx7aaT2q+jnutVCO0E
	 FjgCnH5fguQ9NyfChvNk8Qh0YaQgPVglYu25ihFdTd1TzPb2swVwzPqZQrf+dXWChG
	 Wde2ai1F0lCnn2FCGeGPM1QEIlytCL5eDK4p5qzmKRx8bs6oXTJDuvX0LSwh4uf9uj
	 MMzuO6EF1lHmA==
Date: Wed, 14 Oct 2026 09:34:04 -1000
Message-ID: <adebd7c36fe4c6e349aca65bd7820079@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ming Lei <tom.leiming@gmail.com>, axboe@kernel.dk, hare@suse.de,
 sean@ashe.io, neelx@suse.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: dispatch kworker to housekeeping CPU when hctx cpumask is empty
In-Reply-To: <pvnvyzf3cbebpxmobjntvovrruxgnygm7pwgx3tl2jczc7ji5z@ygmd6z4cfxh4>
References: <20261012012905.267920-1-atomlin@atomlin.com>
 <CACVXFVMTr8mORGSVM4JWHrLYgk+9O0J20bjaL_08uYmRCbzC3A@mail.gmail.com>
 <o2hxbjxbkg3wv25lyj3nluwv4e6cb6q5qaukrhjzwg2hodwk5c@wgpc25peito7>
 <asxLLWOQQzolER0a@fedora-laptop>
 <pvnvyzf3cbebpxmobjntvovrruxgnygm7pwgx3tl2jczc7ji5z@ygmd6z4cfxh4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello, Aaron.

On Mon, Oct 12, 2026 at 12:06:25PM -0400, Aaron Tomlin wrote:
> kblockd_workqueue is unique in that it is allocated as WQ_PERCPU to
> preserve per-CPU locality for multi-queue devices.

I haven't followed the earlier discussion, but if CPU locality is important
without requiring hard per-CPU affinity, an unbound workqueue with
non-strict "cpu" (or "smt" for core) affinity scope can provide both:
locality by default with flexibility to migrate when needed.

Thanks.

-- 
tejun
