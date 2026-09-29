Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A753A887
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694402; cv=none; b=cFC1j8AHGTXPumek1ZMoB4iEJtVO2M3X7E1LUv6AX/dylHUsKMcfMLs+gG5dMhWsrfBIskG3MDNkPDwRfAm6+bbyAgz0awyrDHQcGS6Kqz8PvFeUcKKqyPWMDJnsZCGB79ArGu/xYy8qTRyzaLe6RsOCMXslO+mduo98lTlZHf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694402; c=relaxed/simple;
	bh=jwEA9tszSdXiqK2lVGbK9zWNHlffeaTYOxNnAuJHg0s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qH3OS5uJCm+vypFOixv7ADOkg6nPbkaTx8FLZs+O1Vj83oA1yeW30y+JMO/kznMJY/rXd70RDhds0RsIa2JwTtcdU8qAxk+HVHypu3OW0N5NqyMhpxwKPTutmMBkRDsBnyHXmdPydV02aKFyzGQQrUOrKDRAsY1mKrMooS1LImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6GT5t2o; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6GT5t2o"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab4620ecf9so5573757b3.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790694388; x=1791299188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aBbvMtdtXkPr9NqwMjzBWKgQ9hOQ8+AsNzjKBiR/MZM=;
        b=h6GT5t2oAjpHhnStHfZZs5+v/BGAaWIu/60oc/Jvtrwgq25a5N78TqLWlLY6tAon4h
         CUKwPT4nszAokGPumvJbv0xMvmD3KJbacNAD4CKQSd+3ue/XjXYvXB81nfL2qRoQmA2X
         /K7XkENNeq0m7wX+miFKcfZrwHwZM/Nn7TC4VlpXCjqvSCLzqWslN1U9szSJZx1/W4dz
         KWiToeXr+ZUMsx9/i7ZeQkOGaIm41XisMs6mmxTjZjYrWYqlgmdjdjBVCPeGxBwg9v9q
         q+O3vyHinS+AHmQy8NviMV8vGooteQFhkUTjtTggt8Zcl8rlDz88/WTcnZIg8DXVix3M
         ouzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790694388; x=1791299188;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aBbvMtdtXkPr9NqwMjzBWKgQ9hOQ8+AsNzjKBiR/MZM=;
        b=SceUbULDvj+7FDlwd5iKov1zquP+D7Nyv+u1Y5Qdr+cgfBkV61CsOt/XZ42+l743Tj
         B6VIxVvhEfpWihOdmrglCe+eH+8SCfrSdtvm5XdTxUWL0Ye7HHzLJkDt0vpBkDFO5fcN
         LDXKcJOwB3KWcjaSpz569uP26o4G5BySAYXdMFFlMXYnv9fDTk3OiufmsCFba9I+5xLu
         /Sx5Bdhc5WapqbP76BrYBKmAVNQuZ2+qgFXUvIS7vejF/Jv16lV615mH68ECxLrxVmdl
         fe3lBdpKvGROKsbe5w7CUXlpFHS3+n7S1qlZ7owyj2DY/AY+SUtwshprI3Df1wx72Qzl
         m/lQ==
X-Forwarded-Encrypted: i=1; AKwUvBznpwJudPItcjtC98vdKxFvVErAeP+qy9xCybG8y/hDeNUlK6JvGQuaE70YXsjpVN96fkldqsI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIy+hdIflsF7vQfZo/9LV3nhUMzzFF1KjugwFAbGRwgirPVbeld
	W8rOEgXrk2R3AHcZmJeBfzVTWUr8+mAjhW5BBe4RwQzFcweTXBQdJzMl
X-Gm-Gg: AYBFou3XEuMdbWkKifaUEzh+Nk9OUeVXnYJ78N3+aF6ZAiytBepjE+/QROEboQDoyPf
	xM6QKEAbtAy9tnXq36WkOMw82s5m4zcQWi7rsluQjKZCwBkbb/T0d8m1SaGdgs3Z0u4s9nfmJZ0
	XeCVE1h6XG1NolW/eav2ziM0Jkyxtz2qpJBRSWJZbGWiDvFgcxT9WHLe8wUWoaNUj/HRiqzmisL
	KCFMQg1XOSaIJEKyOIrwn+TSjn3+nlC51qYAVoc/7qhEP+Lljq+8hPwhCr27rAK16kCqUucwiJx
	83g25DXjKMyEySpBo3WPbevRjX8x5BlXUxlL6KUDx7IJ2sLlU4uKAtbt/qXFtmGEdsLJ6MzvlV0
	VY1JTiVXEqAPJ6LQe2lf6fYWCHGA4xIMclnvgor7q25mIIrv35AZjzdvJyI7vS4c0xXr+LvDQf6
	lW3hFxGHSIINQ0Pt2+PM+tx/uMdrvnNzS0lDNpn0UF+AuBpqgcy08ywbp+Xh2ErPRL6WGizZ911
	zT6jDUehqFhEvd4QWN9giO5mpPcTrqKzBbFWpCvJZSSQpJglrrM
X-Received: by 2002:a05:690c:c50f:b0:8a9:a1e9:2659 with SMTP id 00721157ae682-8a9a1e92fcfmr37633367b3.50.1790694387584;
        Tue, 29 Sep 2026 08:06:27 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860f9cdb0sm60566977b3.24.2026.09.29.08.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:06:26 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:06:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: lollipopkit <a@lolli.tech>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 io-uring@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 lollipopkit <a@lolli.tech>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.570e0a646f4@gmail.com>
In-Reply-To: <20260929045433.59435-1-a@lolli.tech>
References: <20260929045433.59435-1-a@lolli.tech>
Subject: Re: [PATCH] io_uring/cmd_net: drop unextractable TX_TIMESTAMP skbs
 instead of requeueing
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

lollipopkit wrote:
> SOCKET_URING_OP_TX_TIMESTAMP selects error-queue skbs with
> skb_has_tx_timestamp() but extracts the timestamp with
> skb_get_tx_timestamp().  The two use different checks and can disagree:
> a skb the walk accepted can be rejected with -ENOENT forever.  When
> that happens the processing loop stops and skb_queue_splice() puts the
> unprocessed skbs back onto the HEAD of sk_error_queue.  The rejected
> skb is selected first on every following run, fails again, and blocks
> every skb behind it: new timestamps keep arriving and keep re-running
> the command, but nothing is ever delivered again.
> 
> The disagreement is reachable without a race.  With
> SOF_TIMESTAMPING_BIND_PHC the walk never looks at sk_bind_phc, but
> skb_get_tx_timestamp() converts the hardware timestamp through
> ptp_convert_timestamp(), which returns 0 when no virtual clock matches
> sk_bind_phc (for example when the vclock was destroyed after the
> socket bound to it).  ktime_to_timespec64_cond() then fails and the
> extractor returns -ENOENT permanently.  Any skb with a non-zero
> hwtstamp is selected while SOF_TIMESTAMPING_RAW_HARDWARE is set, so a
> single such skb blocks even the software timestamps queued behind it.
> 
> Measured on real hardware, an I219-V (e1000e), using
> /sys/class/ptp/ptpN/n_vclocks to create and destroy the vclock the
> socket was bound to: 22 error-queue skbs generated (16 software + 6
> hardware).  Of the 21 extractor calls, 20 failed with -ENOENT and the
> one that succeeded delivered 1 software timestamp; deliveries then
> froze while 8 further sends kept re-running the command, and the
> remaining 21 skbs (15 software + 6 hardware) sat in the error queue.
> Both control arms (vclock kept alive; no BIND_PHC) delivered
> everything.
> 
> With this patch applied on top of the CQ-full fix ("io_uring/cmd_net:
> end TX_TIMESTAMP multishot when the CQ is full"), A/B tested in a KVM
> guest from a single kernel binary, with the new behaviour behind a
> test-only runtime switch (the switch is test scaffolding and is not
> part of this patch).  The guest needs no special hardware: QEMU's igb
> model emulates hardware TX timestamping (TSYNCTXCTL/TXSTMPL/TXSTMPH)
> and the igb driver registers a PTP clock, so the guest reproduces the
> same failure the same way.  The two arms are separate runs with their
> own sockets and sends; the device holds one pending hardware
> timestamp, so how many of the 16 sends get a hardware skb varies per
> run (12 and 8 here).  Switch off: 28 skbs generated (16 software + 12
> hardware), deliveries froze at 1 and the remaining 27 (15 software +
> 12 hardware) sat in the error queue.  Switch on: 24 skbs generated (16
> software + 8 hardware); all 16 software timestamps were delivered, the
> 8 hardware skbs the extractor rejected with -ENOENT were dropped, and
> the error queue drained.
> 
> recvmsg(MSG_ERRQUEUE) already treats such a skb as skippable:
> sock_recv_errqueue() dequeues it, returns the error message without a
> timestamp, and frees it.  Do the same here and keep the deliverable
> timestamps moving: drop the skb the extractor rejected and continue
> with the rest of the list.  The CQE-full case keeps its
> requeue-and-end-multishot behaviour.
> 
> Fixes: 9e4ed359b8ef ("io_uring/netcmd: add tx timestamping cmd support")
> Cc: stable@vger.kernel.org # needs the CQ-full fix above
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: lollipopkit <a@lolli.tech>

Is this a real name?

https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

"a known identity (sorry, no anonymous contributions.)"
