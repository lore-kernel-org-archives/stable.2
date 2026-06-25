Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF34C35E940;
	Thu, 25 Jun 2026 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782348405; cv=none; b=iiWeLUtW2Adsrqx3G3zFqfZgPTSwrvIooUdhGoagvek5kIxVm8zdlpyz8VAZmDVbwFK7jqgTd3RGOfTPkmi2n/vQ5kmFYYcHI3doI2+QJzEipYYwYS4oA3MFhVr6/0FMSw30TF8KK/nte4nMG0UJ0zLWCR9vGdnOEjAwJ8TYnYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782348405; c=relaxed/simple;
	bh=67MthuxU73U1xA9VK2d01iwIZdi+ncVNZ2vKuf5Yl3o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MU8KS0ZOEBUKb3/h/F1edUoE+ZwQ2FaPh/3ELiEnpbY/eoFZDP3r0vYdIQDJVgJFRmqj++bVwgvvliKLiLKJP1QtmtzPrIApaGV1xNktGAqBnKg3bjxFoojPKrmhoJt3uTX2ssbn8BmTHE0RFlYV5nQPq7zu08taBWasGDPy+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OIPuJwZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OIPuJwZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078D81F000E9;
	Thu, 25 Jun 2026 00:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782348403;
	bh=OHXgIzAq1ABZ6fiQ3NfXaitG1aotS7Mupzd1wlwLSx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OIPuJwZOZapWq1v3vaakOmLIHv9zLawflrgUu9yGeNcys6oKU01XztCJgiOKCD+ye
	 8427eZwz1ae8baJy+pTm5IR7lM6NSwusqV6hOZpMMWrh2HDKqPzcK4TkVqv5TiaN0t
	 YnL9sy6YRlrNCp4FRJ6rYxqNiuUMnaKO98w3VQHg=
Date: Wed, 24 Jun 2026 17:46:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Kees Cook <kees@kernel.org>, Matteo Croce <mcroce@microsoft.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] reboot: keep parsed reboot CPU in range
Message-Id: <20260624174642.da2cc6912a9b19accd378538@linux-foundation.org>
In-Reply-To: <20260622154216.10064-1-include@grrlz.net>
References: <20260622154216.10064-1-include@grrlz.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 15:42:16 +0000 Bradley Morgan <include@grrlz.net> wrote:

> reboot=s... parses the CPU number with simple_strtoul(), but stores
> it in an int before checking it against num_possible_cpus(). Very
> large values can wrap negative and bypass the range check, leaving
> reboot_cpu invalid for migrate_to_reboot_cpu().

Thanks.  kstrtoXX() is the modern way.

> Keep the parsed value unsigned until after the range check.
> 
> Fixes: f9a90501faac ("reboot: refactor and comment the cpu selection code")
> Cc: stable@vger.kernel.org

I don't think this is serious enough to warrant backporting.


