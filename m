Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC24544BC9F;
	Mon, 28 Sep 2026 06:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577976; cv=none; b=QMTyom8kJNLhL5KE0hHwfjEUW4Kqw4I/Z60BeO9MvlnhTCsbszrw0GSpPE+kup58nQBj2A+OAJlSfGGjFcYdz2oG9rDtx8ksQ0tXarquhj0y2/7zVqXUKPsTJZsK6MQ7oy9wiTFoeRffjjiyvtyFLgXQqviH2O3UgvGC2qROzdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577976; c=relaxed/simple;
	bh=iCI3tKlvohA0sE5hr3jkRxNqW5pZE+wcC9cw7dFkBQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKApsTfUOaDHCrC2ILchBqfbqva6MV4ez7ez5N8WBPp9k9iswQw/LNoiMibuziAvwncJsbYVuyRd4lw2Hhzoda6WxxLw1KI02aRriPD+Nu5zXuou7hpZ+ABQA+PL6XtxAn9BPPAML1wVJG2rIYwJdArc/+v3rLR9b34wyRFLUmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=H+Ewn0Ir; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="H+Ewn0Ir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=1TDs8Mk3jZwIwrp8V1WwMu1E9TgjX++C7F24nZ7B+UA=;
	b=H+Ewn0IrYSfQPWSFRfsxTDP2hedp1sE08pM+J/dMGGjz6mDCepEoe4zUJA7CJo
	4kvQ/4RuLsXExQkgXel5DGuuU9/RnWz8byrK7FEbw5B6BQA6d1ZBiXpUJsAh8SP2
	O0RbcPPI+Hlk6jbB3gbet3inDZTWw2epvMvbfszUdGKDc=
Message-ID: <8182d29f-d945-41f6-9c7f-e52eb7699ca6@126.com>
Date: Mon, 28 Sep 2026 14:44:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: detach the VF representor when ice_start_vfs()
 fails
To: netdev-bot+sashiko@kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn,
 stable@vger.kernel.org
References: <20260921031616.3390259-1-xiaolinkui@126.com>
 <179009028142.2160803.9147341738754348504@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <179009028142.2160803.9147341738754348504@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDn91zmDLpq+F1SAQ--.55792S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4rZw45Ar1xCFW5KF43GFg_yoW5tFWfp3
	ykXF1Dtw4kGa40g34I93W0qa18urZ5KryUur1UKr4Skrn8Wr10qFW5A342v34UC397C3Wa
	vr4q9w1rW34DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxDGOUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQiGXWq6DOiJfgAA35

 > [High] The newly added ice_eswitch_detach_vf(pf, vf) in the 
ice_start_vfs()
 > teardown loop -- Should this call be made with vf->cfg_lock held?

Agreed, and thanks for the exact interleaving. Both existing callers,
ice_free_vfs() and ice_reset_all_vfs(), hold vf->cfg_lock across the detach,
and the VFs this loop unwinds are precisely the ones that already reached
set_bit(ICE_VF_STATE_INIT) -- which is what ice_check_vf_ready_for_cfg()
checks -- so nothing keeps a concurrent "ip link set dev <pf> vf N ..." or
a VF mailbox message out of them any more.

v2 holds vf->cfg_lock across the whole teardown of each VF, the way
ice_free_vfs() does, which also covers ice_dis_vf_mappings() and
ice_vf_vsi_release(). Both writers in your interleaving are excluded by
that: ice_reset_vf() (reached from __ice_set_vf_mac(), ice_set_vf_trust(),
ice_set_vf_port_vlan() and the other ndo handlers) and
ice_vc_process_vf_msg() take the same lock. Attach stays lockless on
purpose: on the way up ICE_VF_STATE_INIT is not set yet, so
ice_check_vf_init() keeps the configuration paths out.

 > [High] AB-BA lock ordering inversion between pf->vfs.table_lock and the
 > devlink instance lock.

I do not think this one is added by the patch, and the fix for it is much
larger than this UAF fix.

The pair table_lock -> devl_lock is already taken in this very loop before
the failure: whenever the teardown loop has anything to unwind (it_cnt 
!= 0),
at least one ice_eswitch_attach_vf() has already run in the forward loop
above, under the same table_lock. ice_eswitch_detach_vf() in ice_free_vfs()
and ice_reset_all_vfs() does the same. The call added here goes through the
same helper, inside the region that is already under table_lock, so it does
not establish a new ordering pair.

Converging on one hierarchy, as you suggest, means taking devl_lock outside
table_lock in ice_ena_vfs()/ice_free_vfs()/ice_reset_all_vfs() and adding
devl_lock-held variants of ice_eswitch_attach_vf()/ice_eswitch_detach_vf().
That is a lock-hierarchy change across three callers plus the eswitch API,
and it does not belong in a -net patch that has to be backported to stable.
I would rather propose it as a separate series if you think it is worth
doing.

 > [Medium] ... does this loop also need to return the VF MSI-X window?

Agreed, this one is real. ice_virt_get_irqs() does bitmap_set() on the
PF-wide pf->virt_irq_tracker.bm and nothing on this path calls
ice_virt_free_irqs(): not the release_vsi label of ice_init_vf_vsi_res(),
not the ice_eswitch_attach_vf() failure branch, and not the teardown loop.
The caller does not help either. Since the tracker lives for the lifetime of
the PF and ice_set_per_vf_res() sizes the VFs from
pf->virt_irq_tracker.num_entries rather than from the free area, every
failed "echo N > sriov_numvfs" leaks a little more of the range.

As you say, it is pre-existing, and its root cause is different from the
representor bug, so v2 sends it as patch 2/2 instead of folding it into
patch 1/2, with its own Fixes: tag. It returns the window on every failure
path, in the order ice_free_vfs() uses.

v2 is two patches on the same baseline as v1:

   1/2 ice: detach the VF representor when ice_start_vfs() fails
   2/2 ice: release the VF MSI-X window when ice_start_vfs() fails   (new)

Code of 1/2 changed to add the cfg_lock, so the Reviewed-by from Aleksandr
Loktionov is not carried over.

pw-bot: cr

