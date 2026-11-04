Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793800511;
	b=mD5lkMvJxf/UMzShTN4kNmj/ti+Eo3jz+FrKQqbLRRMkS2I36G4qhl/cvlLdNzaHRCpv
	 DQFwmHLKIprxRf4SBYPEG1FqjGBBnVKamMfXhrgxXeS8AFh22sgnE1jJRMdRDOsYcw+pK
	 yZ9oBy7voGAZJCZpPwJlgJoFqlU+7Ys6TJKY74xEawsnWaa5o6YO1/ZlF+Ny6fUGF7fvN
	 XwhU3xNmzTkK5OAIA2Ffl7TtyWOqKBrYl9radARrRBeZ5WGKAOdeXMGFAor7anp5YpGfI
	 Fz3F6gCBPQMJ/z/U+X75ZUZcWgL8a6WVo4zmc5rxTsZJjzrSdarK5VQYdf0odnou9Fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800511;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=maDQ2WD6HiiRMLihh/6PlAJLLE5S+DKoSCvfTu9OXko=;
	b=Tl9MEqlLT4b65HHk635OwgyfYFuIL9HXdWbvVwQ2h5CCUXjjWDcRhumhVDSvUIPi2Z3h
	 0OjJTI0ultRePt7yCs2eOzNooFHY6kFdFWEM47JEGysDoWBlemio+TR1lwhhDVVo3FGr9
	 gfpTR/QoKgcPAFxotGNy80NMwI0tpE6EtE6QQI1y2bYm+BQX7qfWuXhcTOCa8TtWL2gZN
	 rdub2Rvia1rtlC8SBhEgOEo40Ctqb60oFqUx4S2EdqNZ5XW5ejL6898hSGdxwvj3GHD1z
	 /6eINxXp/OMl/+r8ipQAnjlmL8nPOpwSn3YK79Ar5sS1n+FE4CDl0qSdFvJX8qJhGsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=fail smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB134606A332
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB134606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6afafc89b48so1060551a12.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 05:55:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793800509; cv=none;
        d=google.com; s=arc-20260327;
        b=OwD95I8Uo9cplxnb9hjxL3P7Xq3GczzIVenO3GEXzEphYWYsnJ66g3TRVaMBa82rnK
         1nB8IGLRoEzrpynNJEUlMqk4e8goC/sm6+z6CswC14NhLUbmnMUYUKXzbXQXBn1q72GP
         4x7lAMI6cPkjrwKFgHrbZalSlK6gDNXRQ184HaxiwzEd5vXKktudM6tTOcEw4kWqoAnl
         COmplxg1vRjgv9oldZ5RgQTGc8YHKa2OucWfQb8jsKuL/mhwc2kte4Kwj4gwKIQXS4i1
         7DnyWTeUupfg2MQCh23UkGUu0oV1DrSadaMcKgj2QJ9JbT0xuygHJIczKVeaMG5TNMKQ
         l72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=maDQ2WD6HiiRMLihh/6PlAJLLE5S+DKoSCvfTu9OXko=;
        fh=h4NKKXGTrsnUPs7/QY21ubjv/6QNZfOlmeHOWbo0FxY=;
        b=hMbs8LYUXRnwOtUC2n/jPTskgfUaFG/XIdskXyzSPWzFU6UxfVrmVxbQQ0OIzXhGan
         pjQc5ycISY/Z+QaWEbxgNUAxUY7Zm158uGja8XB0jZj9JtqCZu5CyJ/HTGxJfLsnlyls
         jXtTktNBUtVBVW3nvcVm8JZUGGO6pd5BgmfWMtuEr4NtyFE+Wwq7+WCd0kkXV/mmty/t
         zAAC7kWPqkpcNrOV+B7wbi74ybzj5x2Ih1d5SbaTQ28vVi0dcAltEaSYanDMJbRTd3Ab
         wamoRz9JQGlqS1a392JHALvoYWpk5NJY3Zg4oI8aNmdoqd3Ivyh5WGZrK4oQ8lGebuZ+
         dXgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793800509; x=1794405309;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=maDQ2WD6HiiRMLihh/6PlAJLLE5S+DKoSCvfTu9OXko=;
        b=daTiT5bYFHzYFgKRWTbioJ8++0h2F7pQvMyJBuoRAdnEIYHMg3O+51So0hVazLpT7a
         UWQltnye1TPb/uSfLIaE0/q+d8REjiv5xGecDBE0/1VE/P1s47/bqAl9obm9tmQBnWQm
         zq6/04hmiOlcPTVa4eL8uqV4HkmisQ9uS2S5Ply9e2I184Tfw3BRG8ZEzMEHAf5fCBoS
         0zc7Oy5lTqZTKb7lpwv9y26y94niwzCRZzkx34M3le5Q6SNxecJypi4tbbw/i/kx8S3B
         FqPoFRapg7I5+NU9+XbuvmS/4Z8dOup1VmuDxY0QzjdaoMHGhLLJfFtWeEPA4BX2QQM/
         G17w==
X-Forwarded-Encrypted: i=1; AKwUvBwUY3U8qmz5OSynsg9O1lPWA0A8vjqajT/hqsWsL5YqxlxcPyYMMXHqGQW8+VeBLEt6+BHRi1g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CH0k+5wKl74kFpUGLXda2Nsusb0FKEDQCXD80psncP2ix83wS
	nKb/bPBcm55r/j8KT/nS/AJlS7uxZsLJ5oMA+Q+SACvvzmflGbfGCMFxZYxib2XZNKwXiBFR2o3
	ojIn/LlnlfziLb7eO72Vd5K6UpMDGOXOIWhGjEHk1og==
X-Gm-Gg: AYBFou31Q54qzBRVvvmKOO4XVHwNZz4lZziSwFm4IXwrjhoE3b6WaoR9vHrFxSnrVtF
	F+yjys5bascQm5d33umt30sI+A5tYIauLKlDGB7AVJfl1zNy+yS1xS2p+s5nj6imFERFVtET1OZ
	C/VYWnOxPMQhC6TeDSNNc1Limoqg2ZpHBtTxRaNqyWvkyZGbQd3pMXjk7M0+LgcIsd7QI4/gePW
	cNzz18O2N3kGk9Ikzmn6yJeDIbtRfyf0OwmQwLYxTDmtjeS6F/cL2kOMnDs0Zi23ZE9qqXkfxL/
	tTNTxgKGjmlBGmoHQsP+cZ2lo9KsmgqlW6SYnKqiUkWd3Kk8e0WOQqN9nFY07gW6CR2c2OvOM5L
	FYLEzMVo7dGQKhGMUgQYJhz47v9ULGgbjJD0=
X-Received: by 2002:a05:6402:1851:b0:6b3:f7f6:649e with SMTP id
 4fb4d7f45d1cf-6b4d438aba8mr8776244a12.7.1793800508173; Wed, 04 Nov 2026
 05:55:08 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020190319.884375-3-opensource@grische.xyz> <179279532326.3134.8925339564776340456@kernel.org>
In-Reply-To: <179279532326.3134.8925339564776340456@kernel.org>
From: opensource@grische.xyz
Date: Wed, 4 Nov 2026 14:54:41 +0100
X-Gm-Features: AclHuK-Y4PhN7UgN6Wg1KVGHuCHUflIixbfP_eRM3Iuwj9ty4dhSxmMFdf4CmYc
Message-ID: <CALsH2cy0Pn2DFAjqb5H2PR6o+_Vr=ig7bbL9-RA82sC99wf50Q@mail.gmail.com>
Subject: Re: [PATCH net 2/3] net: stmmac: dwmac1000: don't discard frames with
 only a checksum error
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, o.rempel@pengutronix.de, 
	stable@vger.kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, aaro.koskinen@nokia.com, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Can this mask let giant frames through when Rx checksum offload is
> disabled?

Yes, in threshold Rx mode. The dangerous case was a giant frame that
spans two buffers, because stmmac_rx() parsed its last descriptor as a
new frame. The same happened without this series for any frame larger
than the Rx buffer.

Commit 834ec9530832 ("net: stmmac: drop split frames on AF_XDP
zero-copy RX") has since fixed that in net, and v2 will be based on it.

>
> Should bit 7 also count as a discard reason unless IPC (hw->rx_csum) is
> enabled?

Bit 7 alone does not identify a giant frame, because on cores with the
advanced timestamp feature it reports a timestamp instead.
With the current code enh_desc_get_rx_status() does not know which core
it runs on, and it has no access to hw->rx_csum.

A giant frame that fits one buffer therefore reaches the stack with a
verified FCS in threshold Rx mode only.

Dropping it would need a new parameter that tells the parser whether
the core has the timestamp feature.
