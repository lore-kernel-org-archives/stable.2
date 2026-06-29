Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850043EF654
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747647; cv=none; b=uW0b3pGTJXdwz7O3t++PTlITjktaQgZqLcsFPiNuSoGt7/Nx+d9JpwWACuurkwGfhS9lDDhrvnLmhAWZVeRx8YnkPJTJxV+xkjfYIchK3pxxwkX8KphUCnA+P+XCzzVT8aRe4JEKY8kuytcsZOsmEz6lYWrTGHByARziJwtAJIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747647; c=relaxed/simple;
	bh=EFwE5ooeukEnnEc43GuxbMkaqRCOSt5EXwI+fuMAuQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHMQTTN9X5YWYGptfnib+F6OFf4Hrcl65ESC++WF+DvG18VhsOc5NioLKeuLLkdjJWd/wCmKU04q+ILe+v3amUHkImH50ZK09P2Pk22Xuvn9X8c+Gr1HGYl9OQhkL1hoejjowgF3D341V5aoKfMZAU05GEtuhpJex8bP4+jxzZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7KAUloB; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7KAUloB"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30bc871ecdfso4609070eec.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782747643; x=1783352443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QToOEeOU/UyYphWJrDQxnYbVsLkFGV+L+v/I8ajcB8=;
        b=X7KAUloBk4wBFIhQjB+Z3wKOoBa3PjdtyBFul9mJlgZWR/daB6yyQ2rx9vrPzv8z5k
         XoD7mto5mD/Zh8ATvNdi5Ii6KKVtwIxFTQZzKat5x514wAocBuCrwt8M667SATF7xU2N
         816dY3im2CR+ua4bjMFvGSvcOILdyImuxMI/psNCt8VH18wZjzClyPl5CNDAzq45U9wk
         C7X23swU758DdLwjNmaaz3UGJSI5tFLBygI90k3RjlROe4PbfYPCAyLp8yzf73X8WtNq
         KwcHgChMda4VwapuiVvclRY8nq9OvqWOWZGu9tqAYCr/vAqOPZjNcVvsy1+bmCPJ/zoi
         LxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782747643; x=1783352443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8QToOEeOU/UyYphWJrDQxnYbVsLkFGV+L+v/I8ajcB8=;
        b=prqoUk5605z6QfQL4Bv+c4jSJ5OCTt/aGEfx+uwUz6gqMLcU6ddFwjG0SYn8ZAtzv4
         KSAoZnPYXzWHhrK7D8r9gJoSGvBERsPDZdfYbeWPWA3BGIecoHrmCNuCwii1e0bB8GDT
         Tg8L9h5zK3Ipq8zCH1FaAbWYyI9YI+jX+rLazSltZ3AT8eA6Hb2761BBL0vaTCeLS1VM
         O9CTL3dYm4yJwrRgTXnDgJHcM9Uq7jZ1p7frJZmhf20F1JZJRTJe5/bzu8kmgx/Y4XSa
         21vI9PH06WhhrlYRk8grKYe8L1DvA6vi2NuUGI0e6hifC3y2YRIYqZBi3DohZSQDDERI
         7A6A==
X-Forwarded-Encrypted: i=1; AHgh+RrA32UqbUyhKrIaK9/Cvv4e1790NLiWRjgVZFA56yPJ9bpJIOmTUUN+bqfJXZC4y42uhHQzoI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCZPTYPVFJnkq0q4/y+BtLTdsr4aYrgYwrUgnMGEQsG5qWMtG
	HA7T7EtuS2prtT/naTCpKZO9e0kUnzJnT/0EhtiAFcP4hGZ1tpTDkZ5u
X-Gm-Gg: AfdE7clt8SN2Zo046M+KyY2gVOhGrx/GABb8EGVlskSUre6CdunGsu+/Mg18ZPer32b
	CQpNXcSKPfO2UOREYsDH/RkI1eyhUDzdZsMFsKYpBv1C8/U3f9EQEYXccsPP89fT0Nz8CJ+r1hc
	ZNAAZ7K3XFmjfWDLkPrkpe7rtQIHs39iSwkm4PrfCbbqcFztkzFGLaLp6maI+4MhOM9p0ThMuno
	RJZAwULNaME7k9nkTW6yJzrvO7AhthkOapInPV/qefHgc1U9EQE7OnC9cZm64+v64klgHu6Czh5
	UZ7JZ/Rl13L87QsbZ3RQkFnwDsqesDjLAIaf77XVkIW8pfSJWsMA6yXAGnAgZo1W2Du245b2JAv
	6RlTSNg0+Jph9+pRCDwvUwFKKLHwsbE1jC4fldq5REEi6NNwdrUY02eKa4SYmGht5zwVUCH591s
	vJPM8iVWiDHeUcWvP2I8fGqBkLWw==
X-Received: by 2002:a05:7300:8c15:b0:30c:1147:ccc3 with SMTP id 5a478bee46e88-30c84fdbbaemr16973902eec.33.1782747643093;
        Mon, 29 Jun 2026 08:40:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ec3e400a2sm19162263eec.28.2026.06.29.08.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:40:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 29 Jun 2026 08:40:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Eddie James <eajames@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (occ) unregister sysfs devices outside occ lock
Message-ID: <09e5f291-eb8f-4c56-8d61-45b38c81fa2d@roeck-us.net>
References: <20260617150859.741453-1-runyu.xiao@seu.edu.cn>
 <20260619015938.494464-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619015938.494464-1-runyu.xiao@seu.edu.cn>

On Fri, Jun 19, 2026 at 09:59:38AM +0800, Runyu Xiao wrote:
> occ_active(false) and occ_shutdown() unregister sysfs-backed devices while
> occ->lock is held.  hwmon_device_unregister() and sysfs_remove_group() can
> wait for active sysfs callbacks to drain, and those callbacks can enter the
> OCC update path and try to take occ->lock again.  That gives the unregister
> paths the lock ordering occ->lock -> sysfs callback drain, while a callback
> has the opposite edge sysfs callback -> occ->lock.
> 
> This issue was found by our static analysis tool and then manually
> reviewed against the current tree.
> 
> The grounded PoC kept the real unregister and callback carrier:
> 
>   occ_shutdown()
>   hwmon_device_unregister()
>   occ_show_temp_1()
>   occ_update_response()
> 
> Lockdep reported the circular dependency with occ_shutdown() already
> holding the OCC mutex and hwmon_device_unregister() waiting on the sysfs
> side:
> 
>   WARNING: possible circular locking dependency detected
>   ... (sysfs_lock) ... at: hwmon_device_unregister+0x12/0x30 [vuln_msv]
>   ... (&test_occ.lock) ... at: occ_shutdown.constprop.0+0xe/0x40 [vuln_msv]
>   occ_update_response.isra.0+0xb/0x20 [vuln_msv]
>   occ_show_temp_1.constprop.0.isra.0+0x23/0x40 [vuln_msv]
>   *** DEADLOCK ***
> 
> Serialize hwmon registration and removal with a separate hwmon_lock.
> Under that lock, detach occ->hwmon and update occ->active while occ->lock
> is held so concurrent OCC state changes still see a stable state, then
> drop occ->lock before calling hwmon_device_unregister().  Remove the
> driver sysfs group before taking occ->lock in occ_shutdown(), so draining
> the driver attributes cannot wait while the OCC mutex is held.  Also make
> OCC update callbacks return -ENODEV after deactivation, so callbacks that
> already passed sysfs active protection do not poll the hardware after
> teardown has detached the hwmon device.
> 
> Fixes: 849b0156d996 ("hwmon: (occ) Delay hwmon registration until user request")
> Fixes: ac6888ac5a11 ("hwmon: (occ) Lock mutex in shutdown to prevent race with occ_active")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied.

Thanks,
Guenter
