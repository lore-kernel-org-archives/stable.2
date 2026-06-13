Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3242E8B6B;
	Sat, 13 Jun 2026 22:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388611; cv=none; b=qiF4LoIznQKqXHdW3TyYSL3xC8Z5OUQvtOt7JcwAVUza6oiPOc7gMGLdVqwVbWv1O8Hz3ZqM0Ddm9Kuj89QzGmiZQYEV0pLksx3yKS8enG3lf1lgDC0ErEMLnwvYmAgXBpW2uGNS1UXcv6A2MoDTQDFtn8+zfWuOE/WDNYmI2LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388611; c=relaxed/simple;
	bh=Ty23d+ua1dqkGA4hPjCbufVnZC9y/OdJE12hi2dRnP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KCMxfOqICcqVwx7a1lVFeBLbADHRqeSH4BoaL768DGLdf/Z7uKW6KHsbeKZBoo4xIlFVoA6VBC8flgbp1oF0JEQlSR+XGgueMmSoBvZaBfcLT2+oy+zGrQ5PlSxm7yfoCe4eaWVHcrp9VDfJIsyV1mak7i9ysBAWcOIjeNggsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osZ8SvrQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osZ8SvrQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFB81F000E9;
	Sat, 13 Jun 2026 22:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388610;
	bh=4PTIGDi9ER6F/Yu8r3U5jD2WB/pK85HSolNv8DfWnrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=osZ8SvrQ1ktcypllHLzzxml6/ZuuL3fadszmGsWMeoZtcrdlVpmmdTTYVSHbtX3dl
	 wU7xCH2dhkBkAZq//nHME9Va/P3RCTEv42m2EPq7tf7TBFQOK1mSqtn4z74KGYc6m4
	 AbBRX3rByLIwTJ601PMLVcjrSzCU7VrNsovmOjAjBOfF0oE2h93DlKETPMTw6htabk
	 E+/zMLg1JZ4oaYxhfT2RFnGkwQN80TqMLZ19uqlbuaNd5kIvVCBjA3hdWwbvXelbMC
	 S+i/7a3DJHN1e7zMX3t7EK9QtUtVqMeuopgWXO3mT2KWmfXQIe4Vu/T5kPWmZtIQoi
	 ZMEScEke/SYCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A073A54A32;
	Sat, 13 Jun 2026 22:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: restrict socket queue dumps in enqueue
 tracepoints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178138860672.1607522.16960084358181288406.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 22:10:06 +0000
References: <20260611135647.3666727-1-lixiasong1@huawei.com>
In-Reply-To: <20260611135647.3666727-1-lixiasong1@huawei.com>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: jmaloy@redhat.com, stable@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ying.xue@windriver.com, tuong.t.lien@dektech.com.au, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, weiyongjun1@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 21:56:47 +0800 you wrote:
> tipc_sk_enqueue() runs with sk->sk_lock.slock held while the socket is
> owned by user context. The spinlock protects the backlog queue in this
> path, but it does not serialize against the socket owner consuming or
> purging sk_receive_queue.
> 
> KASAN reported:
> 
> [...]

Here is the summary with links:
  - [net] tipc: restrict socket queue dumps in enqueue tracepoints
    https://git.kernel.org/netdev/net/c/acd7df8d9554

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


