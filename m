Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4F37881F;
	Wed, 22 Jul 2026 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731728; cv=none; b=Ldxr4/xa8MI7vLJx6aHnw2Zqsf6BmU2sarAAgVnaBuwh8Ky7wmOFu0ZOkrwEGAKMF4g4Y2o0rJrFov86eTKzNi+kKyuQHevJw1sj1VB4FxPZqNELQxChkCBEb8o/5m7B5xv8tJa2XFrmVy6aTYfDU8DP/d9aj2NW0Hk56yha+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731728; c=relaxed/simple;
	bh=dfgQxcF26A+u7BUNOweO93RY6+J3A6H3g34p49DmZQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDeKeGO4BOz/aTLgQzE1w6bUmsgOtqKQmJw1D51fGnj2S0JdCvqyQixos4LB5ECjb0kF1udWKh1MFqkz59uwComEj49Dt+1ZLQ5tcVWs1ypQzXL2KFYy25iJzZoUqmuokHx9B8pIDdOJM+kNhoqT4XpBIROClTiX9USavC32S6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCD8Vm0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCD8Vm0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99DF1F00ADE;
	Wed, 22 Jul 2026 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731727;
	bh=6F2ZR1aQosy5Iq6JUlHAxXjgL1kPRnucYF8OOuqzH1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PCD8Vm0VHwfNRFR68A+0+K+OCnHMqWvW+Buqvh/ckMMgKnB+N+fEZOcNwHNyw3AkX
	 SHUhQUxuacaUaTr089wEho4AYNl+Wlh2eNRag1LUjmSeY5E97bowAaTiDA80s7cHWQ
	 510O9YyBrBGvlLivhMFwUNc/yrcYz26sJOfFei1YzYPXVjsyR2d29E+BF8pvicqg5Y
	 Z6+pshoFlAvQTqbjDAdmzHZ9cvzvzi1VmRMcPryVDccLAD/qUmCtounJzeW96ajNDH
	 x4P0STDQBTja/b/Z4YomBENGNppYk7O5HJbWG1mJteo0TkCCJmTWH9HoNF61blqx/0
	 xopmqE6+lNS2A==
Date: Wed, 22 Jul 2026 07:48:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, shenjian15@huawei.com, salil.mehta@huawei.com,
 dingtianhong@huawei.com, przemyslaw.kitszel@intel.com, horms@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: hip04: fix tx coalesce timer and IRQ
 teardown races
Message-ID: <20260722074846.78587ed4@kernel.org>
In-Reply-To: <20260711052922.1634837-1-fanwu01@zju.edu.cn>
References: <20260711052922.1634837-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jul 2026 05:29:22 +0000 Fan Wu wrote:
> This issue was found by an in-house static analysis tool.

Do you have the HW and were you able to test this patch?
If yes please add this to the commit message.
If no please leave this driver alone, it's old.
-- 
pw-bot: cr
