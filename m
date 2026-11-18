Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.56.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988844;
	b=1SqwSpWC0QORSGLHYawL5wIEO0Ltq12pSwBy+jQ+Z0NiP2QIQ/P40JbZ4nxlQViMv8B2
	 LgCo1L5u/79tQAmVCsxLPwOoiDSoq9DEvFhuBpxQRA54qfsVkmdmQGv84toyL61NkriyK
	 mJJ/qTdRh2UHz+Ihk8znTw1XXCXQMZLFO8MFswsvODkWFyBts9cT1zZZa7xmRYr4Y8YT8
	 PVf79enUNQ6+1E0KTUpX46DMs5dn8Fy6Ohi09oUd4LqSV3m4E4cwLfbfH3NT9JXP4G5uM
	 W8JtTg60eURE+ABhQ9gtziw2FGgZ0X1sVZArp6ayV9uEF2pNFt6WhnUfNIbwcBVGFfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988844;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=H65MlX7VDMs/QZf1f9eG5SUm6SNdstMBTp7c2Y28djo=;
	b=zzCSUVhhcCXv7U6pmmJiZkqokF4Zy9cW0KE79f3a96KCP8JrxHvDonXeUvAYIuhIfmAE
	 TapM2rMh2+hCD0SkVzXzx5lDj/whlhvefrG1G9b23WvT6cCwQKsstZk2IQj8SejxZKkXj
	 tAUSudA8P6Flq5tKSZQ+sy7gHqN98kJfKBYpZ7TSKkdRAKcFMfs3dotxbzGoOim1bBTLH
	 yUBLDt1/dzyVYGcXwjeTdDIX/spZft6AUx15j/o76JgKOa54QBX+UODCnKjkm6IIg27tc
	 CRZGCT2a+gIGwe34L9kAmELjJkSF+NhVxEH8aDslHGDmm0eZSjSbSwMfik0oJu2FF/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideco.ru;
	spf=pass smtp.mailfrom=ideco.ru;
	dkim=pass header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=mODEyCM+;
	arc=none smtp.remote-ip=51.250.56.165
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD50606A325;
	Wed, 18 Nov 2026 08:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DD50606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ideco.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideco.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=mODEyCM+
Received: from [169.254.254.254] (localhost [127.0.0.1])
	by smtp.ideco.ru (Postfix) with ESMTP id 0B8B026BC1;
	Wed, 18 Nov 2026 13:00:41 +0500 (+05)
Received: from [192.168.1.75] (5cfcd9fa.dynamic.mv.ru [92.252.217.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.ideco.ru (Postfix) with ESMTPSA id ED0E426BC0;
	Wed, 18 Nov 2026 13:00:38 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru ED0E426BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
	t=1794988840; bh=H65MlX7VDMs/QZf1f9eG5SUm6SNdstMBTp7c2Y28djo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mODEyCM+RnWfkQD3D0L7RPiVM9y17X1jl+AEmaew/5qkbmQPln7heB3W1I9zluFOn
	 OuQqrZ4nNyJ8dLBHHkOQTqZMy4jfQ8HNLgQv7CMCbS7pz3mYcKh7Uhp9f/YJEZ4KBp
	 djCk2Dkt5MsDG7xsVGV/ni8IG8DLTItnx/yHy4wq3ES7VP+Fro9H3Irfx7hKPnQBS+
	 XRZom0Ap2YHRkbdYwIdYROJ5HbBCneb2WWhyJFvGhc9zhzc50QQFmqYMw3u9mgsUiV
	 Rq1pA8q9jJDoAxs3QfPxkBMNbbgkqLvDlfOTd1H+kJoK2w6Ic0MEoJLqxY8UKDVz2I
	 vdP/70pwXmsPQ==
Message-ID: <a77f7b69-89a3-4fe4-8ac7-4f5ac86ba2d4@ideco.ru>
Date: Wed, 18 Nov 2026 12:00:38 +0400
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: Avoid tracing bridge ports after initialization
 failure
To: netdev-bot+sinfo@kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org
References: <20261118074324.1583964-1-a.kazinsky@ideco.ru>
 <179498811103.3291.4517029211414094145@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0JrQsNC30LjQvdGB0LrQuNC5?=
 <a.kazinsky@ideco.ru>
In-Reply-To: <179498811103.3291.4517029211414094145@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

18.11.2026 11:48, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account.
> 
> *IMPORTANT*: If you do repost (for other reasons) - please include
> the relevant info in the cover letter or commit messages.

Hi!
This change was not tested on real hardware.


