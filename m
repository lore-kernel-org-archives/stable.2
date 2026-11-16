Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842729;
	b=gG1hxrRJjpg/OXpmp4CHnUsqHVsbFfj9sZEgvp+MG+9ESuUiSHdGjLwu5kGoH77PowOZ
	 +TpGeLdFEZzS6O6ieErt3mql4+B1ut3DD7NUJ1AV6U6JDIY8Ui127QAv+lQAXgtUFDJ5j
	 g5YFeV1RZARtTJy+4Qh1ew1HzCtlN/V2F8RIf0BbXfJ1ZBVO6FgTFdTTk7tYFWlZBpmDh
	 nNsmk/cR51ob4Q/dRcbuzgG24/MebstC3hHVkAOV41Uy2wM5ft4F/DLy6KmBhLhrWea9Z
	 giscuMvM4i3qN8579DXJg/ZwKKoo+psmZ0OIzMECittk7reJBz3B9s3WnT5EoxONvKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842729;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tBrCJP9dOXojpsN85BTJhtl+ayGDg46qUwwBB1MbyTY=;
	b=U/cjhoQ/vMBVY5KsCjnHDOh7sCKy/u1COB7vjJoL01MytXZpRp1vjmYMkF/P8BknUG//
	 ojRl+GaE1nTmqqv3dYJX6DlfRCZVHabw0xsoQHeocW47VJXvGZnSeHPzo2wQuv2cmWaaJ
	 b6nAI4vMIJKFY7D0s911AEA2eoPd9aMqwxCopltmQjB16lii7lRtL9386ZqaEUwNZQffK
	 db6NzDldHFgbXwubkwmcshXejULpb7QHvD4X0QpuaFmYVS+HMF5Vgebs+YiHOefdAfTub
	 PqHx6oCeadThGw3hR+ndVMg0SpWR6Lj81hkDpBPWGJF/EgC1jXQ7reOzW6XF61TkH5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XBaw/1vN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46D606A323;
	Mon, 16 Nov 2026 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XBaw/1vN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8301F000C8;
	Mon, 16 Nov 2026 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842729;
	bh=tBrCJP9dOXojpsN85BTJhtl+ayGDg46qUwwBB1MbyTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XBaw/1vNGcj/B/XDzkZuv61tm1PCF15ZgmGy9zbfQAGzgrvA3fsNxpmkWDLLDh2Hp
	 GS6nXdDPPxTnBFR3NPl0ugVHqV8eGEAqn6CCphG/UFLQNd4EDFho9AJcbDnB5/Cfq7
	 ns3nIC/dcZtyzIlMHLw3XjnGieUjL1STN3z81fAbdcwZ1/Hvj/0axkq7ysSlR1bdfL
	 txRKKjxoE6Fk2DIBjDaf8VnUhtpQyvPSEKGAq53OqMh42dUqxtzEQVxFRxW8UP1ZPR
	 IwoRDXIvdXzNgZqxzQZV0zJ5M7L0iX9bxxSOa14dXGiSesuvZW4Kq9RBEgcw02KO00
	 +6OEXiLQPnJWg==
Date: Mon, 16 Nov 2026 15:25:25 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, arm-scmi@vger.kernel.org,
	philip.radford@arm.com, Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	"Rafael J. Wysocki" <rafael@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] powercap: arm_scmi: Fix potential stale zones after
 a skipped leaf
Message-ID: <20261116-influential-jackrabbit-of-criticism-c6c24c@sudeepholla>
References: <20261115110546.2344308-1-cristian.marussi@arm.com>
 <20261115110546.2344308-2-cristian.marussi@arm.com>
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
In-Reply-To: <20261115110546.2344308-2-cristian.marussi@arm.com>

On Sun, Nov 15, 2026 at 11:05:44AM +0000, Cristian Marussi wrote:
> From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
> 
> scmi_zones_register() skips leaf zones that cannot be registered, but
> returns the last leaf error when that leaf ends the traversal. Probe
> then fails without unregistering the successfully registered zones,
> whose private data is device-managed.
> 
> Return success after completing the traversal. Keep the existing error
> return and full rollback for a failed non-leaf zone.
> 
> This issue was found by our static analysis tool under development.
> 
> Fixes: 3e767d6850f8 ("powercap: arm_scmi: Remove recursion while parsing zones")
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: stable@vger.kernel.org

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

I may be wrong but sign-off when you repost means you are agreeing with
the change and hence review tag is not needed ?

-- 
Regards,
Sudeep
