Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737B4282F2C;
	Mon,  3 Aug 2026 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767672; cv=none; b=q3cKiZ6sdXt9kPnDFw7p5XYt+Cp/q1GHQan+stH25V7KzJ3CCOvCUdZhnfooSo6T38FHVt4bGTkqgWQa74nfw/mK+oM71BClR26HmPKjnKFK1OjwNsMQ1qilAzDEF4tOpwVu9TydJbOIEXQ5m2kLXbRlFhsK2+uzLU+0J1iaM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767672; c=relaxed/simple;
	bh=dgXL7EclvxUzTsdRjAELK6xM2qk3/dqJevuuRYv5ViI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWXp31Dq+6OMlkBGnESwlVh7e3HdA0ZYtUVy7LBSC086rF0Zp+OE1eaiQGZlOOZ0itD1SyXGCmi1D0pYcCkyQ1aILKYjtsVve5ZP05AxiDMhWntdb96l9J4xiW3CGvwXbrLtuxoZw61AKPN+Z5zu0HtUiC2wGcTMvSJQFRl+Wy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=af3HzQ4C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eVf/ArUc; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="af3HzQ4C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eVf/ArUc"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A52D21D0002F;
	Mon,  3 Aug 2026 10:34:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 03 Aug 2026 10:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1785767669; x=
	1785854069; bh=/HL477DpRvkCc1I8LrhiaXUWEYeTj9gOFeomcYsjHuo=; b=a
	f3HzQ4C2geLQwgRaJkIv4GAJoSc5vNMQDFe3C51nVm9TrD6YWZ8Pht5roVuNazPT
	I6UsJo2gFh2F1DKALMYl1XDTGaS/vCYi1vXCMcdH5aq9ktlq9E1NOSW/etoSS5hD
	zze7IJVDphkgKmeG0kcco08mO3kIrH5DQK8n36LmFVER+Eblx0/tA2UNUHukSuUb
	g+j+aEmhZXCS9n7MDoyaWPX/bRxx940T9zD2kqc+SM6th528BzS/DQarppL1sG/S
	p6Jhh2gbvQWyAy3e/wnqf1jplZAbvm3cdHy4270ylecwIu/683hnQrwjHS4qmspJ
	+suRXci2u58+6A/8gpYVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785767669; x=1785854069; bh=/HL477DpRvkCc1I8LrhiaXUWEYeTj9gOFeo
	mcYsjHuo=; b=eVf/ArUcVIJm4FEQXWHjey7Aes5M9INXSC5NntntKU9bLunJ2u+
	djBtrVe4fMva9j/rmdPJVJYvjnxP5A4gFssWEnsX6YWfbjI9p1lWfxOPi3Ww31oE
	WzNuZKPsKds3cvQEJTWu9n9/QRYZv65qPP+0pKz1GZG8uKsJyIHAXr7GSZguk8jS
	OtvZFxyAJdX6ARth3UjJPg5LPDqBcMx6BDUhMfcN9JoNGc7xehl546SM7S81xP/+
	T3JvVO4zRrvHrj2jCwuM9epa4GrQIvM+bAbV773Zu5yuC4U28YxKH0VZNWsDnC9m
	jQtYSNqpTN5+8V5mL54Avj0mKkrq6AK4DlA==
X-ME-Sender: <xms:9KZwavgMkzG50Y66TxaPU2cD6tRFJzt9aAtt3zOcQ8PUYFKlxvjoxQ>
    <xme:9KZwath_hMOLr_lriU4rL4p0UXOVBVXnNqa3-L4moyvtOfljDlLxgjcHHCOgbadit
    F7T5c8pG-nN2fHsLiINsCkn5DJPsaSVaYjPIjlyxN_zZOOZZTXVHkM>
X-ME-Received: <xmr:9KZwavI7fKpr3MMwJT_aNoUDBcey0FdNwSEB2CPXKnNs0W55EV-bzFCxe0PUezXjwN2_WzZGvPNR9pEtdIvIyXaJd-n->
X-ME-Proxy-Cause: dmFkZTGtzSN8WW7EjmYSdGhXdGYlyWdSvgyhso5mZ/l2anWpocFS5Q958I0NW72sp8ik32
    5Wp6Jg2Y1A8rTTyR7Yk5xtamMq/IaKjY8oNrm6Z1APCZF8CdTJV4dCbjsSk5L+q3B7Coib
    s44kUmkekWFZKtGcVwAgyajc+1o5pS9n7uB/Qzyb9AMMknwZfFyk6Coe6+A+/JJZqLTmoF
    fnwQjTxyUSy9yfcv0UiiRVG5+lDYWbYYDO4SjZtfWSsVxIimvSmywSAM9Sfp0U4abb9vsp
    cy8tBUFtGpUmiEdF71P1gCwSVsKKbuSFKyQ6r/4M6KL4uLln9fOBtjCgYU5r5+w+KBgKDA
    SNTXZ5z4Dt3i7qFa/1Go2vM7Fv5lZr6nDNbqRBwv+g1PPh3vfzWMaZkJt/4C5cu3kdUS99
    auCX7cf5tGdxMZAWPbA63CZ1WAn1V3cvnCt9MlInwtWZf1Csr+RRRZt2j/OJo3JEZrGjxj
    8xqohxhlcI1swNUlbJxXKl9/08rQa7U9AkWnkyIjoK2emS0ZCDT9VPsOKzfmU4LSPVwICb
    qz2TD9YLngWeIRhnu3T7AYig0rp9m2I3nWjsFeEzuilVrJWJv9Q2KwUPya3cYZb9jcz+4I
    lJeh0QKSx3KE82E5FAgrhpsMJl0LzBXn3TK6xt8GeejGiqUNkEoDgh7rQpYw
X-ME-Proxy: <xmx:9KZwasFL1VcbwOzhRgQvaKX-VU5sUbnV1H0kpzzz-24S8cPdHaTzZg>
    <xmx:9KZwajTvBZJxG2-nDRIhPvpIv24IQtgO9qULay4WSz6d2LviYVK8Ng>
    <xmx:9KZwaofS0BRlCekfS-Yhgl33szqofW0eG0A--w1svv1s_PqzaPZsfQ>
    <xmx:9KZwaipIRukTEjwomCO7GIyNxMIA2OHSZBqDvZfhc-bPcnlqEZkBRA>
    <xmx:9aZwamfs79ZUuE71kn6y1Lzlwyct8E3duApt1xhPrEfKQKa522pxVgF->
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 10:34:27 -0400 (EDT)
Date: Mon, 3 Aug 2026 23:34:25 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] firewire: core: fix possible memory leak in
 build_tree()
Message-ID: <20260803143425.GA331475@sakamocchi.jp>
Mail-Followup-To: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20260801110915.82561-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801110915.82561-1-nihaal@cse.iitm.ac.in>

Hi,

Thanks you for sending the patch.

On Sat, Aug 01, 2026 at 04:39:13PM +0530, Abdun Nihaal wrote:
> The memory allocated for node in fw_node_create() is not freed when a
> parent port inconsistency error occurs. Fix that by invalidating
> references to the node, and then calling fw_node_put() on it.
> 
> Fixes: 3038e353cfaf ("firewire: Add core firewire stack.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis
> 
> v1->v2:
> - Invalidate references to the node in the child nodes,
>   as suggested by Takashi Sakamoto.
> - Use fw_node_put() instead of kfree() for consistency
> 
> v1 link: https://lore.kernel.org/all/20260727095955.104972-1-nihaal@cse.iitm.ac.in/
> 
>  drivers/firewire/core-topology.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
> index df2ac0dab106..3d0109c3ed90 100644
> --- a/drivers/firewire/core-topology.c
> +++ b/drivers/firewire/core-topology.c
> @@ -227,6 +227,15 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
>  		    (enumerator.quadlet_count > 0 && parent_count != 1)) {
>  			fw_err(card, "parent port inconsistency for node %d: "
>  			       "parent_count=%d\n", phy_id, parent_count);
> +			while (h != &stack) {

This line would be replaced with '!list_is_head(h, &stack)' in
include/linux/list.h.

> +				child = fw_node(h);
> +				for (i = 0; i < child->port_count; i++) {
> +					if (child->ports[i] == node)
> +						child->ports[i] = NULL;
> +				}
> +				h = h->next;
> +			}
> +			fw_node_put(node);
>  			return NULL;
>  		}

After my further investigation, I realized that the memory leak still
remains if the above error is detected in the middle of selfID sequence
traversal, since the stack can include some node instances unlinked to
their parent, or the issued node instance has the references to some child
nodes which are deleted from the stack. We need more careful method to
release all of the intermediate state of tree.


Thanks

Takashi Sakamoto
