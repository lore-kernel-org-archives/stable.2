Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618573;
	b=Em7c4dAladHUDT8KyxvhSX5xBircCP2sPxITlAXFedGGMN6l1JHCjFG0/ikJBcetvyLH
	 vjeTk8I7hJebSrQ60vYpMJ3dK0GTOocvT74ik5ze/xeKH6PMvcY2P2feoJD6F8QRSHj4u
	 8KTTLOvJxHc1fbJHeL34p32Lg/SyjtCikXt1JB0EapJCgKlU474U6PsfooJSRACrv1TPF
	 zZFNf3xGbvAg/MxwNukfdQeJafR2rxJ8IQzKG4qUj/GPlGmdr46l9SvCW5YPZzVFHqaiX
	 bcatzHZCEjcHqNpSc2QX8YX858CxXDKHfM0oyG5+H2PdLhrIfXwIVfZsEBSnLyIOqUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618573;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sd8pgkezC7ZcVn7+Uxgt0n5visYzPF1xvceS5f2PYO4=;
	b=bfu+Djgn2uJYN2La/XJ4nXswO+Zo89Oy/oJBMIIcLsWQwR20fRLLA1ZyD0hXAC4IN+FI
	 vJE+55CNiod9BdvWJrD8Ye69o6gGpnj4ja7o5pPa+pJ+tjBQPi8yzT6MlauooLgAVoDzl
	 a2tJVC9c5yg5BSZJatLL5N+m4OMOiwKBWXmjXq1nf6/PTd9u70lYroFYWe2Cq7Z7cyecE
	 M5ipq8Ttpd7bDihGlCeRRjae8w6kPuaT0cmZdlzQsyisVzGNMM/S+qColyyjuSSZHv91X
	 BnqqPpni3Nt0wk/ShPX4GdGfOXw5IaJBUg/BAzDqvPBqjOwgOpgfE9u/HcmJz9mnSwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pGKosGxF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFB5606A8B3;
	Mon,  2 Nov 2026 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pGKosGxF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783D71F00A1A;
	Mon,  2 Nov 2026 11:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793618572;
	bh=sd8pgkezC7ZcVn7+Uxgt0n5visYzPF1xvceS5f2PYO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pGKosGxFrudNlcbW59RMsHe6tuTJpr4YZQiYTx5tweorjqyly2p/ZHW2n6kn+6tZ9
	 7kOqYfdue7c5u1AI1ZTIUdDzm8Cw6QO4zpQfTBjwlPLNeBFC07SGTCC5A/M+ae5zbG
	 EDZ0RMLAbxmgD7cepYd9aer/eI6+pzaYoGgbZSwc=
Date: Mon, 2 Nov 2026 12:22:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ulf Markwardt <ulf.markwardt@tu-dresden.de>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Infiniband PKEY Regression 6.12.115
Message-ID: <2026110214-property-unaligned-70bb@gregkh>
References: <aaa3241b-4dc7-47da-8703-067ffc4ce252@tu-dresden.de>
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
In-Reply-To: <aaa3241b-4dc7-47da-8703-067ffc4ce252@tu-dresden.de>

On Mon, Nov 02, 2026 at 07:38:39AM +0100, Ulf Markwardt wrote:
> Dear Linux Developers,
> we are running 6.12.x kernels with AlmaLinux 9.8 as OS on some HPC clusters.
> From 6.12.114 to 6.12.115 we experience this regression on a certain host type:
> 
> The InfiniBand P_Key tables do not get populated by the SM (opensm) when
> booting kernel 6.12.115. All IPoIB child interfaces that require a specific P_Key
> (e.g. 0x8001, 0x8002) fail with "P_Key not found". With kernel 6.12.114 the
> P_Key tables get populated and all IPoIB subinterfaces come up at boot time.

Any chance you can run 'git bisect' to find the offending commit?

And always cc: the relevant subsystem developers to please.

thanks,

greg k-h
