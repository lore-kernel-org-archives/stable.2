Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3609E2C0268;
	Sat, 22 Aug 2026 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787431043; cv=none; b=B375a8+nb3j1OS4KBZtIP7w6XUp4kQx/Rul7FGI44xfIXXaztaWbcGr5pojTsh0BKjAZ/kRzrYSkmyIPq/V/ZfXzaOmCKFXgW3fC57SuqtAGRWLJZ96M2jeMNP2+S0D4tVObERFVGQ/CG6cFAkTROKU+A7vvATLB0Jx+23+ddW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787431043; c=relaxed/simple;
	bh=zlDUVsMmOrOYxoGdnBHNhjXPYYdtbU1wVYTyRoyvuyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZouQhfm1DUpqJF5Hjz9TGy/DpgWEHATTzBgO+Z599E98s7ojhsP9wISHklRoz4CAa8W5UpHN0fobYWLfgiK8CmlpuCvxmzaDh+tqXvVf76oXqG0dvIxru/Fafy/2QT5wchMDhvGgoAltSn1bsfJFRay2bP5p2fiSQyxctFPn4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN9JZsED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN9JZsED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563211F000E9;
	Sat, 22 Aug 2026 20:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787431041;
	bh=zlDUVsMmOrOYxoGdnBHNhjXPYYdtbU1wVYTyRoyvuyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QN9JZsEDXgupC6P5xT4AEXuNs0WP2HzAgCVSBgTRsbqO5Svx1NCGCOO0xDO8URVgX
	 C+QoCCn/3/AbcXi4IQ6ytcnFoclF9R7fiu+gUGCO8xjXsL8u/95vkOv0FY43uDmYBV
	 2dZeZ1qcIwVI4MK5U04KdW514PMCjnkpOaqGA/uyXkccg7O3ic/ykivq0yMQKgCPFD
	 X8WjdbaaJzwL3zVPYeYSTQw+ruXZWT7RIPgjHKL+JGp/gEGWBFP0XIQ+VSnzt1xhn1
	 odfMHLH1r5MEhxbjFbwTnCQ5R0cw/DliDQw1DXlq1/wbqUx51+qIG4gvQYFG1AZMQ0
	 8BYGC3v8gXoRA==
Date: Sat, 22 Aug 2026 13:37:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org, vega@nebusec.ai, victor@mojatatu.com,
 takis@issaris.org, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH net] net/sched: account classifier filter allocations to
 memcg
Message-ID: <20260822133720.6651596a@kernel.org>
In-Reply-To: <CAM0EoM=OeG2DUcy9TzUxYWwCr2AAeQbOVz1v21SFtOB02wuM9A@mail.gmail.com>
References: <20260819143733.57538-1-jhs@mojatatu.com>
	<20260822200222.2211875-1-kuba@kernel.org>
	<CAM0EoM=OeG2DUcy9TzUxYWwCr2AAeQbOVz1v21SFtOB02wuM9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 16:24:21 -0400 Jamal Hadi Salim wrote:
> I have a list of follow-up items for this patch - mostly pre-existing
> issues and others pointing to similar patterns identified by the
> sashikos.

roger
