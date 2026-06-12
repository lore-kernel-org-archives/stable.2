Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8BC35E1C3
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275284; cv=none; b=EhDM/nySk+7qo3hiNc7EvFSiLorGqL+jS8Vm4WrYTv/TlFi1BkX4t0Ri9h4xL3DQmmjqE2RXiIRmOcMsmvaav+zMODbFA6jhss5sL8I79vGf7qpoo7GNtsLAdMvJsX9PYFk+zAsrpsr1d/tpRpWGZg5SbN0yHg9htYFvhiBOJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275284; c=relaxed/simple;
	bh=tOihwrG2GW8dEz+XPM8wmcselRnF6BHlVgFIImbB9KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXms84yXZBfqn+0OlHUS1Bl0ct65IchvauFvzHRIblFPrr3P3XODB/XFhDVVo1AeJaC51rGTsBYMUKAmEiQrK3UO/Qn0tSDOpBV6RDfBIN48J6baswvPoPyHN+jRruBlbpAlq1lDA0zsVYn0RkGr7CxxWPWlV0RZpP3EYkRTaAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0u9J25A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0u9J25A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A775F1F000E9;
	Fri, 12 Jun 2026 14:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275283;
	bh=tOihwrG2GW8dEz+XPM8wmcselRnF6BHlVgFIImbB9KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l0u9J25AOGdhkafzxCGYv1nJx3UccgP8KpvY6Bfk38HDg+5LosKAxmqN2+c6Gb508
	 f6XVtiC0a2lIWOMmzOoVSdhIAKtmn7YKBAi7VliGwWMPyj9dUcIgApFJoKyaCi473U
	 H2rPVBAdthDs+oZRyiCs/9GeSX5MEj+f7tQJR8e6bsZJK0WxAPu+0Zg+6PFiO4OR2L
	 riIG+Q733vEDra/m3RdnMBcXhFuWSu4A/fY9aHi3Jn9mccBIqFmZjObgFkBezbyNj/
	 DafMX/t/lwbd0GdtdFZCMTJUkFLcu/txqEFvuYIVXrcP85jB8QNAov8VR7qEfunwHg
	 J1jWeAMC4xcig==
From: Sasha Levin <sashal@kernel.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Minh Nguyen <minhnguyen.080505@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Please apply 98d0912e9f84 ("net: skbuff: fix missing zerocopy reference in pskb_carve helpers") down to 6.1.y
Date: Fri, 12 Jun 2026 10:41:16 -0400
Message-ID: <20260612-stable-reply-pskb-carve-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <airicdmj6A7ZRGxs@eldamar.lan>
References: <airicdmj6A7ZRGxs@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 06:29:37PM +0200, Salvatore Bonaccorso wrote:
> Here is the backport for the 6.6.y series as well.
>
> As mentioned in the other mail, I could not have looked explicitly for
> the 5.15.y and 5.10.y. In particular for the later I think more work
> is required.

Thanks, queued for 6.6.y and 6.1.y.

--
Thanks,
Sasha
