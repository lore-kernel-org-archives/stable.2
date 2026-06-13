Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B231A9F8C
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310044; cv=none; b=FPPIe+dr+40mJjpC4CAj/ibRg+yzO4fY2lCNtm7tk+1k82QFZ5WiHOB0z/ERp7raGfdjTLasYsjGdY79aZKy75hUb5SowYXsej4ZLbzELjcumpdZIxTKNMhk+MRslu5pmZHGxn+poW/Me2s8MVyj4UgrbBLk5RlN6EowOWjOSjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310044; c=relaxed/simple;
	bh=HAhhcYjAKT5J+ykF1nq/n9Mf/eHOm482fWFb2rB2ZH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9xwCa1jCoN9DKzouyTkbvzaC2APs+rQn4tpAtqhaKCpWxD3GJ9Gz5Ba+LKTTaadLMBcY0wNXaKTS5V8uyEfihv4Es4j+YI76CtSIy6u3S62X5yMCqO9Say21EVaBS0jwC33kEK4SGM/0WqFKpGX9Ue+C6cLeowOrLbhOcSXJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDBYadxX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDBYadxX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2322B1F000E9;
	Sat, 13 Jun 2026 00:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781310041;
	bh=HAhhcYjAKT5J+ykF1nq/n9Mf/eHOm482fWFb2rB2ZH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eDBYadxXt+9KG6UQeQxrlKq49Lojq8gJmm7PrRXl3YuFWZ8SB2Z/6Dsxz0sFiq2w4
	 T8thAjnACRGSHTVHO+R4ssLOFmpL+blUNiAzuFM3vWNR5bfRLzwrmIz81t9ykCMVPH
	 3VODfyeH/Z61YW6nD2gP40MJvL0hm1KD3eLMuBXGMWCxWaI6ynwo0Uyq4NHzwXbs62
	 lkKWD6woRaNlLpRX6TWc5BJrOY1Uqxn2BCbTqR2L00a8m7XuNS+8ZeCkhTGie5OELM
	 lz5W9pViJN6Gd9jhU4Ysj+gJo6VJym3Qe54PrdkI+IBc+DpF0HdtQVqGglzoZ7MzL9
	 C/VvFcKj+W7Sg==
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
Date: Fri, 12 Jun 2026 20:20:35 -0400
Message-ID: <20260612233120.3-1-sashal@kernel.org>
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

Thanks, the 6.6.y backport is queued, and 6.1.y is queued on top of it.

--
Thanks,
Sasha
