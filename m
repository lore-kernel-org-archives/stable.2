Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896332;
	b=yI0XF6J7GYqKD0ZKkWeC46HdiPEE7BP5tEpxQ8NizWZ0hUxUFXNKl2KbyfCgHl5otRaV
	 wsjrMfVKDyR5GsDDpxKmU2pWMRy6//alXzDY2Q3L9DlWHl/I5Mwp3phEvjcATkdFKx7hQ
	 mGPECKqZOtU8eh82pBbk5I865EZkOgEiiZqxdQzVYJpAjDyzntqdmNC94rt3fyaKFQZLB
	 KNOjSWWvSaW9qQ2YfYfhPNjQHHyof9USHN0uxyXZ08d+YJ9ASKTI+BNSRbQCv6UlMxhjz
	 NIx+rPF6n+ygvYNO/1BOj91SE32eO5BPJOhYmRnJ7ayCEwNI2MqTkseE8XqswhM2GkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896332;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=s4NWbuvuth328WuI4yRDsUxrAkUoeScZ/xXaa/okTGo=;
	b=oyaWajuJM4UVhe7fgkUlKDdempOBvJFzXz3YMMAKAdizhgmitZ3n7U5EPcTZm8ZfkPVG
	 EnSTeHbeBCQHZ64AA8su5kgraDbDnluTn4jJoGjLta7BSnxov6GddidyaCUgrA1cMOpVQ
	 SNcKaxOPzoIqwDOEAHt7QJHPTMfGzKyDc0LvIX0TB26dWYkFUIPCWXQTiDYQDH4LLZn6M
	 WcGhrj+1FtEEYQyyPm8BGrmknYCBzOeqLLObWOcJze1ooCdkHT79TIcMPw4LT7rBzH2yg
	 bURNV1ZaT+oJhmYdONeq8u7FXpMl6AcLrSkWMCJKJrevJMtycLkikQpU/4r9PJpZKJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ss+SidAd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FC3606A903;
	Thu,  5 Nov 2026 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ss+SidAd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4812F1F00919;
	Thu,  5 Nov 2026 16:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896332;
	bh=s4NWbuvuth328WuI4yRDsUxrAkUoeScZ/xXaa/okTGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ss+SidAd9Ug/IgXRLh8zcNtTp4uGU1wbcjxsOnIdvA77IsvoeiNkVVJt+Dw08tI1E
	 gK5ka5TJzeYUuK8Motq0qGhsAfwiH4c9unVA+oWMHn0EuF9TwqTjaZV1pbHuBqrx8l
	 0ZBYeUFPElB9HMit1Ae1h623UYkPWpIpnyVL5rQ8qV/6lpvr5tJK9QMCtaOTmsR7Ui
	 FueVTyzPHTH23ho0yLG672cy7aVIkoLtAAIEGdiVmGf1POks5zDh8TkF+Zn7FPr9px
	 SxTpkyz3JZYrai8A6DHXO55lPAs2UKDqeN5XY8i4ZARuXJFdc7SQCnOHF9nfnQcw4g
	 XTPg9rXBF/kHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4022F391B173;
	Thu,  5 Nov 2026 16:32:12 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: hci_qca: fix use-after-free in ibs debugfs
 files
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179389633088.103975.11910858924814622408.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 16:32:10 +0000
References: <20261105055645.12917-1-25031212351@stu.xidian.edu.cn>
In-Reply-To: <20261105055645.12917-1-25031212351@stu.xidian.edu.cn>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, ytkim@qca.qualcomm.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  5 Nov 2026 13:56:45 +0800 you wrote:
> qca_debugfs_init() creates an "ibs" directory under hdev->debugfs and
> stores pointers to fields of struct qca_data in the debugfs files.
> qca_close() frees qca_data without removing that directory, while
> hdev->debugfs is only removed when the HCI device is released. The HCI
> device can outlive the driver data, for example when an HCI socket still
> references it, so reading or writing one of the ibs files then
> dereferences freed memory.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_qca: fix use-after-free in ibs debugfs files
    https://git.kernel.org/bluetooth/bluetooth-next/c/eeca795cec6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


