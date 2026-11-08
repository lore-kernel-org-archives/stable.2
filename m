Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794150223;
	b=tw35ckS4tk0gH3p7DBgbiMOdUUDvtzjFDIuICq46n4c+4y35U5hzlJTLVzsBLxLENcxO
	 sFEZnn2J/9okRb7DjdrCu852JUUAI1kmjiTYCFwI2RgF8o53jLZJf7vlnPwhQZumiBEY3
	 WZ3Cfi/0yjV4zmHr6/OIGg/8khaOZ8UoqLCBfDhXtMlo0unqwbM2vZTzQZhdCOWJ3sbHi
	 5RoNy4qQCqMtxKdJ3O5447RtD1DcXMylF65JyNokgFTOZP/6S+8y5prYVpgf2OIemiAzN
	 yqaoSN1YC2zgThS/eVYJU8Y+u/S6yX4yjlDO2a3HgJncvkbYG+rgTOZ3WenyozlF+Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150223;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=QbYiVhTzlQpnBAy6zKPAAIvl7xIK7BIFFyDILWvOq84=;
	b=W8cGnrWEDW22zttCC/cptDysr8vqE0Mg3Z8FblOI/wG8q9JA3sYfQiHzmMeFD5mtk2rP
	 QGEdZtjUBA87rPB3ED756LWqppBfrS5F11Ygtps3DjGWuyDqkq0YR/MeEn7fQVGVptDZL
	 NJz8+rfFuWEziTvpyEa5J+pDamEIDfXNJcpE/nWI+6oMbwrQ3QRSFo33DDEYPdLRRLZ0k
	 r0iCMG3ggiWh2bQARixngC5980wVW8a9VdJdA6z9UECYXx013M4RZ7gleAELYRQwVKtO/
	 vUTHIUBFPZHIwsSOhBlY7S/EQ1CoFeKlEf9vtnXbWZp3FmFfbiQ+4J58Ftj52GyI07A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCsa70S1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C5606A31C;
	Sun,  8 Nov 2026 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCsa70S1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0751F0089F;
	Sun,  8 Nov 2026 15:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794150222;
	bh=QbYiVhTzlQpnBAy6zKPAAIvl7xIK7BIFFyDILWvOq84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HCsa70S1BZqJdmjyXob9EUXbfT32P5XkVIMtxLhAJLUpjKsjQUrUY5k1ASCZC+gzf
	 j1bWcrKR2PZqf1vL40czsp2nwov2rDgxpO2To8dhaD8dn73l/A7FAkrbttcKy9d2yB
	 SpUzbMVmIpO+uRrBm7g9XvoCfbjwxpqrF06FURysNnnKGSya4CSI8Q/qW9wYqrzVA8
	 lCNlLFIvUYwlYGYdrAJ+SV1MsBFjIZn1fR759BfQ99VS3RrDAA55GCU5wTEeQ4zZRx
	 WVgHtqCFQIgK//ZJdwA+nsC1PxiwlE3XOUCFqGj0X73nwDATogJd4ImRxywEwTsXZI
	 kiM/wCADE2/5Q==
Date: Sun, 8 Nov 2026 15:03:39 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: =?utf-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>,
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: qualcomm: rmnet: fix TX aggregation teardown
 race
Message-ID: <20261108150339.GC18859@horms.kernel.org>
References: <20261101233427.2050688-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <179357635158.3286.10001576876397197758@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179357635158.3286.10001576876397197758@kernel.org>

On Sun, Nov 01, 2026 at 11:39:11PM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi Jérémy,

As per similar requests for other patches, I would appreciate it if you
could take a moment to respond to the questions posed by the bot above.
