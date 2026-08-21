Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B97B3921FA
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295826; cv=pass; b=rxnqogZ85uPTCP/wAW0Q3TdEIwt7B4Dyj6fyZ9aZLOOkHoCtOep9f66Dtk/UGVmpqItnYkEWbvVIjz3+38cRDqkE0nd3n494wbIoAs7XEk6QlfI9mn6gtxaVMOASgojL2uOSqCwlRoU9Zgvt0FZ+9KNI1iyB91hw8OlZgek4Gtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295826; c=relaxed/simple;
	bh=xCzho40+G6ZBTizyPF35uFcSIk58EJVZNAHxewqz+V0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XrWL9tUC6x/PXBNQ4OtPG5YlLAzlMsgTgK09beN1jW96O1Z9emVLJZAw/pIf8I5pNvAIKbC4bAjDxCGc69ge9wfc6GXDBDkgm3SgBBCPQyWE8fdGCwKbxEvkg6GO49TeSGW8boAa7V0tIrLbUiSKRAqbvA77YceetIaCMkD1wgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=chGVqWpN; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Q4gYPq3v; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="chGVqWpN";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Q4gYPq3v"
ARC-Seal: i=1; a=rsa-sha256; t=1787295628; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=P0XJ5O9c6hOy1sPPoyvAkZRASzHyBgOPJxWirE8c0VlVBz9cj5QYZNbTB9HMYVGJKn
    OvcwAFT67xXdgWnIDgUovs6NWO8oASPAmJwHKUFZF9p3m1snEB8Bn/Z7tYF0fM9Jnec2
    lbbuw19kj8sGuHegzhBs/+if/IZhkp17HaLqphe/Iaehib/YfYBvZ4xZ5kF7357ZiGmz
    54n17kgMUwJdegIC+9YUmrt7iVT74KMa5H71F26kaJDfx00yDGHv2HEe/XsAS/+HaSlL
    JvIXJRs9gnpg422Uq35Mr6tbM2ZaL4qLbpGqpmw+Iz7l8gEXZmj1+chLOd9kS54ICQuv
    pL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787295628;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gl/5jSnkVoIqX/kALxRvnx4JE5EPN34G10m4wo7sG3k=;
    b=YuOiIvdvMP4TGRSsFzdUukW17DriKuat84beCkIS7efw82aomjfJoZZzc0N+wYQt5z
    VX9QCw+STBEZJJJKCe5M3MLF7SaAT+YS5lUllm6s9ruLkK0VoNdPLFRzmhTDJ5nP0Z6C
    EJZIHoCsLfevZNP7ePKkTRMYzKndDtmuE8jbtzs5ZbPYJLiLeeWQZQPkpYc0yxN0vUUz
    8VYeZbtSOT+yMPLHFVJBnMusaN6/zYJLWJNtWSMlB1e7QQhU/nn3NjDBNCeL5Y8tNdiR
    Du6J9Q2QWy412f07bn7uWGtw55iT1yciaZlBHOcq5TGWb8Z0fF/0j+1WXP6vfmTtnlgm
    vqNA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787295628;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gl/5jSnkVoIqX/kALxRvnx4JE5EPN34G10m4wo7sG3k=;
    b=chGVqWpN7t45MDAVX2NVP+DegPJJ/NSskl7S3ru+gU/9Wn+gV5pIl+MWttLExx3lqh
    0Tz49EhTYKQBnBmO0zhF88thXI2XRKGySgwjdh1aQZpmHTCrvtfD3wCpolLNRaZb5sCe
    G+DJPf3vk/KeAdmTXPZPGNp+YW2ra65H0CGGDXvxkjAH9be/gz63fPvxotBw5AAZBW+R
    FKTh01uUzYw+j/qW+8T4q47FtaqXLBfrI5lua0mSEY3s4IB1cPpm/wx+7CFiMXfbcK7G
    pn5m8uCSLJ2hWJr8sGkAqxd/DUIu7bOmdXDtDsPWNonJBygdNcrBGUgvQ+ggaMIHrUKW
    nieQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787295628;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gl/5jSnkVoIqX/kALxRvnx4JE5EPN34G10m4wo7sG3k=;
    b=Q4gYPq3v97KEvfes6O4ebEiNw9HdCYTSDpl+MCpiy/qX8oApbxEWlyDPBeVkPEOeWC
    Cl1JDBk1O1HpXXPpfHCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727L70RSpH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Aug 2026 09:00:27 +0200 (CEST)
Message-ID: <376bdf5f-0e7f-4330-a3bd-7cffdc3ab857@hartkopp.net>
Date: Fri, 21 Aug 2026 09:00:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18.y] can: isotp: fix timer drain order, wakeup handling
 and tx_gen ordering
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260805125414.30592-1-socketcan@hartkopp.net>
 <20260806021809.0018-sashal@kernel.org>
 <6596e764-a9d8-4557-99e5-585bd680c3ef@hartkopp.net> <anTHCfIquCTzW52G@laps>
 <ccc28652-1d35-48d2-9171-2e3749b38604@hartkopp.net>
Content-Language: en-US
In-Reply-To: <ccc28652-1d35-48d2-9171-2e3749b38604@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sasha,

On 07.08.26 10:05, Oliver Hartkopp wrote:
>> I think that just a 2 patch series would make the most sense. Thanks!
>>
> 
> I just posted the v2 patch series for 6.6.y , 6.12.y and 6.18.y

upstream commit 050f010f920da17c1044a4f174766ad553e770b6 is now 
integrated in 6.6.y , 6.12.y and 6.18.y

But I didn't get a FAIL notice for 5.10.y 5.15.y 6.1.y so far.

Many thanks,
Oliver

