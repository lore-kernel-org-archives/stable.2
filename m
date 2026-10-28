Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793183335;
	b=loohWh34hez/V8VwzRc1asHc/WD6s3tAfUyeuS/DMvqOid+F9EJSwKUXhhk7nbSABgI1
	 1au7j4HaxnL5HYFuWaNBm9Yb01zTH3NhT8sDPgKfMnzYNJI5nnDix51EXe5hpv3TJxzeE
	 jVElTKhNOQojHgYuJa0swLuqjBB2+QJ4BmZPobf7GqgQapBSQcJYLRn2ppYrz8vMqAoJN
	 Eg+jMWUKS5M9vfDzvqQpLPOEvL/3AIxW+JwiBG7KAMWhl66lEqWPnS1WOF8UICvdOOAR3
	 CmTUOTLduahgRo/aFp8z0kVPgzXlLzrbJqJXYK3t5j8ZTOfUkQ4KI1jtpWi1WBSH6Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793183335;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=t2VG8ghbsZ2ehmH3QK6+4qnOak7PHYZ/7p13exiaPw4=;
	b=BTxXJpVeZ0PgUImpN9YBuhLzvEpBN3GRKsz+qveGYYW6zGTQMHppyuBL8Q3m11/olYpF
	 pxusgijAGlFOBIhRCASVaYZk0TijTkzixSU002FIQSk5DHCBc/j7ML06hUIbK7hKFc3Dy
	 MRaVsnyqsiZ94D1xuFPWQh6RK1Wil0Wyrfsvz8is9LvEkFEFFN+DyW+sOaHJdZaier5fb
	 M6lLdfVS+w7A0pGotpblZtDTmDyRxNKjSitNr+3UIC9mGOGyxVWAt+yBSRIc+uwaWonwB
	 lY3Sc6KToH8omH5FhUUbRl2uTYeN36yOaPH3PHFNuM+UPMUT+D8VW4HeaFnm0b2MFWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FwjAGgEk;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C5B606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46C5B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FwjAGgEk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793183334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2VG8ghbsZ2ehmH3QK6+4qnOak7PHYZ/7p13exiaPw4=;
	b=FwjAGgEkky3QAsStShkKwl6LS5+a3RNga7E4plxH9VVo4mx9LYqPqRCa8ZJNAdcY13psBy
	oVGFwojp6I50PQkZqhEy9S4puFcNRulENyYU2nu+MsYT35+a2Lv7EEE/NiVkGtjm9vPnlI
	5mUtubbv9lwwt93jcimrL1lqpM4RoeE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-0aQtWSHpOb2hD8VZTNTAEA-1; Wed,
 28 Oct 2026 06:28:52 -0400
X-MC-Unique: 0aQtWSHpOb2hD8VZTNTAEA-1
X-Mimecast-MFC-AGG-ID: 0aQtWSHpOb2hD8VZTNTAEA_1793183331
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C7C81955E8F;
	Wed, 28 Oct 2026 10:28:50 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA2BD1800444;
	Wed, 28 Oct 2026 10:28:45 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Seiji Nishikawa <snishika@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Leech <cleech@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix io_work priority inversion when send_mutex is held
Date: Wed, 28 Oct 2026 19:28:42 +0900
Message-ID: <20261028102842.2192925-1-snishika@redhat.com>
In-Reply-To: <20261023122351.977034-1-snishika@redhat.com>
References: <20261014064524.4015025-1-snishika@redhat.com> <526673b4-a090-47a4-9181-e30813a8cbe5@suse.de> <20261023122351.977034-1-snishika@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Keith,

A short follow-up on this patch.

The problem is a regression in v6.16 and later, and this is the minimal
fix for it. It applies cleanly on the current nvme-7.4 branch. On the
customer system, the unpatched kernel hung every time. With this patch,
there has been no hang since October 15. blktests nvme over tcp passes
with it, with the same results as without it.

Hannes suggested removing the direct send path instead. I agree with
that as a follow-up, and I will send it as a separate RFC patch for the
next merge window, as I wrote in my previous mail. I can only test it on
VMs, so the performance side needs testing by someone with a real
nvme-tcp setup. It is a bigger change and not something for stable.

Could this fix go into nvme-7.4, so that it can reach stable and the
distro kernels? Please let me know if anything is missing.

Thanks,
Seiji

