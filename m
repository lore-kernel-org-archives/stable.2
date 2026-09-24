Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8554BA1C1;
	Thu, 24 Sep 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272279; cv=none; b=TGeDt4ln00zEyCGD5i6SrsLtI5FHg3fmPoqmT5MX1cTqQjdwDe54fVU0WQDadOh8WnBAXdehxhpiA4qwuMcklLuDYOPe2rT/hO0vDmiHwW1LxjUbtHeeMp+7eW8M9+qs0wH1m80kG14wiZSBo4H5dnx20wQwGKNC64Fw6WT56FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272279; c=relaxed/simple;
	bh=503u+GvE9hLcZA091oZT/2BycLqE4S2w4LymVxhSWCA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I2sZ8aXR7sDDMuhpxvQu/PkvUREvL2vFATLk5RgPLz8jyO5s1AHTKIISyF4wvBmgnz+17qmNCY7Y0Ccm5P8kkG7NjbXZqv9KSdDKsc+2mubHAZ+iHdJ+poQA7HU+5xItPkCllrASBPSokdoQ+WLcuUceFRai6h/ehYFBGMcpVRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6aRw0g/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6aRw0g/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1E01F000FF;
	Thu, 24 Sep 2026 17:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272277;
	bh=f+Qgjsg2d3vNFRxVXjIh+EKgqE+PmxLvlBfZvZKyjyU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j6aRw0g/nW2OVWuTyFeaGn4XvIXVJhRdsT+bCITSDe+vbtmeB+JWBS3omA6bilPdw
	 pwjWh62ItntOWi2MhCEY5C/PPQmsKQeDCQcxjl1A1CPMJ93gqsqDET2Osl649Hplz6
	 /LSx4RHiREYd2veVZ2q0xIxgIs9RxwKcQGlGoCsnrarcRw4GmhqmrMmvfvlwf7c/Pw
	 oPKKljT166VxaOWSMjqCXx0iCo0WHq30PdDd4REndDAiQr2JpWXRgSAk1JeEaAlE6r
	 NJE8jIrMM8eYUHDCnIi+tTsrChl8Ij6a7TBmD0dXpsSyRGoRVwpR0k1MMonmUiOWHL
	 V4zYJiPQTRQ1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C463A566DD;
	Thu, 24 Sep 2026 17:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] af_packet: fix integer overflow in
 prb_calc_retire_blk_tmo()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179027220641.1681135.9631541848557905301.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 17:50:06 +0000
References: <20260923050101.1510064-1-zhangdairui@gmail.com>
In-Reply-To: <20260923050101.1510064-1-zhangdairui@gmail.com>
To: Dairui Zhang <zhangdairui@gmail.com>
Cc: netdev@vger.kernel.org, willemb@google.com, daniel@iogearbox.net,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Sep 2026 13:01:01 +0800 you wrote:
> prb_calc_retire_blk_tmo() computes in 32-bit int arithmetic:
> 
>         mbits = (blk_size_in_bytes * 8) / (1024 * 1024);
> 
> If I'm reading the validation right, tp_block_size is user
> controlled and packet_set_ring() only rejects values that are <= 0
> as int or not page aligned, so a 256MiB block goes right through
> (and alloc_one_pg_vec_page() even has a vzalloc fallback for it).
> 0x10000000 * 8 wraps to INT_MIN, and on a NIC reporting 1 Gbps
> (div == 1) the function ends up returning -2047.
> 
> [...]

Here is the summary with links:
  - [net,v2] af_packet: fix integer overflow in prb_calc_retire_blk_tmo()
    https://git.kernel.org/netdev/net/c/56d82862a0a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


