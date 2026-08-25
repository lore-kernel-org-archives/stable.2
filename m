Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD00483BFC
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668240; cv=none; b=iQbI6x6djfuYtpdx2hNfnFA23NlMYni7AiCA4kmPNwfVkO64HgvnbWXHvqmJ52VzewEzxxkkg3l6UY+ivU2l3SRqpDNTguaPfuIUIP5uOA9xode3OzBpeLhq309KD1mRSSpJQj7V4YxqewiHHuxG+Ch2R2kfnWTR8enBifVfXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668240; c=relaxed/simple;
	bh=KFiEypjeanIUDgiziG4rVLWZI3TgNKGrIaOgXdPUDxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+U8avLWEjKKy8MGTr4+o7FxwvnroOev9HQVcJ7QTQYG9v2AcqmEIFfEfucjMDHAcmUqkQ5t8ALueoOemkTxQd7s3iyauNwE80gZoU83GVIBQZ3KZ5OnO5bJE0C7KycwYnGMRjL1x3DW0vuO+esFaVt63lXy0Ky9gEudavCUDWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HS1vF6Fb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HS1vF6Fb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CEF1F000E9;
	Tue, 25 Aug 2026 14:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787668239;
	bh=um8sGt2FicXOOnl+3MYa3kFUGb9YW/Q6a9KHs20TKAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HS1vF6FbYoPyPmkt99PxaKgyF4aepgqEtq2hvv3tiBY9kT+8LTIKO2i9aW/82w+0x
	 Ys8mZjk34eZA+9tK2mJCe57lL3UtYA7D+8wL/2n+IbNT+FZ5tijRVq2PiBu8XIDps5
	 n7FZddZtceSKZEcWW6/uS53h50g1qUhxytgGLxlU=
Date: Tue, 25 Aug 2026 16:30:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Kyle Zeng <kylebot@openai.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 7.1.y] futex/pi: Plug private futex exec() race
Message-ID: <2026082524-colonist-outfit-8682@gregkh>
References: <2026082416-unopened-rectify-cdc8@gregkh>
 <20260825134046.3886617-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825134046.3886617-1-sashal@kernel.org>

On Tue, Aug 25, 2026 at 09:40:46AM -0400, Sasha Levin wrote:
> From: Thomas Gleixner <tglx@kernel.org>
> 
> [ Upstream commit c5f0bc9fd1cec4a00400cc727fcde03e0fde17cc ]

Already queued up :)

