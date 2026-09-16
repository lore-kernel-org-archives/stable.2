Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAE13C3C11;
	Wed, 16 Sep 2026 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581691; cv=none; b=I2sd63GeIpK/pw4gBFEwxHNQgHEqHP6JRRmG0gKpd1d9YRjmqSCMueaiHP5NTYQzInubde/7GF4W8E7fgICM97e46zISZ9S0LRPMFriZnq+bNkitCUrGMx1GrhAJVcE2SK5PtJYEoH+nvkBbQqOoy1r3PEbSZRWoXyE7Zbi7em4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581691; c=relaxed/simple;
	bh=09Y6NmXOfl+/4OZKcbNE3lImrO2ep5jwmT7KCM4DnX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u8oCyjoYCrhgD1r+UBinjBoYJnDug8QALjuU+p3WWNKQqT6BmkxG2yektqHaf8o5RsK1p0YgGXKvPeopHkqjmv/q8p4saDwQL15EmMaFiR94MWoN4c6zKg0ug3O7UAlawTMMjY7usu6WTgsh+cFzvpoOLQAgSqBY3PRmTxmo3J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh72kNH1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh72kNH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FA31F00898;
	Wed, 16 Sep 2026 18:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789581674;
	bh=bjU2FuqIuDT3+ZN5mr0JJA3Z8a86wq3MGmrj0zkeERM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Dh72kNH1A1ojtJUBruh5E5ICmaHfLWyu4y71S3crBPGOYYhHDGloQAD+3pitiFeGV
	 fwb25qxORjpoIoWT5O4kjzYAI8Z5+hzFk2N9i1vFmu13spuQ5Oa3JxwlzXAdwa5Akn
	 wqrLxTpPMeaZH9aU6w2qkXnxR0OjF7C13/SUppTRnitAaNtS6xoy9HBJ4P3B8BNp9B
	 qFnKDsKOCANXKFfMD9xtMJ9XpT8buYMyUgYWcTdsjnOl5ZbGaspHjbhP3Mz+MnnJFI
	 WU0lmICTWcquEm9VVkqutB0TIx1D7IEKo9RyOyOjYxAMDBTLKwZBWPJ8nmGczuQxzC
	 iqoyzlyC0TJWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D084E39E8A50;
	Wed, 16 Sep 2026 18:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: hci_conn: fix CIS hold ownership on reuse
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178958160838.2777538.9118454215553806207.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 18:00:08 +0000
References: <20260915160430.3108071-1-qwe.aldo@gmail.com>
In-Reply-To: <20260915160430.3108071-1-qwe.aldo@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Sep 2026 13:04:29 -0300 you wrote:
> Commit 69997d50ec57 ("Bluetooth: ISO: handle bound CIS cleanup via
> hci_conn") made hci_bind_cis() and hci_connect_cis() return a
> connection with one hold for the ISO layer.  hci_bind_cis() currently
> takes that hold only after configuring a CIS, so its BT_CONNECTED and
> matching BT_BOUND paths return a bare lookup result.  Its configuration
> failure path can likewise call hci_conn_drop() before taking a hold.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: hci_conn: fix CIS hold ownership on reuse
    https://git.kernel.org/bluetooth/bluetooth-next/c/e06d549fcd4a
  - [2/2] Bluetooth: ISO: release unused CIS holds after channel attach
    https://git.kernel.org/bluetooth/bluetooth-next/c/0fcd4dad555c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


