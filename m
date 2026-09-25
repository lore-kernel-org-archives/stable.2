Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755C201278
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790320745; cv=none; b=SiXFx7h0Ftm4QyJvTvei1LXnr7KvZLLa8zS5MH5yD7K57y6hFahsTvP1ROQ6ROZ1CthF/GzvKorGcmDKHWnW3EBWmBn3uQoHI+XIceOCpLMcFZyKp2o0/YOmD99wUUeGMIaF31gLJjthuFr1xE56aR8yFC8o0fQAeFeqB6YqypM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790320745; c=relaxed/simple;
	bh=wunzVgverBhRiUsz9U+PX33jIBCRD9wkVi1KnyqrITk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVwrMm+d5hxCvz2fsj5m89AKSb4rKvAW1xnmZg38YFF+PLT3pMk9ZPjXL8nZHJoFkLv4DmC/u3443abjepgs7YBsWTT0NfGUTtcnNjkV1Sx8oHowJpuTIZLoY3lDGU38Q1m2/X7d+ikUh3n8DM7PvnXl1iV33KZOzHb4sunPHuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ibf/yjZn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ibf/yjZn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790320743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wunzVgverBhRiUsz9U+PX33jIBCRD9wkVi1KnyqrITk=;
	b=Ibf/yjZnQkqlY+UV5CGqOIPi4ymgraxxYQEKBa4uDvzRRFGkNJrb1lHtamxF+cqpj6Svqw
	6kLnOFPOnl6BPM/E1/vwGtvajpGVI+52QcvdiBg0vuKcWCR99d2VvKMz/SF4nLY3+6NkLe
	lOL3SkoZ0BT4SqsI/lNX7nzAqdJZ8W4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-pHI5C_PAPKa_FE_kBufkgQ-1; Fri,
 25 Sep 2026 03:18:58 -0400
X-MC-Unique: pHI5C_PAPKa_FE_kBufkgQ-1
X-Mimecast-MFC-AGG-ID: pHI5C_PAPKa_FE_kBufkgQ_1790320737
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F17B180B5FA;
	Fri, 25 Sep 2026 07:18:56 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A14D1800351;
	Fri, 25 Sep 2026 07:18:52 +0000 (UTC)
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
Date: Fri, 25 Sep 2026 09:18:43 +0200
Message-ID: <20260925071850.53292-1-jtornosm@redhat.com>
In-Reply-To: <20260915092418.0aafd079@kernel.org>
References: <20260915092418.0aafd079@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Jakub,

Would you be ok with dropping patch 1/4 and resubmitting only
patches 2-4?

Patch 1/4 was originally needed to avoid the 2.5s wait during
reset with netdev_lock held. With patch 3/4 replacing the
wait_event with a synchronous send + poll, the original concern
is already addressed. During reset (if necessary), if it times
out it will return, same behavior as the pre-patch code. Patch
1/4 becomes just an extra precaution, not strictly required, so
it can be removed.

The core fix is in patch 3/4 which carries the Fixes: tag.
Patches 2/4 and 4/4 avoid unnecessary VF resets when changing
trust, reducing disruption and wait times.

Thanks

Best regards
José Ignacio

