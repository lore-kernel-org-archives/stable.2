Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE503A9615;
	Thu, 25 Jun 2026 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782353431; cv=none; b=MFrbKj51jPqn9Ml6jsU2WYKoR+AuPGPsrOVlkkJKGM+hysyB5GqwzmpYMXu+ViskdGRaSnuMFzgI/edgiJVESnNuNO4goyKibesia8ZMzaJEzmz4fQKVpICbXOaAsLA3A6CbHPYNKnITczOFwm82V4RA/xW1dVzrZJ071BOBk+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782353431; c=relaxed/simple;
	bh=vUQ+GNW+9GoZ1bBTqXqLJWo/WogleoR97speMN87xOA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=URZAyCRtmHNX80lhfjOmr9XWZnaYjbf7qqWWXej5HzJjL56yhJYG2Fi9gHRcaTISu0E5sTUyeamB2OQUDVa7W7A8N3s3dSpTsHY9XwyNQe+5fPJ9i9ZTaFNqVPi9QuaUGOVLJHzf0xHjdauvH18sMVlOEfmWl3vqYMp9dNnrBdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8bdBche; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8bdBche"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216311F000E9;
	Thu, 25 Jun 2026 02:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782353430;
	bh=UqbZL7BWYZ7QqBCbFrb/Fv38IFOYv3GEAYWURv1o8Eg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m8bdBchek5O+Kf1TkPqzTT273/0iBbBxCgb3YjgsRrAcqicfwK4klrkbu5x0DDoKO
	 IilYPjfemJ3kbC/504m3J7cK6HdEInOfDAiPs13dK16A9k/rIdOecptuY1bDBQrTwu
	 t0xwnkSyXcAWeihMZibnGZjg1rIMb7Amrq+17SuxJqSUj7F4hWX69OMg4FemhCmvct
	 fFywnZriV2cnIlmdhDnxg87ckvL7VHuruVUVFcZ1yo2FCvsLXTBlBqyPfRz0VLPont
	 AoU/VsyOxYF4+L8pIVOM5RGMmuoP3oQ8GNtMIcNbeyOxSafllWreqI0GwmiXNPIPNa
	 q3jv69Ex7NT9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938D63AAA6D4;
	Thu, 25 Jun 2026 02:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re:
 [PATCH net] net: usb: kalmia: bound RX frame length in kalmia_rx_fixup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235341814.3082498.6889909573598271946.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 02:10:18 +0000
References: <178211531778.2216480.12637613349790980750@maoyixie.com>
In-Reply-To: <178211531778.2216480.12637613349790980750@maoyixie.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jun 2026 16:01:57 +0800 you wrote:
> kalmia_rx_fixup() computes usb_packet_length = skb->len - (2 *
> KALMIA_HEADER_LENGTH) as a u16, guarded only by a pre-loop check that
> skb->len is at least KALMIA_HEADER_LENGTH, which is 6. A device can
> deliver a short bulk-IN frame with skb->len in the 6 to 11 range, or
> leave a short trailing remainder on a later loop iteration. Either case
> underflows usb_packet_length to about 65530.
> 
> [...]

Here is the summary with links:
  - [net] net: usb: kalmia: bound RX frame length in kalmia_rx_fixup()
    https://git.kernel.org/netdev/net/c/47b6bcef6e67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


