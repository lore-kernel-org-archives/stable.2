Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794938321;
	b=zdeM9VRrtKymjNBuntCU2ksaAN8ELNHNdLnKvNPB8G06tjVcDZ6fb/t7GXcGg/Dkdri8
	 +qs5Td+bTBIk6yiJFmr3N+Quz/dw9+eK3ywK7ld3YC3SWC6YFATdJ0vDZomFpmYFCfEAu
	 4cV8gyqi3EDawHltRR8cF/pifDmjw4aH0qMI+B+VSrKBMx4sl3B6cMt2CyOO7CQR7s/35
	 nEArQvEI1sgyng/E8SwAB3xg04oQjskNKb4x0oBR0E32+G/xZKhLuPS7jxIfRoZK+/B1L
	 aazfrJzKXePp/mZswWYNmjHZ12i0L55h35LJMWGGDcsMMCwAj0LmZOs6YSWLp4y6+Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938321;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=fDNSNdtJiNjajmSbnTodRJEXL2NvDP17/w+5CLNocfY=;
	b=QoTMcZ06fivfeXhTri4nO7AAWdx/p/xkbJRSEw5fF2hpusGZiQDh5qcMMJCB0WPLBa8A
	 h6NWQUD9GYqbgcwvWDNSMkbrP5yrB29yyR30Sc/64q7vKj1rPUSfura30AAZisH5TIlYr
	 X4ljORuUgcb+Yh9fJ7M27BAm7UaNt/1cluVbwZ/sQ0+R0WaLtFwA2q0vdzKRwaTwqIqz3
	 ETCQUZq8Wn0FumiZx+GY1dacammHLYF2dqMP3NsOMGm+bLRCyugNY1gjlc6lYWNAcLEl2
	 LgPWzV++H6NbC439nzacLcF8Gblurki1qhBGsuycOXyL+c9ei1Tj4wHveHwuXXGlTBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RQUAWyu+;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4C8606A33A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E4C8606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RQUAWyu+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794938320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDNSNdtJiNjajmSbnTodRJEXL2NvDP17/w+5CLNocfY=;
	b=RQUAWyu+mlNTWbq6u08wfFosdmF1UAXwNZ31ZDwaIp78fYyNaAkCIMeX4BAVggCaxtPhuu
	s+dDN/75KhqYeju6jMVys0GnbhuJRffAuTyDHKXpmiNJpyvDy3b0qhP0tusB8vB2CJImYx
	B1I9bLLxaz9nUaguGt9CPGtjaSXb/00=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-NzwzltnfOmmdHu5W3N7H9A-1; Tue,
 17 Nov 2026 12:58:34 -0500
X-MC-Unique: NzwzltnfOmmdHu5W3N7H9A-1
X-Mimecast-MFC-AGG-ID: NzwzltnfOmmdHu5W3N7H9A_1794938312
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAD5E195608F;
	Tue, 17 Nov 2026 17:58:31 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2D765588;
	Tue, 17 Nov 2026 17:58:27 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Tue, 17 Nov 2026 18:58:31 +0100 (CET)
Date: Tue, 17 Nov 2026 18:58:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tz2294@columbia.edu, stable@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
Message-ID: <avyVwg-5ef-pXZkG@redhat.com>
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avxWKI795DthE8Sb@redhat.com>
 <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
 <avyODoFhZ_M7YDU5@redhat.com>
 <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 11/17, Linus Torvalds wrote:
>
> On Tue, 17 Nov 2026 at 09:25, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > So. Do you agree that we can "ignore" this report from Mani for now?
>
> I think we can ignore it, but I also have a cunning plan.

Good. this was my main (the only) question.

> So what we could do is to just make the pipe code open-code its own
> wait event logic, and add its waiters at the head.

perhaps... and we already have WQ_FLAG_PRIORITY, but we can't re-use it
without more changes...

Oleg.

