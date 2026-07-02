Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1581374A0B
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972475; cv=none; b=EzTOZJDidyV+uWwgW0bSKjQaCLd+MmX9Cr0t600bVD+XgrYpT1K37eD4ocXE0Nc4c6qGHmywtWq0OQ0ERXfMXCh3CwmvxScvarUVCO9LTEuLFBDS3F9c+L1M8xtyll3i6fl4omMghKADrjvaMwnPJrsXzHaR8TPYj/Tc0UsPQgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972475; c=relaxed/simple;
	bh=fzGMVpwottawy8SBQS2Dx2K5HqtSwxxWch8ZeUwm1xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdV63DD5DEQvArHUENoaktie+me6AKaU+X60KpRFDOFrBc1HQks+Qe6bE44WU0EH+QVNUEwOLpubBrxDQADl1LgfHF8W+boRsSpFPGoV9c+LT0bt/n8DQ53WIyCJGu7MyB6MUcXmCIEt86NE8ugIZUL0M95JKhYdRbBVkQu1Cd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGPGAkrW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGPGAkrW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782972472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4UvuXefX8yd84GaG25xUb95oI2RF2HujmNeaEeoIYs=;
	b=jGPGAkrWmM+ZkiJJUfGPaQk4ghcdxTZKxhOOrP62BaeAngFYJrRjW8rbl4h5lVOUAFyqK0
	FIxSL1uSBW47JzmWDPkE20YRBECAq4htqcdgF4a7gR1EpNIRsDiEFa9UHrC2XKbY0jtONK
	kCnkiQN8RYdcHDpxWJUZyte/AzfDu6M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-M9B-jmFmO5ib1ycgkmwL0w-1; Thu,
 02 Jul 2026 02:07:51 -0400
X-MC-Unique: M9B-jmFmO5ib1ycgkmwL0w-1
X-Mimecast-MFC-AGG-ID: M9B-jmFmO5ib1ycgkmwL0w_1782972470
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9801418C1054;
	Thu,  2 Jul 2026 06:07:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8963E3000C2F;
	Thu,  2 Jul 2026 06:07:46 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jtornosm@redhat.com
Cc: ath12k@lists.infradead.org,
	jjohnson@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ath12k: fix NULL pointer dereference in rhash table destroy
Date: Thu,  2 Jul 2026 08:07:44 +0200
Message-ID: <20260702060744.478850-1-jtornosm@redhat.com>
In-Reply-To: <20260615112103.601982-1-jtornosm@redhat.com>
References: <20260615112103.601982-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Gentle ping on this patch.

This fixes a NULL pointer dereference during driver unbind that
crashes the kernel when initialization failed partially. The crash
is 100% reproducible when unbinding after an initialization failure.

This is particularly critical for VM environments with VFIO passthrough.

Regarding the concern from v1 about preferring symmetric init/deinit:
I understand the preference for unwinding init failures at each stage.
However, implementing full symmetric cleanup would require extensive
refactoring of multiple error paths across ath12k_core_start(),
ath12k_dp_alloc(), and related initialization functions.

The NULL check approach provides a safe, minimal fix that:
1. Prevents the crash without changing complex init logic
2. Follows the same pattern used elsewhere in the kernel for
   conditional cleanup (e.g., other rhashtable users)
3. Has been tested and validated in the failing scenario

I've addressed the guard(mutex) feedback from v1 in this v2.

If Qualcomm engineering prefers a different approach, I'm happy to
revise, but no alternative has been suggested since the v1 discussion.

Please let me know if there are any other concerns.

Thanks

Best regards
Jose Ignacio

