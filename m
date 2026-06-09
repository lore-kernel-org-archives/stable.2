Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA0E2EEE99
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997083; cv=none; b=F7q1Fpg6H4W6U+1w82cSX+iGyxNWlv1U15XVzTcPhoMOA8WicsRNWDCjm7Cta3K5pZmMoEXL9kmszeOsKMUQFbR0rdNouN3sRa9QhDvE5gG7iH/W3TMM7C16Mo6b4QJzY9bQbsbX+cLwUJry4zk3ToBSyvKY5CgdgrbcsWeL+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997083; c=relaxed/simple;
	bh=hK/NM8PZF9R3IBwEAIWhX+J5Ev2FbPBzI086itUNPRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZD8gUW0uHrSHMAdUtEqNW8LNLWO4ePrkcPeWJilYwHPkk72TPz+53qpx4sb2aK1C7PzKP71cdoofedjR7qlTmbR4sl6SHyV/Cn8p4hHmebAZcntiEeID1nknaJY9T19RQ7KQZbNREbY5s2f/1oVk0+OoJ4662qxS94VeM2VEGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUQ9h22h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUQ9h22h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780997080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bn+yJ4BX4ZExpc5KrxMHHLRqVjpa5d+xcR5uDhhXkfQ=;
	b=TUQ9h22hVHvJAFNdB+iJrmZmEfoZIb4VNwXgzD64KwEvFY5MEgHPxy4DAQnMG/T/AxDCHb
	AuF2bvCP08eFteM6iAqEZ5BHDZ5o0y5Qlz99KuIsaBdVYZ0BnLATtgwP/fGZpsM4ysYN3E
	hhYmd273bBwON7Q8lD9W/OyF5C0yq2o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-gqi3h2XpMFC6IB5S6261_g-1; Tue,
 09 Jun 2026 05:24:35 -0400
X-MC-Unique: gqi3h2XpMFC6IB5S6261_g-1
X-Mimecast-MFC-AGG-ID: gqi3h2XpMFC6IB5S6261_g_1780997074
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4089318501C5;
	Tue,  9 Jun 2026 09:24:34 +0000 (UTC)
Received: from thinkpad (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6F9A3653A;
	Tue,  9 Jun 2026 09:24:32 +0000 (UTC)
Date: Tue, 9 Jun 2026 11:24:29 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Steffen Lindner <steffen.lindner@de.abb.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.18.y 1/2] hsr: Implement more robust duplicate discard
 for PRP
Message-ID: <aifbzVmhiThTVLj7@thinkpad>
References: <2026052838-cleat-rewrite-24c4@gregkh>
 <20260529232406.1883397-1-sashal@kernel.org>
 <20260601075222.hFB8WzTJ@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260601075222.hFB8WzTJ@linutronix.de>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Mon, Jun 01, 2026 at 09:52:22AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-05-29 19:24:05 [-0400], Sasha Levin wrote:
> > From: Felix Maurer <fmaurer@redhat.com>
> >
> > [ Upstream commit 415e6367512bf8faca93eaaf46fbe23d841b4509 ]
> >
> …
> > Reported-by: Steffen Lindner <steffen.lindner@de.abb.com>
> > Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Tested-by: Steffen Lindner <steffen.lindner@de.abb.com>
> > Link: https://patch.msgid.link/8ce15a996099df2df5b700969a39e7df400e8dbb.1770299429.git.fmaurer@redhat.com
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Stable-dep-of: aaec7096f996 ("net: hsr: defer node table free until after RCU readers")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> This is sort of big. It should not introduce any regressions and if so
> we need to fix them anyway so early exposer might be good. However
> aaec7096f9961 ("net: hsr: defer node table free until after RCU
> readers") should be backported down to v5.10-stable so I wonder if
> taking this huge patch is economic for this two liner fix going down the
> road.

I agree, taking the big commit above down to v5.10 probably isn't a good
idea, just for this fix. It should be easy to build a small version of
415e6367512b ("hsr: Implement more robust duplicate discard for PRP")
that just has the changes needed to apply (a slightly modified version
of) aaec7096f996 ("net: hsr: defer node table free until after RCU
readers"), i.e., the changes that introduce list_del() and thereby fix
that the nodes were just freed before 415e6367512b and not removed from
the list at all (which would be another UAF). That should apply to 6.18
and probably to most releases below as well.

I don't really know the guidelines around the stable trees. Do we want
such (heavily modfied) patches so that others can be applied?

Thanks,
   Felix

