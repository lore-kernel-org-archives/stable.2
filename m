Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000C547012A;
	Fri,  7 Aug 2026 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120253; cv=none; b=Tx30MAU0ei5yYYl2H8z8RbIILT4KSqmxfLlVRUmm2YdRpLZ0CkOsjra3A3gF4HxdyQx3Ya8+U69VmHZCZu15hPXtIrmUvgJ9CQz31SHq1mDGqpvkkq9DtUTdoT1/DV0dFLHhmClWijmEaG5QA7Bo+4+0CrqkuBr/lxMybWMVP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120253; c=relaxed/simple;
	bh=rQ9g7WlfTq23NRrsutVgiQvCoPvLQxPLDgKCGGCgT3o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L2ennJcLoZIM+ownfNL0F9ekIMumj3syfLGWWiaAw2grqAShD9hooA8a3u9siGfPh1bwBYb2WCXmQqU0hbbvZ+4PQPMDw8Yarxz6sbjWnn8VayjMwgVkYqThhjv2lPyaZEY/R5hn2gjDC9bbi2SwzFyfLE4Ztvas0vheUpINp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQA4QYqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQA4QYqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4A11F000E9;
	Fri,  7 Aug 2026 16:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786120251;
	bh=C4FQjZYTE//llKVhlhKFfqhrGlATGa8jtNdKQWtWEpA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RQA4QYqszNYnl8R7ruigrx21hZLPF9ZkAzQFnqsMctv4/zr0bM1332VVVQyh/wug5
	 M/O+f1mVEoSLfFk14FfK8f/FTg4GEGsW35OyQVjk7Jh1XRa7IKDivOyr5Z3FFg8TiC
	 8DlOoLQWuMc2XvS1+2PRMeZpnxInKdDLmYZJq3OlXD0Gu0mi7dKLkqKyMVQea44Jt9
	 D9SBKES14YTXsHsKhe6joRhUh3LClEP6C9eXIhCgy/oVjC4VwUxarfQSpO9mS4mA0F
	 dmo9aFaAtGBuNjRB1RSKCWvOuCaPA/byWTifQnOFfryTz6B8w4W0gk5dPZSzi+L6B/
	 gcQXsmIYvttww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93958380CEE3;
	Fri,  7 Aug 2026 16:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: RFCOMM: take rfcomm_mutex for the deferred
 setup
 accept
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178612021013.1887768.3117085684534014518.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 16:30:10 +0000
References: <20260807020345.111346-1-ali@iusegentoo.com>
In-Reply-To: <20260807020345.111346-1-ali@iusegentoo.com>
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Aug 2026 02:03:44 +0000 you wrote:
> rfcomm_sock_recvmsg() completes a deferred setup by calling
> rfcomm_dlc_accept() without holding any RFCOMM lock:
> 
> 	if (test_and_clear_bit(RFCOMM_DEFER_SETUP, &d->flags)) {
> 		rfcomm_dlc_accept(d);
> 		return 0;
> 	}
> 
> [...]

Here is the summary with links:
  - Bluetooth: RFCOMM: take rfcomm_mutex for the deferred setup accept
    https://git.kernel.org/bluetooth/bluetooth-next/c/813afbffcb80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


