Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ADB374186;
	Tue, 21 Jul 2026 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634311; cv=none; b=bClcSRG1JDP4uCrJj4IMleMLoj8ywJTuYMmJeRc9vJeeGOzS7XofmIekJ3uk5u219KS8V+j30Q+NtfPCxzISdg5necgeweYZz+Q61DF2tiSNXraAVHBKc1qci8asxuhtddGEt2/Hq2nNayPyKRu8MGIatbYRVUyjcUd76ZBzOrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634311; c=relaxed/simple;
	bh=pZptG7F+WImY5Bh8xXylXqzP9zapFZB07HZH578GoEc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H7jMqoeXx3hBdmlv0CSqoUEBTFyeIGq1rTQ3eG96V3eeozn4cy7/nbCMqzSe2A3nNrTOEXpHkXujiJXxMZfI+VgEm+GNUpS91mvVEL6O9kY5OD+AHESoHB2KpzCbr8cemrK0alw9dtaZrVMWM2eVeJ6uInjtSiONbjy4Ok45+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IkA9H1Pz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IkA9H1Pz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=51e/NXX3RWXe6Xl3NDfoTStUj9hUJtJJOdVMysO7bv4=;
	t=1784634309; x=1785843909; b=IkA9H1Pz7EOMaLfQYKCHwWBdKLVm5OEJjcF/yRIjRs+4wpn
	8ZeAOMKcXMc46VPaIgCHMWsggSyeNWT29AfBzYRF95kDclwW7ReIDvOPdTlwaACnEHbrZT3Ap7XL7
	Q1RSN6vLVVQj81ZrozkO+hWP4LYyegkW8NzAP7/siQtd30xtnGdxMIzvt2qG4P6lWhilggzGKg0Fe
	/Uq+vk7ao1PS/JrPg2foP2vGREHqPTi/NDc+YQB8CX9L7qpk58y5j/Tslol+/ImritizHTtGxRIy9
	3xvPHOJp1icfOpSw/JpvzWX//QE4MtcPASyKDc6pclbQuFcWDZs99lj5K1WjYSXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wm8Hb-00000001zfu-1aW1;
	Tue, 21 Jul 2026 13:05:08 +0200
Message-ID: <52df51b04ffce900a95c159319b1cd419f9a3b0f.camel@sipsolutions.net>
Subject: Re: [PATCH net] wifi: mac80211_hwsim: reject undersized
 HWSIM_ATTR_TX_INFO
From: Johannes Berg <johannes@sipsolutions.net>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 21 Jul 2026 13:05:06 +0200
In-Reply-To: <20260711151551.65504-1-security@auditcode.ai>
References: <20260711151551.65504-1-security@auditcode.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2026-07-11 at 17:15 +0200, Ibrahim Hashimov wrote:
> hwsim_tx_info_frame_received_nl() casts the HWSIM_ATTR_TX_INFO
> attribute payload to a `struct hwsim_tx_rate *` and then
> unconditionally walks IEEE80211_TX_MAX_RATES (4) entries of it:

[snip]

Way too much text. Please edit manually, LLMs like to be super verbose.

> 	[HWSIM_ATTR_TX_INFO] =3D { .type =3D NLA_BINARY,
> 				 .len =3D IEEE80211_TX_MAX_RATES *
> 					sizeof(struct hwsim_tx_rate)},

So, you found the policy, why not fix that instead?

johannes
