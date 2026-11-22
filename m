Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795340800;
	b=rovR+o2bKDVSeXDCAbya+Zob+JdT1wSzT0S7IsUjwjtHFT7Tz4jcyMI8az4zgHY9pYhg
	 CS10HYhvbzH49ex7Z9KVeY4/ob0az4rJ82rxtSxEGMTD1Zo+igT7zYfDKVEvTtRuHEXI+
	 eyeCdENe+j6hbhR75gsGs2TyKsOjHfDkhzGOL1zDgwyacY7YWH2nBGEb2JIgtm36FSgee
	 uwRzu257dbip+7WmiscCfDxn0FHmiTMa1g2M47MWhVvQGrcWY1+mVE+88gEoOQqQ6yQZ7
	 ndBUBFbSaNUCE0KuTNAHm3goytHWVNDoz3b+0cxMj7nLQrFN02rYzDRxmtGVopMGR+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340800;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zNlepZ/3IVY+nSsWzAMEuie2JIc2qw3XvEmh3qp2qmM=;
	b=oT/1ZCcUQx2Oz/82Fp0Ppg7pzLLGRSFtdtILXXvMz1aFXlWyotHaNJiIoZEVhrZ3swd5
	 ViaBykHHpMw8iD8x49Z+oNgN5aTiqFlISpQjPaql8nKybJBCrtsSiqIlGXk3ALocMR8DJ
	 g7ffVyfuNk6DrMwBShGEguOMJzTJU3VTxsmwv4LeAYj+UR+PW6RcGiXrbSX1ewxuqQmtJ
	 whwMNs6ZZ605GNrdG8FAukol/6woq+xIOrAHeYayahscfJThPugGLOsiG0r5Efia/d3NK
	 XmrrBJKbqfQpbSyPhNTQeIpJUgIkR3zF8T62MGV+RuehuD4qwCn04pexugH2+XXGl/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=G0VW9tmd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9CE606A320;
	Sun, 22 Nov 2026 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=G0VW9tmd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A5A1F000C4;
	Sun, 22 Nov 2026 09:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795340799;
	bh=zNlepZ/3IVY+nSsWzAMEuie2JIc2qw3XvEmh3qp2qmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G0VW9tmdh2HQBQR0bhBNnaTFWl6YLGz9OIYClIELSHi5+l1NFVL7F1FxbCA9pYNwH
	 uc9aajUwH1QkctMT6mo4Nqbr9P2w4vgaNMNiDPi9xifNjorVoMNgXeJp/c6lPtbxb3
	 HivABL5sUyEFnwzQx6uQ4OT8fsn9XTRfR/k+d7NY=
Date: Sun, 22 Nov 2026 10:46:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Patrick Fischer <admin@tsv-stahl-riesa.de>
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Shardar Shariff Md <smohammed@nvidia.com>,
	Krishna Yarlagadda <kyarlagadda@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] serial: tegra: Fix 32-bit overflows in the clock
 rate adjustment
Message-ID: <2026112227-uphill-footnote-1781@gregkh>
References: <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
 <e3b302d3-979d-4b7e-9b51-dd5c8121c192@tsv-stahl-riesa.de>
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
In-Reply-To: <e3b302d3-979d-4b7e-9b51-dd5c8121c192@tsv-stahl-riesa.de>

On Sun, Nov 22, 2026 at 10:42:34AM +0100, Patrick Fischer wrote:
> Hi Greg,
> 
> gentle ping on this series now that the merge window is over. Both
> patches have Tested-by and Reviewed-by from Svyatoslav and still apply
> cleanly to 7.4-rc3. Please let me know if anything needs to change.

There is no context here :(

