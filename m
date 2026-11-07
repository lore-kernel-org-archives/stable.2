Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082353;
	b=ztn+jlhFc4OW7DCzEPzb6vnDpqkGSIFELPGJf0trNio1pVN8eKuFHeC00D3b3YLyh3i0
	 /Yls1DZiN682RMIm4Hz9NGhHHd1Z7Osq3xZ/bNz7cPsRbTi7/eW2IuFz+dfJaoA9dFLyb
	 ThQxPM6tZMYR7QdbEHuD5ZjH1o6Cj6nc14TVaJx+mYEa3Crya534Fiwzn5wEr6ee+quVr
	 MVTIk9y+K9xIhiaTk+aZzb3WHWxiaDu2dKCzqS/YXD7KoolO4oxb4FJdQz7BExeXpwiam
	 z8sCFhchEx8VIWQuWmCmDoPVRTHTlm6hL34swev4LPTkSbL5q98pHxZaC2xydrDnasw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082353;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Y9eqk47d/dOu35ERQnyu5l7kxx3O74fBqJydJLDSt6w=;
	b=zuBBVenexuGVrO8cxq6nj83ctXE7v87bc4zhnom639Wzb823zARa4ypcPTdxf990qpjA
	 1Wj08LXnuDHzjSTIGYeHtmfzGYZ/1sKdyKyuAzHuRlz5eYRqHdzBt0Ieod1/cyvLK2I9P
	 vSj2J0fEG+76hB+i9ywFFAQnCtOsoSOm1Gwj9Pa2AH02vLkRxevnOFYhgHew0EL3Ck1Hr
	 TSjFl+QmG4qCdKfa/IoK8mUjDOZMjR2SZ3jsnrYb8cCLe/I6ngS93mj1iGOXuGJar4YtY
	 JB8Psm/dVqEfnXQUseNpgOkrDgSV3Ni3cwsPh866+yCxdg0S2XJY+vMBRRjyI3dUIHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Wqd0/zTK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427C606A326;
	Sat,  7 Nov 2026 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wqd0/zTK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6469E1F0089F;
	Sat,  7 Nov 2026 20:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082352;
	bh=Y9eqk47d/dOu35ERQnyu5l7kxx3O74fBqJydJLDSt6w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Wqd0/zTKYUoFCvQkSEoBRb7UANTN7c1FagJKEpvMCuSQRMDCqt9ne1Gvw8xmYfC7d
	 1z9oi1t7wmTM0LHINLEiqRV5XAzXN2pqqRHlz408uIxwVJLSG5tRTVnnSD4Z9EKsjw
	 5hvw79d6V4TIQ+nZKqoFkx3FTHDeC4EnrerQld0OhSGW+sCLTf0pgVPC3UDD3ueQqJ
	 jJ9wz4wAWRPgBLIl5I9Oso8sUZAeWOTIT1lSFxsgoDsHy+33KxrWTYlMeH8hKS9hKc
	 0TRQ8XRaKibHMiUggN9BRXlvTU6ihqn1pu3cRMi8Hiqbn+ItFKQBXF2Xg1Dwx+hMsn
	 /Q8XlexcTUuCg==
Message-ID: <b87f518d-7f39-49a0-9ddb-25024430d706@kernel.org>
Date: Sat, 7 Nov 2026 21:12:28 +0100
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
Subject: Re: [PATCH] usb: typec: tipd: assign partner identity to persistent
 memory
To: michael.reeves077@gmail.com,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Janne Grunau
 <j@jannau.net>, Hector Martin <marcan@marcan.st>
Cc: Neal Gompa <neal@gompa.dev>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicole Mazzuca <nicole@streganil.no>,
 stable@vger.kernel.org, asahi@lists.linux.dev
References: <20261107-tipd-stack-uaf-fix-v1-1-efcb517924ec@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20261107-tipd-stack-uaf-fix-v1-1-efcb517924ec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/7/26 11:06, Michael Reeves via B4 Relay wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
>
> cd321x_update_work() passes a pointer to a local stack variable
> (&st.partner_identity) to typec_register_partner(). The Type-C core
> caches this pointer, leading to a stack-use-after-free and a kernel
> Oops when accessed later (e.g., via get_pd_product_type()).
>
> Fix this by copying the identity to the heap-allocated cd321x struct
> and passing a pointer to that persistent memory instead. Move up
> the assignment to cd321x->cur_partner_identity, so this works.
>
> Reported-by: Nicole Mazzuca <nicole@streganil.no>
> Closes: https://github.com/AsahiLinux/linux/issues/668
> Fixes: 82432bbfb9e8 ("usb: typec: tipd: Handle mode transitions for CD321x")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>


Thanks,


Sven


