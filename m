Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FECB38DC50;
	Thu, 30 Jul 2026 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422830; cv=none; b=ZY84L2YD/F2MLdHtc3ZB9uZskShkMfngSNocgWBBis3ThPAMNj4QNw/vyVgpldtzU5S9Ffllt/EtU6dpz6+DzQATO6yhFlst/7VpE/OrROy9UOj5RfIpJyPzFy5+icw+qwcoyMp8mr2m3+gz6zCvR4J7A6J5P54VKIiqvcAxzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422830; c=relaxed/simple;
	bh=kUE5i8p9QVvzL+XnMimLV4JyGsBzaWMnWl8xmyuYB6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=id5ozh6/mI002keyYPpToWQvTplYVr0p1VmLgzHX6cYWGK45bSWBzy9HXM+wMDLAnsC6hTNEy0CI36r41aWHw0eRToV1iyDiyuwul57QTJijKDc067NnxsZKe3F0tAgSiaD1qjrpym6quLRSUpwkh6MDgOr7jeFdgGf0ExHksA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWtQDiQp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWtQDiQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F66C1F00A3A;
	Thu, 30 Jul 2026 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785422828;
	bh=FYx9PFFHsxsK0B8I6N6sUGEP6tsXyBn7+dYN7OyFtFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eWtQDiQpWc/KiRV8lRfmdpMx9GkYxDg3FajW9zcGCjORaFy6CYcZMtzQRqc5ZG997
	 kfu2uFc/MAXvZeSwYxAFxrynCsnYsgvXadTYodCOU3kiejfURLUz5IWZ1ZP9oqdZD6
	 iGnDR71fjIqg55V/PLWIMBNaoYPyhuONESsahmi6wOflm7/fo5bP6Rs3U/LlbyaGCt
	 D9/mB5Y/HgK0t7nmAalFwtdOw9iaaBprLSXbf6QulQWW/8t5vm0bFfMcc6hS0zMP5J
	 5eyJ88Mnz/KpjNIXJGwylPnQP0UP/GYezFea5buBsQ+eHa3DweQyKSHnijSVP8F6MS
	 lJm5qu2jjT+tA==
From: Simon Horman <horms@kernel.org>
To: xiexinet@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/4] net: hsr: fix packet drops caused by GRO superpackets
Date: Thu, 30 Jul 2026 15:46:53 +0100
Message-ID: <20260730144653.147367-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724161253.79-2-xiexinet@gmail.com>
References: <20260724161253.79-2-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260724161253.79-2-xiexinet@gmail.com?part=1
---
--- Patch [1]: [PATCH net v2 1/4] net: hsr: fix packet drops caused by GRO superpackets ---
commit b386202ef95164a9e68085058531ac441d9df79d
Author: Xin Xie <xiexinet@gmail.com>

net: hsr: fix packet drops caused by GRO superpackets

This commit fixes HSR/PRP packet drops by preventing lower devices from
aggregating frames into GRO super-packets. It adds dev_disable_gro() and
netif_disable_gro() functions and calls them during HSR port setup.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5933c5dab09ee..a6cf2adc86256 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -1840,6 +1840,24 @@ void netif_disable_lro(struct net_device *dev)
>  	}
>  }
>  
> +void netif_disable_gro(struct net_device *dev)
> +{
> +	struct net_device *lower_dev;
> +	struct list_head *iter;
> +
> +	dev->wanted_features &= ~(NETIF_F_GRO | NETIF_F_GRO_HW);

[Severity: High]
Does this one-time modification of wanted_features prevent userspace from
subsequently re-enabling GRO?

Since NETIF_F_GRO and NETIF_F_GRO_HW are not included in the
NETIF_F_UPPER_DISABLES macro definition in include/linux/netdev_features.h,
would netdev_sync_upper_features() and netdev_sync_lower_features() fail
to enforce the disabled state on lower devices during features recalculation?

Could an administrator run ethtool -K eth0 gro on (or add a new physical
device to an intermediate upper device already enslaved to HSR) to bypass
this restriction and cause the HSR packet drops to resurface?

> +	netdev_update_features(dev);
> +
> +	if (unlikely(dev->features & (NETIF_F_GRO | NETIF_F_GRO_HW)))
> +		netdev_WARN(dev, "failed to disable GRO!\n");
> +
> +	netdev_for_each_lower_dev(dev, lower_dev, iter) {
> +		netdev_lock_ops(lower_dev);
> +		netif_disable_gro(lower_dev);
> +		netdev_unlock_ops(lower_dev);
> +	}
> +}
