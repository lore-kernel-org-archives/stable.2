Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F6331578E
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782197505; cv=none; b=PlwpiwLv84FbgHqKhkVQgWRqInPnJZ2BFqxGh6YgElsWhneGjZ56JzveSWgXNlfbz3yDPm1vJaD7oHISvllcP9o+jCSnONpvW+nBxI9snszVzvJB2P+682anVIHUz/Ha4MPMY+U9dlCmpuh29YJtLgV9bdpkTYbr68pui9+xCBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782197505; c=relaxed/simple;
	bh=x8TJwUtC+G+n+qNyQWu0ehmMk+LBRSH9bQBQaUoR0T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRBH5DjOba/AhRqCw+vYARII32+Fk4VJTBqPRwPdVWK4bsJnR5HjWNj3FWtLZ3fMvaXMsBW6fC4aBOzXmkAk7wVUSQvanxNHLBKBehNsN+ZEWZxtuQxXyRVOt5onvhhEdVs4gQaoQQiaGzxgWgM/SB1Kv28wbpZf+ltGvfq8trM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWLTwyq7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWLTwyq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782197503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8TJwUtC+G+n+qNyQWu0ehmMk+LBRSH9bQBQaUoR0T0=;
	b=HWLTwyq7vGsLtkLiNtg3zkq85N2MZdbtRLeDiBa6uopjF6QQcaUI8EepoW8406E8WUMCw6
	6heScPedQFaKN9rvoa5fQLwOyhs+7HFe0v4aRJoBOSAB/4x0aSCypgQArt9CoG8Jwujp8C
	1Xx3p8C6IdXjbbjCe+kRZpkzGXz3De4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-zoNZJuxdNRquAp2fEwsbbQ-1; Tue,
 23 Jun 2026 02:51:38 -0400
X-MC-Unique: zoNZJuxdNRquAp2fEwsbbQ-1
X-Mimecast-MFC-AGG-ID: zoNZJuxdNRquAp2fEwsbbQ_1782197496
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A1911956041;
	Tue, 23 Jun 2026 06:51:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C0C551800591;
	Tue, 23 Jun 2026 06:51:31 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: przemyslaw.kitszel@intel.com
Cc: aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	jacob.e.keller@intel.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net v6 3/4] iavf: send MAC change request synchronously
Date: Tue, 23 Jun 2026 08:51:29 +0200
Message-ID: <20260623065130.600628-1-jtornosm@redhat.com>
In-Reply-To: <55f9e2af-54fb-4257-af25-dc9c0fbeb72c@intel.com>
References: <55f9e2af-54fb-4257-af25-dc9c0fbeb72c@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello,

Thank you for catching this.
You're absolutely right - the loop can't work without polling between
iterations since the second call would hit the current_op check and
return -EBUSY. I will remove the multi-batch loop and revert this to
v5's approach.

v7 will be posted shortly with these changes.

Thanks

Best regards
José Ignacio

