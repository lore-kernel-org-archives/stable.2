Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937E262808
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785565553; cv=none; b=ZAGDcRvS6qgoy7iy3MsuZ0gYpGEeMp2pNKEf1PRIkkSNye1XYn1iKyMHyTGslixNeOQJP9ulYhd6yYNpVVfXPyJEc8dm8g0sMZDAIr0jV4oZ1Z2ao685rFqsUVYkCv2gA3hbxeXER55dlJXk76O+9hvbEsm+9uhUWCyxnfDEMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785565553; c=relaxed/simple;
	bh=2y7jlVTVoBNmTP6hIg3mJXvmtub3JnL3UmvcMUblDQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGOPfr32Q5NV8nU+DvyRYzyryYdtgkGjYWtgTcw/UUarVe7SELz3zO/pAks19Xl9soXyu4wIABcN2TqbkSVP0GZYeIAN87Xbf//EdNZ6owJHub4A9U7HFJqx80OcmrD+xp7y7vFdxktApqAAvhBG7uAcBs4pUwu/ubh8MHcWEtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=yZEpeyUT; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="yZEpeyUT"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so1838337a91.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 23:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785565551; x=1786170351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=udkIuXqeeT/DmizMnG6qNBFnYC/J6qCjxFDgPiS6HaU=;
        b=yZEpeyUTsCbkumfRGFXRl0d+0SuXBH2vYJZ9Z9EidUShnUAFiAQnqG+mKkwrOzsxBv
         NDbr5ZBLmJ2gqilzuS34abuKq4/aLXqSShaDeiTKIFoJsJurr0YcAiysY7qFCS25UvOY
         N+jKi6Xl2wR9zbxmubxPqOXwwSAHPt+HaQ8Lkd1ixouXE9WA6Yia71xpDb5LomWbC+8C
         O1b7lLRtNw9ZDB7qwptxyxs5LCgIUICWr5xr/V1cM7aluSmalAfEqEqDFIo0mZmbXFZZ
         XmO/o24Bs9X1FN/9L28HKYrONxTE1kWWRdbjvO/2JmScW0EPc+CI9vNhPpACPCHKyvsv
         7PmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785565551; x=1786170351;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=udkIuXqeeT/DmizMnG6qNBFnYC/J6qCjxFDgPiS6HaU=;
        b=KkH+qWoqw1F5H/19ZwVKdQiAdZi22LKQVGHcLFnsGPiR1W2dGZ9GwfqpCjbKh0F154
         N7g0lShUz1sn4131+gmqbTtwchOM0hVGx4LMuAbu2UtMpzu1yrnkX4EYu3KSu3jH90KQ
         1BdCHo5fCxPxWTxW2yNWczqqA5VH6eBe+gT+jGUGHC0TcVmcvJHfKXrcmz1ahh+oPSyx
         RE65arGbxYBvj4hK6RdITOM22nmZfL/Ik4M99zNqUSeXJVirZSAjOegAxBanobdY85o1
         LpmtRg2l5HCIyDYnuRsaFBYxM0U7ga2H68i5RB22qIWzl3PO8ahfZr/mdCgvT3I0ez2L
         vkJg==
X-Forwarded-Encrypted: i=1; AHgh+RqKXAogNnKxTaTP9deMTJxhQxNJF+XoH6QGvHAJuARa+Nzg5v8N4MGzokbZoc7eQ9/RJjdAagY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNEU8k9R2eYCsYF09chx5MDqvK6y3HYSQVHmZt5fWcK2ohugy
	atoAd5KSXGyLOicG4hzNvVkPajpVLNEWLnz9o2CbgTOIh7eqSN4SQs9UiMv0A67vRps=
X-Gm-Gg: AR+sD12PVv5OjNSNYapjyrjNysxEesHwkmjiLoZ1Pr5vpV3ccAm5mgg7btHoeaFw5Gp
	xXBqybb0WdER6O6SeSBhoFXv/cZPIldB28nJ1RYaI9Z4iQjstGAl1CnMVhfMsG4HNIvOEw6147B
	y9/+5glg+DGa6AV6ift5seQWHiG1S8HaV7mNuCQ7Pd5hO1k6sj8afLnmBQY19d1LNl2SYSags8z
	/iSdi9PLJiEAPdfbHdjMj7QlkLTnXvks+CPi1TCuDIQOPmF39HWXHx6pB7f/CL0EyzfrbuwiMGd
	p2wesr50hdYYZQq8R+DuSrGQg65+n2hPnRqA2VVMvJn7dQd/pSqO+AGGW1dzrVQILOxWtMScVBK
	AXkhgMAu4nYn0bt+t1MRUuunq1fDaeXEH4KBUe8JoTGnvkOKrU3P9kDqS7PK59tswko3hJAxX9C
	5FuFF+t89dL3hnw4c8QoL7xlYcmjEvu+ZZt69+T5YxnAORErmyubII//flTVhwWAVJ4g5oOeh/D
	m5JzkEDQCHkqDExYtqv0UCfhiuPMl98mdWedBinRydOrjfzUsSQXPcFKizV3r7dP9HKFDd2fvtf
	Y1DTljEX8d0=
X-Received: by 2002:a17:90b:4b45:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-38fbc40905dmr2384489a91.8.1785565551338;
        Fri, 31 Jul 2026 23:25:51 -0700 (PDT)
Received: from Metius ([103.158.43.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4cb50dsm15190712c88.10.2026.07.31.23.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:25:50 -0700 (PDT)
Date: Sat, 1 Aug 2026 11:55:46 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: o-takashi@sakamocchi.jp
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] firewire: core: fix possible memory leak in build_tree()
Message-ID: <ilsaqsyiw3udyq25zuupkoy5g3kdttvphgpqq4otsboinav52q@plmughpwaocm>
References: <20260727095955.104972-1-nihaal@cse.iitm.ac.in>
 <20260727234308.GA244925@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727234308.GA244925@sakamocchi.jp>

Hello,

On Tue, Jul 28, 2026 at 08:43:08AM +0900, Takashi Sakamoto wrote:
> Indeed, there is a case to leak the memory object for the node found
> newly. However, I have a slight concern that the simple call of kfree()
> would cause another issue, perhaps.
> 
> > diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
> > index df2ac0dab106..317f8f57e521 100644
> > --- a/drivers/firewire/core-topology.c
> > +++ b/drivers/firewire/core-topology.c
> > @@ -227,6 +227,7 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
> >              (enumerator.quadlet_count > 0 && parent_count != 1)) {
> >              fw_err(card, "parent port inconsistency for node %d: "
> >                     "parent_count=%d\n", phy_id, parent_count);
> > +            kfree(node);
> >              return NULL;
> >          }
> 
> When arriving at the line, all of children nodes have the reference to
> the issued node.
> 
> ======== 8< --------
> 250                 for (i = 0; i < port_count; i++) {
> 251                         switch (get_port_type(sid, i)) {
> 252                         case SELFID_PORT_PARENT:
>                                     ...
> 265                                 break;
> 266 
> 267                         case SELFID_PORT_CHILD:
>                                     ...
> 273                                 child->ports[child->color] = node;
>                                     ...
> 276                                 break;
> 277                         }
> 278                 }
> ======== 8< --------
> 
> I guess it required to invalidate the above references, since the
> reference would be used to release the child node.
> 
> ======== 8< --------
> diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
> index 75a6b0df670a..8bb6aa1b5d54 100644
> --- a/drivers/firewire/core-topology.c
> +++ b/drivers/firewire/core-topology.c
> @@ -286,6 +286,11 @@ static struct fw_node *build_tree(struct fw_card *card,
>                     (next_sid < end && parent_count != 1)) {
>                         fw_err(card, "parent port inconsistency for node %d: "
>                                "parent_count=%d\n", phy_id, parent_count);
> +                       for (i = 0; i < child->port_count; ++i) {
> +                               if (child->ports[i] == node)
> +                                       child->ports[i] = NULL;
> +                       }
> +                       kfree(node);
>                         return NULL;
>                 }
> ======== 8< --------
> 
> I'd like you to recheck the above point, since the above perspective comes
> from my rough code review.

Thanks for your detailed review. I'll go through this again, and send an
updated v2 patch.

Regards,
Nihaal
