Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5761A9FBD;
	Tue, 25 Aug 2026 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647637; cv=none; b=eMaPWTMpH3smn23PIrSvAb33aFEhceaB4VZifa7vLSCZY8lRjTFBSpv+G/IjM11/TYVb/pII+gHA1vpgrYO8B6zrnig7Y7UOIlrl5Ku03sdOWoJhS9IfpEvrzPxczQdmY7rGKkZp0NL0gRjGxy8hTgSRebS3/xy30OC/T+seSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647637; c=relaxed/simple;
	bh=9iNGiXurcCv+5fGLR7kL9ZTVi+vh7411c3K0gUozs20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UAY0jiSysgFQJ/SywCfm4kLaG56bRVPOtAPTY9OZPI3uSUf5S60hBziy55iRf9cwns6zdffrKqhp1Rfw4ulDZ6sFNsD+Kbk+HuovOrD7T2BSqA3qVBVtowrNNAXqbFMWhZQOdiWs4GaMxibRjDjYHPsMiwWbRYxvhythSTJB9X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=OqrIPmrF; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="OqrIPmrF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787647634; x=1787906834;
	bh=Od7IsANHp9XzoW8pEczlbQg4ofXu9FbMG+Auow4vD0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OqrIPmrFd5TsKtZtTQEF0oWcxPk3Lpn51VrrN59DBWzACZjfT66DA5rr9npX3EuE+
	 gnovSvhnVE9iUZe9VvzzUu+ib0uqI14i5kFm/5zGXr6aBtuQl2B5g3oBGetHtGAOXY
	 GlonY0XLLxNXZ2z5cD4r0IMpoXB0InGi7BqPzEfYOncPoRpgQLH5PPlc8JzDPW02wI
	 HhVYxpaugKl4r8njtZhSvryoiFhqKqQ/BJP15TCQKdBWwzYOHcR/XkBp3jco3Agf0/
	 Y7CwfSOeLzpnvcfv3EvNUP/zDDRLnzMUGKlUNcM83Hhi5s6oo3+/dYAKrU/B5JSVxe
	 kqLAP3OR1huyQ==
X-Pm-Submission-Id: 4hThH52vKZz2Schg
From: Esben Haabendal <esben@geanix.com>
To: "Markus Elfring" <Markus.Elfring@web.de>
Cc: <dri-devel@lists.freedesktop.org>,  <stable@vger.kernel.org>,  "LKML"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] drm/bridge: ti-sn65dsi83: Propagate error in
 sn65dsi83_reset_pipe()
In-Reply-To: <2f0fef87-4377-4a01-a210-8d55a0b67a9e@web.de> (Markus Elfring's
	message of "Wed, 19 Aug 2026 13:51:13 +0200")
References: <20260810-ti-sn65dsi83-fixes-v4-2-ae9c95c8d162@geanix.com>
	<v45WZnbABEcVZHxTpq2Cw_Z3nnj7uSdSYEP2ANyYM3ZcoriX3BBSBRNIHGm_hNTsSqq3z35ZJLXTpuREP82q9w==@protonmail.internalid>
	<2f0fef87-4377-4a01-a210-8d55a0b67a9e@web.de>
Date: Tue, 25 Aug 2026 10:47:12 +0200
Message-ID: <87se42oacv.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Markus Elfring" <Markus.Elfring@web.de> writes:

>> Propagate the error code from drm_bridge_helper_reset_crtc(), so that
>> callers has a chance to handle the failure.
>
>           have got?

I will change to "so that callers have a chance ...", for proper
plural form. Thanks.

/Esben
