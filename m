Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531F3BBFA4;
	Sun, 26 Jul 2026 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785085209; cv=none; b=VwVdrYcH38gURd/mNu8oNBTrZZfNfYzMYt4ypQXwk57ZqorcK12UGVgPFDyjO0db8ous/OdrpyyrXaMnyu3bAroasaaBmJcyBKy/Kb0IaxuNviSZYkYpYVRYqxH+Q2OZdsXRDotFgo+1aH5ekQHx0OIM/79M99MsMpaC8iAH90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785085209; c=relaxed/simple;
	bh=4wKzb9eNIMFzfWhyqEELIhu1aa528SjvPygoq8qOhrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/WZ/S2XlVTyHTk4suwdaonqEJDAE6Ce3uVyVgqudapKjWIEPB2h0e2Ru/1eMaXDEyddXFReu/82paVeZ+v753IqjHkmi4xgEVV7A3kmbNAS4r8aIQTLUHkCcTElHPBF9xqUDgoYNqWZtDvBuDt6yjvo2YhfR/m/YTrqLH+ttWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kK2NlxIs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kK2NlxIs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kvIDHoh0yY+grrigen//Ucr351ObEoj2MVXgsu02pr8=; b=kK2NlxIs//w+/2oyOufYhoPzT2
	wHyb5lVG6qgHqoOsZt/xECEpYlRZI0XRHDYogVew/MuxKetCGcgiNBZkhlfriZYXJxxVUDa7O9kSO
	WYeqUOO3YnCS+HrLIK/ezE6GHuzlD2CTDu0MTj+cl/hRJOAjCyMVZqRIHmDERhL3E65I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wo2Cp-00EJUk-7s; Sun, 26 Jul 2026 19:00:03 +0200
Date: Sun, 26 Jul 2026 19:00:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Baul Lee <baul.lee@xbow.com>, netdev@vger.kernel.org,
	bridge@lists.linux.dev, linux-kernel@vger.kernel.org,
	idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	federico.kirschbaum@xbow.com, stable@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: mrp: fix uninitialised bytes on the wire
Message-ID: <fd3e617f-670a-4694-b96d-c0c93582489d@lunn.ch>
References: <20260726062518.43774-1-baul.lee@xbow.com>
 <amXZWTkZK7EYVwbh@penguin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amXZWTkZK7EYVwbh@penguin>

On Sun, Jul 26, 2026 at 12:54:33PM +0300, Nikolay Aleksandrov wrote:
> On Sun, Jul 26, 2026 at 03:25:18PM +0900, Baul Lee wrote:
> > br_mrp_alloc_test_skb() builds MRP test frames on an skb from
> > dev_alloc_skb(), which does not zero the linear data area.  On the MRA
> > ring-role branch the sub-option TLV header is appended with
> > 
> > 	sub_tlv = skb_put(skb, sizeof(*sub_tlv));
> > 	sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
> > 
> > leaving sub_tlv->length unwritten, and the two trailing alignment bytes
> > are appended with a bare skb_put() that neither writes nor clears them.
> > The surrounding oui and sub_opt regions are explicitly memset(0), which
> > bounds the exposure to exactly these three bytes.
> > 
> > Every MRA MRP_Test frame therefore carries three bytes of stale
> > page-allocator memory, at frame offsets 65 to 67, to any observer of the
> > MRP control traffic.  A capture on a kernel without
> > CONFIG_INIT_ON_ALLOC_DEFAULT_ON shows those bytes varying frame to frame
> > and, after a page-allocator spray, carrying the sprayed pattern; the
> > same reproducer on an otherwise identical CONFIG_INIT_ON_ALLOC_DEFAULT_ON
> > kernel leaks nothing, confirming the source is uninitialised allocation
> > memory.  Reaching it needs CAP_NET_ADMIN, which is self-satisfiable on a
> > stock kernel through unprivileged user and network namespaces.
> 
> Drop this entire unnecessary paragraph (slop).

Hi Baul

Please be careful with this. AI slop will quickly damage your
reputation with Reviewers and Maintainers. If you have a poor
reputation, your patches are likely to be slower to get reviewed, get
more examination and more minor problems pointed out. AI is a useful
tool, but it is just a tool. You personally are responsible for
everything in the patch, so it is up to you to decided if what the AI
has generated is correct/useful.

> > Fixes: f7458934b079 ("net: bridge: mrp: Update the Test frames for MRA")
> > Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> > Reported-by: Baul Lee <baul.lee@xbow.com>
> 
> You don't need a reported-by tag since you've already signed off
> the patch.

Please handle this for all the other patches you have posted to
netdev.

It is a good idea to only post one patch, get review comments for all
the errors you make, and learn from them. Only once you are confident
you are likely to get everything correct can you start posting
multiple patches in parallel. Posting lots of patches with the same
error will also quickly damage your reputation.

	Andrew
