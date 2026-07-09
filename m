Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB443932C;
	Thu,  9 Jul 2026 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783574459; cv=none; b=T8zMcIWJeXULHfxb9RBUKTLOHOt6bvIfSckAUYsLzFBg8xTKf/shraGW/mKgh/0L3/nkH4aKip3Af6sSKy0Vyl6KHyCmAEiNYZN1ERO1foMnQfwEFTUKTLmIrUNkrV/pspBYHAnMTF2jf0NpTfN5/1ear68tcYYI6JrsrkJ04p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783574459; c=relaxed/simple;
	bh=nx6PjUdLWg/xho3R4gEK2VQLIhyL345mxIOtOKgY7cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sl99wX3W/UI6Ety1bWqvrEuGzv56vROgPGdYRaxocAjz/DBIQWPd94FEePYBmyzvvZdo1vG3Ye0P+aVQRx1xEaOiuA77jAU8IF5faHqbHt4Yknlxtszz5GU7UeRWJ3Ctowomu4h1ruHJLiCCvNNKJdWQe20KrNcVthoT6RuvvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHgJYTRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHgJYTRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5FB1F000E9;
	Thu,  9 Jul 2026 05:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783574457;
	bh=WItKFr/Cb3ghbTCZj/vd6l8fpoOlWd/DvPchlacJYks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NHgJYTRe8HE/M007qnmkWa1o3XY1j4pHSzlE3DjFXAevqHPa5QviW4H1ftxPJwuhX
	 FlerENQULC/WlL0nPr2I/Wvje+9rBCXl6iFelr0stYVOwiRMz69+6ZJqi8IExddz+c
	 siuOrFOAaM/ozqsr6IJCejkc/OulxEeMf9hguAp1RaN1Qxbj7X+kJFI2CEK83MBRae
	 2vJUGeoSwY5Fyuwx7xUx13+hkApvf3+H97XZ+sa5c7UP8s4RuMFiif44c0EV74ToBb
	 g4J6Aw1sOZLGBmTQC8WD4z+48EYE9sbbAxrW0U9jIGHUiLNaCwXZnJZ+OJDKua1oS4
	 PuZnpUXX342Xw==
Date: Thu, 9 Jul 2026 07:20:49 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, jeff.hugo@oss.qualcomm.com
Subject: Re: [PATCH v3 4/5] net: qrtr: ns: Limit the total number of nodes
Message-ID: <52mebebmt7tailwyowxwceyqgj54agqdi2vpckq4gro3qkynvr@3gcezc66daxa>
References: <20260409-qrtr-fix-v3-0-00a8a5ff2b51@oss.qualcomm.com>
 <20260409-qrtr-fix-v3-4-00a8a5ff2b51@oss.qualcomm.com>
 <c4cb79ac-1f90-499d-98ed-94ec431d9368@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4cb79ac-1f90-499d-98ed-94ec431d9368@oss.qualcomm.com>

On Wed, Jul 08, 2026 at 06:49:39PM +0100, Youssef Samir wrote:
> 
> 
> On 4/9/2026 6:34 PM, Manivannan Sadhasivam wrote:
> > Currently, the nameserver doesn't limit the number of nodes it handles.
> > This can be an attack vector if a malicious client starts registering
> > random nodes, leading to memory exhaustion.
> > 
> > Hence, limit the maximum number of nodes to 64. Note that, limit of 64 is
> > chosen based on the current platform requirements. If requirement changes
> > in the future, this limit can be increased.
> 
> Hi Mani,
> 
> There are AI200 setups that can reach 384 nodes (192 * (AI200PF + AI200VF)).
> I'm not sure about limiting the number of nodes, but if there's a use-case
> that led to enforcing that limit, could we increase it to something like 512?
> 

Sure. As mentioned in the comment, we can increase the numbers based on the
requirements.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
