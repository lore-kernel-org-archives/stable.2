Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FC3383333
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987231; cv=none; b=DpN0lZ9+zo49o4mTrKox+fVAKiCNSberNlNC0pfjEdn1D+zX4foL2JnKSIMsURGNysvwjYyDEoNe3b1+s2hhvC7TE3vtCGenbfrPZBJxJGH1mlqokIpOhqfGGcBZ5b0u4XKQhh4OHadf0NDmP9S0s9a4VHlq5k5kWL2wT+jXHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987231; c=relaxed/simple;
	bh=XBKR43MBL4MY4PqSfuY1MJ8CjvTvAn+/3f1jFPC1VeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dv9JKtC3evAc/BrvXWRh3Q426jFEIX7s/C4fRYuD3WihEDceLZhZzMBYiijKSuexjP71XsmeaNdVoLqPkAs5xjZayaK+O642b7Ci5t9iOPf0T5CmmQL0hoduOeDq3eYQfeRZ5hMstrt4SERzl24QT4qAGrmjtDka77QOS3mzC24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzV2Zj2y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzV2Zj2y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780987228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBKR43MBL4MY4PqSfuY1MJ8CjvTvAn+/3f1jFPC1VeY=;
	b=OzV2Zj2yu7HBxRDSsqB0u7zbClVet12++EUkm0h+vciK9unSIM4gTrP07qmDya0+iMqr72
	JAyt7tbL5r+MbpGpWvRoqikU+IMOZcW0cCGnhj6tTf6x/VlmSfYbT9T6p7ALsiSd03op4T
	9cJapThmlRF8jAu1WtmGh+lH01YTPQ0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-OswMwogQOBSZEAMPF6MvHg-1; Tue,
 09 Jun 2026 02:40:24 -0400
X-MC-Unique: OswMwogQOBSZEAMPF6MvHg-1
X-Mimecast-MFC-AGG-ID: OswMwogQOBSZEAMPF6MvHg_1780987223
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81C7A1800D9C;
	Tue,  9 Jun 2026 06:40:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.77])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20BEA3653A;
	Tue,  9 Jun 2026 06:40:19 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ath12k: fix NULL pointer dereference in rhash table destroy
Date: Tue,  9 Jun 2026 08:40:16 +0200
Message-ID: <20260609064018.28434-1-jtornosm@redhat.com>
In-Reply-To: <973da9e9-3851-4e00-85d4-28140c039127@oss.qualcomm.com>
References: <973da9e9-3851-4e00-85d4-28140c039127@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Hello Jeff,

Thank you for the feedback.

> My preference would be to fix the logic so that the deinit is symmetric with
> init, and if any stage of init fails, it should unwind whatever init occurred
> up to that point. So this patch seems to be a bandage instead of an engineered
> fix.
>
> But I'll let the Qualcomm engineering team give their opinion.
I understand the concern about symmetry.
The NULL check approach is intentional here. The ath12k driver has complex
multi-stage initialization, with many potential failure points.
The init/deinit paths are symmetric - destroy is called from the same
cleanup paths as init.
The issue is that init can fail partway through, leaving some components
uninitialized.
The rhashtable pointer itself serves as the initialization state indicator -
it's NULL before init and non-NULL after. Checking it directly is simpler
than adding separate state flags that must be kept in sync.
That said, I'm open to alternative approaches if you see a cleaner way to
handle partial initialization states across the driver's initialization
sequence. Happy to revise if there's a better solution I'm missing.

> not a fan of this pattern.
> if we go with a bandaid solution then i'd want to use guard(mutex) so that
> there isn't a need for a cleanup goto -- we could just return like the patch below
Agreed, guard(mutex) is cleaner. I'll incorporate this in v2 once we align
on the overall approach.

Thanks

Best regards
José Ignacio

