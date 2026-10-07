Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD933938D;
	Wed,  7 Oct 2026 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791334643; cv=none; b=rhlMVROKpJPnwO2usMlegzH6AqNro2hwY6x59KKVm/m7TFT23YjNeXlja+bufY7SIFsGjiyGtUfwnGBa1cp5I0XOPoGb8Yom3lgisf+69owM7XQN+ofSOgD8TCTAtArlgLvDZoeOsaaWg+gc1SE7cI7FPlzTWOUvcP9PiHRAEUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791334643; c=relaxed/simple;
	bh=HDWB0hyZ1Zk6gqprDciwya9P+bNmivD0yB9iLhNH0qk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=teWOw/Boa7GcXiAU+qkmUPtwjyk6+qH2GG7SXCgHn5hyK1fTqRnqORSi4oh02zcGGGdpqdO3h4iQ+Ng3kSFuSc3MPg5se7S7CCE6CFbzmZvI3tOe524yMH9FQ11l4XkRFVZxVcBcjA+EAxTl/bdqDzyK6IHItiy57iyNMTos1JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euZFn3PS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euZFn3PS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC241F0089D;
	Wed,  7 Oct 2026 00:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791334642;
	bh=2WIBQo/MW7LjizXTdEZc1dX3DXoK6JiaS0RgVw9TJ28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=euZFn3PSXj2IEAxL96MAKwh0DZr2qx3a+VByqJ3km4MbH2krW45H+mWQoEP2rdsyK
	 U33xUcV2Qfpb7KNqMUHzz4HLSduN1l+q2tGB30xeRGVNbsj+rhgfmRugJIvpRc0y4T
	 yxdeKkU46I/Holrh0uOL+Iwx7r7X2Mv29dB5Mo4CmxOAHB1pvYfeqYD9IA1U0QM++B
	 kAXbcP0khBtp6jDvwHzjUr+HiYkg+vyGxo7DrVEYzjJJn3cxEZRxXVTNPzZuuU6AxB
	 g6qtC1rxy1LuPToT5AJ8TJJr4FRwV1ijsJLuBr7BGMPSOseZX0j9t4BEPbM0ogtw9A
	 TEM3kTElI8Zkw==
Date: Tue, 6 Oct 2026 17:57:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: netdev@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>, Roger
 Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Keerthy <j-keerthy@ti.com>, Kevin Hao
 <haokexin@gmail.com>, Alexander Sverdlin <alex@sverdlin.org>, Arnd Bergmann
 <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: cpsw: unregister secondary netdev on probe
 failure
Message-ID: <20261006175721.75e77a3b@kernel.org>
In-Reply-To: <2f459154f5bca89a07dc978c834e98198c08c331.1791035789.git.kmehltretter@gmail.com>
References: <cover.1791035789.git.kmehltretter@gmail.com>
	<2f459154f5bca89a07dc978c834e98198c08c331.1791035789.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Oct 2026 16:09:14 +0200 Karl Mehltretter wrote:
> +	bool secondary_registered = false;

the rule of thumb is that error unwind should match the remove()
If not possible match the condition of the code, don't add local vars

Sashiko is right to suggest to fold the two fixes together.
-- 
pw-bot: cr
