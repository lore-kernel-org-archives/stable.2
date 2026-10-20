Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460868;
	b=qEMD9OznK6A+qOZxu+4MGSmneuan3WROl+UiqKO2XSSuKuoraKo0AKX5kWGZIbNZYH2r
	 AZNX/5hmd837L7BHYCikKaG9wautMSPwlR3WGr7ADENV2UkxeCgoSHZe+7PgXhWXdegO7
	 tqcuqmoj6v6nQ3i7hT5W9G4VISNnpiv1UiR/Yn97a6NMclHqufvXc/N7vMNpLff2wExGb
	 jpUWuyTkE1wEX8kdbR0cUK0aJilBi0P/mhlo5LNFnV512Vn6gs0uXPH5vqsGZnIMit2pX
	 iU0ghcF3TqaQ6MTEvnUPnCcpB5KygFYhGaKPxUIMHU3MTqooIk2hs00uwix9b+HrOWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460868;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lWanfy7FTxrzVuvWb4WcKHFQsIeStvxyoF5WR75KHLo=;
	b=BZZUhfTCiS35cFUIo0ZyCMR4EIMw1CcTfTX90sLlNqZeMcE+mQZ4Q2Q4nEQQ7Z7a9Ehu
	 FUm8t+je10XDmeUDpTuCQFMf235yzFqvh50ZtpoRVaU6VCbOil7JX7Eu/lXvGdC2iBMHB
	 qsv2AwtxQqJIJeq8uO1b9SMmV2ZddCM0dCTeY+IOZ14h+WQm+LOxz5RGxjrjPRxp1WKFW
	 Fu8KJE4MAryMYChyggWIrhFg5/o84sTkWnbD03pjKJbYzvBzx/5mURBz+UDfdQuWhXmIs
	 4Md5oWCowlMBn2/IVwLQmH9CCum/EDLsvAPbxn5fWJM7ccectSxhVEr+5NB8/EAJLJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Yuv/CpyA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A94C4606A31A;
	Tue, 20 Oct 2026 01:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yuv/CpyA
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A2EE51F000C4;
	Tue, 20 Oct 2026 01:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792460867;
	bh=lWanfy7FTxrzVuvWb4WcKHFQsIeStvxyoF5WR75KHLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yuv/CpyAVg4qbogq50443Pu+Yw78o4PnpX71ZyxAoyL9dd63kN5G5CKYE8mNHXb0O
	 WtshbKIt4hozqxeSftxLeExQJI8pNvPypxnsNmDEJDO3BINMcjfnsZKHkrtxVk4xGZ
	 eLQI6czrP2cpim9LKpqTnFogVSiyoXM6ZfiAz2tF5UzkdTyoSZyCpOACJmTB1It7xv
	 sAxChPbCFp7H775nJrd3begbF0rJepqG7nS4ocGPXylnpV5MKezNc6F3XnhE4LH3sF
	 S6VRBZlgC+PM8GxU/x00Lcch2rmAgI29TJNeWn6sO0I/djDgMpk9PD24pT6BocAqk1
	 HZqEwMNRNpOtw==
Date: Tue, 20 Oct 2026 04:47:43 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] KEYS: Reject @desclen values >= KEY_MAX_DESC_SIZE
 in key_alloc()
Message-ID: <atbIP003h_YHofQb@kernel.org>
References: <20261020013903.1244157-1-jarkko@kernel.org>
 <20261020013903.1244157-3-jarkko@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020013903.1244157-3-jarkko@kernel.org>

On Tue, Oct 20, 2026 at 04:38:56AM +0300, Jarkko Sakkinen wrote:
> @desclen in key_alloc() is saved to the 16-bit wide desc_len field in
> struct keyring_index_key.
> 
> Reject @desclen values at or above KEY_MAX_DESC_SIZE with -EINVAL in order
> to match the userspace limit. The constraints inherits from the one byte
> required for the NULL character.
> 
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: f771fde82051 ("keys: Simplify key description management")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

This is now the only one, which does not have keyutils script in the
commit message so in that sense I think these fixes look pretty good.

Br, Jarkko
