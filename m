Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD256401A2C
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662080; cv=none; b=ViWOT+DKcDfA1GSUjQQRjJDtbb1/MLacyIenu1buGO9NyxgFSo5U90A7Sar8/l/pyVdi40x/rnELPpVSoVnMh582x0Bci1nWt7icqAMMrt/rnFTZ6tZ+cRSGwr/0+HUXS6lNPJ8+H3cPLeu2a2Zy/ySHKBUMFiTjfwPJ7khhItU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662080; c=relaxed/simple;
	bh=lrKF/axBEaMNGhJLERuYC1CFIAf2zPCxPnmm5b8iAx4=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=jIXSzsL+T7ykt4vpYU+ZPnlrgY0Gn0BOsKSTVSODQEiM1dlQMWIbG278kqGS58h/6WjkoTfQGtZHRedS5XiQSMgH1fUIZnX9fD54NsvblcqZKM/wn9geMHx6jK6oE8saHL69zsAwGLjQN7ppHWU/05E9re6IudGEgEpEviPk1wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntVC0r75; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntVC0r75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001AF1F000E9;
	Tue, 25 Aug 2026 12:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787662075;
	bh=tgaz0KYYPXQR/NUnH5Mk6QuSnX1ZrcsGHh5E/3Mbzi0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ntVC0r75DkNNRQXd75xY0nw7JnqgMMzaj6WUFVaApAmVvZQj8TV5thakp/T5c4QXH
	 Ts6gtECzr2NCLTNr3UZ/awLd2Zk3zeiouVSd0rjVQIh3gqF48EWK3fK3L0BoIXB2QO
	 /gV6uY4ui8oHCq24TubajOtRWgiPvWybokp934HK1/Gu8hHcvCXDOdUsudmHVdgrr9
	 ipBFwht8cTeZZS8ZWUB1sBFlSGVs/d8w3V7j5vdOW1mP7edw+9iBKaLY5MQ4ohyBv7
	 8KaRgLtKU+extFMYvqRXfnwRDbUBZCcUmOHbhbnKzXH56NwADvJdesPxeArk34iI2J
	 FJ/PKIwe9bbog==
Date: Tue, 25 Aug 2026 14:47:52 +0200
Message-ID: <20260825091033.136528074@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
 peterz@infradead.org
In-Reply-To: <2026082450-shoplift-anew-8412@gregkh>
References: <2026082450-shoplift-anew-8412@gregkh>
Subject: [patch 6.18.y 0/5] futex: Stable backports for recent issues
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Greg!

The following series is the aggregate of the futex fixes which hit Linus
tree over the weekend:

d8aa5dd97944 ("futex: Fix might_sleep() warning in futex_pivot_pending()")
bde023808364 ("futex: Fix race on the initial mm->futex.phash.ref allocation")
c5f0bc9fd1ce ("futex/pi: Plug private futex exec() race")
f9ece060cc43 ("futex: Sanitize and document task_struct::futex::state transitions")
59b3732f95dd ("futex/pi: Reject cross-mm private futex owners")

Thanks,

	tglx


