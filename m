Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61F3644C1;
	Tue,  1 Sep 2026 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275213; cv=none; b=IDcdSJDcxFpq57ehAbushma0tJFx3WW1L3KbikFKxiH455b5Sf6hCxnKAB4qDv1JgUQIXiZ1BjSwhL2kuipTYagPzqpNTjFOnQzE8OW86JlYvzkQcx+VnkH1xmKk01Xnsl3TJjO7Nscm89heVAvHtgObdDHSOXxYPvyMb/sjfQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275213; c=relaxed/simple;
	bh=YsmZBVpIc4B7O5IpTFE3k08A2Cn0DMN/SxP6LAJOrz0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mklSmMtlMIfsCMitjHaz4YgvKFFTXrFJl/2G0b5GyKAMnLiUhAlggGdrQtHgyauw2C6iEqS4kvboFd1pHLpt3hardTxDYp5w1CPA0BvCdU5U0EP1A1XrYU34H7mxNJlCH0KOK8JnfpeeIk3BbYOOcaMMKlTSfohdHmrGAg0lpBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrFwW9/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrFwW9/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493C01F000E9;
	Tue,  1 Sep 2026 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788275211;
	bh=w6luQyQlp43q7xRA222IbS8aYyAU4c2NFpr+h+0SaJA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=KrFwW9/NvDf1rPXtsE4e+TMxZyaWE7N9EDqrLu/+BLSamT2UBQOv9QGEnHJqvuEeX
	 ettP6dnPZo2i7awYzELV2fI92bBfmjhiyNpcL7tuA169T9JqOiCZTz6IbSi1Ca+fc7
	 KnTG1uvRur+R7ZXHG2QsbR2bEqHCqBeuHAaHA9fq8hnZXTRUZZXrO33CxPpxf7vQjA
	 1F5+aijV2pe2BR1CE2jll5TzXNJuIoH++VKkXF7bWlxnzBWYLEUXO4TQSzVY8YO5cJ
	 RjKwLPudtFI2TC1Lq/BU1GiU28bqaOE7frq2mhwORDXAj/yw1M09uPvRn5iQ+AZseH
	 8nczQtuT3sViQ==
Date: Tue, 1 Sep 2026 17:06:49 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Wei Jie Law <98lawweijie@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5] HID: rmi: fix OOB access with undersized RMI
 reports
In-Reply-To: <20260825103117.12180-1-98lawweijie@gmail.com>
Message-ID: <65p7oon5-or20-q512-p9np-4o574q402165@xreary.bet>
References: <20260825103117.12180-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

