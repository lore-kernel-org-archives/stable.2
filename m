Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53CE145B3F;
	Wed, 24 Jun 2026 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325017; cv=none; b=W40eoiJ1ISyWHuwxXkRiTl6n6SriZClIRau1rIZ+Pg5HETes8riY4pOBCbY+gMo+uTQJ2pv9Du/NIP8mTTE1pqOoNvpeybL95h32oKPGGM+VGlLIIUTZTd3yoXEgukK/OGmOp0Xj7jPdJgTOGnERyQKCEEAKQ0n5fFJsgI7z0QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325017; c=relaxed/simple;
	bh=7NnaKsEYxlQ7+w0A9v23Et8HeWTkSa7HrG3iVsCesv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMna50D6HGEA61+ClLIjV+QPSH3v2cEBoDqvQ6Igk12o8eKMThmSYCD96vZ9pP3iajho0ijQ/429FUa0QJeLAZDJwbkKczA6IyPU4MIpUCHFIbDTbAu4rmfiJzAWG62F8v0MBhcxx6XqBQ349YllrlNcJcmBEMJzgGfWwiRR6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG6UZAJW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG6UZAJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA13A1F000E9;
	Wed, 24 Jun 2026 18:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782325016;
	bh=xls8epCz9Eh9Dj6gwTjfqKKY5gFaZNqvZ8MA83RxZGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oG6UZAJWNoZeyPneAL76f/xmotrBI5IsW5FU6h6ulrPghXDNhRXsXitBUwzTe0P2Q
	 hyal4TKlYaEIW8M7YmqXXsoCHbtr4wafAf5rMygxrcggr9wKOkGfez+DdYiq9gWjKM
	 DZkDb5J8VbWOZEvcGT4MHTKhBrdZwvWQN1nUm/FVS+PwE+9UBXlItk0GiNOwycPNM4
	 OO17HXbEge9bWuH6/5XBUzMv97MTtYjNBJh0Utq2KUSa4EYvDTJ08DwpU5wH0W9L97
	 feOopsCXYoJBnzbgCF81WVIsV2ssSIoouHqbbO3JBV5qvJ+qtWaldx0y80LN4Qi1ob
	 Kiknqm1HQcliQ==
Date: Wed, 24 Jun 2026 19:16:51 +0100
From: Simon Horman <horms@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
	kees@kernel.org, bjarni.jonasson@microchip.com,
	lars.povlsen@microchip.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: sparx5: unregister blocking notifier on init failure
Message-ID: <20260624181651.GC1131256@horms.kernel.org>
References: <20260623115714.2192074-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623115714.2192074-1-haoxiang_li2024@163.com>

On Tue, Jun 23, 2026 at 07:57:14PM +0800, Haoxiang Li wrote:
> sparx5_register_notifier_blocks() registers the switchdev blocking
> notifier before allocating the ordered workqueue. If the workqueue
> allocation fails, the error path unregisters the switchdev and netdevice
> notifiers, but leaves the blocking notifier registered.
> 
> Add a separate error label for the workqueue allocation failure path and
> unregister the switchdev blocking notifier there.
> 
> Fixes: d6fce5141929 ("net: sparx5: add switching support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Reviewed-by: Simon Horman <horms@kernel.org>

