Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B541F7F2
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855925; cv=none; b=pXHb1FpM3ZygDVbMR8N06XWVbs2BXwKM7ZpqN32wr/OXzl/68mXfWSFIYZzD4yQZ51t5EwTkA6j6EAcUHg7IOfPJ10O2ujjIz1jk1oxYhf1foAb3NZUp12gHt2lWz1louG8OhHZSkzWEhSWE3ePRH1TIKTRk7fstpE/RG4uCi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855925; c=relaxed/simple;
	bh=rhFRpVS9EmLd8rd6IQ30xW4lLZ1/9O5lMThVxUcu15A=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=NcOKZ1oCViWdlofCAReoWx85KZMYz0LkHz9QeIFKhGs5fCn+6PTVprraSAmBTKe97pAjyTRLufSwjBhzKDwPVviWOMfmIsPEcKeH9OWLV9FrhkBUksUSDj+9rQcxIkKn7Pe8+Dq4cXC+cAbh/hp8nrUB6/NoWmUfoht+/Qq7sos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKGLVani; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKGLVani"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788855920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OVXrGUg5TW2gZ5wAfIAON6+TG4JNqpvGjztTjnmPorQ=;
	b=HKGLVaniBqgC2p8COBjoCw69ZS8V6yOf1Kxx6vRpxbD7t7Xa2ZpuLrYYfuUMn9YpK7cuMY
	IFWp2hzB3BbMDkz4o8EaPB0R8cx8uQ/HC9MMmqJ5A9dG+8hkgPMIRHzsOe7rIDMsUWHTer
	FRPN5BI7sYCS/ZZWIb0lzBmcR1LII0g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-tu3mrcHjMLCFpPWz0iFacw-1; Tue,
 08 Sep 2026 04:25:15 -0400
X-MC-Unique: tu3mrcHjMLCFpPWz0iFacw-1
X-Mimecast-MFC-AGG-ID: tu3mrcHjMLCFpPWz0iFacw_1788855913
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2EA41954B23;
	Tue,  8 Sep 2026 08:25:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.158])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE69D30001A2;
	Tue,  8 Sep 2026 08:25:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <a2bd6f3ed29919a7328363b548299ae583f052b0.1788539302.git.zihanx@nebusec.ai>
References: <a2bd6f3ed29919a7328363b548299ae583f052b0.1788539302.git.zihanx@nebusec.ai> <cover.1788539302.git.zihanx@nebusec.ai>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S . Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1502560.1788855907.1@warthog.procyon.org.uk>
Date: Tue, 08 Sep 2026 09:25:07 +0100
Message-ID: <1502561.1788855907@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Zihan Xi <zihanx@nebusec.ai> wrote:

> Reaccount encapsulated packets against the UDP socket before queueing
> them on the RxRPC local queue and drop packets once the socket rcvbuf
> limit is reached.

This seems reasonable.  I do really need to add separate accounting for
buffered incoming DATA packets and for all other incoming packets (especially
ACKs), but I think that can be done after the skb_orphan() point you add.

> Clear sk_user_data under RCU protection and release the socket only after
> the local queues are purged.

Is this actually a fix for a separate issue?

Anyway:

Acked-by: David Howells <dhowells@redhat.com>

