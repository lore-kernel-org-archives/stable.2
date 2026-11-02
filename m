Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611446;
	b=BM9C7Xsg/oBv1q99Fl1VWG+uoo7MD9KYVJp1yU5Bi2h8/0OKXFzVQClfwqQ7moS5/cL8
	 DB6cWoE3BNu1VWSdbXqj2SOcvkdMZQ6qpPiEskNwVSACXdMeIPQRNv2z7W9UQt/XsWWJE
	 JzliCrHnqlblVUqzLuDD2QmK2F4OQdnLue+FzSvOuVhUx4zuW/zJ1AYCmAzv98k0wFZU9
	 9YhwrK2wTNaNCwojFWue7KRJuYI1QHXcSPWv/9AwXYgfN6LTBQlbOeTTmlEEfUe3UylRu
	 cGb0/J5s0zoWqg5ymHwpmSF1sRjNkvlTYsPqccUek2dHpMoB4J3Muy2uKfV5wrlYs3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611446;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=q51vHxMxEQ7qEvCAkwbK9TAnlzASfnxBqGB+hxgHUnA=;
	b=Lk3abaAzosL0PQUokEaJfIV8Q0XVBa+UGG2JQzPCKdZ8pKgmgFdAjIxPirttgerTvqhK
	 SqN/OPBN++qb4JKyXtUHkm55dJJA/Q8acsz56ZknGbFoR1/ZldDEpQ5mzgq3pBwk9tCxl
	 pQ3qsIZ0UEA9WevGXXrKGif0KXoAqsBSgLUuPbWWijU4UczMyGnRPunoJ5sEazDemwCAT
	 bZqlAwg3yMgR8fVg5MHXJ6Mbol45nhJDIAGxKi47kG+xeagqsYsThugWZ57FdvKnjbPQ6
	 C4TkJN2twPP1gG7PADcIVHhuncqhfsrRaE72tCDG+TmqXQVT34PG2eJakrF44PQuj0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEZWMNGT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20626606A326;
	Mon,  2 Nov 2026 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEZWMNGT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFC91F0093A;
	Mon,  2 Nov 2026 09:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611445;
	bh=q51vHxMxEQ7qEvCAkwbK9TAnlzASfnxBqGB+hxgHUnA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lEZWMNGTpJEbVKc4ca/IXjPjnZTgmavAnb3vLIAWSEiYv+XSg7Nx0v7ieKbJ/CFeg
	 CiNx0hToBYkba0cAYr4KAkrLrtq0Le9h4zMr98GI7pMO0a7Ze3k6uId74HI7PY/zRq
	 E2+j4sQ8umVURhKAt/oWHp0CNJN43RiTX+/FoCeAAkmouX8aGbj6y4ZCdrlNTgGNYW
	 M/udmp2cip6JqY2rF65DQFVS8yuB7uJlL8eV185mBSufOAu4Pief1tPCrGmXgnDZCk
	 0Dz8YNXXi+f7ru/UxoLjbNrBtSFmtNoAGMBfR1xJYdl0WFgaIJWwDG5nMv57Ti28bC
	 agy38idv4TzkQ==
Subject:
 Re: [PATCH] ieee802154: nl-mac: validate device pointers before dereference
From: netdev-bot+sashiko@kernel.org
To: skalpesh942@gmail.com
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com, stable@vger.kernel.org
Date: Mon, 02 Nov 2026 09:24:04 +0000
Message-ID: <179361144464.3131.14276986600550347612@kernel.org>
In-Reply-To: <20261101092219.1278751-1-skalpesh942@gmail.com>
References: <20261101092219.1278751-1-skalpesh942@gmail.com>
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

Critical: 0 · High: 1 (2) · Medium: 0 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete within the same legacy IEEE802154
  genetlink family.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but several non-
  netlink IEEE 802.15.4 paths also treat `dev->type ==…
- [High] This problem wasn't introduced by this patch, but
  ieee802154_dump_iface() and ieee802154_llsec_dump_table() walk…
- [Medium] This problem wasn't introduced by this patch, but
  ieee802154_llsec_dump_table() never saves its intra-table resume…
- [Medium] This problem wasn't introduced by this patch, but
  llsec_iter_devkeys() (net/ieee802154/nl-mac.c:1185-1206) resets the…

--

ieee802154: nl-mac: validate device pointers before dereference

This patch adds checks for a NULL dev->ieee802154_ptr and a NULL
ieee802154_mlme_ops(dev) in ieee802154_nl_get_dev(),
ieee802154_dump_iface() and ieee802154_llsec_dump_table(). It is meant to
stop crashes on devices such as TUN interfaces whose link type was set to
ARPHRD_IEEE802154 with TUNSETLINK.

> diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
> index 74ef0a310afbb..1acde5af4b564 100644
> --- a/net/ieee802154/nl-mac.c
> +++ b/net/ieee802154/nl-mac.c
> @@ -162,7 +162,8 @@ static struct net_device *ieee802154_nl_get_dev(struct genl_info *info)
>  	if (!dev)
>  		return NULL;
>  
> -	if (dev->type != ARPHRD_IEEE802154) {
> +	if (dev->type != ARPHRD_IEEE802154 || !dev->ieee802154_ptr ||
> +	    !ieee802154_mlme_ops(dev)) {
>  		dev_put(dev);
>  		return NULL;
>  	}

[Severity: High]
Can the IEEE802154_DEL_IFACE handler still hit the same crash?

ieee802154_del_iface() in net/ieee802154/nl-phy.c is registered in the
same nl802154_family. It does not go through ieee802154_nl_get_dev().
It looks the device up with dev_get_by_name() and only checks the link
type:

net/ieee802154/nl-phy.c:ieee802154_del_iface() {
    ...
	dev = dev_get_by_name(genl_info_net(info), name);
	if (!dev)
		return rc;
	if (dev->type != ARPHRD_IEEE802154)
		goto out;

	phy = dev->ieee802154_ptr->wpan_phy;
	BUG_ON(!phy);
    ...
}

Take the TUN setup from the commit message (TUNSETLINK to
ARPHRD_IEEE802154 while the interface is down). An IEEE802154_DEL_IFACE
request with IEEE802154_ATTR_DEV_NAME set to the TUN name would pass the
type check and then dereference a NULL dev->ieee802154_ptr.

This op uses GENL_ADMIN_PERM, the same privilege needed for the
IEEE802154_LLSEC_LIST_KEY dump fixed here. Should ieee802154_del_iface()
get the same check?

[Severity: High]
This is a pre-existing issue, but several non-netlink 802.15.4 paths
also assume that dev->type == ARPHRD_IEEE802154 means
dev->ieee802154_ptr is valid. Would they crash with the same TUN device?

In net/ieee802154/socket.c, the short-address branch of
ieee802154_get_dev() does this. It is reachable from dgram_bind() and
dgram_sendmsg() on an unprivileged SOCK_DGRAM socket:

	for_each_netdev(net, tmp) {
		if (tmp->type != ARPHRD_IEEE802154)
			continue;

		pan_id = tmp->ieee802154_ptr->pan_id;

On an unbound socket, dgram_sendmsg() calls
dev_getfirstbyhwtype(sock_net(sk), ARPHRD_IEEE802154), which can return
the TUN device. That device is then passed to wpan_dev_hard_header():

	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;

	return wpan_dev->ops->header_create(skb, dev, daddr, saddr, len);

On receive, a frame written into the TUN with ETH_P_IEEE802154 goes
through ieee802154_rcv() -> ieee802154_dgram_deliver(), which reads:

	pan_id = dev->ieee802154_ptr->pan_id;
	short_addr = dev->ieee802154_ptr->short_addr;
	hw_addr = dev->ieee802154_ptr->extended_addr;

lowpan_rcv() in net/ieee802154/6lowpan/rx.c also checks only the type
before doing this:

	ldev = wdev->ieee802154_ptr->lowpan_dev;

It has no init_net restriction. Once any 6LoWPAN interface on the host
is up, a TUN in another network namespace could reach it.

ieee802154_dev_ioctl() and 6lowpan/core.c already allow for a NULL
ieee802154_ptr. Should these other sites check for it too?

> @@ -437,7 +438,8 @@ int ieee802154_dump_iface(struct sk_buff *skb, struct netlink_callback *cb)
>  
>  	idx = 0;
>  	for_each_netdev(net, dev) {
> -		if (idx < s_idx || dev->type != ARPHRD_IEEE802154)
> +		if (idx < s_idx || dev->type != ARPHRD_IEEE802154 ||
> +		    !dev->ieee802154_ptr || !ieee802154_mlme_ops(dev))
>  			goto cont;
>  
>  		if (ieee802154_nl_fill_iface(skb, NETLINK_CB(cb->skb).portid,

[Severity: High]
This isn't a bug introduced by this patch, but what keeps dev alive
during this walk? ieee802154_dump_iface() and
ieee802154_llsec_dump_table() loop with plain for_each_netdev(). They
hold no RTNL and no rcu_read_lock(), and take no dev_hold() on the
current device.

genl_dumpit() only takes genl_lock around the dump, because
nl802154_family has no parallel_ops. That lock does not serialize
against netdev unregistration.

The caller can't hold RTNL here either, because
ieee802154_nl_fill_iface() takes and drops it itself:

	rtnl_lock();
	short_addr = dev->ieee802154_ptr->short_addr;
	pan_id = dev->ieee802154_ptr->pan_id;
	rtnl_unlock();

RCU would not cover the llsec path, because llsec->lock_table() takes a
mutex.

Suppose the wpan interface is unregistered at the same time (ip link
del, or ieee802154_unregister_hw()). Can free_netdev() finish while the
dump is still using dev or following dev->dev_list.next?

IEEE802154_LIST_IFACE does not require GENL_ADMIN_PERM. The new
dev->ieee802154_ptr and ml_priv reads added here are part of the same
unprotected walk.

> @@ -771,7 +773,8 @@ ieee802154_llsec_dump_table(struct sk_buff *skb, struct netlink_callback *cb,
>  	int rc;
>  
>  	for_each_netdev(net, dev) {
> -		if (idx < first_dev || dev->type != ARPHRD_IEEE802154)
> +		if (idx < first_dev || dev->type != ARPHRD_IEEE802154 ||
> +		    !dev->ieee802154_ptr || !ieee802154_mlme_ops(dev))
>  			goto skip;
>  
>  		data.ops = ieee802154_mlme_ops(dev);

[Severity: Medium]
This is a pre-existing issue, but does ieee802154_llsec_dump_table()
lose its place inside a table when the skb fills up?

Further down, the function loads its cursors from cb->args:

		data.s_idx = cb->args[1];
		data.s_idx2 = cb->args[2];

The step iterators, such as llsec_iter_keys(), only advance
data->s_idx. On -EMSGSIZE the loop breaks before idx++, and only the
interface index is saved:

	cb->args[0] = idx;

Nothing in nl-mac.c writes cb->args[1] or cb->args[2]. The next
callback picks the same interface and starts its table again from
index 0.

If one interface's key, device, devkey or seclevel table doesn't fit in
a single dump skb, could IEEE802154_LLSEC_LIST_KEY and the other llsec
dumps repeat the same records forever? Smaller overflows would give
duplicate records.

[Severity: Medium]
This is also a pre-existing issue, but llsec_iter_devkeys() seems to
skip device keys. It is reached through
ieee802154_llsec_dump_devkeys() -> ieee802154_llsec_dump_table():

	list_for_each_entry(dpos, &data->table->devices, list) {
		if (idx++ < data->s_idx)
			continue;

		idx2 = 0;

		list_for_each_entry(kpos, &dpos->keys, list) {
			if (idx2++ < data->s_idx2)
				continue;
			...
			data->s_idx2++;
		}

		data->s_idx++;
	}

idx2 is reset for each device, but data->s_idx2 is not. Once the first
device has emitted k keys, would the first k keys of every later device
be skipped?

The iterator still returns 0, so those devkeys would be missing from
the IEEE802154_LLSEC_LIST_DEVKEY output even when the buffer has room.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101092219.1278751-1-skalpesh942%40gmail.com
