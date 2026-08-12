Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4EF38D6B8
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518018; cv=none; b=I+DKRNJtdyUyuoi9i4re41YXm9k2Rtrxi5VGGx6kAJJ/KqKQJ6IKGVbYBjsxF6TwxislGdrXIrzVkFExZIHXo3ZM4NKH6BpD9j2+oYgYV6NESZcUZpKsd284CK/TSl3jdCdRFQjtuOZ+O8/bvNdAV6UAzrtlOUoaH24NksaN6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518018; c=relaxed/simple;
	bh=NElNBa5WKrfWaZmBKCHWVH1OEEff7lrnwrmcx4OlC2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYpRXt+Igq3OGbb84elMKckrE6aUcaxzWTuQdKWTUMwqJDyrPN5TVBgCuz1DfCTVPmwycffIjTYwE7OvwspmlTPE6sjpQUJnKDF434kgbfsjf8RLSDJxpU5xGYXFWw0aDr2ZIhoxD8tv0RvwndcUDII4iHyU4BP4XPVQ3m15rLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNT9yMSp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNT9yMSp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786518014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoLIyz8B9G3tn5O+/VC/wgwFUaD9C7tG4oPrY1+0bns=;
	b=TNT9yMSpTrXE6yKY08SbF4bArCn+1y6sohQUuxMp3YAp+fbGxLzQCGEQy1DwSjBb2eEazD
	V7NpnGkmixM35qSVdCISud5MYq53DMSKFIvlibjSmOPg0rrj+qF9r/4uRatskVipUqoU9W
	75IXVWNqRKHP8UsgkTWlbj+eeJUQsHI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-RCaoSe5rN1uu07mQzJYM1A-1; Wed,
 12 Aug 2026 03:00:06 -0400
X-MC-Unique: RCaoSe5rN1uu07mQzJYM1A-1
X-Mimecast-MFC-AGG-ID: RCaoSe5rN1uu07mQzJYM1A_1786518004
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 727F61800643;
	Wed, 12 Aug 2026 07:00:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6404F18005BB;
	Wed, 12 Aug 2026 06:59:57 +0000 (UTC)
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
Subject: Re: [PATCH net 02/10] i40e: skip unnecessary VF reset when setting trust
Date: Wed, 12 Aug 2026 08:59:55 +0200
Message-ID: <20260812065955.10460-1-jtornosm@redhat.com>
In-Reply-To: <20260806172034.2935502-1-kuba@kernel.org>
References: <20260806172034.2935502-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

All the comments below fall into pre-existing issues, concerns already
addressed in previous versions, out-of-scope items, or extreme edge
cases. No code changes are considered necessary for a new version.
Details for each comment:

> [Severity: Low]
> This isn't a bug, but is the stated precondition accurate? The only call
> site is the else branch of a condition that begins with !setting, so the
> helper runs for every trust grant no matter what the VF has configured.
>
> An untrusted VF can already have "advanced features" configured:
> i40e_vc_add_qch_msg() sets vf->adq_enabled = true after checking spoofchk,
> negotiated ADQ capability, TC count and queue availability, with no
> trust/privilege test, and i40e_validate_cloud_filter() only requires
> I40E_VIRTCHNL_VF_CAP_PRIVILEGE for advanced-mode filters.
>
> Would it be clearer to document the real contract, i.e. "called whenever
> the reset is skipped: on every grant, and on revokes where no cleanup is
> deemed necessary"?

The kernel-doc describes the primary design intent. The helper is trivial
(set/clear one bit) and safe to call in any context, the comment guides
the reader to understand why it exists, not to enumerate every call site.
Not a functional issue.

> [Severity: Medium]
> Can this write of the privilege bit be clobbered by a concurrent VF reset?
>
> i40e_alloc_vf_res() recomputes the same bit from a plain read of
> vf->trusted, with no lock and no READ_ONCE():
>
>     if (vf->trusted)
>         set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
>     else
>         clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
>
> Its only caller is i40e_cleanup_reset_vf(), reached from i40e_reset_vf()
> in the service task for guest-initiated resets (VIRTCHNL_OP_RESET_VF and
> VFLR). i40e_vc_process_vf_msg() is dispatched from
> i40e_clean_adminq_subtask() without rtnl_lock() and without
> __I40E_VIRTCHNL_OP_PENDING, so it runs in parallel with the ndo handler:
>
> service task                ndo path (rtnl held)
> i40e_alloc_vf_res()
>   reads old vf->trusted
>                     vf->trusted = setting;
>                     i40e_setup_vf_trust(vf, setting);
>   set_bit()/clear_bit() using
>   the stale value
>
> vf->trusted and I40E_VIRTCHNL_VF_CAP_PRIVILEGE then stay inconsistent
> until some later reset. Before this patch i40e_ndo_set_vf_trust() always
> called i40e_vc_reset_vf(), which retries i40e_reset_vf() (serialized by
> test_and_set_bit(I40E_VF_STATE_RESETTING)) until a reset happened in the
> caller's own thread, so the bit was always recomputed last from the
> up-to-date vf->trusted. Does the new path need a barrier or to hold off
> against I40E_VF_STATE_RESETTING?

Pre-existing race. The original code writes vf->trusted before calling
i40e_vc_reset_vf() without synchronization against VFLR-initiated resets
from the service task. This patch does not change the synchronization
model and the race window is the same order of magnitude (a few
instructions). The scenario requires a guest-initiated VFLR at the exact
moment of the trust change, extremely difficult to reproduce in practice.

> [Severity: High]
> Does revoking trust still remove the MAC and VLAN filters that only a
> trusted VF was allowed to install?
>
> The new condition does not consider filter state, so a VF with no ADQ, no
> cloud filters and no promiscuous bits takes the else branch, which only
> clears the privilege bit.
>
> While trusted, i40e_check_vf_permission() lets the VF install MACs that
> override the administratively set vf->pf_set_mac address and raises the
> limit from I40E_VC_MAX_MAC_ADDR_PER_VF to
> I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF():
>
>     if (!vf_trusted && !is_multicast_ether_addr(addr) &&
>         vf->pf_set_mac && !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
>         ... return -EPERM;
>     }
>     ...
>     if (!vf_trusted)
>         mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
>     else
>         mac_add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(...);
>
> i40e_vc_add_vlan_msg() likewise only enforces I40E_VC_MAX_VLAN_PER_VF on
> add when the privilege bit is clear.
>
> Previously the unconditional i40e_vc_reset_vf() reached
> i40e_cleanup_reset_vf() -> i40e_free_vf_res(), which does
> i40e_vsi_release(pf->vsi[vf->lan_vsi_idx]), destroying the VSI and all its
> filters; i40e_alloc_vsi_res() then re-added only vf->default_lan_addr and
> broadcast, and i40e_cleanup_reset_vf() set vf->num_vlan = 0.
>
> Can the __I40E_MACVLAN_SYNC_PENDING work repair this instead? Looking at
> i40e_correct_vf_mac_vlan_filters() it only recomputes the VLAN id of
> existing entries:
>
>     new_vlan = i40e_get_vf_new_vlan(vsi, NULL, f, vlan_filters, trusted);
>     if (new_vlan != f->vlan) { ... }
>
> so no MAC filter is deleted on trust loss.
>
> There is also a functional side effect: mac_add_max drops back to 18 while
> i40e_count_active_filters(vsi) still reflects the trusted-era filters, so
> every later VIRTCHNL_OP_ADD_ETH_ADDR from that VF fails with -EPERM,
> including a re-add of its primary MAC after a guest link down/up.
>
> The commit message says "For VFs in a clean state, we can safely change
> the trust setting without the disruptive reset" and lists only "ADQ/cloud
> filters, promiscuous mode" as state requiring cleanup. Should the MAC and
> VLAN filter state be part of that list, or at least mentioned as a
> behaviour change?

Same concern addressed in previous versions. Over-limit filters configured
while trusted remain after trust revocation, but this is acceptable because
untrusted VFs can freely delete their own MAC and VLAN filters, there are
no trust checks in i40e_vc_del_mac_addr_msg() or i40e_vc_remove_vlan_msg().
The VF simply cannot add more over-limit filters.

The permission check uses i40e_count_active_filters(vsi) which counts live
filters, deletions reduce the count immediately. The "primary MAC re-add
after link down/up" scenario does not apply: existing filters remain in
place across link events. A guest-initiated VF reset cleans up everything
via i40e_free_vf_res().

> [Severity: High]
> Is there a check-then-act window here against the virtchnl handlers?
>
> vf->adq_enabled, vf->num_cloud_filters and the promisc state bits are
> written from the service task via i40e_clean_adminq_subtask() ->
> i40e_vc_process_vf_msg(), which takes neither rtnl_lock() nor
> __I40E_VIRTCHNL_OP_PENDING (all test_and_set_bit() sites for that bit are
> ndo/sriov_configure entry points). The privilege bit is only cleared after
> the sampling:
>
> CPU0 i40e_ndo_set_vf_trust()
>     vf->trusted = false;
>     test_bit(I40E_VF_STATE_UC_PROMISC) == 0
>     test_bit(I40E_VF_STATE_MC_PROMISC) == 0
>
> CPU1 i40e_vc_config_promiscuous_mode_msg()
>     /* privilege bit still set */
>     i40e_config_vf_promiscuous_mode(vf, info->vsi_id, allmulti, alluni);
>     ... i40e_aq_set_vsi_unicast_promiscuous()/multicast in HW
>     test_and_set_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states)
>
> CPU0
>     i40e_setup_vf_trust(vf, false);    /* clears privilege, no reset */
>
> Does anything clear the hardware promiscuous flags afterwards? A later VF
> request to disable promiscuous mode is rejected once the privilege bit is
> clear, and the PF reports success to the VF:
>
>     if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
>         ... aq_ret = 0; goto err_out;
>     }
>
> and i40e_sync_vsi_filters() refuses to touch promiscuous for an untrusted
> SRIOV VSI. The same window applies to the plain writes vf->adq_enabled =
> true in i40e_vc_add_qch_msg() and vf->num_cloud_filters++ in
> i40e_vc_add_cloud_filter(), which are read here without READ_ONCE() or a
> lock. Since the guest chooses when to send those messages, it can toggle
> promisc off and on to make the sampled bits read zero.

Same concern addressed in previous versions. This race condition exists in
the original code as well, vf->trusted is set before i40e_vc_reset_vf(),
creating the same window where the VF can install privileged state while
the capability bit is still set. This patch does not introduce this race,
it inherits the same synchronization model. Extremely difficult to
reproduce in practice.

Fixing this requires changing the broader synchronization between ndo
callbacks and virtchnl processing, which is beyond the scope of this patch.

> [Severity: Medium]
> Can the software promisc bits under-report the hardware state?
>
> In i40e_vc_config_promiscuous_mode_msg() the state bits are only set after
> a fully successful call:
>
>     aq_ret = i40e_config_vf_promiscuous_mode(vf, info->vsi_id, allmulti, alluni);
>     if (aq_ret)
>         goto err_out;
>
> but i40e_set_vsi_promisc() issues several admin queue commands and can
> succeed on some and fail on others:
>
>     aq_ret = i40e_aq_set_vsi_multicast_promiscuous(hw, seid, multi_enable, NULL);
>     if (aq_ret) { ... return aq_ret; }
>     aq_ret = i40e_aq_set_vsi_unicast_promiscuous(hw, seid, unicast_enable, NULL, true);
>     if (aq_ret) { ... }
>     return aq_ret;
>
> If multicast promiscuous is enabled in firmware and the unicast command
> fails (or only some VLANs are programmed in the per-VLAN loop), no state
> bit is recorded while the VSI is promiscuous in hardware. Trust revocation
> then takes the no-reset branch and nothing clears it:
> i40e_sync_vsi_filters() does
>
>     if (vsi->type == I40E_VSI_SRIOV && pf->vf &&
>         !pf->vf[vsi->vf_id].trusted) {
>         clear_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
>         goto out;
>     }
>
> without issuing any promiscuous AQ command. Before this patch
> i40e_cleanup_reset_vf() unconditionally ran
>
>     /* disable promisc modes in case they were enabled */
>     i40e_config_vf_promiscuous_mode(vf, vf->lan_vsi_id, false, false);
>
> regardless of the software bits. Would it be safer to call that
> unconditionally on revoke rather than infer the state from the bits? Note
> this one depends on an admin queue command failing part way through, which
> I could not show a guest or admin can force.

Pre-existing issue. As noted in the review itself, this scenario "depends
on an admin queue command failing part way through, which [could not be
shown] a guest or admin can force." This exists regardless of this patch.

