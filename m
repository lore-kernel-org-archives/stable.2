Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDD239CCF7;
	Wed,  9 Sep 2026 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979267; cv=none; b=oilqYSkE4xrUiuCV0iGaydHBJ/IND0nUgVj29q8exm1VdZHeGYuw/tWkUdK6byN0Yf3Zdx8dS71KYhcYVBkeA659dWtLBpUn6X5+arB/b42o/xZwfjkCOVjcSK2z3IogNaYvqxAL+AR9oRLK9BjoHme3i0vHRR+kAaI1C8w205w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979267; c=relaxed/simple;
	bh=lPbmmiQL1Wm3rLy+SfX3YcgQ6DzZwAIv7N/fsc+XUPs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fWglmUZdrPdNNPm3Zp8RA7m9LuV77hO5ljag+KedHa8iMS2ZXG5qQ2F5skcU4zkUk/yrcNTOilEoqIrrYLZbGF1cm4TOq+o7umDpy2zdF8dHbJebaKFzBztBck7+xqu1asU5dQfAuEPhi/+/+eNMfm8Dyv0TEBTzOHyzP9l3SPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LICO0vvQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LICO0vvQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD26C1F000FF;
	Wed,  9 Sep 2026 18:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788979265;
	bh=V8dVU+QStkxPmY4+TTlQDoS1NgA8d65SxXAtC+WMDbQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LICO0vvQ16k1tULzE6km+NUvjuIkZZFgXRUVn+vU1MF/fetG1+uGL7WN1tsA33PCS
	 RtalXEuCCtXOmb6Un8JK+CSovHyYPr4AGWE/Jq25Y51rVskJlWlaRPcVBxJuRiqIWj
	 EdbqxJXk2gORoaf/2HDK4lVI+KUxSlVmAKbXkL+NvqHGD5rXj2fRfBRtxUu2gdWL/q
	 ZAm9X95sw1GqBQo/r0Ayos3PHgLKOT+pLW99j3ENTOiis7LdHVdRDuqfDSvkhtpEEI
	 1m6y+mvhOXGxBDiiH8pmDV5hJ4hPtyVUZS88YEeU4+waDGBBr2oWH7flV//ZcORmur
	 GdiGX3gyCyGLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1983E380AA52;
	Wed,  9 Sep 2026 18:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: disallow bpf_skb_pull_data() for
 LWT_SEG6LOCAL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178897920389.1001427.18181252445473114035.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 18:40:03 +0000
References: <20260909040807.3885815-2-bestswngs@gmail.com>
In-Reply-To: <20260909040807.3885815-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlebrun@google.com, m.xhonneux@gmail.com, co+adfca3e91be95776@bugs.sh,
 xmei5@asu.edu, alexei.starovoitov@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  9 Sep 2026 12:08:08 +0800 you wrote:
> An LWT_SEG6LOCAL program can invalidate its cached SRH with
> bpf_lwt_seg6_adjust_srh() and then call bpf_skb_pull_data(). The latter
> may reallocate skb->head, leaving the per-CPU SRH pointer dangling.
> Post-program SRH validation then writes through that pointer.
> 
> Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL programs so the verifier
> rejects this unsafe helper combination. Other LWT program types continue
> to expose the helper through lwt_out_func_proto().
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: disallow bpf_skb_pull_data() for LWT_SEG6LOCAL
    https://git.kernel.org/bpf/bpf/c/e4a62833adff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


