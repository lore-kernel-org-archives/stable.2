Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830C472540;
	Mon, 28 Sep 2026 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590364; cv=none; b=u7OistxZUtnFNuR9UdpPgM0uxlmqeePo2ic23jCCX+rnb8iIM69iCvfOYj9QVrWBVpf5CoLwW2WiP9H5xRb+u/vHV3DgxnFVgOBmn30HDILlHxFSmBOkdU60Z0njmICL5koCQeANTbMpfKXAvdf1w7WKvJVRwWPx6mhCV/EnVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590364; c=relaxed/simple;
	bh=ForAMpRmjYQhGKOZvVTN4ev/F2ykpldgWDOHrL9zlI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpSerjbTeUWZRjMXBT3wiU3TJCf+JyIw2ksDuaHC6HgLOVvRlx5bzZiWdCD+9tWfofXT9IuAux826dquLsdBFtaywwylaSQ7H1DYU29kt6aEcF/fs3EKXnjmJFSi/0qrSaIVOYBXDzRm7ilPX6adS4xr2PcgKm6fjw2DIAnFRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M3xm3ltD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oHUjsiJo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M3xm3ltD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oHUjsiJo"
Date: Mon, 28 Sep 2026 12:12:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790590360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0dEtTlutFaT0vfpjjH0sO8tCDudniPGBkapiiGSjLTE=;
	b=M3xm3ltDGN8lCyamcTSWCo8p85V7XN1MgBkJIcxl2ymrfO7JBTb+P+gLyRIRSxmRM4/0f7
	NjHSpFxIncMNpt8VjU275oYJRXeLylAob+zhcd67pXPqsDZheaZkbSWhuTju/LltQZZyXH
	AYHJO2nX+NrYQvHoWn0n/Y3FfQGN0Iu+PCpZOTWnIL6hfB8zpiowM1/TVWDmE/EeEQ1Xi6
	8tWa5XO4oVzecUfIlwsH9Rbwr6GQfiKMEp+3uWiK95Hn0oWNshWYdgiwEcqIX43vKQY3tJ
	N/Qz+g40l+qLcMmTA6o7+s5k/NF8hM0DbLIK3eefk3oS+vr6kXt70hhP57pyXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790590360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0dEtTlutFaT0vfpjjH0sO8tCDudniPGBkapiiGSjLTE=;
	b=oHUjsiJoVrCEyTE11shUkEMw8xoyzk9YjbgiMqvTdjwb4kQBpZ1H+/xwIogyZdiHNtXa1d
	8Pq267EDe/sJagDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com,
	skhawaja@google.com, liuhangbin@gmail.com, stable@vger.kernel.org,
	sdf.kernel@gmail.com
Subject: Re: [PATCH 3/4] net: hsr: unfold GSO super-packets at the forward
 entry
Message-ID: <20260928101238.NpVQ1n8V@linutronix.de>
References: <20260809121455.1745-1-xiexinet@gmail.com>
 <20260809121455.1745-4-xiexinet@gmail.com>
 <20260923104346.ur63K3h2@linutronix.de>
 <2cf54664-c07d-471f-af6d-4b70e09626b4@gmail.com>
 <20260925082954.MYDugnDU@linutronix.de>
 <21bfa8a9-c488-49aa-b2a1-4d282fd51c42@gmail.com>
 <20260928063824.0E3LO1vu@linutronix.de>
 <52f4d7a6-6bbe-41fb-863c-5c71644e20d4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52f4d7a6-6bbe-41fb-863c-5c71644e20d4@gmail.com>

On 2026-09-28 11:42:01 [+0200], Xin Xie wrote:
> > This does not sound like it is limited to hsr. I think it deserves a
> > helper similar to skb_linearize().
> 
> Patch 3 already uses the common __skb_gso_segment() helper, then
> passes each segment through normal HSR/PRP forwarding. Do you mean
> a new common wrapper around this helper?

I must have missed this part. It is okay then.

Sebastian
