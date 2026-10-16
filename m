Received: from mta0.migadu.com (out-101.mta0.migadu.com [91.218.175.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA43382F35
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163958; cv=none; b=Xwt8fIE6gbWh8zx6B1KznQqWA69ZC8WYYX8EZf2Obo/vaQMj2ZMXWom38GSRqkztFEAFUyggThHUI+zY7RzdpAzsLBjuiOHiulqx1AqAMIG+fu+NGdYukh5ZH0ThaEpiGy0GX/ETW0CqFYE5YV+52sg2QTuo9QGEZlAc3oYa8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163958; c=relaxed/simple;
	bh=JgjAGc1yvO+GZR/lMz41Sy+B81/XedX2R7qPQROM1P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOt8tDcy3cPDxhXtRwJuuXjSpxYFpbNeYlKAUxAiW8FELG4GExxfDi7nNOL9/K36FK9bBDjyWEFLwJncI8JGaOakbGz5iqZMu5h1W9K41MNibeQIA+1SyUT3UCnqlOph8eFSo8sk4sEA9DbRX/D8D5+6fSQiL8Q9oB9T4Cd50zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EmSs2cBc; arc=none smtp.client-ip=91.218.175.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EmSs2cBc"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JgjAGc1yvO+GZR/lMz41Sy+B81/XedX2R7qPQROM1P0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792163954; v=1; x=1792768754;
 b=EmSs2cBcB3doNAIjtpdTkto7UMnK2jB3+G1bdN15msWzaKjPK5kl99gpT7nHePSyOk10YEEG
 yqY9ITUenWi29PZ/YdZ3rxVvC6+9Djmdyu5DwPG3jC0jXIPYdURLqks/AEXGvFqCPfM80UWv3Ld
 LsBsfQRVBlBOXiCJN4Lmp0Yo=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8e118369b878a887;
	Fri, 16 Oct 2026 15:19:13 +0000
X-Mizu-Trace-ID: 8e118369b878a887
X-Migadu-Flow: FLOW_OUT
Message-ID: <6d16da53-0917-45cb-a5eb-5b85de5e2fb1@linux.dev>
Date: Fri, 16 Oct 2026 23:19:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next net] netdev: Hide the netdev_priv() origin from
 GCC in netdev_from_priv()
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Brad Spengler <spender@grsecurity.net>,
 PaX Team <pageexec@gmail.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-hardening@vger.kernel.org,
 Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261015165959.i.798-kees@kernel.org>
Content-Language: en-US
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20261015165959.i.798-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/16/2026 1:00 AM, Kees Cook wrote:
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2838,6 +2838,13 @@ static inline void *netdev_priv(const struct net_device *dev)
>    */
>   static inline struct net_device *netdev_from_priv(const void *priv)
>   {
> +	/*
> +	 * When GCC can see that @priv came from netdev_priv(), it can
> +	 * compute an object size of 0 for the net_device and its members,
> +	 * which makes FORTIFY_SOURCE fail valid accesses through the result:
> +	 * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=127875
> +	 */
> +	OPTIMIZER_HIDE_VAR(priv);

If this bug only affects GCC, you may wrap it with a
#ifdef CONFIG_CC_IS_GCC block.

>   	return container_of(priv, struct net_device, priv);
>   }
>   

Kind regards,
