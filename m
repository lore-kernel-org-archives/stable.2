Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114209;
	b=36KQJt8BTI5R3czfiVxKZUF0GVvPGiCvqelW18Q/QXOHto8CNPZG59QM2pxHZ1czUY/0
	 yMkWzebcyK5Nk16uc7tryB5cJZ5AvXP5EFBlK9mJTO71ySawUjD36wEYFeJIkXzIXX9KK
	 Da8wQKdegv0fIaFhz9NhNAEJ5l58tdZDhK1YZtHWd/ZpSyMnujV7wxnMMWLe+f17t7gEd
	 Pu7obDvohKL3h1EpZMQuHotLZupju8gQdU883Tc74uZrck9OtfP4iTHiiVTO22WZERzqz
	 3DXUiKlkaasCP4ecr0Hd5EZ/aFcIhwPJjEovNa7l7J91r+lx4zw/xEvfUvqb7wqWarA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114209;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=OR37dFwRN8krG9Wro/JI0lB2csWUrGFL5eB1dazV5AE=;
	b=4KpVr2G/GtexcfJbI+zqf8kS3BH8w4MrUGbEdJQSE454GFsdh1w4tW3fZCSYp5d0Aj2K
	 CKbt0PcD1gvedH9+sksdq18gWPlKNviYlYgNFBlpxy+TW6eYUFFt70eNiJoeISqj4W3+M
	 5H9PPk8EHMKSdISNA02wwzKae7KjnqGWVqxHr+BzY8FsQz86m6dOeNd1ti7Jb+IRGyVrj
	 +y9NYCWHM+lCbfW6mjfP2cv+IMPBl4y5l9rVn7kdZsj5U/gFKY9jAQ6v3tR8NAttMP+9D
	 BA4PnXl11svjFOkyySn0feR3NRjE4YQKBuSHPyuLGzCE5a/uUi1oHupDlJJwaNdMGJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5ZHhYu7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BED606A336;
	Thu, 19 Nov 2026 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5ZHhYu7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDC71F000C5;
	Thu, 19 Nov 2026 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114208;
	bh=OR37dFwRN8krG9Wro/JI0lB2csWUrGFL5eB1dazV5AE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D5ZHhYu7twlYu0ZRDXpQ3PRVp1YNKsmb4+zoLaJCTnFRJ00rzxil/D82bhgiusNa3
	 Mf1XQ1uPg+LhiOqpz+qQkpkdiJ3DScKd2KmR39srGAbRDQ0E/C2tWwppDsq3CigIal
	 At2i/LRCdmX4dsxJDCbgbMSWrBviOcNY12BBqH/5LtAJcYAASOv7yWmBRUlxRg9FpK
	 qVf2s3FhjC4Z0HcOHf0uHcnQnagWZe6XtO4LM0rd1w3CLNxYlhFWkX8CPJ5Jo5MDCg
	 Ao3tyBIAQyJOb/LPIA3HVyPazi3ZLpbd/swlkhXbj7iIWNYJ1UjH4IzQCapav+ix8Y
	 TBcQf75WS+5Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44843808210;
	Thu, 19 Nov 2026 18:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Bluetooth: btrtl: Fix NULL return on errors in
 btrtl_initialize()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179511420733.3743161.1888737096932815865.git-patchwork-notify@kernel.org>
Date: Thu, 19 Nov 2026 18:50:07 +0000
References: <20261119032415.4010732-1-tzungbi@kernel.org>
In-Reply-To: <20261119032415.4010732-1-tzungbi@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, max.chou@realtek.com,
 linux-bluetooth@vger.kernel.org, tfiga@chromium.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 19 Nov 2026 03:24:13 +0000 you wrote:
> In btrtl_initialize(), the `err_free` error path frees `btrtl_dev` and
> returns `ERR_PTR(ret)`.  Because earlier calls in btrtl_initialize() set
> `ret` to 0 on success, any subsequent failure path that jumps to
> `err_free` without setting `ret` to a negative error code causes
> btrtl_initialize() to return `ERR_PTR(0)` (`NULL`).
> 
> Since the caller btrtl_setup_realtek() only checks `IS_ERR(btrtl_dev)`,
> a `NULL` return bypasses the error check and causes a NULL pointer
> dereference in btrtl_download_firmware().
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: btrtl: Propagate errors if btrtl_vendor_read_reg16() fails
    https://git.kernel.org/bluetooth/bluetooth-next/c/c3cdaaa5cb5b
  - [v2,2/2] Bluetooth: btrtl: Return -ENOMEM if bt_skb_alloc() fails
    https://git.kernel.org/bluetooth/bluetooth-next/c/fc4527d1e1b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


