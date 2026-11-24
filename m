Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536808;
	b=q0HlF18+tjoyW1r1y7LmiAS/XZKndKnkcIi0ZH1ivJ04GjMKd1oaPHQoq1pmaSrfkCAv
	 KAPrEnfM3bhoSRabgvKCzT8KUo64x9+WdcrJZa4LvcMeJX4THH6RKM4o1RPfJI6bY4cnj
	 7psgxlS6ZrIKzUIdJhG8lQ7jMvW53ogLDVq4imHb6hlzJ/sxgy3LZGUoBdzSduCM8rBfJ
	 Yi6qIy3hCGHdveh0XZKNHwR8O6O/ShFrVd+ptKLIDlWhnFS+3ydXmiiVX9vfg032NcnkO
	 Fsc46J8QVGtW0ndkbjAfy1CZfO6VgB7H5Ym0JJEhMCgFyrZvKevhTpEpMZyuAWwoRrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536808;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=9qkIA4osyJB1IdKouCVst5K59UW4RbBPM1EDPpjobto=;
	b=gh9O7NZtKRy0CPoWwBxzpeWkrkyQm+ZJdle2tkGSz1RzQM1pdEeP8GzYkGliKTu9m6fj
	 ch2FZto4OZ+LcBoRzEmP+/OnfNQ2R7cNBmcZh+msrP09sRfNHG0C/Ea78UziqYcMvqHUS
	 FXa0ubYFh+uxI3QKU8vmnuW2vCeenibNeoWpOJA6oXoZ2tTyVGzxBzZgaNbbkDrcFQfEi
	 OWPe6jGOCxXYLotZ61o+3l1+CUzUxqF/uH8BFOU0Sdli71O+mLr+E0qitzkK2RrriQiLE
	 tj7lXvPc0beNLAc2IhVdJ9XD83NA9O7xQt8dg3dNpO921GfzkF06VUiqco1m4QQ5PmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZbJt6h0;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D18606A333
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82D18606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZbJt6h0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795536806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qkIA4osyJB1IdKouCVst5K59UW4RbBPM1EDPpjobto=;
	b=WZbJt6h0mYSlxpdUnoM15yUhY2QjfUV6QOU6b8Hom4DH4o/lWsQdFtNoYfUgbCA7Wnqx2t
	/kCDO3f7HeeWrTjH/tq0i5fJi9jraYE/PFmBG/c7SqCD4yU3bqqVSLbpCQtaapGVimSU89
	B7zhL+I8vZWhXWx04EKQe7XL8m/ZcHU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-o3FLZbRIMjencDNElJmXnQ-1; Tue,
 24 Nov 2026 16:13:22 +0000
X-MC-Unique: o3FLZbRIMjencDNElJmXnQ-1
X-Mimecast-MFC-AGG-ID: o3FLZbRIMjencDNElJmXnQ_1795536799
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 634A2195609F;
	Tue, 24 Nov 2026 16:13:18 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E72AA30001B9;
	Tue, 24 Nov 2026 16:13:14 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 01/10] rxrpc: Fix incorrect unit conversion
Date: Tue, 24 Nov 2026 16:12:49 +0000
Message-ID: <20261124161302.4044422-2-dhowells@redhat.com>
In-Reply-To: <20261124161302.4044422-1-dhowells@redhat.com>
References: <20261124161302.4044422-1-dhowells@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fix a place in rxrpc_rack_update() where it's mixing a value in
microseconds with a value in nanoseconds.

Fixes: 7c482665931b ("rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020201258.290827-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@vger.kernel.org
---
 net/rxrpc/input_rack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index 9eb109ffba56..edd0dee8ac32 100644
--- a/net/rxrpc/input_rack.c
+++ b/net/rxrpc/input_rack.c
@@ -75,7 +75,7 @@ static void rxrpc_rack_update(struct rxrpc_call *call,
 		/* Use Rx.serial instead of TCP.ACK.ts_option.echo_reply. */
 		if (before(call->acks_highest_serial, tq->segment_serial[ix]))
 			return;
-		if (rtt < minmax_get(&call->min_rtt))
+		if (rtt < us_to_ktime(minmax_get(&call->min_rtt)))
 			return;
 	}
 

