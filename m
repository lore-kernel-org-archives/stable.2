Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6152383C80;
	Mon, 24 Aug 2026 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596590; cv=none; b=pLyk6ozQ64g2FfR+MZaq04IQFHAEY24g1CmfrWhND8L6iVjY4CYk7lHU8UiX1wBEoJoaPZOvKoAJW1uDaMc9Q5YCaZLTGEx7Dq/bFluxpHzT4ftlyH6jBlDLoTOF3PvWR42mdZCuplAyV6SaPHnXcGsHk7H5XbH5nrcuByGkqY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596590; c=relaxed/simple;
	bh=2tyftcnhEb2mV2efXrDh31ZS7kFCngKhgxCXE6+Ub/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wvtz3eXOAWgAWA4WZJ4T+JYPapIf+NMmZz8ZmvhcciRLxeeh6w2k/+NHYJeiCPoMuTEonNL/nvVWjOoff/C6a7pHTX1Ew5xgNWlKV8FdamHkVqTxMcanHQvu1iczSkED7nIRUkGmUF1sB0J92v+rsPnmmTWy9/cgvMxVFk6rOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAEn0KgK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAEn0KgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B89C1F000E9;
	Mon, 24 Aug 2026 18:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787596589;
	bh=ntOcTimqKtYtTUZPJ6AOjTNeOvXsVzvPFZ4zm5DDbJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EAEn0KgKfnfNqKmaBB3OCC+ptlNP5o45oHW2TM6ipqgPNIUzlFHiHus3uyN70t+Yy
	 clyNcwDQg8iSFaTZBoFTPDQB+T28Qx86N2Wq2n3DRoeTSBljUkc+s96TPuKXBwP3b2
	 G6gbRERM3VBLIxf8f+3ZbpHCYZaKFv5hno3BKaox2/KLfnatZAHZOqn3lJ9UM0KWra
	 AJtX+LlgupFemLQ4A09uT1odR395HqalCH2ZSHBAELkfowkHigHrlHBRPEiraYks45
	 BuTmbVv/eNAoBTlDcnNFZM+VMIEc4iHpPidCJ5oLXElbxDktZKiS6Lk+4Nx735iqzW
	 nNTIYLSP7xOHg==
Date: Mon, 24 Aug 2026 11:36:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 stable@vger.kernel.org, vega@nebusec.ai, Victor Nogueira
 <victor@mojatatu.com>
Subject: Re: [PATCH net v2] net/sched: bound qdisc_pkt_len to prevent qdisc
 soft lockup
Message-ID: <20260824113627.201f795f@kernel.org>
In-Reply-To: <CAM0EoMmhjJyBZArFUdVBzzw6Ko6C9thDgOL-VMU1jDTAhS_qYA@mail.gmail.com>
References: <20260819143213.57401-1-jhs@mojatatu.com>
	<CANn89iLM1JT7xeANTFYOxaOKuz1qSmM4yugRDg4y=uFwP7bdEw@mail.gmail.com>
	<CAM0EoMkUXGW0WNV4Y3rLUyJUDxFcmd7knYoF3ynHQWjUXHRTQQ@mail.gmail.com>
	<CANn89iJSR0kaRWtg+tkC2dfaOnCsG0TEcS=wS6oPOFuY5f0hjA@mail.gmail.com>
	<CAM0EoMmhjJyBZArFUdVBzzw6Ko6C9thDgOL-VMU1jDTAhS_qYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 11:30:44 -0400 Jamal Hadi Salim wrote:
> I see. I was looking for something reasonable. The problem is maximum
> real skb->len is UINT_MAX and with stab amplification it can get a
> small packet into a GB.
> Would you prefer a new #define in pkt_sched.h to put an upper bound
> (QDISC_PKT_LEN_MAX)?
> Something else?

Let's go with the define you mentioned to make progress.
-- 
pw-bot: cr
