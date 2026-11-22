Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.13.135.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795340557;
	b=mnRxZ2nBF5fSGu1Op5OKJ2tr82330pmuAHjwh9rNkvkqdv+BMKQz7J8pETLkpsT2Euaq
	 2mLxlAaCEP+1CTewhbwhBUYKY4uUCBVwpJKhdJmxObmYc0K0kGM15bj6EoxE0o3cnjB4H
	 q5S26NUFnlzuhoFf+nkFV+NmYzjKRvMOWBR3Z6MZePlfa1yy17VVPVlhry2qKm+PsDQS9
	 l0f4NtGg1n67GySiQrtZzdwETSOdNpbiV+958O3Z0hsN7pBCQA5LkBZl5xRgrEPBaagJa
	 ciO/+VrKn+If5z0zQkVLL9U81dqi/ioyB5UQSQX/bzSjPPPXcINryyJ6GmakVWsESQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340557;
	h=DMARC-Filter:DKIM-Signature:X-KAS-Sym:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spamd-Bar;
	bh=7mXN9E5McDZalj6nJGIdEL3qJ/LKcow/He3TKSmJO6Q=;
	b=IVlU7DROgequzHRpC6hqpfvzUrX/53Lb+d+4AYY6CJsARjcvm+HNfgQml/dSV9f39eCe
	 i/5xe/DHTLgwzK9KR0HdIUSsc8gJvEqfIUJG+0NbPe8VF9ocl/qZbZdeLEwdSXYZIM5q8
	 rnRHSX7zQ3hj+u/bqfXsPbK6nJQKfYBpKpyp1Wl3A0TQv/pngttiAks4W9SeGRCbFxTfF
	 yAYzE/2Q8I9zpusk70dOFOE1eJJ/5Fwjyl+sevUUcKv3uBHgjzVehfV1Gxp/jWzlz+qVI
	 14YSmEtaQTXNphJZMGf5x+ztMK16l7yFusupvMZvn8lm3YlabZgOhcS7p4uAn/fYHxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tsv-stahl-riesa.de;
	spf=pass smtp.mailfrom=tsv-stahl-riesa.de;
	dkim=pass header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=ftWfv10p;
	arc=none smtp.remote-ip=85.13.135.14
Received: from dd13108.kasserver.com (dd13108.kasserver.com [85.13.135.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45633606A333;
	Sun, 22 Nov 2026 09:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45633606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=ftWfv10p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tsv-stahl-riesa.de;
	s=kas202608160020; t=1795340555;
	bh=7mXN9E5McDZalj6nJGIdEL3qJ/LKcow/He3TKSmJO6Q=;
	h=Date:Subject:To:Cc:From:In-Reply-To:From;
	b=ftWfv10pYGTEnkUtUsL1NSP8CT6Bzi1DFxQs28jyEc0kD/e7MUZ+hcHMUjGt0BxjD
	 Ti+pIup6YgKKC5f2XzyjYm7yxF905l+7D2mgDb0/LC+BfAvxLgPQhRCGhF8KNdm2kD
	 ej8Cf9I7KvkSXy5PGKyLJ/S7XLdzwH2j6Il7doEnfLfKnqs938TMOPRcY/SWq3GnGB
	 +pVZrMpPE67WM5aaBlp/kZ1Nzh6oT/Boc1N+tB+pc2X+97sJ1KnAJomRybAVO2I+1Q
	 wZ6coKZdANCTWLFV58bLp46YOPT69SypEORWlJ+5xeoxOe03o+EtVfjG2czhI7/hVj
	 Q6LOy46mRLZaA==
X-KAS-Sym: v3:f51bdf72230551df:BHLVAvXUbecqCx65KAKRaRfSCRJ/RnepLulMBbwPWwteb
	mripFIUpAml7cCtqERpaMGvp6Ak7OV3lE8iPMOqmpySjQJMXBc3GoUaNiOJ3JYVYJ6TKopF46jn
	q4uVWX6C3Ji3T33tnuwTxe3Tg5o4SRtDYVASaC9EWX+SWjXVbz1MzhyHPUZKqWAoEsfJYQOCr3/
	e8Hmx1pjaNOkVRlBEOwew3D70xuqqwYoYiiy7493mCJFAFA1pSDWWiaM9UqR8fM4BH7M4Lf2I7O
	IPBxu8VLsAFMYOTxjDWwPLNwXk+ftVWkLUIsiPpytvLNorB9dwbxDD9FVg92DyAthgqKyJeg==:
	iB+jSPSBoH54YX97hl+TQGE92aBQEwaqYZb0rqaIYqfkQV9roZkLFffVPd5I6sv3fEVuMWV9QVG
	+xZI6YYD/z0D5LFmiXwX0Hv5+AlMnmr+JIawHFeqJGtAWowTyS0CPdTau+HXjzA12eG+rzQPOMo
	Ti7abBvbGKcGRqrvZp9bx4nlbIuEuXbJHQ9DNRTtzFkCuJ+xGZfIt3Tz2ifmr2XSpG9ndVnEWFH
	fhKOtwq7piWy3KZR8DUw5gQc0D/JhqwGbwjHvdjDxWcaCWSQAxulC/Yu4Ys6gLjM9XErkmBiFY5
	NUzea3+RwJBppH+vYSOLewA7ZFvWqIbe3c8wVhNXkQQjifeEtQeeT+S6Swat+VBZBV/428g2JMA
	/zMxvPZMrDvohRcFj13EH0OoToYzXDolfUWBjxtbQzcU3WMkxjMEB7qpOklFhpqm5LmH9SU+d6x
	ofkytt/t42V/SZQu6t+8vTlSJUjletHebUcUXlz2UxgnV66LMD36yvDcbZtiOfij7WQj94SYr/0
	nToVcstC8QKX9y1ZjzDsFbSACuNgerpbMDwqpbp27KX9GXICu4bO6MWfPJuuuzYCJlO7Wrnu8k2
	YoAYvw9l
Received: from [192.168.2.174] (dslb-188-098-197-218.188.098.pools.vodafone-ip.de [188.98.197.218])
	by dd13108.kasserver.com (Postfix) with ESMTPSA id 0C79D78200C2;
	Sun, 22 Nov 2026 10:42:35 +0100 (CET)
Message-ID: <e3b302d3-979d-4b7e-9b51-dd5c8121c192@tsv-stahl-riesa.de>
Date: Sun, 22 Nov 2026 10:42:34 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] serial: tegra: Fix 32-bit overflows in the clock rate
 adjustment
To: Laxman Dewangan <ldewangan@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Thierry Reding
 <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: Shardar Shariff Md <smohammed@nvidia.com>,
 Krishna Yarlagadda <kyarlagadda@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
 stable@vger.kernel.org
References: <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
Content-Language: en-US
From: Patrick Fischer <admin@tsv-stahl-riesa.de>
In-Reply-To: <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: -

Hi Greg,

gentle ping on this series now that the merge window is over. Both
patches have Tested-by and Reviewed-by from Svyatoslav and still apply
cleanly to 7.4-rc3. Please let me know if anything needs to change.

Thanks,
Patrick
