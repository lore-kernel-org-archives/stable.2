Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268869;
	b=qWn8xqUL7a21IpxR0szL2Pfxf7jVG9LX+hAL7ek6FJZTyumnLZT2DKCO+7+2E0eweDUx
	 q4EgZjVx06WyHOy6a16jyu8S1mPsU1WRWg/YFR0db9AaLgjd01XctAe+0wg6MuXAGngzj
	 BMSE50RFLhy1VEHO6Do8j6VsFOKohCXw0rcTE1ey5iOn4DS4mJsxAo+xd+zLdECzRByOF
	 /H8ODhD2hnCOWa6Qh25boaWMJebzciqvTccihxiNuTHLEY55Plc9iV31R5VNFl5XcNvSE
	 TbAqpkTXzh0ax/0JVNZVoz31KePI8fuf6L6vO3J53PtobDyzzfjmQCRhp11Ea7tKA2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268869;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3DfZm/w12ULeMupryJ5ey+oHJ90wNbLMae75m53Le94=;
	b=G/FPaFUhOX36If08sz5JUpOhyVAuajTT1Yd9YY2QZ0YrAmCieVBdGgEeoj6CXXjkWD6a
	 2YjYd0rhbUYMGvYiBPfDsmfaE24TrUOz8I4UqsV2GSpifOSOzkWSGcugJS5T+PR0k+tsc
	 K7+03O7lesi7o//8DFil41yj6Z1VnBzCXpSDc4eldyeEt/No6xUmZEcRhC3MIlnxB3qOG
	 MNg0sPEQVP5LiDoM6wxvOLeBQ3s7pMc2g48pF/EhN+jkdim41xPg56MLUqs8drIDOrpb2
	 4DkBMqP6w/CfIBRHHq3uTwb0grHMrhBjzVtowFov8C00iIKQgqoQSpFK3nkaxLgk5TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FAr0qbl3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48B606A32C;
	Thu, 29 Oct 2026 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FAr0qbl3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2111F031E1;
	Thu, 29 Oct 2026 10:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793268868;
	bh=3DfZm/w12ULeMupryJ5ey+oHJ90wNbLMae75m53Le94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FAr0qbl3Eo4a4LO45fLZBhLWnUbpSdL9YT5QkLBXg3MC6MgkJoml6IqrxpRBkVvOE
	 xeBV7ROlUg5yn57vAdfoY5ZatyiPkHgLjzMoSH+cFwsVlK9S9Vs9AOXoRp695yQj7m
	 ZwZdj36DSTxx3w8btErJ0ttSsK5BHCxOkOlD9EMQ=
Date: Thu, 29 Oct 2026 11:14:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Yingying Tang <yingying.tang@oss.qualcomm.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>, ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavankumar Nandeshwar <pavankumar.nandeshwar@oss.qualcomm.com>,
	Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH 7.3.y] wifi: ath12k: Increase RXDMA buffer ring size for
 default memory profile
Message-ID: <2026102919-confound-remnant-f133@gregkh>
References: <20261029095541.685879-1-shengchao.guo@oss.qualcomm.com>
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
In-Reply-To: <20261029095541.685879-1-shengchao.guo@oss.qualcomm.com>

On Thu, Oct 29, 2026 at 05:55:41PM +0800, Shawn Guo wrote:
> From: Pavankumar Nandeshwar <pavankumar.nandeshwar@oss.qualcomm.com>
> 
> commit 15f7603b69a83a0acc7fcc8992ecbea6110f9424 upstream.
> commit 643f0bf936176c114d5631da7547e991b5d99f10 upstream.

Huh?

