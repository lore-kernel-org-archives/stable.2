Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F5737A847;
	Mon, 27 Jul 2026 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785194657; cv=none; b=fN99AyCMDx6wRl4wbaM2hvlYhmO7HBoHbd/TdPvi1Pe/UgjoT58eteDVa/84FPadehIfzleaI0LeCtu4AzlI3TjgkSCpBWCaO8eBafvYFJNTfvjC/PBpieFXFoAxwf2BCmpKV0CLyqnRoB4K8A0ZJIC/55SyaCBNXeyAnU3F/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785194657; c=relaxed/simple;
	bh=tXSfV/B6PixeblPbGx6s2fNJmRGT/XWfhNrLEH2t030=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiCskxLMeXoEFNJFNWLZR3MWLfBnrRPw3DfxBd9bDnC+xWixdyt2BE3rvFu8QxCjppiAbXvSIf7vxvog1Vnane4tdI4B9ommSXCxf5Rmzkp6yHTtcJDGDTAU+MMb6L7f+Vs5q/IC8PuhFk8ZFEbYyyboUsIPT0eGCEt+unHADM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwOPwSrl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwOPwSrl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1321F000E9;
	Mon, 27 Jul 2026 23:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785194656;
	bh=sWaV1GLmCuDyza/UC9bJbOWMP5cjBRlpyS8MJdqzhTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kwOPwSrlDwByVQIVzQlxy/a9EhNem8A3Pofa5fhxYBe216e2WfcaGUOIkDCHxbBrL
	 GVCLcTq8Wxoihe4qxacv8O/nFRM8IQWDCJZHpV7B0hEmVK2ddWe7RqoV+rL/7USv3i
	 sm+qrJb7GGloMBWpI2i+Hu4s5Q9skb5O1EvKlz4oetKujqkVtUqf6nSoZXiD+QMWUc
	 0pNIpX425u/C/o2+24MPsBEvubaZA6SA/Cj51b9UyzXR6GcVe2UtOsBbaPLJlRsev4
	 w5UPyUjgDd50eOXOSuO4rUEBh+ShmP207wnw/vKsfFbhpHjywuwHGlRZNH2mjNKsyD
	 jpewCJXNGWLKw==
Date: Mon, 27 Jul 2026 16:24:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 maheshb@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH net v3] net: reduce XMIT_RECURSION_LIMIT under KASAN
Message-ID: <20260727162414.68617fe7@kernel.org>
In-Reply-To: <20260727200454.4048141-1-tristmd@gmail.com>
References: <20260727200454.4048141-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 20:04:54 +0000 Tristan Madani wrote:
> +#ifdef CONFIG_KASAN
> +#define XMIT_RECURSION_LIMIT	3
> +#else
>  #define XMIT_RECURSION_LIMIT	8
> +#endif

At least these tests (maybe more) fail with a limit this low:
  - selftests/net/forwarding/vxlan_symmetric.sh
  - selftests/net/forwarding/vxlan_symmetric_ipv6.sh
  - selftests/net/forwarding/vxlan_asymmetric.sh
  - selftests/net/forwarding/vxlan_asymmetric_ipv6.sh
  - selftests/net/test_bridge_backup_port.sh
  - selftests/net/test_vxlan_mdb.sh

Can in investigate what limit they need and whether their max is good
enough to avoid issues with KASAN?
