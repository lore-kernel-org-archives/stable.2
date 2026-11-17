Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937567;
	b=Cu31HlBJtjBPX24O+DIPSOghCuEmuEr/ZQpITVNYDebaq/JFTXUBZW8hN3BNNMKM2wkU
	 Bcs5yvXjRg5tViRruMiOVkZCglYvyOJ1z/UHAV71lQBVJQ8c2YqGtrN+pd0EJRlmKJSBb
	 kBWkCWVf17yZy5ztrCCk8f13DgQP1uSVyj7GHomjrdi8JgoYQrYFDgK5FKfsme9Q7NcrQ
	 6UAJY0Qh5wDsEdJ7IgUb6qtlrDIUyoY++zvyHlAz0mW/vHETNroBcc9AXfWVCbVe4WKWc
	 M2xWeJ6cqn2y4qDv+b1flwnltDnpNvot6BHRnrpG4hrc8NXyfVoQ/LRF+wDYioJVYfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937567;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=SlG7QLB1kJzkI8H5DG02stBipiVu0CjDAuInDuzsrOs=;
	b=aBupCYYgcrWLiiEYyBZVmkKz2UQA1wTRiSg5gzB7/t4k6iLuZGE2ie5M6LXhoixo9bAc
	 l0l4PyTcfyJ0sNYYAs+3eoSN8ldeTgs7aT1D9Ga+V1cerhjtG0/IfuwAoK+PZlSPgTsAI
	 /bERrBY77PWWwuaLA5vBXeFM6RjP+/3hDh630j2LUO/DOlA1OQ7YC2UPL7mLI29WrsOYp
	 Kvrq53SnAWZDQYYKudVXW8SSsjEXvRj0C+EQjAycmSJ4VkluW+B0hwyn0EY9gQjZfsvok
	 mCOBSVVZEEdqrpMLRygYj7fYqi2R6x5OcDxCVI5PTYhwLHA+8N1rs2tn8AgAUiIQrTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=uQLS4+jt;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB05606A31C;
	Tue, 17 Nov 2026 17:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BB05606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=uQLS4+jt
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB0281A00;
	Tue, 17 Nov 2026 09:46:01 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 790703F632;
	Tue, 17 Nov 2026 09:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794937564; bh=NtQj8MNCnhvZNvOKcp20IxPx6PzYni3ArIZnYqISPiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQLS4+jtKeL+VWPwFB7KD+ijfK5bsFdh6jcei9p++JhjdTH5twkyk2rjtE0VjeJKX
	 WbJ69WshCKRQq6OkrwKT7zPQzcQ3uXYNCOKNaLQPHVJNgYuHIYjUZ34XI31hEUxtlS
	 ya2sdIDWkywrPkXXVAuR9GgYar6qaPhH58MZ18Xk=
Date: Tue, 17 Nov 2026 17:46:00 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Chengyu Liu <lui2012qwq@gmail.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, philip.radford@arm.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Fix deadlock between reboot
 notifier and forceful work
Message-ID: <avyS2OLs3XGcKXXn@pluto>
References: <20261116084211.3066460-1-cristian.marussi@arm.com>
 <20261116084211.3066460-2-cristian.marussi@arm.com>
 <20261116-astonishing-urchin-from-jupiter-838cfc@sudeepholla>
 <avw5o7sTyriZ2ZiX@pluto>
 <20261117-prodigious-limpet-of-fame-3d72e6@sudeepholla>
 <CAE=Q7=4+HMtqbiK9v3jw4t31TQOYUfRXKRurZ7KcMi7GTi1v2A@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=Q7=4+HMtqbiK9v3jw4t31TQOYUfRXKRurZ7KcMi7GTi1v2A@mail.gmail.com>

On Wed, Nov 18, 2026 at 01:35:04AM +0800, Chengyu Liu wrote:
> Hi,
> 
> I think the current v2 may have reintroduced the second deadlock
> described in my original commit message.
> 
> scmi_forceful_work_func() still calls unregister_reboot_notifier()
> while holding sc->state_mtx. Could you also check the potential lock
> inversion between state_mtx and reboot_notifier_list.rwsem?
> 
> The reboot path holds the rwsem read lock while executing the notifier
> callback, which then waits for state_mtx. Meanwhile, the worker holds
> state_mtx while trying to unregister the notifier, which requires the
> rwsem write lock.

Yes indeed Sashiko complains about the same and the second part of the
issue on the rwsem is unresolved and will need more work.

Thanks,
Cristian
