Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662889;
	b=UbP4DwaGRB+1jPQRWPMW7AkGr/vkxFGYZa5XGN1ZxFF6nvqndj0TZntu1PEtoy4AZ1+N
	 Jv9BO5hYXWl0sqvV2TMt7mtvoqe0Z7yINzrjj7lpyOm/ngLWPlN54u8sf8AvuySvaaSau
	 JB14so8ji3qDfPxMQ8Hy2veqvCx4nUW0Jx5cuO2jaAA0WIYyJcIwP7CqtClhoAwL4kvP7
	 wZZNwTekwvgN7SWn4r5gRr25/4MfDLalcfo3bJFK1UXMK7AZbiw1rviNgizBr6y1iDDmy
	 8Mo0H119D4zZft433jlLjjDSd5YdMzIy75G1rkyDwG0fNQOFiGvckZN6FZSzq9E1a3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662889;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=r9kdUhEEdo8G0E6TvnmRFTKj2ShBGFBBRPt8LMZ5cqk=;
	b=fLaysQswhqMO3/6f07i3uULk+dJj07jqADETblFgbFVnaDT8aFjlPoKvu+cqClnwSo+p
	 Y4gRyTcsyZ0xdeXSDzwQJrTUj7RExdYCdCGOqH1RolCb/GN8OYZtba8VYZJFpU+Qiel02
	 ni8LBBbe41ODcy5GLqiatZCbGXxamfzmPWJQ7dQxs3x/9zLB0Bnet7Nar7L6vTBvvER3F
	 4q88jVnS5E07kvNcP5TVvZdlLXOmnWqk5FnTiZvPlVXM3KsoLFuF+CGPb7ovvP7cWJwPE
	 t99TsVsLWFhu6Qc6JCvRiZR0i9IFAvJa4RpN/bPwCXud5N60Aat99YQoY4tKPYgv0Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Qhk3Cp/e";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58795606A325
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58795606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qhk3Cp/e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792662888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9kdUhEEdo8G0E6TvnmRFTKj2ShBGFBBRPt8LMZ5cqk=;
	b=Qhk3Cp/eXdZOHE1K5iZqsWt/FN6cBvV2l+d0fWzCNE1lh6X7IuLlqrabcoT5ScDx0vGKIE
	+Je2/dpfFxHxq9CO6Zesg/wRdVTC2/jn6Y4f2xuv/cGQtsyFBrVk6nrbsO++sNUQpjPC6V
	Xfcri0aFyOsBu0ui09PsySmXik3Jrwg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-u1OIUuDQNcCF9nGh51KurA-1; Thu,
 22 Oct 2026 09:54:44 +0000
X-MC-Unique: u1OIUuDQNcCF9nGh51KurA-1
X-Mimecast-MFC-AGG-ID: u1OIUuDQNcCF9nGh51KurA_1792662882
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4920C1800633;
	Thu, 22 Oct 2026 09:54:42 +0000 (UTC)
Received: from griffin (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ECB8195608C;
	Thu, 22 Oct 2026 09:54:37 +0000 (UTC)
Date: Thu, 22 Oct 2026 11:54:35 +0200
From: Jiri Benc <jbenc@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>, Eelco
 Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Yi Yang <yi.y.yang@intel.com>, Pravin Shelar
 <pshelar@ovn.org>, Jiri Pirko <jiri@resnulli.us>, Victor Nogueira
 <victor@mojatatu.com>, dev@openvswitch.org, stable@vger.kernel.org
Subject: Re: [PATCH net 5/5] net: openvswitch: ensure a linear inner
 Ethernet header on NSH pop
Message-ID: <20261022115128.6eb99768@griffin>
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412-5@mojatatu.com>
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com>
	<ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
	<ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com>
	<ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com>
	<ACT-N6N4.v1.r0.20261022051412-4@mojatatu.com>
	<ACT-N6N4.v1.r0.20261022051412-5@mojatatu.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, 22 Oct 2026 05:22:22 -0400, Jamal Hadi Salim wrote:
> The fix:
> Pull the inner Ethernet header into the linear area before restoring
> MAC_PROTO_ETHERNET.  This is the NSH counterpart of the MPLS/TEB
> producer fix in the previous patch.
> 
> Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
> Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Jiri Benc <jbenc@redhat.com>

