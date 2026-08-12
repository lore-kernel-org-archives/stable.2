Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88624399375
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517943; cv=none; b=khT9f5izNWF7pwwNrAChVXAmAYbLtFjacpEmtqZJsR0pdOEYwxZdy4+wzS6swQdNNS8pKSvl8YcgcbdlBI6tepOFXT3MRVS8BvrMFFYoUveu6FvZ3MijGLzwNkDgHRAnh+F/wZeRt9RVIA0SK6BU1hozsdwrIwT7TPhrz51eDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517943; c=relaxed/simple;
	bh=LrKZUX9B2iQ3D8wZLb1Bz7dJ4Pq22sX5gnDgCrh6tMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAZt7w4cXfgzQCQTubR6CmF/O5JTkcRfR1w6iFtVtkXHysxJN9EZm0gIojpvAB9X1FA/rMfDI6EIIa4tsN2sNqbWr4IyrQ04Ay2BnaMm9VPj5RsQ2I5ryPlZfa56xwQmaHswbnFJlCWlajj4ho0edOHH24+SSrtkN6T9Hdx67gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iycXGeB5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iycXGeB5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786517941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUlez4NgSsIZSE81dJYqX9V5NVRDEYxTupW8zglxA70=;
	b=iycXGeB5baArB4/fBYm5bj6HHNkwtvLBYCWu/YBYTHNGEPHeSA0WYbRIhxKlUh9l3R4NEI
	mOoNuW58pG5y/1evXOjfgHFJ2NuFfxTxCIG81xcwz98bbqZKlACUYaqkNfqtWQK++elbk1
	a2lHDK39DK8YlVZOZ2XxuZl61MtIZDg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-xCzPqoW4PAS_yY2Xlutgxg-1; Wed,
 12 Aug 2026 02:57:01 -0400
X-MC-Unique: xCzPqoW4PAS_yY2Xlutgxg-1
X-Mimecast-MFC-AGG-ID: xCzPqoW4PAS_yY2Xlutgxg_1786517819
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CF3B18001E1;
	Wed, 12 Aug 2026 06:56:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.55])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 750143001DAF;
	Wed, 12 Aug 2026 06:56:52 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kuba@kernel.org,
	anthony.l.nguyen@intel.com
Cc: aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	doruk@0sec.ai,
	edumazet@google.com,
	grzegorz.nitka@intel.com,
	horms@kernel.org,
	marcin.szycik@linux.intel.com,
	michal.swiatkowski@linux.intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net 01/10] iavf: return EBUSY if reset in progress or not ready during MAC change
Date: Wed, 12 Aug 2026 08:56:50 +0200
Message-ID: <20260812065650.10326-1-jtornosm@redhat.com>
In-Reply-To: <20260806172032.2935407-1-kuba@kernel.org>
References: <20260806172032.2935407-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

All the comments below fall into pre-existing issues, concerns already
addressed in previous versions, out-of-scope items, or extreme edge
cases. No code changes are considered necessary for a new version.
Details for each comment:

> [Severity: Low]
> Is the placement of the new gate ahead of is_valid_ether_addr()
> intentional?
>
> With this ordering, a request carrying an address that can never be
> accepted (all-zero, multicast, other non-unicast MAC) now reports -EBUSY
> rather than -EADDRNOTAVAIL whenever iavf_is_reset_in_progress(adapter) is
> true or adapter->state < __IAVF_DOWN.
>
> The core does not validate the address itself, so the driver check is the
> only one on the rtnetlink/ioctl/sysfs paths:
>
> net/core/dev.c:netif_set_mac_address() {
>     if (!ops->ndo_set_mac_address)
>         return -EOPNOTSUPP;
>     if (ss->ss_family != dev->type)
>         return -EINVAL;
>     if (!netif_device_present(dev))
>         return -ENODEV;
>     ...
>         err = ops->ndo_set_mac_address(dev, ss);
> }
>
> Since -EBUSY advertises a transient condition, callers that retry on EBUSY
> would loop on input that can never succeed. Would moving the state gate
> below the is_valid_ether_addr() check work equally well for the stated
> goal?
>
> The ordering is still present at the end of the series, and the commit
> message does not mention the change in returned errno for invalid
> addresses. Could that be noted, or the checks reordered?

The scenario requires passing an invalid MAC address (multicast, all-zero)
while the VF is resetting. -EBUSY is still a correct response, the VF
cannot perform any operation during reset regardless of the address.

If a caller retries on -EBUSY, the reset completes quickly (milliseconds
to seconds) and the next attempt returns -EADDRNOTAVAIL as expected.
This is a transient errno difference, not a functional issue.

