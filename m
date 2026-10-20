Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792463106;
	b=b6LLTTYN2GJ0vxITXZL8kZ99PJKMyP6gR0St7mggx0o951yqLELorQwmPpBUOkHQkxg3
	 9gHU8m7DpE8oFYfkgs09cUiKdg2oE5MqYAQzzCkhDPnxHnXlj+KSvRE/HE5lZyYxnK1PT
	 ojAtMxo7oyCWHjqNWQaYDM0JEAZr3oY/7kVV548QLfEOyIWgB4TVUqXzOry9S8vdqGSGq
	 0OuML6xz+j5sM4+oDwy97OZBIoxjoFRM9IidQG4fHD61l5YlPehzHxTqM49VjzxgG2/qR
	 XEF+suY5cCN3cpm4CU+Ith8SAdAGZzz4Z9LQgbvBhKoHsnUkL8R9gTEW/eJQdNKpAVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463106;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kYD02ZXBlrEEySdNfcMyQ0toSOLtwjrwU+Tdgho5Jkg=;
	b=RIPl/kG2/5TV2ue6+cAvVo37ZQ6DxGclOASjp87C1HJwL8ENLvRtOvdVliXYl/KjZFY1
	 yFh7Es8HYMSBzicagO7BYX23afkOqwfMU/jXGOZ+5FXjFl+SSDFvoQnDv/9UGeb33Evyj
	 2yb7nt9VxV74G8Sf6LT7+9Txc5NlTo1qrQc6Fi5yiXh6NhU8asZQQrzjLe74y6p23K7cb
	 TJIy+GrDdhZ3927ue9qFlDv2VxEWfpwaDgHps0PNf176zjfp/45OkwVwqrNK1xDGzN94Q
	 RDIIWbQNq1yqSeC9ietphlsdZV+HMWxPw8k2sPQaBgSWpjjBll71DT2b/zbYT8FOMMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SPfgy3rU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402F606A319;
	Tue, 20 Oct 2026 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SPfgy3rU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E721F000C4;
	Tue, 20 Oct 2026 02:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792463106;
	bh=kYD02ZXBlrEEySdNfcMyQ0toSOLtwjrwU+Tdgho5Jkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SPfgy3rUpMslapQQG1A++l4xkexw+M4TH++6ArexD8P5QxXwn/7eHCfkB2FyrZJrO
	 1Hfib7VStokWwiJYb7rH3KpBMILwfWoFOGjSVMQNEfh681e10ESLp+O3PnWzV0fu7T
	 sxJcybPCyqxZFhepvffia3Rt/rj1dmENSfwh3axtuKlw934tHC/jkI4MQOcmrOlJYy
	 bMII4r8Ddaiq9ntZs93CU8oe8Q3oVmztqswKlUESszqjmmKUvtIuT9Ewxpu2vR2NtX
	 SJHLyOczQ2Py5JTaJq5TRwKysg4bX72vvawXGnd6KPcej90Z7+B2lWWivriTkjfIj+
	 s+yFe8PVU+A+w==
Date: Mon, 19 Oct 2026 19:25:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Jiacheng Xu <stitch@zju.edu.cn>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <jiri@resnulli.us>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net] netdevsim: avoid NULL dereference after failed
 probe
Message-ID: <20261019192505.5e7b1341@kernel.org>
In-Reply-To: <20261015080133.lv4rnnyuontntlkb@DEN-DL-M70577.microsemi.net>
References: <20261012135941.78329-1-stitch@zju.edu.cn>
	<20261015080133.lv4rnnyuontntlkb@DEN-DL-M70577.microsemi.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 10:01:33 +0200 Daniel Machon wrote:
> There might be another approach though. Did you explore nsim_driver.dev_groups?
> Adding nsim_bus_dev_new_port_attr/nsim_bus_dev_del_port_attr there might work,
> and the fix will be simpler. I cant claim to be an expert in this area, but it
> might be wort investigating.

I had a similar feeling, but looks like nsim_bus_dev_numvfs_store()
already checks drvdata :\ Let's stick to this approach, but please
fix the flow to look identical to the check in numvfs_store:

        device_lock(dev);                                                       
        ret = -ENOENT;                                                          
        if (dev_get_drvdata(dev))                                               
                ret = nsim_XXX(nsim_bus_dev, num_vfs);            
        device_unlock(dev);     

Please make sure to include the info requested by the bot in next
version, namely:

- How the issue was discovered, e.g. hit in production, hit during
  development, syzbot report, manual code inspection, LLM or static
  analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.
-- 
pw-bot: cr
