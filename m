Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723137F31D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958464; cv=none; b=ZrWYc0ngJksBgge/sAG2RJ8yz4QuYjQiIpBJwjxCNOTcL2Ugi/6RkR22D7G/05t5hNZOlXKDVygxKda5ZtoDzlW1fJDmIVum3EtE+Kpu7q+jM7AnbVsr3SPed1hIxOCFiC7mtHu4bgVwMOHgo0smvx4f6/htyXwDmOAKswG71Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958464; c=relaxed/simple;
	bh=nezGATePjrScPMxNiTNIPf1BmqnYGsGVladVVdtV6r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTpr6YuaKpOEs1Xm1RT7NjUki9ly0ELZKbbP6uTqZ0T7UMuBAhn2hBIT/KkR3D7l9ooQDndINBLRF3vmty8Az3EC219jTjS3GmiAFtKO/mmQ+dHNv+PAv8TJOSMDMBioA3zIU3OvJn6LzOBFKIayJRYIa/Ik2sfG7Ou8Z2/j0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=rlTnALHS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x06HBaYM; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="rlTnALHS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x06HBaYM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2CA13140006E;
	Wed,  9 Sep 2026 08:54:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 08:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788958462; x=1789044862; bh=hHNqOx+ax8
	onSnqXVdNREYQ1bBsZ+RlzPybR8AHFpD4=; b=rlTnALHSQrPML3hRK20Kab2XmL
	nwM6YjsdcsYuKbrkPnE2XTrUK50nfKsiJuiwlvUS/2qmDlyJ2WnFkI4MUgpzVywc
	hP85MzMQwc5F1KMiwv4AInfOvziTsvMM8ZFrY7XsY7r/pU3W1SR/pLWccgHqkY3a
	VLluIv7SQJcSjVUHoMD/W+BVVOktiQaaSDeJzXa5P4CnO8Ytao32b5IbZNZq0s5p
	rPZoV8LHZX2Dh52qagwjwaukdsZeUtsDfnOOurcZPvMh0SkeGFM5qT+lylPl9PAd
	swvcPd8+Ss46EAB1m+fvZO29pKoPkR+htnikXXwZGF+m7E37qB/GagHEVSGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788958462; x=1789044862; bh=hHNqOx+ax8onSnqXVdNREYQ1bBsZ+RlzPyb
	R8AHFpD4=; b=x06HBaYMdFx9VhPhvIJH716nSf7L/h6HvgQ/X+alqEHMGzKsu+H
	driUZaxlxe5RzXHhNqZG7yrGNl7Tf4L4v6l3WRTlt+HgT8lGgRVG8l86aQOM6RWj
	kFYq40SbXaHw2BVap9DHu4Goar06N8rNH2N26A/C6r2rro1eO2ZRTVh3gc1vilX1
	HFMzU491jkpH4wt5gFR3aNRcg9KW95d4nfiRvT45yeq3KU2eMm9cedzAnsyNvRjw
	vD5puAseAko+qEYoSJ6Q3PoK3xf7AYSSMWdVb9gdFj8SuerRVxozKXq5NxjZFkR4
	h4kbEbhjwRTRokcFvoGPQiXj7Nuxf1/JSow==
X-ME-Sender: <xms:_VahaklbHv_oAMKJoODqlQjcXnIphAqDNf2CrDotEyP87bWbvwa0kw>
    <xme:_Vahat2RJdDdCed2kFekXUHewD5SThvIamYQUY2Ya6jfbFZOyA8gI7GCPpdXR4d4q
    wcMyEn2_ObC68oDmYebi8iY0LpriXrOz-X9mE8tmZMh1EADoQ>
X-ME-Received: <xmr:_VahapQ3Bqds8-ASqb13V34qglLJtvT15GciZ88TpUQNe0DtLpHzbvoDAPIte38cG3zTNgav7xpdasKYoeMDAts2MB3kAhEX97UDLpUcEJU>
X-ME-Proxy-Cause: dmFkZTFM2Rg5I0rwx9blzS0WEvDR9aNKYFvAkC1WSw9Mvbgu9MQG5LIFbQjMyoVuSc25rA
    TRr7Ui1SowbQmiaLjYoxAttqFEjMHG1DlYtOPZ9RB39PzpMwbOUVd5XKIOz+16mxYI00Bs
    agKJWnom8q7b4YyEcW4JXpQA56GODib3B7FtSfi8oHXvrcOQV0Fghh+T0iB66JHJKpiXvz
    pkYATiClFqvMnht1rsUogz5EiVPmXDJTppv+NFMVwTaWJCPBdUyJ/BswkQWCLYJrWrZ7+c
    3oJsSd0AVH82zMRc3Q8HlfWE/JBXpZeQorRXNz5edP89+OeY0YFRHzYR/eG9WHe7Z8gkpi
    LVSMdID7xMNGl2b+U9hMEpivM1xjWOjnAn/lzlKXzl2VVKFqHV331z2Pg9iD33XJlXIVBI
    m1L0HUAbk9h1EHmAq09q3EbiQH12DcP4QyDzvmADZGP2bu/VVPfw0lrVPDyso4PMUn+Hm8
    CiCcx1SR7Ra5PFnHIA2KmqMZ43eBBm78IHZvRPG331PvXkl4eN4Ss8AUBUzbu2SmxM31vO
    4gRB5lyM14SsxQBjUzzuH9+pYo+blYshKnGftBiIsmZrleVohTM3c2UDloy2SFvwCQ4emQ
    THp5L2etVPcaD48yWNW5MVMh3+ASRTytufl2x+b0t5L2WnFd2ZxyxG7d7AoQ
X-ME-Proxy: <xmx:_VahauyfvCgASKl0z4oqtLrplxr11lin0xhqr5CoSJzTp0_ciymJGw>
    <xmx:_lahahBwUWhJrKvJwDgiih44v9MB8ey3mAdVnuB8ahblQbGAKErSlA>
    <xmx:_lahaiH3zvbUsn2t4EWXt817kQweRg7LFFyKM-fMtDvlsGva5tRkaw>
    <xmx:_lahagO0sP9EYhO3GrbZCFrLCzz66ghRQld8KrlC3dcMQa3iJ65XTw>
    <xmx:_lahaieA_KjYMoa3jaVAQBqSBn0oBIqlz4BvUi_1rrRciUN67xZw9nzb>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 08:54:21 -0400 (EDT)
Date: Wed, 9 Sep 2026 14:52:45 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 6.18.y 2/2] svcrdma: Clear sc_cm_id when ADDR_CHANGE
 replacement fails
Message-ID: <2026090937-animating-trace-d6da@gregkh>
References: <2026090325-lushness-making-8377@gregkh>
 <20260909002517.726510-1-sashal@kernel.org>
 <20260909002517.726510-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909002517.726510-2-sashal@kernel.org>

On Tue, Sep 08, 2026 at 08:25:17PM -0400, Sasha Levin wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> [ Upstream commit 01500306e1d50de7ca7a2cdcdfa28ac0523eb747 ]
> 
> When svc_rdma_listen_handler() handles RDMA_CM_EVENT_ADDR_CHANGE,
> it creates a replacement listener cm_id and returns 1, telling
> the CM core to destroy the old one. If the replacement allocation
> fails, sc_cm_id still points at the old cm_id that the CM core is
> about to destroy. Any subsequent dereference of sc_cm_id --
> such as svc_rdma_detach()'s rdma_disconnect() call -- is a
> use-after-free.
> 
> NULL sc_cm_id on the failure path and guard svc_rdma_detach()'s
> rdma_disconnect() call against NULL so that the listener can
> be torn down safely when the server shuts down.
> 
> Fixes: d1b586e75ec6 ("svcrdma: Handle ADDR_CHANGE CM event properly")
> Cc: stable@vger.kernel.org
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Link: https://patch.msgid.link/20260527-rdma-follow-on-v1-5-1b09bd87b6cd@oracle.com
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> [ added the missing sc_cm_id NULL guard to the existing __svc_rdma_free() cleanup worker. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Does not apply :(
