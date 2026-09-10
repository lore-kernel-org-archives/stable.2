Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28B3B71C7
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789035531; cv=none; b=pAdRbF7in6qEgJ9b6c3SMM6o1/Wb0czLk0ZJWzzylsGcSjg1MvD85v74ajC4/CTbg+8+U30fNd5HU7Ns1m9YFMweC9ADxLxsAXdbfm3MjFCI2bFPJqNVg2yAc4s9X8LkNytS1WBALTMqqf/YR/lWSFYeBYmZ9EJiZ0XCnroXuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789035531; c=relaxed/simple;
	bh=GhdPZv9zx9m7HXkFvx00ZAigkONoSz1aFYJQXaX6wfw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QPsctz5N/12QjdOfRc8tdi0/41B7m6qMOtBJqzlLF4Ez0xf5/P+oHgBKdrFQ0j1r+mmSrNLCjjvtYSsNJjqWbZNMhr0YlkEwaSG6kEjRL2MZVkUq5asBYBbg1gKyxdMWy3nzuY51TYgDlU2qlG1qq1CjGeH6M+THEWZ/I8NrytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4i1UFm9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4i1UFm9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789035528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MorH7EGnFDFfnoYjZ8yy0Tahkv8+0MJQwew0SsuDs50=;
	b=J4i1UFm9u4t4hW2OUC1xqu3//UzhDCoLjb23Y79u5jwQgcAF8pCuWou0ATzBMQ9U1O6WFQ
	m2WPirL5nTbDVEd01o25kL077fm+iYZymc6bUZS6K6RjX+M5GZXsyNzT4qTtdaFoHSHqYV
	QOZttS+8jeAuhJH6crXpVGO8s1ZDFNo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-Sa8b3DoRPNyHqtMOQFdFkg-1; Thu,
 10 Sep 2026 06:18:44 -0400
X-MC-Unique: Sa8b3DoRPNyHqtMOQFdFkg-1
X-Mimecast-MFC-AGG-ID: Sa8b3DoRPNyHqtMOQFdFkg_1789035522
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9451D1954223;
	Thu, 10 Sep 2026 10:18:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 463B3195608C;
	Thu, 10 Sep 2026 10:18:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260907140644.18dba619@pumpkin>
References: <20260907140644.18dba619@pumpkin> <20260907113743.1453210-1-dhowells@redhat.com> <20260907113743.1453210-2-dhowells@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v9 01/14] afs: Fix lack of loop around sendmsg() to rxrpc
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2029748.1789035516.1@warthog.procyon.org.uk>
Date: Thu, 10 Sep 2026 11:18:36 +0100
Message-ID: <2029749.1789035516@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

David Laight <david.laight.linux@gmail.com> wrote:

> > +	do {
> > +		ret = rxrpc_kernel_send_data(call->net->socket, rxcall, &msg,
> > +					     msg_data_left(&msg),
> > +					     afs_notify_end_request_tx);
> > +		if (ret < 0)
> > +			goto error_do_abort;
> > +	} while (msg_data_left(&msg) > 0);
> 
> Is there any reason you didn't change rxrpc_kernel_send_data() instead?

My thought was to keep rxrpc_kernel_send_data() operating reasonably similarly
to sendmsg(), but I think you're right - that's a better way to do this since
I don't think there's a circumstance that I wouldn't then loop around it.

David

