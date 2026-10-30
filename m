Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355340;
	b=iWNMOO72s63NZiKNMgLAT0jVuklVH1PrwcZaaInFKvxyaFZTq7h7Tl36xJ12MdrAL+Ha
	 788XvOkEkUL4R0YZkRCQnY7C6e0j+v9RsESnT0oSQObYB87OEK/GH6uFydfrY6kicsC7I
	 E/468hpESFCZCCnpZQVyLzlyUjqr6oeP6dF1jS0kciEHBJGqTm2SaSsfnqJZligDvHZ9u
	 WtluTJOv3Mt9DSmGcohB9mFQJwDryZtHikyMyPrsICXTdEhFRaqOYW30ixERINAosl72j
	 sDWZ7wGPGh1ndy++EZW0g+bSYamOBj8we3sJbZvC6b2jQMcfhpJJX0T17LOvMMBr9hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355340;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aa0b8U9AWDYiAQt4ZYGruRRnM7TUUsJIAn+bB9g1SLc=;
	b=0h1+afJ2wBykUsj1O5bmU7fzE+l2OjNymwrcFNqis/HFP1CqGDJ2eIxO6oWV73ZACP9m
	 BXKdU6B46OYlzbjrNewRLdAdwFq/l94JfxoxsXkGbFSV2ymZQpALrmFJfFepPJ0RMBxZ1
	 ExSdgL84ekR4WCLKlpxiivk8Q9MvTeUmVlQKxYJ5LTooZ/sKnxopHZZKhKQySHDyh6FHc
	 g1qL5NBWvxvfhq1zDld42vybSILUysU6i5A7edZ9NGfCW5ZrCpQQDTKBq3ppRUFAfRjhT
	 1itRew34BPgy/dZbfDoPJdTGp+JY6xSyHtGIp44WQ+HIOqd50q18pN6De/0/0mzt0tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMyQfuIf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDA7606A322;
	Fri, 30 Oct 2026 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMyQfuIf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603CC1F000C1;
	Fri, 30 Oct 2026 10:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793355340;
	bh=aa0b8U9AWDYiAQt4ZYGruRRnM7TUUsJIAn+bB9g1SLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OMyQfuIffZNfdarTlHyo40+MakJOzydRykiIPccZT8mS3haA2z6sDSJ5o8BA9wat2
	 Wy8UXE/wYttJcEmodR7NwZRyjcAdcW0hBRFeNQ0jw/hXXQc2zN6Ra8EgcSyJpIkImn
	 v3wIEC4IHvUt7D9Zj5VwsdbRY8U6mQj2Sg3ODRaRy7duJRZ/JyeY7a2YWMSC/NCnk7
	 JvEIgc0LEE9CSGWo0EiwJOre4HX/+awUJTSNEFduOztb4h5Com0yU0MIM+J71RFzSp
	 /TXStSSFfOYOMsuarDBLAODYzUAzLU1HABV8xl2Le75smMm6Ka3Ht+H7pA5DMzcM08
	 YeZqXEJT3XaMg==
Date: Fri, 30 Oct 2026 10:15:35 +0000
From: Simon Horman <horms@kernel.org>
To: Prasad Koya <prasad@arista.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] macvlan: fix allmulti reference counting in passthru
 mode
Message-ID: <20261030101535.GN257209@horms.kernel.org>
References: <20261027024635.366900-1-prasad@arista.com>
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
In-Reply-To: <20261027024635.366900-1-prasad@arista.com>

On Mon, Oct 26, 2026 at 07:46:35PM -0700, Prasad Koya wrote:
> Enabling allmulticast on a down passthru macvlan, bringing it up,
> then toggling allmulticast off and on can underflow the lower device's
> allmulti reference count.
> 
> macvlan_change_rx_flags() only propagates IFF_ALLMULTI changes while
> the macvlan is up. However, the passthru path in macvlan_open() skips
> taking an allmulti reference when IFF_ALLMULTI is already set.
> Clearing allmulticast after opening the device therefore decrements
> a reference that was never taken. With no other allmulti users, the
> unsigned counter wraps from zero to UINT_MAX. The next increment
> fails with -EOVERFLOW and reports "allmulti touches roof".
> 

Hi Prasad,

A Fixes tag should go here.
(No blank line between it and your Signed-off-by line).

There is no need to repost just to address this.
Replying with the Fixes tag should be sufficient.

> Signed-off-by: Prasad Koya <prasad@arista.com>
> ---
> Reproducer:
> 
>   #!/bin/bash
>   set -euo pipefail
> 
>   ns=allmulti-test
>   host=am-veth0
>   peer=am-veth1
>   mv=am-mv0
> 
>   cleanup()
>   {
>       ip netns del "$ns" 2>/dev/null || true
>   }
>   trap cleanup EXIT
> 
>   ip netns add "$ns"
>   ip link add "$host" type veth peer name "$peer"
>   ip link set "$peer" netns "$ns"
> 
>   ip link set "$host" up
>   ip -n "$ns" link set lo up
>   ip -n "$ns" link set "$peer" up
> 
>   ip -n "$ns" link add link "$peer" name "$mv" type macvlan mode passthru
> 
>   ip -n "$ns" link set dev "$mv" allmulticast on
>   ip -n "$ns" link set dev "$mv" up
>   ip -n "$ns" link set dev "$mv" allmulticast off
>   ip -n "$ns" link set dev "$mv" allmulticast on
> 
>  drivers/net/macvlan.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index afad90b9222a..e20d587453d1 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -643,6 +643,14 @@ static int macvlan_open(struct net_device *dev)
>  			if (err < 0)
>  				goto out;
>  		}
> +		if (dev->flags & IFF_ALLMULTI) {
> +			err = dev_set_allmulti(lowerdev, 1);
> +			if (err < 0) {
> +				if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC))
> +					dev_set_promiscuity(lowerdev, -1);
> +				goto out;
> +			}
> +		}
>  		goto hash_add;
>  	}
>  
> @@ -713,6 +721,8 @@ static int macvlan_stop(struct net_device *dev)
>  	dev_mc_unsync(lowerdev, dev);
>  
>  	if (macvlan_passthru(vlan->port)) {
> +		if (dev->flags & IFF_ALLMULTI)
> +			dev_set_allmulti(lowerdev, -1);
>  		if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC))
>  			dev_set_promiscuity(lowerdev, -1);
>  		goto hash_del;
> 
> base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
> -- 
> 2.43.0
> 

I'm unsure if it matters, but the order of initialisation of multicast and
promiscuity differs here from the non-pass-through case.

Overall I think the approach you have taken here is appropriate
as a minimal fix for net.

Reviewed-by: Simon Horman <horms@kernel.org>


But I do see that there is growing duplication of code in the
pass-through and non-pass-through paths. And I believe that
is due to the approach taken by the existing code of using
goto to control flow (other than for cleanup in error paths).

In the longer term I think it would be nice to address that.
I took a stab at that. Perhaps I'm overthinking things.
But, FWIIW, this is what I cam up with (compile tested only).

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index a48c9e662fe9..f2a3cf540e4e 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -631,24 +631,31 @@ static const struct header_ops macvlan_hard_header_ops = {
 	.parse_protocol	= eth_header_parse_protocol,
 };
 
-static int macvlan_open(struct net_device *dev)
+static int macvlan_should_set_promisc(struct net_device *dev)
 {
 	struct macvlan_dev *vlan = netdev_priv(dev);
-	struct net_device *lowerdev = vlan->lowerdev;
-	int err;
 
-	if (macvlan_passthru(vlan->port)) {
-		if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC)) {
-			err = dev_set_promiscuity(lowerdev, 1);
-			if (err < 0)
-				goto out;
-		}
-		goto hash_add;
-	}
+	if (macvlan_passthru(vlan->port))
+		return !(vlan->flags & MACVLAN_FLAG_NOPROMISC);
+
+	return dev->flags & IFF_PROMISC;
+}
+
+/* Initialise acceleration or add unicast address.
+ * Skipped for pass-through ports.
+ */
+static int macvlan_init_vlan(struct net_device *dev)
+{
+	struct macvlan_dev *vlan = netdev_priv(dev);
+	struct net_device *lowerdev;
+
+	if (macvlan_passthru(vlan->port))
+		return 0;
 
-	err = -EADDRINUSE;
 	if (macvlan_addr_busy(vlan->port, dev->dev_addr))
-		goto out;
+		return -EADDRINUSE;
+
+	lowerdev = vlan->lowerdev;
 
 	/* Attempt to populate accel_priv which is used to offload the L2
 	 * forwarding requests for unicast packets.
@@ -661,40 +668,71 @@ static int macvlan_open(struct net_device *dev)
 	 * populated we must add the unicast address to the lower device.
 	 */
 	if (IS_ERR_OR_NULL(vlan->accel_priv)) {
+		int err;
+
 		vlan->accel_priv = NULL;
 		err = dev_uc_add(lowerdev, dev->dev_addr);
 		if (err < 0)
-			goto out;
+			return err;
+	}
+
+	return 0;
+}
+
+/* Clean up acceleration or remove unicast address.
+ * Skipped for pass-through ports.
+ */
+static void macvlan_uninit_vlan(struct net_device *dev)
+{
+	struct macvlan_dev *vlan = netdev_priv(dev);
+	struct net_device *lowerdev;
+
+	if (macvlan_passthru(vlan->port))
+		return;
+
+	lowerdev = vlan->lowerdev;
+
+	if (vlan->accel_priv) {
+		lowerdev->netdev_ops->ndo_dfwd_del_station(lowerdev,
+							   vlan->accel_priv);
+		vlan->accel_priv = NULL;
+	} else {
+		dev_uc_del(lowerdev, dev->dev_addr);
 	}
+}
+
+static int macvlan_open(struct net_device *dev)
+{
+	struct macvlan_dev *vlan = netdev_priv(dev);
+	struct net_device *lowerdev;
+	int err;
+
+	err = macvlan_init_vlan(dev);
+	if (err)
+		return err;
+
+	lowerdev = vlan->lowerdev;
 
 	if (dev->flags & IFF_ALLMULTI) {
 		err = dev_set_allmulti(lowerdev, 1);
 		if (err < 0)
-			goto del_unicast;
+			goto uninit;
 	}
 
-	if (dev->flags & IFF_PROMISC) {
+	if (macvlan_should_set_promisc(dev)) {
 		err = dev_set_promiscuity(lowerdev, 1);
 		if (err < 0)
 			goto clear_multi;
 	}
 
-hash_add:
 	macvlan_hash_add(vlan);
 	return 0;
 
 clear_multi:
 	if (dev->flags & IFF_ALLMULTI)
 		dev_set_allmulti(lowerdev, -1);
-del_unicast:
-	if (vlan->accel_priv) {
-		lowerdev->netdev_ops->ndo_dfwd_del_station(lowerdev,
-							   vlan->accel_priv);
-		vlan->accel_priv = NULL;
-	} else {
-		dev_uc_del(lowerdev, dev->dev_addr);
-	}
-out:
+uninit:
+	macvlan_uninit_vlan(dev);
 	return err;
 }
 
@@ -712,21 +750,15 @@ static int macvlan_stop(struct net_device *dev)
 	dev_uc_unsync(lowerdev, dev);
 	dev_mc_unsync(lowerdev, dev);
 
-	if (macvlan_passthru(vlan->port)) {
-		if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC))
-			dev_set_promiscuity(lowerdev, -1);
-		goto hash_del;
-	}
-
 	if (dev->flags & IFF_ALLMULTI)
 		dev_set_allmulti(lowerdev, -1);
 
-	if (dev->flags & IFF_PROMISC)
+	if (macvlan_should_set_promisc(dev))
 		dev_set_promiscuity(lowerdev, -1);
 
-	dev_uc_del(lowerdev, dev->dev_addr);
+	if (!macvlan_passthru(vlan->port))
+		dev_uc_del(lowerdev, dev->dev_addr);
 
-hash_del:
 	macvlan_hash_del(vlan, !dev->dismantle);
 	return 0;
 }
