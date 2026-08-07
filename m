Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037B04766BC;
	Fri,  7 Aug 2026 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120261; cv=none; b=KCOTQX4H9tjYNSQGn6lT00ex/BsSIIWY/T57bsetyLJNn7B2kG7BZCyVb3eyJaGfzu9PlOWU636Rpx4Cx2inYs0vxsIvMeKGYNHfUdfGOykmQGAKSsmLi17lo0FldBJKw7WBsAFjzXvEhxefOr3SOJfK/hnhuRqmc7gsuLkR5ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120261; c=relaxed/simple;
	bh=W7HQChqgF1qKPf267EpHLh4sSUAMpBfS8bLjXFDxtqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=meUTQqhPQytjNCUtHGcRv7+jijs/sObDcbMlHXUHStRw7l/F70n44hhQs/1kYxuol9MXG/aB3KvnTg/CX+R+KbrKLn8s1zUQC5nCY8bDTVcukYkXSlct6/0waW1vcGz0qJzPtRAMfMWq+K/50XAAZSucOivlmgd1sGI6ZbvKKwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvoElGia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvoElGia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDDA1F000E9;
	Fri,  7 Aug 2026 16:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786120259;
	bh=sCb2npqohnwotgkytokhn3wGg84IRkW72ZlNvoJ+vdA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XvoElGiaTK9V4mrc7aGyUwpIavgqz7Fv34FyYqgzqWC7XjZDnmmycbsU8m/RdK+bi
	 PX77+2W4zrosFfa3KpbL7rrG8AQle4prLc3Sz4veW4MkuA0RcZQprvfYPAbXzaAat3
	 q5oFKbwpBIxcxpxtGkMe3E2V98tTqymkc44x/1ADYebxncQq5YWScifht3XDTMiT/Q
	 XBDq+FOz4qg4OESBkqJH+bhcP5d8VHpLWaHjxdoujCBX9KQpo1ornoHSvSq2J1tRN9
	 SsiU0/ecGdF6gZ81/0htUfRVF/hkV3ZEDK8TQ3GbsfOYLOKh5evAvJ7swuN+NZvsLd
	 QvoXjbwMJUxAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56831380CEE3;
	Fri,  7 Aug 2026 16:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: ISO: zero the sockaddr before returning it in
 getname
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178612021790.1887768.1776053981475041255.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 16:30:17 +0000
References: <20260806230621.10105-1-ali@iusegentoo.com>
In-Reply-To: <20260806230621.10105-1-ali@iusegentoo.com>
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, pav@iki.fi,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  6 Aug 2026 23:06:21 +0000 you wrote:
> iso_sock_getname() fills a struct sockaddr_iso in place and returns its
> size without clearing it first, so bytes it does not write are copied to
> user space from the kernel stack. The getsockname(2) and getpeername(2)
> paths both run through do_getsockname(), which hands getname() an
> uninitialized sockaddr_storage on the stack and copies back up to the
> number of bytes getname() returns, so the driver has to initialize every
> byte it accounts for.
> 
> [...]

Here is the summary with links:
  - Bluetooth: ISO: zero the sockaddr before returning it in getname
    https://git.kernel.org/bluetooth/bluetooth-next/c/e25de80035a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


