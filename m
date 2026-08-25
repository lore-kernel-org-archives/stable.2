Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95743C2BA2;
	Tue, 25 Aug 2026 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645459; cv=none; b=M5q4WSn47Ocj8YDY6ZB7f/YoV41+yLRGU/QLJOPefAQUjdNV8hHabu2bDycDRRgeTjwSC7ft/Ddi9J0CsZM6oylscEJawE8VGYu5IwiqL3+QPkP4b9P321uebXbcvUZsVoBsdG9mWAr4RXTKdx/1PlPRJ6q3e0/1l5C3XJc22fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645459; c=relaxed/simple;
	bh=BJehfVrGyxaZlAsPhdZQ5/4Th9pL/mL5oVnzCq38G8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PX6iaC1QfxuWl5A/YiTTJPzcPQDImq0KKnJfV59I9SFfET6kc7hgGprXMTt3bAxHtxwwfdqVxpZFBrS1ltNwMlVvThLKuVKoDW6R2zWx5yQsB5+UYqxzmxDxHIj+RwB/VFrmPqyVtPnWTJzEQcOx0FElKT0a7xrgy4m5enCG8Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAalOuVR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAalOuVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA131F000E9;
	Tue, 25 Aug 2026 08:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787645458;
	bh=9EkaCa0Vey6aONaNa4chDZemWluQ+iCSUvCz/AlJjvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fAalOuVRlQNdYWi8lRnkl/+O8xdFyKSRsxnYGe2KUqJ8dvfLU+ib0pR4hsenMuu/M
	 2rfyZQUaMkyhmOqeDtQqTw5P08n+7On65uF1ffj0HgxUc1GSAdbb9jetJ4PxeljPDq
	 bki0iBnBtEbYBfruoNc29qYrFTpgwWAF//QPKwBm2c9JaE8Cn9cOnEHvI9jtsaFPmt
	 kT6xNqhIIn1cIvuvHHrWovCCqF4CoSqaHmyoarNmuVJG47TVj/7tc+hSc6H9OQiNXX
	 krbtTYFaq9oodHptlj2Ms0cxZv5rmkqDl+NfCSUhlovBY/FD//XjXbOJnC64Wd29Cc
	 S/cuJPsRbB7Nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A5E3924A68;
	Tue, 25 Aug 2026 08:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] tls: device: fix out-of-bounds write in
 tls_append_frag()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178764540540.3312259.3006660364205789937.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 08:10:05 +0000
References: <20260823084758.20936-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260823084758.20936-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, ilyal@mellanox.com,
 aviadye@mellanox.com, borisp@mellanox.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 23 Aug 2026 16:47:56 +0800 you wrote:
> Found with syzkaller and a local syzbot instance running on top of a
> netdevsim TLS offload emulation; tls_device.c is otherwise only reachable
> on a machine with a NIC that implements the offload.
> 
> tls_push_data() only checks whether the open record still has room for
> another frag at the bottom of its loop, and the MSG_MORE early break
> skips that check.  The record survives to the next syscall with the frag
> count it already had, and tls_append_frag() does not check either, so
> with TLS_TX_ZEROCOPY_RO every splice(SPLICE_F_MORE) of a byte or two adds
> a non-coalescing pipe page and num_frags walks off the end of
> tls_record_info.frags[MAX_SKB_FRAGS].  Once the record is pushed,
> tls_push_record() runs the same index over sg_tx_data[MAX_SKB_FRAGS] and
> the sg_set_page() writes land on the destruct_work that follows it, which
> the workqueue then calls.
> 
> [...]

Here is the summary with links:
  - [net,v1] tls: device: fix out-of-bounds write in tls_append_frag()
    https://git.kernel.org/netdev/net/c/b17cf742eaad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


