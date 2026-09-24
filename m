Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189563F4835
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239542; cv=none; b=SbrpBQxeNBe9+AnC6R7QchpsuQQJL3EWLXr1qbwhNwV/Xs0OHh6GVVt90cFuu9cAW3KuxyIWl1qEZvoljGGpl3bl9Pl7FHysCZz2j28AssM8iFc9koEUT15sB2cORz0vbG5qGW+tm8rr/umKaAL5riNE8sXWz2Uvfyp4yyS/q5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239542; c=relaxed/simple;
	bh=RjcNA6HmCmlxdxtVqsdef6UdVNw3BtkB7wp/J7/Uu94=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=gaGv+m6D+bh4g3hOssndtkiT7f3oBK9ujRxhZZYVP4kwznF0edRzYd8nrS3B4tEniC1FAswweyr3GWipZ4zh6dIUpTBjCmCGSnPcvu5yx8j2YEbHeD9vip75T/zLV/pgNOoGRw/a0+BLgMZQQnxfgrfZCIjot4255qzGP5aUUKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+UvTXQP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+UvTXQP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790239540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RjcNA6HmCmlxdxtVqsdef6UdVNw3BtkB7wp/J7/Uu94=;
	b=D+UvTXQPHpeo7SPPZwGrgrAZh+HX4NVh71vbYLPs1MRvXmDBlxy2VJOYORLu7fc/wRGWGC
	s2eSMLLcno1dpJI+d3Y6GHDatp3W862MSRXSWTGASUmCWtkSyIQmzQfXfQZvNF4liqYHk3
	8AAPsb2aP/H+95nujzAU+oe8FTEHtA4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-nSAQ5WQbPuKl9s_BJxc4WA-1; Thu,
 24 Sep 2026 04:45:36 -0400
X-MC-Unique: nSAQ5WQbPuKl9s_BJxc4WA-1
X-Mimecast-MFC-AGG-ID: nSAQ5WQbPuKl9s_BJxc4WA_1790239534
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA749187A5D5;
	Thu, 24 Sep 2026 08:45:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C9D03000229;
	Thu, 24 Sep 2026 08:45:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260923133706.1496540-11-dhowells@redhat.com>
References: <20260923133706.1496540-11-dhowells@redhat.com> <20260923133706.1496540-1-dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>,
    stable@vger.kernel.org
Subject: Re: [PATCH net v11 10/17] rxrpc: Fix return in rxrpc_recvmsg_data() for service calls
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1551181.1790239528.1@warthog.procyon.org.uk>
Date: Thu, 24 Sep 2026 09:45:28 +0100
Message-ID: <1551182.1790239528@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fixes: d001648ec7cf ("rxrpc: Don't expose skbs to in-kernel users [ver #2]")

