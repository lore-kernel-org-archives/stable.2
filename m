Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399563;
	b=fA23iQq4IQ4Axw3l5o8ZN2Uk1EYeSfQJyUv+f6Ac+0NBq/GVLVanp5OZnLIuI1PAlzDE
	 6tNWXOTT9sTNyPkjtoxEr6hbxCIA3ogR2eeuqL4et+sOQNOxfH6yeP6SBClW7b+1D4TF6
	 D9GWU+f2deKGgTDArfX1enU8F5nvq3ALz7inRpeqGs7KAGUt7ENwlEdppITkROamfks3Y
	 2Qf5WeGo7icIzM/O31lP4lTXvN35wGnoEJMzNkq5Ci5bZTO1pKHGkwSl6YseB1Tlga4J+
	 s5U6zfll4RLXby1PF/jNjTcjRnxgap+qg3LUzXzRPCiUrk2fyOsV+fDt2w445F+XK+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399563;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oydkE5FddDTzcbB4CuqYHGLqNwVoDBp0tkGFYaETDqQ=;
	b=jhj1c342lO5sucPZsVKZ+ozsI8IByiLmFj4iIICZZXC4bTrLM5uAeYX7G6fthYCl1abE
	 XNq3UAwH362HcAzfvLWAJJYx02lHKyJ6tF43vSFDJO+5HkR4el8gJpQ87jBv+B5VAAqsT
	 QtVl+t2jgLatmBW5tgn4tkvhIVsfMoCEFzw510fxml9yNtKvzI7Oj4skzmGoxiLVw0V9o
	 H1P85pqTidOlf9HVh2/wE+JO5kTB1z2+yYSJBgSLNm+y0VW30SNly1UgjSNMbDM8tzyaX
	 GpJcu6LDpPHbkr+bUAxNK25ejzJDj9zAAGL4wec5J4SvGbhIZsTDrWcNS86egSZID7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=y4ikD8Zq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC1606A31C;
	Fri, 30 Oct 2026 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=y4ikD8Zq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E941F0093A;
	Fri, 30 Oct 2026 22:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793399562;
	bh=oydkE5FddDTzcbB4CuqYHGLqNwVoDBp0tkGFYaETDqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=y4ikD8ZqrjtyT0Y7vdSc0SVXlYp6ZeelMjTVNOOqOY/0NK1kLMZvQD85KM+7OS/XD
	 vE011pBrJ+KcNvhwiJujhHD2jaT6V8++X3SbJJHs4HS3nCGbXnG43GWhHkVMpGBB93
	 vIYV6AFSi7xnCIPwgBKVOMWY3ud2hOnJMbQ/o6cI=
Date: Fri, 30 Oct 2026 23:32:40 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Radek Podgorny <radek@podgorny.cz>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: 7.2.y took the on-air address fix without its companion
Message-ID: <2026103011-coeditor-debtless-2d94@gregkh>
References: <179097754519.501890.1801734138080126989@podgorny.cz>
 <2026100356-magnitude-esquire-89fc@gregkh>
 <179337661340.2790793.10493980332574129560@podgorny.cz>
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
In-Reply-To: <179337661340.2790793.10493980332574129560@podgorny.cz>

On Fri, Oct 30, 2026 at 05:10:13PM +0100, Radek Podgorny wrote:
> Hi Greg,
> 
> Sorry for quoting a bluetooth-next hash last time.
> 
> The commit is now in Linus's tree:
> 
>   3889a5fcd091d2154861c19e9c581f9f04aabd0e
>   ("Bluetooth: forget a peer's RPA once it advertises its identity address")
> 
> Please queue it for 7.3.y and 7.2.y. Both already carry the on-air patch
> that needs it, and it applies cleanly to both.

I have no context here, sorry, what is wrong?  If that's a bugfix, why
is it not cc: stable?

confused,

greg k-h
