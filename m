Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA83B19BB;
	Mon, 15 Jun 2026 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552410; cv=none; b=BytyOg/UJL5JJzWWejbYLQt0LfT7aU3E4egW7kl/iRy4y4oQskn/0JyadzTrR/eOVvVoeS40+o77TxjL5/wECin7XIi9grdusHdBeLlz3FNeAnpjqhXve1fxny5JE5FD0czu+3UMhgdJDktDtXGVT6IELM7BfaEdruLUI8RcZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552410; c=relaxed/simple;
	bh=QHQIWrojcKf9PmJqXpVpbH1+2qdWj54z8wuiLNCL/B4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k+5dGX9kIKrX/mEV38eLhpDRTvXGnh+GGcrObbiW3875f8CJs4VgAWD6x4GXH9xbh+ZJBt5fvLFiVNjv0V134stweARhYYNV4zcY8srx1sXu4O5C7znsRR3yTWq8eAqsjZa3Rl6iNKNletbIIXIfswlTrtZzYvzrSXXcBc9aey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4qwsYlL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4qwsYlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD4E1F000E9;
	Mon, 15 Jun 2026 19:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552409;
	bh=Rq4vR0sNZ5Kh8zd/SvSc5LaUbYo7/21ssgczAWlqxoQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=V4qwsYlLa2h4iHyNF36ermXAlYHQ4d4DiaqKD95glPuCrskr6l/IPoI2GiMpghJX0
	 CmUepZXQEnLn7k3rzJNS4jXpd73kiEF2yObX/tQIt4bddJijcL0v/nolNJ9hES4nMV
	 Wvkvk8Ux0pWpoSqrHsxM/ZsfjMpOgI5W5xBhiWDUhp8KfOGj8g1tapmOdokxyE/Gkn
	 n/mNIBDYYOa7ow2yDN2VDZeUIe4kpEgWYFvTEOtroLCj9JZo53nqU9Jicx6OgIVCee
	 wB6sCCd7THhgsMWs9opcohw5PpaQ8oySTavmKIw5GnlDS5K1oV/hY7KKIPTr3s325h
	 iVmo3cblNi9KQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199153839A06;
	Mon, 15 Jun 2026 19:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: Fix UAF of hci_conn_params in
 add_device_complete
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178155240489.265251.9283382501593618053.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 19:40:04 +0000
References: <20260615150922.1737274-1-sam@bynar.io>
In-Reply-To: <20260615150922.1737274-1-sam@bynar.io>
To: Samuel Page <sam@bynar.io>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Jun 2026 16:09:22 +0100 you wrote:
> add_device_complete() runs from the hci_cmd_sync_work kworker, which
> holds only hci_req_sync_lock and *not* hci_dev_lock.  It calls
> hci_conn_params_lookup() and then dereferences the returned object
> (params->flags) without taking hci_dev_lock:
> 
> 	params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
> 					le_addr_type(cp->addr.type));
> 	...
> 	device_flags_changed(NULL, hdev, &cp->addr.bdaddr,
> 			     cp->addr.type, hdev->conn_flags,
> 			     params ? params->flags : 0);
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: Fix UAF of hci_conn_params in add_device_complete
    https://git.kernel.org/bluetooth/bluetooth-next/c/cb20f6afc25b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


