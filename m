Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8BF4229DF
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339214; cv=none; b=ozQ4tp1xuKCPFO/hZvp36uvbthRTXa5hAgd4Tmekrz2ujZzZLATU8qoytN583CK6Cf4mJCdXh4Ruiv34AZzfqjfNjnTP6VJxIiN5izg8/BSFWvJesEa0OSedkl4lG/AZS/iVs7PzA0QJafk8Q2/zYYl5Ey3Pvl0duW+rvLDVeNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339214; c=relaxed/simple;
	bh=dmuDp7Fv2tAk9iFKwhsczkmrqeRavBEb7VkFUV/pxoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aFNmFva55khLFTW06nbpoBrRIzKyBpfEZyJOP1z3WD9kTMMWN3hX4i7UcfK+Pno57yNUrX5+Lwj3ejXROaKO7jv/0KbdbZy+Elt4NUE8FNi9yG44KxuLASeoR8yFzDFK+LHsAWEYqmE5pnXjbJ71U3DtPmlKxqECU6DoAX7Xxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+0XmIjt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+0XmIjt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783339210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmuDp7Fv2tAk9iFKwhsczkmrqeRavBEb7VkFUV/pxoE=;
	b=a+0XmIjtC3f6tOpvV5yFrzJ3pisMRV9g/CNOrwow1t57s6kIHJU8zeK0JxI9UEQNM/h/Lu
	b6OM2UY/q3c3vJFClw8lR2n3QsWh5XOFGYGdIw/WP3/vh5zYWEXpUMdQ7GY7j7zr6miOzq
	m7CNuo9WiChVBHrTxAvhUdarXXXuVn0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-JpE8dzbuOCq9raDZS0k0Lg-1; Mon,
 06 Jul 2026 08:00:07 -0400
X-MC-Unique: JpE8dzbuOCq9raDZS0k0Lg-1
X-Mimecast-MFC-AGG-ID: JpE8dzbuOCq9raDZS0k0Lg_1783339205
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A8D018052DB;
	Mon,  6 Jul 2026 12:00:05 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A11CC1956088;
	Mon,  6 Jul 2026 12:00:03 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Asim Viladi Oglu Manizada <manizada@pm.me>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,  echaudro@redhat.com,
  i.maximets@ovn.org,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  horms@kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH net] net: openvswitch: reject oversized nested action attrs
In-Reply-To: <20260706094336.38639-1-manizada@pm.me> (Asim Viladi Oglu
	Manizada's message of "Mon, 06 Jul 2026 09:44:10 +0000")
References: <20260706094336.38639-1-manizada@pm.me>
Date: Mon, 06 Jul 2026 08:00:02 -0400
Message-ID: <f7ttsqc2urh.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Asim Viladi Oglu Manizada <manizada@pm.me> writes:

> Open vSwitch stores generated flow actions as nlattrs, whose nla_len
> field is u16. Commit a1e64addf3ff ("net: openvswitch: remove
> misbehaving actions length check") allowed the total sw_flow_actions
> stream to grow beyond 64 KiB, which is valid, but also removed the last
> guard preventing a generated nested action attribute from exceeding
> U16_MAX.
>
> An oversized generated container can thus be closed with a truncated
> nla_len. A later dump or teardown then walks a structurally different
> stream than the one that was validated. In particular, an oversized
> nested CLONE/CT action may cause subsequent bytes in the generated
> stream to be interpreted as independent actions.
>
> Keep the larger total-action-stream behavior, but make nested action
> close reject generated containers that do not fit in nla_len, and return
> the error through all callers. For recursive SAMPLE, CLONE, DEC_TTL, and
> CHECK_PKT_LEN builders, trim resource-owning action-list tails in reverse
> construction order before discarding failed wrappers, so resources copied
> into the rejected tails are released before the wrappers are removed.
>
> Most failed outer wrappers are discarded by truncating actions_len after
> child resources have been released. CHECK_PKT_LEN also trims its parent
> after branch resources are gone. SET/TUNNEL close failures unwind their
> known tun_dst ownership directly, and SET_TO_MASKED has no external
> ownership and truncates on close failure.
>
> Fixes: a1e64addf3ff ("net: openvswitch: remove misbehaving actions
> length check")
> Cc: stable@vger.kernel.org
> Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
> Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
> ---

Thanks for the fix!

Reviewed-by: Aaron Conole <aconole@redhat.com>

