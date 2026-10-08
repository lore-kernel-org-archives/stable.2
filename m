Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC938C2D0;
	Thu,  8 Oct 2026 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487212; cv=none; b=UjN6mxmgqQZTzgXDKHi4+o4mDaAqkQrcNJGCqmUafzNbPQFHgb0Yjzf03ilwANI92jS0SmE9u5yBgasM1met+bPlyuwa840xLl9XyVe/1BDNmcg49Zggrklc5Oy8+MBO4SAgbz6JK506g1R2hCz8bLFJl0a4hLTIeqqw6AeaPq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487212; c=relaxed/simple;
	bh=fqtvXx7SuhVACWim03ZBe3zS9HB8AvdJ4R5T5U8Eqqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OV0HErO1r5owNQiWTjDCx/KEumWsLSOP650cmUj5TS6ozw39sT4zjVXPUAzoTshFqtnOZJHsIQdEq05Sx+ZFKu67WXe7t5Ft+IazkIYZvupoefywXpZfA9veLxRAU0WqIxIGuIVQgaQZE9K3wtKW/hZYK67Xk1SSlgrEZ3NyS5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=TOG+mGXE; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="TOG+mGXE"
Received: from localhost (unknown [10.10.165.5])
	by mail.ispras.ru (Postfix) with ESMTPSA id 14A18407617A;
	Thu,  8 Oct 2026 19:19:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 14A18407617A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1791487199;
	bh=jcK7/LghoFd1/EJFysr6Y0kYIb8jr/AM86zczc6LWtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOG+mGXEoimluZjHiP2F8uGFZyIQHI6WhXAMQD11cJiE+Rd5LQCywBeX1/Kzv/RSt
	 23iiV9lBqoiJ/nD4A9KpWV+3G0Ii861XoeOQXQ7k4SvmeW4vwOSsSt0BjaEItPWMkS
	 MjyGKx+vERZDO+gyl9bFAr+mKq4voGF0qlRUy4JU=
Date: Thu, 8 Oct 2026 22:19:58 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Alexander Martyniuk <alexevgmart@gmail.com>
Cc: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lvc-project@linuxtesting.org, 
	Johannes Berg <johannes.berg@intel.com>, Thomas Pedersen <thomas@cozybit.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+63a84ea9c0f57d6133fa@syzkaller.appspotmail.com, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5.10/5.15] wifi: mac80211: mesh: release the channel if
 start fails
Message-ID: <20261008220352-4a493878ce385d22bedcf4a4-pchelkin@ispras>
References: <20261008115145.83101-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261008115145.83101-1-alexevgmart@gmail.com>

On Thu, 08. Oct 14:51, Alexander Martyniuk wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> commit ae97fff6495a8764bc0ef281cfe5444f701e527f upstream.
> 
> ieee80211_join_mesh() acquires a channel context and then calls
> ieee80211_start_mesh(), which can fail. In that case, the chanctx
> isn't released then interface removal will attempt to unassign it
> after it's removed from the driver, hitting:
> 
>   wlan0: Failed check-sdata-in-driver check, flags: 0x0
>   WARNING: net/mac80211/driver-ops.c:366 at drv_unassign_vif_chanctx
>    ieee80211_assign_link_chanctx
>    __ieee80211_link_release_channel
>    ieee80211_link_release_channel
>    ieee80211_teardown_sdata
>    unregister_netdevice_many_notify
>    _cfg80211_unregister_wdev
>    ieee80211_remove_interfaces
>    ieee80211_unregister_hw
>    mac80211_hwsim_del_radio
>    hwsim_exit_net
> 
> Correctly release the channel on start failures.
> 
> Assisted-by: LLM
> Reported-by: syzbot+63a84ea9c0f57d6133fa@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=63a84ea9c0f57d6133fa
> Fixes: 2b5e19677592 ("mac80211: cache mesh beacon")
> Link: https://patch.msgid.link/20260908122838.201719-21-johannes@sipsolutions.net
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
> ---
> Backport fix for CVE-2026-98326
>  net/mac80211/cfg.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index afb1ad3e6ea1..bae9588ea913 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -2276,7 +2276,11 @@ static int ieee80211_join_mesh(struct wiphy *wiphy, struct net_device *dev,
>  	if (err)
>  		return err;
>  
> -	return ieee80211_start_mesh(sdata);
> +	err = ieee80211_start_mesh(sdata);
> +	if (err)
> +		ieee80211_vif_release_channel(sdata);

In 5.10/5.15 ieee80211_vif_release_channel() requires &sdata->local->mtx
to be held, it has the corresponding lockdep assertion.

Besides, the backport uses a different release-function, relevant for old
kernels.  I understand that's an adaptation but FWIW it's generally
recommended to write a brief backporter's comment above one's SoB line if
any non-trivial adaptation is done.
