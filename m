Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA53246EF82;
	Mon, 17 Aug 2026 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996016; cv=none; b=VOiE4Eje245hrTPNXL3M0hdQWKIMWMKouKMWWEZxWCwOHh5uXqD4PCxsYEkhWggpGXsmAbsnZRGHsjIQBmqkKUYzyhZ5PcpO9VpR0OZzuq7AryhYtO4kz5VXTPBthiIuxrFF8UKpbINtopH5OrASWx0q8m2RzFjk/PMPf5yJEUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996016; c=relaxed/simple;
	bh=8rNJPOvWQeLSMlRINIAUAZDPECL7vEwSPcEYDpKEVDo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DYvHEAGtRZq1rlH/jjiAHKkRXp3xhJfaKNR74PcIEkx2qTqM50SXZnCLsAovSD0MPkSTeg6jpRn8rrEYTuYp8hcmBxWfCmA3mZ+nibogRNy4AS5/CirlTngHrtDVZ5iYZBCaRIXZOjSMjJEDfnPxuo2uZpNB38zZUFFFQD2qGRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foTs1yhj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foTs1yhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6751F00A3A;
	Mon, 17 Aug 2026 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786996014;
	bh=LTWf/+YwmHFRhCjhh37NBeey88rf7DYi9mDCQWcAItk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=foTs1yhjahbTjHY2OhKe9adS/J3VrGzfDZ5rs1s+/cYkdKFhZfXHZ1GAk4ULs8Zzz
	 WjIHPHhWMQYWX9JzI/7qlgnkR3Y6GhEejjppedjdO19SZ6r3aQtEl7uWapg660609+
	 VW9eUFhV9HF+LveANHl0D+rLcXMannDezWrYnHzTlG/AMi+ZO5iKZnsDxWCenxRlNP
	 QcG0a5Xw6TNlHnfCwM2q+g0tt/A9z4Z7yklq6wp3bl6+kO8ejGXGgqRUZWIhNrOeuu
	 Uhqa45ytlIJAjWY05jX53Vs/cGIxCjvin0Eqthwt06HOlzq2r9nMMGZ11naNUbNq6C
	 kNNR52RnaEMOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08CB3926262;
	Mon, 17 Aug 2026 19:46:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: eir: Fix OOB read in eir_get_service_data()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178699596638.1691257.16551460626446632057.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:46:06 +0000
References: <20260815062419.37489-1-sammiee5311@gmail.com>
In-Reply-To: <20260815062419.37489-1-sammiee5311@gmail.com>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 15 Aug 2026 15:24:19 +0900 you wrote:
> eir_get_service_data() walks the advertising data for a Service Data
> field with a matching UUID.  On a mismatch it advances:
> 
>     eir += dlen;
>     eir_len -= dlen;
> 
> eir_get_data() reports dlen as the field's data length, but the field
> spans dlen + 2 bytes once its length and type bytes count, and more
> when non-Service-Data fields were skipped to reach it.  The pointer
> lands correctly on the next field.  eir_len does not, and the shortfall
> compounds across fields until eir_get_data() reads the length and type
> bytes of a "field" past the end of the buffer.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: eir: Fix OOB read in eir_get_service_data()
    https://git.kernel.org/bluetooth/bluetooth-next/c/14a97a38ba8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


