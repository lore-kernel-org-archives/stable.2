Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919333A1683
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459958; cv=none; b=fjfe87k+YCPNguTJxBsynP2nVNpaiQqxK+RKpyd5+Z2NGCwI8a+u/KanRNs2H4pTlBXJGm5EEBMe9q5/q8FE5VeTU+p12ixt7mL1erIH38GiHkBJotqGNumAXNqeISLIv29i/5kCxtMSYhuf6gsTYM+ViFiW2XlwDdgw1QO+1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459958; c=relaxed/simple;
	bh=BoO2FTAyTI6F4cYRTOhVtNgV5d2eTPvtAtnPei4RUAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXnlMpDHKymqaFGLwNeKuJeP9+LFfqYhQC2nTEdgnunZn5fpd4ajY+GmCLotNnkpbWdge5YXUh/plBFMfobXRfCcF69eSCoLjsonZYdEONmWvdEpccQTQvN4au8laZd0fRcOGjDtS6+iQiVMXiJUYAEHYfWEfOonwMmu1twQfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPjcVyTF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPjcVyTF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789459955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZrMp1xXvVLE6vjhWMU4i0OTjJAbdj66RfQfoirCJwk=;
	b=MPjcVyTFZifu4W7qu5ezTGUb9YgPCFtAwGe16GOP/7oInNYH9quOz9xzbjSiqx8qGawkBv
	E1+O9rYJHGAVvPCeAztSA9yJbcm0VFwaOS35QTxC9ONNntQcZDJKoEzi6l+oaEtbQ8KYcw
	RrI+aHJPvZHulTUHCV2NaVHHE9ut3G0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-FZ_pyM-EMO6Ap2b5wuM9bw-1; Tue,
 15 Sep 2026 04:12:30 -0400
X-MC-Unique: FZ_pyM-EMO6Ap2b5wuM9bw-1
X-Mimecast-MFC-AGG-ID: FZ_pyM-EMO6Ap2b5wuM9bw_1789459948
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05E2E1802578;
	Tue, 15 Sep 2026 08:12:28 +0000 (UTC)
Received: from fedora.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABBC8756;
	Tue, 15 Sep 2026 08:12:23 +0000 (UTC)
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
Subject: Re: [PATCH net 1/4] iavf: return EBUSY if reset in progress or not ready during MAC change
Date: Tue, 15 Sep 2026 10:12:19 +0200
Message-ID: <20260915081222.13970-1-jtornosm@redhat.com>
In-Reply-To: <20260824190145.2714480-1-kuba@kernel.org>
References: <20260824190145.2714480-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

All the comments below fall into pre-existing issues, concerns already
addressed in previous versions and comments, out-of-scope items, or extreme
edge cases. No code changes are considered necessary for a new version.
Details for each comment:

> [Severity: Low]
> This paragraph describes a user-visible behaviour change caused by
> ad7c7b2172c3, but there is no Fixes: tag on this commit.  Was that
> intentional?
>
> Worth noting that this commit does not actually remove the wait under the
> netdev instance lock: after this patch iavf_set_mac() still calls
>
>     ret = wait_event_interruptible_timeout(adapter->vc_waitqueue,
>                            iavf_is_mac_set_handled(netdev, addr->sa_data),
>                            msecs_to_jiffies(2500));
>
> so a Fixes: ad7c7b2172c3 here would arguably be misleading.  The later
> patch in the same series, "iavf: send MAC change request synchronously",
> does carry Fixes: ad7c7b2172c3 and cc: stable, which looks like the right
> place for the provenance.  Is that the intended split?

Yes, that is the intended split. This patch is a preparatory improvement
that adds a best-effort early bail-out, but it does not remove the wait
under the netdev instance lock. Patch 3/4 ("iavf: send MAC change
request synchronously") is the one that actually eliminates the
problematic wait and carries the Fixes: ad7c7b2172c3 tag and cc: stable.

Adding Fixes: here would be misleading since this patch alone does not
fix the problem — it only reduces the likelihood of hitting it.

> [Severity: Low]
> Is this check-then-act sequence racy against the reset scheduling path?
>
> iavf_is_reset_in_progress() does plain reads of adapter->state and
> adapter->flags:
>
>     static bool iavf_is_reset_in_progress(struct iavf_adapter *adapter)
>     {
>         if (adapter->state == __IAVF_RESETTING ||
>             adapter->flags & (IAVF_FLAG_RESET_PENDING |
>                       IAVF_FLAG_RESET_NEEDED))
>             return true;
>
>         return false;
>     }
>
> IAVF_FLAG_RESET_NEEDED can be set from a context that does not hold the
> netdev instance lock:
>
> dev_watchdog()
>   netif_freeze_queues(dev);
>   dev->netdev_ops->ndo_tx_timeout(dev, i);    /* timer context */
>     iavf_tx_timeout()
>       iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED)
>         adapter->flags |= flags;              /* non-atomic RMW */
>
> net/sched/sch_generic.c only freezes the TX queues around ndo_tx_timeout(),
> so there does not appear to be anything serializing that writer against
> iavf_set_mac().  If the TX timeout fires just after the new test, does
> iavf_set_mac() go on to the 2.5 s wait_event_interruptible_timeout() with
> the netdev instance lock held anyway, i.e. exactly the case the check is
> meant to reject?
>
> The window is small and the fallback is the pre-patch behaviour (blocked
> for up to 2.5 s, then -EAGAIN), so this looks like a best-effort guard
> rather than a new failure mode.  Is that the intent, or should the state
> and flags reads be done under the same serialization as the reset path
> (and with READ_ONCE(), given the concurrent non-atomic |= on
> adapter->flags)?

Yes, this is a best-effort guard to inform the user as soon as possible
instead of blocking with the netdev instance lock held. If a reset starts
immediately after the check, the behavior falls back to the pre-patch
code path: blocked for up to 2.5s, then -EAGAIN. No new failure mode is
introduced.

The flags/state access patterns (plain reads, non-atomic RMW on
adapter->flags) are pre-existing throughout the iavf driver — the
watchdog, tx_timeout, and adminq paths all use the same style.
Introducing READ_ONCE / proper serialization here alone would be
inconsistent and incomplete. That is a broader driver-wide cleanup,
out of scope for this fix.

