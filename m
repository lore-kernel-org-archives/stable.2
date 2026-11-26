Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795687734;
	b=aS6oxX0QVsWMNOdvp9CvJnkPc/1LDHomumv0tD/JpFGweQ3CaTKDPyCk5ZR1UK4hagv6
	 dyZa7SE0lRbzvGiMRFMG1lQLlLkmK8TcBtnh26JTB6Mf22MZOGEqVQagv4X3CgUjgX7vM
	 P33VLwIt6pZTDHGJ/LWdVt5yUmk/+Tabbapp4Rsvql483swL/QRrd0TcN8YwIg/23te6G
	 C/6rFgtUNMnpLsQYe02HmiK2tlw0lPtB9uAQICFfIkkPnnXJcdVQSzsxuLfKRKendidjm
	 BUOMQAmGdFUMuSMS8jskEn2rgh5yeltvXR1U/rQeYUtNitVVyfNWca6j9MnI658M74A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687734;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=kARfGtMOF+Hf5J72M41uplNYkAH3lMeoKErE8vZmf48=;
	b=BCElLe/3EAZX+fG/9SD+/P3hPbEYdqiP8FSE1Nnwz773GUUHVr1pjJ02Q2nVZk/i9ggg
	 P+jCwekOpYFc4W7CueoD3hLEaN4DkE/7e6ju85adQqUYAKTo+J8Ozct5HyJM9yIZNCj5h
	 cMvGWjuXDMMWWRCeRbnH4FKzop9SsRWFhDmIspWc1mNtZbdOMSsFTFLWnw0zUGv3tBZB6
	 l8UIDd29wgIc3J0exSJ6gL8/tKL2uNNtx/t4j7n/CfhfNCBJWUnuTg0SSjlAcfe74rYXh
	 Au1MWV4I3OOLh7lKnILllhZU0r+xcsCkn+hprxbfi3TCicptHvLhfL0ht80Do/D/ryQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N8vhm2gO;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114D606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 10:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2114D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N8vhm2gO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795687733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kARfGtMOF+Hf5J72M41uplNYkAH3lMeoKErE8vZmf48=;
	b=N8vhm2gObj3x0wtgr88soYfSwrU94Rw/8zMbtBT/59fm4c4bKPgu93shh280RqUNIlO2v2
	Qb5zWpaIB1ZAFTRDwVEwyZjQ7IOc/gkfiNWzsyvBAH9ZZ03Jy1mFbez4tOXafqQE5MrL5r
	BaspZPsBwAdTxJgPud5ShGd2lPEObkI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-MWGLfK7uO8Kna3H3a-l0UQ-1; Thu,
 26 Nov 2026 10:08:48 +0000
X-MC-Unique: MWGLfK7uO8Kna3H3a-l0UQ-1
X-Mimecast-MFC-AGG-ID: MWGLfK7uO8Kna3H3a-l0UQ_1795687726
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDEA41955F2E;
	Thu, 26 Nov 2026 10:08:45 +0000 (UTC)
Received: from jbenc-thinkpadp1gen4i.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11C3630001BE;
	Thu, 26 Nov 2026 10:08:41 +0000 (UTC)
Date: Thu, 26 Nov 2026 11:08:39 +0100
From: Jiri Benc <jbenc@redhat.com>
To: Lin Jiapeng <ljp1205831794@gmail.com>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 dev@openvswitch.org, Lin Jiapeng <jiapenglin@tencent.com>,
 stable@vger.kernel.org, TencentOS Corvus AI <corvus@tencent.com>
Subject: Re: [PATCH net] openvswitch: reject negative L2 length in
 ovs_fragment()
Message-ID: <20261126110839.6cd6aa8c@jbenc-thinkpadp1gen4i.rmtcz.csb>
In-Reply-To: <5d1f3ff8-b995-4496-a59f-2a01f38603b1@gmail.com>
References: <20261126083218.55429-1-ljp1205831794@gmail.com>
	<20261126101410.4a310394@jbenc-thinkpadp1gen4i.rmtcz.csb>
	<5d1f3ff8-b995-4496-a59f-2a01f38603b1@gmail.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, 26 Nov 2026 17:34:19 +0800, Lin Jiapeng wrote:
> After PUSH_MPLS followed by the two POP_MPLS actions, skb->data is four
> bytes past the saved inner_network_header. Because both POP actions
> still declare next_proto as MPLS, the clearing condition added by
> 78a86d75 is never satisfied, even though the label stack has already
> been emptied.

In other words, the fix in 78a86d75a70e was incomplete. In addition to
checking whether the caller is claiming to pop the last header, we also
need to check whether the inner_network_header is still inside the
packet and reset the inner_protocol if it's not.

Please adjust, test and send v2.

Note the severity of this bug is close to zero (as also evidenced by
no previous reports of such panic). Your action list is not going to
appear anywhere in practice.

Also, permanently add to your prompt that your AI must check the git
log for similar bugs in the past, analyze the past fixes and verify the
proposed fix is in alignment with them.

 Jiri

