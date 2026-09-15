Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C33B42EF
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460089; cv=none; b=cbT6r1qtMW+jEX3JafCvp7wlomXMeE3aBgXtpoFCc3hGBjBEEm8NqF1HNGYNyKitKFQXPOakVzA94vnBjgJjrwA9zf0ZqybOcC9t0sFtJYUBqMC8D9LBlW1aH4+ppWfA8botLk4V5a8pYI+17H4fYr0jF8HdQ0fjHUfQPwOfhw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460089; c=relaxed/simple;
	bh=IIKTM3ElfQiVAIIjv3mMJgamBgHaEqIIhac2eSMcVq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWqEgMoeBbAdm99JdZzrShTBgpXWpecH7v+5fF/+KguTq5yRZnS5eXdK+ao0E7Kxdeu9NHZL3LWnRm5Dj7LP8bvjsPjspSSXwpdMg2FAC6YNLkBB4+yx8zbHHTSKNXc+YDYqJaA5xJW9hngUhm7nQbUsaJYkzZd7FouvQQJDG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7kQyUxC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7kQyUxC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789460086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIKTM3ElfQiVAIIjv3mMJgamBgHaEqIIhac2eSMcVq8=;
	b=Y7kQyUxCuEEpNYTKTNSgfbQCVJ4eB3aboGbrA+manVK+pD/Lj3oDHgLS2arswGuSuTWlgM
	nhgBL7eAdxUJPEKvbxzZmYD/gNnebfpPiU/L3a40MaDGGKDtuOkjhVKJHKX1eYkZFOANyj
	BwHweZe5Mp+e+roE8EWg9PPHq30WRRk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-VG31SI_GO2C5xixWDH03XQ-1; Tue,
 15 Sep 2026 04:14:44 -0400
X-MC-Unique: VG31SI_GO2C5xixWDH03XQ-1
X-Mimecast-MFC-AGG-ID: VG31SI_GO2C5xixWDH03XQ_1789460082
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5909D1800148;
	Tue, 15 Sep 2026 08:14:42 +0000 (UTC)
Received: from fedora.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2466A3000223;
	Tue, 15 Sep 2026 08:14:37 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kuba@kernel.org
Cc: aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	jtornosm@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	rafal.romanowski@intel.com,
	sdf@fomichev.me,
	stable@vger.kernel.org
Subject: Re: [PATCH net 2/4] i40e: skip unnecessary VF reset when setting trust
Date: Tue, 15 Sep 2026 10:14:36 +0200
Message-ID: <20260915081436.14176-1-jtornosm@redhat.com>
In-Reply-To: <20260824190147.2714513-1-kuba@kernel.org>
References: <20260824190147.2714513-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

All the comments below fall into pre-existing issues, concerns already
addressed in previous versions and comments, out-of-scope items, or extreme
edge cases. No code changes are considered necessary for a new version.
Details for each comment:

> [Severity: Medium]
> This helper writes I40E_VIRTCHNL_VF_CAP_PRIVILEGE from the ndo (rtnl)
> context. i40e_alloc_vf_res() derives the same bit from an unsynchronized
> read of vf->trusted.
>
> If that path reads vf->trusted and is preempted before the
> set_bit()/clear_bit(), can i40e_ndo_set_vf_trust() update vf->trusted and
> call i40e_setup_vf_trust() in between, so the stale write lands last? That
> would leave vf->trusted true with the capability bit clear, or vf->trusted
> false with the bit still set.
>
> Before this patch the ndo always followed the vf->trusted update with
> i40e_vc_reset_vf(), so the bit was recomputed from the final value of
> vf->trusted. With the reset skipped, is anything left that reconciles the
> two?

Pre-existing race. The original code writes vf->trusted before calling
i40e_vc_reset_vf() without synchronization against VFLR-initiated resets
from the service task. This patch does not change the synchronization
model and the race window is the same order of magnitude (a few
instructions). The scenario requires a guest-initiated VFLR at the exact
moment of the trust change, extremely difficult to reproduce in practice.

> [Severity: High]
> Does this condition need to consider the MAC and VLAN filters that the VF
> was only allowed to install because it was trusted?
>
> Trust is checked at add time only. Nothing revalidates filters that are
> already installed when the privilege bit is dropped.
>
> Can the __I40E_MACVLAN_SYNC_PENDING work repair this instead? Looking at
> i40e_correct_vf_mac_vlan_filters() it only recomputes the VLAN id of
> existing entries, so no MAC filter is deleted on trust loss.
>
> There is also a functional side effect: mac_add_max drops back to 18 while
> i40e_count_active_filters(vsi) still reflects the trusted-era filters, so
> every later VIRTCHNL_OP_ADD_ETH_ADDR from that VF fails with -EPERM,
> including a re-add of its primary MAC after a guest link down/up.

Same concern addressed in previous comments. Over-limit filters configured
while trusted remain after trust revocation, but this is acceptable because
untrusted VFs can freely delete their own MAC and VLAN filters, there are
no trust checks in i40e_vc_del_mac_addr_msg() or i40e_vc_remove_vlan_msg().
The VF simply cannot add more over-limit filters.

The permission check uses i40e_count_active_filters(vsi) which counts live
filters, deletions reduce the count immediately. The "primary MAC re-add
after link down/up" scenario does not apply: existing filters remain in
place across link events. A guest-initiated VF reset cleans up everything
via i40e_free_vf_res().

> [Severity: Medium]
> Can this sample of VF-controlled state race with the virtchnl handlers that
> write it? i40e_vc_process_vf_msg() is called from
> i40e_clean_adminq_subtask() in service task context without rtnl_lock() and
> without taking __I40E_VIRTCHNL_OP_PENDING, so it does not exclude this ndo.
>
> Does that leave an untrusted VF promiscuous indefinitely? The same ordering
> appears in i40e_vc_add_cloud_filter() and i40e_vc_add_qch_msg().

Same concern addressed in previous comments. This race condition exists in
the original code as well, vf->trusted is set before i40e_vc_reset_vf(),
creating the same window where the VF can install privileged state while
the capability bit is still set. This patch does not introduce this race,
it inherits the same synchronization model. Extremely difficult to
reproduce in practice.

Fixing this requires changing the broader synchronization between ndo
callbacks and virtchnl processing, which is beyond the scope of this patch.

> [Severity: Medium]
> This is a pre-existing issue and not introduced by this patch, but
> i40e_vc_reset_vf() is void and can return having done nothing.
>
> Would calling i40e_setup_vf_trust(vf, setting) unconditionally, before the
> branch, make both artifacts deterministic?

Pre-existing issue not introduced by this patch, as the reviewer correctly
identifies. The current structure keeps the logic clear: the else branch
handles the no-reset case, the if branch delegates everything to the reset
path.

> [Severity: Medium]
> The reset releases the ADQ channel VSIs and i40e_alloc_vf_res() re-creates
> them with newly assigned seids. i40e_del_all_cloud_filters() then looks
> the VSI up by the recorded seid. If the seid changed, the teardown takes
> the error path and the hlist_del(), kfree(cfilter) and
> vf->num_cloud_filters decrement are all skipped. Does this leak the
> struct i40e_cloud_filter allocations?

Pre-existing issue, the same ordering (reset before cloud filter deletion)
existed in the original code. This patch restructures the control flow
but preserves the same sequence.

