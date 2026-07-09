Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D51A31F996
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598418; cv=none; b=PkMRFILpvwcmvtrscVW0044vI0tGcTQtRCd2ObBu4RThX8zQys9yKoMtHMUIjKGQZ0VtsY3Eb6w55/sVCBHmUMdv5xdOGbF+y71KJ9/xl6wTQianufySfxioZ7gZ0MHhu5AmkLTm1hQRE0DtW7h0HwRE6HLJSguqIxP0KJrx7OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598418; c=relaxed/simple;
	bh=cSBdc8BBnyRLpnjMSu1QpbPrJfE3jILuuYEAXMRbwwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ehVytVfLZLDYKgJZhF3bCCtLGLz/xTcLPXjL2j05tZSIrQ1jWzjOgJ9VJf93KGWcw29Ga2OlIyM+DU7Nykh+x4f2Sr7+dXkJQ3CDu82wY+4Trk1VaKqpnytYd79Llk2tQ9nZ4bLB2jiayOuun7HmOcG9IjgbWJy1VZE+hci/z/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhWhagHe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhWhagHe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783598411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cSBdc8BBnyRLpnjMSu1QpbPrJfE3jILuuYEAXMRbwwc=;
	b=OhWhagHeu96z0MJuMdt7agz+bxOh+peN7WNADpIO+v4ATTPY45OarwzrOT0HGZ4xt/JdUv
	YfVrcxmCfZzvI689PEoOasOSXyODpI4itIHnYW8MG2WMO19sJX2yKDyBFIDIWJEZ2pReiv
	43CWiTI57jMqQhrZa8deQ0KKweUO4eg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-HEB2ZsPFO62fGRwxLukiSA-1; Thu,
 09 Jul 2026 08:00:07 -0400
X-MC-Unique: HEB2ZsPFO62fGRwxLukiSA-1
X-Mimecast-MFC-AGG-ID: HEB2ZsPFO62fGRwxLukiSA_1783598406
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDD40195607B;
	Thu,  9 Jul 2026 12:00:06 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC8FF180035F;
	Thu,  9 Jul 2026 12:00:05 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  stable@vger.kernel.org
Subject: Re: [PATCH net] openvswitch: fix GSO userspace truncation underflow
In-Reply-To: <20260707221635.27489-1-kylebot@openai.com> (Kyle Zeng's message
	of "Tue, 7 Jul 2026 15:16:35 -0700")
References: <20260707221635.27489-1-kylebot@openai.com>
Date: Thu, 09 Jul 2026 08:00:04 -0400
Message-ID: <f7t33xstltn.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Kyle Zeng <kylebot@openai.com> writes:

> OVS_ACTION_ATTR_TRUNC currently stores a delta from the original skb
> length in OVS_CB(skb)->cutlen. When a later userspace action segments a
> GSO skb, queue_gso_packets() reuses that delta for each smaller segment.
> A segment can then reach queue_userspace_packet() with cutlen greater
> than skb->len, underflowing the length passed to skb_zerocopy().
>
> Store the maximum preserved length instead and bound each consumer
> against the current skb length. Use U32_MAX as the no-truncation
> sentinel so the value remains valid if skb geometry changes before a
> consumer handles it.
>
> Fixes: f2a4d086ed4c ("openvswitch: Add packet truncation support.")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

