Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B2A3B059D
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460374; cv=none; b=imekDlclmnRLeNYLwtqVQO2VaeDfCjI3+4MLkLnK0K8u/Pvttci11amHGyqnSPsk37gKjunCaPx8sak8HyzHECVEk4O2tcV9K6y9r7o6qmkRwDRfeapIb75Ex3v6Jxq+n59VAkdvNStHoqENRGK/OAEbaoKuONblqvqt81QYq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460374; c=relaxed/simple;
	bh=/TruTWV3DYPt48o1z88GEWqVQgGaU9IxfJFJc/yPRPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cigp+g9vJpr6kyPEHBZvYDay18bqCNK3QR9hoRCZmq91APlRq9Gbatp31On4aSCyAlvz5l6MxjhMeWEzDWek1Hg40kI5OktD5HnmKGuciWR3Y6MooGmiwxrUkM/88MVC03U17DX6zBNBRl0fUEvzxtjfuqiIN57MPm/Ffk4aaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/f0Rw9t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/f0Rw9t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789460371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ij4ME6Q9FkmtCpj45HdGF/u3p1gNwGldp70kJo3jax4=;
	b=B/f0Rw9tO9Q1ABgcOYtksYN1BEYwcSCxTWUmQppMb7GED1+x7S6mW1RgRDceZwZ3EjVCUK
	ydTmnaNeK0elpr7pyHz8Eb639Cdc6A3UoFjid2o2wh8xNj2hm7gwnU6VAvKkkr0xS2JpgS
	0ERUmPkrgbARc8KPgCFPme4iKRAQyZU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-cqSTrVxuMESq4wGII5S6lQ-1; Tue,
 15 Sep 2026 04:19:28 -0400
X-MC-Unique: cqSTrVxuMESq4wGII5S6lQ-1
X-Mimecast-MFC-AGG-ID: cqSTrVxuMESq4wGII5S6lQ_1789460366
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7CCB1955EAA;
	Tue, 15 Sep 2026 08:19:25 +0000 (UTC)
Received: from fedora.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE5981800579;
	Tue, 15 Sep 2026 08:19:21 +0000 (UTC)
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
Subject: Re: [PATCH net 4/4] ice: skip unnecessary VF reset when setting trust
Date: Tue, 15 Sep 2026 10:19:20 +0200
Message-ID: <20260915081920.14393-1-jtornosm@redhat.com>
In-Reply-To: <20260824190150.2714587-1-kuba@kernel.org>
References: <20260824190150.2714587-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

All the comments below fall into pre-existing issues, concerns already
addressed in previous versions and comments, out-of-scope items, or extreme
edge cases. No code changes are considered necessary for a new version.
Details for each comment:

> [Severity: Low]
> This isn't a bug, but doesn't ice_vf_lib.c already have a helper with
> exactly these semantics?
>
> drivers/net/ethernet/intel/ice/ice_vf_lib.c:
> static void ice_vf_set_host_trust_cfg(struct ice_vf *vf)
>
> Would it be preferable to export that one rather than carry a second copy?

ice_vf_set_host_trust_cfg() derives the capability bit from vf->trusted,
which must already be set before calling it. ice_setup_vf_trust() takes
the setting as an explicit parameter, matching the i40e helper and the
call site where vf->trusted and the capability bit are set together.
Different interfaces for different purposes. Not a functional issue.

> [Severity: High]
> Is this predicate complete with respect to everything trust gates in ice?
> Besides LLDP filters and promiscuous mode, vf->trusted also gates the MAC
> and VLAN filter quotas and the administratively assigned MAC.
>
> Do those hardware filters then stay programmed after the log prints "VF N is
> now untrusted"?
>
> Can vf->num_mac therefore remain above ICE_MAX_MACADDR_PER_VF after trust is
> revoked, so that later legitimate MAC adds from the now-untrusted VF are
> rejected until some unrelated reset happens?

Same concern addressed in previous comments for both i40e and ice.
Over-limit filters configured while trusted remain after trust revocation,
but this is acceptable because untrusted VFs can freely delete their own
MAC and VLAN filters, there are no trust checks in the deletion path
(ice_vc_handle_mac_addr_msg() only checks trust when set == true). The VF
simply cannot add more over-limit filters.

ice_vc_handle_mac_addr_msg() decrements vf->num_mac on delete, so the
counter reflects actual state after deletions. The no-reset path is only
reached for VFs with no LLDP or promiscuous mode, having excess
MAC/VLAN filters in this state is extremely unlikely.

> [Severity: High]
> What happens to the negotiated VLAN V2 capabilities when trust changes
> without a reset?  The advertised limit is derived from vf->trusted once,
> at negotiation time, and then cached on the PF.
>
> If the VF negotiated VIRTCHNL_VF_OFFLOAD_VLAN_V2 while trusted, does the
> else branch leave max_filters at VLAN_N_VID, allowing the now-untrusted VF
> to keep programming VLAN filters well beyond ICE_MAX_VLAN_PER_VF?

The VLAN_V2 caps cache invalidation is part of the reset/rebuild path
by design (ice_vf_set_initialized()). This patch does not change that
architecture, it only adds a conditional to skip the reset when no
advanced features are configured. The cache behavior is inherited from
the existing design and is beyond the scope of this fix.

> [Severity: Medium]
> This isn't a bug introduced by this patch, but while ice_set_vf_trust() is
> being touched: the switchdev check earlier in this same function returns
> without releasing the VF reference taken by ice_get_vf_by_id().
>
> Would it make sense to convert that return into "goto out_put_vf;" here?

Pre-existing reference leak, not introduced by this patch.

