Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6443C0A1F;
	Mon, 31 Aug 2026 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788219066; cv=none; b=E31eDMxXNalsOdS1/GEFHqftA94/5nAFv9TYVrs4u43EhQWO0O7NJ1UZ+aYpxRCeTtVYv+R0H9DRcBk0oT8o5jOx2gPiTwT0ZlldSK9tkYneRuICOxdasuH3nKMnQI+m/1RV8yMsh+HNIYFp+C8cnHDZIDx3jBTfRVzZXO4hoUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788219066; c=relaxed/simple;
	bh=MuO/HOXm+2GvUf8idm6+4/WH40QkERPtFzIpTGaY9Rc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J+m5RHt4qzG+W+Hz0t7tcUUxav/cj2ac/EkaEiAlLhrBtDe7+VLDdEGS09KEkCysiE9uv1p3BKhR+T1Ipi+dAAx5RhQZA26egNgAUI3H9mT3vbDZhhJ2Od2Q3q5WErCzUkm3epiftZDrOWWTytOlPg6T6liT+AoIqFFrYJHG/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmLdifZu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmLdifZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFAD1F00A3D;
	Mon, 31 Aug 2026 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788219064;
	bh=HRDE5CcFsUaO2hYcHVHMYaePZMARCTkl6/PC/xbppD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TmLdifZug6NP4Z4XOxHHAFynfHKmN+CSgdXYX6twHGQtXwd6DUiv8EcuRiaU8pGHM
	 g1IWh9DgcWld7KGd91JhpQUuIclz3RsUIb/ULNiUrGGKRGM2vJ07aFFaHjtoPBSdV1
	 suOyWHMahOuQxL7nOSGTxjavt8ORcrS6cs7vkFqI3qaAe9O8Zq+hj/tihPlJKl30hB
	 3iivgyVOk3Om2Tx0BoL81ey3LZ+H/eEkDcGNCLt+wCw65k3qm4+AOCtvyPV7rurKtc
	 3FsRREoI+ln8/RarxY+PsZdqLZPlrzE2o1q/L1UyqybhkNs4/LU8H1dKijsX3PsM+g
	 ul1yad1rGUCLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939753924476;
	Mon, 31 Aug 2026 23:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/2] net/sched: cls_u32: fix duplicate handle when
 node
 ID pool is exhausted
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178821900715.831784.1406795274214529731.git-patchwork-notify@kernel.org>
Date: Mon, 31 Aug 2026 23:30:07 +0000
References: <20260825081052.133898-1-jhs@mojatatu.com>
In-Reply-To: <20260825081052.133898-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org, vega@nebusec.ai, victor@mojatatu.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Aug 2026 04:10:51 -0400 you wrote:
> gen_new_kid() falls back to returning max (htid | 0xFFF) when both
> idr_alloc_u32() ranges are full, instead of reporting an error.
> u32_change() trusts that value and inserts a new knode with a handle
> that is already live in the hash table, breaking handle uniqueness
> within the table's node ID space.
> 
> The handle was never reserved in ht->handle_idr, so every later error
> path that does idr_remove(&ht->handle_idr, handle) removes the
> reservation of a different, live knode, which is then reused — one
> failed add compounds into further duplicates.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net/sched: cls_u32: fix duplicate handle when node ID pool is exhausted
    https://git.kernel.org/netdev/net/c/d7e7e98d23f4
  - [net,v3,2/2] selftests: tc-testing: add u32 node ID pool exhaustion test
    https://git.kernel.org/netdev/net/c/7b120a771943

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


