Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538363EB81E;
	Tue,  7 Jul 2026 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449079; cv=none; b=mnnKqAosA0FOkkL1Z2bmI6HYsxpB4BZ+SvTlBdmWcVmXZVteOXPZqvbaIG1EgkXNeXijOq6TEPqU9HfBIzRZvd1CAq0Q+8OBb6JwWelfo+fJAc9jNeFLFhIGOp79WZ6otjgpd4Kqg0V+C23nDa1QKpaTKNO12qouChV4yccp6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449079; c=relaxed/simple;
	bh=6rnez0pQKR9IlghS2nAbl0rO9vucvzzo6OUAc4Qgi28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJNpvDYvkV9jqDMEGn0l3/sx4yLokTEZq+zBY1NL45g0i9Dv4LjuPBckST0Fzja9L9IBBhTIzdxDvQ3tm2hHMWNdD7SYw5R+gVdnLfjYptKevZ44cRxulMQKPQ83RgyqDsF0bLWJtM3qrgxgTPwv37rwvvnT+tsJhPn7GBAF03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Oj1yds81; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Oj1yds81"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k5m+Pgp4RwbMKePDOPmKj1j/iO+dkm9HhURejYjv8hw=; b=Oj1yds81xnMoN9icAqqSk1MEHN
	j1OsLrZNODpuu0LXLPdV62Nzc5MbidbbnjragNrY6aZJZ+SoGUQmInxq9JRYfThLl7BddEtcw2sb5
	oLxkcsF3Fkx7dvowFIrQOy9+JaICoKc5MoA3iZ/njT06RolEmvjzOxv44SsBQnCeO9W8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whAZY-00BD5W-51; Tue, 07 Jul 2026 20:31:08 +0200
Date: Tue, 7 Jul 2026 20:31:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Federico Kirschbaum <federico.kirschbaum@xbow.com>
Subject: Re: [PATCH net] dibs: loopback: validate offset and size in
 move_data()
Message-ID: <c09ac69d-5f69-4634-81a0-5e629cf135ba@lunn.ch>
References: <20260707074318.1448662-1-dust.li@linux.alibaba.com>
 <ak0NpKUDkvrkuSOm@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak0NpKUDkvrkuSOm@linux.alibaba.com>

On Tue, Jul 07, 2026 at 10:31:00PM +0800, Dust Li wrote:
> On 2026-07-07 15:43:18, Dust Li wrote:
> >The loopback move_data() performs a memcpy into the registered DMB
> >without checking whether offset + size exceeds the DMB length.  Unlike
> >real ISM hardware, which enforces memory region bounds natively, the
> >software loopback has no such protection.
> >
> >A peer-supplied out-of-bounds offset or oversized write would result in
> >an OOB write past the allocated kernel buffer.  Add an explicit bounds
> >check before the memcpy to reject such requests with -EINVAL.
> >
> >Fixes: f7a22071dbf3("net/smc: implement DMB-related operations of loopback-ism")
> >Cc: stable@vger.kernel.org
> >Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> 
> Reported-by: Baul Lee <baul.lee@xbow.com>

Could you provide a link to the report?

Thanks
	Andrew
