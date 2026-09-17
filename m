Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8223F1B4257;
	Thu, 17 Sep 2026 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611031; cv=none; b=CoOd0JW+jD/lFSbfqZdRxyMrTZ9kd0K3ErA4wguC3RNP3fO4pfMpoGh49MefqDYfNvn0Q/qPNDpjwFhU/HsqeNTMUV3YMLhlO7s/whsZQ472EzHEV2tpzuG5tFKREosmM0f6mtjPuhbDWRiKAUQhOqltZJJu03AqHBU8PRYYfUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611031; c=relaxed/simple;
	bh=TBEoGhdwxynB/CvCr2tWYndxD0aUjrkZSgnkHjDVGUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqJiYkYOsI7Hgp1l61IE9mXXue8ZgfOkISGbcOWziLxYEMUZ/AEONzdPTQWo6fj9rVGg7WYm+APwnEMjs9VLZF27ciMuL6hZn+BGa2dGx3HmZrU1vIzYP8MWh5HvRpaMtAjM0ghfKzk61wir5SGSZMt47m80jTiKHY8fAPF0Dcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgwcXnAM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgwcXnAM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2116F1F000FF;
	Thu, 17 Sep 2026 02:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611030;
	bh=TBEoGhdwxynB/CvCr2tWYndxD0aUjrkZSgnkHjDVGUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JgwcXnAMgmqNkW+jIJJqXviu2P8Is/ffW/bcjwJtvRjJBSZVcsX+d1KBRUHXGiHnz
	 obOSGh6PHBd0MpiZ/vOwy3vhu4CbO3vwGJIQfgcNpVtWdnlqO2X+0u3NKL7aQ2nC4A
	 0yYwr78MVpWB/lmay1P1z+y7jwxG5OXowgnlBD8z8doAoc4T+O64YAiHXjUAv9K8kK
	 7ZOX6lkKJzwPl6ZxhYrSecGwKzuqc704b0zUwlfiKj3wilm4zkTYc5EGpBvZmpbTET
	 puiTntVfRn239EbkXL+UGXtFPZoszBPR/gDz5CFgBsZSk/qunhTlqaOW/ac37eu4QG
	 6G8UOmyjbarfA==
Date: Wed, 16 Sep 2026 19:10:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Kevin Curtis <kevin.curtis@farsite.co.uk>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: wan: farsync: Disable PCI device on removal
Message-ID: <20260916191029.54f0e0f4@kernel.org>
In-Reply-To: <20260915015941.86661-1-mhun512@gmail.com>
References: <20260915015941.86661-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 21:59:40 -0400 Myeonghun Pak wrote:
> Subject: [PATCH net] net: wan: farsync: Disable PCI device on removal

We're not fixing minor issues in orphaned drivers, sorry.
