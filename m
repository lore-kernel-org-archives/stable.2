Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F824078F9
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339841; cv=none; b=vCKWQo903kQkbJfabKC/znLl2peSlAjMl59mkyteCSlfZCYEUCR8ZcWVE3OVYve+OdS36jrIhNtmaSWVuBiV8I2nJLTE+1cykfGI4p1RZ+mAcsgI1OWe41zkJ1980wlDGIvpVu7jP18mrknF3R2iwz72ZaPSJR7yWjpliOm8mq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339841; c=relaxed/simple;
	bh=nKIWorpbzaf5SIcpy9hDDeWjpM23McIxp03rHgi94W0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHo3elQoT3dHdf/8ry/ym7jxlaMkyzyQYgkLMoAvJ1m734EGXEAliBhA/61AY+Fryl03XWAk4ZTudIZHKIQ/jKB39LuimJgrkACczqlaBg/fS6829D9g/rvLzFfhjdNmOr2bLqT23689JSOCbkE8wx9AcJI+Rt1642MQI6KbjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLKGri+1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLKGri+1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788339839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0eT/W/+oeHRW7p1OCHLSK34HdANZwDkci4//NsCv6s=;
	b=fLKGri+12is44Ow3DBMoc+scw0005VDpBebWUYiQ8y040tIReRN3LnVUkpLADlKRHQFHOD
	W5ptr+dPlU4QU9ehcutMHtaOJurD5QzLibmsbyvRdMBMyKL8sY2nlAy8RQwM0WnFMtq7qG
	+CQXZ3W7JfJ9J+Xlz03MN/YQCqUIMZI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-8WX91g-7MwCQqqgIQotzJQ-1; Wed,
 02 Sept 2026 05:03:57 -0400
X-MC-Unique: 8WX91g-7MwCQqqgIQotzJQ-1
X-Mimecast-MFC-AGG-ID: 8WX91g-7MwCQqqgIQotzJQ_1788339836
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A659C1830197;
	Wed,  2 Sep 2026 09:03:55 +0000 (UTC)
Received: from griffin (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 883361956044;
	Wed,  2 Sep 2026 09:03:51 +0000 (UTC)
Date: Wed, 2 Sep 2026 11:03:47 +0200
From: Jiri Benc <jbenc@redhat.com>
To: Fourie Zhang <littleddfu@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Aaron Conole <aconole@redhat.com>, Ilya Maximets
 <i.maximets@ovn.org>, dev@openvswitch.org, stable@vger.kernel.org, Fourie
 Zhang <fouriezhang@tencent.com>
Subject: Re: [PATCH net] net: mpls: clear inner_protocol when the last label
 is popped
Message-ID: <20260902110319.279de291@griffin>
In-Reply-To: <20260902082924.2812968-1-fouriezhang@tencent.com>
References: <20260902082924.2812968-1-fouriezhang@tencent.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed,  2 Sep 2026 16:28:08 +0800, Fourie Zhang wrote:
> Fixes: c66549ffd666 ("openvswitch: correctly fragment packet with mpls headers")

The problem was actually introduced by 48d2ab609b6bb ("net: mpls:
Fixups for GSO"), which introduced the skb_set_inner_network_header and
skb_set_inner_protocol in push_mpls but forgot to reset them in
pop_mpls.

Apart of that, the fix looks reasonable to me. This is fortunately a
rather niche bug in practice (and to trigger intentionally, it requires
CAP_NET_ADMIN).

Please resend with the correct Fixes header.

Thanks!

 Jiri

