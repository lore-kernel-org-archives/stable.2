Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564611;
	b=yYSMjBka4amjkGnmJtJm5STC0S+1DMFHupe0UHbpY4L2BWza+FtC42L/7HJXIYV14SOw
	 kWURWjUQ2FU27ucLby04hJ1Hp+MpWv6+GtYkrT9MN98216Q31SnYG2kzF2ATyxvYNEon/
	 Tr/ssZ1T9rnnXxgsrgo5jvw25+qGE8Fb0j2bVY7asQOu/+GfpHT1vrYl2XaaPyRYmuiaj
	 7DLrQMHNCbKzyhhEykQOofIy5eyR84FZYXrF/UfSIws+6i+9guuPxN1eeiytDF8erVWng
	 HEmse0jf/ztGQng2g20450v0c2JyHT+J31GRwpszTQ0X3BLZaiNmchpPwyJIl90v5gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564611;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=q4Bwqwgc7+5Gx59AnjvrJulXRRk7CHLTbvvAvvNTNLQ=;
	b=Yuo6JHUC43IHZWH9sjtz8h7F7DebDXOtwFlwlyeqGpwlL2l7/8uPDD5KR4KMqEdyKxPx
	 MmwOrFHGmdoBdRiBCZRF8eMs5XQRMqGvZQV0hW+AlogP6L6cS7WDCGF/1z9E+JcMXNRPI
	 VOM29NXAwS3Wi8gpWgPTe+heALc9LQ1Xj+wNBNHZuirzwTJ0EHKk6+4mC2AouyN01Ddgn
	 HG1dArFJcS9hK5sq7rXPmOTrPMCjxwM+tqw0AVGQ56tJ85D82LsJyYAr3JYNnFvXgOOr4
	 ga1CAgYe/IRlN07fJi9XKDfxN5lU1fe3AuhP8c5VWgIJeWxRfqejQlLuZj+31ymnWLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFjdvIVC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3731606A323;
	Tue, 24 Nov 2026 23:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFjdvIVC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D121F000C6;
	Tue, 24 Nov 2026 23:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795564610;
	bh=q4Bwqwgc7+5Gx59AnjvrJulXRRk7CHLTbvvAvvNTNLQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NFjdvIVCM7ay5+dOJbZLpvgqUBR77DaGw6h1NVPXeEqyjPzUl9o5rfe1rP7qFTf5j
	 KO4LSmYqmjJWVCQbD47TXukfre/AO2eHk6Fj//yqV3cAspEALk1fsHAWxgPhup2pyJ
	 MwJi/BcPBGx0OiBSj0ChVy4cLcfydZlLt0KjfT68uOi5xDb6Pi4tGflNxheZ6rZB5u
	 REGjLWCPtXWEgy4X9eotvV3Jk6Hjl8B9b6TUsxP5c+Qbrb+Dr6Mh2qynMWMBTaPUlI
	 GQv3sgShivg5t6Uo+iss+TjBt3CMHMxGrPm5iTTrjtanuNNtqV1b9qyKaWY4agW3XY
	 50tl/3j05sNAw==
Subject: Re: [PATCH v2 net 1/2] net/ncsi: add missing rcu_read_lock to netlink
 and device list walks
From: netdev-bot+sashiko@kernel.org
To: tristmd@gmail.com
Cc: sam@mendozajonas.com, fercerpav@gmail.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 tristan@talencesecurity.com
Date: Tue, 24 Nov 2026 23:56:49 +0000
Message-ID: <179556460945.3135.15659166746585133239@kernel.org>
In-Reply-To: <20261120235407.1911365-2-tristmd@gmail.com>
References: <20261120235407.1911365-2-tristmd@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new RCU section in ncsi_find_dev() ends before the pointer
  it found is used.

--

net/ncsi: add missing rcu_read_lock to netlink and device list walks

This commit adds rcu_read_lock()/rcu_read_unlock() around the
NCSI_FOR_EACH_* list walks in ncsi_find_dev(), ncsi_write_package_info()
and ncsi_pkg_info_all_nl(). It also turns the early returns in
ncsi_write_package_info() into a goto so there is a single unlock point.

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 1d63958c4429b..ec7c0d8cf3d9f 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -419,13 +419,18 @@ void ncsi_free_request(struct ncsi_request *nr)
>  struct ncsi_dev *ncsi_find_dev(struct net_device *dev)
>  {
>  	struct ncsi_dev_priv *ndp;
> +	struct ncsi_dev *nd = NULL;
>  
> +	rcu_read_lock();
>  	NCSI_FOR_EACH_DEV(ndp) {
> -		if (ndp->ndev.dev == dev)
> -			return &ndp->ndev;
> +		if (ndp->ndev.dev == dev) {
> +			nd = &ndp->ndev;
> +			break;
> +		}
>  	}
> +	rcu_read_unlock();
>  
> -	return NULL;
> +	return nd;
>  }

[Severity: High]
Is ndp still used after this RCU section ends?

ncsi_find_dev() drops the RCU read lock before it returns &ndp->ndev.
ndp_from_ifindex() then drops the netdev reference too:

net/ncsi/ncsi-netlink.c:ndp_from_ifindex() {
    ...
	nd = ncsi_find_dev(dev);
	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;

	dev_put(dev);
	return ndp;
}

As a result, the NCSI_CMD_PKG_INFO doit handler, which unprivileged users
can call, uses ndp without holding a reference and outside any RCU
read-side section:

ncsi_pkg_info_nl()
  ndp_from_ifindex()
    ncsi_find_dev()                 <- rcu_read_unlock()
  genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL)   <- may sleep
  ncsi_write_package_info(skb, ndp, package_id)
    reads ndp->package_num / ndp->ndev.dev before rcu_read_lock()
    NCSI_FOR_EACH_PACKAGE(ndp, np)  <- list head embedded in ndp

ncsi_pkg_info_all_nl() follows the same pattern. It gets ndp from
ndp_from_ifindex(), walks ndp->packages, and then calls
ncsi_write_package_info(skb, ndp, package_id).

On the free side, ftgmac100_remove()->ncsi_unregister_dev() does:

	spin_lock_irqsave(&ncsi_dev_lock, flags);
	list_del_rcu(&ndp->node);
	spin_unlock_irqrestore(&ncsi_dev_lock, flags);

	disable_work_sync(&ndp->work);

	kfree(ndp);

Can ndp be freed while ncsi_pkg_info_nl() or ncsi_pkg_info_all_nl() is
still using it?

The follow-up patch "net/ncsi: defer free of removed list entries to an
RCU grace period" changes this to kfree_rcu_mightsleep(ndp). Even so, the
grace period can end between the rcu_read_unlock() in ncsi_find_dev() and
the next rcu_read_lock() in ncsi_write_package_info(). The sleeping
genlmsg_new() call sits inside that gap.

The netdev reference can't pin ndp either. ftgmac100_remove() unregisters
NCSI before it unregisters the netdev:

	if (priv->ndev)
		ncsi_unregister_dev(priv->ndev);
	unregister_netdev(netdev);

The commit message says these walks race with ncsi_unregister_dev(). Is
that race still open through the ndp pointer that ncsi_find_dev()
returns? The follow-up patch doesn't change ncsi_find_dev(),
ndp_from_ifindex() or the netlink handlers, so the issue seems to remain
after the full series.

Would this need either a reference count on ndp, or one RCU section that
covers every use of ndp in the handlers, with the sleeping allocation
moved out of it?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120235407.1911365-1-tristmd%40gmail.com
