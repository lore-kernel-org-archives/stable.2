Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA2B19DF6A;
	Sat, 27 Jun 2026 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782540952; cv=none; b=REBCxF/GOLrQ9a3Xuw9ibKDn5bE1Q8GOXwaCWpJdt55zHO2cKsuDovgCXh5voBbYUm+CWfiQoxmYeA/vMsG7gFqJ9bmLHX8CXEe6zGTjYFh4MJmGfKSxshoIQvAkLkMkt5sdtIZr2V4D0mlOaNrAjJUrR7l+VjbZWORALcoM+PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782540952; c=relaxed/simple;
	bh=JE3z79lH90+PE45QQqvUptcXYf6awokU2Z8AazF4zOY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Xh00MbcSxZPzbLIRJ7GdO6EyLhTIi8G8b1fpLs/NrqpDo4Gln4O8HSeUQG9HqqJYyRwHrGh7SZL2Ewd1Rr97MhaXP5V6mI3Jajb6m7hLiL7FGI4OFtNuRcU49FnP8lFBkQEmuFP5eOYOPjM0guZ9RZqlpb/ScXnyX2Y2K/jJuvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=sAWmU36a; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="sAWmU36a"
Received: by dvalin.narfation.org (Postfix) id 7A8A1200EE;
	Sat, 27 Jun 2026 06:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782540948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTnTXdmwCpBP9MGpNP6k1YurftJlpFzAka6dFJ0LeYA=;
	b=sAWmU36amAfhjR/5+VrneCRAta4Wfa34bjUHP62uFr6yrx2ADGOwIWkGMNHBVUA6IvE6Zk
	839Yru0QXGuGwmKWRFCaed2l9TMIiv0klalgsIjNFpn4dx+De495sE51SsqlWgbfQgn5RS
	TKbHVFdKEK1IvZJHPc7vV/WB2hWDySA=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] fix: net/batman-adv: batadv_interface_kill_vid: extra
 batadv_meshif_vlan_put after destroy
From: Sven Eckelmann <sven@narfation.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com, 
 sven@narfation.org, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260627034636.59693-1-vulab@iscas.ac.cn>
References: <20260627034636.59693-1-vulab@iscas.ac.cn>
Date: Sat, 27 Jun 2026 08:15:20 +0200
Message-Id: <178254092045.4739.1497464106445743950.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6296; i=sven@narfation.org;
 h=from:subject:message-id; bh=JE3z79lH90+PE45QQqvUptcXYf6awokU2Z8AazF4zOY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFn2WTUSdy5vMxL397p3+cCGCdfnTglpMDsmvvFS6a6HB
 Us0rxdpdpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmkqbKyNB+Wucq99ZvxVxz
 F2/iOG5wY9E2NpatEcdcb/iGnqjf8FqD4b/fYQdpQ36F4zyLH/vmiJ+Rkxdfy/WevyHMh3OH74p
 nMUwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

On Sat, 27 Jun 2026 11:46:36 +0800, WenTao Liang <vulab@iscas.ac.cn> wrote:

Hi,

not-acked

1. please don't send patches to netdev directly. See (from any recent
   batadv.git, netdev/net.git netdev/net-next.git or torvalds/linux.git):

    $ ./scripts/get_maintainer.pl 20260627034636.59693-1-vulab@iscas.ac.cn.mbx 
    Marek Lindner <marek.lindner@mailbox.org> (maintainer:BATMAN ADVANCED,blamed_fixes:1/1=100%)
    Simon Wunderlich <sw@simonwunderlich.de> (maintainer:BATMAN ADVANCED)
    Antonio Quartulli <antonio@mandelbit.com> (maintainer:BATMAN ADVANCED,blamed_fixes:1/1=100%)
    Sven Eckelmann <sven@narfation.org> (maintainer:BATMAN ADVANCED)
    b.a.t.m.a.n@lists.open-mesh.org (moderated list:BATMAN ADVANCED)
    linux-kernel@vger.kernel.org (open list)

2. please add after the "PATCH" the tree which it should enter (in this case
   "[PATCH batadv]". See: 

    ./scripts/get_maintainer.pl --scm 20260627034636.59693-1-vulab@iscas.ac.cn.mbx|grep '^git'           
    git https://git.open-mesh.org/batadv.git
    git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

3. Please use a subject line which follows the kernel style. See
   https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-formatA

   - no "fix: "
   - "batman-adv: " instead of "net/batman-adv: "
   - most likely no "batadv_interface_kill_vid: "
   - an actual summary of your change (because right now it says it adds(?) an extra put)

> In batadv_interface_kill_vid(), batadv_meshif_vlan_get() acquires a
> reference on the vlan object. batadv_meshif_destroy_vlan() internally
> calls batadv_meshif_vlan_put() which balances that reference. However, an

No, this doesn't balance the reference. The reference put in this function is
for the reference acquired by this function. The batadv_meshif_destroy_vlan()
put is for the reference for its "from .ndo_vlan_rx_add_vid till 
.ndo_vlan_rx_kill_vid" lifetime.

You can see exactly the same approach also in batadv_meshif_destroy_netlink()
for its "untagged" vlan. A function which you didn't touch.

> additional batadv_meshif_vlan_put(vlan) is called after
> batadv_meshif_destroy_vlan(), causing a refcount underflow and potential
> use-after-free of the vlan object.

No, doesn't cause an underflow in my setup. Please explain exactly how you
tested this and came the conclusion that this would cause a use-after-free.
Because I can't reproduce this and the patch in this form is causing a memory
leak for me.

> 
> Remove the extra batadv_meshif_vlan_put(vlan) call.

No, this can't be the correct solution.

>
>
> diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
> index e5a55d24..7a1aeeca 100644
> --- a/net/batman-adv/mesh-interface.c
> +++ b/net/batman-adv/mesh-interface.c
> @@ -693,9 +693,6 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
>  
>  	batadv_meshif_destroy_vlan(bat_priv, vlan);
>  
> -	/* finally free the vlan object */
> -	batadv_meshif_vlan_put(vlan);
> -

This looks wrong to me. Now it leaks the VLAN which was acquired at the
beginning of the function. When I add a kref_get-printk right before the
batadv_meshif_destroy_vlan() and in batadv_tt_local_entry_release() before the
puts:

    refcnt before batadv_meshif_destroy_vlan: 3
    refcnt after batadv_meshif_destroy_vlan: 2
    refcnt before batadv_tt_local_entry_release: 2
    refcnt after batadv_tt_local_entry_release: 1

As you can see, now the VLAN never reaches the 0 and thus isn't free'd. You can
also directly see the memory leak (which didn't happen before):

    root@node01:~# ip l del dev bat0.10
    [   18.127153][  T368] refcnt before batadv_meshif_destroy_vlan: 3
    [   18.128792][  T368] refcnt after batadv_meshif_destroy_vlan: 2
    [   18.649318][   T12] refcnt before batadv_tt_local_entry_release: 2
    [   18.650220][   T12] refcnt after batadv_tt_local_entry_release: 1
    root@node01:~# rmmod batman-adv
    [   27.033891][  T374] batman_adv: bat0: Interface deactivated: dummy0
    [   27.034522][  T374] batman_adv: bat0: Removing interface: dummy0
    [   27.038340][  T374] batman_adv: bat0: Interface deactivated: enp0s1
    [   27.038973][  T374] batman_adv: bat0: Removing interface: enp0s1
    [   27.044439][  T374] br0: port 1(bat0) entered disabled state
    [   27.049110][  T374] bat0 (unregistering): left allmulticast mode
    [   27.049486][  T374] bat0 (unregistering): left promiscuous mode
    [   27.049804][  T374] br0: port 1(bat0) entered disabled state
    [   27.096326][  T374] refcnt before batadv_tt_local_entry_release: 1
    [   27.096851][  T374] refcnt after batadv_tt_local_entry_release: 0
    root@node01:~# modprobe batman-adv 
    root@node01:~# echo scan > /sys/kernel/debug/kmemleak
    root@node01:~# echo scan > /sys/kernel/debug/kmemleak
    [   41.460324][  T361] kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
    root@node01:~# cat /sys/kernel/debug/kmemleak
    unreferenced object 0xffff88800ab1bd00 (size 64):
      comm "ip", pid 300, jiffies 4294893634
      hex dump (first 32 bytes):
        c0 cb c7 13 80 88 ff ff 0a 80 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      backtrace (crc 552e6e51):
        kmemleak_alloc+0x55/0xa0
        __kmalloc_cache_noprof+0x2f4/0x540
        batadv_meshif_create_vlan+0x7c/0x450 [batman_adv]
        batadv_interface_add_vid+0xb6/0xd0 [batman_adv]
        vlan_add_rx_filter_info+0xee/0x160
        vlan_vid_add+0x2f6/0x910
        register_vlan_dev+0xc5/0x6f0
        vlan_newlink+0x40e/0x6f0
        rtnl_newlink_create+0x2e1/0x770
        __rtnl_newlink+0x20b/0x9d0
        rtnl_newlink+0x7f7/0xf90
        rtnetlink_rcv_msg+0x811/0xbf0
        netlink_rcv_skb+0x148/0x3f0
        rtnetlink_rcv+0x19/0x20
        netlink_unicast+0x5fc/0xa50
        netlink_sendmsg+0x82b/0xd70

Because of the errors this patch introduces and the form of the patch: will not
be applied in batadv.git

We can discuss an actual fix when you can explain us how this problem can
actually be reproduced.

-- 
Sven Eckelmann <sven@narfation.org>
