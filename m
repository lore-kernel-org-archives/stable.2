Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD02561A2
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660916; cv=none; b=gPqkdqaFEQnCar5ujqBFkUFzE8VkIidiZ0IJo9y9886QgEYCRJDxSP2n75zbv4OGUwxBowgBiRZxb5mEcqChc/ZB169GHXe1VndhPkM/9JleQPeje1U6VlDcpVkazPWukbBP1QI56VUUG/yX2msiZOsHUiuz4N0gXa01nb9Spe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660916; c=relaxed/simple;
	bh=5Ecgga1c8XchRbqCv9AculccL2L8p7bRqXlzTd/nZ4g=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=mkpHu2zVNI1X1SRtn5nUcjiFKDMqXlFhSNxj5TTAjQ1UoCcnVq8HvgirwuxUl3twVx/iv9z5ATAS/E61j18UVBFGF/qrX6WzVVhY1E+yYIDDfH2uYNw80/8Kufi+2FwNyhpwh6WJlljnNn6aLZl6aKiyiPgqZf9qAVwtkzg0dIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtgWV/5q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtgWV/5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789660914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=et3zBoBSN6GCI6rqJx1DCxQFrRFU/eDN/OP4aGK4tMg=;
	b=TtgWV/5qynDSkC4GWtPyVPJ2CVVfXiWQ2wT4a5RZN4q9crnEXPy4stDyZhpnhmU7zP8yb9
	S/HVWTK8TEn2/+A9tljTj/yOC08HqxDqk0KZARnQIeL7Sqx0GN4F2coGhRc8gPmNZ/IgPt
	+TqcCPC/BqA1Ryut5DVQ7m0wTKkr0xM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-mLqnMxcVMLylnzq2NHKwDA-1; Thu,
 17 Sep 2026 12:01:50 -0400
X-MC-Unique: mLqnMxcVMLylnzq2NHKwDA-1
X-Mimecast-MFC-AGG-ID: mLqnMxcVMLylnzq2NHKwDA_1789660908
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BE1F1944E40;
	Thu, 17 Sep 2026 16:01:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07ED81956086;
	Thu, 17 Sep 2026 16:01:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260914221143.2084bcc2@pumpkin>
References: <20260914221143.2084bcc2@pumpkin> <20260914151340.3227501-1-dhowells@redhat.com> <20260914151340.3227501-2-dhowells@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v10 01/14] rxrpc: Fix lack of short-send handling in rxrpc_kernel_send_data()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <669657.1789660903.1@warthog.procyon.org.uk>
Date: Thu, 17 Sep 2026 17:01:43 +0100
Message-ID: <669658.1789660903@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

David Laight <david.laight.linux@gmail.com> wrote:

> > -	n = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg, len,
> > +	n = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
> >  				   afs_notify_end_reply_tx);
> 
> Probably needs s/n/ret/

I had decided not to do that to keep the patch smaller, but I can make that
change.  I also want to change it from ssize_t to int.

David

