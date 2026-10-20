Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496889;
	b=NWRM6Zgh+u8o5Yk7trxmzZD2lpHDOaOyc6SZtNACC51PjMSJpoVgUAOQBy30CdZ1hV6l
	 UC19QeYGIvc53YTNsSBRBxS9GDMpRCFxJ80kWamgx0Q2G3BRnM0LrhU9w8vv4gQF5Gp1s
	 HEh9Y0C/tNN3/MVsY1Exg2UllDba25jwZRb0DcOEgChHMDlUVDeaDHwnxINoWmIsnHZZ5
	 nrXTcGes1f6DOSMFlKhPZIADPRpKZyVGRLgz2Wy0T2VGOBdwl1OS3d9/KYJKUW1hZg3i6
	 HF/szdcOyT/aw5DDnUYHFqpEQAg2CUuxUGNccHTerDVLB6iSFW10/R/aoox46S4rnBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496889;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VFXFbtEQ4MBD/iklYndo4gvm1M1Y96k7ZK7QazWFbYY=;
	b=X9zqvAElGseofUAjSLJEQFUvt/7DcY7xjTC9tvhtKoF5h+Zxfj9ioHDvHqtZ8eq8ve+U
	 Ud850QgqP11CU9EflucXxap/jVv8ORxq0FWQEx6kWePXwUdRlxwOoe7kfghwbcu2lP+hS
	 tqV7b2jC6ndYr9nhxdgpp/Fu3dDCmahKOGlO3z9lQ5ItuNgcVLdBcP+FD+VHWjevDR2+4
	 gYHgAv9o2skxRrLS/RkzG0AmyLorxfNYDbSWnvXzwDHnd/ODqBHdoPpISm98F1B3Tubka
	 SO1EHNLPTEtYpYsUPe5uzgg0gpoS3kzCHCoRxur9z1a6r9AQVzy/oxwz03iHhkDJ3fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SfLg4qiA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1322A606A319;
	Tue, 20 Oct 2026 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SfLg4qiA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1551F000C4;
	Tue, 20 Oct 2026 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792496888;
	bh=VFXFbtEQ4MBD/iklYndo4gvm1M1Y96k7ZK7QazWFbYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SfLg4qiAor4wdFr+2NoQEHW6tvPr7BVO6rB2J/g7qaa0DxRfciesMDnD9tYPK2n6m
	 j1vC4ghQ7b78kq7jkKVElVwnPDmPJ2B3VOTGELW5ukNVeTsTww3AYkitaWBB+3/ynf
	 LaPt1W+mi+V2eF9L9flpklmZ5L57WF8DZ5JL+P8o=
Date: Tue, 20 Oct 2026 13:48:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Martyniuk <alexevgmart@gmail.com>
Cc: co+0ea1ac045375cf05@bugs.sh, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, netdev@vger.kernel.org,
	pabeni@redhat.com, stable@vger.kernel.org, xmei5@asu.edu
Subject: Re: [PATCH 5.10/5.15/6.1/6.6] vlan: require the MAC header to be
 present in __vlan_insert_inner_tag()
Message-ID: <2026102052-rambling-dribble-1e97@gregkh>
References: <2026102010-hazy-clear-1f06@gregkh>
 <20261020080505.279102-1-alexevgmart@gmail.com>
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
In-Reply-To: <20261020080505.279102-1-alexevgmart@gmail.com>

On Tue, Oct 20, 2026 at 11:05:05AM +0300, Alexander Martyniuk wrote:
> >> just a friendly reminder
> >> 
> >
> >Of what?
> >
> >There's no context here...
> 
> Of patch, which is first message in the thread
> 

I see no thread or context here at all.
