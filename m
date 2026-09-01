Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D78935E926;
	Tue,  1 Sep 2026 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252815; cv=none; b=s+zJNjxWGKtSe/puD+Jjh++Cb5iiPpFo+unHuuYtOWkpDNvddEnxPAc98iEt9y3hCLMdg6UYztrpta/71CimtfMuzzk0WaNkFYB5m2mqr9qSfgbYF782cFkNHftR6QAghEJ23T1DCGT0M0ubS02VdgxAi+HxWGcDBTphrpRE/TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252815; c=relaxed/simple;
	bh=HmHGhENmx1zfzoANCEaUHyFEWFfzElv3LdyoS8aqriM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApG0Lzxp+3Sx5IhI7o+8b9f8jPM7o9D1X5i64ulqV+VZkvLlOw3yhoqp/c+N8wxK9ph8UMzKUi1pSadHNdo5hLxxME2S1RZCrx+5XZOy0wqdfS2XQNhupNeE0P7KtAOzk6sW7eFHFC1F2LUHKEW8usyZI8X7g/ZvlgIROmwlXiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYo+SoMx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYo+SoMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211E91F000E9;
	Tue,  1 Sep 2026 08:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788252813;
	bh=dQJU98biTFI2j0fBN1HFz4j5aySI6T8wL//bYy3tt6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UYo+SoMxASHNScw6bHBQ3pYYAIAYztpH17/qKP90Supd3le3mlnEZuBEMlG8Xmdz7
	 kJkQygAvMgiYmqNXdGUaii8RNtO2sGg3YLqxnfnNyNZxmV+zg2V5IhK5L6+ZJJ4c4N
	 5qbqlHBwRz7u2b70JOXueUMDno3Csoi6HIv2cq4J4Dxvm4jjaP3nj5qsxpeOJsotzk
	 Ro1LJOyiZBwtHyQfArxCVvoMcDUMAbA75mKQPSA7ChvQmzj7KEOmKY9zup9UZZQOkF
	 9b8OmZjm9uLXleIgT7ZeNQWl97X6M4TJKSGCQHY4nEED9qOy40mVajNQ4Ac1qo2B0P
	 I+alpLciXRKHQ==
Message-ID: <7f269572-7dae-4894-b148-56314cd21bbd@kernel.org>
Date: Tue, 1 Sep 2026 10:53:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] thunderbolt: Fix DP tunnel teardown while an async
 DPRX read is running
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>,
 asahi@lists.linux.dev, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260829-b4-tbt-fixes-v3-0-e1fab6ac54fe@kernel.org>
 <20260901081924.GA106095@black.igk.intel.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260901081924.GA106095@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/1/26 10:19, Mika Westerberg wrote:
>> ---
>> Sven Peter (7):
>>        thunderbolt: Hold a router reference for each allocated HopID
>>        thunderbolt: Make the DP tunnel activation callback mandatory
>>        thunderbolt: Fix domain reference leak when DPRX read is canceled
>>        thunderbolt: Don't access a DP tunnel after its DPRX read was canceled
>>        thunderbolt: Mark discovered tunnels as active
>>        thunderbolt: Tear down inactive DP tunnels when the domain is stopped
> Applied 1-6 to thunderbolt.git/fixes, with minor changes in the commit
> messages and the condition in patch 6, thanks! Please check that it is
> okay. My testing at least it works as expected.

Looks good to me, thanks!

>
>>        thunderbolt: Drop the DP tunnel activation callback data
> Since this one is a cleanup, I wonder if you can send it again later when
> the DPRX fixes have landed? I typically base my next branch after -rc1 and
> don't merge fixes/rc's there constantly so preferably after v7.4-rc1 is
> released.

Sure, I can resend it after 7.4-rc1 is out.


Sven


