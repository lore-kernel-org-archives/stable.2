Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1151441636
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908884; cv=none; b=VlZ2ujakpWNlzKOi3yU/qmYv1flrdTaYkyUymGY6KhecMjI0Jpz4skLDborNJjlIKpficQUvhmuo5ho0UuKj/VXyes4S4Q9qlNMqG439HeeHR37ZRIr7rXamEERnumOuxPToy0KK/8fOqXARrAZzgGF8J6EKsi5d4hvnLNVAMBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908884; c=relaxed/simple;
	bh=9gB3FZ/URecrVzXEqePsQErtHg6htVk+48ctF0yoBW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xo61mUo1xW6+YxJTqR39EU3FNRCBy5X0JhOQ8UeIvH38EktvlagGXjbT7lDVisB/FljI1cd5RU9ugJVFTu6vIvEVPNW9sOBVSBaI5vnaI9fNXyDEuXCIR2X2DkLXw7Gnb3exdrd1w4HqcLcIGoyZtX5QT7iXp6LrMMhuVUE+7yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZEWqhgu; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZEWqhgu"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-381c69ad0d9so276719a91.0
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 09:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784908882; x=1785513682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7lGCvGc0qmAYP5540gpiXw7B0oJUHKRWl+SM1YR+Tyg=;
        b=XZEWqhguWqCuR6Mbb1GfWoZW/e2T09RsnYxRThexKogcaD7WQtrUSX0tHLuN9Qe7cQ
         Y2NLaxuYsz8xoevEJDhJXLLpuvsSEGZAvkqoPwTqb9gvEbJ8rKV6mcfU4IxKxUWC8PYF
         Un69Upu0aqg5lguOBvvJorf2mGNpvyxyAk+u2rCXGGMhaSdQaDVwk9KvMwZ+fHg2VqrI
         nXBP8LqitlJT8Wwh36YPkzezKeXCgKWZwVTbFm3q2179qNRzLoGR3ZhFEuPlUKlVsm0O
         JkT46Wwq5IAD9xxeEB6CDLbJE33p1HtC9KX+GO63YTPaisA58ugzJGz+yPuq037L6DGD
         sfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784908882; x=1785513682;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7lGCvGc0qmAYP5540gpiXw7B0oJUHKRWl+SM1YR+Tyg=;
        b=bGQx2lWQFXsTY8GFmH9MxZiSFU4MxSS6t0ZUGlezsHKSvVr++wvYS25kEmUPZyo2EC
         wS0/tsAXzlWPwmelBJ+K6qSxxioEjEPOs9Tsoh2VU7zZWhK5CAApmzksXBcFnm1NgtiV
         ix5eL9Nlue4O9sXpV8Fa0Yl0OQDCbclWDg55KHY7gK0NqfVmzANwQOVOScPgHNe9Vuqs
         3cqFNUDVmEMjtSrBSyDVQxNz3BaMZfrs9FClZhdh7Dq/tWxBofNwjm4x5Yucz6UbrlWo
         6LIQIUKaxVREnud8cNQvrjRH4Sv+HjX2uvjfbK5CDwVlFc4oeuVWQhHlKNC5oBpPvTMq
         vKeg==
X-Forwarded-Encrypted: i=1; AHgh+RptouSe4lbcEqlO1Nfy9KOPcpV+wt3EPI7jDJUxGnPA2YqZpS+RRS0ogsz0TdnVBwA41X8mxdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ2EH8ZNpluNz6QZy3RB3gpQtV1UEvHJp3cZE5uPrUiHxXK1ed
	kSdXIxUGKpT+rwDS70tO7hFnRoYzalRZklSGoa8YSlyyZc0hloNRkbyi
X-Gm-Gg: AR+sD12Pk6dJ2g7nK370ThJcGlOa9xqPNtOBGJZQlS3N0fKLnQa1wUfMZCaGy+Cx+PL
	wlvvao/ttotREe+4y88hO6KAgeFW2frwQHQeRe49hpqjMiM9A4k+cQttdo2dpor2TylN6W4RTh5
	GzZu+n3eKbzaFegX+Y2FDc+2Le8IpEWMeHvh13pl354AtDBkRcW0HQq5I5gwzt1qSO7gZLxRMKb
	zwvm7ekp4rFFa5b1+jamhy/XuDK7UU5dQjnl7mU5sqZsQUmIYhir29GPK1GGGE3yxiLIfntnCLn
	Bbrq7sXMqtWAMfTNwUyxByX0rRblfy5BitLdtPfgpJlG638BNk0MqcXdhEqPvtgatH2e5H54Kl2
	iMOOnXiu1BA89OaZldPQBAK1akd1k9Z0inP5M4wnjfsoIiLsTzkbG9cU658fE9D+A8iaRQIU=
X-Received: by 2002:a17:90a:d64c:b0:381:bc4c:da5b with SMTP id 98e67ed59e1d1-38ec6985236mr7668458a91.18.1784908882110;
        Fri, 24 Jul 2026 09:01:22 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f056202cesm902393a91.0.2026.07.24.09.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:01:21 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:01:16 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Mina Almasry <almasrymina@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Donald Hunter <donald.hunter@gmail.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] netdev: require admin permission for the bind-tx
 netlink operation
Message-ID: <amOL4DB9G1l4SrSy@devvm7509.cco0.facebook.com>
References: <20260724150156.72816-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724150156.72816-1-doruk@0sec.ai>

On 07/24, Doruk Tan Ozturk wrote:
> The netdev generic-netlink bind-rx operation (NETDEV_CMD_BIND_RX) is
> flagged uns-admin-perm, so binding a dmabuf into a device RX datapath
> requires CAP_NET_ADMIN. The symmetric bind-tx operation
> (NETDEV_CMD_BIND_TX), added later, was given no permission flag. The
> netdev family sets netnsok and has no pre_doit, and
> netdev_nl_bind_tx_doit() performs no capability check, so any
> unprivileged process can bind a dmabuf into a netmem-TX-capable device
> TX datapath.
> 
> net_devmem_bind_dmabuf() attaches and DMA-maps the caller-supplied
> dmabuf to the device and installs TX device-memory state, the same
> class of privileged device operation that bind-rx restricts. Gate
> bind-tx behind uns-admin-perm to match bind-rx.

TX is permission-less by design, it does not modify the netdev in any way.
